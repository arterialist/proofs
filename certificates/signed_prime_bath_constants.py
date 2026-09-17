"""Exact rational enclosures used in the analytic bath certificate."""
from fractions import Fraction as F
from math import isqrt

def atan_bounds(x, terms=32):
    s=sum(((-1)**j*x**(2*j+1)/F(2*j+1) for j in range(terms)),F())
    nxt=(-1)**terms*x**(2*terms+1)/F(2*terms+1)
    return min(s,s+nxt),max(s,s+nxt)
a,b=atan_bounds(F(1,5));c,d=atan_bounds(F(1,239))
pi_lo,pi_hi=16*a-4*d,16*b-4*c

def log_base(x, terms=40):
    z=(x-1)/(x+1)
    assert 0<=z<=F(1,3)
    s=2*sum((z**(2*j+1)/F(2*j+1) for j in range(terms)),F())
    tail=2*z**(2*terms+1)/(F(2*terms+1)*(1-z*z))
    return s,s+tail
L2,U2=log_base(F(2))
def log_bounds(x):
    x=F(x);k=0
    while x>2:x/=2;k+=1
    while x<1:x*=2;k-=1
    l,u=log_base(x)
    return (l+k*L2,u+k*U2) if k>=0 else (l+k*U2,u+k*L2)
assert pi_lo>F(3141,1000) and pi_hi<F(22,7)
# gamma <= H_n-log n-1/(2(n+1)); see report for integral proof.
n=1000
h=sum((F(1,j) for j in range(1,n+1)),F())
gamma_hi=h-log_bounds(n)[0]-F(1,2*(n+1))
H_hi=log_bounds(pi_hi)[1]+gamma_hi+pi_hi/2+3*U2
assert H_hi<F(5373,1000)
R_lo=log_bounds(F(700,22))[0]-F(4,65)-F(124,10000)
assert R_lo>F(3386,1000)
S_hi=F()
for n,p in [(2,2),(3,3),(4,2),(5,5),(7,7)]:
    rootlo=F(isqrt(n*10**24),10**12)
    S_hi+=log_bounds(p)[1]/rootlo
assert S_hi<F(2927,1000)
# exp upper via finite Taylor and geometric tail.
def exp_upper(x, terms=30):
    term=F(1);s=term
    for j in range(1,terms):term*=x/j;s+=term
    nxt=term*x/terms
    return s+nxt/(1-x/F(terms+1))
assert exp_upper(F(1))<F(2719,1000)
# cosh(delta/4) <= exp(delta/4) is too coarse; use even series.
x=F(1,512)
cs=sum((x**(2*j)/F(__import__('math').factorial(2*j)) for j in range(12)),F())
ct=x**24/F(__import__('math').factorial(24))/(1-x*x/F(25*26))
assert cs+ct<F(1001,1000)
print('PASS: exact rational enclosures for pi, H, R, Schur S, e, and cosh(delta/4).')
print('bounds',{'H':float(H_hi),'R':float(R_lo),'S':float(S_hi)})


# Exact leakage integration and the final coercivity/relative-form margins.
delta=F(1,128); T=200; a=F(1,6); b=F(1001,24000); c=delta*F(1001,192000)
inte=a*a*T**7/7+2*a*c*T**6/6+(c*c+2*a*b)*T**5/5+2*b*c*T**4/4+b*b*T**3/3
eps=2*delta**6*inte/(448*F(3141,1000))
assert eps==F(157289603731413872114125,9582029776036901406375936)
alpha=F(3386,1000)-F(8759,1000)*eps
ku=4*eps+F(1,40000)
rho=2*F(2719,1000)/F(129,2)
relative=F(2927,1000)+rho+ku/20-F(19,20)*alpha
assert alpha>F('3.2422204802')
assert ku<F('0.0656852442')
assert alpha-F(2927,1000)>F('0.3152204802')
assert relative<-F('0.0655151165')
print('PASS: exact leakage fraction, full bath coercivity, and signed relative margin.')
