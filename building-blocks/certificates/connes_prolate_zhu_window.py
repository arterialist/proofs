"""Rational checks for the prolate a=4/5 endpoint residual note.

mpmath generates candidate Jacobi eigenpairs only. Fraction arithmetic
checks their residuals, Sturm counts, endpoint evaluations, polynomial
norm, and ODE Taylor majorants. The note supplies the infinite-tail
and Weil-operator inequalities used with these finite checks.
"""

from fractions import Fraction as Q
from math import factorial, comb
import mpmath as mp

N=36
mp.mp.dps=100

def q(v): return Q(str(v))
def clamp_interval(lo,hi,d=70):
    u=10**d
    return Q((lo*u).__floor__(),u),Q(-((-hi*u).__floor__()),u)
def exp_interval(x,M=100):
    s=Q(0); term=Q(1)
    for n in range(M+1):
        if n:term*=x/n
        s+=term
    nxt=term*x/(M+1)
    return s,s+nxt/(1-x/Q(M+2))
def atan_interval(x,M=100):
    s=sum(((-1)**n*x**(2*n+1)/Q(2*n+1) for n in range(M)),Q(0))
    err=x**(2*M+1)/Q(2*M+1)
    return (s,s+err) if M%2==0 else (s-err,s)
def add(A,B):return A[0]+B[0],A[1]+B[1]
def sub(A,B):return A[0]-B[1],A[1]-B[0]
def mul(A,B):
    v=[x*y for x in A for y in B]
    return min(v),max(v)
def pospow(A,n):
    assert A[0]>0
    return A[0]**n,A[1]**n
pi5=atan_interval(Q(1,5));pi239=atan_interval(Q(1,239))
PI=clamp_interval(*sub(mul((Q(16),Q(16)),pi5),mul((Q(4),Q(4)),pi239)))
LAM=clamp_interval(*exp_interval(Q(4,5)))
EXP16=clamp_interval(*exp_interval(Q(16,5)))
EXP8=clamp_interval(*exp_interval(Q(8,5)))
C2=clamp_interval(*mul((Q(4),Q(4)),mul(pospow(PI,2),EXP16)))
assert C2[0]>Q(968) and C2[1]<Q(970)
assert C2[1]-C2[0]<Q(1,10**60)
cmid=(C2[0]+C2[1])/2
lmid=(LAM[0]+LAM[1])/2
c_mp=2*mp.pi*mp.exp(mp.mpf(8)/5)

# Candidate generation only; every spectral claim below is checked in Q.
def alpha(l):
    return mp.mpf(l)/mp.sqrt((2*l-1)*(2*l+1)) if l else mp.mpf(0)
S=mp.matrix(N)
for k in range(N):
    l=2*k
    S[k,k]=l*(l+1)+c_mp*c_mp*(alpha(l+1)**2+alpha(l)**2)
    if k+1<N:S[k,k+1]=S[k+1,k]=c_mp*c_mp*alpha(l+1)*alpha(l+2)
eig,V=mp.eigsy(S)
E={j:q(mp.nstr(eig[j],60)) for j in (0,2)}
b={j:[q(mp.nstr(V[k,j]*mp.sqrt(mp.mpf(4*k+1)/2),60)) for k in range(N)] for j in (0,2)}

def diag(k,c2):
    l=2*k
    return Q(l*(l+1))+c2*(Q((l+1)**2,(2*l+1)*(2*l+3))+(Q(l*l,(2*l+1)*(2*l-1)) if l else Q(0)))
def down(l): return Q(l*(l-1),(2*l+1)*(2*l-1))
def up(l): return Q((l+1)*(l+2),(2*l+1)*(2*l+3))
def product_off(k,c2):
    l=2*k
    return c2*c2*up(l)*down(l+2)
def sturm(T,c2):
    p=diag(0,c2)-T; n=int(p<0)
    assert p
    for k in range(1,N):
        p=diag(k,c2)-T-product_off(k-1,c2)/p
        assert p
        n+=int(p<0)
    return n
for T,count in [(Q(90),1),(Q(210),2),(Q(325),3)]:
    for shift in [-20,20]:
        assert sturm(T+shift,C2[0])==count
        assert sturm(T+shift,C2[1])==count
# The omitted Jacobi block is at least 72*73 by the prolate ODE form.
# Its Schur correction at the widest tested threshold is below 20.
ln=2*N
beta2=C2[1]**2 * Q((ln-1)**2,(2*ln-3)*(2*ln-1)) * Q(ln**2,(2*ln-1)*(2*ln+1))
assert beta2/Q(ln*(ln+1)-345)<20
print('sturm counts verified')

def normsq(v):return sum((Q(2,4*k+1)*v[k]*v[k] for k in range(len(v))),Q(0))
for j in (0,2):
    v=b[j];ev=E[j]
    assert Q(999,1000)<normsq(v)<Q(1001,1000)
    assert Q(2,4*N-3)*v[-1]**2<Q('2e-25')**2
    errs=[]
    for k in range(N):
        l=2*k
        # Coefficient of P_l in L(sum v_j P_{2j}).
        def rr(c2):
            a=(diag(k,c2)-ev)*v[k]
            if k:a+=c2*up(l-2)*v[k-1]
            if k+1<N:a+=c2*down(l+2)*v[k+1]
            return a
        z=[rr(C2[0]),rr(C2[1])]
        errs.append(max(abs(z[0]),abs(z[1])))
    tail=max(C2)*up(2*N-2)*abs(v[-1])
    rsq=sum((Q(2,4*k+1)*errs[k]**2 for k in range(N)),Q(0))+Q(2,4*N+1)*tail**2
    assert rsq<Q(1,10**42)
    print('pair',j,'eigenvalue',float(ev),'residual<1e-21')

# Integral-one polynomial H = h_4 - h_0 in the physical variable.
coef=[b[2][k]/(2*lmid*b[2][0])-b[0][k]/(2*lmid*b[0][0]) for k in range(N)]
assert coef[0]==0

def legendre_values(t):
    P0=Q(1);P1=t;out=[P0]
    for l in range(1,2*N):
        P2=(Q(2*l+1)*t*P1-Q(l)*P0)/Q(l+1)
        if (l+1)%2==0:out.append(P2)
        P0,P1=P1,P2
    return out

def heval(t):
    p=legendre_values(t)
    return sum((coef[k]*p[k] for k in range(N)),Q(0))
H1=sum(coef,Q(0))
assert Q('1.0761e-8')<H1<Q('1.0763e-8')
assert Q(754)<sum(abs(coef[k])*Q((2*k)*(2*k+1),2) for k in range(N))<Q(800)
assert sum(abs(coef[k])*Q((2*k+2)*(2*k+1)*(2*k)*(2*k-1),8) for k in range(1,N))<Q(50000)
# Apply a wide rational enclosure to 1/sqrt(lambda), sqrt(lambda).
assert Q('1.49')**2<LAM[0] and LAM[1]<Q('1.50')**2
assert Q('1.60e-8')<Q('1.49')*H1
Bmsum=sum((heval(Q(n)/((EXP8[0]+EXP8[1])/2)) for n in range(1,5)),Q(0))
assert Q('2.78e-8')<Bmsum<Q('2.79e-8')
print('endpoint H1',float(H1),'Bminus sum',float(Bmsum))

# Values of one-sided k' at the translated jump sites, excluding the tiny s perturbation.
def pder(t):
    # exact polynomial derivative via Legendre identity at interior rationals;
    # at t=1 use the endpoint derivative.
    if t==1:return sum((coef[k]*Q((2*k)*(2*k+1),2) for k in range(N)),Q(0))
    p=legendre_values(t)
    return sum((coef[k]*Q(2*k)*(t*p[k]-legendre_odd(2*k-1,t))/(t*t-1) for k in range(1,N)),Q(0))
def legendre_odd(l,t):
    P0=Q(1);P1=t
    if l==1:return P1
    for z in range(1,l):P0,P1=P1,(Q(2*z+1)*t*P1-Q(z)*P0)/Q(z+1)
    return P1
for n in (2,3,4):
    s=sum((Q(1,2)*heval(Q(m,n))+Q(m,n)*pder(Q(m,n)) for m in range(1,n+1)),Q(0))
    # sqrt(lambda/n) <= 1.5, so a generous bound survives normalization errors.
    assert abs(s)*Q(3,2)<Q(9)
    print('prime derivative row',n,float(s))

# Power coefficients of H; exact polynomial norm integral.
P0=[Q(1)];P1=[Q(0),Q(1)]
leg=[P0]
for l in range(1,2*N):
    nextp=[Q(0)]*(len(P1)+1)
    for i,v in enumerate(P1):nextp[i+1]+=Q(2*l+1)*v/Q(l+1)
    for i,v in enumerate(P0):nextp[i]-=Q(l)*v/Q(l+1)
    if (l+1)%2==0:leg.append(nextp)
    P0,P1=P1,nextp
mon=[Q(0)]*(2*N-1)
for k in range(N):
    for d,v in enumerate(leg[k]):mon[d]+=coef[k]*v
def poly_sq_int(rows,lo,hi):
    sq=[Q(0)]*(2*len(rows)-1)
    for i,v in enumerate(rows):
        if not v:continue
        for j,w in enumerate(rows):
            if w:sq[i+j]+=v*w
    return sum((sq[d]*(hi**(d+1)-lo**(d+1))/Q(d+1) for d in range(len(sq))),Q(0))
lo=Q(1)/((EXP8[0]+EXP8[1])/2)
intervals=[(4,lo,Q(1,4)),(3,Q(1,4),Q(1,3)),(2,Q(1,3),Q(1,2)),(1,Q(1,2),Q(1))]
kn2=Q(0)
for n,u0,u1 in intervals:
    rows=[mon[d]*sum((Q(m)**d for m in range(1,n+1)),Q(0)) for d in range(len(mon))]
    kn2+=lmid*poly_sq_int(rows,u0,u1)
assert Q('0.604')<kn2<Q('0.606')
print('norm squared',float(kn2))

# Taylor coefficients at the regular endpoint, from the prolate ODE.
# Candidate endpoint intervals are widened far beyond the Jacobi residual
# and tail estimates proved in the accompanying note.
def absmax(A):return max(abs(A[0]),abs(A[1]))
P=[Q(0),Q(0),Q(0)]
for j in (0,2):
    ep=sum(b[j],Q(0))/(2*lmid*b[j][0])
    a=[(ep-Q('1e-16'),ep+Q('1e-16'))]
    kap=(E[j]-Q('1e-20'),E[j]+Q('1e-20'))
    for n in range(100):
        x=mul(sub((Q(n*(n+1)),Q(n*(n+1))),kap),a[n])
        x=add(x,mul(C2,a[n]))
        if n>=1:x=sub(x,mul(mul((Q(2),Q(2)),C2),a[n-1]))
        if n>=2:x=add(x,mul(C2,a[n-2]))
        a.append(clamp_interval(x[0]/Q(2*(n+1)**2),x[1]/Q(2*(n+1)**2),70))
    M=max(absmax(a[n]) for n in (98,99,100))
    z=Q(1,10)
    for d in (0,1,2):
        v=sum((absmax(a[n])*Q(factorial(n),factorial(n-d))*z**(n-d) for n in range(d,101)),Q(0))
        tail=2*M*Q(factorial(101),factorial(101-d))*z**(101-d)
        P[d]+=v+tail
print('ODE absolute series bounds',*[float(v) for v in P])
assert P[0]<Q('0.00013') and P[1]<Q('0.0065') and P[2]<Q('0.29')

# The collar estimate in the note has omega_G(delta) < 48 delta.
# e > 27/10 gives the safe rational inequality 2/e < 20/27.
lower_residual=Q('1e-5')/Q(4,5)*(Q('8e-9')-Q(20,27)*Q('4.8e-9'))
assert lower_residual>Q('5.5e-14')
assert Q('5.5e-14')>Q('2.3')*Q('2.34611e-14')
print('normalized Weil residual lower > 5.5e-14; ratio > 2.3')
