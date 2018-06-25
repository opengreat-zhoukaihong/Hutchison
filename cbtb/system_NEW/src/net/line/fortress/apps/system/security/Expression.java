package net.line.fortress.apps.system.security;

public class Expression implements java.io.Serializable {
  private String attributeName;
  private String operatorClassName;
  private String attributeValue;

  public Expression(String attributeName,
                    String operatorClassName,
                    String attributeValue) {
    this.attributeName = attributeName;
    this.operatorClassName = operatorClassName;
    this.attributeValue = attributeValue;
  }

  public String getAttributeName() {
    return this.attributeName;
  }

  public String getOperatorClassName() {
    return this.operatorClassName;
  }

  public String getAttributeValue() {
    return this.attributeValue;
  }

  public void cleanup() {
    this.attributeName = null;
    this.operatorClassName = null;
    this.attributeValue = null;
  }

  public String toString() {
    return "evaluating: <" + attributeName + "> " + operatorClassName +" <"+ attributeValue + ">";
  }
}