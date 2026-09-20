# Actual Möbius recombination of the distinct-prime Selberg weight

**Status.** This note proves an unconditional exact identity for the actual
Möbius and von Mangoldt functions. Every prime power is retained. The
identity supplies an exact scope test for a proposed recombination in the
critical semiprime problem; it is not the coefficient of that packet and
does not prove the remaining off-diagonal exponential-sum estimate or the
Riemann hypothesis. The
arithmetic-function identity and its divisor-sum form are checked in Lean in
[`MobiusDistinctPrimeRecombination.lean`](../../formalization/BuildingBlocks/MobiusDistinctPrimeRecombination.lean).

## The exact recombination

Write Dirichlet convolution as `*`, and pointwise multiplication as a dot.
Let

\[
 P_2=\Lambda\cdot(\log-\Lambda),\qquad
 D_2=\Lambda*\Lambda-P_2.
\]

The elementary distinct-prime identity gives

\[
 D_2(n)=\sum_{\substack{ab=n\\(a,b)=1}}\Lambda(a)\Lambda(b).
\tag{1}
\]

Then

\[
 \boxed{\quad
 \mu*D_2=(\mu\cdot\log^2)+\mu*(\Lambda^2),
 \quad}                                                     \tag{2}
\]

where both squares on the right are pointwise. In divisor notation, (2) is

\[
 \sum_{d\mid n}\mu(d)D_2(n/d)
 =\mu(n)\log^2n+
   \sum_{d\mid n}\mu(d)\Lambda(n/d)^2.                    \tag{3}
\]

To prove it, let \(Df=f\cdot\log\). Möbius inversion and the logarithmic
Leibniz rule give

\[
 \mu*\Lambda=-D\mu,
 \qquad D(f*g)=Df*g+f*Dg.
\]

Differentiating the first identity gives

\[
 D\mu*\Lambda+\mu*D\Lambda=-D^2\mu,
\]

and hence

\[
 \mu*\Lambda*\Lambda=D^2\mu+\mu*D\Lambda.                 \tag{4}
\]

Since \(P_2=D\Lambda-\Lambda^2\), subtracting \(\mu*P_2\) from
(4) proves (2). This proof is entirely finite at each integer.

## Exact support and sign

Equation (3) makes the prime-power correction explicit. On \(n=p^a\),
the two terms on its right cancel, including \(a=1\), and therefore

\[
 (\mu*D_2)(p^a)=0.                                        \tag{5}
\]

More generally, the convolution vanishes unless \(n\) is squarefree. If
\(n\) is squarefree, then

\[
 \boxed{\quad
 (\mu*D_2)(n)
 =2\mu(n)\sum_{\substack{p<q\\p,q\mid n}}\log p\log q.
 \quad}                                                     \tag{6}
\]

Indeed, \(D_2(m)\) is nonzero only when \(m\) has exactly two distinct
prime bases, and its value there is twice the product of their logarithms.
Möbius convolution takes the finite difference in every prime exponent,
which kills every nonsquarefree input and gives (6) on squarefree inputs.

Formula (6) also gives a sign comparison for a local argument. For distinct
primes,

\[
 (\mu*D_2)(pq)=2\log p\log q>0,
 \qquad
 (\mu*D_2)(pqr)
 =-2(\log p\log q+\log p\log r+\log q\log r)<0.           \tag{7}
\]

Thus the two local prime Möbius signs in a semiprime fiber multiply to
\(+1\). The first negative sign appears only when a complementary Möbius
history is restored.

## Why this is not the critical off-diagonal coefficient

At the critical scales

\[
 2<\lambda<\frac{29}{14},\qquad
 P=T^{1-2\lambda/5},\quad Q=T^{\lambda/5},\quad
 C=T^{4\lambda/5-1},\quad N=Q^5,
\]

the unresolved two-prime energy is

\[
 E_{\ne}=\sum_{k\asymp P}\sum_{q\ne q'}
 \sum_{r,r'\asymp Q^2}d_q\overline{d_{q'}}
 R(r)\overline{R(r')}
 e\!\left(-kN\left(\frac1{qr}-\frac1{q'r'}\right)\right).
\tag{8}
\]

The required estimate is, for some fixed \(\rho>0\),

\[
 E_{\ne}\ll_\varepsilon T^\varepsilon P Q^5T^{-2\rho}.
\tag{9}
\]

The established diagonal sampling estimate permits every
\(0<\rho<\lambda/10\). The parent reduction, however, comes from Vaughan's
exact identity

\[
 \mu=2a-a*a*1+b*b*1,
\]

and the unresolved term is literally

\[
 \sum_{r,s>U}\sum_{t\ge1}\mu(r)\mu(s)L_{rst}(T).          \tag{10}
\]

Consequently the critical variables have coefficient
\(\mu(p)\mu(q)\cdot1(c)\). The outer factor \(c=t\) has coefficient one,
not \(\mu(c)\), and the two local factors carry Möbius values, not the
logarithmic von Mangoldt weight \(D_2(pq)\). Formula (2) therefore does not
recombine (8) or (10).

The amplitude \(L_{rst}(T)\) depends only on the product \(m=rst\). Before
dyadic separation, the applicable exact identity is instead

\[
 (\mu*\mu)*1=\mu,                                         \tag{11}
\]

which recovers the original sum \(\sum_m\mu(m)L_m(T)\). This recombination
is already built into the parent argument. The restriction \(r,s>U\) and
the independent dyadic cutoffs on \(r,s,t\) prevent applying (11) to the
isolated balanced residual.

There are therefore two exact coefficient mismatches for a proposed use of (2) in the critical packet. If the proposed coefficient lacks an outer Möbius factor,
or lacks the logarithmic weights in (1), it is not \(\mu*D_2\). Even in a
problem where (2) is the correct coefficient, assigning a negative sign to
the isolated \(pq\) term contradicts (7).

For a concrete coefficient check, take three distinct primes
\(c=\ell,p,q\). The live factor in (10) is
\(1(\ell)\mu(p)\mu(q)=+1\). The corresponding outer-Möbius contribution
suggested by (2) has sign \(\mu(\ell)=-1\) and logarithmic magnitude. The
outer sign is already opposite, before any phase or endpoint estimate is
used.
