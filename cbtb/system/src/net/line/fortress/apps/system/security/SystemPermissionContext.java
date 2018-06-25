package net.line.fortress.apps.system.security;

import java.util.*;

public class SystemPermissionContext extends PermissionContext {
  public SystemPermissionContext(String domainID,
                                 String userID,
                                 Vector userGroup,
                                 Hashtable allGroups) {
    super(domainID, userID, userGroup, allGroups, "system");
  }
}