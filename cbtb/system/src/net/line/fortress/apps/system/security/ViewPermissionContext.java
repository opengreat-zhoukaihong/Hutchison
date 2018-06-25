package net.line.fortress.apps.system.security;

import java.util.*;

public class ViewPermissionContext extends PermissionContext {
  public ViewPermissionContext(String domainID,
                               String userID,
                               Vector userGroup,
                               Hashtable allGroups) {
    super(domainID, userID, userGroup, allGroups, "view");
  }
}