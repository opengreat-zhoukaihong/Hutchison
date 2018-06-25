package net.line.fortress.apps.system.nls;

import java.rmi.*;
import javax.ejb.*;
import javax.naming.*;

public interface LanguageService extends EJBObject {
  public String getEncoding(String language) throws ObjectNotFoundException, FinderException, NamingException, RemoteException;
  public String getDescription(String language) throws ObjectNotFoundException, FinderException, NamingException, RemoteException;
}