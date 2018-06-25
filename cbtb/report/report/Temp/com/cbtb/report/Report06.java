package com.cbtb.report;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import com.cbtb.util.*;
import net.line.fortress.apps.system.report.*;
import net.line.fortress.apps.system.report.jreport.*;

public class Report06 extends HttpServlet {
  public  String whereString;
  public  String startDate;
  public  String endDate;
  public  String userId;

  private static final String CONTENT_TYPE = "text/html";
  /**Initialize global variables*/
  public void init(ServletConfig config) throws ServletException {
    super.init(config);
  }
  /**Process the HTTP Get request*/
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      String companyID;
      String matchNumber;
      String truckerCapacityNo;
      String truckerID;
      String statementNo;

  /**STATEMENT_STATUS <>'CANCEL'*/
      whereString="STATEMENT_DATA.STATEMENT_STATUS >'"+ CbtbConstant.STATEMENT_STATUS_CANCEL+"'";
      startDate=(String)request.getParameter("sd");
      endDate=(String)request.getParameter("ed");
      companyID=(String)request.getParameter("ci");
      matchNumber=(String)request.getParameter("mn");
      truckerCapacityNo=(String)request.getParameter("no");
      truckerID=(String)request.getParameter("ti");
      statementNo=(String)request.getParameter("sn");
      userId=(String)request.getParameter("user");
       if(startDate.trim().length()>0)
         whereString=whereString+" AND TRUCK_CAPACITY.DELIVERY_DATE>=TO_DATE('"+startDate+"','YYYY-MM-DD')";
       if(endDate.trim().length()>0)
         whereString=whereString+" AND TRUCK_CAPACITY.DELIVERY_DATE<=TO_DATE('"+endDate+"','YYYY-MM-DD')";
       if(companyID.trim().length()>0)
          whereString=whereString+" AND STATEMENT_DATA.TRUCK_COMPANY_NO='"+companyID+"'";
       if(matchNumber.trim().length()>0)
          whereString=whereString+" AND STATEMENT_DETAIL_DATA.MATCH_NUMBER='"+matchNumber+"'";
       if(truckerCapacityNo.trim().length()>0)
          whereString=whereString+" AND TRUCK_CAPACITY.TRUCK_CAPACITY_NUM='"+truckerCapacityNo+"'";
       if(truckerID.trim().length()>0)
          whereString=whereString+" AND TRUCK_CAPACITY.TRUCKER_ID='"+truckerID+"'";
       if(statementNo.trim().length()>0)
          whereString=whereString+" AND STATEMENT_DATA.STATEMENT_NO='"+statementNo+"'";
      doPost(request, response);
  }

  /**Process the HTTP Post request*/
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      ReportSpec spec=null  ;

      if (spec == null) {
            spec = new ReportSpec("cbt", "report06.cls", ReportSpec.PDF, ReportSpec.EN, ReportSpec.UTF8,whereString);
      }

      if(startDate.trim().length()>0)
            spec.getParameters().put("startDate", startDate);
      if (endDate.length()>0)
            spec.getParameters().put("endDate", endDate);
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
