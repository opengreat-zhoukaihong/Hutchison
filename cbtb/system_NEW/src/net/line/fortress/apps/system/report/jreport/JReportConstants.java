package net.line.fortress.apps.system.report.jreport;

/**
 * Title:
 * Description:
 * Copyright:    Copyright (c) 2001
 * Company:
 * @author
 * @version 1.0
 */
import java.util.Enumeration;
import java.util.Collection;
import java.util.Iterator;
import net.line.fortress.apps.system.ConfigManager;
import net.line.fortress.apps.system.report.ReportSpec;

public class JReportConstants {
    public final static String HTML = "1";
    public final static String PDF = "2";
    public final static String TEXT = "3";
    public final static String EXCEL = "4";
    public final static String POSTSCRIPT = "5";
    public final static String RTF = "6";

    public static String getFileFormat(ReportSpec reportSpec) {
      switch (reportSpec.getFileFormat()) {
        case ReportSpec.HTML: return HTML;
        case ReportSpec.PDF: return PDF;
        case ReportSpec.TEXT: return EXCEL;
        case ReportSpec.EXCEL: return EXCEL;
        case ReportSpec.POSTSCRIPT: return POSTSCRIPT;
        case ReportSpec.RTF: return RTF;
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
      url += "&jrs.rpt_language=" + reportSpec.getUserLanguage() + "&jrs.rpt_encoding=" + reportSpec.getEncoding();
      if (!"".equals(reportSpec.getWherePortion())) {
        url += "&jrs.wp=" + reportSpec.getWherePortion();
      }
      System.out.println("url:" + url);
      return url;
    }

}