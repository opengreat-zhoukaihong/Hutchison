package net.line.fortress.apps.system.utils;

import java.sql.*;

public class SQLUtil {
  public static String getNullString(ResultSet rSet, String columnName, String nullString)
    throws SQLException {
    String temp = rSet.getString(columnName);
    if (rSet.wasNull()) {
      return nullString;
    } else {
      return temp;
    }
  }

  public static String getNullString(ResultSet rSet, int columnIndex, String nullString)
    throws SQLException {
    String temp = rSet.getString(columnIndex);
    if (rSet.wasNull()) {
      return nullString;
    } else {
      return temp;
    }
  }

  public static void setNullString(PreparedStatement pStmt, int parameterIndex, String value)
    throws SQLException {
    if (value == null) {
      pStmt.setNull(parameterIndex, Types.VARCHAR);
    } else {
      pStmt.setString(parameterIndex, value);
    }
  }

  public static String padding(String value) {
    StringBuffer resultStr = new StringBuffer();
    String delimiter = "''";
    for (int i = 0; i < value.length(); i++) {
      if (value.charAt(i) == '\'') {
        resultStr.append(delimiter);
      } else {
        resultStr.append(value.charAt(i));
      }
    }
    return resultStr.toString();
  }

}