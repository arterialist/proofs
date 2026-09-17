"""Exact quotient-ring checks of cyclotomic valuation reductions and neutrality.

Requires Python and SymPy. The uniform statements are proved in the companion note."""
from math import gcd,prod
from collections import defaultdict
import sympy as s
x=s.Symbol('x')
MAX=60
phis={n:s.Poly(s.cyclotomic_poly(n,x),x,domain=s.QQ) for n in range(1,MAX+1)}
facts={n:s.factorint(n) for n in range(1,MAX+1)}

def rem(P,n):return s.Poly(P,x,domain=s.QQ).rem(phis[n])
def value(m,e,n):return rem(phis[m].as_expr().subs(x,x**e),n)
def key(P):return tuple(P.all_coeffs())
roots={n:{key(rem(sign*x**j,n)) for sign in (1,-1) for j in range(n)} for n in range(2,MAX+1)}
counts={'pairs':0,'prime_formulas':0,'neutral_certificates':0,'all_neutral_pairs':0,'strict_gcd_reductions':0,'folded_neutral_pairs':0}
missed=[]
for N in range(3,MAX+1):
    rad=prod(facts[N]);u=N//rad
    for n in range(2,N):
        if N%n==0:continue
        counts['pairs']+=1
        P=rem(phis[N],n)
        h=gcd(n,u);n0=n//h;N0=N//h
        assert rem(P-value(N0,h,n),n).is_zero
        assert all(facts[N0][p]==1 for p in facts[n0] if p in facts[N0])
        g=gcd(n,N)
        dominance=all(facts[N][p]>facts[n][p] for p in facts[n] if p in facts[N])
        assert (h==g)==dominance
        assert (gcd(n0,N0)==1)==dominance
        if dominance:
            assert rem(P-value(N//g,g,n),n).is_zero
            counts['strict_gcd_reductions']+=1
        # Product norm of every old nondivisor evaluation is exactly one.
        assert s.resultant(phis[n].as_expr(),phis[N].as_expr(),x)==1
        for p,b in facts[N].items():
            m=N//p**b
            numerator=value(m,p**b,n);denominator=value(m,p**(b-1),n)
            assert not denominator.is_zero
            assert rem(P*denominator-numerator,n).is_zero
            counts['prime_formulas']+=1
        cert=False
        for p,b in facts[N0].items():
            if n0%p==0:continue
            if p%n0 not in {1,(-1)%n0}:continue
            m=N0//p**b;e=p**(b-1)
            if p%n0==1:expected=rem(1,n)
            elif m==1:expected=rem(-x**((-h*e)%n),n)
            else:expected=rem(x**((-h*e*int(s.totient(m)))%n),n)
            assert P==expected
            counts['neutral_certificates']+=1;cert=True
        is_root_unity=key(P) in roots[n]
        if is_root_unity:
            counts['all_neutral_pairs']+=1
            if not cert:missed.append((n,N,P.as_expr(),n0,N0))
        folded=defaultdict(int)
        for d in s.divisors(N):
            residue=d%n
            assert residue!=0
            folded[min(residue,n-residue)]+=int(s.mobius(N//d))
        folded_zero=not any(folded.values())
        if folded_zero:
            counts['folded_neutral_pairs']+=1
            assert is_root_unity
        if cert:assert is_root_unity and folded_zero
        if n0 in (2,3,4,6):assert cert and is_root_unity
print('PASS exact counts',counts)
print('neutral pairs outside the sufficient test',missed[:8])

assert rem(phis[14],10)==rem(1-x,10)
assert rem(value(7,2,10),10)==rem(1+x**2,10)
assert rem(phis[16],10)==rem(1-x**3,10)
assert rem(phis[20],16)==rem(-x**6+x**4-x**2,16)
assert rem(phis[16],12)==rem(1-x**2,12)
for n,N in [(10,14),(10,16),(16,20),(12,16)]:
    print('witness remainder',n,N,rem(phis[N],n).as_expr())
# Algebraic squared-modulus witnesses, computed in the same quotient fields.
for n,N in [(10,14),(10,16),(16,20)]:
    P=rem(phis[N],n)
    conjugate=rem(P.as_expr().subs(x,x**(n-1)),n)
    square=rem(P*conjugate,n)
    print('exact modulus-square polynomial',n,N,square.as_expr())
print('PASS: exact witnesses reject naive gcd reduction and either direction of a valuation-gap neutrality claim.')
# The sufficient prime congruence filter is not a classification of all neutral pairs.
Q24=s.Poly(s.cyclotomic_poly(24,x),x,domain=s.QQ)
assert s.Poly(s.cyclotomic_poly(385,x),x,domain=s.QQ).rem(Q24)==s.Poly(1,x,domain=s.QQ)
assert all(p%24 not in {1,23} for p in (5,7,11))
print('extra neutral witness: Phi385 == 1 modulo Phi24; no prime factor is +/-1 modulo 24.')
# Above the conductor valuation, values follow a fixed residual-field orbit.
P16=rem(s.cyclotomic_poly(16,x),10)
P32=rem(s.cyclotomic_poly(32,x),10)
P256=rem(s.cyclotomic_poly(256,x),10)
assert P32==rem(P16.as_expr().subs(x,x**7),10)  # 7 mod 10 lifts 2 mod 5.
assert P256==P16  # 2^4 == 1 mod 5.
print('PASS: residual-field orbit and a neutral case outside the prime congruence filter.')

folded=defaultdict(int)
for d in s.divisors(385):
    residue=d%24
    folded[min(residue,24-residue)]+=int(s.mobius(385//d))
assert dict(folded)=={1:0,5:0,7:0,11:0}
assert 24**2>385 and (385-24)**2>385
print('PASS: folded-divisor certificate',dict(folded),'at surviving-interior pair (24,385).')
