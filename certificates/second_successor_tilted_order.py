"""New upper-envelope and initial tilted-source checks, using proved charge intervals."""
import math
from flint import arb, arb_series, ctx
# Requires python-flint 0.9.0.
ctx.prec=192
ka_lo=arb(2789)/10000;ka_hi=arb(279)/1000
kb_lo=arb(2529)/10000;kb_hi=arb(253)/1000
c=arb(93)/100
l3=arb(3).log();sq2=arb(2).sqrt()
# First cell derivative and envelope.
M=sq2*l3/4-ka_lo*sq2/3+(ka_hi-kb_lo)
assert M<arb(3)/10
assert arb(3)/5*sq2<c
# Tail at x>=23 uses the separately certified epsilon_23<.162.
assert 2*kb_hi+2*arb(162)/1000<c*arb(22)/23
base={2:2,3:3,4:2,5:5,7:7,8:2,9:3,11:11,13:13,16:2,17:17,19:19,23:23}
lam={n:arb(base[n]).log() if n in base else arb(0) for n in range(1,25)}
psi={1:arb(0)}
for n in range(2,25):psi[n]=psi[n-1]+lam[n]
for n in range(3,11):assert psi[n]<n
F=arb(0)
for n in range(1,23):
 a=arb(n);b=arb(n+1)
 nxt=F+sq2*psi[n+2]*((b/2).sqrt().atan()-(a/2).sqrt().atan())
 nxt-=2*(psi[n+1]+ka_hi)*(b.sqrt().atan()-a.sqrt().atan())
 nxt+=2*(kb_lo-ka_hi)*(1/b.sqrt()-1/a.sqrt())
 aa=lam[n+2]-kb_lo
 bb=lam[n+2]-psi[n+1]+ka_hi-3*kb_lo
 cc=2*(ka_hi-kb_lo)
 disc=bb**2-4*aa*cc
 if disc>0:
  for root in [(-bb-disc.sqrt())/(2*aa),(-bb+disc.sqrt())/(2*aa)]:
   if root>n and root<n+1:
    assert 2*aa*root+bb>0 # only a local minimum of the upper function
   else:assert root<n or root>n+1
 else:assert disc<0
 if n>=2:
  assert F>0 and nxt>0
  for end_value in [F,nxt]:
   for endpoint in [a,b]:
    assert end_value*endpoint**arb('1.5')/(endpoint-1)<arb(63)/100
 F=nxt
print('Certified: Q2(v)<.93*(exp(-v/2)-exp(-3v/2)) for every v>0.')
print('First-cell derivative upper:',M)
print('All 21 cells [2,23] satisfy ratio<.63; interior stationary points are minima.')
print('Certified psi(n)<n for n=3,...,10, giving the initial negative second tilted source.')
