. "..\xb64.ps1"

function Test-Encoding {
    Param (
        $Src,
        $Key
    )
    $s = Get-XB64EncodedString $Src $Key
    Write-Host $s
}

function Test-Decoding {
    Param (
        $B64,
        $Key
    )
    $s = Get-XB64DecodedString $B64 $Key
    $res = "`"" + $s + "`""
    Write-Host $res
}

Write-Host "-------------------------------"
Write-Host "Encode"
Write-Host "-------------------------------"
Test-Encoding "abc" ""
Test-Encoding "abc" "x"
Test-Encoding "abc" "xyz"
Test-Encoding "abc" "xyz1"
Test-Encoding "a" "A2345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234#"
Test-Encoding "‚ ‚¢‚¤" "x"
Test-Encoding "‚ ‚¢‚¤" "xyz"
Test-Encoding "‚ ‚¢‚¤" "xyz123456a"

Write-Host "-------------------------------"
Write-Host "Decode"
Write-Host "-------------------------------"
Test-Decoding "YWJj" ""
Test-Decoding "GRobAA==" "x"
Test-Decoding "GRsZAA==" "xyz"
Test-Decoding "GRsZzgE=" "xyz1"
Test-Decoding "IM3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvc/g==" "A2345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234#"
Test-Decoding "m/n6m/n8m/n+AA==" "x"
Test-Decoding "m/j4m/j+m/j8AA==" "xyz"
Test-Decoding "m/j40rO317SwngE=" "xyz123456a"


Write-Host "Incorrect:"
Test-Decoding "XX==" "x"

Write-Host "w/ Wrong key:"
Test-Decoding "GRsZAA==" "123"

Write-Host "-------------------------------"
[byte[]]$b = Get-Content "C:\test\img.jpg" -Encoding Byte
$s = Get-XB64EncodedString $b "xyz"
Write-Host $s

$b = Get-XB64DecodedBytes $s "xyz"
Set-Content "C:\tmp\img.jpg" -Value $b -Encoding Byte
