package net.line.fortress.apps.system.nls;


import java.util.*;
import net.line.fortress.apps.system.*;;

public class LanguageBundleSystem {
    public ResourceBundle genericBundle;
    public ResourceBundle specificBundle;
    public String genericKey;
    public String specificKey;

    public LanguageBundleSystem(ResourceBundle genBundle, String genKey, ResourceBundle specBundle, String specKey) {
        this.genericBundle = genBundle;
        this.genericKey = genKey;
        this.specificBundle = specBundle;
        this.specificKey = specKey;
    }

    public String getProperty(String sKey) {
        if (specificBundle != null) {
            try {
                return this.specificBundle.getString(sKey);
            } catch (MissingResourceException e) {
                try {
                    return this.genericBundle.getString(sKey);
                } catch (MissingResourceException e1) {
                    //LogManager.instance.logError("Unable to get property of key " + sKey + " from the specific and generic bundle.");
                    return sKey;
                }
            }
        } else {
            if (genericBundle != null) {
                try {
                    return this.genericBundle.getString(sKey);
                } catch (MissingResourceException e) {
                    //LogManager.instance.logError("Unable to get property of key " + sKey + " from the specific and generic bundle.");
                    return sKey;
                }
            } else {
                return sKey;
            }
        }
    }
}