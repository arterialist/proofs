# A positive off-diagonal Weil kernel blocks a positive heat semigroup

Connes's proposed use of the lowest Weil eigenvector requires its
eigenvalue to be simple and its eigenvector even. This note tests the
standard route through a positivity-improving heat semigroup. The route
fails for the **complete** compact Weil form on every multiplicative
window $[\lambda^{-1},\lambda]$ with
$\lambda>\sqrt{4/3}$. The result concerns semigroup positivity; it does
not assert that the lowest eigenvalue is multiple or that its eigenvector
is odd.

## Exact off-diagonal form

Put $a=\log\lambda$ and use logarithmic coordinates
$u=\log x\in(-a,a)$, so $dx/x=du$. Let $q_\lambda$ be the closed,
lower-bounded Weil form of [Connes--Consani, equations (2.6)--(2.12)](https://arxiv.org/html/2106.01715).
For real, nonnegative, smooth $f,g$ with disjoint compact supports, its
cross form is

\[
\begin{aligned}
q_\lambda(f,g)
={}&\int_{-a}^{a}\!\int_{-a}^{a}
 f(u)g(v)\,K(|u-v|)\,du\,dv\\
&-\sum_{1<n\le\lambda^2}\frac{\Lambda(n)}{\sqrt n}
  \int_{-a}^{a}f(u)
  \bigl(g(u+\log n)+g(u-\log n)\bigr)\,du,
\end{aligned}\tag{1}
\]

where zero extension is understood and, away from $s=0$,

\[
K(s)=2\cosh(s/2)-\frac{e^{-s/2}}{1-e^{-2s}}.
\tag{2}
\]

Here the first term of $K$ comes from the two pole evaluations in
equation (2.8), equivalently the rank-two pole in equation (2.11).
The second comes with a minus sign from $W_{\mathbb R}$ in equations
(2.7)--(2.8): after $x=e^s$, its off-diagonal weight is
$e^{s/2}/(e^s-e^{-s})=e^{-s/2}/(1-e^{-2s})$.
The last line of (1) is the full prime-power contribution from
equations (2.6), (2.11)--(2.12). Terms supported on the diagonal in
$W_{\mathbb R}$ vanish because $f$ and $g$ have disjoint supports.

At the separation $s_0=\log(4/3)$, which is below the first prime
shift $\log2$, exact arithmetic gives

\[
K(s_0)=\frac{7}{2\sqrt3}-\frac{8\sqrt3}{7}
=\frac{1}{14\sqrt3}>0.
\tag{3}
\]

If $\lambda>\sqrt{4/3}$, the points $-s_0/2$ and $s_0/2$ lie strictly
inside $(-a,a)$. Choose nonzero, nonnegative smooth bumps $f,g$
around those points, sufficiently narrow that every cross-support
distance stays in a neighborhood of $s_0$ contained in $(0,\log2)$
where $K>0$. Every prime-power integral in (1) then vanishes, while
the double integral is strictly positive. Hence

\[
\boxed{\quad q_\lambda(f,g)>0\quad\text{for disjoint }f,g\ge0.
\quad}\tag{4}
\]

## Semigroup consequence and scope

Let $A_\lambda$ be the self-adjoint operator associated with the closed
form $q_\lambda$, as in [Connes, equation (19)](https://arxiv.org/html/2602.04022).
For any real lower-bounded closed form, positivity preservation of
$e^{-tA_\lambda}$ would force $q_\lambda(f,g)\le0$ whenever $f,g$
are nonnegative, disjoint elements of the form domain. Indeed, after
adding a scalar to make the operator nonnegative, the form identity
$q(f,g)=\lim_{t\downarrow0}t^{-1}\langle f,(I-e^{-tA})g\rangle$
has $\langle f,g\rangle=0$; a positive semigroup would make this
limit nonpositive. Equation (4) instead gives
$t^{-1}\langle f,e^{-tA_\lambda}g\rangle\to-q_\lambda(f,g)<0$.
Therefore

\[
\boxed{\quad e^{-tA_\lambda}\text{ fails to preserve positivity for
all sufficiently small }t>0\text{ when }\lambda>\sqrt{4/3}.\quad}\tag{5}
\]

In particular, the heat semigroup is not positivity improving. A
strictly positive ground-state multiplier $h$ cannot change this:
multiplication by $h$ and by $h^{-1}$ are order preserving, so the
ground-state-conjugated semigroup is positive exactly when the original
one is. The usual Perron--Frobenius or Doob-transform argument therefore
cannot establish the simple even bottom sought in
[Connes, sections 6.1 and 6.6](https://arxiv.org/html/2602.04022).
A proof based on a different spectral or arithmetic mechanism remains
possible. No all-window Weil sign or RH conclusion is obtained here.

This is a written analytic proof, not a Lean formalization. It is
specific to Connes--Consani's full Weil form with both poles, the
archimedean term, and every admitted prime power. It is distinct from
the [odd theta reflection-atom obstruction](theta-odd-prime-atom-obstruction.md),
which concerns a different killed half-line form.
