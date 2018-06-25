package net.line.fortress.apps.system.dbquery;

import java.sql.*;
import net.line.fortress.apps.system.*;

public class DBQuery {
  private boolean isTimeout = false;
  private long lastAccess = 0;
  private long timeout = 300000;
  private PreparedStatement pStmt = null;
  private ResultSet rSet = null;
  protected DBQuery(PreparedStatement pStmt, ResultSet rSet) {
    this.pStmt = pStmt;
    this.rSet = rSet;
    this.lastAccess = System.currentTimeMillis();
    ConfigManager configMgr = ConfigManager.getInstance();
    this.timeout = Integer.parseInt(configMgr.getProperty("net.line.system.dbQueryManager.timeout", "300")) * 1000;
  }
  public ResultSet getResultSet() throws SQLException {
    if (isTimeout) {
      throw new ResultSetTimeoutException("DBQuery: timeout");
    }
    if (rSet != null) {
      this.lastAccess = System.currentTimeMillis();
      return rSet;
    }
    throw new SQLException("Result set closed.");
  }
  public void close() {
    if (this.rSet != null) {
      try {
        this.rSet.close();
      } catch (SQLException e) {
        LogManager.instance.logError("Unable to close the rSet.", e);
      }
      rSet = null;
    }
    if (this.pStmt != null) {
      try {
        this.pStmt.close();
      } catch (SQLException e) {
        LogManager.instance.logError("Unable to close the pStmt.", e);
      }
      pStmt = null;
    }
  }
  protected boolean isFinished() {
    if (this.rSet == null) {
      //  closed
      return true;
    } else if (this.timeout > 0 && this.lastAccess + this.timeout < System.currentTimeMillis()) {
      //  timeout
      this.isTimeout = true;
      this.close();
      return true;
    } else {
      //  active
      return false;
    }
  }
  protected void finalize() {
    this.close();
  }
}