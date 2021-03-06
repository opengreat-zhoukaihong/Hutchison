package net.line.fortress.apps.system.utils;

import java.util.*;
import java.text.*;
import java.security.*;

public class ConversionUtil {
  private final static SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
  static {
    formatter.setLenient(false);
  }

  private ConversionUtil() {
  }

  public static Vector csvStr2Vector(String csvStr) {
    Vector out = new Vector();
    if (csvStr != null) {
      StringTokenizer tokenizer = new StringTokenizer(csvStr, ",");
      while (tokenizer.hasMoreTokens()) {
        out.addElement(tokenizer.nextToken().trim());
      }
    }
    return out;
  }

  public static String vector2csvStr(Vector v) {
    if (v == null) {
      return null;
    }
    String str = "";
    boolean firstEntry = true;
    for (Enumeration e = v.elements(); e.hasMoreElements(); ) {
      if (firstEntry) {
        str += (String)e.nextElement();
        firstEntry = false;
      } else {
        str += "," + (String)e.nextElement();
      }
    }
    return str;
  }

  public static Calendar str2Calendar(String str) {
          Calendar calendar = Calendar.getInstance();
          calendar.setTime(formatter.parse(str, new ParsePosition(0)));
          return calendar;
  }

  public static synchronized String calendar2Str(Calendar calendar) {
          return formatter.format(calendar.getTime());
  }

  public static Calendar timestamp2Calendar(java.sql.Timestamp ts) {
          Calendar calendar = Calendar.getInstance();
          calendar.setTime(ts);
          return calendar;
  }

  public static java.sql.Timestamp calendar2Timestamp(Calendar calendar) {
          return new java.sql.Timestamp(calendar.getTime().getTime());
  }

  public static String timestamp2Str(java.sql.Timestamp ts, String formatString) {
          SimpleDateFormat formatter = new SimpleDateFormat(formatString);
          return formatter.format(ts);
  }

  public static java.sql.Timestamp str2Timestamp(String str, String formatString) {
          SimpleDateFormat formatter = new SimpleDateFormat(formatString);
          return new java.sql.Timestamp(formatter.parse(str, new ParsePosition(0)).getTime());
  }

  public static String bytes2HexString(byte bytes[]) {
          char[] hex = new char[bytes.length * 2];
          for (int i = 0; i < bytes.length; i++) {
                  char c;
                  c = (char)((bytes[i] >> 4) & 0xf);
                  if (c > 9) {
                          c = (char)((c - 10) + 'a');
                  } else {
                          c = (char)(c + '0');
                  }
                  hex[2 * i] = c;
                  c = (char)(bytes[i] & 0xf);
                  if (c > 9) {
                          c = (char)((c - 10) + 'a');
                  } else {
                          c = (char)(c + '0');
                  }
                  hex[2 * i + 1] = c;
          }
          return String.valueOf(hex);
  }

  public static byte[] HexString2bytes(String hexString) {
          byte bytes[] = new byte[hexString.length() / 2];
          char chars[] = new char[hexString.length()];
          hexString.getChars(0, hexString.length(), chars, 0);
          for (int i = 0; i < hexString.length() / 2; i++) {
                  char c= chars[i * 2];
                  if (c <= '9' && c >= '0') {
                          bytes[i] = (byte)((c - '0') << 4);
                  } else if (c <= 'f' && c >= 'a') {
                          bytes[i] = (byte)((c + 10 - 'a') << 4);
                  } else if (c <= 'F' && c >= 'A') {
                          bytes[i] = (byte)((c + 10 - 'A') << 4);
                  } else {
                          throw new NumberFormatException(hexString.substring(i * 2, 1 * 2 + 2));
                  }
                  c = chars[i * 2 + 1];
                  if (c <= '9' && c >= '0') {
                          bytes[i] = (byte)((c - '0') + bytes[i]);
                  } else if (c <= 'f' && c >= 'a') {
                          bytes[i] = (byte)((c + 10 - 'a') + bytes[i]);
                  } else if (c <= 'F' && c >= 'A') {
                          bytes[i] = (byte)((c + 10 - 'A') + bytes[i]);
                  } else {
                          throw new NumberFormatException(hexString.substring(i * 2, 1 * 2 + 2));
                  }
          }
          return bytes;
  }
}