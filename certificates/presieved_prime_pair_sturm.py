"""Independent exact cyclic alias, spectral, arithmetic and density checks."""
from fractions import Fraction as F
import math
import sympy as sp
from flint import arb, ctx
# Requires sympy 1.14.0 and python-flint 0.9.0.
ctx.dps=80
active_fixture=[125, 121, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127]
charge_fixture=['212451/1000000', '116751/125000', '142607/250000', '348167/1000000', '205089/500000', '655647/1000000', '242579/500000', '398821/1000000', '636031/1000000', '324071/500000', '371357/500000', '129347/200000', '559011/1000000', '126471/200000', '519/3125']
def r(t):
 t=abs(F(t))
 # Truncated-power representation of the cubic B-spline, distinct from author pieces.
 return sum(F((-1)**j*math.comb(4,j),48)*max(2*t+2-j,F(0))**3 for j in range(5))
def R(h,d):return F(h,2)*(r(F(d,h))-r(F(2*d,h)))
def cyclic(h,q,d):return sum((R(h,d+k*q) for k in range(-2,3)),F())
def mask(W,j):return math.gcd(W,j)==1
z=sp.Symbol('z')
def aspoly(vec):return sp.Poly.from_dict({(j,):sp.Rational(a.numerator,a.denominator) for j,a in enumerate(vec) if a},z)
checks=[]
for h,W,q in [(8,2,16),(8,6,24),(16,6,96),(16,30,240),(32,30,480)]:
 S=[j for j in range(q) if mask(W,j)];phi=int(sp.totient(W));nu=2*q//h
 assert all(sum(cyclic(h,q,j-k) for k in range(q))==F(h*h,64) for j in [0,1,q-1])
 # Polynomial in a primitive q-th root: full masked quadratic form.
 direct=[F() for _ in range(q)];phase_sum=[F() for _ in range(q)]
 for j in S:phase_sum[(nu*j)%q]+=1
 for j in S:
  for k in S:direct[(nu*(k-j))%q]+=cyclic(h,q,j-k)/len(S)
 cyclo=sp.Poly(sp.cyclotomic_poly(q,z),z)
 assert aspoly(phase_sum).rem(cyclo).is_zero
 # CRT congruence counts and actual integer displacement form.
 crt=[F() for _ in range(q)]
 for d in range(-h,h+1):
  cnt=sum(mask(W,j) and mask(W,j-d) for j in range(W))
  local=math.prod(F(p-(1 if d%p==0 else 2),p-1) for p in sp.factorint(W))
  assert F(cnt,phi)==local
  crt[(nu*d)%q]+=R(h,d)*F(cnt,phi)
 # Ramanujan sums via the divisor-Mobius formula, followed by all aliases.
 aliases=[F() for _ in range(q)]
 for b in range(W):
  cb=sum(int(dd*sp.mobius(W//dd)) for dd in sp.divisors(math.gcd(W,b)))
  expected=int(sp.mobius(W//math.gcd(W,b))*sp.totient(math.gcd(W,b)))
  assert cb==expected
  freq=nu+q*b//W
  for d in range(-h,h+1):aliases[(freq*d)%q]+=F(cb*cb,W*phi)*R(h,d)
 assert aspoly([a-b for a,b in zip(direct,crt)]).rem(cyclo).is_zero
 assert aspoly([a-b for a,b in zip(direct,aliases)]).rem(cyclo).is_zero
 checks.append([h,W,q,len(S)])
print('PASS exact cyclotomic masked-vector / CRT / Ramanujan alias comparisons.',flush=True)

# Exact density integrals from the same truncated-power kernel at h=1.
u=sp.Symbol('u',real=True)
pieces=[sp.Rational(1,2)*((sp.Rational(1,12)-u*u/2+u**3/2)-(sp.Rational(1,12)-2*u*u+4*u**3)),
 sp.Rational(1,2)*((sp.Rational(1,12)-u*u/2+u**3/2)-(1-2*u)**3/6),
 (1-u)**3/12]
ends=[sp.Rational(0),sp.Rational(1,4),sp.Rational(1,2),sp.Rational(1)]
inte=2*sum(sp.integrate(f,(u,ends[j],ends[j+1])) for j,f in enumerate(pieces))
first=2*sum(sp.integrate(u*f,(u,ends[j],ends[j+1])) for j,f in enumerate(pieces))
assert inte==sp.Rational(1,64) and first==sp.Rational(7,1280)

X,h,W,q=64,16,6,96
allowed=[j for j in range(q) if mask(W,j)]
B=sp.Matrix([[sp.Rational(cyclic(h,q,j-k))-sp.Rational(1,24) for k in allowed] for j in allowed])
xx=sp.Symbol('x');L=sp.Rational(105,128)
# Exact characteristic polynomial and Sturm root count, independent of LDL.
poly=B.charpoly(xx).as_poly();shifted=sp.Poly(poly.as_expr().subs(xx,xx-L),xx)
zeros=0
while shifted.eval(0)==0:shifted=shifted.exquo(sp.Poly(xx,xx));zeros+=1
assert zeros>0 and shifted.count_roots(-sp.oo,0)==0
print('PASS exact characteristic-polynomial/Sturm scalar optimum; multiplicity',zeros,flush=True)

# Factor every actual integer, rather than enumerate prime bases and powers.
bases={n:next(iter(f)) for n in range(X+1,2*X+1) if len(f:=sp.factorint(n))==1}
active=[n for n in bases if mask(W,n)]
assert {n:bases[n] for n in bases if not mask(W,n)}=={81:3,128:2}
assert set(active)==set(active_fixture)
assert len({n%q for n in range(X+1,2*X+1)})==X
assert all(cyclic(h,q,(n%q)-(m%q))==R(h,n-m) for n in range(X+1,2*X+1) for m in range(X+1,2*X+1))
charges={n:sp.Rational(d) for n,d in zip(active_fixture,charge_fixture)}
eps=sp.Rational(1,20000)
A=sp.Matrix([[sp.Rational(R(h,n-m))-sp.Rational(1,24)+(charges[n] if n==m else 0) for m in active] for n in active])
# Exact leading minors in the alternate, sorted actual-integer order.
pivots=[];work=A-eps*sp.eye(len(active))
for j in range(len(active)):
 pivot=work[j,j];assert pivot>0;pivots.append(pivot)
 for i in range(j+1,len(active)):
  for k in range(j+1,len(active)):work[i,k]-=work[i,j]*work[j,k]/pivot
print('PASS independent rational elimination on sorted active support.',flush=True)
inactive=[j for j in allowed if j not in {n%q for n in active}]
C=sp.Matrix([[B[allowed.index(n%q),allowed.index(j)] for j in inactive] for n in active])
frob=sum(c*c for c in C);dout=4+frob/eps
assert frob==sp.Rational(241987,147456) and dout==sp.Rational(151260307,4608)
# Verify both Schur majorants as exact matrices using quadratic identities.
# A>=eps I, B_inactive>=-4 I follow from the proofs/reproduced exact scalar spectrum.
assert L<4

def ab(x):return arb(int(sp.numer(x)))/int(sp.denom(x))
logs={n:arb(int(bases[n])).log() for n in active}
P=sum(logs.values());P2=sum(v*v for v in logs.values())
scalar=P*P/24-ab(L)*P2;cost=sum(ab(charges[n])*logs[n]**2 for n in active)
bound=P*P/24-cost
pair=sum(ab(sp.Rational(R(h,n-m)))*logs[n]*logs[m] for n in active for m in active)
assert scalar<arb('-61.02') and bound>arb('16.90') and pair>bound
print('Scalar bound:',scalar)
print('Weighted cost:',cost)
print('Nonuniform bound:',bound)
print('Actual allowed pair:',pair)
print('Exact outside charge:',dout)
print('Exact density moments:',inte,first)
