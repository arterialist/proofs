"""Arb certificate for natural cutoffs 2<=N<=22 and the PNT reduction constants."""
from flint import arb, ctx

ctx.prec=192
prime_base={2:2,3:3,4:2,5:5,7:7,8:2,9:3,11:11,13:13,16:2,17:17,19:19,23:23}
lam={n:arb(prime_base[n]).log() if n in prime_base else arb(0) for n in range(2,24)}
def d(n):
 z=1/arb(n).sqrt()
 return z.asin()-z
def tail(n):
 z=arb(n)
 return 2*z.sqrt()-(z-1).sqrt()-z*(1/z.sqrt()).asin()
minimum=arb(1)
for N in range(2,23):
 delta=sum((lam[n]*d(n) for n in range(2,N+1)),arb(0))+tail(N)
 assert delta>0
 psiN=sum((lam[n] for n in range(2,N+1)),arb(0))
 # A sufficient strict-positive bound for every x>=N.
 assert delta+(psiN-N)/(3*N)>arb(9)/100
 F=arb(0);psi=arb(0)
 for n in range(1,N):
  last=n==N-1
  psin=psi+lam[n+1]
  def value(x):
   z=x.sqrt();a=arb(n).sqrt()
   result=F+2*psin*(z.atan()-a.atan())+2*(psi+delta)*(1/z-1/a)
   if last:result+=2*(z-a)-2*N*(z.atan()-a.atan())
   return result
  def num(x):
   z=x*lam[n+1]-psi-delta*(x+1)
   if last:z+=x*(x+1-N)
   return z
  left,right=num(arb(n)),num(arb(n+1))
  Fnext=value(arb(n+1))
  if n==1:
   assert left>0
   assert (lam[n+1]-delta+(2*n+1-N if last else 0))>0
  else:
   assert F>0 and Fnext>0
   if left<0 and right>0:
    if last:
     b=lam[N]-N+1-delta
     root=(-b+(b*b+4*(psi+delta)).sqrt())/2
    else:
     root=(psi+delta)/(lam[n+1]-delta)
    assert root>n and root<n+1
    assert value(root)>0
   elif last:
    # Increasing quadratic numerator: no other interior minimum.
    assert 2*n+lam[N]-N+1-delta>0
   else:
    # An affine derivative numerator has no further minima.
    assert left>0 or right<0
  F=Fnext;psi=psin
 print('certified natural cutoff',N,'charge',delta,'tail lower coefficient',delta+(psiN-N)/(3*N))
R=arb(1291)/200
z=(arb(23).log()/R).sqrt()
epsilon=(8/(17*arb.pi())).sqrt()*z.sqrt()*(-z).exp()
B=46*d(23)+tail(23)
error=epsilon*B
assert arb(279)/1000+error<arb(303)/1000
assert arb(2789)/10000-error>arb(25)/100
assert 2*(arb(25)/100-epsilon)>arb(17)/100
assert 2*(arb(303)/1000-arb(279)/1000)*(1-1/arb(23).sqrt())<arb(1)/25
assert arb(2).log()-2*arb(303)/1000>0
print('N>=23 charge error bound:',error)
print('certified: 1/4<delta_N<303/1000, and global primitive positivity')
