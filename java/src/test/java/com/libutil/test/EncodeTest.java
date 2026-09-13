package com.libutil.test;

import com.libutil.XB64;

public class EncodeTest {

  public static void main(String args[]) {
    encodeTest();
    Log.out("----");
    encodeTestJa();
    Log.out("----");
    encodeBytesTest();
  }

  private static void encodeTest() {
    test("", null, "");
    test("abc", null, "YWJj");
    test("", "", "");
    test("", "x", "");
    test("abc", "", "YWJj");
    test("abc", "x", "GRob");
    test("abc", "xyz", "GRsZ");
    test("abc", "xyz1", "GRsZ");
    test("a", "A2345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234#", "IA==");
  }

  private static void encodeTestJa() {
    test("あいう", "", "44GC44GE44GG");
    test("あいう", "x", "m/n6m/n8m/n+");
    test("あいう", "xyz", "m/j4m/j+m/j8");
    test("あいう", "xyz123456a", "m/j40rO317Sw");
  }

  private static void encodeBytesTest() {
    byte[] b = { (byte) 0x61, (byte) 0x62, (byte) 0x63 };
    test(b, "", "YWJj");
    test(b, "x", "GRob");
    test(b, "xyz", "GRsZ");
    test(b, "xyz1", "GRsZ");
  }

  private static void test(String s, String key, String expected) {
    String r = XB64.encode(s, key);
    assertEquals(key, expected, r);
  }

  private static void test(byte[] b, String key, String expected) {
    String r = XB64.encode(b, key);
    assertEquals(key, expected, r);
  }

  public static boolean assertEquals(Object expected, Object actual) {
    return assertEquals("", expected, actual);
  }

  public static boolean assertEquals(String message, Object expected, Object actual) {
    boolean ok = false;
    String op = "!=";
    String strExpected = "" + expected;
    String strActual = "" + actual;
    if (equals(strExpected, strActual)) {
      ok = true;
      op = "==";
    }
    Log.out("[" + (ok ? "PASS" : "FAIL") + "] " + message + ("".equals(message) ? "" : ": ") + "EXP=" + strExpected + " " + op + " ACTUAL=" + strActual);
    return ok;
  }

  public static boolean equals(String s1, String s2) {
    if ((s1 == null) && (s2 == null)) {
      return true;
    }
    if (s1 == null) {
      return false;
    }
    return s1.equals(s2);
  }

}
