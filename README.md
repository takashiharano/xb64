Base64S
=====================

Base64S (with "S" standing for "secure") is a derivative encoding scheme of Base64.  
The data to be encoded is XORed with the given key before encoding.  
The encrypted data is seemingly Base64 encoded characters, but it is impossible to decode in Base64.  
The detail of the mechanism is available at https://libutil.com/b64s/

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
