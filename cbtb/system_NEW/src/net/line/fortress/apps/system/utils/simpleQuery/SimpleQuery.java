package net.line.fortress.apps.system.utils.simpleQuery;

import java.rmi.*;
import java.sql.*;
import java.util.*;
import javax.ejb.*;
import javax.naming.*;
import net.line.fortress.apps.system.ejb.*;
import net.line.fortress.apps.system.dbquery.*;
import net.line.fortress.apps.system.*;

public class SimpleQuery implements Iterator {
  private List bufferList = null;
  private int index = 0;
  private net.line.fortress.apps.system.ejb.SimpleQuery query = null;

  public SimpleQuery(String sql) throws RemoteException, NamingException, CreateException, Exception {
    this(sql, 10);
  }
  public SimpleQuery(String sql, int cachesize) throws RemoteException, NamingException, CreateException, Exception {
    InitialContext ctx = null;
    try {
      ctx = new InitialContext();
//      Hashtable ht = new Hashtable();
//      ht.put(Context.INITIAL_CONTEXT_FACTORY, "weblogic.jndi.WLInitialContextFactory");
//      ht.put(Context.PROVIDER_URL, "t3://localhost:7001");
//      ctx = new InitialContext(ht);
      SimpleQueryHome beanHome = (SimpleQueryHome)javax.rmi.PortableRemoteObject.narrow(
        ctx.lookup("ejb.SimpleQuery"), SimpleQueryHome.class);
      query = beanHome.create(sql, cachesize);
      if (query.hasNextList()) {
        bufferList = query.nextList();
      }
    } finally {
      try {
        ctx.close();
      } catch (Exception e) {}
    }
  }
  public boolean hasNext() {
    if (bufferList != null && index < bufferList.size()) {
      return true;
    } else if (query != null) {
      try {
        boolean ret = query.hasNextList();
        if (!ret) {
          this.close();
        }
        return ret;
      } catch (Exception e) {
        LogManager.instance.logError("Unable to get next object.", e);
        this.close();
      }
    }
    return false;
  }
  public Object next() {
    if (bufferList != null && index < bufferList.size()) {
      return bufferList.get(index++);
    } else if (query != null) {
      try {
        bufferList = query.nextList();
        index = 0;
      } catch (NoSuchElementException e) {
        this.close();
        throw e;
      } catch (ResultSetTimeoutException e) {
        throw e;
      } catch (Exception e) {
        LogManager.instance.logError("Unable to get next object.", e);
        this.close();
        throw new NoSuchElementException("NoSuchElementException in SimpleQuery");
      }
      return bufferList.get(index++);
    }
    throw new NoSuchElementException("NoSuchElementException in SimpleQuery");
  }
  public void remove() {
    throw new UnsupportedOperationException("remove not implemented in SimpleQuery.");
  }
  public void close() {
    if (query != null) {
      try {
        query.remove();
      } catch (Exception e) {}
    }
    query = null;
  }
  protected void finalize() {
    this.close();
  }

}
