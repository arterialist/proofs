"""Finite rational/Arb certificate with exact analytic infinite-tail inclusion.

No SciPy is used or trusted. The accompanying text table defines exact rational columns.
The full Sturm-Liouville matrix has rational diagonal and squared off-diagonal.
"""
from pathlib import Path
from flint import arb, arb_mat, fmpq, ctx
ctx.prec = 256
N, rank = 256, 146
data = {"theta": [[0,1] for _ in range(rank)], "columns": [[[0,1] for _ in range(N)] for _ in range(rank)]}
seen = set()
for line in Path(__file__).with_name("prolate_projection_rationals.txt").read_text().splitlines():
    if not line or line.startswith("#"): continue
    kind, j, n, a, b = line.split()
    j,n,a,b = map(int,(j,n,a,b))
    assert 0 <= j < rank and b > 0 and (kind,j,n) not in seen
    seen.add((kind,j,n))
    if kind == "T":
        assert n == -1
        data["theta"][j] = [a,b]
    else:
        assert kind == "Q" and 0 <= n < N
        data["columns"][j][n] = [a,b]
assert all(("T",j,-1) in seen for j in range(rank))

def diagonal(n):
    return fmpq(n*(n+1)) + 40000*(fmpq((n+1)**2,(2*n+1)*(2*n+3))
           + fmpq(n*n,(2*n+1)*(2*n-1)))
def offsquare(n):
    return fmpq(40000**2*(n+1)**2*(n+2)**2,
                (2*n+3)**2*(2*n+1)*(2*n+5))

# Exact LDL inertia with every pivot explicitly nonzero.
# Subtracting b_{N-2}²/(N(N+1)-tau), b_{N-1}²/(...) on the last two
# coordinates bounds the entire infinite-tail Schur correction from above.
inertias = []
for tau in (43800,43900):
    for lowered in (False,True):
        parity_counts = []
        min_abs_pivot = None
        for parity in (0,1):
            count = 0
            previous = None
            for n in range(parity,N,2):
                pivot = diagonal(n)-tau
                if lowered and n >= N-2:
                    pivot -= offsquare(n)/fmpq(N*(N+1)-tau)
                if previous is not None:
                    pivot -= offsquare(n-2)/previous
                assert pivot != 0
                count += pivot < 0
                ap = abs(pivot)
                if min_abs_pivot is None or ap < min_abs_pivot:
                    min_abs_pivot = ap
                previous = pivot
            parity_counts.append(count)
        assert parity_counts == [73,73]
        inertias.append({"tau":tau,"corner_lowered":lowered,
                        "negative_counts":parity_counts,
                        "minimum_absolute_LDL_pivot":str(arb(min_abs_pivot))})
        print("exact inertia",tau,lowered,parity_counts,flush=True)

theta = [arb(fmpq(*r)) for r in data["theta"]]
assert len(theta)==rank and all(t < 43746 for t in theta)
Q = arb_mat([[arb(fmpq(*data["columns"][j][n])) for j in range(rank)]
             for n in range(N)])
G = Q.transpose()*Q
gram_squared = sum((G[i,j]-(1 if i==j else 0))**2
                   for i in range(rank) for j in range(rank))
assert gram_squared < arb(1)/10**20
gram_frobenius = gram_squared.sqrt()

# DQ has exactly N+2 rows: multiplication by x² raises degree by at most two.
off = [arb(offsquare(n)).sqrt() for n in range(N)]
diag = [arb(diagonal(n)) for n in range(N)]
residual_squared = arb(0)
tail_squared = arb(0)
for j in range(rank):
    for n in range(N):
        r = (diag[n]-theta[j])*Q[n,j]
        if n>=2: r += off[n-2]*Q[n-2,j]
        if n+2<N: r += off[n]*Q[n+2,j]
        residual_squared += r*r
    for n in (N-2,N-1):
        r = off[n]*Q[n,j]
        tail_squared += r*r
residual_squared += tail_squared
assert residual_squared < arb(1)/10**12
residual_frobenius = residual_squared.sqrt()
eta = residual_frobenius/(154*(1-gram_frobenius).sqrt())
assert eta < arb(1)/10**8

# Outward rational bath bound using eta < 1e-8; given input constants exact.
bath = arb("0.353892")-arb("8.653892")/10**16
assert bath > arb("0.353891999999999")
print("Gram Frobenius bound:", gram_frobenius)
print("Complete residual:", residual_frobenius)
print("Tail rows:", tail_squared.sqrt())
print("Projection distance:", eta)
print("Bath lower bound:", bath)

# Independent rational substitution into the continuous prolate bound.
from fractions import Fraction as F
from math import factorial
# Machin's identity and alternating arctangent series certify these pi bounds.
pi_lo, pi_hi = F(3141592, 1000000), F(3141593, 1000000)
def atan_interval(z):
    lo=sum((-1)**j*z**(2*j+1)/F(2*j+1) for j in range(20))
    return lo,lo+z**41/41
a_lo,a_hi=atan_interval(F(1,5)); b_lo,b_hi=atan_interval(F(1,239))
assert pi_lo < 16*a_lo-4*b_hi <= 16*a_hi-4*b_lo < pi_hi
assert 127 < 400/pi_hi and 400/pi_lo < 128

def log_interval_unit(x, terms=60):
    assert 1 <= x <= 2
    t=(x-1)/(x+1)
    lo=2*sum(t**(2*j+1)/F(2*j+1) for j in range(terms))
    tail=2*t**(2*terms+1)/(F(2*terms+1)*(1-t*t))
    return lo,lo+tail

arg=F(20000)/pi_lo+25
assert 4096 <= arg <= 8192
_,log2_hi=log_interval_unit(F(2))
_,res_hi=log_interval_unit(arg/4096)
D_hi=2*(12*log2_hi+res_hi)/pi_lo**2
assert D_hi < F(222,125)
exponent=F(12)/F(222,125)
assert exponent == F(250,37)
exp_lower=sum(exponent**j/F(factorial(j)) for j in range(32))
assert exp_lower > F(2500,3)
# Therefore 10*exp(-12/D)<10/(2500/3)=0.012.
epsilon=F(3,250)
mu=F(3386,1000)-F(8759,1000)*epsilon-F(2927,1000)
assert mu==F(88473,250000) and mu>F(3152,10000)

print("Continuous concentration bound and rational bath substitution passed")
