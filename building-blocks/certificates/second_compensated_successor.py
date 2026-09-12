"""Bounded rigorous second-successor sign test; full analytic tails are in the note."""
import math
from flint import arb, arb_series, ctx
# Requires python-flint 0.9.0.
ctx.prec=192
K=40
l2=arb(2).log();l3=arb(3).log();pi=arb.pi()
kap=arb(0);rest=arb(0)
for j in range(1,K+1):
    z=arb_series([arb(2*j+1)/2,arb(1)],prec=2).zeta()
    D=-z[1]/z[0]
    coeff=arb(math.comb(2*j,j))/(4**j*(2*j+1))
    kap+=coeff*D
    rest+=coeff*(2**j-1)*(D-l2/(arb(2)**j*arb(2).sqrt()))
r=arb(2*K+1)/2
C2=l2+2*l2/r+2/r**2
kap_tail=C2/(arb(2)**K*arb(2).sqrt()*(2*K+3))
C3=l3+3*l3/r+3/r**2
rest_tail=3*C3/(arb(3).sqrt()*(2*K+3))*(arb(2)/3)**(K+1)
raw=l2*(arb(2).sqrt().atan()/arb(2).sqrt()-pi/4)+rest
kb=raw+(1-pi/4)*kap
kb_tail=rest_tail+(1-pi/4)*kap_tail
ka_lo=arb(2789)/10000;ka_hi=arb(279)/1000
kb_lo=arb(2529)/10000;kb_hi=arb(253)/1000
assert kap>ka_lo and kap+kap_tail<ka_hi
assert kb>kb_lo and kb+kb_tail<kb_hi
print('kappa partial:',kap)
print('kappa omitted upper:',kap_tail)
print('kappa_b partial:',kb)
print('kappa_b omitted upper:',kb_tail)
print('certified charge intervals: .2789<kappa<.279; .2529<kappa_b<.253')
base={2:2,3:3,4:2,5:5,7:7,8:2,9:3,11:11,13:13,16:2,17:17,19:19,23:23}
lam={n:arb(base[n]).log() if n in base else arb(0) for n in range(1,25)}
psi={1:arb(0)}
for n in range(2,25):psi[n]=psi[n-1]+lam[n]
def increment(n,x):
    a=arb(n)
    val=arb(2).sqrt()*psi[n+2]*((x/2).sqrt().atan()-(a/2).sqrt().atan())
    val-=2*(psi[n+1]+ka_lo)*(x.sqrt().atan()-a.sqrt().atan())
    val+=2*(kb_hi-ka_lo)*(1/x.sqrt()-1/a.sqrt())
    return val
F=arb(0);interior=[]
for n in range(1,23):
    aa=lam[n+2]-kb_hi
    bb=lam[n+2]-psi[n+1]+ka_lo-3*kb_hi
    cc=2*(ka_lo-kb_hi)
    disc=bb**2-4*aa*cc
    nxt=F+increment(n,arb(n+1))
    if n==1:
        assert aa>0 and disc<0
    else:
        assert F>arb(1)/20
    assert nxt>arb(1)/20
    if disc>0:
        for root in [(-bb-disc.sqrt())/(2*aa),(-bb+disc.sqrt())/(2*aa)]:
            if root>n and root<n+1:
                val=F+increment(n,root)
                assert val>arb(1)/20
                interior.append((n,str(root),str(val)))
            else:
                assert root<n or root>n+1
    else:
        assert disc<0
    F=nxt
print('all cell minima on [2,23] exceed 1/20; first cell increases from zero')
for n,root,value in interior:print('interior stationary test',n,root,value)
# The same actual PNT input as the first-stage proof, evaluated once at 23.
z=(arb(23).log()/arb(6455)*1000).sqrt()
eps=(arb(8)/(17*pi)).sqrt()*z.sqrt()*(-z).exp()
assert eps<arb(162)/1000
assert 2*(kb_lo-arb(162)/1000-ka_hi/(3*23))>arb(1)/6
print('epsilon_23:',eps)
print('tail bound certified: Q2(log x)>1/(6 sqrt x), x>=23')
