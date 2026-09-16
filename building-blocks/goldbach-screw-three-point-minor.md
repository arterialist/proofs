# The equally spaced three-point Goldbach screw minor

## Exact matrix

Use the Matsumoto--Suzuki screw convention

\[
G_g(u,v)=g(u-v)-g(u)-g(-v)+g(0)
\]

and suppose `g` is real and even.  Put

\[
a=g(t)-g(0),\qquad b=g(2t)-g(0),\qquad c=g(3t)-g(0).
\]

On the points `t,2t,3t`, the complete principal matrix is

\[
K_3(a,b,c)=
\begin{pmatrix}
-2a&-b&b-a-c\\
-b&-2b&a-b-c\\
b-a-c&a-b-c&-2c
\end{pmatrix}.                                      \tag{1}
\]

For example, the `(2,3)` entry is
`g(-t)-g(2t)-g(-3t)+g(0)=a-b-c`.  No Toeplitz entry or endpoint has been
dropped.

Its determinant is

\[
\begin{aligned}
D(a,b,c)=2\{&-4abc+a(a-b-c)^2+b^2c\\
             &-b(a-b-c)(b-a-c)+b(b-a-c)^2\}.         \tag{2}
\end{aligned}
\]

Positive semidefiniteness requires `D(a,b,c)>=0` in addition to all the
diagonal and `2x2` principal-minor inequalities.  The cubic determinant by
itself is not a replacement for those lower minors.

For the actual function

\[
g(t)=H_1(e^t)-H_1(1)
\]

and `t=log N`, equation (2) uses exactly

\[
a=H_1(N)-H_1(1),\quad
b=H_1(N^2)-H_1(1),\quad
c=H_1(N^3)-H_1(1).                                  \tag{3}
\]

As in the two-point audit, positivity of this actual matrix is conditional:
Matsumoto--Suzuki prove that screw positivity on the whole line is
equivalent to RH.

## Complete weighted-prefix substitution

Let

\[
A(X)=\sum_{n\le X}\frac{r_2(n)}{n^2},\qquad
U_X=A(X)-\log X-c_2,
\]

with `r_2(n)=sum_{m+k=n} Lambda(m)Lambda(k)`.  Every ordered pair, prime
power, and additive endpoint is retained.  Write the three weighted-prefix
formulas, with separate remainders, as

\[
\begin{aligned}
a&=\frac{\sqrt N}{2}\{U_N-E_W(N)\}-H_1(1),\\
b&=\frac{N}{2}\{U_{N^2}-E_W(N^2)\}-H_1(1),\\
c&=\frac{N\sqrt N}{2}\{U_{N^3}-E_W(N^3)\}-H_1(1).   \tag{4}
\end{aligned}
\]

Substitution of (4) into `D(a,b,c)>=0` is the exact finite Goldbach
consumer.  There is no legitimate simplification that discards one of the
three errors.  As recorded in the preceding audit, Matsumoto--Suzuki derive
the useful error estimate under RH; unconditionally (4) is an identity only
when `E_W` is defined as the residual.

## Error frontier

Assume the same power estimate used in the two-point audit,

\[
|R_F(y)|\le Cy^\theta\qquad(\theta<2),
\]

for the Fujii remainder separated from the zero sum.  Partial summation
gives

\[
|E_W(X)|\le C_\theta X^{\theta-2},\qquad
C_\theta=C\frac{4-\theta}{2-\theta}.                 \tag{5}
\]

At the three scales, the errors in the reconstructed values `a,b,c` are
bounded respectively by

\[
\frac{C_\theta}{2}N^{\theta-3/2},\qquad
\frac{C_\theta}{2}N^{2(\theta-3/2)},\qquad
\frac{C_\theta}{2}N^{3(\theta-3/2)}.                \tag{6}
\]

All three vanish exactly when

\[
\boxed{\theta<3/2}.                                  \tag{7}
\]

The third scale accelerates convergence below the frontier and divergence
above it, but does not move the frontier.  At `theta=3/2`, each coordinate
error is only `O(1)`.  Since `D` is cubic, controlling the resulting
determinant error also requires an a priori bound for `a,b,c`.  Such a bound
for the actual `H_1` is already part of the RH-level analytic setting.

There is no hidden cancellation at the critical exponent.  The exact
specialization

\[
D(-1,-1,-1+e)=4-2e-2e^2                              \tag{8}
\]

has a nonzero linear response to the third-scale error.  Thus an `O(1)`
error in `c` produces an `O(1)` determinant ambiguity even with `a,b`
fixed.  The three-point minor is richer algebraically, but its transfer
threshold is the same `theta<3/2` threshold as the two-point minor.  It
does not turn an unconditional `X^(2-o(1))` Goldbach error into a sign.

## Low-coefficient obstruction

The raw Goldbach coefficients still cannot serve as moments of a positive
measure.  Let `r_j=r_2(j)` and use the vector

\[
v=(r_5,-r_4,0).
\]

For the raw Hankel matrix starting at total four,

\[
v^T
\begin{pmatrix}
r_4&r_5&r_6\\
r_5&r_6&r_7\\
r_6&r_7&r_8
\end{pmatrix}v
=r_4\{r_4r_6-r_5^2\}<0.                              \tag{9}
\]

The third coordinate is zero, so (9) embeds the smallest all-nonzero
`2x2` counterexample.  It is a concrete `3x3` failure, though not a new
independent obstruction.

## Formal scope

[`GoldbachScrewThreeMinorFinite.lean`](BuildingBlocks/GoldbachScrewThreeMinorFinite.lean)
compiles the matrix (1), determinant (2), complete substitution (4),
critical sensitivity (8), and the low-coefficient witness (9).  Printed
axioms are only Lean's standard logical axioms.  The module proves no screw
positivity, remainder estimate, analytic continuation, or RH consequence.
