package net.line.fortress.apps.system.nls;

import java.rmi.*;
import javax.ejb.*;

public interface LanguageServiceHome extends EJBHome {
  public LanguageService create() throws RemoteException, CreateException;
}