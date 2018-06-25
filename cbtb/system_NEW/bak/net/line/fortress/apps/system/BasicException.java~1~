package net.line.fortress.apps.system;

import java.io.*;

public class BasicException extends Exception {
  private Exception chainedException;

  public BasicException() {
    this(null, null);
  }

  public BasicException(String message) {
    this(message, null);
  }

  public BasicException(Exception exception) {
    this(null, exception);
  }

  public BasicException(String message, Exception exception) {
    super(message);
    this.chainedException = exception;
  }

  public void printStackTrace() {
    if (this.chainedException != null) {
      this.chainedException.printStackTrace();
    }
    super.printStackTrace();
  }

  public void printStackTrace(PrintStream printStream) {
    if (this.chainedException != null) {
      this.chainedException.printStackTrace(printStream);
    }
    super.printStackTrace(printStream);
  }

  public void printStackTrace(PrintWriter printWriter) {
    if (this.chainedException != null) {
      this.chainedException.printStackTrace(printWriter);
    }
    super.printStackTrace(printWriter);
  }
}