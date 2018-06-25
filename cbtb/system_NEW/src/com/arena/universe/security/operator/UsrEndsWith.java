package com.arena.universe.security.operator;

import net.line.fortress.apps.system.security.PermissionContext;
import net.line.fortress.apps.system.utils.ConversionUtil;

public class UsrEndsWith  implements BinaryOperator
{
	public boolean evaluate(Object actualValue, String comparedValue, PermissionContext context) {
		String temp = null;
		if (comparedValue != null) {
			if (comparedValue.equals("_USER_")) {
				temp = context.getUserID();
			} else {
				temp = comparedValue;
			}
		}
		return (actualValue != null) && ((String)actualValue).endsWith(temp);
	}
}
