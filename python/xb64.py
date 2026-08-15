#------------------------------------------------------------------------------
# XB64 - XORed Base64
# Copyright 2023 Takashi Harano
# Released under the MIT License
# https://libutil.com/xb64/
#------------------------------------------------------------------------------
import base64

DEFAULT_ENCODING = 'utf-8'

#------------------------------------------------------------------------------
def encode(s, k='', encoding=DEFAULT_ENCODING):
    if s is None:
        return None
    if k is None:
        k = ''
    a = s
    if type(s).__name__ == 'str':
        a = s.encode(encoding)
    kb = k.encode(DEFAULT_ENCODING)
    b = _encode(a, kb)
    b = base64.b64encode(b)
    b64 = b.decode(encoding)
    return b64

def _encode(a, k):
    ln = len(a)
    kl = len(k)
    if ln == 0 or kl == 0:
        return a

    d = kl - ln
    if d < 0:
        d = 0

    b = []
    for i in range(ln):
        b.append(a[i] ^ k[i % kl])

    j = i + 1
    for i in range(d):
        b.append(255 ^ k[j % kl])
        j += 1

    b.append(d)
    return bytearray(b)

#------------------------------------------------------------------------------
def decode(b64, k='', bin=False, encoding=DEFAULT_ENCODING):
    if b64 is None:
        return None
    if k is None:
        k = ''
    b = base64.b64decode(b64)
    kb = k.encode(DEFAULT_ENCODING)
    d = _decode(b, kb)
    if not bin:
        d = d.decode(encoding)
    return d

def _decode(a, k):
    al = len(a)
    kl = len(k)
    if al == 0 or kl == 0:
        return a
    p = a[-1]
    ln = al - p - 1
    b = []
    for i in range(0, ln):
        b.append(a[i] ^ k[i % kl])
    return bytearray(b)

if __name__ == '__main__':
    print(__file__)
