package net.line.fortress.apps.system.utils;

import java.io.*;
import java.sql.*;
import java.util.*;
import net.line.fortress.apps.system.utils.simpleQuery.*;
import net.line.fortress.apps.system.*;

public class SequenceManager {

  public static SequenceManager instance = new SequenceManager();

  public long nextValue(String sequenceName) throws GetSequenceFailedException {
    Object o = null;
    try {
      SimpleQuery query = new SimpleQuery("select " + sequenceName + "_seq.nextval from dual");
      if (query.hasNext()) {
        o = ((SimpleRecord)query.next()).get(1);
      }
      query.close();
    } catch (Exception e) {
      throw new GetSequenceFailedException("Cannot get sequence " + sequenceName, e);
    }
    if (o != null) {
      return ((Number)o).longValue();
    }
    throw new GetSequenceFailedException("Cannot get sequence " + sequenceName);
  }

}
