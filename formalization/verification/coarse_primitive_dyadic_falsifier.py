"""Certified interval check that S_512 > 16 S_256 for the actual prime error."""

from fractions import Fraction as F
from decimal import Decimal as D, localcontext, ROUND_FLOOR, ROUND_CEILING, getcontext
PREC=60; K=30
getcontext().prec=PREC

def qdec(q,rounding):
 with localcontext() as c:
  c.prec=PREC; c.rounding=rounding
  return D(q.numerator)/D(q.denominator)
def downop(fn):
 with localcontext() as c: c.prec=PREC; c.rounding=ROUND_FLOOR; return fn()
def upop(fn):
 with localcontext() as c: c.prec=PREC; c.rounding=ROUND_CEILING; return fn()
def add(a,b): return (downop(lambda:a[0]+b[0]),upop(lambda:a[1]+b[1]))
def neg(a): return (-a[1],-a[0])
def sub(a,b): return add(a,neg(b))
def mul(a,b):
 lo=downop(lambda:min(a[0]*b[0],a[0]*b[1],a[1]*b[0],a[1]*b[1]))
 hi=upop(lambda:max(a[0]*b[0],a[0]*b[1],a[1]*b[0],a[1]*b[1]))
 return lo,hi
def scale(q,a):
 q=D(q); return mul((q,q),a)
def divq(a,q):
 q=D(q)
 return (downop(lambda:a[0]/q),upop(lambda:a[1]/q))
def point(q): q=D(q); return q,q
def lograt(num,den=1):
 z=F(num-den,num+den); s=F(0)
 for n in range(K+1): s += z**(2*n+1)/F(2*n+1)
 lo=2*s; tail=2*z**(2*K+3)/(F(2*K+3)*(1-z*z))
 return qdec(lo,ROUND_FLOOR),qdec(lo+tail,ROUND_CEILING)
LN2=lograt(2)
def logint(p):
 k=p.bit_length()-1
 return add(scale(k,LN2),lograt(p,1<<k))
def sieve(n):
 lam=[point(0) for _ in range(n+1)]
 for p in range(2,n+1):
  if all(p%d for d in range(2,int(p**.5)+1)):
   lp=logint(p); q=p
   while q<=n: lam[q]=lp; q*=p
 psi=[]; s=point(0)
 for x in range(n+1): s=add(s,lam[x]); psi.append(s)
 return psi
def intsq(a,b,c):
 return add(add(mul(a,a),mul(a,b)),add(divq(add(mul(b,b),scale(2,mul(a,c))),3),add(divq(mul(b,c),2),divq(mul(c,c),5))))
def S(X,psi):
 A=point(0); cells=[]
 for m in range(X,2*X):
  b=sub(psi[m],point(m)); c=point('-0.5'); cells.append((A,b,c)); A=add(A,sub(b,point('0.5')))
 M=A; ans=point(0)
 for a,b,c in cells: ans=add(ans,add(intsq(a,b,c),intsq(sub(M,a),neg(b),neg(c))))
 return ans,M
psi=sieve(1024); a,_=S(256,psi); b,_=S(512,psi); d=sub(b,scale(16,a))
r=(downop(lambda:b[0]/(D(16)*a[1])),upop(lambda:b[1]/(D(16)*a[0])))
for name,v in [('S256',a),('S512',b),('difference',d),('ratio',r)]: print(name,v[0],v[1],'width',v[1]-v[0])
assert d[0]>0
