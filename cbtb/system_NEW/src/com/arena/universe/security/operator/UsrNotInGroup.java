package com.arena.universe.security.operator;

import java.util.*;
import net.line.fortress.apps.system.security.PermissionContext;
import net.line.fortress.apps.system.utils.ConversionUtil;

public class UsrNotInGroup implements BinaryOperator
{
	public boolean evaluate(Object actualValue, String comparedValue, PermissionContext context) {
		Vector group = null;
		if (comparedValue != null) {
			group = (Vector)context.getAllGroups().get(comparedValue);
		} else {
			return false;
		}
		return group == null || !group.contains((String)actualValue);
	}
}
