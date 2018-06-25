package com.cbtb.report;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import com.cbtb.util.*;
import net.line.fortress.apps.system.report.*;
import net.line.fortress.apps.system.report.jreport.*;

public class Report04a extends HttpServlet {
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
   * Init where condition :request_status='CONFIRM' & Origin City =HK  for I/B
  */
     whereString="MC.MATCH_STATUS='"+ CbtbConstant.MATCH_STATUS_CONFIRM+"' AND DR.ORIGIN_CITY_ID='"+CbtbConstant.HONGKONG_CITY_ID+"'";
      String deliveryDate;
      String deliveryTimeID;
      deliveryDate=(String)request.getParameter("dd");
      deliveryTimeID=(String)request.getParameter("ti");
      userId=(String)request.getParameter("user");
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
            spec = new ReportSpec("cbt", "report04.cls", ReportSpec.PDF, ReportSpec.EN, ReportSpec.UTF8,whereString);
      }
      spec.getParameters().put("userId",userId);
      spec.getParameters().put("title", "Confirmed but not delivered for I/B");   //set the report title
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
