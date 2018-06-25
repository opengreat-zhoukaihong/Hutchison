// *** Generated Source File - Do Not Edit - Changes Will Be Lost ***

package net.line.fortress.apps.system.report.jreport;

// IM_Ag_
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
import java.util.Locale;
import net.line.fortress.apps.system.report.*;

public class JReportInputStream extends java.io.ByteArrayInputStream
	implements ReportInputStream
{

	private static byte[] tempBuf = new byte[1];

	public JReportInputStream() {
	    super(tempBuf);
	}

	public void init(ReportSpec reportSpec) throws ReportException {
	//      super(tempBuf);
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
	    System.out.println("reportURL:" + reportURL.toString());
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
	      pw.println(JReportConstants.getPostDataString(reportSpec));

	      // Force a send now.
	      pw.flush();

	      // Close the write.
	      pw.close();


	      conn.connect();
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
