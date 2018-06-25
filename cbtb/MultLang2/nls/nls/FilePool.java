package net.line.fortress.apps.system.nls;
import java.util.*;
import java.sql.Timestamp;
import java.io.*;
import java.util.zip.*;
import net.line.fortress.apps.system.LogManager;

public class FilePool extends ResourcePool{
  private static FilePool instance = null;
  private Hashtable pool = new Hashtable();
  private boolean init = false;
  private Date lastModified = null;
  private long timeout = 60000; //millisec
  private long lastAccess = 0;
  private String extension = "properties";

  public static FilePool getInstance() {
    if (instance == null)
        createInstance();
    return instance;
  }

  private static synchronized void createInstance() {
    if (instance == null)
      instance = new FilePool();
  }

  public void setTimeout(long millisec) {
    this.timeout = millisec;
  }

  public long getTimeout() {
    return this.timeout;
  }

  public Resource getResource(String name) {
      if (!init) {
        invalidateAllResources();
        init = true;
      }

      String resname = name + "." + this.extension;
      if (System.currentTimeMillis()-this.lastAccess>timeout) {
          this.lastAccess = System.currentTimeMillis();
          LogManager.instance.logInfo("FilePool.getResource(): over " + (this.timeout/60000) + " mins");
          Date modified = new FileSystemLoader().getLastModified();
          if (this.lastModified.compareTo(modified)!= 0) {
            invalidateAllResources();
          }
      }

      if (!pool.containsKey(resname))
        return null;
      else
        return (Resource)pool.get(resname);
  }

  public void invalidateResource(String name) {
      LogManager.instance.logInfo("FilePool.invalidateResource: name[" + name + "]");
      //remove the element from the pool
      FileSystemLoader filesystem = new FileSystemLoader();
      instance.lastAccess = System.currentTimeMillis();
      instance.lastModified = filesystem.getLastModified();
      this.pool.remove(name);
      Resource res = filesystem.getFile(name);
      if (res != null)
        this.pool.put(name, res);
  }

  public void invalidateAllResources() {
      LogManager.instance.logInfo("FilePool.invalidateAllResources: begin");
      FileSystemLoader filesystem = new FileSystemLoader();
      instance.lastAccess = System.currentTimeMillis();
      instance.lastModified = filesystem.getLastModified();
      pool.clear();
      this.pool = filesystem.getFiles();
  }

  public void setExtension(String extension) {
    this.extension = extension;
  }

  public String getExtension() {
    return this.extension;
  }

}

