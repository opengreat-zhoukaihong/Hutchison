package net.line.fortress.apps.system.security;

import java.sql.Timestamp;

public class User implements java.io.Serializable {
  private final static long noOfMillisInADay = 24 * 60 * 60 * 1000;
  private String domainID;
  private String userID;
  private String password;
  private String userName;
  private String description;
  private boolean suspended;
  private boolean everExpired;
  private boolean changePwdNextLogon;
  private int noOfFailedAttempt;
  private int noOfGraceLogon;
  private Timestamp lastAttemptTimestamp;
  private Timestamp lastAccessTimestamp;
  private Timestamp lastModifyTimestamp;
  private String createdBy;
  private Timestamp creationTimestamp;

  public User(String domainID,
              String userID,
              String password,
  	      String userName,
	      String description,
  	      boolean suspended,
	      boolean everExpired,
	      boolean changePwdNextLogon,
	      int noOfFailedAttempt,
	      int noOfGraceLogon,
	      Timestamp lastAttemptTimestamp,
	      Timestamp lastAccessTimestamp,
	      Timestamp lastModifyTimestamp,
	      String createdBy,
	      Timestamp creationTimestamp) {
    this.domainID = domainID;
    this.userID = userID;
    this.password = password;
    this.userName = userName;
    this.description = description;
    this.suspended = suspended;
    this.everExpired = everExpired;
    this.changePwdNextLogon = changePwdNextLogon;
    this.noOfFailedAttempt = noOfFailedAttempt;
    this.noOfGraceLogon = noOfGraceLogon;
    this.lastAttemptTimestamp = lastAttemptTimestamp;
    this.lastAccessTimestamp = lastAccessTimestamp;
    this.lastModifyTimestamp = lastModifyTimestamp;
    this.createdBy = createdBy;
    this.creationTimestamp = creationTimestamp;
  }

  public String getDomainID() {
    return this.domainID;
  }

  public void setDomainID(String domainID) {
    this.domainID = domainID;
  }

  public String getUserID() {
    return this.userID;
  }

  public void setUserID(String userID) {
    this.userID = userID;
  }

  public String getPassword() {
    return this.password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public String getUserName() {
    return this.userName;
  }

  public void setUserName(String userName) {
    this.userName = userName;
  }

  public String getDescription() {
    return this.description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public boolean isSuspended() {
    return this.suspended;
  }

  public void setSuspended(boolean suspended) {
    this.suspended = suspended;
  }

  public boolean isEverExpired() {
    return this.everExpired;
  }

  public void setEverExpired(boolean everExpired) {
    this.everExpired = everExpired;
  }

  public boolean isChangePwdNextLogon() {
    return this.changePwdNextLogon;
  }

  public void setChangePwdNextLogon(boolean changePwdNextLogon) {
    this.changePwdNextLogon = changePwdNextLogon;
  }

  public int getNoOfFailedAttempt() {
    return this.noOfFailedAttempt;
  }

  public void setNoOfFailedAttempt(int noOfFailedAttempt) {
    this.noOfFailedAttempt = noOfFailedAttempt;
  }

  public int getNoOfGraceLogon() {
    return this.noOfGraceLogon;
  }

  public void setNoOfGraceLogon(int noOfGraceLogon) {
    this.noOfGraceLogon = noOfGraceLogon;
  }

  public Timestamp getLastAttemptTimestamp() {
    return this.lastAttemptTimestamp;
  }

  public void setLastAttemptTimestamp(Timestamp lastAttemptTimestamp) {
    this.lastAttemptTimestamp = lastAttemptTimestamp;
  }

  public Timestamp getLastAccessTimestamp() {
    return this.lastAccessTimestamp;
  }

  public void setLastAccessTimestamp(Timestamp lastAccessTimestamp) {
    this.lastAccessTimestamp = lastAccessTimestamp;
  }

  public Timestamp getLastModifyTimestamp() {
    return this.lastModifyTimestamp;
  }

  public void setLastModifyTimestamp(Timestamp lastModifyTimestamp) {
    this.lastModifyTimestamp = lastModifyTimestamp;
  }

  public String getCreatedBy() {
    return this.createdBy;
  }

  public void setCreatedBy(String createdBy) {
    this.createdBy = createdBy;
  }

  public Timestamp getCreationTimestamp() {
    return this.creationTimestamp;
  }

  public void setCreationTimestamp(Timestamp creationTimestamp) {
    this.creationTimestamp = creationTimestamp;
  }

  public float getDaysBeforePasswordExpired(int period) {
    return (this.lastModifyTimestamp.getTime() + period * noOfMillisInADay -
            this.lastAccessTimestamp.getTime()) / noOfMillisInADay;
  }

  public void cleanup() {
    this.domainID = null;
    this.userID = null;
    this.password = null;
    this.userName = null;
    this.description = null;
    this.suspended = false;
    this.everExpired = false;
    this.changePwdNextLogon = false;
    this.lastAttemptTimestamp = null;
    this.lastAccessTimestamp = null;
    this.lastModifyTimestamp = null;
    this.createdBy = null;
    this.creationTimestamp = null;
  }

}