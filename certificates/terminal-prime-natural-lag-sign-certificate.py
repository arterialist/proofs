"""Exact interval certificate for the literal terminal source at N=18553.

All interval endpoints are integer multiples of 10^-24. The only
transcendental inputs, log(p), are enclosed by finite rational
atanh-series and a rational geometric remainder. The kernel bounds
use its proved monotonicity on 0 <= s <= 1; see the companion note.
No floating-point operation is used to establish the assertions.
"""

from fractions import Fraction

N = 18553
S = 10**24
TERMS = 26
BLOCK = 20

def ceildiv(a,b):
    return -((-a)//b)

def atanh_log_bounds(z):
    # 2*atanh(z) with z in [0,1/3], and a geometric upper tail.
    z2 = z*z
    power = z
    total = Fraction(0)
    for j in range(TERMS):
        total += 2*power/(2*j+1)
        power *= z2
    rem = 2*power/((2*TERMS+1)*(1-z2))
    return total, total+rem

base_lo,base_hi = atanh_log_bounds(Fraction(1,3))
log2 = (S*base_lo.numerator//base_lo.denominator,
        ceildiv(S*base_hi.numerator,base_hi.denominator))

composite = bytearray(N+1)
prime_powers=[]
for p in range(2,N+1):
    if composite[p]:
        continue
    if p*p<=N:
        for n in range(p*p,N+1,p):
            composite[n]=1
    m=p.bit_length()-1
    twom=1<<m
    z=Fraction(p-twom,p+twom)
    lo,hi=atanh_log_bounds(z)
    lp=(m*log2[0]+S*lo.numerator//lo.denominator,
        m*log2[1]+ceildiv(S*hi.numerator,hi.denominator))
    power=p
    while power<=N:
        prime_powers.append((power,lp))
        power*=p
prime_powers.sort()
assert not composite[N], 'N must be prime'
lamlo=[0]*(N+1)
lamhi=[0]*(N+1)
for n,(lo,hi) in prime_powers:
    lamlo[n]=lo;lamhi[n]=hi
psilo=[0]*(N+1)
psihi=[0]*(N+1)
for n in range(1,N+1):
    psilo[n]=psilo[n-1]+lamlo[n]
    psihi[n]=psihi[n-1]+lamhi[n]

def rat_interval(num,den):
    return (S*num//den,ceildiv(S*num,den))

def scale_interval(lo,hi,num,den,negative=False):
    if negative:
        return ((-hi*num)//den,ceildiv(-lo*num,den))
    return (lo*num//den,ceildiv(hi*num,den))

def add(*ivals):
    return (sum(v[0] for v in ivals),sum(v[1] for v in ivals))

def multiply(x,y):
    vals=(x[0]*y[0],x[0]*y[1],x[1]*y[0],x[1]*y[1])
    return (min(vals)//S,ceildiv(max(vals),S))

E=(psilo[N]-N*S,psihi[N]-N*S)

def K_at(a):
    # s=a/N; exact terminal-compensated Stieltjes formula.
    k=(0,0)
    for n,(lo,hi) in prime_powers:
        den=(N*n+a)**2
        k=add(k,scale_interval(lo,hi,N*N,den))
    k=add(k,
          rat_interval(-N,N+a),
          rat_interval(N,N*N+a),
          rat_interval(-N*N,(N+a)**2),
          scale_interval(E[0],E[1],N*N,(N*N+a)**2,True))
    return k

J=(0,0)
P=(0,0)
err=0
blocks=0
for a in range(1,N,BLOCK):
    b=min(N,a+BLOCK)
    Jb=(0,0)
    Ab=0
    for m in range(a,b):
        # E(x)=psi(m)-x on [m,m+1); |E(x)| <= |E(m)|+1.
        cell=(psilo[m]-(m*S+S//2),psihi[m]-(m*S+S//2))
        Jb=add(Jb,cell)
        Em=(psilo[m]-m*S,psihi[m]-m*S)
        Ab+=max(abs(Em[0]),abs(Em[1]))+S
    J=add(J,Jb)
    kl=K_at(a);kr=K_at(b)
    if kl[0]>kr[1]:
        raise AssertionError('K monotonicity interval violated')
    # K is increasing: the left-endpoint rectangle has absolute error
    # <= [K(b/N)-K(a/N)] * integral_a^b |E(x)| dx.
    P=add(P,multiply(kl,Jb))
    diff=kr[1]-kl[0]
    err+=ceildiv(diff*Ab,S)
    blocks+=1
T=K_at(0)
certP=(P[0]-err,P[1]+err)
assert J[0]>297*S and J[1]<298*S
assert T[0]>-2*S and T[1]<-S
assert certP[0]>11349*S and certP[1]<11907*S
print('N prime:', N, 'prime powers included:', len(prime_powers))
print('J_N in [',J[0]//S,',',ceildiv(J[1],S),']')
print('T_N in [',T[0]//S,',',ceildiv(T[1],S),']')
print('N^2 q_N(N) in [',certP[0]//S,',',ceildiv(certP[1],S),']')
print('PASS: 297 < J_N < 298, -2 < T_N < -1, '
      '11349 < N^2 q_N(N) < 11907')
