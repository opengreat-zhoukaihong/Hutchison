package net.line.fortress.apps.system.utils.simpleQuery;

import java.util.*;
import java.io.*;
import java.math.*;
import java.sql.*;
import java.sql.Date;

public class SimpleRecordComparator implements Comparator, Serializable {

  public static final int ASC = 1;
  public static final int DESC = -1;
  private int columnNum = 1;
  private String columnName = null;
  private int order = SimpleRecordComparator.ASC;

  public SimpleRecordComparator() {
  }
  public SimpleRecordComparator(int col) {
    this.columnNum = col;
  }
  public SimpleRecordComparator(String col) {
    this.columnName = col;
  }
  public SimpleRecordComparator(int col, int order) {
    this.columnNum = col;
    this.order = order;
  }
  public SimpleRecordComparator(String col, int order) {
    this.columnName = col;
    this.order = order;
  }
  public int compare(Object o1, Object o2) {
    if (o1 instanceof SimpleRecord && o2 instanceof SimpleRecord) {
      Object obj1 = null;
      Object obj2 = null;
      if (columnName != null) {
        obj1 = ((SimpleRecord)o1).get(columnName);
        obj2 = ((SimpleRecord)o2).get(columnName);
      } else {
        obj1 = ((SimpleRecord)o1).get(columnNum);
        obj2 = ((SimpleRecord)o2).get(columnNum);
      }
      if (obj1 instanceof BigDecimal && obj2 instanceof BigDecimal) {
        return this.order * ((BigDecimal)obj1).compareTo((BigDecimal)obj2);
      } else if (obj1 instanceof String && obj2 instanceof String) {
        return this.order * ((String)obj1).compareTo((String)obj2);
      } else if (obj1 instanceof Double && obj2 instanceof Double) {
        return this.order * ((Double)obj1).compareTo((Double)obj2);
      } else if (obj1 instanceof Float && obj2 instanceof Float) {
        return this.order * ((Float)obj1).compareTo((Float)obj2);
      } else if (obj1 instanceof Integer && obj2 instanceof Integer) {
        return this.order * ((Integer)obj1).compareTo((Integer)obj2);
      } else if (obj1 instanceof Date && obj2 instanceof Date) {
        return this.order * ((Date)obj1).compareTo((Date)obj2);
      } else if (obj1 instanceof Time && obj2 instanceof Time) {
        return this.order * ((Time)obj1).compareTo((Time)obj2);
      } else if (obj1 instanceof Timestamp && obj2 instanceof Timestamp) {
        return this.order * ((Timestamp)obj1).compareTo((Timestamp)obj2);
      }
      throw new ClassCastException("ClassCastException in SimpleRecordComparator. "
        + obj1.getClass().getName() + " cannot compare to " + obj2.getClass().getName());
    }
    throw new ClassCastException("ClassCastException in SimpleRecordComparator. "
      + o1.getClass().getName() + " cannot compare to " + o2.getClass().getName());
  }
}
