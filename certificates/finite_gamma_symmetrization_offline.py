"""Certified off-line zero of a finite BPY gamma-Mellin symmetrization.

Reproduce with: uv run --with python-flint==0.9.0 python certificates/finite_gamma_symmetrization_offline.py
The certificate concerns F_128, not the Riemann xi function.
"""

from math import factorial

from flint import acb, arb, ctx

ctx.prec = 320
N = 128
center_re = '0.28697936359458129186726727883478092687107342745132051469284157211'
center_im = '34453.494087897740158977956570756121584446430646858921341269243062'
rad_str = '1e-20'
rad = arb(rad_str)
pi = arb.pi(); logpi=pi.log(); half=arb('0.5'); threehalf=arb('1.5')
fN=factorial(N)
js=[]; weights=[]; cs=[]; ljs=[]
for j in range(1,N+1):
    rat = arb(fN)**2/(arb(factorial(N+j))*arb(factorial(N-j)))
    js.append(j); weights.append(rat*rat); ljs.append(arb(j).log())
    cs.append(-2*j*j*sum((1/arb(k*k-j*j) for k in range(1,N+1) if k!=j),arb(0)))

def qs(s):
    q=acb(0); d=acb(0); dd=acb(0)
    for j,w,c,l in zip(js,weights,cs,ljs):
        a=acb(w)*(-2*s*l).exp()
        v=s+1+c
        q += a*v
        d += a*(1-2*l*v)
        dd += a*((2*l)**2*v-4*l)
    return q,d,dd

def components(s):
    q,qp,qpp=qs(s)
    v,vp,vpp=qs(half-s)
    r=( (threehalf-s).lgamma()-(1+s).lgamma()+(2*s-half)*logpi ).exp()
    dl=-(threehalf-s).digamma()-(1+s).digamma()+2*logpi
    ddl=(threehalf-s).polygamma(1)-(1+s).polygamma(1)
    g=q+r*v
    gp=qp+r*(dl*v-vp)
    gpp=qpp+r*((dl*dl+ddl)*v-2*dl*vp+vpp)
    return g,gp,gpp

s0=acb(arb(center_re),arb(center_im))
g,gp,_=components(s0)
sdisc=acb(arb(center_re+' +/- '+rad_str),arb(center_im+' +/- '+rad_str))
_,_,gpp=components(sdisc)
print('N',N)
print('center',s0)
print('radius',rad)
print('G(center) abs upper',abs(g).upper())
print('Gprime(center) abs lower',abs(gp).lower())
print('Gsecond(disc) abs upper',abs(gpp).upper())
lhs=abs(g).upper()+abs(gpp).upper()*rad*rad/2
rhs=abs(gp).lower()*rad
print('Rouche lhs upper',lhs.upper())
print('Rouche rhs lower',rhs.lower())
if not (lhs.upper() < rhs.lower()):
    raise RuntimeError('Rouche inequality was not certified')
if not (arb(center_re) - rad > arb('0.25')):
    raise RuntimeError('The certified disk meets the symmetry line')
print('CERTIFIED: one zero in the disk; disk entirely right of Re(s)=1/4')
