"""Actual fifth-primitive failure with an elementary full-prime-power tail."""
import math
from flint import arb, arb_series, ctx
# Requires python-flint 0.9.0.
ctx.prec=128
N=100000
sieve=bytearray(b'\1')*(N+1);sieve[:2]=b'\0\0'
for p in range(2,math.isqrt(N)+1):
 if sieve[p]:sieve[p*p::p]=b'\0'*((N-p*p)//p+1)
pp=[]
for p in range(2,N+1):
 if sieve[p]:
  n=p
  while n<=N:pp.append((n,arb(p).log()));n*=p
qs=[arb(1)]+[arb(j).sqrt().atan()/arb(j).sqrt() for j in range(1,6)]
def q(j,n):
 if n<=j+1:return qs[j]
 if j==0:return 1/arb(n).sqrt()
 return (arb(j)/n).sqrt().asin()/arb(j).sqrt()
e=[]
for j in range(5):
 e.append(sum((lp*(q(j+1,n)-q(j,n)) for n,lp in pp),arb(0)))
# f'(z)<=1/[6(1-z)^(3/2)], Lambda(n)<=log n;
# sum_{n>N}log(n)/n^(3/2)<=integral_N^infty=2(logN+2)/sqrtN.
E=(arb(N).log()+2)/(3*arb(N).sqrt()*(1-arb(5)/N)**arb('1.5'))
lo=[];hi=[]
for j in range(5):
 lo.append(e[j]+sum((lo[i]*(qs[j-1-i]-qs[j-i]) for i in range(j)),arb(0)))
 hi.append(e[j]+E+sum((hi[i]*(qs[j-1-i]-qs[j-i]) for i in range(j)),arb(0)))
 assert lo[-1]>0
 print('kappa',j,'lower',lo[-1],'upper',hi[-1])
psi5=2*arb(2).log()+arb(3).log()+arb(5).log()
x1=arb(101)/100
upper=-psi5/((x1+4)*(x1+5))-lo[4]/x1
upper+=sum((hi[i]/((4-i)*(5-i)) for i in range(4)),arb(0))
assert upper < -arb(1)/20
print('Uniform bracket upper on 1<=x<=101/100:',upper)
print('Thus P5(log(101/100)) < -log(101/100)/20 < 0.')
