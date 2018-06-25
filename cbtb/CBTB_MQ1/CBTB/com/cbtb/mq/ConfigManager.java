package com.cbtb.mq;

/**
 * Title:  ConfigManager For get properties from system.props<br>
 * Description:<br>
 * Copyright:    Copyright (c) 2001<br>
 * Company:   HutchTech<br>
 * @author Henry Mei
 * @version 1.0
 */

import java.io.*;
import java.util.*;

public class ConfigManager {
  private static ConfigManager instance = null;
  private Properties properties = null;

  public static ConfigManager getInstance() {
    if (instance == null) {
      instance = initInstance();
    }
    return instance;
  }

  private static synchronized ConfigManager initInstance() {
    if (instance != null) {
      return instance;
    }
    return new ConfigManager();
  }

  private ConfigManager() {
    Properties p = new Properties();
    InputStream in = this.getClass().getResourceAsStream("/system.props");
    try {
      p.load(in);
    } catch (Exception e) {
      System.out.println("Cannot load /system.props");
      e.printStackTrace();
    } finally {
      try {
        if (in != null) in.close();
      } catch (Exception e) {}
    }
    this.properties = p;
  }

  public String getProperty(String key) {
    return this.properties.getProperty(key);
  }

  public String getProperty(String key, String def) {
    return this.properties.getProperty(key, def);
  }

  public Enumeration propertyNames() {
     return this.properties.propertyNames();
  }
}