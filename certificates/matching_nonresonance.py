"""Exact rational bounds for the finite divisor-source nonresonance lemma.
Run with Python 3. No third-party packages are required.
The gamma remainder is DLMF 5.11.2 and 5.11(ii).
"""
from fractions import Fraction as F

def log_ratio(q):
    # Reduce q to [1,2), then use the positive atanh series.
    k = 0
    while q >= 2:
        q /= 2
        k += 1
    while q < 1:
        q *= 2
        k -= 1
    def series(r):
        z = (r - 1) / (r + 1)
        v = 2 * sum((z ** (2*j+1) / (2*j+1) for j in range(60)), F(0))
        e = 2*z**121 / (121*(1-z*z))
        return v, v+e
    lo, hi = series(q)
    l2, u2 = series(F(2))
    if k >= 0:
        return lo+k*l2, hi+k*u2
    return lo+k*u2, hi+k*l2

N = 100
hn = sum((F(1,n) for n in range(1,N+1)), F(0))
l, u = log_ratio(F(N))
base = hn-F(1,2*N)+F(1,12*N*N)
gamma = (base-u-F(1,120*N**4), base-l)
assert gamma[0] > F(23,40)  # H(1)=2 gamma-1 > 3/20.
for q in range(2,10):
    lo, hi = F(0), F(0)
    for n in range(1,q+1):
        a, b = log_ratio(F(n))
        lo += a
        hi += b
    divisor_sum = sum(q//n for n in range(1,q+1))
    lo += 1-divisor_sum+2*(q-1)*gamma[0]
    hi += 1-divisor_sum+2*(q-1)*gamma[1]
    assert hi < -F(37,1000) or lo > F(37,1000), q
print("Exact rational checks passed: H(1)>3/20 and |H(q)-H(1)|>37/1000 for 2<=q<=9.")
