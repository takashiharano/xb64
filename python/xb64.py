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

    if isinstance(src, str):
        src = src.encode(encoding)

    k = key.encode(DEFAULT_ENCODING)
    b = xor(src, k)

    b = base64.b64encode(b)
    b64 = b.decode('ascii')
    return b64

#------------------------------------------------------------------------------
def decode(src, key=''):
    if key is None:
        key = ''

    a = base64.b64decode(src)
    k = key.encode(DEFAULT_ENCODING)
    b = xor(a, k)

    return b

#------------------------------------------------------------------------------
def decode_to_string(src, key='', encoding=DEFAULT_ENCODING):
    b = decode(src, key)
    s = b.decode(encoding)
    return s

#------------------------------------------------------------------------------
def xor(src, key):
    ln = len(src)
    kl = len(key)

    if ln == 0 or kl == 0:
        return bytes(src)

    b = []
    for i in range(ln):
        b.append(src[i] ^ key[i % kl])

    return bytes(b)

if __name__ == '__main__':
    print(__file__)
