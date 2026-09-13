/*!
 * XB64 - XORed Base64
 * Copyright 2023 Takashi Harano
 * Released under the MIT License
 * https://libutil.com/xb64/
 */
var xb64 = {
  /**
   * Encodes a byte array or string to an XB64 string.
   *
   * Strings are converted to UTF-8 before XB64 encoding.
   * If the key is null, undefined, or empty, the source is encoded
   * as standard Base64 without XOR processing.
   *
   * @param {number[]|string} src Source byte array or string.
   * @param {string} key XOR key.
   * @returns {string} XB64 encoded string.
   */
  encode: function(src, key) {
    if (typeof src == 'string') src = xb64.utf8.toByteArray(src);
    var k = xb64.utf8.toByteArray(key);
    var b = xb64.xor(src, k);
    return xb64.base64.encode(b);
  },

  /**
   * Decodes an XB64 string to a byte array.
   *
   * If the key is null, undefined, or empty, the source is decoded
   * as standard Base64 without XOR processing.
   *
   * @param {string} src XB64 encoded string.
   * @param {string} key XOR key used for encoding.
   * @returns {number[]} Decoded byte array.
   */
  decode: function(src, key) {
    var a = xb64.base64.decode(src);
    var k = xb64.utf8.toByteArray(key);
    return xb64.xor(a, k);
  },

  /**
   * Decodes an XB64 string to a string.
   *
   * The decoded data is interpreted as UTF-8.
   *
   * @param {string} src XB64 encoded string.
   * @param {string} key XOR key used for encoding.
   * @returns {string} Decoded string.
   */
  decodeToString: function(src, key) {
    var a = xb64.decode(src, key);
    return xb64.utf8.fromByteArray(a);
  },

  /**
   * XORs a byte array with a repeating key byte array.
   *
   * If the source or key is empty, a copy of the source is returned.
   *
   * @param {number[]} src Source byte array.
   * @param {number[]} key XOR key byte array.
   * @returns {number[]} XORed byte array.
   */
  xor: function(src, key) {
    var ln = src.length;
    var kl = key.length;
    if ((ln == 0) || (kl == 0)) return src.slice();
    var b = [];
    for (var i = 0; i < ln; i++) {
      b.push(src[i] ^ key[i % kl]);
    }
    return b;
  },

  base64: {
    encode: function(arr) {
      var len = arr.length;
      if (len == 0) return '';
      var tbl = {64: 61, 63: 47, 62: 43};
      for (var i = 0; i < 62; i++) {
        tbl[i] = (i < 26 ? i + 65 : (i < 52 ? i + 71 : i - 4));
      }
      var str = '';
      for (i = 0; i < len; i += 3) {
        str += String.fromCharCode(
          tbl[arr[i] >>> 2],
          tbl[(arr[i] & 3) << 4 | arr[i + 1] >>> 4],
          tbl[(i + 1) < len ? (arr[i + 1] & 15) << 2 | arr[i + 2] >>> 6 : 64],
          tbl[(i + 2) < len ? (arr[i + 2] & 63) : 64]
        );
      }
      return str;
    },

    decode: function(str) {
      var arr = [];
      if (str.length == 0) return arr;
      for (var i = 0; i < str.length; i++) {
        var c = str.charCodeAt(i);
        if (!(((c >= 0x30) && (c <= 0x39)) || ((c >= 0x41) && (c <= 0x5A)) || ((c >= 0x61) && (c <= 0x7A)) || (c == 0x2B) || (c == 0x2F) || (c == 0x3D))) {
          throw new Error('invalid b64 char: 0x' + c.toString(16).toUpperCase() + ' at ' + i);
        }
      }
      var tbl = {61: 64, 47: 63, 43: 62};
      for (i = 0; i < 62; i++) {
        tbl[i < 26 ? i + 65 : (i < 52 ? i + 71 : i - 4)] = i;
      }
      var buf = [];
      for (i = 0; i < str.length; i += 4) {
        for (var j = 0; j < 4; j++) {
          buf[j] = tbl[str.charCodeAt(i + j) || 0];
        }
        arr.push(
          buf[0] << 2 | (buf[1] & 63) >>> 4,
          (buf[1] & 15) << 4 | (buf[2] & 63) >>> 2,
          (buf[2] & 3) << 6 | buf[3] & 63
        );
      }
      if (buf[3] == 64) {
        arr.pop();
        if (buf[2] == 64) {
          arr.pop();
        }
      }
      return arr;
    }
  },

  utf8: {
    toByteArray: function(s) {
      var a = [];
      if (!s) return a;
      var chs = s.match(/[\uD800-\uDBFF][\uDC00-\uDFFF]|[\s\S]/g) || [];
      for (var i = 0; i < chs.length; i++) {
        var ch = chs[i];
        var c = ch.charCodeAt(0);
        if (c <= 0x7F) {
          a.push(c);
        } else {
          var e = encodeURIComponent(ch);
          var w = e.split('%');
          for (var j = 1; j < w.length; j++) {
            a.push(('0x' + w[j]) | 0);
          }
        }
      }
      return a;
    },

    fromByteArray: function(b) {
      var e = '';
      for (var i = 0; i < b.length; i++) {
        e += '%' + xb64.toHex(b[i]);
      }
      return decodeURIComponent(e);
    }
  },

  toHex: function(v) {
    var hex = parseInt(v).toString(16).toUpperCase();
    if (hex.length < 2) {
      hex = '0' + hex;
    }
    return hex;
  }
};
