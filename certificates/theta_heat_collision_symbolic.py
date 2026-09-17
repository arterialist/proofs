"""Exact checks of the theta boundary identity and ordinary collision jet."""
import sympy as s

u,t,x=s.symbols('u t x', real=True)
g=s.exp(t*u*u)*s.cos(x*u)
expected=s.exp(t*u*u)*((2*t+4*t*t*u*u-x*x-1)*s.cos(x*u)-4*t*x*u*s.sin(x*u))
assert s.simplify(s.diff(g,u,2)-g-expected)==0

eps,B,C,D=s.symbols('eps B C D', nonzero=True, real=True)
tau=eps**2
b=2*C/(3*B)
c=(D/(3*B)-2*C*C/(9*B*B))/s.sqrt(2)
plus=s.sqrt(2)*eps+b*eps**2+c*eps**3
minus=-s.sqrt(2)*eps+b*eps**2-c*eps**3
for y in [plus,minus]:
    heat_jet=B*(y*y/2-tau)+C*(y**3/6-tau*y)+D*(y**4/24-tau*y*y/2+tau*tau/2)
    assert s.series(heat_jet,eps,0,5).removeO().expand()==0
gap=s.series((plus-minus)**2,eps,0,6).removeO().expand()
assert s.simplify(gap-(8*eps**2+(8*D/(3*B)-16*C*C/(9*B*B))*eps**4))==0
print('Boundary transfer, both collision branches, and gap second coefficient verified symbolically.')
print('gap^2 =',gap)
