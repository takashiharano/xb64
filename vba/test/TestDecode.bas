Option Explicit

Public Sub DecodeTest()
    Debug.Print "Decode Test"
    Call DoTest("", "", "")
    Call DoTest("", "x", "")
    Call DoTest("abc", "", "YWJj")
    Call DoTest("abc", "x", "GRobAA==")
    Call DoTest("abc", "xyz", "GRsZAA==")
    Call DoTest("abc", "xyz1", "GRsZzgE=")
    Call DoTest("a", "A2345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234#", "IM3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvc/g==")
    Call DoTest("あいう", "", "44GC44GE44GG")
    Call DoTest("あいう", "x", "m/n6m/n8m/n+AA==")
    Call DoTest("あいう", "xyz", "m/j4m/j+m/j8AA==")
    Call DoTest("あいう", "xyz123456a", "m/j40rO317SwngE=")
    Debug.Print ""
End Sub

Private Sub DoTest(exp As String, key As String, b64 As String)
    Dim r As String
    r = XB64.DecodeString(b64, key)
    Dim res As String
    Dim status As String
    status = "NG"
    If r = exp Then
        status = "OK"
    End If
    res = "[" & status & "] """ & b64 & """ -> """ & r & """"
    Debug.Print res
End Sub
