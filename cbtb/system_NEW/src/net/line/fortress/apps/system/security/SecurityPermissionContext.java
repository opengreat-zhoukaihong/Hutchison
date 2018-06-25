package net.line.fortress.apps.system.security;

import java.util.*;

public class SecurityPermissionContext extends PermissionContext {
  public SecurityPermissionContext(String domainID,
                                   String userID,
                                   Vector userGroup,
                                   Hashtable allGroups) {
    super(domainID, userID, userGroup, allGroups, "security");
  }
}