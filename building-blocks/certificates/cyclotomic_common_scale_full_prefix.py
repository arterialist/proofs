"""Exact prime-step, trace, geometric weight and full-prefix derivative fixtures."""
from fractions import Fraction as F
from math import gcd
import sympy as s
x,y=s.symbols('x y')
def red(f,n):return s.rem(f,s.cyclotomic_poly(n,x),x)
def actual_norm(u,v,p):
 n=p*v
 f=red(s.cyclotomic_poly(p*u,x),n)
 terms=[red(f.subs(x,x**a),n) for a in range(1,n) if gcd(a,n)==1 and a%v==1]
 out=s.Integer(1)
 for t in terms:out=red(out*t,n)
 V=red(s.cyclotomic_poly(u,x).subs(x,x**p),n)
 if u%p==0 and v%p==0:pred=V**p
 elif u%p==0 or v%p==0:pred=V**(p-1)
 else:pred=V**(p-2)*V.subs(x,x**pow(p,-1,v))
 assert out==red(pred,n)
 return {'u':u,'v':v,'prime':p,'degree':len(terms),'norm':str(out)}
steps=[actual_norm(*t) for t in [(6,4,2),(5,4,2),(6,5,2),(7,5,2),(5,3,3),(9,4,3),(7,4,3)]]
# Direct trace of every basis monomial, including j=0, in a separate fixture.
g,q=6,4;n=g*q;trace_n=n
fibre=[a for a in range(1,n) if gcd(a,n)==1 and a%q==1]
for j in range(n):
 direct=red(sum(x**(j*a) for a in fibre),n)
 formula=sum(int(s.mobius(d))*(g//d)*x**(g*((j//(g//d))*pow(d,-1,q)%q)) for d in s.divisors(g) if gcd(int(d),q)==1 and j%(g//d)==0)
 assert direct==red(formula,n)
assert len(fibre)==s.totient(n)/s.totient(q)
# Geometric Farey weights from ordered fractions, without modular-inverse formula.
N=21;n=15
phases=sorted({F(a,b) for b in range(1,N+1) for a in range(b) if gcd(a,b)==1})
weights={}
for a in (1,11):
 phase=F(a,n);i=phases.index(phase)
 before=phases[i-1] if i else phases[-1]-1
 after=phases[i+1] if i+1<len(phases) else phases[0]+1
 weights[a]=(after-before)/2
assert weights=={1:F(1,224),11:F(1,209)}
# Separate full-prefix verification at both members of the actual fibre.
cp=s.cyclotomic_poly(n,x);ix=s.invert(x,cp,x)
basis=[red((x+ix)**j,n) for j in range(s.totient(n)//2)]
c=s.symbols('c:'+str(len(basis)))
def absolute_squared(f):
 value=red(f*f.subs(x,ix),n)
 sol=s.solve(s.Poly(value-sum(a*b for a,b in zip(c,basis)),x).all_coeffs(),c)
 return s.expand(sum(sol[a]*y**j for j,a in enumerate(c)))
def intval(f,lo,hi):
 L=H=F(0)
 for a in s.Poly(f,y).all_coeffs():
  z=[L*lo,L*hi,H*lo,H*hi];L=min(z)+F(a);H=max(z)+F(a)
 return L,H
minpoly=y**4-y**3-4*y**2+4*y+1
# Verify the real-subfield minimal polynomial rather than presuming it.
assert red(minpoly.subs(y,x+ix),n)==0
interval=s.Poly(minpoly,y).intervals(eps=s.Rational(1,10**14))[-1][0]
lo,hi=map(F,interval)
full=[]
for K in (20,21):
 der=s.diff(cp,x)
 for j in range(1,K+1):
  if j!=n:der=red(der*s.cyclotomic_poly(j,x),n)
 for a in (1,11):
  value=red(der.subs(x,x**a),n);sq=absolute_squared(value)
  L,H=intval(sq,lo,hi)
  assert L>1
  full.append({'K':K,'a':a,'squared_modulus':str(sq),'interval':[str(L),str(H)],'clipped_deficit':0})
print('Exact prime-step, basis trace, geometric Farey and full-prefix clipping assertions passed.')
