Option Explicit

Public Sub DecodeTest()
    Debug.Print "Decode Test"
    Call DoTest("abc", "xyz", "GRsZ")
    Call DoTest("ab", "xyz", "GRs=")
    Call DoTest("", "xyz", "")
    Call DoTest("abc", "", "YWJj")
    Call DoTest("", "", "")
    Call DoTest("abc", "x", "GRob")
    Call DoTest("a", "A2345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234#", "IA==")
    Call DoTest("あいう", "", "44GC44GE44GG")
    Call DoTest("あいう", "x", "m/n6m/n8m/n+")
    Call DoTest("あいう", "xyz", "m/j4m/j+m/j8")
    Call DoTest("あいう", "xyz123456a", "m/j40rO317Sw")
    Debug.Print ""
End Sub

Private Sub DoTest(exp As String, key As String, b64 As String)
    Dim r As String
    r = XB64.DecodeString(b64, key)
    Dim res As String
    Dim status As String
    status = "FAIL"
    If r = exp Then
        status = "PASS"
    End If
    res = "[" & status & "] """ & b64 & """ -> """ & r & """"
    Debug.Print res
End Sub
