// *** Generated Source File - Do Not Edit - Changes Will Be Lost ***

package net.line.fortress.apps.system.report.jreport;

// IM_Ag_
import java.util.Enumeration;
import net.line.fortress.apps.system.report.*;
import net.line.fortress.apps.system.*;
import net.line.fortress.apps.system.utils.DefaultConnectionPool;

public class JReportConstants
{

	// ------ Declarations ------
	// DC_Ag_
	public final static String HTML = "1";
	public final static String PDF = "2";
	public final static String TEXT = "3";
	public final static String EXCEL = "4";
	public final static String POSTSCRIPT = "5";
	public final static String RTF = "6";


	// ------ Instance Variables ------
	// ---- Begin SilverStream User-Written Event Handler Methods ----
	// ----

	// ------ Public methods ------

	// UC_Ag_
	public static String getFileFormat(ReportSpec reportSpec) {
	  switch (reportSpec.getFileFormat()) {
	    case ReportSpec.HTML: return HTML;
	    case ReportSpec.PDF: return PDF;
	    case ReportSpec.TEXT: return TEXT;
	    case ReportSpec.EXCEL: return EXCEL;
	    case ReportSpec.POSTSCRIPT: return POSTSCRIPT;
	    case ReportSpec.RTF: return RTF;
	  }
	  return null;
	}

	public static String getFileFormatName(ReportSpec reportSpec) {
	  switch (reportSpec.getFileFormat()) {
	    case ReportSpec.HTML: return "html";
	    case ReportSpec.PDF: return "pdf";
	    case ReportSpec.TEXT: return "text";
	    case ReportSpec.EXCEL: return "excel";
	    case ReportSpec.POSTSCRIPT: return "postscript";
	    case ReportSpec.RTF: return "rtf";
	  }
	  return null;
	}

	public static String getURLString(ReportSpec reportSpec) {
	  ConfigManager configMgr = ConfigManager.getInstance();
	  String serverUrl = configMgr.getProperty("net.line.report.server." + reportSpec.getSystemName() + ".url");
	  String url = serverUrl + "/" + reportSpec.getReportName();
	  return url;
	}

	public static String getPostDataString(ReportSpec reportSpec) {
	  Enumeration parameters = reportSpec.getParameters().keys();
	  String url = "";
	  String key = "";
	  String val = "";

	  url = "jrs.cmd=jrs.web_vw&jrs.result_type=" + getFileFormat(reportSpec) + "&jrs.param_file=true";

	  while (parameters.hasMoreElements()) {
	    key = (String)parameters.nextElement();
	    val = (String)reportSpec.getParameters().get(key);
	    url += "&jrs.param$" + key + "=" + val;
	  }

	  String language = reportSpec.getLanguage();
	  String country = reportSpec.getCountry();

	  if (language != null && !"".equals(language)) {
	      url += "&jrs.rpt_language=" + reportSpec.getLanguage();
	      if (reportSpec.getEncoding() == null || "".equals(reportSpec.getEncoding())) {
	        ConfigManager configMgr = ConfigManager.getInstance();
	        String encoding = null;
	        if (country != null && !"".equals(country)) {
	          encoding = configMgr.getProperty("net.line.report.jreport." +
	          getFileFormatName(reportSpec) + "."+ reportSpec.getLanguage() + "." +
	          reportSpec.getCountry() + ".encoding");
	          System.out.println("encoding:" + encoding);
	          if (encoding == null || "".equals(encoding)) {
	            encoding = configMgr.getProperty("net.line.report.jreport.default." +
	            reportSpec.getLanguage() + "." + reportSpec.getCountry() + ".encoding", "BIG5");
	          }
	        } else {
	          encoding = configMgr.getProperty("net.line.report.jreport." +
	          getFileFormatName(reportSpec) + "."+ reportSpec.getLanguage() + ".encoding");

	          if (encoding == null || "".equals(encoding)) {
	            encoding = configMgr.getProperty("net.line.report.jreport.default." +
	            reportSpec.getLanguage() + ".encoding", "BIG5");
	          }
	        }
	        url += "&jrs.rpt_encoding=" + encoding;
	      } else {
	        url += "&jrs.rpt_encoding=" + reportSpec.getEncoding();
	      }
	  }

	  if (reportSpec.getWherePortion() != null && !"".equals(reportSpec.getWherePortion())) {
	    url += "&jrs.wp=" + reportSpec.getWherePortion();
	  }
	  return url;
	}

}
