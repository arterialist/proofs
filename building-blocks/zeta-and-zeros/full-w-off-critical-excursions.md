# Off-critical zeros force power-sized excursions of both signs in the full W

This is a standard Landau consequence of the Mellin transform already
proved in the [square-root multiple sign criterion](sqrt-multiple-sign-criterion.md).
It supplies a conditional diagnostic, not a new bound toward RH.

This concerns the complete critical arithmetic function $W$ defined in
[the square-root multiple criterion](sqrt-multiple-sign-criterion.md), not the per-state defect or a different
weighted increment observable. If zeta has a nontrivial zero
$\rho=\beta+i\gamma$ with $\beta>1/2$, then for every $0<\eta<\beta-1/2$,

$$
\boxed{
\limsup_{x\to\infty}\frac{W(x)}{x^{3/2+\eta}}=+\infty,
\qquad
\liminf_{x\to\infty}\frac{W(x)}{x^{3/2+\eta}}=-\infty.
}
\tag{1}
$$

No selected zero is assumed to dominate other zeros, and no alignment of
their phases is assumed. The conclusion is conditional on an off-critical
zero; it is not evidence that such a zero exists.

## The complete Mellin transform

Write

$$
\Sigma(s)=-\frac{\zeta'(s)}{\zeta(s)}-\frac{s}{s-1},
\qquad
P(s)=\sum_p(\log p)^2\frac{p^{-2s}}{(1-p^{-s})^2}.
$$

The first function is the Mellin--Stieltjes transform of
$\sigma=d\psi-dt-\delta_1$. The second is the literal same-prime sum:

$$
P(s)=\sum_p\sum_{j\ge2}(j-1)(\log p)^2p^{-js}.
$$

For $\Re(s)>1$, absolute integration gives

$$
\boxed{
\int_1^\infty W(x)x^{-s-2}dx
=\frac{\zeta(s+1/2)}{s(s+1)}[\Sigma(s)^2-P(s)]
=:\mathcal M(s).
}
\tag{2}
$$

Indeed the tent kernel contributes $(ab)^{-s}/[s(s+1)]$, and the exact
critical scale sum contributes $\sum_d d^{-s-1/2}=\zeta(s+1/2)$. This keeps
the baseline atom, all proper powers, and every critical scale.

The sum defining $P$ converges locally uniformly for $\Re(s)>1/2$.
Therefore (2) continues meromorphically to that half-plane. It is analytic
at every real $s>1/2$. In particular, the apparent singularity of $\Sigma$
at $1$ cancels; the remaining real values of zeta in $(1/2,1)$ are nonzero.

If $\rho$ is a zero of multiplicity $m$ with $\Re(\rho)>1/2$, then

$$
\Sigma(s)=-\frac m{s-\rho}+O(1).
$$

Thus $\mathcal M$ has a genuine double pole at $\rho$, with nonzero leading
coefficient

$$
\frac{m^2\zeta(\rho+1/2)}{\rho(\rho+1)}.
\tag{3}
$$

The numerator is nonzero because $\Re(\rho+1/2)>1$. The diagonal series is
analytic at $\rho$ and cannot remove the double pole.

## Positivity excludes either one-sided power bound

Put $\alpha=3/2+\eta$, so $\alpha-1<\beta$. Suppose first that
$W(x)\le Cx^\alpha$ eventually, for some finite $C$. The function
$F(x)=Cx^\alpha-W(x)$ is then nonnegative on a tail. Its Mellin transform,
after removal of the finite initial interval, is

$$
\frac{C}{s+1-\alpha}-\mathcal M(s)+E(s),
$$

where $E$ is entire. It retains the genuine pole (3), while its only new
real pole is at $s=\alpha-1<\beta$.

Under $x=e^t$, this Mellin transform is the Laplace transform of
$e^{-t}F(e^t)$. Its convergence abscissa is finite: the elementary
Chebyshev bound and tent convolution give
$W(x)=O(x^2 \log(2x))$. The genuine pole at $\rho$ forces this abscissa to
be at least $\beta$; otherwise the defining Laplace integral would be
analytic at $\rho$. Landau's positivity theorem, in the form stated in [Suzuki, Proposition 1](https://arxiv.org/html/2411.07436), then forces a singularity
at a real point at least $\beta$. There is none, by (2) and
$\alpha-1<\beta$. This is a contradiction.

Therefore no finite eventual upper bound $W(x)\le Cx^\alpha$ exists.
Applying the same argument to $Cx^\alpha+W(x)$ excludes every finite
eventual lower bound $W(x)\ge-Cx^\alpha$. These two assertions are exactly
(1).

For clarity, the polynomial bound used above does not require RH. One has
$|\sigma|([1,t])=O(t)$. Integrating on $ab\le x$ gives
$|N(x)|=O(x^2 \log(2x))$; summing the critical factors uses the convergent
series $\sum_d d^{-3/2}$. The nonnegative same-prime cost has the smaller
bound proved in the companion note. Thus the required Laplace abscissas
are finite.

Under RH the [square-root multiple theorem](sqrt-multiple-sign-criterion.md) instead gives
$W(x)\sim-\frac16x^{3/2}\log^2x$. This separates the two possible global
behaviors. Local positive birth coefficients, or positive values of the
material generator, occur without deciding between them.
