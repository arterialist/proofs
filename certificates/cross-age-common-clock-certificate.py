"""Exact rational checks for the frozen N=14, j=12 common-clock example.

The logarithm and arctangent remainder bounds are stated in the companion
mathematical note. All sign decisions below use fractions, not floats.
"""

from fractions import Fraction as Q
from math import isqrt
class I:
 def __init__(self,a,b=None): self.a=Q(a); self.b=Q(a if b is None else b)
 def __add__(self,o):
  o=asI(o);return I(self.a+o.a,self.b+o.b)
 __radd__=__add__
 def __neg__(self):return I(-self.b,-self.a)
 def __sub__(self,o):return self+-asI(o)
 def __rsub__(self,o):return asI(o)+-self
 def __mul__(self,o):
  o=asI(o);v=[self.a*o.a,self.a*o.b,self.b*o.a,self.b*o.b];return I(min(v),max(v))
 __rmul__=__mul__
 def inv(self):
  assert self.a*self.b>0
  return I(1/self.b,1/self.a)
 def __truediv__(self,o):return self*asI(o).inv()
 def __rtruediv__(self,o):return asI(o)*self.inv()
 def sq(self):
  v=[self.a*self.a,self.b*self.b];return I(0 if self.a<=0<=self.b else min(v),max(v))
def asI(x):return x if isinstance(x,I) else I(x)
def logq(x):
 x=Q(x);z=(x-1)/(x+1);s=2*sum((z**(2*k+1)/Q(2*k+1) for k in range(128)),Q(0));r=2*abs(z)**257/(257*(1-z*z));return I(s-r,s+r)
def sqrtq(n):
 d=10**12;k=isqrt(n*d*d);return I(Q(k,d),Q(k+1,d))
def atanq(x):
 x=Q(x);assert 0<=x<1
 s=sum(((-1)**k*x**(2*k+1)/Q(2*k+1) for k in range(24)),Q(0));r=x**49/49;return I(s,s+r)
def atanI(x):return I(atanq(x.a).a,atanq(x.b).b)
P=3*logq(2)+2*logq(3)+sum((logq(n) for n in [5,7,11,13]),I(0));e=P-14
D=Q(10,117)*e.sq()*logq(Q(140,23))-Q(10,108)*e*P*logq(Q(104,77))+e*logq(Q(16,11))-Q(10,108)*e.sq()*logq(Q(35,8))
assert Q(33,10000)<D.a<=D.b<Q(34,10000)
pi=16*atanq(Q(1,5))-4*atanq(Q(1,239))
r2,r6,r12,r13=[sqrtq(n) for n in [2,6,12,13]]
c=2*(14/r12*(atanI(1/r6)-atanI(1/r12))-(r2-1))
m0=2*e/r12*(pi/2-atanI(1/r12))+c
m1=2*e/r13*(pi/2-atanI(1/r13))
dm=m1.sq()-m0.sq()
assert Q(81,10000)<dm.a<=dm.b<Q(82,10000)
print('Exact rational certificate passed: 33/10000 < D < 34/10000; 81/10000 < m1^2-m0^2 < 82/10000.')
