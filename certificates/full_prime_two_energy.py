"""Full all-prime actual N=2 original-energy lower bound.
Arb arithmetic, exact sieve, primary Dusart theta remainder, full-power sectors.
No finite-prime Loewner result is used as an operator inequality.
"""
# Requires python-flint 0.9.0; all mathematical inputs are fixed below.
import bisect, math
from flint import arb, arb_poly, ctx
ctx.prec=160
P=40000; H=24; V=12; cells_per_age=128; max_age=H+V+2
step=arb(1)/cells_per_age
l2=arb(2).log(); A=2-l2
kappa=2*arb(2).sqrt()-1-l2/arb(2).sqrt()-arb.pi()*A/4
U=1+arb(1)/36260
assert arb(P)>32321
assert (arb(H)/2).exp()>32321

# Source constants, with an alternating-series enclosure for Catalan's constant.
catlo=sum((arb((-1)**j)/(2*j+1)**2 for j in range(1000)),arb(0))
cathi=catlo+arb(1)/2001**2
C0=2*(arb(2).sqrt()-1)+arb(2).sqrt()*A
C1=4-4*arb(2).sqrt()+2*l2*arb(2).sqrt()+arb(2).sqrt()*A*(l2+2)
MPlo=-C1+4*A*catlo+4*kappa; MPhi=-C1+4*A*cathi+4*kappa
assert C0>arb('2.67') and C0<arb('2.68')
assert C1<arb('5.29') and MPlo>0 and MPhi<arb('.76')
Va=2*arb(2).sqrt()-1+l2/arb(2).sqrt(); Vf=4*arb(2).sqrt()-2

# For t>=H, every t^3-scaled summand below decreases.
def scaled_kernel_error(t):
    t=arb(t)
    return (480/t+U*arb(9)/2*t**2*(-t/6).exp()
        +U*arb(16)/3*t**2*(-t/4).exp()
        +t**3*(t/(3*l2)).log()*(-3*t/10).exp()
        +(t/l2+1)*t**3*(-t/2).exp()+t**3*(-3*t/2).exp())
K=arb(105)
assert scaled_kernel_error(H)<K
assert arb(H)**3*(2/arb(H)+K/arb(H)**3)>0

sieve=bytearray(b'\x01')*(P+1);sieve[0:2]=b'\x00\x00'
for n in range(2,math.isqrt(P)+1):
    if sieve[n]:sieve[n*n::n]=b'\x00'*(((P-n*n)//n)+1)
primes=[n for n in range(2,P+1) if sieve[n]]
maxj=math.ceil(max_age/math.log(2))+1
prefix={}
for j in range(1,maxj+1):
    row=[arb(0)]
    for p in primes:row.append(row[-1]+arb(1)/p**(j+1))
    prefix[j]=row
print('Exact prime list and reciprocal-power tables ready.',flush=True)

# Each floating guess for a floor is verified by exact Arb comparisons.
def count_exp(v):
    ev=v.exp()
    if ev>=P:return len(primes)
    f=int(float(ev))
    assert arb(f)<=ev and ev<arb(f+1)
    return bisect.bisect_right(primes,f)

def theta_tail_error(logx,j):
    # |sum_{p>x}p^(-j-1)-integral_x^infty t^(-j-1)/log t dt|
    return (2+arb(1)/j)*10*(-j*logx).exp()/logx**4

logP=arb(P).log()
def node(t):
    t=arb(t)
    finite=arb(0)
    for j in range(1,maxj+1):
        if t/j<l2:break
        lo=count_exp(t/(j+1));hi=count_exp(t/j)
        finite+=prefix[j][hi]-prefix[j][lo]
    model=arb(0); error=arb(0)
    for j in range(1,maxj+1):
        upper=t/j
        if upper<=logP:break
        lower=max(logP,t/(j+1))
        model+=(-j*upper).ei()-(-j*lower).ei()
        error+=theta_tail_error(lower,j)+theta_tail_error(upper,j)
    scale=(t/2).exp()
    central=scale*(finite+model);err=scale*error
    return max(arb(0),central-err),central+err

# Use exact dyadic floats outside proved Arb balls for min/max operations.
def lower_float(x):
    z=float(x)-1e-12
    assert arb(z)<x
    return max(0.,z)
def upper_float(x):
    z=float(x)+1e-12
    assert arb(z)>x
    return z

N=max_age*cells_per_age
nodes=[node(arb(i)/cells_per_age) for i in range(N+1)]
print('All-prime node enclosures ready.',flush=True)
lo=[];hi=[]
for i in range(N):
    left=arb(i)/cells_per_age;right=arb(i+1)/cells_per_age
    birth=prefix[1][count_exp(right)]-prefix[1][count_exp(left)]
    if right>logP:
        a=max(left,logP);b=right
        # Upper bound for theta(e^b)-theta(e^a), divided by min p^2 log p.
        excess=b.exp()-a.exp()+10*b.exp()/b**3+10*a.exp()/a**3
        birth+=excess*(-2*a).exp()/a
    birth*= (right/2).exp()
    lo.append(lower_float((-step/2).exp()*nodes[i+1][0]-birth))
    hi.append(upper_float((step/2).exp()*nodes[i][1]+birth))
assert max(hi)<2
# Beyond max_age, the tail bound is <2 and decreasing.
assert 2/arb(max_age)+K/arb(max_age)**3<2
print('Whole-cell enclosures ready; global B<2.',flush=True)

pairlo=[arb(min(lo[i],lo[i+1])) for i in range(N-1)]
pairhi=[arb(max(hi[i],hi[i+1])) for i in range(N-1)]

def corr(weights,values):
    # Exact interval polynomial multiplication, not floating FFT quadrature.
    prod=arb_poly(list(reversed(values)))*arb_poly(weights)
    return [prod[len(values)-1-i] for i in range(H*cells_per_age)]

# Old-source integral, retaining the partial endpoint at log 2.
wold=[]
for j in range(math.ceil(float(l2)*cells_per_age)):
    l=arb(j)/cells_per_age;r=min(arb(j+1)/cells_per_age,l2)
    wold.append(2*((r/2).exp()-(l/2).exp()))
oldlo=corr(wold,pairlo);oldhi=corr(wold,pairhi)

# New source density; tail v>=V bounded by Bmax*(2/3)exp(-3V/2).
def primitive(v):
    t=(v/2).exp()
    return t/(1+t*t)+t.atan()
wnew=[primitive(arb(j+1)/cells_per_age)-primitive(arb(j)/cells_per_age)
      for j in range(V*cells_per_age)]
newlo=corr(wnew,pairlo);newhi=corr(wnew,pairhi)
source_tail=arb(4)/3*(-arb(3)*V/2).exp()
shift=int(float(l2)*cells_per_age)
assert arb(shift)/cells_per_age<l2 and l2<arb(shift+1)/cells_per_age
Icore=arb(0)
for i in range(H*cells_per_age):
    sl=arb(min(lo[i+shift],lo[i+shift+1]))
    sh=arb(max(hi[i+shift],hi[i+shift+1]))
    yl=arb(lo[i])-l2/arb(2).sqrt()*sh+oldlo[i]
    yh=arb(hi[i])-l2/arb(2).sqrt()*sl+oldhi[i]
    nl=(A/2+kappa)*arb(lo[i])+A*newlo[i]
    nh=(A/2+kappa)*arb(hi[i])+A*(newhi[i]+source_tail)
    if yl>=0:ysq=yl*yl
    elif yh<=0:ysq=yh*yh
    else:ysq=arb(0)
    Icore+=step*(ysq-nh*nh)
print('Certified coherent negative-age core norm difference:',Icore,flush=True)

# Continuum term J(2Y-J) is nonnegative for all h>=H.
assert 2*C0*H-(2*C1+MPhi)>0
Etail=(2*C0*Vf*K/(3*arb(H)**3)
       +MPhi*(Va+Vf)*K/(2*arb(H)**4)
       +(2*Va*Vf+Vf*Vf)*K*K/(5*arb(H)**5))
# Positive physical ages x>1: old output vanishes. Every new prime and power is bounded.
positive_age_loss=A*A*(arb.pi()**2/6-arb(3)/2)**2/3
Ilower=Icore-Etail-positive_age_loss
# Full retained K margin from four exact core masses. Every later prime
# has c_p-m_p>0 by kappa log p/[p(p-1)] > A/[p^2(p+1)].
assert kappa>arb('.31') and A<arb('1.31')
core_mass=arb(0); old_mass=arb(0)
for p in [2,3,5,7]:
    cp=A/p*sum((arb(p)**(-j)*(arb(1+p**(j+1))/(1+p**j)).log()
               for j in range(1,25)),arb(0))
    cp+=kappa*arb(p).log()/(p*(p-1))
    mp=A*arb(p).log()/(p*(p-1))
    assert cp>mp
    core_mass+=cp;old_mass+=mp
mass_margin=core_mass*core_mass-old_mass*old_mass
energy_lower=4*Ilower+mass_margin
print('Retained full K-minus-old-mass margin lower:',mass_margin)
print('Coherent infinite negative-age tail error upper:',Etail)
print('Entire positive-age norm loss upper:',positive_age_loss)
print('Full norm difference lower:',Ilower)
print('Full original-energy decrease lower:',energy_lower)
assert energy_lower>arb(1)/200
print('CERTIFIED: actual full-prime N=2 old energy minus compensated energy > 1/200.')
