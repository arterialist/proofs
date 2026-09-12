"""Actual theta coefficient checks on n=0..8, t in [0,1/2].

Arb finite integration, explicit full theta/integration tails, and a uniform
Taylor enclosure in time followed by interval subdivision. No all-degree claim.
"""
import math
import flint
from flint import arb, acb, ctx

ctx.dps=100
N=8
K=10
T=arb(1)/2
MAX=N+4+K+1

def phi8(u):
    p=acb.pi()*(4*u).exp()
    return sum((u-p*n*n).exp()*(2*(p*n*n)**2-3*p*n*n) for n in range(1,9))

def tail(k):
    # t <= 1 suffices. u^2 <= exp(4u)/16, and pi*n^2-1/16 >= c*n^2.
    c=arb.pi()-arb(1)/16
    nt=4*arb.pi()**2*9**4*math.factorial(k)*(-81*c).exp()/(324*c-9)**(k+1)
    U=arb(3)/2
    ut=arb(0)
    for n in range(1,9):
        rate=4*c*n*n*(4*U).exp()-9
        poly=sum(math.comb(k,j)*U**(k-j)*math.factorial(j)/rate**(j+1) for j in range(k+1))
        ut+=2*arb.pi()**2*n**4*(9*U-c*n*n*(4*U).exp()).exp()*poly
    return nt+ut

tails=[tail(2*n) for n in range(MAX+1)]

def moment(n,t):
    def f(u,analytic):
        return u**(2*n)*(t*u*u).exp()*phi8(u)
    out=sum(acb.integral(f,arb(j)/8,arb(j+1)/8,abs_tol=arb('1e-85'),rel_tol=arb('1e-80')) for j in range(12))
    return out.real+arb(0,tails[n])

base=[moment(n,arb(0)) for n in range(MAX+1)]
end=[moment(n,T) for n in range(MAX+1)]
assert all(m>0 for m in base+end)

def derived(m):
    r=[m[n+1]/((4*n+2)*m[n]) for n in range(N+4)]
    delta=[1-r[n+1]/r[n] for n in range(N+3)]
    dp=[r[n]*(1-delta[n])*((4*n+10)*(1-delta[n])*delta[n+1]-(4*n+2)*delta[n]) for n in range(N+2)]
    lam=[1/d for d in delta]
    v=[dp[n]/delta[n]**2 for n in range(N+2)]
    rows=[]
    for n in range(N+1):
        slope=lam[n+1]-lam[n]
        omega=2*(lam[n]+lam[n+1])-1-slope*slope
        op=2*(-(1+slope)*v[n]+(slope-1)*v[n+1])
        rows.append({'r':r[n],'delta':delta[n],'delta_next':delta[n+1],
                     'delta_prime':dp[n],'quadratic_rate':dp[n]/(r[n]*delta[n]),
                     'slope':slope,'v':v[n],'v_ratio':v[n+1]/v[n],
                     'omega':omega,'omega_prime':op,'cubic_rate':op/(r[n]*omega)})
    return rows

def time_moments(lo,hi):
    t=arb((arb(lo)+arb(hi))/2,(arb(hi)-arb(lo))/2)
    result=[]
    for n in range(N+5):
        value=base[n+K]/math.factorial(K)
        for j in range(K-1,-1,-1):
            value=value*t+base[n+j]/math.factorial(j)
        remainder=end[n+K+1]*T**(K+1)/math.factorial(K+1)
        result.append(value+arb(0,remainder))
    return result

def passes(rows):
    return all(z['delta']>0 and z['delta']<1 and z['delta_next']>0 and
               z['delta_next']<z['delta'] and z['delta_prime']>0 and
               z['quadratic_rate']<8 and z['slope']>1 and z['slope']<3 and
               z['v']>0 and z['v_ratio']>1 and z['v_ratio']<2 and z['omega']>0 and z['omega_prime']<0
               for z in rows)

stack=[(0,1,0)]  # dyadic interval [a/2^(d+1), b/2^(d+1)]
accepted=0
maxdepth=0
uniform_margins={}
while stack:
    a,b,d=stack.pop()
    denominator=2**(d+1)
    rows=derived(time_moments(arb(a)/denominator,arb(b)/denominator))
    if passes(rows):
        accepted+=1
        maxdepth=max(maxdepth,d)
        for z in rows:
            margins={'delta':z['delta'],'neighbor_defect_gap':z['delta']-z['delta_next'],
                     'delta_prime':z['delta_prime'],'quadratic_rate_margin':8-z['quadratic_rate'],
                     'slope_lower_margin':z['slope']-1,'slope_upper_margin':3-z['slope'],
                     'v':z['v'],'v_ratio_lower_margin':z['v_ratio']-1,'v_ratio_upper_margin':2-z['v_ratio'],
                     'omega':z['omega'],'negative_omega_prime':-z['omega_prime']}
            for key,value in margins.items():
                lower=value.lower()
                if key not in uniform_margins or lower<uniform_margins[key]:
                    uniform_margins[key]=lower
    else:
        assert d<22,('Unresolved interval',a,b,d)
        stack.extend([(2*a,a+b,d+1),(a+b,2*b,d+1)])

samples=[]
for t,m in [(arb(0),base),(T,end)]:
    rows=derived(m)
    assert passes(rows)
    samples.append({'t':str(t),'rows':[{key:str(value) for key,value in row.items()} for row in rows]})
gamma_end=[arb(math.factorial(n))/math.factorial(2*n)*end[n] for n in range(N+4)]
boundary=[]
for n,z in enumerate(derived(end)):
    a0,a1,a2,a3=gamma_end[n:n+4]
    T0=a1*a1-a0*a2
    T1=a2*a2-a1*a3
    U=a1*a2-a0*a3
    quadratic=4*T0
    cubic=27*(4*T0*T1-U*U)
    assert z['delta']>arb('.0305') and z['delta_next']>arb('.0287') and z['omega']>arb('54.07')
    assert quadratic>0 and cubic>0
    boundary.append({'n':n,'delta':str(z['delta']),'delta_next':str(z['delta_next']),
                     'omega':str(z['omega']),'quadratic_discriminant':str(quadratic),
                     'cubic_discriminant':str(cubic)})

assert accepted == 32768 and maxdepth == 15
print("Actual coefficient constraints hold on the entire time interval [0,1/2], shifts 0..8.")
print("delta0 and derivative at zero:", samples[0]["rows"][0]["delta"], samples[0]["rows"][0]["delta_prime"])
