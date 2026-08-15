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
    test(null, "", (String) null);
    test(null, null, (String) null);
    test("", null, "");
    test("YWJj", null, "abc");
    test("", "", "");
    test("", "x", "");
    test("YWJj", "", "abc");
    test("GRobAA==", "x", "abc");
    test("GRsZAA==", "xyz", "abc");
    test("GRsZzgE=", "xyz1", "abc");
    test("IM3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvc/g==", "A2345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234#", "a");
    test("XX==", "x", "");
  }

  private static void decodeTestJa() {
    test("44GC44GE44GG", "", "あいう");
    test("m/n6m/n8m/n+AA==", "x", "あいう");
    test("m/j4m/j+m/j8AA==", "xyz", "あいう");
    test("m/j40rO317SwngE=", "xyz123456a", "あいう");
  }

  private static void decodeBytesTest() {
    byte[] exp = { (byte) 0x61, (byte) 0x62, (byte) 0x63 };
    test("YWJj", "", exp);
    test("GRobAA==", "x", exp);
    test("GRsZAA==", "xyz", exp);
    test("GRsZzgE=", "xyz1", exp);
  }

  private static void test(String s, String k, String expected) {
    String r = XB64.decodeToString(s, k);
    assertEquals(k, expected, r);
  }

  private static void test(String s, String k, byte[] expected) {
    byte[] r = XB64.decode(s, k);
    Log.out("k=" + k);
    for (int i = 0; i < r.length; i++) {
      Log.out("EXP=" + expected[i] + " : ACTUAL=" + r[i]);
    }
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
    Log.out("[" + (ok ? "OK" : "NG") + "] " + message + ("".equals(message) ? "" : ": ") + "EXP=" + strExpected + " " + op + " ACTUAL=" + strActual);
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
