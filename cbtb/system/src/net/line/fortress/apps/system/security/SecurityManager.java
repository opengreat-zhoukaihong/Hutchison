package net.line.fortress.apps.system.security;

public interface SecurityManager {

  public Domain getDomain(String domainID)
    throws SecurityDomainNotFoundException,
           SecurityDBAccessException,
           java.rmi.RemoteException;
  public User findUser(String encryptedDomainID,
                       String encryptedUserID,
                       String encryptedPassword)
    throws SecurityDBAccessException,
           SecurityUserNotFoundException,
           java.rmi.RemoteException;
  public User authenticate(String domainID,
                           String userID,
                           String encryptedPassword,
                           boolean checkPassword,
                           Domain domain)
    throws SecurityUserNotFoundException,
           SecurityUserSuspendedException,
           SecurityInvalidPasswordException,
           SecurityDBAccessException,
           java.rmi.RemoteException;

  public java.util.Vector getQualifiedGroupIDs(String domainID,
                                    String userID)
    throws SecurityDBAccessException,
           java.rmi.RemoteException;

  public java.util.Hashtable getAllGroupsWithMembers(String domainID)
    throws SecurityDBAccessException,
           java.rmi.RemoteException;

  public java.util.Vector getPermissions(String domainID,
                                         String userID)
    throws SecurityDBAccessException,
           java.rmi.RemoteException;

  public java.util.Hashtable getAllUsersWithPermissions(String domainID)
    throws SecurityDBAccessException,
           java.rmi.RemoteException;

  public boolean implies(java.util.Vector permissions,
                         PermissionContext context)
    throws java.rmi.RemoteException;

  public void deleteUser(String domainID,
                         String userID)
    throws SecurityUserNotFoundException,
           SecurityDBAccessException,
           java.rmi.RemoteException;

  public void deleteDomain(String domainID)
    throws SecurityDomainNotFoundException,
           SecurityDBAccessException,
           java.rmi.RemoteException;
/*
  public boolean checkLogon(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response)
    throws java.rmi.RemoteException;
*/
/*
  public java.util.Vector getAuthorizationList(java.util.Hashtable allPermissions,
                                               PermissionContext context)
    throws java.rmi.RemoteException;
*/
  public String getPersonID(String domainID,
                            String userID)
    throws SecurityUserNotFoundException,
           SecurityDBAccessException,
           java.rmi.RemoteException;

  public String getQualifiedUserID(String personID)
    throws SecurityUserNotFoundException,
           SecurityDBAccessException,
           java.rmi.RemoteException;

  public void changePassword(String domainID,
                             String userID,
                             String currentPassword,
                             String newPassword,
                             boolean checkPassword)
    throws SecurityUserNotFoundException,
           SecurityDBAccessException,
           SecurityInvalidPasswordException,
           java.rmi.RemoteException;

  public void createDomain(Domain domain)
    throws SecurityDBAccessException,
           java.rmi.RemoteException;

  public void updateDomain(Domain domain)
    throws SecurityDomainNotFoundException,
           SecurityDBAccessException,
           java.rmi.RemoteException;

  public void createUser(User user, String personID)
    throws SecurityDBAccessException,
           java.rmi.RemoteException;

  public void updateUser(User user)
    throws SecurityUserNotFoundException,
           SecurityDBAccessException,
           java.rmi.RemoteException;

  public void addExternalGroupMembership(User user, String group)
    throws SecurityDBAccessException,
           java.rmi.RemoteException;

  public void removeExternalGroupMembership(User user, String group)
    throws SecurityDBAccessException,
           java.rmi.RemoteException;
  public void addCbtbGroupMembership(User user,String group)
    throws SecurityDBAccessException,
           java.rmi.RemoteException;
  public void removeCbtbGroupMembership(User user,String group)
    throws SecurityDBAccessException,
           java.rmi.RemoteException;
  public void removeCbtbGroupMembership(User user)
  throws SecurityDBAccessException,
           java.rmi.RemoteException;
}