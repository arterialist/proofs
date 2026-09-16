#!/usr/bin/env python3
"""Directed-decimal enclosure of the literal p=5, X=2 total energy increment.

Every coefficient is an actual odd Möbius coefficient.  All source tails are
bounded by Hilbert norms after the finite atom-pair polynomial is evaluated.
"""
from collections import defaultdict
from decimal import Decimal, localcontext, ROUND_FLOOR, ROUND_CEILING
from fractions import Fraction as Q
from importlib.util import module_from_spec, spec_from_file_location
from pathlib import Path

source = Path(__file__).with_name('post_branch_kernel_p5_x2.py')
spec = spec_from_file_location('kernel', source)
k = module_from_spec(spec)
spec.loader.exec_module(k)

M = 60
DIVISORS = ((1, 1), (2, -1), (3, -1), (6, 1))
P = 80


def directed(op, rounding):
    with localcontext() as ctx:
        ctx.prec = P
        ctx.rounding = rounding
        return +op()


def down(op): return directed(op, ROUND_FLOOR)
def up(op): return directed(op, ROUND_CEILING)

def rational_interval(x):
    a, b = Decimal(x.numerator), Decimal(x.denominator)
    return down(lambda:a/b), up(lambda:a/b)


def multiply(x, y):
    candidates_lower = [down(lambda a=a,b=b:a*b) for a in x for b in y]
    candidates_upper = [up(lambda a=a,b=b:a*b) for a in x for b in y]
    return min(candidates_lower), max(candidates_upper)


def add(x,y): return down(lambda:x[0]+y[0]),up(lambda:x[1]+y[1])
def negate(x): return -x[1],-x[0]

def power_positive(x, n):
    return down(lambda:x[0]**n),up(lambda:x[1]**n)


def polynomial_interval(poly,q):
    total=(Decimal(0),Decimal(0))
    for exponent,coefficient in poly.items():
        if not coefficient: continue
        term=multiply((Decimal(coefficient),Decimal(coefficient)),
                      power_positive(q,exponent))
        total=add(total,term)
    return total


def mu(n):
    out=1
    p=2
    while p*p<=n:
        if n%p==0:
            n//=p
            if n%p==0:return 0
            out=-out
        p+=1
    if n>1:out=-out
    return out


def rows():
    E,W,Z,DZ=defaultdict(int),defaultdict(int),defaultdict(int),defaultdict(int)
    for d,md in DIVISORS:
        E[d]+=md
        W[5*d]-=md
        for n in range(3,M+1,2):
            c=mu(n)
            if c:
                Z[d*n]+=md*c
                DZ[5*d*n]-=md*c
    return tuple({m:c for m,c in row.items() if c} for row in (E,W,Z,DZ))


def gram_polynomial(A,B):
    poly=defaultdict(int)
    for m,c in A.items():
        for n,d in B.items():
            poly[max(m,n)]+=c*d
            poly[m+n]-=c*d
    return {i:c for i,c in poly.items() if c}


def add_rows(*rows):
    result=defaultdict(int)
    for row in rows:
        for m,c in row.items():result[m]+=c
    return {m:c for m,c in result.items() if c}


def add_polynomials(*terms):
    result=defaultdict(int)
    for sign,poly in terms:
        for exponent,coefficient in poly.items():
            result[exponent]+=sign*coefficient
    return {exponent:c for exponent,c in result.items() if c}


def show(label,x):
    print(f'{label}: [{x[0]:+.18E}, {x[1]:+.18E}]')


def main():
    q0=k.exp_minus_one_interval()
    L0=k.log_two_interval()
    q=(rational_interval(q0[0])[0],rational_interval(q0[1])[1])
    L=(rational_interval(L0[0])[0],rational_interval(L0[1])[1])
    assert q[1]<Decimal(3)/8 and L[1]<Decimal(1)
    h=(down(lambda:L[0]/2),up(lambda:L[1]/2))
    h2=multiply(h,h)
    E,W,Z,DZ=rows()
    old_row=add_rows(E,Z)
    new_row=add_rows(E,Z,W,DZ)
    direct_increment_poly=add_polynomials(
        (1,gram_polynomial(new_row,new_row)),
        (-1,gram_polynomial(old_row,old_row)))
    decomposed_increment_poly=add_polynomials(
        (2,gram_polynomial(DZ,E)),(2,gram_polynomial(DZ,W)),
        (2,gram_polynomial(E,W)),(1,gram_polynomial(W,W)),
        (2,gram_polynomial(Z,W)),(2,gram_polynomial(Z,DZ)),
        (1,gram_polynomial(DZ,DZ)))
    assert direct_increment_poly==decomposed_increment_poly
    def pair(A,B):return multiply(h2,polynomial_interval(gram_polynomial(A,B),q))
    def scaled(x,n):return multiply((Decimal(n),Decimal(n)),x)
    endpoint=add(scaled(pair(E,W),2),pair(W,W))
    scoped=add(endpoint,add(scaled(pair(DZ,E),2),scaled(pair(DZ,W),2)))
    oldW=scaled(pair(Z,W),2)
    oldDZ=scaled(pair(Z,DZ),2)
    delta2=pair(DZ,DZ)

    etaZ=rational_interval(Q(16,3)*Q(5,8)**(M+1))[1]
    etaDZ=rational_interval(Q(20,9)*Q(1,10)**(M+1))[1]
    # E <= 5/4, W <= 1/5, Z_M < 1303/1000, DZ_M < 2223/10^6.
    scoped_error=up(lambda:2*etaDZ*(Decimal('1.25')+Decimal('.2')))
    oldW_error=up(lambda:2*etaZ*Decimal('.2'))
    oldDZ_error=up(lambda:2*(etaZ*Decimal('.002223')+
                              Decimal('1.303')*etaDZ+etaZ*etaDZ))
    delta2_error=up(lambda:2*Decimal('.002223')*etaDZ+etaDZ**2)
    def widen(x,error):return down(lambda:x[0]-error),up(lambda:x[1]+error)
    scoped=widen(scoped,scoped_error)
    oldW=widen(oldW,oldW_error)
    oldDZ=widen(oldDZ,oldDZ_error)
    delta2=widen(delta2,delta2_error)
    total=add(add(scoped,oldW),add(oldDZ,delta2))

    show('scoped full mixed+endpoint',scoped)
    show('2<Z_old,W>',oldW)
    show('2<Z_old,Delta Z>',oldDZ)
    show('||Delta Z||^2',delta2)
    show('total admission energy difference',total)
    print('old source tail norm <=',etaZ)
    print('new nonendpoint tail norm <=',etaDZ)
    assert all(x[0]>0 for x in (scoped,oldW,oldDZ,delta2,total))
    assert total[0]>Decimal('.004851906630')
    assert total[1]<Decimal('.004851906635')

if __name__=='__main__':main()
