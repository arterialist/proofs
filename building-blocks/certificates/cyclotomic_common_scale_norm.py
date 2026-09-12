"""Bounded exact relative-norm fixtures; no phase census or clipping estimates."""
from fractions import Fraction as F
from math import gcd,prod
import sympy as s
x=s.Symbol('x')

def poly(expr):return s.Poly(expr,x,domain=s.QQ)
def reduction(expr,Q):return poly(expr).rem(Q)
def power(P,e,Q):
 if e<0:P=s.invert(P,Q);e=-e
 out=poly(1)
 while e:
  if e&1:out=(out*P).rem(Q)
  P=(P*P).rem(Q);e//=2
 return out

def operator(g,q,m):
 fs=s.factorint(g)
 scalar=prod(int(p)**(int(e)-1) for p,e in fs.items())
 for p in fs:
  if (q*m)%p==0:scalar*=int(p)-1
 op={1:scalar}
 for p in fs:
  p=int(p)
  if (q*m)%p==0:continue
  nxt={}
  for t,c in op.items():
   nxt[t]=nxt.get(t,0)+(p-2)*c
   u=t*pow(p,-1,q)%q
   nxt[u]=nxt.get(u,0)+c
  op={t:c for t,c in nxt.items() if c}
 return op

records=[]
for g,q,m in [(1,5,7),(2,5,7),(3,5,7),(4,5,7),(5,5,7),(7,5,7),(9,5,7),(10,5,6),(6,5,7)]:
 assert gcd(q,m)==1 and m>q>=2
 n=g*q;N=g*m;Q=poly(s.cyclotomic_poly(n,x))
 full_factor=poly(s.cyclotomic_poly(N,x))
 beta=full_factor.rem(Q)
 fibre=[u for u in range(1,n) if gcd(u,n)==1 and u%q==1]
 D=int(s.totient(n))//int(s.totient(q))
 assert len(fibre)==D
 actual=poly(1);trace=poly(0)
 for u in fibre:
  term=reduction(beta.as_expr().subs(x,x**u),Q)
  actual=(actual*term).rem(Q);trace=(trace+term).rem(Q)
 op=operator(g,q,m)
 assert sum(op.values())==s.totient(g)
 predicted=poly(1)
 for t,e in op.items():
  value=reduction(s.cyclotomic_poly(m,x).subs(x,x**(g*t)),Q)
  predicted=(predicted*power(value,e,Q)).rem(Q)
 assert actual==predicted
 assert s.resultant(Q.as_expr(),beta.as_expr(),x)==1
 # Exact additive fibre sums give the ordinary algebraic field trace.
 trace_formula=poly(0)
 for (j,),coeff in full_factor.terms():
  Rj=poly(0)
  for d in s.divisors(g):
   d=int(d)
   if gcd(d,q)>1 or j%(g//d):continue
   h=j//(g//d)
   Rj+=reduction(int(s.mobius(d))*(g//d)*x**(g*((h*pow(d,-1,q))%q)),Q)
  trace_formula=(trace_formula+coeff*Rj).rem(Q)
 assert trace_formula==trace
 # Compatibility only: evaluate the gcd-layer expression proved in the companion chapter.
 layer=poly(1)
 for b in s.divisors(g):
  b=int(b)
  if gcd(b,m)>1:continue
  e=int(s.mobius(b))
  if not e:continue
  value=reduction(s.cyclotomic_poly(m,x).subs(x,x**(g//b)),Q)
  layer=(layer*power(value,e,Q)).rem(Q)
 assert layer==beta
 records.append({'g':g,'q':q,'m':m,'n':n,'N':N,'relative_degree':D,'norm_operator':{str(t):e for t,e in op.items()},'norm_in_Qzeta_n':str(actual.as_expr()),'algebraic_trace_in_Qzeta_n':str(trace.as_expr()),'absolute_norm':1,'gcd_layer_fixture_compatible':True})

n=15;N=21;Q=poly(s.cyclotomic_poly(n,x));beta=reduction(s.cyclotomic_poly(N,x),Q)
beta11=reduction(beta.as_expr().subs(x,x**11),Q)
assert (beta*beta11).rem(Q)==reduction(-x**12,Q)
abs2=(beta*reduction(beta.as_expr().subs(x,x**14),Q)).rem(Q)
assert not (abs2-poly(1)).is_zero
weights={}
for u in [1,11]:
 r=pow(u,-1,n)
 weights[u]=(F(1,N-(N-r)%n)+F(1,N-(N+r)%n))/(2*n)
assert weights=={1:F(1,224),11:F(1,209)}
assert weights[1]-weights[11]==-F(15,46816)
fixture={'g':3,'q':5,'m':7,'beta_in_Qzeta15':str(beta.as_expr()),'fibre':[1,11],'relative_norm':'-zeta5^4','abs_beta_squared_minus_1':str((abs2-poly(1)).as_expr()),'nonzero_proof':'Nonzero polynomial of degree<phi(15), so it cannot vanish at any primitive fifteenth root.','weights':{str(u):str(w) for u,w in weights.items()},'weighted_fibre_log':'(-15/46816)*log(abs(beta)), nonzero','clipping_scope':'Only the actual factor and its fibre weights are checked; no claim about full-prefix clipped activation.'}
print('Exact common-scale norms, algebraic traces, gcd layers and weighted fibre assertions passed.')
