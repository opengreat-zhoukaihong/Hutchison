package net.line.fortress.apps.system.security;

import net.line.fortress.apps.system.BasicException;

public class SecurityException extends BasicException {
  public SecurityException() {
    super();
  }

  public SecurityException(Exception e) {
    super(e);
  }
}