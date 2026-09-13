. "..\xb64.ps1"

$TEST_DATA = @(
    @{ Src = "";       Key = "";             B64 = "" }
    @{ Src = "";       Key = "x";            B64 = "" }
    @{ Src = "";       Key = $null;           B64 = "" }
    @{ Src = "abc";    Key = "";             B64 = "YWJj" }
    @{ Src = "abc";    Key = $null;           B64 = "YWJj" }
    @{ Src = "abc";    Key = "x";            B64 = "GRob" }
    @{ Src = "abc";    Key = "xyz";          B64 = "GRsZ" }
    @{ Src = "abc";    Key = "xyz1";         B64 = "GRsZ" }
    @{
        Src = "a"
        Key = "A2345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234#"
        B64 = "IA=="
    }
    @{ Src = "‚ ‚¢‚¤"; Key = "";             B64 = "44GC44GE44GG" }
    @{ Src = "‚ ‚¢‚¤"; Key = "x";            B64 = "m/n6m/n8m/n+" }
    @{ Src = "‚ ‚¢‚¤"; Key = "xyz";          B64 = "m/j4m/j+m/j8" }
    @{ Src = "‚ ‚¢‚¤"; Key = "xyz123456a";   B64 = "m/j40rO317Sw" }
)

function Test-Encoding {
    Param (
        $Src,
        $Key,
        $Expected
    )

    $got = Get-XB64EncodedString $Src $Key
    $status = if ($got -eq $Expected) { "PASS" } else { "FAIL" }

    Write-Host "[$status] src=`"$Src`" key=`"$Key`" exp=`"$Expected`" got=`"$got`""

    return ($got -eq $Expected)
}

function Test-Decoding {
    Param (
        $Src,
        $Key,
        $B64
    )

    $got = Get-XB64DecodedString $B64 $Key
    $status = if ($got -eq $Src) { "PASS" } else { "FAIL" }

    Write-Host "[$status] src=`"$Src`" key=`"$Key`" b64=`"$B64`" got=`"$got`""

    return ($got -eq $Src)
}

$passed = 0
$total = 0

Write-Host "Encoding"
foreach ($t in $TEST_DATA) {
    if (Test-Encoding $t.Src $t.Key $t.B64) {
        $passed++
    }
    $total++
}

Write-Host ""
Write-Host "Decoding"
foreach ($t in $TEST_DATA) {
    if (Test-Decoding $t.Src $t.Key $t.B64) {
        $passed++
    }
    $total++
}

Write-Host ""
Write-Host "$passed/$total tests passed"
