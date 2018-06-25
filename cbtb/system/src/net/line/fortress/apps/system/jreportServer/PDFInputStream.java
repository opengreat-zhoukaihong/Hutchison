package net.line.fortress.apps.system.jreportServer;

import java.io.*;
import java.net.*;
import net.line.fortress.apps.system.*;

public class PDFInputStream extends InputStream {
  private HttpURLConnection connection = null;
  private InputStream in = null;
  public PDFInputStream(PDF pdf) throws IOException {
    this(pdf.getRelativePath());
  }
  public PDFInputStream(String path) throws IOException {
    ConfigManager configMgr = ConfigManager.getInstance();
    String system = path.substring(0, path.indexOf('/'));
    String reportPath = path.substring(path.indexOf('/'));
    String serverUrl = configMgr.getProperty("line.net.report.server." + system + ".url");
    String reportUrl = serverUrl + reportPath;
    try {
      connection = (HttpURLConnection)(new URL(reportUrl)).openConnection();
      connection.setDoInput(true);
      in = connection.getInputStream();
    } catch(IOException e) {
      this.close();
      throw e;
    }
  }
  public int read() throws IOException {
    return in.read();
  }
  public void close() {
    if (in != null) {
      try {
        in.close();
      } catch (Exception e) {}
    }
    in = null;
    if (connection != null) {
      try {
        connection.disconnect();
      } catch (Exception e) {}
    }
    connection = null;
  }
  protected void finalize() {
    this.close();
  }
}