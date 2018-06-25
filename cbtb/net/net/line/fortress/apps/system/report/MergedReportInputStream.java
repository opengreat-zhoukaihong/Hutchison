package net.line.fortress.apps.system.report;

import jet.pdf.*;
import java.util.*;
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
import java.io.*;
import java.util.Locale;
import net.line.fortress.apps.system.ConfigManager;
import net.line.fortress.apps.system.report.jreport.*;
import net.line.fortress.apps.system.util.UniqueNumberGenerator;

public class MergedReportInputStream extends java.io.ByteArrayInputStream
{

      private static byte[] tempBuf = new byte[1];
      private Collection reportFiles = new LinkedList();
      private String tempReportDir = null;
      private String tempFilePrefix =null;
      private static UniqueNumberGenerator  numberGenerator = new UniqueNumberGenerator();

      public MergedReportInputStream() {
          super(tempBuf);
      }

      public void init(Collection reportSpecs, String tempFilePrefix) throws ReportException {
        this.tempFilePrefix = tempFilePrefix;
        tempReportDir = ConfigManager.getInstance().getProperty("net.line.system.report.tempDirectory", "/opt/weblogic/tempReport");
        if (tempReportDir == null || "".equals(tempReportDir)) {
                throw new ReportException("Temp report directory not found");
        }

        Iterator iterator = reportSpecs.iterator();
        int i = 0;
        while (iterator.hasNext()) {
            i++;
            String fileName = generateReportFile((ReportSpec) iterator.next());
            reportFiles.add(fileName);
        }
        try {
          merge();
        } catch (Exception e) {
          e.printStackTrace();
          throw new ReportException("Unable to merge reports");
        }
        cleanUp();
      }

      public void init(Collection reportSpecs) throws ReportException {
        init(reportSpecs, null);
      }

      private synchronized String getUniqueFileName() {
             return  tempFilePrefix + "_" + numberGenerator.generateRandomNumber() + ".pdf";
      }

      private synchronized String getUniqueFileName(ReportSpec spec){
             return  tempFilePrefix + "_" + spec.getReportName() .substring(0, spec.getReportName() .length() - 4) + numberGenerator.generateRandomNumber() + ".pdf";
      }

      private synchronized String getResultFileName(){
             return  tempFilePrefix + "_" + numberGenerator.generateTimeNumber() + ".pdf";
      }

      private void  merge()  throws IOException {
          String resultFile = tempReportDir +System.getProperty("file.separator") + getResultFileName();
          Iterator iterator = reportFiles.iterator();
          PdfExt pdf = null;
          if (iterator.hasNext()) {
            try {
              pdf = new PdfExt((String) iterator.next());
            } catch (Exception e) {
              e.printStackTrace();
            }
          }
          while (iterator.hasNext()) {
            try {
                pdf.appendPdfDocument(new PdfExt((String) iterator.next()));
            } catch (Exception e) {
              e.printStackTrace();
            }
          }
          pdf.writeToFile(resultFile);
          readResultFile(resultFile);
          reportFiles.add(resultFile);
      }

      private void  readResultFile(String resultFile)  throws IOException {
          ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
          InputStream in = new BufferedInputStream(new FileInputStream(resultFile));
          int bufferSize = 1024;

          byte[] tempBuf = new byte[bufferSize];
          int cnt;
          for (;;) {
            cnt = in.read(tempBuf);
            if (cnt == -1) {
              break;
            }
            outputStream.write(tempBuf, 0, cnt);
          }
          in.close();
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

      private void cleanUp() {
          Iterator iterator = reportFiles.iterator();
          while (iterator.hasNext()) {
            try {
              File file = new File((String)iterator.next());
              file.delete();
            } catch (Exception e) {
              e.printStackTrace();
            }
          }
      }

      private String generateReportFile(ReportSpec reportSpec)  throws ReportException {
              String outputFile = tempReportDir + System.getProperty("file.separator") + getUniqueFileName(reportSpec);
              ReportInputStream in = null;
              FileOutputStream out = null;

              try {
                in = new JReportInputStream();
              ((ReportInputStream)in).init(reportSpec);
                int bufferSize = 1024;
                out = new FileOutputStream(outputFile);
                byte[] buf = new byte[bufferSize];
                int cnt;
                for (;;) {
                  cnt = ((InputStream)in).read(buf);
                  if (cnt == -1) {
                    break;
                  }
                  out.write(buf, 0, cnt);
                }
              } catch(Exception e) {
                e.printStackTrace();
                throw new ReportException("Report cannot be generated:"+ reportSpec);
              } finally {
                try {
                  if (in != null) {
                    ((InputStream)in).close();
                  }
                  if (out != null) {
                    out.close();
                  }
                } catch (Exception ex) {
                  ex.printStackTrace();
                }
              }
              return outputFile;
      }

      public static void main(String[] args) {
                        try {
                                  MergedReportInputStream in = new MergedReportInputStream();

                                    Collection reportSpecs = new LinkedList();
                                    ReportSpec report1 = new ReportSpec("testEop", "showEop2.cls");
                                    ReportSpec report2 = new ReportSpec("testEop", "showEop2.cls");
                                    ReportSpec report3 = new ReportSpec("testEop", "showEop2.cls");
                                    report1.getParameters().put("docId", "PO00001");
                                    report2.getParameters().put("docId", "PO00002");
                                    report3.getParameters().put("docId", "PO00003");
                                    reportSpecs.add(report1);
                                    reportSpecs.add(report2);
                                    reportSpecs.add(report3);
                                    in.init(reportSpecs, "ivanlaw");

	        OutputStream out = new FileOutputStream("c:\\result.pdf");
	        try {
	          int bufferSize = 1024;

	          byte[] buf = new byte[bufferSize];
	          int cnt;
	          for (;;) {
	            cnt = ((InputStream)in).read(buf);
	            if (cnt == -1) {
	              break;
	            }
	            out.write(buf, 0, cnt);
	          }
	        } catch(Exception e) {
	          e.printStackTrace();
	        } finally {
	          if (in != null) {
	            ((InputStream)in).close();
	          }
	          if (out != null) {
	            out.close();
	          }
	        }
	        } catch (Exception e) {
	          e.printStackTrace();
	        }
      }

}
