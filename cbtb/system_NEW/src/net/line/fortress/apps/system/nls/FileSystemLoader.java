package net.line.fortress.apps.system.nls;

import java.util.*;
import java.sql.Timestamp;
import java.io.*;
import java.util.zip.*;
import net.line.fortress.apps.system.*;

public class FileSystemLoader {
  private String source = ""; //  D:\\weblogic\\myserver\\nls.jar

  public FileSystemLoader() {
      this.source = ConfigManager.getInstance().getProperty("net.line.system.nls.source");
      if (this.source == null)
        this.source = "D:\\weblogic\\myserver\\nls.jar";
      LogManager.instance.logInfo("FileSystemLoader: begin source[" + this.source + "]");
  }

  public Resource getFile(String name) {
      ZipFile zipfile = null;
      ZipEntry zipentry = null;
      InputStream in = null;
      Properties props = null;
      Resource res = null;
      try {
        zipfile = new ZipFile(this.source);
        zipentry = zipfile.getEntry(name);
        in = zipfile.getInputStream(zipentry);
        props = new Properties();
        props.load(in);
        return new Resource(props);

      } catch (IOException e1) {
          LogManager.instance.logInfo("FileSystemLoader.getFile(): Unable to load the file[" + name + "]");
      } finally {
          if (zipfile!=null) {
            try {
              zipfile.close();
            } catch (IOException e){
              LogManager.instance.logInfo("FileSystemLoader.getFile(): " + e.getMessage());
            }
          }
          try {
            in.close();
          } catch (Exception e) {
              LogManager.instance.logInfo("FileSystemLoader.getFile(): " + e.getMessage());
          }
      }
      return null;
  }

  public Hashtable getFiles() {
      LogManager.instance.logInfo("FileSystemLoader.getFiles(): begin source[" + this.source + "]");

      ZipFile zipfile = null;
      ZipEntry zipentry = null;
      InputStream in = null;
      Properties props = null;
      Resource res = null;
      Hashtable files = new Hashtable();
      try {
        //clear the pool
        zipfile = new ZipFile(this.source);
        for (java.util.Enumeration e = zipfile.entries(); e.hasMoreElements();) {
            zipentry = (ZipEntry) e.nextElement();
            LogManager.instance.logInfo("FileSystemLoader.getFiles(): entry.name="+ zipentry.getName());
            in = zipfile.getInputStream(zipentry);
            props = new Properties();
            props.load(in);
            res = new Resource(props);
            files.put(zipentry.getName(),res);
        }

        return files;

      } catch (IOException e) {
          LogManager.instance.logInfo("FileSystemLoader.getFiles(): file[" + this.source +"] is not found");
      } finally {
          if (zipfile!=null) {
            try {
              zipfile.close();
            } catch (IOException e){
              LogManager.instance.logInfo("FileSystemLoader.getFiles(): " + e.getMessage());
            }
          }
          try {
            in.close();
          } catch (Exception e) {
              LogManager.instance.logInfo("FileSystemLoader.getFiles(): " + e.getMessage());
          }
      }
      return null;
  }

  public Date getLastModified() {
    return new Date(new File(this.source).lastModified());
  }

  public void setSource(String source) {
    this.source = source;
  }

  public String getSource() {
    return this.source;
  }
}
