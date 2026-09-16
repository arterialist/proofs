# Suzuki 2026, Corollary 1.6: a limit-domain audit

Status: an elementary correction to the domain of a conjectural limit statement. This note does not prove RH or challenge the separate operator-construction results in the cited preprint. Checked 2026-09-16.

The source is Masatoshi Suzuki, *Weil's quadratic form via the screw function*, [arXiv:2606.09096v1, Corollary 1.6, equation (1.12)](https://arxiv.org/html/2606.09096v1#S1.SS2), whose displayed manuscript date is August 24, 2026. Theorem 1.5 states that \(W(a,\theta;z)\) is entire and has only real zeros. Corollary 1.6 proposes

\[
 e^{\phi(a,z)}W(a,\theta(a);z)\longrightarrow
 F(z):=z^2\frac{\xi(1/2-iz)}{\xi'(1/2-iz)}
 \tag{1}
\]

uniformly on every compact subset of \(\mathbb C\). The text requires \(\phi(a,z)\) to be finite, but does not explicitly require holomorphy or specify spherical convergence.

## The literal all-plane statement is impossible

Put \(X(z)=\xi(1/2-iz)\), so \(X\) is real on the real axis and

\[
 F(z)=-iz^2\frac{X(z)}{X'(z)}.
\]

[Hardy's theorem](https://fr.wikisource.org/wiki/Page:Comptes_rendus_hebdomadaires_des_s%C3%A9ances_de_l%E2%80%99Acad%C3%A9mie_des_sciences,_tome_158,_1914.djvu/1014) gives infinitely many distinct positive real zeros of \(X\). Between each consecutive pair \(t_j<t_{j+1}\), Rolle's theorem gives \(c_j\in(t_j,t_{j+1})\) with \(X'(c_j)=0\). Since the endpoints are consecutive distinct real zeros, \(X(c_j)\ne0\). Thus \(F\) has a genuine pole at every \(c_j\ne0\); the factor \(z^2\) cannot cancel any of them. No simplicity assumption on the zeros is needed.

Consequently ordinary finite-valued compact-uniform convergence on all of \(\mathbb C\) cannot hold in (1), even under RH. If the normalizing factors are holomorphic, the locally uniform limit of the entire left-hand sides would moreover have to be entire.

Merely deleting the poles from the convergence domain does not repair the entire-function interpretation. If \(p\) is a pole of order \(m\), choose a small circle \(C\) about \(p\) containing no other pole. Uniform convergence on \(C\) of entire functions \(f_a\) to \(F\) would give

\[
 0=\lim_a\oint_C(z-p)^{m-1}f_a(z)\,dz
   =\oint_C(z-p)^{m-1}F(z)\,dz\ne0.
\]

Spherical convergence does not rescue this case either: on the circle, where \(F\) is finite and bounded, uniform spherical convergence implies ordinary uniform convergence. These contour arguments assume holomorphic left-hand sides. If arbitrary nonholomorphic normalizations are instead allowed, the analytic zero-preservation argument needs a separate justification.

## A consistent corrected implication

A possible replacement is locally uniform convergence on \(\mathbb C\setminus\mathbb R\), with the normalized left-hand sides holomorphic and zero-free there. Then (1) does imply RH.

Indeed, an off-line zero of \(\xi\) corresponds to a nonreal zero \(z_0\) of \(X\). If its multiplicity is \(m\), locally

\[
 \frac{X(z)}{X'(z)}=\frac{z-z_0}{m}+O((z-z_0)^2).
\]

Therefore \(F\), after removing the apparent quotient singularity, has a simple zero at \(z_0\ne0\). On a small disk about \(z_0\), Hurwitz's theorem contradicts convergence of zero-free holomorphic functions to this nonzero holomorphic function. This excludes every off-line zero, including multiple zeros.

The corrected domain is compatible with RH: under RH,
\[
X(z)=X(0)\prod_{\gamma>0}(1-z^2/\gamma^2),
\]
with zeros repeated by multiplicity. The finite products have only real zeros, as do their derivatives by Rolle's theorem. Locally uniform convergence and Hurwitz's theorem then show that \(X'\) has only real zeros. Hence \(F\) is holomorphic and zero-free on both open half-planes. Real poles remain on the excluded boundary.

There is a further limitation if arbitrary \(z\)-dependent exponential normalizations are permitted. Under RH, for any sequence of nonzero entire \(W_n\) having only real zeros, \(F/W_n\) has a holomorphic logarithm on each half-plane. Runge approximation on an exhaustion by two disjoint closed rectangles, one in each half-plane, supplies entire polynomials \(p_n\) such that \(e^{p_n}W_n\to F\) locally uniformly off the real axis. Thus unrestricted normalizations can manufacture the corrected convergence once RH is assumed. A useful arithmetic limit theorem must additionally specify or constrain the normalization and prove convergence independently.

The audit concerns the precise all-plane convergence formulation of Corollary 1.6. The corrected implication is a conditional analytic criterion, not progress toward proving the required arithmetic estimate.
