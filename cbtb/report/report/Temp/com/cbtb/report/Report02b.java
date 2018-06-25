package com.cbtb.report;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import com.cbtb.util.*;
import net.line.fortress.apps.system.report.*;
import net.line.fortress.apps.system.report.jreport.*;

public class Report02b extends HttpServlet {
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
   * Init where condition :request_status='POST' & Destination City =HK  for O/B
  */
      whereString="DELIVERY_REQUEST.REQUEST_STATUS='"+ CbtbConstant.DELIVERY_REQUEST_POST+"' AND DELIVERY_REQUEST.DESTINATION_CITY_ID='"+CbtbConstant.HONGKONG_CITY_ID+"'";
      String startDate;
      String endDate;
      String deliveryTimeID;
      String originCityID;
//      String destinationCityID;
      String deliveryRequestNo;
      startDate=(String)request.getParameter("sd");
      endDate=(String)request.getParameter("ed");
      deliveryTimeID=(String)request.getParameter("ti");
      originCityID=(String)request.getParameter("oc");
//      destinationCityID=(String)request.getParameter("dc");
      deliveryRequestNo=(String)request.getParameter("no");
      userId=(String)request.getParameter("user");

       if(startDate.trim().length()>0)
         whereString=whereString+" AND DELIVERY_REQUEST.DELIVERY_DATE>=TO_DATE('"+startDate+"','YYYY-MM-DD')";
       if(endDate.trim().length()>0)
         whereString=whereString+" AND DELIVERY_REQUEST.DELIVERY_DATE<=TO_DATE('"+endDate+"','YYYY-MM-DD')";
       if(!deliveryTimeID.equals("Any"))
          whereString=whereString+" AND DELIVERY_REQUEST.DELIVERY_TIME_ID='"+deliveryTimeID+"'";
       if(!originCityID.equals("Any"))
          whereString=whereString+" AND DELIVERY_REQUEST.ORIGIN_CITY_ID='"+originCityID+"'";
//       if(!destinationCityID.equals("Any"))
//          whereString=whereString+" AND DELIVERY_REQUEST.DESTINATION_CITY_ID='"+destinationCityID+"'";
       if(deliveryRequestNo.trim().length()>0)
          whereString=whereString+" AND DELIVERY_REQUEST.DELIVERY_REQUEST_NUM='"+deliveryRequestNo+"'";
    doPost(request, response);
  }

  /**Process the HTTP Post request*/
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      ReportSpec spec=null  ;
      if (spec == null) {
            spec = new ReportSpec("cbt", "report02.cls", ReportSpec.PDF, ReportSpec.EN, ReportSpec.UTF8,whereString);
      }
      spec.getParameters().put("userId",userId);
      spec.getParameters().put("title", "Destination City:");
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
