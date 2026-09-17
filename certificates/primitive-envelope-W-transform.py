"""Arb proof of the bounded-cell constants for P <= .93*(exp(-v/2)-exp(-3v/2))."""
from flint import arb, ctx

ctx.prec=192
klo=arb(2789)/10000
khi=arb(279)/1000
c=arb(93)/100
assert arb(2).log()/2-klo/arb(2).sqrt()<arb(15)/100
assert arb(15)/100*2*arb(2).sqrt()<arb(43)/100
assert arb(43)/100<c
p={2:2,3:3,4:2,5:5,7:7,8:2,9:3,11:11,13:13,16:2,17:17,19:19,23:23}
F=arb(0);psi=arb(0)
for n in range(1,23):
 lam=arb(p[n+1]).log() if n+1 in p else arb(0)
 if n+1 in p:assert lam>klo
 pn=psi+lam
 a,b=arb(n).sqrt(),arb(n+1).sqrt()
 Fn=F+2*pn*(b.atan()-a.atan())+2*(psi+klo)*(1/b-1/a)
 if n>=2:
  # Every combination of endpoint F-values and endpoint reciprocal envelopes.
  for f in [F,Fn]:
   for x in [arb(n),arb(n+1)]:
    assert f*x*x.sqrt()/(x-1)<arb(63)/100
  print('certified cell',n,'to',n+1,': upper ratio < 63/100')
 F=Fn;psi=pn
z=(arb(23).log()/(arb(1291)/200)).sqrt()
epsilon=(8/(17*arb.pi())).sqrt()*z.sqrt()*(-z).exp()
assert z>arb(1)/2
assert 2*(khi+epsilon)<arb(88)/100
assert arb(88)/100<c*22/23
print('PNT tail: 2*(kappa+epsilon23)<88/100<(93/100)*(22/23)')
print('all-age envelope constant 93/100 certified using the stated PNT input')
