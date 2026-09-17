"""Selected exact interior incidence fixtures, retaining nonunit divisors and full derivative."""
from math import gcd,isqrt
from fractions import Fraction as Q
from collections import defaultdict
import sympy as sp
z,y=sp.symbols('z y')

def reduce(f,n):return sp.rem(f,sp.cyclotomic_poly(n,z),z)
def squared_modulus(f,n):
    cp=sp.cyclotomic_poly(n,z)
    invz=sp.invert(z,cp,z)
    conj=reduce(f.subs(z,invz),n)
    value=reduce(f*conj,n)
    basis=[reduce((z+invz)**j,n) for j in range(sp.totient(n)//2)]
    c=sp.symbols('c:'+str(len(basis)))
    equations=sp.Poly(value-sum(t*b for t,b in zip(c,basis)),z).all_coeffs()
    sol=sp.solve(equations,c)
    return sp.expand(sum(sol[t]*y**j for j,t in enumerate(c)))
def full_derivative(N,n):
    value=sp.diff(sp.cyclotomic_poly(n,z),z)
    for k in range(1,N+1):
        if k!=n:value=reduce(value*sp.cyclotomic_poly(k,z),n)
    return reduce(value,n)
def interval_value(poly,lo,hi):
    L=Q(0);H=Q(0)
    for c in sp.Poly(poly,y).all_coeffs():
        products=[L*lo,L*hi,H*lo,H*hi]
        L=min(products)+Q(c);H=max(products)+Q(c)
    return L,H

def histories(n,d):
    ans=[]
    def go(k,chain):
        if k==d:ans.append(chain);return
        for t in range(d,k):
            if k%t==0 and t%d==0:go(t,chain+[t])
    go(n,[n]);return ans
record={'scope':'q7,r8 with g1,g2; one actual successor bridge; no census.', 'fixtures':{}}
for g in (1,2):
    q,r=7,8;N=(q+r)*g;n=q*g;X=N;k=q+r
    assert gcd(q,r)==1 and q>isqrt(X) and r>isqrt(X) and q*r>X
    divs=sp.divisors(N)
    chains={int(d):histories(N,int(d)) for d in divs}
    for d,paths in chains.items():assert sum((-1)**(len(p)-1) for p in paths)==sp.mobius(N//d)
    # Independent rational Möbius product in the cyclotomic field.
    cp=sp.cyclotomic_poly(n,z); product=sp.Integer(1)
    terms=[]; layers=defaultdict(list)
    for d in divs:
        coefficient=int(sp.mobius(N//d))
        assert d%n!=0
        f=reduce(z**d-1,n)
        if coefficient==1:product=reduce(product*f,n)
        elif coefficient==-1:product=reduce(product*sp.invert(f,cp,z),n)
        b=g//gcd(int(d),g)
        layers[b].append([int(d),coefficient])
        terms.append({'d':int(d),'mu':coefficient,'gcd_with_n':gcd(int(d),n),'residue':int(d%n),'chain_count':len(chains[int(d)])})
    actual=reduce(sp.cyclotomic_poly(N,z),n)
    assert product==actual
    # Exact gcd-layer polynomial identity, with no unit-divisor restriction.
    factorized=sp.Integer(1)
    for b in sp.divisors(g):
        if gcd(int(b),k)==1:
            factor=sp.cyclotomic_poly(k,z).subs(z,z**(g//b))
            factorized*=factor**int(sp.mobius(b))
    assert sp.cancel(factorized-sp.cyclotomic_poly(N,z))==0
    modulus=squared_modulus(actual,n)
    minpoly=y**3+y**2-2*y-1 if n==7 else y**3-y**2-2*y+1
    roots=sp.Poly(minpoly,y).intervals(eps=sp.Rational(1,10**10))
    lo,hi=map(Q,roots[-1][0])
    L,H=interval_value(modulus,lo,hi)
    assert (H<1) if g==1 else (L>1)
    full=[]
    for K in (N-1,N):
        derivative=full_derivative(K,n)
        sq=squared_modulus(derivative,n)
        dl,dh=interval_value(sq,lo,hi)
        assert dl>1
        full.append({'cutoff':K,'derivative_mod_Phi_n':str(derivative),'squared_modulus_in_y':str(sq),'squared_modulus_interval':[str(dl),str(dh)],'clipped_deficit':0})
    record['fixtures'][str(g)]={'q':q,'r':r,'g':g,'n':n,'N':N,'X':X,'first_common_multiple_reduced':q*r,'terms':terms,'gcd_layers':dict(layers),'all_division_chains':chains,'Phi_N_mod_Phi_n':str(actual),'squared_modulus_in_y':str(modulus),'y_minpoly':str(minpoly),'y_largest_root_interval':[str(lo),str(hi)],'update_squared_modulus_interval':[str(L),str(H)],'update_log_sign':-1 if g==1 else 1,'full_derivatives':full}
# Reciprocity of shifted projection counts is just the exact CRT correction.
q,r,X=7,8,15
counts=[]
for h in (0,1,7):
    i0=next(i for i in range(1,q*r+1) if i%q==0 and (i+h)%r==0)
    count=max(0,1+(X-h-i0)//(q*r))
    direct=sum(i%q==0 and (i+h)%r==0 for i in range(1,max(0,X-h)+1))
    assert count==direct
    counts.append({'h':h,'first_positive_solution':i0,'count':count})
record['shifted_successor_counts']=counts
for key, fixture in record['fixtures'].items():
    print(f"g={key}, n={fixture['n']}, N={fixture['N']}, phase sign={fixture['update_log_sign']}")
    for value in fixture['full_derivatives']:
        print(f"  cutoff {value['cutoff']}: squared modulus {value['squared_modulus_in_y']}; interval {value['squared_modulus_interval']}")
print("All exact chain, cyclotomic, full-derivative, clipping and shifted-CRT assertions passed.")
