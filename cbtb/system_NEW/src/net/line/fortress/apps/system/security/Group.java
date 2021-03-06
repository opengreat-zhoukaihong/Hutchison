package net.line.fortress.apps.system.security;

/**
 * Title:
 * Description:
 * Copyright:    Copyright (c) 2001
 * Company:
 * @author
 * @version 1.0
 */
import java.sql.Timestamp;
public class Group implements java.io.Serializable{
  private String domainID;
  private String groupID;
  private String groupName;
  private String description;
  private String createdBy;
  private Timestamp creationTimestamp;
  public Group() {
  }
  public Group(String domainID,
               String groupID,
               String groupName,
               String description,
               String createdBy,
               Timestamp creationTimestamp)
  {
    this.domainID = domainID;
    this.groupID = groupID;
    this.groupName = groupName;
    this.description = description;
    this.createdBy = createdBy;
    this.creationTimestamp = creationTimestamp;
  }
  public String getDomainID()
  {
    return this.domainID;
  }
  public void setDomainID(String domainID)
  {
    this.domainID = domainID;
  }
  public String getGroupID()
  {
    return this.groupID;
  }
  public void setGroupID(String groupID)
  {
    this.groupID = groupID;
  }
  public String getGroupName()
  {
    return this.groupName;
  }
  public void setGroupName(String groupName)
  {
    this.groupName = groupName;
  }
  public String getDescription()
  {
    return this.description;
  }
  public void setDescription(String description)
  {
    this.description = description;
  }
  public String getCreatedBy()
  {
    return this.createdBy;
  }
  public void setCreatedBy(String createdBy)
  {
    this.createdBy = createdBy;
  }
  public Timestamp getCreationTimestamp()
  {
    return this.creationTimestamp;
  }
  public void setCreationTimestamp(Timestamp creationTimestamp)
  {
    this.creationTimestamp = creationTimestamp;
  }
}