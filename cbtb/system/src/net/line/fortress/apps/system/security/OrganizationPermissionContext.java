package net.line.fortress.apps.system.security;

import java.util.*;

public class OrganizationPermissionContext extends PermissionContext {
  public OrganizationPermissionContext(String domainID,
                                       String userID,
                                       Vector userGroup,
                                       Hashtable allGroups) {
    super(domainID, userID, userGroup, allGroups, "organization");
  }
}