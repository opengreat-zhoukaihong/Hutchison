package net.line.fortress.apps.system.dbquery;

public class ResultSetTimeoutException extends RuntimeException {
  public ResultSetTimeoutException() {
    super();
  }
  public ResultSetTimeoutException(String msg) {
    super(msg);
  }
}