package com.cbtb.mq;

import java.io.*;
import java.text.*;
import java.util.*;
import java.util.Date;
import java.sql.*;
//import net.line.fortress.apps.system.security.*;

/**This is MQ log maganger set and configration */
public class LogManager {

  public static int DEBUG         = 0;
  public static int INFO          = 1;
  public static int NOTICE        = 2;
  public static int WARNING       = 3;
  public static int ERROR         = 4;
  public static int FATAL_ERROR   = 5;

  public static int MIN_LEVEL     = 0;
  public static int MAX_LEVEL     = 5;

  public static int DAILY         = 0;
  public static int HOURLY        = 1;

  private static String[] LEVEL_DESC = {
      "<D>",
      "<I>",
      "<N>",
      "<W>",
      "<E>",
      "<F>",
  };

  private PrintWriter out;
  private int level = DEBUG;
  private DateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
  private boolean needToCloseOutput = false;
  private String directory = ".";
  private String filePrefix = "";
  private String fileSuffix = ".log";
  private int frequency = DAILY;
  private int daysRetained;
  private SimpleDateFormat df;
  private String oldFilename;
  private String systemName;

  // --- Start of Singleton Pattern ----------------------- //

  public static final LogManager instance = new LogManager();

  protected LogManager() {
    ConfigManager configMgr = ConfigManager.getInstance();
    setSystemName(configMgr.getProperty("com.cbtb.system.name"));
    String output       = configMgr.getProperty("com.cbtb.system.log.output", "stdout");
    String filename     = configMgr.getProperty("com.cbtb.system.log.filename");
    String directory    = configMgr.getProperty("com.cbtb.system.log.directory", ".");
    String prefix       = configMgr.getProperty("com.cbtb.system.log.filename.prefix");
    String suffix       = configMgr.getProperty("com.cbtb.system.log.filename.suffix", ".log");
    String frequency    = configMgr.getProperty("com.cbtb.system.log.frequency", "daily");
    String level        = configMgr.getProperty("com.cbtb.system.log.level", "debug");
    String daysRetained = configMgr.getProperty("com.cbtb.system.log.days.retained", "7");
    if (output.equals("stdout")) {
      this.setOutput(System.out);
    } else if (output.equals("stderr")) {
      this.setOutput(System.err);
    } else if (output.equals("none")) {
      this.setOutput((OutputStream)null);
    } else if (output.equals("fixedFile")) {
      this.setOutput("", filename);
    } else if (output.equals("recyclingFile")) {
      this.setOutput(directory,
                     prefix,
                     suffix,
                     frequency.equals("hourly") ? HOURLY : DAILY,
                     Integer.parseInt(daysRetained));
    }
    this.setLevel(level);
  }

  // --- End of Singleton Pattern ------------------------- //
/*
  public static synchronized void initialize() {
    if (instance == null) {
      instance = new LogManager();
      ConfigManager configMgr = ConfigManager.getInstance();
      instance.setSystemName(configMgr.getProperty("net.line.system.name"));
      String output       = configMgr.getProperty("net.line.system.log.output", "stdout");
      String filename     = configMgr.getProperty("net.line.system.log.filename");
      String directory    = configMgr.getProperty("net.line.system.log.directory", ".");
      String prefix       = configMgr.getProperty("net.line.system.log.filename.prefix");
      String suffix       = configMgr.getProperty("net.line.system.log.filename.suffix", ".log");
      String frequency    = configMgr.getProperty("net.line.system.log.frequency", "daily");
      String level        = configMgr.getProperty("net.line.system.log.level", "debug");
      String daysRetained = configMgr.getProperty("net.line.system.log.days.retained", "7");
      if (output.equals("stdout")) {
        instance.setOutput(System.out);
      } else if (output.equals("stderr")) {
        instance.setOutput(System.err);
      } else if (output.equals("none")) {
        instance.setOutput((OutputStream)null);
      } else if (output.equals("fixedFile")) {
        instance.setOutput("", filename);
      } else if (output.equals("recyclingFile")) {
        instance.setOutput(directory,
                           prefix,
                           suffix,
                           frequency.equals("hourly") ? HOURLY : DAILY,
                           Integer.parseInt(daysRetained));
      }
      instance.setLevel(level);
    }
  }
*/
  private synchronized void setOutput(String directory,
                                      String filePrefix,
                                      String fileSuffix,
                                      int frequency,
                                      int daysRetained) {
    this.directory = directory;
    this.filePrefix = filePrefix;
    this.fileSuffix = fileSuffix;
    this.frequency =
      (frequency != DAILY && frequency != HOURLY) ? DAILY : frequency;
    if (this.frequency == DAILY) {
      this.df = new SimpleDateFormat("yyyy-MM-dd");
    } else {
      this.df = new SimpleDateFormat("yyyy-MM-dd-HH");
    }
    this.daysRetained = daysRetained;
    recycleOutput();
  }

  private synchronized void setOutput(String directory, String filename) {
    String qualifiedFilename = directory.equals("") ? filename : directory + File.separator + filename;
    logDebug("log filename <" + qualifiedFilename + ">");
    PrintWriter newOutput = null;
    try {
      newOutput = new PrintWriter(new FileOutputStream(qualifiedFilename, true));
    } catch (IOException e) {
      logError("LogManager: failed to open file " + filename, e);
      return;
    }
    if (out != null && needToCloseOutput) {
      logInfo("LogManager: output closed and switched to " + filename);
      out.close();
    }
    out = newOutput;
    needToCloseOutput = true;
    logInfo("LogManager: started with output to " + filename);
  }

  public synchronized void recycleOutput() {
    String filename = filePrefix + "-" + df.format(new Date()) + fileSuffix;
    if (!filename.equals(oldFilename)) {
      setOutput(directory, filename);
      oldFilename = filename;
    }
    //housekeepOutput();
  }

  public void housekeepOutput() {
    Calendar comparedDate = Calendar.getInstance();
    comparedDate.add(Calendar.DATE, -daysRetained);
    //logDebug("comparedDate: " + comparedDate.get(Calendar.YEAR) + " " + comparedDate.get(Calendar.MONTH) + " " + comparedDate.get(Calendar.DATE));
    String[] logFileList = (new File(directory)).list();
    Calendar fileDate = Calendar.getInstance();
    File fileDeleted;
    String fileTime;
    for (int i = 0; i < logFileList.length; i++) {
      //logDebug("Examining log file <" + logFileList[i] + ">");
      if (logFileList[i].startsWith(filePrefix) && logFileList[i].endsWith(fileSuffix)) {
        try {
          fileTime = logFileList[i].substring(filePrefix.length() + 1, logFileList[i].length() - fileSuffix.length());
          //logDebug("fileDate: " + fileTime);
          fileDate.setTime(df.parse(fileTime, new ParsePosition(0)));
          //logDebug("fileDate: " + fileDate.get(Calendar.YEAR) + " " + fileDate.get(Calendar.MONTH) + " " + fileDate.get(Calendar.DATE));
          if (fileDate.before(comparedDate)) {
            fileDeleted = new File(directory, logFileList[i]);
            if (fileDeleted.exists()) {
              if (fileDeleted.delete()) {
                logInfo("LogManager: log file <" + logFileList[i] + "> is deleted.");
              } else {
                logInfo("LogManager: unable to delete log file <" + logFileList[i] + ">.");
              }
            } else {
              logInfo("LogManager: log file <" + logFileList[i] + "> cannot be found.");
            }
          } else {
            //logDebug("keep this log file");
          }
                          } catch (Exception e) {
                                  logError("Unable to examine log file <" + logFileList[i] + ">", e);
                          }
                  } else {
                          //logDebug("it is not a log file");
                  }
          }
  }

  public synchronized void setOutput(OutputStream os) {
      if (out != null && needToCloseOutput) {
          logInfo("LogManager: output closed.");
          out.close();
          out = null;
      }
      if (os == null) {
          out = null;
          return;
      }
      out = new PrintWriter(os);
      needToCloseOutput = false;
      logInfo(
          "LogManager: started with output as " +
              ((os == System.out) ?
                  "System.out" : "OutputStream " + os.toString()));
  }

  public synchronized void setOutput(PrintWriter writer) {
      if (out != null && needToCloseOutput) {
          logInfo("LogManager: output closed.");
          out.close();
          out = null;
      }
      if (writer == null) {
          out = null;
          return;
      }
      out = writer;
      needToCloseOutput = false;
      logInfo("LogManager: started with output as PrintWriter " +
          writer.toString());
  }

  public synchronized void close() {
      logInfo("LogManager: requested to be closed down.");
      if (out != null && needToCloseOutput) {
          out.close();
          out = null;
      }
  }

  /**
     Specifies the level of the messages to be logged.
   */
  public void setLevel(int level) {
      this.level = level;
  }

  public void setLevel(String level) {
      if ("debug".equalsIgnoreCase(level)              || String.valueOf(DEBUG).equals(level)) {
          this.level = DEBUG;
      } else if ("info".equalsIgnoreCase(level)        || String.valueOf(INFO).equals(level)) {
          this.level = INFO;
      } else if ("notice".equalsIgnoreCase(level)      || String.valueOf(NOTICE).equals(level)) {
          this.level = NOTICE;
      } else if ("warning".equalsIgnoreCase(level)     || String.valueOf(WARNING).equals(level)) {
          this.level = WARNING;
      } else if ("error".equalsIgnoreCase(level)       || String.valueOf(ERROR).equals(level)) {
          this.level = ERROR;
      } else if ("fatal_error".equalsIgnoreCase(level) || String.valueOf(FATAL_ERROR).equals(level)) {
          this.level = FATAL_ERROR;
      } else {
          LogManager.instance.logWarning(
              "LogManager: invalid log level = " + level + " specified; assumed to be DEBUG.");
          this.level = DEBUG;
      }
  }

  /**
     Returns the current logging level.
     @return  the current logging level.
   */
  public int getLevel() {
      return this.level;
  }

  public void setSystemName(String s) {
          this.systemName = s;
  }

  public String getSystemName() {
          return this.systemName;
  }

  /**
     Logs a message with the specified log level and associated
     exception.
     @param   logLevel the level of the message.
     @param   msg the message string.
     @param   e an optional exception associated with the message.
   */
  public void log(int logLevel, String msg, Exception e) {
      String line;

      if (out == null || this.level > logLevel) {
          return;
      }

      logLevel = logLevel < MIN_LEVEL ? MIN_LEVEL : logLevel;
      logLevel = logLevel > MAX_LEVEL ? MAX_LEVEL : logLevel;

      synchronized(this) {

          line = "# " + dateFormat.format(new Date()) + ((systemName != null)? " [" + systemName + "] ": " ")
                         + LEVEL_DESC[logLevel] + " " + msg;
          out.println(line);
          if (e != null) {
              e.printStackTrace(out);
          }
          out.flush();
      }

  }

  /**
     Logs a debug message with an exception.
     @param  msg the message string
     @param  e the exception.
   */
   /*
  public void logUserDebug(User user, String msg, Exception e) {
          if (user == null) {
          log(DEBUG, "<null> : " + msg, e);
          } else {
                  log(DEBUG, "<" + user.getDomainID() + "/" + user.getUserID() + "> : " + msg, e);
          }
  }
*/
  /**
      Logs a debug message without an exception.
      @param  msg the message string
      @param  e the excetpion.
   */
  /*
  public void logUserDebug(User user, String msg) {
          if (user == null) {
          log(DEBUG, "<null> : " + msg, null);
          } else {
                  log(DEBUG, "<" + user.getDomainID() + "/" + user.getUserID() + "> : " + msg, null);
          }
  }
*/
  /**
     Logs a debug message with an exception.
     @param  msg the message string
     @param  e the exception.
   */
  public void logDebug(String msg, Exception e) {
      log(DEBUG, msg, e);
  }

  /**
      Logs a debug message without an exception.
      @param  msg the message string
      @param  e the excetpion.
   */
  public void logDebug(String msg) {
      log(DEBUG, msg, null);
  }

  /**
      Logs an info message with an exception.
      @param  msg the message string
      @param  e the excetpion.
   */
  public void logInfo(String msg, Exception e) {
      log(INFO, msg, e);
  }

  /**
      Logs an info message without an exception.
      @param  msg the message string
      @param  e the excetpion.
   */
  public void logInfo(String msg) {
      log(INFO, msg, null);
  }

  /**
      Logs a notice message with an exception.
      @param  msg the message string
      @param  e the excetpion.
   */
  public void logNotice(String msg, Exception e) {
      log(NOTICE, msg, e);
  }

  /**
      Logs a notice message without an exception.
      @param  msg the message string
      @param  e the excetpion.
   */
  public void logNotice(String msg) {
      log(NOTICE, msg, null);
  }

  /**
      Logs a warning message with an exception.
      @param  msg the message string
      @param  e the excetpion.
   */
  public void logWarning(String msg, Exception e) {
      log(WARNING, msg, e);
  }

  /**
      Logs a warning message without an exception.
      @param  msg the message string
      @param  e the excetpion.
   */
  public void logWarning(String msg) {
      log(WARNING, msg, null);
  }

  /**
      Logs an error message with an exception.
      @param  msg the message string
      @param  e the excetpion.
   */
  public void logError(String msg, Exception e) {
      log(ERROR, msg, e);
  }

  /**
      Logs an error message without an exception.
      @param  msg the message string
      @param  e the excetpion.
   */
  public void logError(String msg) {
      log(ERROR, msg, null);
  }

  /**
      Logs a fatal error message with an exception.
      @param  msg the message string
      @param  e the excetpion.
   */
  public void logFatalError(String msg, Exception e) {
      log(FATAL_ERROR, msg, e);
  }

  /**
      Logs a fatal error message without an exception.
      @param  msg the message string
      @param  e the excetpion.
   */
  public void logFatalError(String msg) {
      log(FATAL_ERROR, msg, null);
  }
}