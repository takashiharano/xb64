#------------------------------------------------------------------------------
# XB64 - XORed Base64
# Copyright 2023 Takashi Harano
# Released under the MIT License
# https://libutil.com/xb64/
#------------------------------------------------------------------------------
import base64

DEFAULT_ENCODING = 'utf-8'

#------------------------------------------------------------------------------
def encode(src, key='', encoding=DEFAULT_ENCODING):
    if key is None:
        key = ''

    a = src
    if isinstance(src, str):
        a = src.encode(encoding)

    k = key.encode(DEFAULT_ENCODING)

    ln = len(a)
    kl = len(k)

    if ln == 0 or kl == 0:
        b = a
    else:
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

    ba = bytearray(b)
    b = base64.b64encode(ba)
    b64 = b.decode('ascii')
    return b64

#------------------------------------------------------------------------------
def decode(src, key=''):
    if key is None:
        key = ''

    a = base64.b64decode(src)
    k = key.encode(DEFAULT_ENCODING)

    al = len(a)
    kl = len(k)

    if al == 0 or kl == 0:
        return a

    p = a[-1]
    ln = al - p - 1
    b = []

    for i in range(0, ln):
        b.append(a[i] ^ k[i % kl])

    return bytes(b)

def decode_to_string(src, key='', encoding=DEFAULT_ENCODING):
    b = decode(src, key)
    s = b.decode(encoding)
    return s

if __name__ == '__main__':
    print(__file__)
