package net.line.fortress.apps.system.nls;

import net.line.fortress.apps.system.*;

public class InvalidKeyException extends BasicException{

    private String message;
    private Exception exception;

    public InvalidKeyException() {
        super();
    }

    public InvalidKeyException(String s) {
        super(s);
    }

    public InvalidKeyException (Exception e) {
        super(e);
    }
}