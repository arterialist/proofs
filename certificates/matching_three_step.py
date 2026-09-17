"""Exact full three-step arithmetic graph and affine bad-time certificate.
Run with Python 3; no third-party dependencies or optimization are used.
The logarithm enclosure is a positive atanh series. The Euler-constant
remainder is DLMF 5.11.2 and 5.11(ii). This finite computation does not
establish the separate asymptotic prime-family count.
"""
from fractions import Fraction
from fractions import Fraction as F
from itertools import combinations
import math

S = 10**24

def floorfrac(x): return x.numerator // x.denominator
def ceilfrac(x): return -((-x.numerator) // x.denominator)
def enc(x): return floorfrac(x*S), ceilfrac(x*S)

def logunit(r):
    z=(r-1)/(r+1); t=z; acc=Fraction(0)
    for j in range(45):
        acc += 2*t/(2*j+1); t*=z*z
    tail=2*t/(91*(1-z*z))
    return enc(acc)[0], enc(acc+tail)[1]

L2=logunit(Fraction(2))
def logint(n):
    k=n.bit_length()-1
    lo,hi=logunit(Fraction(n,2**k))
    return lo+k*L2[0],hi+k*L2[1]

def observables(N):
    # From the alternating positive-real digamma remainder:
    # H_M-log M-1/(2M)+1/(12M^2)-1/(120M^4) < gamma
    # < H_M-log M-1/(2M)+1/(12M^2).
    M=10000
    hmlo=sum(S//k for k in range(1,M+1))
    hmhi=sum((S+k-1)//k for k in range(1,M+1))
    lmlo,lmhi=logint(M)
    cl,ch=enc(-Fraction(1,2*M)+Fraction(1,12*M*M))
    el,eh=enc(Fraction(1,120*M**4))
    gl,gu=hmlo-lmhi+cl-eh,hmhi-lmlo+ch
    tau=[0]*(N+1)
    for d in range(1,N+1):
        for n in range(d,N+1,d):tau[n]+=1
    H=[(0,0)];lf=uf=D=0
    for q in range(1,N+1):
        l,u=logint(q);lf+=l;uf+=u;D+=tau[q]
        H.append((lf-D*S+2*q*gl,uf-D*S+2*q*gu))
    return H, (gl,gu)

def graph(N):
    factors=[[] for _ in range(N+1)];sf=[True]*(N+1);primes=[]
    for p in range(2,N+1):
        if not factors[p]:
            primes.append(p)
            for n in range(p,N+1,p):factors[n].append(p)
            for n in range(p*p,N+1,p*p):sf[n]=False
    even=[n for n in range(1,N+1) if sf[n] and len(factors[n])%2==0]
    odd=[n for n in range(1,N+1) if sf[n] and len(factors[n])%2]
    ei={n:i for i,n in enumerate(even)};oi={n:i for i,n in enumerate(odd)}
    edges=set()
    for n in even+odd:
        for p,r in combinations(factors[n],2):
            a=n//(p*r)
            for q in primes:
                if a*q>min(2*n,N):break
                if 2*a*q<n or q in factors[n]:continue
                m=a*q
                edges.add((ei[n],oi[m]) if n in ei else (ei[m],oi[n]))
    return even,odd,sorted(edges)

H,gamma=observables(255)
delta=F(37,1000)
gaps=[]
for q in range(2,10):
    lo=F(H[q][0]-H[1][1],S)
    hi=F(H[q][1]-H[1][0],S)
    assert lo>delta or hi < -delta
    gaps.append({'q':q,'difference_lower':str(lo),'difference_upper':str(hi),
                 'decimal_display':[float(lo),float(hi)]})
assert F(H[1][0],S)>F(3,20)
k=13;r=6
D=sum(math.comb(k,j) for j in range(r+1))
assert D==4096
alpha=F(13,8);beta=F(7,4);t0=F(15,8);ell=2-t0
c=delta*ell/(8*8*D)
assert c==F(37,2097152000)
assert c< F(3,20)
assert c*alpha<F(3,20)*min(t0-beta,alpha-1)
assert 4*8*D*c/delta==ell/2

# A separate actual finite discriminator at X=128; this single label is not
# claimed to instantiate the asymptotic 13-prime family.
X=128;n=210;Y=F(1,10)
even,odd,edges=graph(2*X-1)
left=[set() for _ in even];right=[set() for _ in odd]
for i,j in edges:left[i].add(j);right[j].add(i)
closure=[{j for j1 in left[i] for i1 in right[j1] for j in left[i1]}
         for i in range(len(even))]
assert all(left[i] <= closure[i] for i in range(len(even)))
assert sum(map(len,closure)) == 5244
factor_count=lambda z: sum(z%p==0 for p in range(2,z+1)
                          if all(p%d for d in range(2,math.isqrt(p)+1)))
for i,j in ((i,j) for i,js in enumerate(closure) for j in js):
    a=even[int(i)];b=odd[int(j)];g=math.gcd(a,b)
    assert a<=8*b and b<=8*a
    assert factor_count(a//g)<=6 and factor_count(b//g)<=6
neighbors=sorted(odd[j] for j in closure[even.index(n)])
assert len(neighbors)==69 and sum(m<X for m in neighbors)==30
mid=[(lo+hi)//2 for lo,hi in H]
rad=[max(v-lo,hi-v) for v,(lo,hi) in zip(mid,H)]

def prefix_mid(j,label):
    return F(sum(mid[x//label] for x in range(X,j)),S)

def sublevel(a,b,T):
    # Exact enclosing interval in z in [0,1] for |a+b*z|<=T.
    if not b:return (F(0),F(1)) if abs(a)<=T else None
    left,right=sorted(((-T-a)/b,(T-a)/b))
    left=max(F(0),left);right=min(F(1),right)
    return (left,right) if left<right else None

bad=[];per_neighbor=[]
for m in neighbors:
    intervals=[]
    # Triangle inequality for all t, even across true zero displacements.
    err=F(X*(max(rad[:2*X//m+1])+max(rad[:2*X//n+1])),S)
    for j in range(240,256):
        a=prefix_mid(j,m)-prefix_mid(j,n)
        b=F(mid[j//m]-mid[j//n],S)
        z=sublevel(a,b,Y+err)
        if z:intervals.append((j+z[0],j+z[1]))
    length=sum((b-a for a,b in intervals),F(0))
    if m<X:assert length<=16*Y/delta+F(1,10**10)
    if length:
        witnesses=[]
        for left,right in intervals:
            t=(left+right)/2;j=t.numerator//t.denominator
            value=prefix_mid(j,m)-prefix_mid(j,n)+(t-j)*F(mid[j//m]-mid[j//n],S)
            if abs(value)+err<Y:
                witnesses.append({'time':str(t),'absolute_gap_upper':str(abs(value)+err)})
        assert witnesses,'No certified actually cheap point in enclosing window'
        per_neighbor.append({'neighbor':m,'bad_measure_upper':str(length),
                             'actually_cheap_witness':witnesses[0]})
    bad.extend(intervals)
union=[]
for a,b in sorted(bad):
    if union and a<=union[-1][1]:union[-1]=(union[-1][0],max(b,union[-1][1]))
    else:union.append((a,b))
bad_length=sum((b-a for a,b in union),F(0))
good_lower=F(16)-bad_length
assert good_lower>0
assert F(H[1][0],S)*(240-n)>Y
assert [r['neighbor'] for r in per_neighbor] == [37,53,83]
assert len(union)==2
assert good_lower > F('14.2460930279')
assert Y*Y*good_lower > F('0.142460930279')
print('Full three-step graph: 5244 edges; label 210 has 69 neighbors, 30 below X.')
print('Certified cheap witnesses only at labels 37, 53, 83.')
print('Good-time measure > 14.2460930279; integrated squared cost > 0.142460930279.')
