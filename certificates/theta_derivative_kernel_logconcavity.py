"""Actual full-theta derivative-kernel log-concavity on 0 <= u <= 1.
The infinite u>=1 range is treated analytically in the accompanying argument.
Uses the established disk bound |Phi(u)|<10000 on |u|<=1/2.
Requires Python 3 and python-flint 0.9.0; run without Python -O.
See ../building-blocks/theta-and-heat/theta-derivative-kernel-logconcavity.md for the full analytic proof.
"""
from flint import arb, ctx
ctx.prec=160
pi=arb.pi()
# Exact recurrence q_(j+1)=(1/2-2y)q_j+2y q_j'.
qs=[[arb(0),arb(-6),arb(4)]]
for j in range(3):
 q=qs[-1]; new=[arb(0)]*(len(q)+1)
 for k,c in enumerate(q):
  new[k]+=(arb(1)/2+2*k)*c
  new[k+1]-=2*c
 qs.append(new)
assert all(sum(abs(c) for c in q)<5000 for q in qs)
def poly(q,x):
 s=arb(0)
 for c in reversed(q): s=s*x+c
 return s
# For 1/10<=u<=1 and n>=9, all derivative tails j<=3:
# |Phi_n^(j)| <= 2*5000*(3 n^2)^5 exp(-3 n^2).
# The ratio of successive n^10 exp(-3n^2) terms is <1/2.
terr=4*5000*arb(3)**5*arb(9)**10*(-arb(243)).exp()
assert terr<arb('1e-80')
def derivatives(u):
 y=pi*(2*u).exp(); a=[arb(0)]*4
 for n in range(1,9):
  yn=n*n*y; fac=(u/2-yn).exp()
  for j in range(4): a[j]+=fac*poly(qs[j],yn)
 return [z+arb(0,terr.upper()) for z in a]

def sign_on(a,b):
 u=arb((a+b)/2,(b-a)/2)
 ph,p1,p2,p3=derivatives(u)
 if not p1<0:return False
 E=u*u*p1*p3-u*u*p2*p2-u*p1*p2+2*p1*p1
 return E<0
# Rational dyadic intervals, with 1/10 represented by an enclosing Arb ball.
# Use exact integer grid endpoints instead to keep coverage transparent.
from fractions import Fraction
stack=[(Fraction(1,10),Fraction(1))]; leaves=0; depthmax=0
while stack:
 a,b=stack.pop()
 aa=arb(a.numerator)/a.denominator; bb=arb(b.numerator)/b.denominator
 # Enclosure of [a,b] includes rounding of midpoint and radius.
 mid=(aa+bb)/2; rad=(bb-aa)/2
 u=mid+arb(0,rad.upper())
 ph,p1,p2,p3=derivatives(u)
 E=u*u*p1*p3-u*u*p2*p2-u*p1*p2+2*p1*p1
 if p1<0 and E<0:
  leaves+=1
 else:
  assert b-a>Fraction(1,10**8), (a,b,E)
  m=(a+b)/2; stack.extend([(a,m),(m,b)])
print('Full theta: E(u)<0 on [1/10,1]; interval count',leaves)

# Even Taylor part Phi(u)=sum a_m u^(2m), m<=20.
D=40
fact=[arb(1)]
for j in range(1,D+1):fact.append(fact[-1]*j)
coeff=[arb(0)]*(D+1)
for n in range(1,25):
 p=pi*n*n
 ex=[-p*arb(2)**j/fact[j] for j in range(D+1)]
 ep=[(-p).exp()]
 for j in range(1,D+1):
  ep.append(sum((k*ex[k]*ep[j-k] for k in range(1,j+1)),arb(0))/j)
 for j in range(0,D+1,2):
  coeff[j]+=sum((ep[j-k]*(4*p*p*(arb(9)/2)**k-6*p*(arb(5)/2)**k)/fact[k] for k in range(j+1)),arb(0))
tdisk=952*arb(25)**4*(-arb(625)/2).exp()
a=[coeff[2*m]+arb(0,(tdisk*arb(4)**m).upper()) for m in range(21)]
g=[-(m+1)*a[m+1] for m in range(20)]
gp=[(m+1)*g[m+1] for m in range(19)]
gpp=[(m+1)*gp[m+1] for m in range(18)]
q=arb(1)/25
errs=[10000*arb(4)**(j+1)*arb(21)**(j+1)*q**(20-j)/(1-2*q) for j in range(3)]
# derivative coefficient falling factorial <= m^(j+1), ratio <=2q.
v=arb(1)/200+arb(0,(arb(1)/200).upper())
vals=[poly(cs,v)+arb(0,er.upper()) for cs,er in zip([g,gp,gpp],errs)]
G,Gp,Gpp=vals
C=G*Gpp-Gp*Gp
print('g(v) enclosure on [0,1/100]:',G)
print('g g-double-prime minus g-prime-squared enclosure:',C)
assert G>0 and C<0
assert gp[0]<0
print("g'(0) enclosure:", gp[0])
print('Full theta: (log(-phi-prime)) double-prime <0 on [0,1] in v=u^2.')
