package net.line.fortress.apps.system.jreportServer;

import java.io.*;
import java.util.*;
import javax.servlet.http.HttpSession;
import net.line.fortress.apps.system.*;

public class ReportUtil {
  public static String printReport(ReportSpec rs, HttpSession session) throws IOException {
    Vector reports = (Vector)session.getAttribute("net.line.report.list");
    ConfigManager configMgr = ConfigManager.getInstance();
    int maxReportNo = Integer.parseInt(configMgr.getProperty("net.line.report.max", "20"));
    if (reports == null) {
      reports = new Vector();
      session.setAttribute("net.line.report.list", reports);
    } else if (reports.size() >= maxReportNo) {
      reports.removeElementAt(0);
    }
    String path = new PDF(rs).getRelativePath();
    String key = Long.toString(System.currentTimeMillis());
    reports.add(key);
    return "/common/servlet/report/" + key + ".pdf?" + path;
  }
}