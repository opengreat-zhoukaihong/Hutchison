package net.line.fortress.apps.system.nls;

import net.line.fortress.apps.system.*;

public class MissingResourceException extends BasicException{

    private String message;
    private Exception exception;

    public MissingResourceException() {
        super();
    }

    public MissingResourceException(String s) {
        super(s);
    }

    public MissingResourceException (Exception e) {
        super(e);
    }
}