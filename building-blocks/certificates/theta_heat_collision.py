"""Arb certificate for one actual theta-heat collision at negative time.

Requires python-flint 0.9.0. All infinite tails are
bounded explicitly; the contraction certificate uses the modular moment bound.
This is a numerical certificate using FLINT/Arb, not a Lean theorem.
"""
from decimal import Decimal, localcontext
from fractions import Fraction
import flint
from flint import arb, acb, ctx

ctx.dps = 75
T_TEXT = '-12.49451312964394680640550665475526188154132031167097937'
X_TEXT = '54.64245539060258447805111731866518235252412475529268007'
T = arb(T_TEXT)
X = arb(X_TEXT)
radius = arb('1e-14')
tail_error = arb('1e-100')

def phi8(u):
    q = acb.pi()*(4*u).exp()
    return sum((u-q*n*n).exp()*(2*(q*n*n)**2-3*q*n*n)
               for n in range(1,9))

def moment(t, x, k):
    def integrand(u, analytic):
        phase = x*u
        trig = [phase.cos, phase.sin, phase.cos, phase.sin][k%4]()
        sign = [1,-1,-1,1][k%4]
        return sign * (t*u*u).exp()*phi8(u)*u**k*trig
    z = sum(acb.integral(integrand, arb(j)/8, arb(j+1)/8,
                         abs_tol=arb('1e-60'), rel_tol=arb('1e-55'))
            for j in range(12))
    return z.real + arb(0, tail_error)

# For all k<=4 and t<=0, the n>=9 integral tail is bounded by this.
n_tail = 96*arb.pi()**2*9**4*(-81*arb.pi()).exp()
assert n_tail < arb('1e-102')

# The omitted u>3/2 tail for n<=8. Expand (3/2+v)^k exactly.
import math
u_tails=[]
for k in range(5):
    bound=arb(0)
    for n in range(1,9):
        rate=4*arb.pi()*n*n*arb(6).exp()-9
        poly=sum(math.comb(k,j)*(arb(3)/2)**(k-j)*math.factorial(j)/rate**(j+1)
                 for j in range(k+1))
        bound += 2*arb.pi()**2*n**4*(arb(27)/2-arb.pi()*n*n*arb(6).exp()).exp()*poly
    assert bound < arb('1e-530')
    assert bound+n_tail < tail_error
    u_tails.append(str(bound))

jet=[moment(T,X,k) for k in range(5)]
A,A1,B,C,D=jet
J=[[ -B,A1],[-C,B]]
det=J[0][0]*J[1][1]-J[0][1]*J[1][0]
Y=[[(J[1][1]/det).mid(),(-J[0][1]/det).mid()],
   [(-J[1][0]/det).mid(),(J[0][0]/det).mid()]]

# On the box, t<0. Modularity gives int_0^inf exp(u) Phi(u) du <=1/8,
# hence int u^j exp(tu^2) Phi(u) du <= j!/8.
# Mean-value bounds for the four entries of J use moments up to degree 5.
variation=[[arb(15)/4,arb(1)],[arb(18),arb(15)/4]]
Jbox=[[J[i][j]+arb(0,variation[i][j]*radius) for j in range(2)] for i in range(2)]
R=[[arb(int(i==j))-sum(Y[i][k]*Jbox[k][j] for k in range(2))
    for j in range(2)] for i in range(2)]
kappa=sum(abs(R[i][j]) for i in range(2) for j in range(2))
newton_residual=sum(abs(Y[i][0]*A+Y[i][1]*A1) for i in range(2))
assert T+radius < 0
assert kappa < 1
assert newton_residual+kappa*radius < radius
assert Jbox[1][1] < 0
Bbox=B+arb(0,arb(15)/4*radius)
Cbox=C+arb(0,18*radius)
Dbox=D+arb(0,105*radius)
schur_box=Dbox-Cbox*Cbox/Bbox
gap_second_box=8*Dbox/(3*Bbox)-16*Cbox*Cbox/(9*Bbox*Bbox)
assert schur_box > 0
assert gap_second_box < 0

rows=[]
for dt in [arb('-.01'),arb('.01')]:
    h,hx,hxx=[moment(T+dt,X,k) for k in range(3)]
    laguerre=hx*hx-h*hxx
    assert laguerre < 0 if dt < 0 else laguerre > 0
    rows.append({'dt':str(dt),'H':str(h),'Hx':str(hx),'Hxx':str(hxx),'Laguerre':str(laguerre)})

with localcontext() as decimal_context:
    decimal_context.prec=100
    endpoints={name:[str(Decimal(value)-Decimal('1e-14')),str(Decimal(value)+Decimal('1e-14'))]
               for name,value in [('t',T_TEXT),('x',X_TEXT)]}
print("Actual negative-time collision: contraction and full-tail sign checks passed.")
print("contraction bound:", kappa, "Hxx:", Bbox)
