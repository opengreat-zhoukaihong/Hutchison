package com.arena.universe.security.operator;

import net.line.fortress.apps.system.security.PermissionContext;
import net.line.fortress.apps.system.utils.ConversionUtil;

public class StrNotEndsWith implements BinaryOperator
{
	public boolean evaluate(Object actualValue, String comparedValue, PermissionContext context) {
		return (actualValue == null) || !((String)actualValue).endsWith(comparedValue);
	}
}
