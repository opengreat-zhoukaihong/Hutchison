package net.line.fortress.apps.system.security;

public class Domain implements java.io.Serializable {
  private String domainID;
  private String domainName;
  private String description;
  private String domainType;
  private int maxNoOfLogonAttempt;
  private int maxNoOfGraceLogon;
  private int consecutiveLogonInterval;
  private int inactivePeriodInDays;
  private int passwordExpiryPeriodInDays;
  private int countdownEnableInDays;

  public Domain(String domainID, String domainName, String description, String domainType,
		int maxNoOfLogonAttempt, int maxNoOfGraceLogon, int consecutiveLogonInterval,
		int inactivePeriodInDays, int passwordExpiryPeriodInDays, int countdownEnableInDays) {
    this.domainID = domainID;
    this.domainName = domainName;
    this.description = description;
    this.domainType = domainType;
    this.maxNoOfLogonAttempt = maxNoOfLogonAttempt;
    this.maxNoOfGraceLogon = maxNoOfGraceLogon;
    this.consecutiveLogonInterval = consecutiveLogonInterval;
    this.inactivePeriodInDays = inactivePeriodInDays;
    this.passwordExpiryPeriodInDays = passwordExpiryPeriodInDays;
    this.countdownEnableInDays = countdownEnableInDays;
  }

  public String getDomainID() {
    return this.domainID;
  }

  public void setDomainID(String domainID) {
    this.domainID = domainID;
  }

  public String getDomainName() {
    return this.domainName;
  }

  public void setDomainName(String domainName) {
    this.domainName = domainName;
  }

  public String getDescription() {
    return this.description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public String getDomainType() {
    return this.domainType;
  }

  public void setDomainType(String domainType) {
    this.domainType = domainType;
  }

  public int getMaxNoOfLogonAttempt() {
    return this.maxNoOfLogonAttempt;
  }

  public void setMaxNoOfLogonAttempt(int maxNoOfLogonAttempt) {
    this.maxNoOfLogonAttempt = maxNoOfLogonAttempt;
  }

  public int getMaxNoOfGraceLogon() {
    return this.maxNoOfGraceLogon;
  }

  public void setMaxNoOfGraceLogon(int maxNoOfGraceLogon) {
    this.maxNoOfGraceLogon = maxNoOfGraceLogon;
  }

  public int getConsecutiveLogonInterval() {
    return this.consecutiveLogonInterval;
  }

  public void setConsecutiveLogonInterval(int consecutiveLogonInterval) {
    this.consecutiveLogonInterval = consecutiveLogonInterval;
  }

  public int getInactivePeriodInDays() {
    return this.inactivePeriodInDays;
  }

  public void setInactivePeriodInDays(int consecutiveLogonInterval) {
    this.inactivePeriodInDays = inactivePeriodInDays;
  }

  public int getPasswordExpiryPeriodInDays() {
    return this.passwordExpiryPeriodInDays;
  }

  public void setPasswordExpiryPeriodInDays(int passwordExpiryPeriodInDays) {
    this.passwordExpiryPeriodInDays = passwordExpiryPeriodInDays;
  }

  public int getCountdownEnableInDays() {
    return this.countdownEnableInDays;
  }

  public void setCountdownEnableInDays(int countdownEnableInDays) {
    this.countdownEnableInDays = countdownEnableInDays;
  }

  public void cleanup() {
    this.domainID = null;
    this.domainName = null;
    this.description = null;
    this.domainType = null;
  }
}