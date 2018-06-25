package com.arena.universe.security.operator;

import java.util.*;
import net.line.fortress.apps.system.security.PermissionContext;
import net.line.fortress.apps.system.utils.ConversionUtil;

public class DteEqual implements BinaryOperator
{
  public boolean evaluate(Object actualValue, String comparedValue, PermissionContext context) {
    return actualValue != null &&
	   ((Calendar)actualValue).equals(ConversionUtil.str2Calendar(comparedValue));
  }
}
