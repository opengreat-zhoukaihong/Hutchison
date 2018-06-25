package net.line.fortress.apps.system.nls;
import net.line.fortress.apps.system.LogManager;
import java.util.*;


public class LanguageBundleSystem {
    private Resource genericResource = null;
    private Resource specificResource = null;
    private String basename = "";
    private String projectCode = "";
    private Locale locale = null;

    public LanguageBundleSystem(String basename, String localeCode, String projectCode) {
        this.projectCode = projectCode;
        this.basename = basename;
        this.locale = new Locale(localeCode.substring(0,localeCode.indexOf('_')),
                                    localeCode.substring(localeCode.indexOf('_')+1));;

        this.genericResource = getResource(this.basename,locale.getCountry(),locale.getLanguage());
        this.specificResource = getResource(this.basename+"_"+projectCode,locale.getCountry(),locale.getLanguage());
    }

    private Resource getResource(String basename, String country, String language) {
        String name = basename + "_" + language + "_" + country;
//        LogManager.instance.logInfo("LanguageResourceSystem.getResource(): get the resource[" + name + "]");
        return FilePool.getInstance().getResource(name);
    }

    public String getProperty(String sKey) {
        if (specificResource != null) {
            try {
                return this.specificResource.getProperty(sKey);
            } catch (MissingResourceException e) {
                try {
                    if (genericResource != null)
                        return this.genericResource.getProperty(sKey);
                    else
                        return sKey;
                } catch (MissingResourceException e1) {
                    //LogManager.instance.logError("Unable to get property of key " + sKey + " from the specific and generic bundle");
                    return sKey;
                }
            }
        } else {
            if (genericResource != null) {
                try {
                    return this.genericResource.getProperty(sKey);
                } catch (MissingResourceException e) {
                   // LogManager.instance.logError("Unable to get property of key " + sKey + " from the specific and generic bundle");
                    return sKey;
                }
            } else {
                return sKey;
            }
        }
    }
}