"""Exact finite cellular and trace-monoid checks; no floating proof steps."""
from fractions import Fraction as F
from itertools import combinations
from collections import defaultdict
import sympy as s
from sympy.matrices.normalforms import smith_normal_form
import math

def cellular(N):
    edges=[('S',n) for n in range(1,N)]+[('U',m,n) for m in range(2,N+1) for n in range(1,N//m+1)]
    index={e:i for i,e in enumerate(edges)}
    B1=s.zeros(N,len(edges))
    for i,e in enumerate(edges):
        a,b=(e[1],e[1]+1) if e[0]=='S' else (e[2],e[1]*e[2])
        B1[a-1,i]=-1;B1[b-1,i]=1
    columns=[];nc=na=0
    def col(terms):
        v=s.zeros(len(edges),1)
        for edge,value in terms:v[index[edge]]+=value
        columns.append(v)
    for n in range(1,N+1):
        for a in range(2,N+1):
            for b in range(2,N//(a*n)+1):
                col([(('U',b,n),1),(('U',a,b*n),1),(('U',a*b,n),-1)]);nc+=1
    for m in range(2,N+1):
        for n in range(1,N//m):
            col([(('S',n),1),(('U',m,n+1),1),(('U',m,n),-1)]
                +[(('S',j),-1) for j in range(m*n,m*(n+1))]);na+=1
    B2=s.Matrix.hstack(*columns) if columns else s.zeros(len(edges),0)
    assert B1*B2==s.zeros(N,len(columns))
    folded=B2[N-1:,:]
    snf=smith_normal_form(folded,domain=s.ZZ)
    nonzero=[snf[i,i] for i in range(min(snf.shape)) if snf[i,i]]
    assert all(abs(v)==1 for v in nonzero)
    pi=len(list(s.primerange(2,N+1)))
    rank=len(nonzero)
    assert len(edges)-(N-1)-rank==pi
    h2=len(columns)-rank
    assert h2==nc-(N-1)+pi
    # Actual prime-period cocycles, zero on successor edges.
    periods=s.zeros(len(edges),pi)
    for j,p in enumerate(s.primerange(2,N+1)):
        for i,e in enumerate(edges):
            if e[0]=='U':periods[i,j]=s.factorint(e[1]).get(p,0)
    assert B2.T*periods==s.zeros(len(columns),pi)
    if N<=8:
        lap=B1.T*B1+B2*B2.T
        assert len(edges)-lap.rank()==pi
    return {'N':N,'vertices':N,'successor_edges':N-1,'division_edges':len(edges)-N+1,
            'composition_cells':nc,'affine_cells':na,'boundary_rank':rank,
            'H1_free_rank':pi,'H1_torsion_invariants':[],'H2_free_rank':h2}

def cliques(N):
    ps=list(s.primerange(2,N+1));out=[]
    for k in range(len(ps)+1):
        for Fset in combinations(ps,k):
            if all(p*q<=N for p,q in combinations(Fset,2)):out.append(Fset)
    return ps,out

def clique_poly(N):
    ps,cs=cliques(N)
    return {math.prod(a):(-1)**len(a) for a in cs}

def dirichlet_inverse(c,R):
    a=[s.Integer(0)]*(R+1);a[1]=s.Integer(1)
    for n in range(2,R+1):a[n]=-sum(c.get(d,0)*a[n//d] for d in s.divisors(n) if d>1)
    return a

def log_coefficients(a,R):
    # Exact formal arithmetic logarithm via nilpotent Dirichlet convolution.
    f=a.copy();f[1]=0;power=[s.Integer(0)]*(R+1);power[1]=1
    out=[s.Integer(0)]*(R+1)
    for k in range(1,R.bit_length()):
        nxt=[s.Integer(0)]*(R+1)
        for n in range(2,R+1):nxt[n]=sum(power[d]*f[n//d] for d in s.divisors(n))
        power=nxt
        for n in range(2,R+1):out[n]+=s.Rational((-1)**(k+1),k)*power[n]
    return out

def normal_form(word,N):
    # Lexicographically least topological ordering of the dependence heap.
    rem=list(range(len(word)));answer=[]
    while rem:
        available=[j for j in rem if not any(i<j and (word[i]==word[j] or word[i]*word[j]>N) for i in rem)]
        j=min(available,key=lambda i:(word[i],i));answer.append(word[j]);rem.remove(j)
    return tuple(answer)

cell_data=[cellular(N) for N in (2,3,4,6,8,12,15,30)]
trace_data=[]
for N in (6,10,15,30):
    R=max(60,N);ps,cs=cliques(N);c=clique_poly(N)
    a=dirichlet_inverse(c,R);log=log_coefficients(a,R)
    assert all(v>=0 for v in a)
    for n in range(1,N+1):
        assert a[n]==1
        f=s.factorint(n)
        expected=s.Rational(1,next(iter(f.values()))) if len(f)==1 else 0
        assert log[n]==expected
    if N==6:
        classes=defaultdict(set)
        def build(word,r):
            classes[r].add(normal_form(word,N))
            for p in ps:
                if r*p<=R:build(word+(p,),r*p)
        build((),1)
        assert all(len(classes[n])==a[n] for n in range(1,R+1))
        assert a[6]==1 and a[10]==2 and a[30]==4
        assert log[6]==0 and log[4]==s.Rational(1,2) and log[10]==1
    bulk=[p for p in ps if p*p<=N]
    def evaluate(sigma):return sum(F(v,r**sigma) for r,v in c.items())
    def shell(sigma):
        P=lambda y:math.prod(1-F(1,q**sigma) for q in ps if q<=y)
        return P(math.isqrt(N))-sum(F(1,p**sigma)*P(N//p) for p in ps if p*p>N)
    for sigma in (1,2):assert evaluate(sigma)==shell(sigma)
    trace_data.append({'N':N,'clique_coefficients':{str(r):v for r,v in sorted(c.items())},
       'coefficients_to_60':{str(n):str(a[n]) for n in range(1,61) if a[n]},
       'log_coefficients_to_30':{str(n):str(log[n]) for n in range(2,31) if log[n]},
       'C_at_1':str(evaluate(1)),'C_at_2':str(evaluate(2))})
c30=clique_poly(30)
C1=sum(F(v,r) for r,v in c30.items());C2=sum(F(v,r*r) for r,v in c30.items())
assert C1==F(-175602331,3234846615) and C2>F(3,5)
assert C2==F(4230679694542079651,6976155081717972150)

# Curvature uses the original uniform x and division-phase y, not a new gauge.
x,y,A,B=s.symbols('x y A B',nonzero=True)
composition=s.cancel((A/y)*(B/y)/(A*B/y))
affine=s.cancel((x*A/y)/((A/y)*x**2))
assert composition==1/y and affine==1/x

# Verify the lead's isolated rod minimum-clock consequence by exact enumeration.
rod_data=[]
for N in range(2,11):
    rods=[(m,n) for n in range(2,N+1) for m in range(1,n) if n%m==0]
    equality=defaultdict(int)
    for bits in range(1<<len(rods)):
        used=set();selected=[];r=1;a=0;valid=True
        for i,(m,n) in enumerate(rods):
            if bits>>i&1:
                seg=set(range(m,n+1))
                if used&seg:valid=False;break
                used|=seg;selected.append((m,n));r*=n//m;a+=n-m
        if valid:
            assert r<=a+1
            if r==a+1:
                assert not selected or selected==[(1,r)]
                equality[r]+=1
    assert all(equality[r]==1 for r in range(1,N+1))
    rod_data.append({'N':N,'equality_products':dict(equality)})

u,v,w,x=s.symbols('u v w x')
D6=1+u*x+(u+v)*x**2+(u*u+u)*x**3+(u*u+v+w)*x**4+u*v*x**5
log4=s.diff(s.log(D6),u,2).subs({u:0,v:0,w:0})/2
log6=s.diff(s.log(D6),u,v).subs({u:0,v:0,w:0})
assert s.expand(log4).coeff(x,3)==0
assert s.expand(log6).coeff(x,5)==-1

print('All exact cellular, clique, curvature and rod checks passed.')
