package net.line.fortress.apps.system.ejb;

import java.rmi.*;
import javax.ejb.*;
import java.util.*;
import java.sql.*;
import net.line.fortress.apps.system.LogManager;
import net.line.fortress.apps.system.utils.*;
import net.line.fortress.apps.system.dbquery.*;
import net.line.fortress.apps.system.utils.simpleQuery.*;

public class SimpleQueryBean implements SessionBean {
  private SessionContext sessionContext;
  private int size = 10;
  private ArrayList resultList = null;
  private DBQuery dbQuery = null;
//  private javax.transaction.UserTransaction ut = null;
  private int count = 1;

  public void ejbCreate(String sql, int cachesize) throws Exception {
//    ut = sessionContext.getUserTransaction();
//    ut.begin();
    try {
      dbQuery = DBQueryManager.getInstance().execute(sql);
      resultList = this.getList();
      size = cachesize;
    } finally {
    }
  }
  public void ejbRemove() {
    closeList();
  }
  public void ejbActivate() {
  }
  public void ejbPassivate() {
  }
  public void setSessionContext(SessionContext context) {
    sessionContext = context;
  }
  public void afterBegin() {
  }
  public void beforeCompletion() {
  }
  public void afterCompletion(boolean committed) {
  }
  private ArrayList getList() throws SQLException, ResultSetTimeoutException {
    ArrayList temp = null;
    if (dbQuery != null) {
      ResultSet rSet = dbQuery.getResultSet();
      ResultSetMetaData rSetMetaData = rSet.getMetaData();
      temp = new ArrayList(size);
      try {
        for (int i = 0; i < size; i++) {
          if (rSet.next()) {
            SimpleRecord row = new SimpleRecord(rSetMetaData.getColumnCount());
            for (int col = 1; col <= rSetMetaData.getColumnCount(); col++) {
              row.add(rSetMetaData.getColumnName(col), getField(rSet, rSetMetaData, col));
            }
            temp.add(row);
          } else {
            this.closeList();
            if (i == 0) temp = null;
            return temp;
          }
        }
      } catch (SQLException e) {
        this.closeList();
        throw e;
      } catch (ResultSetTimeoutException e) {
        this.closeList();
        throw e;
      }
    }
    return temp;
  }
  public List nextList() throws SQLException, ResultSetTimeoutException {
    if (resultList == null) {
      throw new NoSuchElementException("NoSuchElementException in SimpleQueryBean");
    }
    ArrayList temp = resultList;
    resultList = this.getList();
    return temp;
  }
  public boolean hasNextList() {
    return (resultList != null);
  }
  public void closeList() {
    if (dbQuery != null) {
      dbQuery.close();
    }
    dbQuery = null;
//    try {
//      ut.commit();
//    } catch (Exception ex) {
//    }
  }
  private Object getField(ResultSet rSet, ResultSetMetaData rSetMetaData, int col) throws SQLException {
    switch (rSetMetaData.getColumnType(col)) {
      case  Types.BIGINT : {
//        return rSet.getBigDecimal(col);
        return new Double(rSet.getDouble(col));
      }
      case  Types.CHAR : {
        return rSet.getString(col);
      }
      case  Types.DATE : {
	return rSet.getDate(col);
      }
      case  Types.DECIMAL : {
//        return rSet.getBigDecimal(col);
        return new Double(rSet.getDouble(col));
      }
      case  Types.DOUBLE : {
        return new Double(rSet.getDouble(col));
      }
      case  Types.FLOAT : {
        return new Float(rSet.getFloat(col));
      }
      case  Types.INTEGER : {
	return new Integer(rSet.getInt(col));
      }
      case  Types.NUMERIC : {
//        return rSet.getBigDecimal(col);
        return new Double(rSet.getDouble(col));
      }
      case  Types.REAL : {
//        return rSet.getBigDecimal(col);
        return new Double(rSet.getDouble(col));
      }
      case  Types.SMALLINT : {
	return new Integer(rSet.getInt(col));
      }
      case  Types.TIME : {
	return rSet.getTime(col);
      }
      case  Types.TIMESTAMP : {
	return rSet.getTimestamp(col);
      }
      case  Types.TINYINT : {
	return new Integer(rSet.getInt(col));
      }
      case  Types.VARCHAR : {
        return rSet.getString(col);
      }
      case  Types.NULL : {
        return null;
      }
      default : {
        return null;
      }
    }
  }
  protected void finalize() {
    this.closeList();
  }
}
