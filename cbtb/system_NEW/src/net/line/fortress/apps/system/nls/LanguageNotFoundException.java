package net.line.fortress.apps.system.nls;

import net.line.fortress.apps.system.*;

public class LanguageNotFoundException extends BasicException{

    private String message;
    private Exception exception;

    public LanguageNotFoundException() {
        super();
    }

    public LanguageNotFoundException(String s) {
        super(s);
    }

    public LanguageNotFoundException (Exception e) {
        super(e);
    }
}