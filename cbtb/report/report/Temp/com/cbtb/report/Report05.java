package com.cbtb.report;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import com.cbtb.util.*;
import net.line.fortress.apps.system.report.*;
import net.line.fortress.apps.system.report.jreport.*;

public class Report05 extends HttpServlet {
  public    String whereString;
  public    String startDate;
  public    String endDate;
  public    String invoiceNo;
  public    String shipperID;
  public    String userId;
  private static final String CONTENT_TYPE = "text/html";
  /**Initialize global variables*/
  public void init(ServletConfig config) throws ServletException {
    super.init(config);
  }
  /**Process the HTTP Get request*/
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  /**INVOICE_STATUS <>'CANCEL' & PAY_STATUS='0' NoPaid;
  */
      whereString="INVOICE_DATA.INVOICE_STATUS >'"+ CbtbConstant.INVOICE_STATUS_CANCELD+"' AND INVOICE_DATA.PAY_STATUS='"+ CbtbConstant.PAY_STATUS_NOPAID+"'";
      startDate=(String)request.getParameter("sd");
      endDate=(String)request.getParameter("ed");
      invoiceNo=(String)request.getParameter("no");
      shipperID=(String)request.getParameter("id");
      userId=(String)request.getParameter("user");

       if(startDate.trim().length()>0)
         whereString=whereString+" AND INVOICE_DATA.CREATION_DATE>=TO_DATE('"+startDate+"','YYYY-MM-DD')";
       if(endDate.trim().length()>0)
         whereString=whereString+" AND INVOICE_DATA.CREATION_DATE<=TO_DATE('"+endDate+"','YYYY-MM-DD')";
       if(invoiceNo.trim().length()>0)
          whereString=whereString+" AND INVOICE_DATA.INVOICE_NO='"+invoiceNo+"'";
       if(shipperID.trim().length()>0)
          whereString=whereString+" AND INVOICE_DATA.SHIPPER_NO='"+shipperID+"'";
      doPost(request, response);
  }

  /**Process the HTTP Post request*/
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      ReportSpec spec=null  ;
      if (spec == null) {
            spec = new ReportSpec("cbt", "report05.cls", ReportSpec.PDF, ReportSpec.EN, ReportSpec.UTF8,whereString);
      }
       if(startDate.trim().length()>0)
           spec.getParameters().put("startDate", startDate);
       if (endDate.length()>0)
           spec.getParameters().put("endDate", endDate);
      spec.getParameters().put("userId",userId);
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
