package net.line.fortress.apps.system.message.mq;

import net.line.fortress.apps.system.BasicException;

public class MQConnectionException extends BasicException{

  public MQConnectionException() {
	super();
  }

  public MQConnectionException(Exception e) {
	super(e);
  }

  public MQConnectionException(String message) {
	super(message);
  }

  public MQConnectionException(String message, Exception e) {
	super(message, e);
  }

}