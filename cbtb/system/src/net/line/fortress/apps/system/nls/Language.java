package net.line.fortress.apps.system.nls;

import java.util.*;

public class Language {
  public int counter;
  public ResourceBundle bundle;

  public Language(ResourceBundle rb){
    this.counter = 1;
    this.bundle = rb;
  }
}