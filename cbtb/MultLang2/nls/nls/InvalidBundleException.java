package net.line.fortress.apps.system.nls;

import net.line.fortress.apps.system.*;

public class InvalidBundleException extends BasicException{

    private String message;
    private Exception exception;

    public InvalidBundleException() {
        super();
    }

    public InvalidBundleException(String s) {
        super(s);
    }

    public InvalidBundleException (Exception e) {
        super(e);
    }
}