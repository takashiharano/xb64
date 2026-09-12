import os
import sys

sys.path.append(os.path.join(os.path.dirname(__file__), '..'))
import xb64

def test(s, k, exp):
    b = xb64.encode(s, k)
    st = 'PASS' if b == exp else 'FAIL'
    print('[' + st + '] exp=' + str(exp) + ' got=' + str(b))

def main():
    test('abc', '', 'YWJj')
    test('abc', 'x', 'GRobAA==')
    test('abc', 'xyz', 'GRsZAA==')
    test('abc', 'xyz1', 'GRsZzgE=')
    test('a', 'A2345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234#', 'IM3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvKycjHxs/OzczLysnIx8bPzs3My8rJyMfGz87NzMvc/g==')
    test('あいう', '', '44GC44GE44GG')
    test('あいう', 'x', 'm/n6m/n8m/n+AA==')
    test('あいう', 'xyz', 'm/j4m/j+m/j8AA==')
    test('あいう', 'xyz123456a', 'm/j40rO317SwngE=')
    test('', 'x', '')
    test('', '', '')
    test('abc', None, 'YWJj')
    test('', None, '')
    test(None, None, None)

main()
