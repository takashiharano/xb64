import os
import sys

sys.path.append(os.path.join(os.path.dirname(__file__), '..'))
import xb64

TEST_DATA = [
    ('', '', ''),
    ('', 'x', ''),
    ('', None, ''),
    ('abc', '', 'YWJj'),
    ('abc', None, 'YWJj'),
    ('abc', 'x', 'GRob'),
    ('abc', 'xyz', 'GRsZ'),
    ('abc', 'xyz1', 'GRsZ'),
    (
        'a',
        'A2345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234#',
        'IA=='
    ),
    ('あいう', '', '44GC44GE44GG'),
    ('あいう', 'x', 'm/n6m/n8m/n+'),
    ('あいう', 'xyz', 'm/j4m/j+m/j8'),
    ('あいう', 'xyz123456a', 'm/j40rO317Sw'),
]

def encode_test(src, key, exp):
    got = xb64.encode(src, key)
    st = 'PASS' if got == exp else 'FAIL'
    print('[' + st + '] src=' + repr(src) + ' key=' + repr(key)
          + ' exp=' + repr(exp) + ' got=' + repr(got))
    return got == exp

def decode_test(exp, key, b64):
    got = xb64.decode_to_string(b64, key)
    st = 'PASS' if got == exp else 'FAIL'
    print('[' + st + '] src=' + repr(exp) + ' key=' + repr(key)
          + ' b64=' + repr(b64) + ' got=' + repr(got))
    return got == exp

def main():
    passed = 0
    total = 0

    print('Encoding')
    for src, key, b64 in TEST_DATA:
        if encode_test(src, key, b64):
            passed += 1
        total += 1

    print()
    print('Decoding')
    for src, key, b64 in TEST_DATA:
        if decode_test(src, key, b64):
            passed += 1
        total += 1

    print()
    print(str(passed) + '/' + str(total) + ' tests passed')

if __name__ == '__main__':
    main()
