package net.line.fortress.apps.system.ejb;

import java.rmi.*;
import javax.ejb.*;

public interface BasicSecurityManagerImplHome extends EJBHome {
  public BasicSecurityManagerImpl create() throws RemoteException, CreateException;
}