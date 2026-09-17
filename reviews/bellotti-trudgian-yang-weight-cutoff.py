"""Arb certificate for a corrected 58.7 cutoff in BTY Lemma 11.

Run with: uv run --with python-flint==0.9.0 python reviews/bellotti-trudgian-yang-weight-cutoff.py 4.8594
and again with 4.85935 for the slightly stronger candidate.

The calculation concerns only the weight inequality.
"""

import sys

from flint import arb, ctx
ctx.prec = 128
assert len(sys.argv) == 2 and sys.argv[1] in ('4.8594', '4.85935')
A = arb(1)/arb(sys.argv[1])
H = arb(3)*10**12
eta0 = A/H.log()
sigma0 = 1-A/(arb(16)*H+10**10).log()
D0 = 2*sigma0-1
th = arb('1.1338')
t = th.tan()
s = th.sin()
c = th.cos()
sec2 = 1/(c*c)
cot = 1/t
w0 = sec2*(th*t+3*th*cot-3)
k = [arb(v)/859 for v in [859,-851,780,-525,171,28,-29]]
kappa = sum(k)
d = [D0*i if int(v)<0 else arb(i) for i,v in enumerate([859,-851,780,-525,171,28,-29])]
q = 2*th*cot

def w(v):
    return sec2*(sec2*(th*cot-v/2)*(v*t).cos()+2*th*cot-v+(2*th-v*t).sin()/(2*th).sin()-2*(1+(th-v*t).sin()/s))

def wp(v):
    return sec2*(sec2*(-(v*t).cos()/2-(th*cot-v/2)*t*(v*t).sin())-1-t*(2*th-v*t).cos()/(2*th).sin()+2*t*(th-v*t).cos()/s)

def ps(u):
    return sum(v*(-di*u).exp() for v,di in zip(k,d))

def psp(u):
    return sum(-di*v*(-di*u).exp() for v,di in zip(k,d))

def V(u):
    return w(eta0*u)*ps(u)-kappa*w0

def Vp(u):
    return eta0*wp(eta0*u)*ps(u)+w(eta0*u)*psp(u)

assert eta0 < arb('0.007164')
assert sigma0 > arb('0.993467')
assert V(arb(0)).contains(0)
# These 100 interval cells cover [0, 0.1]. Strictly positive V' and
# V(0)=0 prove V(u)>=0 on this initial segment.
derivative_lo = None
for i in range(100):
    cell = arb(arb(2*i+1)/2000,arb(1)/2000)
    value = Vp(cell)
    assert value>0, ('derivative',i,value)
    if derivative_lo is None or value.lower()<derivative_lo:
        derivative_lo=value.lower()
lo = None
# These 5860 closed interval cells cover [0.1, 58.7].
for i in range(10,5870):
    u = arb(arb(2*i+1)/200,arb(1)/200)
    value = V(u)
    if not (value > 0):
        raise AssertionError((i, value, u))
    if lo is None or value.lower() < lo:
        lo = value.lower()
assert V(arb(59)) < 0
print('A0',A)
print('eta0',eta0,'sigma0',sigma0,'D0',D0)
print('Hprime lower on [0,0.1]',derivative_lo)
print('H(58.7)',V(arb('58.7')))
print('min lower on [0.1,58.7]',lo)
print('H(59)',V(arb(59)))
