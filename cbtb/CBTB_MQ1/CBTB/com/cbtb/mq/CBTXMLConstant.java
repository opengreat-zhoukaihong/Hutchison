package com.cbtb.mq;

/**
 * Title:     CBT XML Constant<br>
 * Description:  The constants define to convert MQ message to our constants<br>
 * Copyright:    Copyright (c) 2001<br>
 * Company:      HT<br>
 * @author Henry Mei
 * @version 1.0
 * @see
 */

public class CBTXMLConstant
{
  public static final String ORGANISATION_TYPE_SHIPPER="Shipper";
  public static final String ORGANISATION_TYPE_TRUCKER="Trucking Company";

  public static final String ORGANISATION_PERFER_LANGUAGE_CN ="CN";
  public static final String ORGANISATION_PERFER_LANGUAGE_EN ="EN";

  public static final String ORGANISATION_STATUS_PENDING="PENDING";
  public static final String ORGANISATION_STATUS_ACTIVATE="ACTIVATE";
  public static final String ORGANISATION_STATUS_APPROVED ="APPROVED";
  public static final String ORGANISATION_STATUS_REJECTED="REJECTED";

  public static final String ORGANISATION_PAYMENT_TERMS_CASH="COD";
  public static final String ORGANISATION_PAYMENT_TERMS_CREDIT="CT";

  public static final String REGISTRATION_CHANNEL_INTERNET = "internet";
  public static final String REGISTRATION_CHANNEL_EMAIL = "email";
  public static final String REGISTRATION_CHANNEL_FAX = "fax";
  public static final String REGISTRATION_CHANNEL_PHONE = "phone";

  public static final String USER_GROUP_ID_ADMIN="OrgAdminGp";
  public static final String USER_GROUP_ID_OPREATOR="OrgOpreatorGp";

  public static final String ACTION_CREATE = "create";
  public static final String ACTION_DELETE = "delete";
  public static final String ACTION_CHANGE = "change";
  public static final String ACTION_SUSPEND = "suspend";
  public static final String ACTION_ACTIVE = "active";

  public static final String DTD_NAME_ORAGNISATION="organisation.dtd";
  public static final String DTD_NAME_TRUCKER="trucker.dtd";
  public static final String DTD_NAME_USER_GROUP="user_group.dtd";
  public static final String DTD_NAME_USER_PROFILE="user_profile.dtd";

  public static final String DATE_FORMAT="yyyy-MM-dd";
}