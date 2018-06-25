package com.arena.universe.security.operator;

import java.util.*;
import net.line.fortress.apps.system.security.PermissionContext;
import net.line.fortress.apps.system.utils.ConversionUtil;

public class StrNotIn implements BinaryOperator
{
	public boolean evaluate(Object actualValue, String comparedValue, PermissionContext context) {
		Vector list = null;
		if (comparedValue == null) {
			return true;
		} else {
			list = ConversionUtil.csvStr2Vector(comparedValue);
		}
		return actualValue == null || !list.contains((String)actualValue);
	}
}
