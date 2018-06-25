package com.arena.universe.security.operator;

import java.util.*;
import net.line.fortress.apps.system.security.PermissionContext;
import net.line.fortress.apps.system.utils.ConversionUtil;

public class UsrNotIn implements BinaryOperator
{
	public boolean evaluate(Object actualValue, String comparedValue, PermissionContext context) {
		Vector list = null;
		if (comparedValue != null) {
			list = ConversionUtil.csvStr2Vector(comparedValue);
		} else {
			return false;
		}
		return actualValue == null || !list.contains((String)actualValue);
	}
}
