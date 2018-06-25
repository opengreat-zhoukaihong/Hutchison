package net.line.fortress.apps.system.security;

public class SecurityDBAccessException extends SecurityException {
  public SecurityDBAccessException(Exception e) {
    super(e);
  }
}