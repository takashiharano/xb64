# XB64

XB64 (XORed Base64) is a simple reversible encoding method for obfuscation based on XOR and Base64 encoding.

It is intended for lightweight obfuscation in environments where data would otherwise have to be stored or transmitted as plain text.

Before being Base64-encoded, each byte of the input data is XORed with the corresponding byte of the key. The key is repeated as needed to match the length of the input.

The resulting text resembles standard Base64-encoded data, but Base64 decoding alone does not restore the original data.

The design keeps the data from being immediately readable while remaining simple enough to be decoded manually if necessary.

Details of the algorithm are available at https://libutil.com/xb64/.

## Usage

Java:

```Java
String encoded = XB64.encode("abc", "xyz");
String decoded = XB64.decodeToString("GRsZ", "xyz");
```

JavaScript:

```JavaScript
var encoded = xb64.encode('abc', 'xyz');
var decoded = xb64.decodeToString('GRsZ', 'xyz');
```

Python:

```Python
encoded = xb64.encode('abc', 'xyz')
decoded = xb64.decode_to_string('GRsZ', 'xyz')
```

PowerShell:

```powershell
$encoded = Get-XB64EncodedString "abc" "xyz"
$decoded = Get-XB64DecodedString "GRsZ" "xyz"
```

Visual Basic:

```Visual Basic
Dim encoded As String
Dim decoded As String
encoded = XB64.EncodeString("abc", "xyz")
decoded = XB64.DecodeString("GRsZ", "xyz")
```

## Notice

XB64 is intended for obfuscation, not encryption.
The key need not be kept secret; it is simply a parameter used to reverse the obfuscation, not a cryptographic key.
It is not intended to be used where secrecy is of any concern.
