package com.arena.universe.security.operator;

public interface BinaryOperator
{
  public boolean evaluate(Object actualValue,
    String comparedValue,
    net.line.fortress.apps.system.security.PermissionContext context);
}
