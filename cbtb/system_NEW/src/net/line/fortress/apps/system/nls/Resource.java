package net.line.fortress.apps.system.nls;

import java.util.*;
import java.io.*;
import net.line.fortress.apps.system.LogManager;

public class Resource {
  private Properties props = null;
  private long timestamp = 0;

  public Resource(Properties props) {
    this.props = props;
    this.timestamp = System.currentTimeMillis();
  }

  public Properties getProperties() {
      return this.props;
  }

  public void setProperties(Properties props) {
    this.props = props;
  }

  public void setTimestamp(long timestamp) {
    this.timestamp = timestamp;
  }

  public long getTimestamp() {
    return this.timestamp;
  }

  public String getProperty(String key) throws MissingResourceException {
      try {
        String result = this.props.getProperty(key);
        if (result==null)
            throw new MissingResourceException("Resource.getProperty(): Unable to get the key[" + key + "]");
        return result.trim();
      } catch (Exception e) {
          throw new MissingResourceException("Resource.getProperty():");
      }
  }
}
