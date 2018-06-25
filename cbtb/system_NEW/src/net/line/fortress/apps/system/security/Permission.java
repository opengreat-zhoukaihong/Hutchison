package net.line.fortress.apps.system.security;

import java.util.*;

public class Permission implements java.io.Serializable {
  private String permissionType;
  private Vector expression;

  public Permission(String permissionType) {
    this.permissionType = permissionType;
    this.expression = new Vector(20);
  }

  public String getPermissionType() {
    return this.permissionType;
  }

  public Vector getExpression() {
    return this.expression;
  }

  public void cleanup() {
    permissionType = null;
    if (expression != null) {
      for (Enumeration e = expression.elements(); e.hasMoreElements();) {
        ((Expression)e.nextElement()).cleanup();
      }
      expression.removeAllElements();
    }
    expression = null;
  }

  public String toString() {
    StringBuffer s = new StringBuffer("Permission include:\n");
    for (Enumeration e = expression.elements(); e.hasMoreElements();) {
      s.append(e.nextElement()).append("\n");
    }
    s.append("that's all\n");
    return s.toString();
  }
}