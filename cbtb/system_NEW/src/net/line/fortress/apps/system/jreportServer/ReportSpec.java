package net.line.fortress.apps.system.jreportServer;

import java.util.*;
import java.net.*;

public class ReportSpec {
  private String systemName;
  private String reportName;
  private Hashtable parameters = new Hashtable();

  public ReportSpec(String systemName, String reportName) {
    this.systemName = systemName;
    this.reportName = reportName;
  }
  public String getSystemName() {
    return systemName;
  }
  public String getReportName() {
    return reportName;
  }
  public Hashtable getParameters() {
    return parameters;
  }
  public String toString() {
    StringBuffer sb = new StringBuffer();
    sb.append("systemName=");
    sb.append(systemName);
    sb.append(";reportName=");
    sb.append(reportName);
    for (Enumeration e = parameters.keys(); e.hasMoreElements(); ) {
      String key = (String)e.nextElement();
      String value = (String)parameters.get(key);
      sb.append(";");
      sb.append(URLEncoder.encode(key));
      sb.append("=");
      sb.append(URLEncoder.encode(value));
    }
    return sb.toString();
  }
}