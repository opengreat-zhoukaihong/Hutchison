// *** Generated Source File - Do Not Edit - Changes Will Be Lost ***

package net.line.fortress.apps.system.report;

// IM_Ag_
import java.util.*;

public class ReportSpec
	implements java.io.Serializable
{

	// ------ Declarations ------
	// DC_Ag_
	public final static int HTML = 0;
	public final static int PDF = 1;
	public final static int TEXT = 2;
	public final static int EXCEL = 3;
	public final static int POSTSCRIPT = 4;
	public final static int RTF = 5;

	public final static String EN = "en";
	public final static String ZH = "zh";
	public final static String CH = "ch"; // should be removed
	public final static String CN = "cn";

	public final static String BIG5 = "BIG5";
	public final static String GBK = "GBK";
	public final static String UTF8 = "UTF8";

	public Locale locale = null;
	private String systemName = null;
	private String reportName = null;
	private int fileFormat = PDF;
	//    private String userLanguage = null;
	private String encoding = null;
	private String wherePortion = null;

	private Hashtable parameters = new Hashtable();

	private static int counter = 0;


	// ------ Instance Variables ------
	// ---- Begin SilverStream User-Written Event Handler Methods ----
	// ----

	// ------ Public methods ------

	// UC_Ag_
	public ReportSpec(String reportName) {
	        this(null, reportName);
	}

	public ReportSpec(String systemName, String reportName) {
	        this(systemName, reportName, PDF, null);
	}

	public ReportSpec(String systemName, String reportName, Locale locale) {
	        this(systemName, reportName, PDF, locale);
	}

	public ReportSpec(String systemName, String reportName, int fileFormat, Locale locale) {
	        this(systemName, reportName, fileFormat, locale, null, "");
	}

	public ReportSpec(String systemName, String reportName, int fileFormat, Locale locale, String encoding, String wherePortion) {
	        this.systemName = systemName;
	        this.reportName = reportName;
	        this.fileFormat = fileFormat;
	        this.locale = locale;
	        this.encoding = encoding;
	        this.wherePortion=wherePortion;
	}



	// depreciated constructor
	public ReportSpec(String systemName, String reportName, int fileFormat, String userLanguage, String encoding, String wherePortion) {
	        this.systemName = systemName;
	        this.reportName = reportName;
	        this.fileFormat = fileFormat;
	        this.encoding = encoding;
	        this.wherePortion=wherePortion;
	        this.setUserLanguage(userLanguage);
	}

	public String getSystemName() {
	        return systemName;
	}

	public void setSystemName(String systemName) {
	        this.systemName = systemName;
	}


	public String getReportName() {
	        return reportName;
	}

	public void setLocale(Locale locale) {
	  this.locale = locale;
	}

	private void setUserLanguage(String userLanguage) {
	        if (ReportSpec.EN.equals(userLanguage)) {
	          locale = Locale.ENGLISH;
	        } else if (ReportSpec.CN.equals(userLanguage)) {
	          locale = Locale.SIMPLIFIED_CHINESE;
	        } else if (ReportSpec.ZH.equals(userLanguage)) {
	          locale = Locale.TRADITIONAL_CHINESE;
	        } else if (ReportSpec.CH.equals(userLanguage)) {
	          locale = Locale.SIMPLIFIED_CHINESE;
	        }
	}

	/*
	 *  depreciated
	 *  use getLanguage() instead
	 */
	public String getUserLanguage() {
			if (locale == null) {
				return null;
			}
	        return locale.getLanguage();
	}

	public String getLanguage() {
			if (locale == null) {
				return null;
			}
	        return locale.getLanguage();
	}

	public String getCountry() {
			if (locale == null) {
				return null;
			}
	        return locale.getCountry();
	}

	public void setEncoding(String encoding) {
	        this.encoding = encoding;
	}

	public String getEncoding() {
	        return encoding;
	}

	public Hashtable getParameters() {
	        return parameters;
	}

	public void setFileFormat(int fileFormat) {
	        this.fileFormat = fileFormat;
	}

	public int getFileFormat() {
	        return fileFormat;
	}

	public void setWherePortion(String wherePortion) {
	        this.wherePortion = wherePortion;
	}

	public String getWherePortion() {
	        return wherePortion;
	}

	// this id cannot be used by window because it is too long
                             // depreciated function
	public synchronized String getId() {
	        return "RS" + counter++;
	}

}
