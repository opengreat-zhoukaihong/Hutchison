package net.line.fortress.apps.system.nls;

import java.util.*;

abstract class ResourcePool {
  abstract Resource getResource(String name);
  abstract void invalidateAllResources();
  abstract void invalidateResource(String name);

}