package net.line.fortress.apps.system.ejb;

import java.rmi.*;
import javax.ejb.*;


public interface SimpleQuery extends EJBObject {
  public java.util.List nextList() throws RemoteException, java.sql.SQLException, net.line.fortress.apps.system.dbquery.ResultSetTimeoutException;
  public boolean hasNextList() throws RemoteException;
  public void closeList() throws RemoteException;
}
