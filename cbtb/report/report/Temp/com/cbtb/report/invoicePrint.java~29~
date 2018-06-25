package com.cbtb.report;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import net.line.fortress.apps.system.report.*;
import net.line.fortress.apps.system.report.jreport.*;

public class InvoicePrint extends HttpServlet {
  private static final String CONTENT_TYPE = "text/html";
  /**Initialize global variables*/
  public void init(ServletConfig config) throws ServletException {
    super.init(config);
  }
  /**Process the HTTP Get request*/
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      doPost(request, response);
  }

  /**Process the HTTP Post request*/
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      ReportSpec spec=null  ;
      String whereString;
      String invoiceArray;
      String invoiceList=request.getParameter("chkInvoiceNo");
      if (invoiceList==null)
        return ;
      String[] invoiceNo=request.getParameterValues("chkInvoiceNo");
      invoiceArray="('"+invoiceNo[0]+"'";
      for(int i=1,size=invoiceNo.length;i<size;i++)
      {
          invoiceArray=invoiceArray+",'"+invoiceNo[i]+"'";
      }
      invoiceArray=invoiceArray+")";
      whereString= "INVOICE_DATA.INVOICE_NO in "+ invoiceArray;

      if (spec == null) {
            spec = new ReportSpec("cbt", "invoicePrint.cls", ReportSpec.PDF, ReportSpec.EN, ReportSpec.UTF8,whereString);
      }
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
