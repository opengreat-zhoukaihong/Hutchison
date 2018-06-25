package net.line.fortress.apps.system.security;

import java.util.*;

public class PermissionContext implements java.io.Serializable{
  private String domainID;
  private String userID;
  private Vector userGroup;
  private Hashtable allGroups;
  private String permissionType;
  private Hashtable context;

  public PermissionContext(String domainID,
                           String userID,
                           Vector userGroup,
                           Hashtable allGroups,
                           String permissionType) {
    this.domainID = domainID;
    this.userID = userID;
    this.userGroup = userGroup;
    this.allGroups = allGroups;
    this.permissionType = permissionType;
    this.context = new Hashtable(10);
  }

  public String getDomainID() {
    return this.domainID;
  }

  public String getUserID() {
    return this.userID;
  }

  public Vector getUserGroup() {
    return this.userGroup;
  }

  public Hashtable getAllGroups() {
    return this.allGroups;
  }

  public String getPermissionType() {
    return this.permissionType;
  }

  public Object get(String key) {
    return this.context.get(key);
  }

  public Object put(String key, Object value) {
    return this.context.put(key, value);
  }

  public void clear() {
    this.context.clear();
  }

  public void cleanup() {
    this.domainID = null;
    this.userID = null;
    this.userGroup = null;
    this.allGroups = null;
    this.permissionType = null;
    this.context.clear();
    this.context = null;
  }
}