# XB64 - XORed Base64
#
# The MIT License
#
# Copyright 2023 Takashi Harano
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#------------------------------------------------------------------------------
# Usage:
# . ".\xb64.ps1"
#
# [Encode]
#  String:
#   $s = Get-XB64EncodedString "<STRING>" "<KEY>"
#
#  Byte[]:
#   [byte[]]$b = Get-Content "C:\test\file.bin" -Encoding Byte
#   $s = Get-XB64EncodedString $b "<KEY>"
#
# [Decode]
#  String:
#   $s = Get-XB64DecodedString "<BASE64_STRING>" "<KEY>"
#
#  Byte[]:
#   $b = Get-XB64DecodedBytes "<BASE64_STRING>" "<KEY>"
#   Set-Content "C:\tmp\file.bin" -Value $b -Encoding Byte
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Byte array or plain text to Base64 encoded string with XORing source and key
#------------------------------------------------------------------------------
function Get-XB64EncodedString {
    Param (
        $Src,
        $Key
    )

    if ($Src.GetType().Name -eq "String") {
        $b = [System.Text.Encoding]::UTF8.GetBytes($Src)
    } else {
        $b = $Src
    }

    $kb = [System.Text.Encoding]::UTF8.GetBytes($Key)

    $buf = Get-EncodedBytes $b $kb
    $encoded = [System.Convert]::ToBase64String($buf)

    return $encoded
}

#------------------------------------------------------------------------------
# Base64 encoded string to Byte array with XORing source and key
#------------------------------------------------------------------------------
function Get-XB64DecodedBytes {
    Param (
        $Src,
        $Key
    )

    $buf = [System.Convert]::FromBase64String($Src)
    $kb = [System.Text.Encoding]::UTF8.GetBytes($Key)
    $arr = Get-DecodedBytes $buf $kb
    return $arr
}

#------------------------------------------------------------------------------
# Base64 encoded string to Plain text with XORing source and key
#------------------------------------------------------------------------------
function Get-XB64DecodedString {
    Param (
        $Src,
        $Key
    )

    $buf = Get-XB64DecodedBytes $Src $Key
    if ($buf -eq $null) {
        return ""
    }
    $str = [System.Text.Encoding]::UTF8.GetString($buf)
    return $str
}

#------------------------------------------------------------------------------
function Get-EncodedBytes {
    Param (
        [byte[]]$Src,
        [byte[]]$Key
    )

    if (($Src.Length -eq 0) -or ($Key.Length -eq 0)) {
        return $Src
    }

    $d = $Key.Length - $Src.Length
    if ($d -lt 0) {
        $d = 0
    }

    $buf = New-Object byte[] ($Src.Length + $d + 1)

    for ($i=0; $i -lt $Src.Length; $i++) {
        $buf[$i] = $Src[$i] -bxor $Key[$i % $Key.Length]
    }

    $j = $i
    for ($i=0; $i -lt $d; $i++) {
        $buf[$j] = (255 -bxor $Key[$j % $Key.Length])
        $j++
    }

    $buf[$j] = $d

    return $buf
}

#------------------------------------------------------------------------------
function Get-DecodedBytes {
    Param (
        [byte[]]$Src,
        [byte[]]$Key
    )

    if (($Src.Length -eq 0) -or ($Key.Length -eq 0)) {
        return $Src
    }

    $d = $Src[$Src.Length - 1]
    $len = $Src.Length - $d - 1
    if ($len -lt 0) {
        $len = 0
    }
    $buf = New-Object byte[] ($len)

    $j = 0
    for ($i=0; $i -lt $len; $i++) {
        $buf[$j] = $Src[$i] -bxor $Key[$j % $Key.Length]
        $j++;
    }

    return $buf
}
