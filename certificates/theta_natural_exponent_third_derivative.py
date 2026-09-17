"""Single compact full-theta claim: N>0 and T N'-T' N>0, 0<=v<=9.
No inference from point samples: successful leaves cover the entire interval.
Midpoints are checked only to stop immediately at a rigorous counterexample.
"""
import math
from fractions import Fraction as Q
from flint import arb, arb_series, ctx
ctx.prec = 192
ctx.cap = 8
pi = arb.pi()

def poly(cs, x):
    z = arb(0)
    for c in reversed(cs):
        z = z*x+c
    return z

def ball(a, b):
    aa = arb(a.numerator)/a.denominator
    bb = arb(b.numerator)/b.denominator
    return (aa+bb)/2 + arb(0, ((bb-aa)/2).upper())

def quantities(v, jets):
    k, k1, k2, k3, k4 = jets
    A = k+v*k1
    B = 2*k1+v*k2
    C = 3*k2+v*k3
    DD = 4*k3+v*k4
    NN = 2*A**3-A*B+v*(B*B-A*C)
    N1 = 6*A*A*B-2*A*C+v*(B*C-A*DD)
    TT = 2*k1*k1-k*k2
    T1 = 3*k1*k2-k*k3
    return NN, TT*N1-T1*NN

# Phi(u)=sum a_m u^(2m). On |u|<=1/2, |Phi|<10000, and the
# omitted theta terms n>=25 have modulus <=952*25^4 exp(-625/2).
M = 40
degree = 2*M
fact = [arb(math.factorial(j)) for j in range(degree+1)]
coeff = [arb(0)]*(degree+1)
for n in range(1,25):
    p = pi*n*n
    ex = [-p*arb(2)**j/fact[j] for j in range(degree+1)]
    ep = [(-p).exp()]
    for j in range(1,degree+1):
        ep.append(sum((i*ex[i]*ep[j-i] for i in range(1,j+1)),arb(0))/j)
    for j in range(0,degree+1,2):
        coeff[j] += sum((ep[j-i]*(4*p*p*(arb(9)/2)**i-6*p*(arb(5)/2)**i)/fact[i] for i in range(j+1)),arb(0))
disk_tail = 952*arb(25)**4*(-arb(625)/2).exp()
a = [coeff[2*m]+arb(0,(disk_tail*4**m).upper()) for m in range(M+1)]
gjets = [[-(m+1)*a[m+1] for m in range(M)]]
for j in range(5):
    old = gjets[-1]
    gjets.append([(m+1)*old[m+1] for m in range(len(old)-1)])
# At 0<=v<=1/16, 4v<=1/4. For all j<=5 the ratio in the omitted
# differentiated Cauchy coefficient series is at most 2*(1/4).
errors = [10000*arb(4)**(j+1)*arb(M+1)**(j+1)*(arb(1)/4)**(M-j)/(1-arb(1)/2) for j in range(6)]

def near(v):
    vals = [poly(cs,v)+arb(0,er.upper()) for cs,er in zip(gjets,errors)]
    gs = arb_series([z/math.factorial(j) for j,z in enumerate(vals)],prec=6)
    ks = -gs.derivative()/gs
    return quantities(v,[ks[j]*math.factorial(j) for j in range(5)])

# Write g(u^2)=g_1(u^2)*(1+R(u)), with
# g_1=exp(5u/2-pi exp(2u))*P(pi exp(2u))/(2u),
# P(y)=8y^2-30y+15 and
# R=sum_{n>=2} n^2 P(n^2 y)/P(y) exp(-(n^2-1)y).
# For real u>=1/4 and |z-u|<=1/16, Re(pi exp(2z))>4, |y|<2 Re y.
# P's roots lie in (0,1) and (0,13/4), so |P(y)|>(9/8)(Re y)^2,
# |P(n^2 y)|<68 n^4 (Re y)^2, giving |R_tail|<=
# 122*9^6 exp(-320). Cauchy bounds its j-th Taylor coefficient by
# this constant times 16^j. This is uniform in real u>=1/4.
r_tail = 122*arb(9)**6*(-arb(320)).exp()
assert r_tail < arb('1e-130')

def away(u):
    U = arb_series([u,1],prec=6)
    Y = pi*(2*U).exp()
    P = 8*Y*Y-30*Y+15
    R = arb_series([],prec=6)
    for n in range(2,9):
        Yn = n*n*Y
        R += n*n*(8*Yn*Yn-30*Yn+15)/P*(-(n*n-1)*Y).exp()
    R = arb_series([R[j]+arb(0,(r_tail*16**j).upper()) for j in range(6)],prec=6)
    # Constant log(pi/2) is irrelevant to every derivative.
    logg = arb(5)/2*U-Y+P.log()-U.log()+(1+R).log()
    ks = -logg.derivative()/(2*U)
    jets = []
    for j in range(5):
        jets.append(ks[0])
        if j<4:
            ks = ks.derivative()/(2*U)
    return quantities(u*u,jets)

def certify(fn, lo, hi, label):
    stack = [(lo,hi)]
    leaves = 0
    tested = 0
    while stack:
        a,b = stack.pop()
        try:
            nn,dd = fn(ball(a,b))
        except ValueError:
            # A broad interval can enclose zero in a positive denominator.
            # Subdivision resolves this; no mathematical sign is inferred.
            nn,dd = arb('nan'),arb('nan')
        tested += 1
        if nn>0 and dd>0:
            leaves += 1
        else:
            m = (a+b)/2
            mn,md = fn(ball(m,m))
            if mn<0 or md<0:
                print('NEGATIVE exact-rational point',label,m,'N=',mn,'D=',md,flush=True)
                raise SystemExit(2)
            assert b-a>Q(1,10**10), ('UNRESOLVED',label,a,b,nn,dd)
            stack.extend([(m,b),(a,m)])
        if tested % 100000 == 0:
            print('Mathematical coverage',label,'completed through',a,'accepted leaves',leaves,flush=True)
    print('CERTIFIED N>0 and T*N-prime-T-prime*N>0 on',label,'with',leaves,'intervals',flush=True)

certify(near,Q(0),Q(1,16),'0<=v<=1/16')
certify(away,Q(1,4),Q(3),'1/4<=u<=3')
print('Normalized theta-tail disk bound:',r_tail,flush=True)
print('Conclusion: BOTH order-three signs hold for EVERY 0<=v<=9.',flush=True)
