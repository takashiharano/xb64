package com.libutil.test;

import com.libutil.XB64;

public class DecodeTest {

  public static void main(String args[]) {
    decodeTest();
    Log.out("----");
    decodeTestJa();
    Log.out("----");
    decodeBytesTest();
  }

  private static void decodeTest() {
    test("", null, "");
    test("YWJj", null, "abc");
    test("", "", "");
    test("", "x", "");
    test("YWJj", "", "abc");
    test("GRob", "x", "abc");
    test("GRsZ", "xyz", "abc");
    test("GRsZ", "xyz1", "abc");
    test("IA==", "A2345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234#", "a");
  }

  private static void decodeTestJa() {
    test("44GC44GE44GG", "", "あいう");
    test("m/n6m/n8m/n+", "x", "あいう");
    test("m/j4m/j+m/j8", "xyz", "あいう");
    test("m/j40rO317Sw", "xyz123456a", "あいう");
  }

  private static void decodeBytesTest() {
    byte[] exp = { (byte) 0x61, (byte) 0x62, (byte) 0x63 };

    test("YWJj", "", exp);
    test("GRob", "x", exp);
    test("GRsZ", "xyz", exp);
    test("GRsZ", "xyz1", exp);
  }

  private static void test(String s, String key, String expected) {
    String r = XB64.decodeToString(s, key);
    assertEquals("b64=\"" + s + "\" key=\"" + key + "\"", expected, r);
  }

  private static void test(String s, String key, byte[] expected) {
    byte[] r = XB64.decode(s, key);
    assertEquals("b64=\"" + s + "\" key=\"" + key + "\"", expected, r);
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

  public static boolean assertEquals(String message, byte[] expected, byte[] actual) {
    boolean ok = true;

    if ((expected == null) || (actual == null)) {
      ok = (expected == actual);
    } else if (expected.length != actual.length) {
      ok = false;
    } else {
      for (int i = 0; i < expected.length; i++) {
        if (expected[i] != actual[i]) {
          ok = false;
          break;
        }
      }
    }

    Log.out("[" + (ok ? "PASS" : "FAIL") + "] " + message);
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
