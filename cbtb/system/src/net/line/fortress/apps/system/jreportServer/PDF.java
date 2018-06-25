package net.line.fortress.apps.system.jreportServer;

import java.io.*;
import java.net.*;
import java.util.*;
import net.line.fortress.apps.system.*;

public class PDF {
  private String relativePath = null;
  public PDF(ReportSpec spec) throws IOException {
    ConfigManager configMgr = ConfigManager.getInstance();
    String serverUrl = configMgr.getProperty("line.net.report.server." + spec.getSystemName() + ".url");
    String commandUrl = serverUrl + "/" + spec.getReportName() + "?jrs.cmd=jrs.web_vw&jrs.result_type=2&jrs.param_file=true";
    String key, val;
    for (Enumeration en = spec.getParameters().keys(); en.hasMoreElements(); ) {
      key = (String)en.nextElement();
      val = (String)spec.getParameters().get(key);
      commandUrl += "&jrs.param$" + key + "=" + val;
    }
    LogManager.instance.logDebug("PDF: jreport server command url - " + commandUrl);
//    this.relativePath = spec.getSystemName() + "/" + commandUrl.substring(commandUrl.lastIndexOf('/') + 1);
    HttpURLConnection conn = null;
    String resultUrl = null;
    try {
      conn = (HttpURLConnection)(new URL(commandUrl)).openConnection();
      conn.setFollowRedirects(false);
      conn.connect();
      int code = conn.getResponseCode();
      if ((code/100) == 3) { // HTTP Redirection
        String reportLoc = conn.getHeaderField("location");
	resultUrl = serverUrl + "/" + spec.getReportName() + "/result" + reportLoc.substring(reportLoc.lastIndexOf('/'));
      }
    } finally {
      if (conn != null) {
	try {
	  conn.disconnect();
        } catch (Exception e) {}
      }
    }
    LogManager.instance.logDebug("PDF: jreport server result url - " + resultUrl);
    this.relativePath = spec.getSystemName() + "/" + resultUrl.substring(commandUrl.lastIndexOf('/') + 1);
  }
  public String getRelativePath() {
    return this.relativePath;
  }
}