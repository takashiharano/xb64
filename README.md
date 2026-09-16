# XB64

XB64 (XORed Base64) is a simple XOR-based cipher whose output is encoded in Base64.

It is intended for lightweight obfuscation in environments where data would otherwise have to be stored or transmitted as plain text.

Before being Base64-encoded, the input data is XORed with the provided key.

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

XB64 is intended for obfuscation, not for providing confidentiality.
The key is simply a parameter used in the reversible transformation; the scheme does not rely on it being secret.
This method should not be used where confidentiality must be assured.
