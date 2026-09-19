# A canonical dual cosine formula for the actual lattice remainder

Attribution: Arterialist RH research team, September 2026. This note records the exact formulas and their classical Poisson, Bernoulli, and Peano-kernel ingredients; no priority claim is made.

This written proof gives an absolutely convergent dual cosine formula, a centered differential identity and an equivalent Peano formula for the actual lattice remainder. Poisson summation, Bernoulli Fourier series and cell interpolation are classical tools. The exact logarithmic weight removes the singular zero endpoint while retaining the fractional first cell and derivative contacts.

Use the notation and exact identity from [actual coherent division lattice remainder](actual-coherent-division-lattice-remainder.md):

$$
E(e^{-t})+C(t)=\mathcal Q(t)+\mathcal R(t),\qquad
\mathcal Q(t)=\sqrt t\sum_{m\ge1}\log(m)L(tm),
\quad |\mathcal R(t)|\le C_0\sqrt t.
\tag{1}
$$

Here t is a geometric successor parameter. The complete inverse kernel is L(z)=sum mu(k)K(kz). Its checked absolute moments satisfy integral L=integral L log=0. The endpoint correction C and signed error R in (1) remain unchanged throughout.

## The literal first cell supplies the regular domain

Fix t>0 and put

$$
f_t(x)=\log x\,L(tx)\quad(x>0),\qquad
g_t(x)=\mathbf1_{|x|\ge1}f_t(|x|)\quad(x\in\mathbb R).
\tag{2}
$$

There is no smoothing choice at the origin: f_t(1)=0 because the terminal state has log1=0. Thus g_t is continuous at both cut endpoints. In contrast, f_t need not be regular at zero, and no inverse-weight integrability of raw L is asserted.

The explicit K and its first two derivatives satisfy K^(j)(z)=O(z^(-3/2-j)) at infinity. These follow directly from its Dawson integral and differential equation, also displayed below. On every compact subinterval of (0,infinity), the complete derivative series

$$
L^{(j)}(z)=\sum_{k\ge1}\mu(k)k^jK^{(j)}(kz),\quad j=0,1,2,
\tag{3}
$$

converge absolutely and locally uniformly; the k tail is O(k^(-3/2)). They also give L^(j)(z)=O(z^(-3/2-j)) at infinity. Hence on [1,infinity), f_t and f_t' are integrable and tend to zero, while

$$
f_t''(x)=-\frac{L(tx)}{x^2}+
\frac{2tL'(tx)}x+t^2\log x\,L''(tx)
\tag{4}
$$

is integrable. The distributional second derivative of g_t has this even interior density plus the two derivative-contact atoms

$$
L(t)(\delta_{-1}+\delta_1).
\tag{5}
$$

It is therefore a finite signed measure. The origin contributes no distribution because g_t vanishes on (-1,1). The contact (5) follows from f_t'(1)=L(t), and is retained below.

## Absolutely convergent Poisson duality

Use Fourier transform ghat(xi)=integral exp(-i xi x)g(x)dx. Since D²g_t is a finite measure, ghat_t(2pi k)=O_t(k^(-2)) for nonzero integer k. The periodization sum_n g_t(y+n) converges uniformly on compact y ranges by the explicit integrable power tail, and is continuous. Its Fourier coefficients are ghat_t(2pi k), by absolute Fubini. The absolutely convergent Fourier series and uniqueness give Poisson summation at y=0.

Using evenness and g_t(0)=0, this proves

$$
\sum_{m\ge1}f_t(m)-\int_1^\infty f_t(x)dx
=2\sum_{k\ge1}\int_1^\infty f_t(x)\cos(2\pi kx)dx.
\tag{6}
$$

The dual series is absolutely convergent. The checked log moments imply integral_0^infinity f_t=0. Consequently the desired source readout is exactly

$$
\boxed{\mathcal Q(t)=
2\sqrt t\sum_{k\ge1}\int_1^\infty f_t(x)\cos(2\pi kx)dx
-\sqrt t\int_0^1f_t(x)dx.}
\tag{7}
$$

The entire fractional first cell stays present. This proof applies ordinary Poisson summation to a regular cutoff function. It does not assert that raw f_t satisfies the stronger endpoint hypotheses of a co-Poisson theorem.

## The derivative contact and periodic curvature

Twice integrating the individual cosine integral by parts gives

$$
\int_1^\infty f_t(x)\cos(2\pi kx)dx
=-\frac{L(t)}{(2\pi k)^2}
-\frac1{(2\pi k)^2}\int_1^\infty f_t''(x)\cos(2\pi kx)dx.
\tag{8}
$$

All boundaries at infinity vanish. At x=1 the value f_t(1) vanishes, while its derivative does not. The Fourier identity
sum_(k>=1)cos(2pi kx)/k²=pi²B2({x}), with B2(u)=u²-u+1/6, is absolutely convergent. Interchanging it with the integrable second derivative in (8) yields

$$
\boxed{\mathcal Q(t)=
-\sqrt t\int_0^1\log x\,L(tx)dx
-\frac{\sqrt t}{12}L(t)
-\frac{\sqrt t}{2}\int_1^\infty B_2(\{x\})f_t''(x)dx.}
\tag{9}
$$

The first two terms form a specific endpoint packet. Neither is declared positive. The two cancelled moments also give the useful exact rewrite

$$
-\sqrt t\int_0^1\log x\,L(tx)dx
=t^{-1/2}\int_t^\infty\log(u/t)L(u)du.
\tag{10}
$$

Both sides converge absolutely. This moves the fractional first cell into a complete signed tail rather than deleting it.

There is a direct limitation on pointwise sign arguments for the dual modes. By Riemann--Lebesgue applied to (4), the right side of (8) is -L(t)/(2pi k)^2+o_t(k^(-2)). Thus high dual modes have the opposite sign of L(t) whenever L(t) is nonzero. The accepted positive-negative-positive values of the ACTUAL L give actual parameter values of both signs for those modes. This says nothing against a combined sign estimate for (9) with its endpoint packet and R(t) retained.

## The specific K equation and a convergent division lift

The explicit kernel obeys

$$
K'(z)=-\frac{b(z)}{2z},\qquad
b'(z)+b(z)=\frac1{2z^{3/2}}.
$$

Therefore

$$
zK''(z)+(1+z)K'(z)=-\frac1{4z^{3/2}}.
\tag{11}
$$

One must not sum the separated forcing after multiplication by mu(k): it would introduce the non-absolutely convergent series sum mu(k)/sqrt k. Instead subtract the exact leading derivative tail inside each term and define

$$
\mathcal T(z)=\sum_{k\ge1}\mu(k)k^2
\left[K'(kz)+\frac1{4(kz)^{5/2}}\right].
\tag{12}
$$

The bracket is O((kz)^(-7/2)) at infinity, so (12) converges absolutely and locally uniformly. The complete identity (11) then gives

$$
\boxed{zL''(z)+L'(z)=-z\mathcal T(z).}
\tag{13}
$$

In (9), this replaces (4) by the exact convergent expression

$$
f_t''(x)=-x^{-2}L(tx)
+\frac{t(2-\log x)}xL'(tx)
-t^2\log x\,\mathcal T(tx).
\tag{14}
$$

Equations (12)--(14) provide an actual division-compatible differential form of the periodic curvature term. They assign no sign to the centered forcing or its Bernoulli pairing. The target remains the combined bound Q(t)+R(t)>=C(t), or a bound with the explicit C0 sqrt(t) error margin. Poisson duality, the positive curved-log moment, and the known signed shape of L do not by themselves prove it.


## Combine the contact before testing curvature

There is a nonnegative observation kernel after the derivative contact is combined exactly with the periodic term. Define p(x)={x}(1-{x}). Because f_t' tends to zero and f_t'(1)=L(t),

$$
\int_1^\infty f_t''(x)dx=-L(t).
$$

Substitute B2({x})=1/6-p(x) in (9). The constant 1/6 term cancels the displayed derivative contact exactly, giving

$$
\boxed{Q(t)=F_{\rm cell}(t)+\frac{\sqrt t}{2}
\int_1^\infty p(x)f_t''(x)dx,\qquad
F_{\rm cell}(t)=-\sqrt t\int_0^1\log x L(tx)dx.}
\tag{15}
$$

This is also the summed trapezoidal Peano identity

$$
\frac12\int_m^{m+1}(x-m)(m+1-x)f_t''(x)dx
=\frac{f_t(m)+f_t(m+1)}2-\int_m^{m+1}f_t(x)dx.
\tag{16}
$$

Its proof is two ordinary integrations by parts on each closed cell. The sums converge absolutely by the already proved bounds on f_t and f_t''. The value f_t(1)=0 is essential when converting the summed trapezoid samples to the original lattice sum. The first cell (0,1) is still explicit in (15).

In particular the exact centered ODE gives the actual curvature integrand

$$
p(x)\left[-\frac{L(tx)}{x^2}
+\frac{t(2-\log x)}xL'(tx)-t^2\log x\,\mathcal T(tx)\right].
\tag{17}
$$

The observation p is nonnegative and zero at integers; the complete integrand remains signed. A lower comparison for the integrated quantity in (15), together with its first-cell term, would be relevant even if pointwise curvature changes sign. Neither the zero moments nor the quadratic-log calibration establishes that comparison.

The proved [mean-removal refinement](../successor-and-division/actual-coherent-successor-quadrature-refinement.md) gives the following stronger sufficient criterion using an unsigned error margin:

$$
\frac{e^t-1}{t}\left[F_{\rm cell}(t)
+\frac{\sqrt t}{2}\int_1^\infty p(x)f_t''(x)dx\right]
\ge C(t)+C_1t\log(2/t).
\tag{18}
$$

Formula (18) is an unproved quantitative target. The actual signed epsilon can instead be kept on the left. This formulation combines the first derivative contact before any sign test, and does not convert a positive observation kernel into a sign claim about its arithmetic source.

The classical Bernoulli Fourier identity used in (9) is [DLMF 24.8.1](https://dlmf.nist.gov/24.8.E1). [Burnol, JTNB 16 (2004), §1](https://jtnb.centre-mersenne.org/item/10.5802/jtnb.434.pdf) discusses the related Müntz density-subtraction and Duffin–Weinberger co-Poisson mechanisms. That attribution concerns the general lattice/Mellin method, not an exact match to this successor kernel or its retained endpoint. The elementary Poisson proof above states its own complete regularity and convergence hypotheses.

This chapter contains written analysis, with no Lean claim for the quadrature, dual series or arithmetic comparison. No priority claim is made.
