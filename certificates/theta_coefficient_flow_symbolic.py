"""Exact algebra checks for the actual coefficient evolution formulas."""
import sympy as s

a=s.symbols('a',real=True)
g=s.symbols('g0:5',positive=True)
def flow(expr):
    return s.expand(sum(s.diff(expr,g[k])*(a+4*k)*g[k+1] for k in range(4)))
T0=g[1]**2-g[0]*g[2]
T1=g[2]**2-g[1]*g[3]
U0=g[1]*g[2]-g[0]*g[3]
U1=g[2]*g[3]-g[1]*g[4]
V0=g[2]**2-g[0]*g[4]
D=4*T0*T1-U0**2
assert s.simplify(flow(T0)-(a+8)*U0)==0
assert s.simplify(flow(U0)-((a+12)*V0-8*T1))==0
assert s.simplify(flow(D)-2*(a+12)*(2*U0*T1+2*T0*U1-U0*V0))==0
x=s.symbols('x')
assert s.expand(s.discriminant(g[0]+3*g[1]*x+3*g[2]*x*x+g[3]*x**3,x)-27*D)==0
d,e=s.symbols('d e',nonzero=True)
q,v=1-d,1-e
assert s.expand(3-4*q-4*v+6*q*v-q*q*v*v-(4*d*e-(d+e-d*e)**2))==0
assert s.simplify((4*d*e-(d+e-d*e)**2)/(d*d*e*e)-(2*(1/d+1/e)-1-(1/e-1/d)**2))==0
assert s.expand(-((a+8)*(1-d)*(1-e)-2*(a+4)*(1-d)+a)-((a+8)*(1-d)*e-a*d))==0
print('Quadratic, mixed minor, cubic discriminant, flow, and reciprocal-defect normalization verified.')
