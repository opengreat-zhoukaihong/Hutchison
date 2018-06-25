package net.line.fortress.apps.system.web;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.net.*;
import net.line.fortress.apps.system.*;
import net.line.fortress.apps.system.jreportServer.*;

public class srvReport extends HttpServlet {
  private static final String CONTENT_TYPE = "text/html";
  /**Initialize global variables*/
  public void init(ServletConfig config) throws ServletException {
    super.init(config);
  }
  /**Process the HTTP Get request*/
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    ConfigManager configMgr = ConfigManager.getInstance();
    String path = request.getPathInfo();
    String report = path.substring(1, path.indexOf('.', 1));
    String relativePath = request.getQueryString();
    LogManager.instance.logDebug("srvReport: jreport server report url - " + relativePath);

    Vector reports = (Vector)request.getSession().getAttribute("net.line.report.list");
    int maxReportNo = Integer.parseInt(configMgr.getProperty("net.line.report.max", "20"));
    if (reports == null || !reports.contains(report)) {
      LogManager.instance.logDebug("Not in report list");
      response.sendError(HttpServletResponse.SC_NOT_FOUND);
      return;
    }

    PDFInputStream in = null;
    OutputStream out = null;
    try {
      in = new PDFInputStream(relativePath);
      out = response.getOutputStream();
      byte[] buffer = new byte[4096];
      int count = in.read(buffer);
      while (count != -1) {
        out.write(buffer, 0, count);
        count = in.read(buffer);
      }
    } catch (IOException e) {
      LogManager.instance.logError("srvReport: communication error ", e);
    } finally {
      if (in != null) {
        try {
          in.close();
        } catch(Exception e) {}
      }
      if (out != null) {
        try {
          out.close();
        } catch(Exception e) {}
      }
    }
  }
  /**Clean up resources*/
  public void destroy() {
  }
}