"""Exact finite checks for literal successor/strict-division renewal.

Requires SymPy 1.14.0. Integer/rational/polynomial arithmetic; no floating spectral inference.
Prime markers only encode d**(-s) multiplicatively; every division edge stays.
"""
import sympy as sp

x=sp.Symbol('x')
primes=[2,3,5,7]
markers={p:sp.Symbol('u'+str(p)) for p in primes}
logs={p:sp.Symbol('l'+str(p)) for p in primes}
def weight(d):
    return sp.prod(markers[p]**e for p,e in sp.factorint(d).items())
def cost(d):
    return sum(e*logs[p] for p,e in sp.factorint(d).items())
def mark(expr):
    return sp.expand(sum(logs[p]*markers[p]*sp.diff(expr,markers[p]) for p in primes))
def matmark(M):return M.applyfunc(mark)
def clean(z):return sp.factor(sp.cancel(z))
def equal(A,B):
    assert A.shape==B.shape
    assert all(clean(a-b)==0 for a,b in zip(A,B))
def matrices(N,weighted=True):
    S=sp.zeros(N);L=sp.zeros(N)
    for n in range(1,N+1):
        if n<N:S[n-1,n]=1
        for m in range(1,n):
            if n%m==0:L[n-1,m-1]=weight(n//m) if weighted else 1
    return S,L

polys=[sp.Integer(1)]
for N in range(1,11):
    polys.append(sp.expand(polys[-1]+sum(x**(N-m)*polys[m-1] for m in sp.divisors(N)[:-1])))
    if N<=8:
        S,L=matrices(N,False)
        assert clean((sp.eye(N)+L-x*S).det()-polys[N])==0
for degree in range(1,6):
    assert all(sp.expand(polys[n]).coeff(x,degree)==sp.expand(polys[10]).coeff(x,degree)
               for n in range(2*degree,11))

N=6
S,L=matrices(N)
Z=sp.eye(N)+L
M=Z.inv()
for n in range(1,N+1):
    for m in range(1,N+1):
        expected=sp.mobius(n//m)*weight(n//m) if n%m==0 else 0
        assert clean(M[n-1,m-1]-expected)==0
assert M[3,0]==0
assert M[5,0]==markers[2]*markers[3]
K=M*S
assert K[:,0]==sp.zeros(N,1)
D=sp.expand((Z-x*S).det())
assert clean(D-(sp.eye(N)-x*K).det())==0

# Independent cycle-cover enumeration as disjoint interval rods.
rods=[(m,n) for n in range(2,N+1) for m in range(1,n) if n%m==0]
partition=sp.Integer(0);rod_configs=0
for bits in range(1<<len(rods)):
    occupied=set();w=sp.Integer(1);product=1;valid=True
    for i,(m,n) in enumerate(rods):
        if bits>>i&1:
            interval=set(range(m,n+1))
            if occupied&interval:valid=False;break
            occupied|=interval
            w*=weight(n//m)*x**(n-m)
            product*=n//m
    if valid:
        assert product<=N
        partition+=w;rod_configs+=1
assert clean(partition-D)==0

# Distinguished first return, including the boundary term after inversion.
ZQ=Z[1:,1:];SQ=S[1:,1:];MQ=ZQ.inv();KQ=MQ*SQ
b=sp.Matrix([weight(n) for n in range(2,N+1)])
mu=sp.Matrix([sp.mobius(n)*weight(n) for n in range(2,N+1)])
equal(MQ*b,-mu)
Qdet=sp.expand((ZQ-x*SQ).det())
return_det=clean(1-D/Qdet)
return_direct=clean(-x*((ZQ-x*SQ).inv()*b)[0])
return_repaired=clean(x*((sp.eye(N-1)-x*KQ).inv()*mu)[0])
assert clean(return_det-return_direct)==0
assert clean(return_det-return_repaired)==0
resolvent=(sp.eye(N)-x*K).inv()
assert resolvent[0,0]==1
assert clean((resolvent*M)[0,0]-Qdet/D)==0

# Log-cost marked division cancellation, derived from Z and its inverse.
B=M*matmark(Z)
C=M*matmark(matmark(Z))-B*B
for n in range(1,N+1):
    for m in range(1,N+1):
        d=n//m if n%m==0 else 1
        f=sp.factorint(d)
        lam=logs[next(iter(f))] if len(f)==1 else 0
        expected=weight(d)*lam if n%m==0 else 0
        assert clean(B[n-1,m-1]-expected)==0
        assert clean(C[n-1,m-1]-expected*cost(d))==0
equal(C,matmark(B))
marked_trace=clean(sp.trace(resolvent*B))
assert clean(marked_trace-mark(D)/D)==0

u,v,w=markers[2],markers[3],markers[5]
def uv_coefficient(expr):
    return clean(sp.diff(expr,u,v).subs({u:0,v:0,w:0,markers[7]:0}))
log_mixed=uv_coefficient(sp.log(D))
return_mixed=uv_coefficient(return_det)
marked_mixed=uv_coefficient(marked_trace)
assert clean(log_mixed+x**3+x**4+x**5+x**6+x**7)==0
assert clean(return_mixed-x**4-x**5)==0
assert clean(marked_mixed-(logs[2]+logs[3])*log_mixed)==0

# Actual primitive cyclic words, not just vertex-simple cycles.
S0,L0=matrices(N,False);A=S0+L0
adj={i:[j for j in range(N) if A[i,j]] for i in range(N)}
def canonical(word):return min(word[k:]+word[:k] for k in range(len(word)))
def primitive(word):
    return all(word!=word[:d]*(len(word)//d) for d in sp.divisors(len(word))[:-1])
primitive_counts={}
for length in range(2,7):
    found=set()
    def extend(word):
        if len(word)==length:
            if word[0] in adj[word[-1]] and primitive(word):found.add(canonical(word))
            return
        for nxt in adj[word[-1]]:extend(word+(nxt,))
    for root in range(N):extend((root,))
    expected=sum(sp.mobius(d)*sp.trace(A**(length//d)) for d in sp.divisors(length))/length
    assert len(found)==expected
    primitive_counts[length]=len(found)
for word in ((0,1,2,3),(1,2,3),(0,1,2,3,4,5)):
    assert primitive(word) and all(word[(i+1)%len(word)] in adj[a] for i,a in enumerate(word))
T=x*S-L
traces={k:sp.expand(sp.trace(T**k)) for k in range(2,5)}
assert traces[2]==-2*x*u

# Exact complex-root isolation refutes a right-half-plane zero exclusion.
root_intervals=sp.polys.polytools.intervals(polys[6],all=True,eps=sp.Rational(1,10000))
right=[]
for rectangle,mult in root_intervals[1]:
    a,b=rectangle
    assert sp.Poly(polys[6],x).count_roots(a,b)==mult
    if sp.re(a)>0:right.append((rectangle,mult))
assert len(right)==2 and sum(m for _,m in right)==2
assert polys[4].subs(x,-2)<0 and polys[4].subs(x,-1)>0


# The stated rational rectangles, independently of the isolator's output.
a=sp.Rational(8775,32768)+sp.I*sp.Rational(23367,32768)
b=sp.Rational(4389,16384)+sp.I*sp.Rational(11685,16384)
assert sp.Poly(polys[6],x).count_roots(a,b)==1
assert sp.Poly(polys[6],x).count_roots(sp.re(a)-sp.I*sp.im(b),sp.re(b)-sp.I*sp.im(a))==1
print("Exact determinant, boundary return, marked kernels, trace and primitive-word checks passed.")
print("D6 =",D)
print("Deleted-state determinant =",Qdet)
print("Primitive word counts (lengths 2 through 6) =",primitive_counts)
print("Mixed logarithm =",log_mixed,"; mixed first return =",return_mixed)
print("Both stated right-half-plane rational rectangles contain exactly one root.")
