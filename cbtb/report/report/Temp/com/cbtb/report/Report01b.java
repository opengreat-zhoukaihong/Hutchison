package com.cbtb.report;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import com.cbtb.util.*;
import net.line.fortress.apps.system.report.*;
import net.line.fortress.apps.system.report.jreport.*;

public class Report01b extends HttpServlet {
  public  String whereString;
  public String userId;
  private static final String CONTENT_TYPE = "text/html";
  /**Initialize global variables*/
  public void init(ServletConfig config) throws ServletException {
    super.init(config);
  }
  /**Process the HTTP Get request*/
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  /**
   * Init where condition :COMPANY_STATUS='COMPANY_REGISTRATION_IN_PROGRESS'
  */
//    whereString="COMPANY_PROFILE.COMPANY_STATUS='"+CbtbConstant.COMPANY_ACTIVE+"' AND DOCUMENT_NEED.RECORD_STATUS (+)= '0'";
    whereString="";
    userId=(String)request.getParameter("user");
    doPost(request, response);
  }

  /**Process the HTTP Post request*/
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      ReportSpec spec=null  ;
      if (spec == null) {
            spec = new ReportSpec("cbt", "report01b.cls", ReportSpec.PDF, ReportSpec.EN, ReportSpec.UTF8,whereString);
      }
      spec.getParameters().put("userId", userId);
      JReportPDFInputStream in = new JReportPDFInputStream(spec);
      response.setContentType("application/pdf");
      OutputStream out = response.getOutputStream();
      try {
        int bufferSize = 1024;

        byte[] buf = new byte[bufferSize];
        int cnt;
        for (;;) {
          cnt = in.read(buf);
          if (cnt == -1) {
            break;
          }
          out.write(buf, 0, cnt);
        }
      } catch(Exception e) {
        e.printStackTrace();
      } finally {
        if (in != null) {
          in.close();
        }
        if (out != null) {
          out.close();
        }
      }
  }
  /**Clean up resources*/
  public void destroy() {
  }
}
