package net.line.fortress.apps.system.util;

/**
 * Title:
 * Description:
 * Copyright:    Copyright (c) 2001
 * Company:
 * @author
 * @version 1.0
 */
import java.util.Calendar;
import java.util.Random;

public class UniqueNumberGenerator {
  Random random = new Random();
  private static int i = 0;

  public UniqueNumberGenerator() {
  }

  public synchronized String generateRandomNumber()  {
//      return Integer.toString(++i);
//        return Long.toString(Calendar.getInstance().getTime().getTime()) ;// + "_" + Long.toString(random.nextLong());
        return  Long.toString(random.nextLong());
  }

  public synchronized String generateTimeNumber()  {
//      return Integer.toString(++i);
        return Long.toString(Calendar.getInstance().getTime().getTime());
        //        return  Long.toString(random.nextLong());
  }


}