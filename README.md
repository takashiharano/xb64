XB64
=====================

XB64 (XORed Base64) is a simple reversible encoding method based on XOR and Base64 encoding.
Before being Base64-encoded, the input data is XORed with the provided key.
The resulting text resembles standard Base64-encoded data, but it cannot be decoded correctly with a standard Base64 decoder alone.
Details of the algorithm are available at https://libutil.com/xb64/.

## Usage
Java:
```Java
String encoded = XB64.encode("abc", "xyz");
String decoded = XB64.decodeToString("GRsZAA==", "xyz");
```

JavaScript:
```JavaSctipt
var encoded = xb64.encode('abc', 'xyz');
var decoded = xb64.decode('GRsZAA==', 'xyz');
```

Python:
```Python
encoded = xb64.encode_string('abc', 'xyz')
decoded = xb64.decode_string('GRsZAA==', 'xyz')
```

PowerShell:
```powershell
$encoded = Get-XB64EncodedString "abc" "xyz"
$decoded = Get-XB64DecodedString "GRsZAA==" "xyz"
```

Visual Basic:
```Visual Basic
Dim encoded As String
Dim decoded As String
encoded = XB64.EncodeString("abc", "xyz")
decoded = XB64.DecodeString("GRsZAA==", "xyz")
```

## Notice
XB64 is not intended to be used where secrecy is of any concern.
