package net.line.fortress.apps.system.web;

/**
 * Title:
 * Description:
 * Copyright:    Copyright (c) 2001
 * Company:
 * @author
 * @version 1.0
 */

public class LogonAction {

  public LogonAction() {
  }
  private String userId;
  private String password;
  private String domainId;
  public String getUserId() {
    return userId;
  }
  public void setUserId(String newUserId) {
    userId = newUserId;
  }
  public void setPassword(String newPassword) {
    password = newPassword;
  }
  public String getPassword() {
    return password;
  }
  public void setDomainId(String newDomainId) {
    domainId = newDomainId;
  }
  public String getDomainId() {
    return domainId;
  }
}