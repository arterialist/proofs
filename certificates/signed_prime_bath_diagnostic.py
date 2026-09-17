"""Numerical finite compressions; separate rational infinite-bath certificate."""
import math
from pprint import pprint
from fractions import Fraction as F
import numpy as np
import mpmath as mp
from scipy.special import digamma, expit
from scipy.integrate import quad
from scipy.linalg import null_space, eigvalsh
from numpy.polynomial.legendre import leggauss
mp.mp.dps=70
B=1.; cells=256; d=2*B/cells; kap=64.; X=math.exp(2*B)
ns=np.array([2.,3.,4.,5.,7.]); lam=np.log([2.,3.,2.,5.,7.]); weights=lam/np.sqrt(ns)
md=mp.mpf(2)/cells
Is=mp.sinh(md/2)-md/2
mc=4*mp.sinh(md/4)/md
Ic=mp.sinh(md/2)+md/2-16*mp.sinh(md/4)**2/md
ss,sc,mm=float(mp.sqrt(Is)),float(mp.sqrt(Ic)),float(mc-1)
xg,wg=leggauss(10)
def vals(y):
    return np.array([np.ones_like(y)/math.sqrt(d),np.sinh(y/2)/ss,(2*np.sinh(y/4)**2-mm)/sc])
def overlap(r,v):
    lo=max(-d/2,r*d-v-d/2);hi=min(d/2,r*d-v+d/2)
    if hi<=lo:return np.zeros((3,3))
    y=(lo+hi)/2+(hi-lo)/2*xg
    return (vals(y+v-r*d)*wg)@vals(y).T*(hi-lo)/2

def build(order):
    g,w=leggauss(order)
    a=np.zeros((cells,3,3));k=a.copy();c=a.copy();j=a.copy()
    h0=float(digamma(.25)-math.log(math.pi))
    ker=lambda v:2*math.exp(-v/2)/(-math.expm1(-2*v))
    # Tail includes all v >= delta, where diagonal correlation is zero.
    a[0]=(h0+quad(ker,d,np.inf,epsabs=1e-11)[0])*np.eye(3)
    for ell in range(cells):
        for z,wz in zip(g,w):
            v=d*(ell+(1+z)/2);dv=d*wz/2
            for r in (ell,ell+1):
                if r>=cells:continue
                ov=overlap(r,v)
                if r==0:
                    sym=ov+ov.T
                    a[0]+=dv*ker(v)*(np.eye(3)-sym/2)
                    k[0]+=dv*math.exp(-v/2)*sym
                    c[0]+=dv*math.exp(v/2)*expit(-kap*(v-2*B))*sym
                else:
                    a[r]-=dv*ker(v)*ov/2
                    k[r]+=dv*math.exp(-v/2)*ov
                    c[r]+=dv*math.exp(v/2)*expit(-kap*(v-2*B))*ov
    for n,wt in zip(ns,weights):
        v=math.log(n);ell=int(v/d)
        for r in (ell,ell+1):
            if r<cells:j[r]+=wt*expit(-kap*(v-2*B))*overlap(r,v)
    def assemble(blocks):
        out=np.zeros((3*cells,3*cells))
        for r,block in enumerate(blocks):
            for i in range(cells-r):
                out[3*(i+r):3*(i+r+1),3*i:3*(i+1)]=block
                if r:out[3*i:3*(i+1),3*(i+r):3*(i+r+1)]=block.T
        return out
    centers=-B+(np.arange(cells)+.5)*d
    yy=d*xg/2
    poles=[]
    for sign in [1,-1]:
        loc=vals(yy)@(wg*np.exp(sign*yy/2))*d/2
        poles.append(np.concatenate([loc*math.exp(sign*cc/2) for cc in centers]))
    rows=np.array(poles);u=null_space(rows)
    aa,kk,cc,jj=[u.T@assemble(b)@u for b in [a,k,c,j]]
    ff=aa+kk;dd=jj-cc
    # Actual unregulated J has precisely the same overlap, with weights restored.
    j0=j.copy()
    for n,wt in zip(ns,weights):
        v=math.log(n);ell=int(v/d)
        for r in (ell,ell+1):
            if r<cells:j0[r]+=wt*expit(kap*(v-2*B))*overlap(r,v)
    actualj=u.T@assemble(j0)@u
    return {'quadrature_order':order,'retained_dimension':u.shape[1],
        'moment_residual':float(np.linalg.norm(rows@u)),
        'F_min':float(eigvalsh(ff,subset_by_index=[0,0])[0]),
        'D_min_max':list(map(float,[eigvalsh(dd,subset_by_index=[0,0])[0],eigvalsh(dd,subset_by_index=[len(dd)-1,len(dd)-1])[0]])),
        'D_relative_to_F_plus_6I_max':float(eigvalsh(dd,ff+6*np.eye(len(dd)),subset_by_index=[len(dd)-1,len(dd)-1])[0]),
        'D_minus_095F_max':float(eigvalsh(dd-.95*ff,subset_by_index=[len(dd)-1,len(dd)-1])[0]),
        'q_retained_min':float(eigvalsh(aa-actualj,subset_by_index=[0,0])[0]),
        'K_max':float(eigvalsh(kk,subset_by_index=[len(dd)-1,len(dd)-1])[0]),
        'compensation_identity_residual':float(np.linalg.norm(ff-dd-(aa-jj+cc+kk)))}

def rational_certificate():
    delta=F(1,128);T=200;a=F(1,6);b=F(1001,24000);c=delta*F(1001,192000)
    inte=a*a*T**7/7+2*a*c*T**6/6+(c*c+2*a*b)*T**5/5+2*b*c*T**4/4+b*b*T**3/3
    eps=2*delta**6*inte/(448*F(3141,1000))
    R=F(3386,1000);H=F(5373,1000);S=F(2927,1000)
    alpha=R-(R+H)*eps
    Kupper=4*eps+1/F(40000)
    # Full continuum loss norm <= 2 e/(kappa+.5), using e<2.719.
    rho=2*F(2719,1000)/F(129,2)
    # S_kappa <= S; cancellation avoids needing a numerical logistic enclosure.
    theta=F(19,20)
    C=S+rho+(1-theta)*Kupper-theta*alpha
    return {'epsilon_fraction':str(eps),'epsilon_upper':float(eps),'A_high_lower':float(alpha),'K_high_upper':float(Kupper),'q_high_lower':float(alpha-S),'D_relative_theta':float(theta),'D_relative_C_upper':float(C),'continuum_loss_upper':float(rho),'D_high_L2_upper':float(S+Kupper+rho)}
if __name__=='__main__':
    result={'status':'Finite matrices are floating diagnostics, not interval certified. Bath constants have a separate analytic/rational proof.','B':B,'cells':cells,'kappa':kap,'prime_powers':ns.tolist(),'prime_schur':float(sum(weights)),'certificate':rational_certificate(),'finite':[build(12),build(20)]}
    pprint(result)
