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

    if ($null -eq $Key) {
        $Key = ""
    }

    if ($Src -is [string]) {
        [byte[]]$b = [System.Text.Encoding]::UTF8.GetBytes($Src)
    } else {
        [byte[]]$b = $Src
    }

    [byte[]]$kb = [System.Text.Encoding]::UTF8.GetBytes($Key)
    [byte[]]$buf = @(Get-XorBytes $b $kb)

    return [System.Convert]::ToBase64String($buf)
}

#------------------------------------------------------------------------------
# Base64 encoded string to Byte array with XORing source and key
#------------------------------------------------------------------------------
function Get-XB64DecodedBytes {
    Param (
        $Src,
        $Key
    )

    if ($null -eq $Key) {
        $Key = ""
    }

    [byte[]]$buf = [System.Convert]::FromBase64String($Src)
    [byte[]]$kb = [System.Text.Encoding]::UTF8.GetBytes($Key)
    [byte[]]$arr = @(Get-XorBytes $buf $kb)

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

    [byte[]]$buf = @(Get-XB64DecodedBytes $Src $Key)
    return [System.Text.Encoding]::UTF8.GetString($buf)
}

#------------------------------------------------------------------------------
# XOR byte array with repeating key byte array
#------------------------------------------------------------------------------
function Get-XorBytes {
    Param (
        [byte[]]$Src,
        [byte[]]$Key
    )

    $len = $Src.Length
    $kl = $Key.Length

    if (($len -eq 0) -or ($kl -eq 0)) {
        return $Src
    }

    $buf = New-Object byte[] ($len)

    for ($i = 0; $i -lt $len; $i++) {
        $buf[$i] = $Src[$i] -bxor $Key[$i % $kl]
    }

    return $buf
}
