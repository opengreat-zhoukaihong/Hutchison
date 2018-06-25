package net.line.fortress.apps.system.ejb;

import java.rmi.*;
import javax.ejb.*;


public interface SimpleQueryHome extends EJBHome {
  public SimpleQuery create(String sql, int cachesize) throws RemoteException, CreateException, Exception;
}
