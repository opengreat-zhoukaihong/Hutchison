package net.line.fortress.apps.system.nls;

import java.util.*;
import net.line.fortress.apps.system.*;

public class LanguageBundlePool {
    private static String baseName;
    private static LanguageBundlePool instance = null;
    private static Hashtable htLanguage = new Hashtable();

    private static synchronized void createInstance() {
        if (instance == null) {
            instance = new LanguageBundlePool();
        }
    }

    public static LanguageBundlePool getInstance() {
        if (instance == null) {
            createInstance();
        }
        return instance;
    }

    public synchronized LanguageBundleSystem getLanguageBundle(String baseName, String localeCode, String variantCode)
            throws InvalidKeyException {

        if (baseName.equals("") || localeCode.equals("") || variantCode.equals(""))
            throw new InvalidKeyException();
        String genericKey = baseName + "_" + localeCode;
        String specificKey = baseName + "_" + variantCode + "_" + localeCode;

        LogManager.instance.logDebug("LanguageBundlePool.getLanguageBundle() : genericKey[" + genericKey + "] and specificKey[" + specificKey + "]");

        Language lo = null;
        ResourceBundle rb, rb_gen, rb_spec = null;

        if (htLanguage.containsKey(genericKey)) {
            lo = (Language) htLanguage.get(genericKey);
            lo.counter++;
            htLanguage.put(genericKey,lo);
            rb_gen = ((Language)htLanguage.get(genericKey)).bundle;
        } else {
            try {
                rb = ResourceBundle.getBundle(baseName,
                                    new Locale(localeCode.substring(0,localeCode.indexOf('_')),
                                                localeCode.substring(localeCode.indexOf('_')+1)));
                lo = new Language(rb);
                htLanguage.put(genericKey,lo);
                rb_gen = ((Language)htLanguage.get(genericKey)).bundle;
           } catch (MissingResourceException e) {
                LogManager.instance.logError("Unable to get the generic bundle [" + genericKey + "]");
                rb_gen = null;
           }
        }

        if (htLanguage.containsKey(specificKey)) {
            lo = (Language) htLanguage.get(specificKey);
            lo.counter++;
            htLanguage.put(specificKey,lo);
            rb_spec = ((Language)htLanguage.get(specificKey)).bundle;
        } else {
            try {
                rb = ResourceBundle.getBundle(baseName + "_" + variantCode,
                        new Locale(localeCode.substring(0,localeCode.indexOf('_')),
                        localeCode.substring(localeCode.indexOf('_')+1)));
                lo = new Language(rb);
                htLanguage.put(specificKey,lo);
                rb_spec = ((Language)htLanguage.get(specificKey)).bundle;
            } catch (MissingResourceException e) {
                LogManager.instance.logError("Unable to get the specific bundle [" + specificKey + "]");
                rb_spec = null;
            }
        }

        return new LanguageBundleSystem(rb_gen, genericKey, rb_spec, specificKey);
    }

    public synchronized void removeLanguageBundle(LanguageBundleSystem myBundle)
            throws InvalidBundleException, LanguageNotFoundException {

        if (myBundle == null)
            throw new InvalidBundleException();

        String genericKey = myBundle.genericKey;
        String specificKey = myBundle.specificKey;
        ResourceBundle genericBundle = myBundle.genericBundle;
        ResourceBundle specificBundle = myBundle.specificBundle;

        if (genericBundle != null) {
            if (htLanguage.containsKey(genericKey)) {
                Language lo = (Language) htLanguage.get(genericKey);
                if (lo.counter > 1 ) {
                    lo.counter--;
                    htLanguage.put(genericKey,lo);
                    LogManager.instance.logDebug("generic bundle[" + genericKey + "] - decrement the counter by 1");
                } else {
                    htLanguage.remove(genericKey);
                    LogManager.instance.logDebug("remove the generic bundle [" + genericKey + "]");
                }
            } else {
                LogManager.instance.logError("generic bundle [" + genericKey + "] is not found in hashtable.");
                throw new LanguageNotFoundException();
            }
        }

       if (specificBundle != null) {
            if (htLanguage.containsKey(specificKey)) {
                Language lo = (Language) htLanguage.get(specificKey);
                if (lo.counter > 1 ) {
                    lo.counter--;
                    htLanguage.put(specificKey,lo);
                    LogManager.instance.logDebug("specific bundle[" + specificKey + "] - decrement the counter of the  by 1");
                } else {
                    htLanguage.remove(specificKey);
                    LogManager.instance.logDebug("remove the specific bundle [" + specificKey + "]");
                }
            } else {
                LogManager.instance.logError("specific bundle [" + specificKey + "] is not found in hashtable.");
                throw new LanguageNotFoundException();
            }
        }
    }
}