package net.line.fortress.apps.system.utils.simpleQuery;

import java.util.*;
import java.io.*;

public class SimpleRecord implements Serializable {

  private List list = null;
  private Map map = null;

  public SimpleRecord() {
    list = new ArrayList();
    map = new HashMap();
  }

  public SimpleRecord(int size) {
    list = new ArrayList(size);
    map = new HashMap(size);
  }

  public Object get(int index) {
    return map.get((String)list.get(index - 1));
  }

  public Object get(String key) {
    return map.get(key);
  }

  public void set(int index, Object obj) {
    map.put(list.get(index - 1), obj);
  }

  public void set(String key, Object obj) {
    if (map.get(key) == null) {
      throw new IllegalArgumentException("No such column");
    }
    map.put(key, obj);
  }

  public void add(String key, Object obj) {
    list.add(key);
    map.put(key, obj);
  }
/*
  private void writeObject(ObjectOutputStream out) throws IOException {
    out.writeObject(list);
    out.writeObject(map);
  }

  private void readObject(ObjectInputStream in) throws IOException, ClassNotFoundException {
    list = (ArrayList)in.readObject();
    map = (HashMap)in.readObject();
  }
*/
}
