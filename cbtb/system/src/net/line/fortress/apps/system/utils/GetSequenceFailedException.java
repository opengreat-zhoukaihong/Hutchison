package net.line.fortress.apps.system.utils;

import net.line.fortress.apps.system.BasicException;

public class GetSequenceFailedException extends BasicException {
  public GetSequenceFailedException() {
    super();
  }
  public GetSequenceFailedException(String s) {
    super(s);
  }
  public GetSequenceFailedException(String s, Exception e) {
    super(s, e);
  }
}