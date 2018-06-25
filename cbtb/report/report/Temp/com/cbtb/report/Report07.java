package com.cbtb.report;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import com.cbtb.util.*;
import net.line.fortress.apps.system.report.*;
import net.line.fortress.apps.system.report.jreport.*;

public class Report07 extends HttpServlet {
  private static final String CONTENT_TYPE = "text/html";
  public String whereString;
  public String userId;
  /**Initialize global variables*/
  public void init(ServletConfig config) throws ServletException {
    super.init(config);
  }
  /**Process the HTTP Get request*/
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      String deliveryDate;
      String deliveryTimeID;
      deliveryDate=(String)request.getParameter("dd");
      deliveryTimeID=(String)request.getParameter("ti");
      userId=(String)request.getParameter("user");
      whereString="MATCH_CAPACITY_REQUEST.MATCH_STATUS='"+CbtbConstant.MATCH_STATUS_MATCHED+"'"; //status='1'; Matched
       if(deliveryDate.trim().length()>0)
         whereString=whereString+" AND DR.DELIVERY_DATE=TO_DATE('"+deliveryDate+"','YYYY-MM-DD')";
       if(!deliveryTimeID.equals("Any"))
          whereString=whereString+" AND DR.DELIVERY_TIME_ID='"+deliveryTimeID+"'";
    doPost(request, response);
  }

  /**Process the HTTP Post request*/
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      ReportSpec spec=null  ;
      if (spec == null) {
            spec = new ReportSpec("cbt", "report07.cls", ReportSpec.PDF, ReportSpec.EN, ReportSpec.UTF8,whereString);
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
