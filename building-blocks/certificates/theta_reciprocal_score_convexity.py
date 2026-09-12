"""Certify the single actual inequality 2 k'(v)^2-k(v)k''(v)>0 on 0<=v<=4.
Here phi(v)=Phi(sqrt(v)), g=-phi', k=-g'/g, with the COMPLETE theta kernel.
All infinite theta and Taylor tails are enclosed explicitly. No sampling inference.
Requires python-flint (the original computation used version 0.9.0).
The complementary analytic tail is proved in ../theta-natural-exponent-concavity.md.
"""
from fractions import Fraction as Q
from flint import arb,ctx
ctx.prec=192
pi=arb.pi()
def poly(cs,x):
 z=arb(0)
 for c in reversed(cs):z=z*x+c
 return z

def interval(a,b):
 aa=arb(a.numerator)/a.denominator;bb=arb(b.numerator)/b.denominator
 return (aa+bb)/2+arb(0,((bb-aa)/2).upper())

# On |u|<=1/2, |Phi(u)|<10000; theta tail n>=25 is bounded by D.
# Each even coefficient a_m has error <=D*4^m.
M=40;degree=2*M
fact=[arb(1)]
for j in range(1,degree+1):fact.append(fact[-1]*j)
coeff=[arb(0)]*(degree+1)
for n in range(1,25):
 p=pi*n*n
 ex=[-p*arb(2)**j/fact[j] for j in range(degree+1)]
 ep=[(-p).exp()]
 for j in range(1,degree+1):
  ep.append(sum((k*ex[k]*ep[j-k] for k in range(1,j+1)),arb(0))/j)
 for j in range(0,degree+1,2):
  coeff[j]+=sum((ep[j-k]*(4*p*p*(arb(9)/2)**k-6*p*(arb(5)/2)**k)/fact[k] for k in range(j+1)),arb(0))
D=952*arb(25)**4*(-arb(625)/2).exp()
a=[coeff[2*m]+arb(0,(D*arb(4)**m).upper()) for m in range(M+1)]
gjets=[[-(m+1)*a[m+1] for m in range(M)]]
for j in range(3):
 old=gjets[-1]
 gjets.append([(m+1)*old[m+1] for m in range(len(old)-1)])
# For 0<=v<=1/16, t=4v<=1/4. The omitted j-th derivative of g is
# <=10000*4^(j+1)*(M+1)^(j+1)*t^(M-j)/(1-2t), j<=3.
t=arb(1)/4
errors=[10000*arb(4)**(j+1)*arb(M+1)**(j+1)*t**(M-j)/(1-2*t) for j in range(4)]
stack=[(Q(0),Q(1,16))];near=0
while stack:
 lo,hi=stack.pop();v=interval(lo,hi)
 G,G1,G2,G3=[poly(cs,v)+arb(0,err.upper()) for cs,err in zip(gjets,errors)]
 N=2*G*G2*G2-G1*G1*G2-G*G1*G3
 if G>0 and N>0:
  near+=1
 else:
  if N<0:
   raise AssertionError(('NEGATIVE interval in v',lo,hi,N))
  assert hi-lo>Q(1,10**9),('UNRESOLVED near zero',lo,hi,N)
  mid=(lo+hi)/2;stack.extend([(lo,mid),(mid,hi)])
print('CERTIFIED actual reciprocal-score convexity for 0<=v<=1/16;',near,'intervals',flush=True)

# Phi^(j)(u)=exp(u/2-y) S_j(y), y=pi exp(2u),
# S_j(y)=sum_n q_j(n^2 y)exp(-(n^2-1)y), q_0=4y^2-6y.
qs=[[arb(0),arb(-6),arb(4)]]
for j in range(4):
 old=qs[-1];new=[arb(0)]*(len(old)+1)
 for k,c in enumerate(old):
  new[k]+=(arb(1)/2+2*k)*c
  new[k+1]-=2*c
 qs.append(new)
C=max(sum(abs(c) for c in z) for z in qs)
# For y>=3 and n>=9: |q_j(n^2 y)|<=C n^12 y^6, j<=4.
# y^6 exp(-(n^2-1)y) decreases for y>=3. The successive n ratio is<1/2.
E=2*C*arb(3)**6*arb(9)**12*(-arb(240)).exp()
assert E<arb('1e-80')
def score_numerator(u):
 y=pi*(2*u).exp()
 S=[]
 for j in range(1,5):
  sj=poly(qs[j],y)
  for n in range(2,9):sj+=poly(qs[j],n*n*y)*(-(n*n-1)*y).exp()
  S.append(sj+arb(0,E.upper()))
 S1,S2,S3,S4=S
 A=-S1
 B=S1-u*S2
 Cc=-3*S1+3*u*S2-u*u*S3
 DD=15*S1-15*u*S2+6*u*u*S3-u*u*u*S4
 # 2k'^2-kk'' = N/(16u^8 A^3), where A>0.
 N=2*A*Cc*Cc-B*B*Cc-A*B*DD
 return A,N
stack=[(Q(1,4),Q(2))];away=0
while stack:
 lo,hi=stack.pop();u=interval(lo,hi)
 A,N=score_numerator(u)
 if A>0 and N>0:
  away+=1
 else:
  if N<0 and A>0:
   raise AssertionError(('NEGATIVE interval in u',lo,hi,N))
  assert hi-lo>Q(1,10**9),('UNRESOLVED away',lo,hi,A,N)
  mid=(lo+hi)/2;stack.extend([(lo,mid),(mid,hi)])
print('CERTIFIED actual reciprocal-score convexity for 1/4<=u<=2;',away,'intervals',flush=True)
print('Infinite theta-tail enclosure for normalized jets:',E,flush=True)
print('Conclusion: 2k-prime(v)^2-k(v)k-double-prime(v)>0 for EVERY 0<=v<=4.',flush=True)
