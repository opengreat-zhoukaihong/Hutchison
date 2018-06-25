package net.line.fortress.apps.system.report.jreport;

/**
 * Title:
 * Description:
 * Copyright:    Copyright (c) 2001
 * Company:
 * @author
 * @version 1.0
 */

import java.util.Enumeration;
import java.net.URL;
import java.net.HttpURLConnection;
import java.io.InputStream;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.StringReader;
import java.io.DataInputStream;
import java.io.CharArrayReader;
import java.io.PrintWriter;
import net.line.fortress.apps.system.report.ReportSpec;
import net.line.fortress.apps.system.report.ReportException;

public class JReportPDFInputStream extends ByteArrayInputStream {
  private static byte[] tempBuf = new byte[1];
  String postString;

  public JReportPDFInputStream(ReportSpec reportSpec) throws ReportException {
      super(tempBuf);

      if (reportSpec == null) {
        throw new ReportException("reportSpec cannot be null");
      }
      ByteArrayOutputStream outputStream = generateReport(reportSpec);
      this.buf = outputStream.toByteArray();
      this.pos = 0;
      this.count = buf.length;

      if (outputStream != null) {
        try {
          outputStream.close();
        } catch (Exception e) {
          e.printStackTrace();
        }
      }
  }

  private URL initURL(ReportSpec reportSpec) throws ReportException {
      String url = JReportConstants.getURLString(reportSpec);
      postString ="jrs.auth_uid=admin&jrs.auth_pwd=admin&jrs.cmd=jrs.web_vw&jrs.result_type=2&jrs.param_file=true&jrs.wp="+reportSpec.getWherePortion();
      String key, val;

      for (Enumeration en = reportSpec.getParameters().keys(); en.hasMoreElements(); ) {
              key = (String)en.nextElement();
              val = (String)reportSpec.getParameters().get(key);
              postString += "&jrs.param$" + key + "=" + val;
      }

      try {
        URL reportUrl = new URL(url);
        return reportUrl;
      } catch (Exception e) {
        e.printStackTrace();
      	throw new ReportException("unable to init URL: " + url);
      }
  }

  private ByteArrayOutputStream generateReport(ReportSpec reportSpec) throws ReportException {
      URL reportURL = initURL(reportSpec);

      ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
      InputStream in = null;
      HttpURLConnection conn = null;

      try {
        conn = (HttpURLConnection)reportURL.openConnection();

        conn.setFollowRedirects(true);
        // Allow Inputs
        conn.setDoInput(true);
        // Allow Outputs
        conn.setDoOutput(true);
        // Don't use a cached copy.
        conn.setUseCaches(false);
        // Use a post method.
        conn.setRequestMethod("POST");
        // Create a writer for the page
        PrintWriter pw = new PrintWriter(conn.getOutputStream());

        // Send the variables to the page. Variables need to
        // be seperated with a &
//        pw.println(JReportConstants.getPostDataString(reportSpec));
        // Force a send now.
        pw.println(postString);
        pw.flush();
        // Close the write.
        pw.close();

//        conn.connect();
        int code = conn.getResponseCode();
        String reportLoc = conn.getHeaderField("location");
        in = new BufferedInputStream(conn.getInputStream());
        int bufferSize = 1024;

        byte[] buf = new byte[bufferSize];
        int cnt;
        for (;;) {
          cnt = in.read(buf);
          if (cnt == -1) {
            break;
          }
          outputStream.write(buf, 0, cnt);
        }
      } catch (Exception e ) {
        e.printStackTrace();
 	throw new ReportException("unable to generate report");
      } finally {
        if (in != null) {
          try {
            in.close();
          } catch (Exception e) {}
        }
        if (conn != null) {
          try {
            conn.disconnect();
          } catch (Exception e) {}
        }
      }
      return outputStream;
  }

}


