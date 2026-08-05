Base64S
=====================

Base64S (with the “S” standing for “Secure”) is a simple reversible cipher based on XOR and Base64 encoding.
Before being Base64-encoded, the input data is XORed with the provided key.
The resulting text resembles standard Base64-encoded data, but it cannot be decoded correctly with a standard Base64 decoder alone.
Details of the algorithm are available at https://libutil.com/b64s/.

## Usage
Java:
```Java
String encoded = Base64s.encode("abc", "xyz");
String decoded = Base64s.decodeString("GRsZAA==", "xyz");
```

JavaScript:
```JavaSctipt
var encoded = base64S.encode('abc', 'xyz');
var decoded = base64S.decode('GRsZAA==', 'xyz');
```

Python:
```Python
encoded = base64s.encode_string('abc', 'xyz')
decoded = base64s.decode_string('GRsZAA==', 'xyz')
```

PowerShell:
```powershell
$encoded = Get-Base64SEncodedString "abc" "xyz"
$decoded = Get-Base64SDecodedString "GRsZAA==" "xyz"
```

Visual Basic:
```Visual Basic
Dim encoded As String
Dim decoded As String
encoded = Base64s.EncodeString("abc", "xyz")
decoded = Base64s.DecodeString("GRsZAA==", "xyz")
```

## Notice
Base64S is not intended to be used where secrecy is of any concern.
