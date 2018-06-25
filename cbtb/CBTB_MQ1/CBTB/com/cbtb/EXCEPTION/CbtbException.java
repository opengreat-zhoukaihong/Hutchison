package com.cbtb.exception;
import javax.ejb.EJBException;

/**
 * Title:
 * Description:
 * Copyright:    Copyright (c) 2001
 * Company:
 * @author
 * @version 1.0
 */

public class CbtbException extends javax.ejb.EJBException  implements java.io.Serializable
{
  private String errorCode = "";

  public CbtbException()
  {
    super();
  }

  public CbtbException(String msg)
  {
    super(msg);
    errorCode = msg;
  }

  public String getErrorCode()
  {
    return errorCode;
  }
}