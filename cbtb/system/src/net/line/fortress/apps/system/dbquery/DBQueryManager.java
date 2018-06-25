package net.line.fortress.apps.system.dbquery;

import java.util.*;
import java.sql.*;
import net.line.fortress.apps.system.*;
import net.line.fortress.apps.system.utils.*;

public class DBQueryManager implements Runnable {
  private static DBQueryManager instance = null;

  private Thread thread = null;
  private Hashtable connections = null;
  private long interval = 60000;
  private int maxConnections = 1;
  private int maxCursors = 50;
  private long lastClear = 0;

  public static DBQueryManager getInstance() {
    if (instance == null) {
      instance = initInstance();
    }
    return instance;
  }
  private static synchronized DBQueryManager initInstance() {
    if (instance != null) {
      return instance;
    }
    return new DBQueryManager();
  }
  private DBQueryManager() {
    ConfigManager configMgr = ConfigManager.getInstance();
    this.maxConnections = Integer.parseInt(configMgr.getProperty("net.line.system.dbQueryManager.maxConnections", "1"));
    this.maxCursors = Integer.parseInt(configMgr.getProperty("net.line.system.dbQueryManager.maxCursors", "50"));
    this.interval = Integer.parseInt(configMgr.getProperty("net.line.system.dbQueryManager.interval", "60")) * 1000;
    this.connections = new Hashtable(maxConnections);
    try {
      this.createConnection();
    } catch (SQLException e) {
      LogManager.instance.logError("DBQueryManager cannot add connection", e);
    }
    this.start();
  }
  private synchronized Connection createConnection() throws SQLException {
    Connection conn = DefaultConnectionPool.getInstance().getConnection();
    this.connections.put(conn, new ArrayList());
    LogManager.instance.logDebug("DBQueryManager connection created, " + this.connections.size() + " available.");
    return conn;
  }
  private synchronized void closeConnection(Connection connection) {
    ArrayList list = (ArrayList)this.connections.get(connection);
    if (list != null) {
      for (int i = 0; i < list.size(); i++) {
        DBQuery query = (DBQuery)list.get(i);
        query.close();
      }
      list.clear();
      this.connections.remove(connection);
    }
    try {
      connection.close();
    } catch (SQLException e) {
      LogManager.instance.logError("DBQueryManager unable to close the connection.", e);
    }
    LogManager.instance.logDebug("DBQueryManager connection removed, " + this.connections.size() + " available.");
  }
  private synchronized Connection getNextConnection() throws SQLException {
    int min = this.maxCursors;
    Connection ret = null;
    for (Iterator itr = this.connections.keySet().iterator(); itr.hasNext();) {
      Connection conn = (Connection)itr.next();
      int size = ((ArrayList)this.connections.get(conn)).size();
      if (size < min) {
        min = size;
        ret = conn;
      }
    }
    if (ret != null) {
      return ret;
    } else if (this.maxConnections > this.connections.size()) {
      return this.createConnection();
    }
    throw new SQLException("DBQueryManager no connection available");
  }
  public synchronized DBQuery execute(String sql) throws SQLException {
    Connection connection = null;
    try {
      connection = this.getNextConnection();
    } catch (SQLException e) {
      this.clearup();
      connection = this.getNextConnection();
    }
    PreparedStatement pStmt = null;
    try {
      pStmt = connection.prepareStatement(sql);
    } catch (SQLException e) {
      LogManager.instance.logError("DBQueryManager connection problem", e);
      this.closeConnection(connection);
      connection = this.createConnection();
      pStmt = connection.prepareStatement(sql);
    }
    ResultSet rSet = pStmt.executeQuery();
    DBQuery query = new DBQuery(pStmt, rSet);
    ((ArrayList)this.connections.get(connection)).add(query);
    return query;
  }
  private synchronized void clearup() {
    this.lastClear = System.currentTimeMillis();
    int DBQueryCount = 0;
    Connection idleConnection = null;
    for (Iterator itr = this.connections.keySet().iterator(); itr.hasNext();) {
      Connection conn = (Connection)itr.next();
      ArrayList list = (ArrayList)this.connections.get(conn);
      for (int i = 0; i < list.size(); i++) {
        DBQuery query = (DBQuery)list.get(i);
        if (query.isFinished()) {
          list.remove(i);
          DBQueryCount++;
        }
      }
      if (list.size() == 0) {
        idleConnection = conn;
      }
    }
    if (idleConnection != null && this.connections.size() > 1) {
      this.closeConnection(idleConnection);
    }
    if (DBQueryCount > 0) {
      LogManager.instance.logDebug("DBQueryManager " + DBQueryCount + " DBQuery removed.");
    }
  }
  public void start() {
    if (this.thread == null) {
      this.thread = new Thread(this);
    }
    this.thread.start();
    LogManager.instance.logDebug("DBQueryManager started");
  }
  public void stop() {
    this.thread = null;
    LogManager.instance.logDebug("DBQueryManager stopped");
  }
  public void run() {
    while (this.thread == Thread.currentThread()) {
      if (this.lastClear + this.interval <= System.currentTimeMillis()) {
        this.clearup();
      }
      try {
        this.thread.sleep(this.interval);
      } catch (InterruptedException e) {}
    }
  }
  protected void finalize() {
    for (Iterator itr = this.connections.keySet().iterator(); itr.hasNext();) {
      Connection conn = (Connection)itr.next();
      ArrayList list = (ArrayList)this.connections.get(conn);
      for (int i = 0; i < list.size(); i++) {
        DBQuery query = (DBQuery)list.get(i);
        query.close();
      }
      list.clear();
      try {
        conn.close();
      } catch (SQLException e) {}
    }
    this.connections.clear();
  }
}