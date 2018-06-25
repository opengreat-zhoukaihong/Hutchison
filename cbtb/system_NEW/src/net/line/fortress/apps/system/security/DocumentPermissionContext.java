package net.line.fortress.apps.system.security;

import java.util.*;

public class DocumentPermissionContext extends PermissionContext implements java.io.Serializable{
  public DocumentPermissionContext(String domainID,
                                   String userID,
                                   Vector userGroup,
                                   Hashtable allGroups) {
    super(domainID, userID, userGroup, allGroups, "document");
  }
}