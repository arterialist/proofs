# The first Bessel-product cumulant and its arithmetic scope

## Exact source and hypotheses

The source is Matsumoto--Suzuki, *M-functions and screw functions:
applications to Goldbach's problem and zeros of the Riemann zeta-function*,
[arXiv:2409.00888v2](https://arxiv.org/abs/2409.00888), especially Theorem
1.4, Theorem 2.1, equations (5.5)--(5.6), and Theorem 5.1.

For the `H_1` specialization, let `gamma` range over the **distinct**
positive ordinates of nontrivial zeta zeros and let `m_gamma` be the
multiplicity of `1/2+i gamma`.  Under RH the Bessel amplitude is

\[
a_\gamma=\frac{2m_\gamma}{1/4+\gamma^2}.             \tag{1}
\]

The multiplicity is part of the amplitude.  The paper explicitly notes
that rational linear independence of its set `Omega_zeta^+` does not imply
simplicity, because the set excludes multiplicity information.

Two hypotheses have separate roles:

- RH makes the frequencies real and the amplitudes (1) positive, giving
  condition (S2), absolute boundedness of `H_1`, and the screw function.
- Rational linear independence (LIC) of the distinct positive ordinates
  gives equidistribution on the phase torus and identifies the `M`-function
  with the long-time value distribution of `H_1(e^t)`.

Under both hypotheses, the real `M`-function has characteristic transform

\[
\widetilde M_{H_1}(z)
=\prod_{\gamma>0}J_0(a_\gamma z).                    \tag{2}
\]

Theorem 1.4 instead evaluates the atom at zero of the infinitely divisible
distribution by inserting the imaginary argument `z=-iy` in (2) and
multiplying by `exp(-yH_1(1))`.  The moment calculation below uses the real
characteristic function (2), not that point-mass formula.

## Lowest non-Gaussian cumulant

For a finite packet of independent uniform phases,

\[
X=\sum_j a_j\cos\Theta_j,
\]

the odd moments vanish and

\[
\mu_2=\frac12\sum_j a_j^2.                            \tag{3}
\]

Adding one independent component uses

\[
E[(Y+a\cos\Theta)^4]
=E[Y^4]+3a^2E[Y^2]+\frac38a^4.                       \tag{4}
\]

Induction gives

\[
\mu_4=3\mu_2^2-\frac38\sum_j a_j^4,
\qquad
\kappa_4:=\mu_4-3\mu_2^2
=-\frac38\sum_j a_j^4\le0.                          \tag{5}
\]

This is also the first non-Gaussian term in

\[
\log\prod_jJ_0(a_jz)
=-\frac{z^2}{4}\sum_j a_j^2
 -\frac{z^4}{64}\sum_j a_j^4+O(z^6).                \tag{6}
\]

Thus the lowest new inequality is

\[
\boxed{\mu_4\le3\mu_2^2},                            \tag{7}
\]

strict for any nonempty packet with a nonzero amplitude.  For the zeta
packet, one ordinate contributes

\[
-\frac38a_\gamma^4
=-6\frac{m_\gamma^4}{(1/4+\gamma^2)^4}.              \tag{8}
\]

The powers `m_gamma^4` in (8) show why silently imposing simple zeros would
change the statement.

Under RH+LIC and passage to the convergent infinite packet, equations
(3)--(5) become the long-time moment identity

\[
\lim_{T\to\infty}\frac1T\int_0^T H_1(e^t)^4dt
\le
3\left(
\lim_{T\to\infty}\frac1T\int_0^T H_1(e^t)^2dt
\right)^2.                                           \tag{9}
\]

Equation (9) is conditional on both RH and LIC.  The finite Bessel algebra
alone proves no assertion about the actual arithmetic trajectory.

## Why there is no finite Goldbach inequality

Proposition 6.1 gives an unconditional finite von Mangoldt formula for each
individual value `H_1(X)`.  Substituting it into (9), however, produces a
continuum time average whose upper cutoff `X=e^T` tends to infinity.  It is
not an identity involving finitely many rows `H_1(N_1),...,H_1(N_k)`.

LIC is exactly what replaces the time trajectory by independent Haar
phases.  A finite collection of integer samples has no exact Haar
quadrature, and positivity of the Bessel-product measure does not impose
(7) pointwise on those samples.

The weighted Goldbach-prefix relation introduces a further obstruction:
its useful remainder estimate is derived under RH.  Inserting

\[
H_1(X)=\frac{\sqrt X}{2}
\left\{A(X)-\log X-c_2-E_W(X)\right\}
\]

into (9) retains fourth powers and mixed products of `E_W(e^t)` throughout
the unbounded time average.  Known finite-prefix bounds neither identify
the Bessel amplitudes nor recover the LIC phase average.  Removing these
terms would assume the same RH-level error control already isolated in the
two- and three-point audits.

Consequently (7) is a valid conditional statistic of the `H_1` value
distribution, but it does not translate to a new finite Goldbach sign or a
weaker unconditional arithmetic constraint.  The loss is phase information
and the infinite time average, rather than an omitted finite algebraic
identity.

## Formal scope

[`GoldbachMFunctionCumulantFinite.lean`](../../formalization/BuildingBlocks/GoldbachMFunctionCumulantFinite.lean)
formalizes the exact finite convolution recursion, (5), nonpositivity and
strict negativity, the multiplicity-sensitive amplitude (1), and the
single-zero coefficient (8).  RH, LIC, zeta-zero enumeration, infinite
products, time equidistribution, and the Goldbach remainder formula are not
asserted in Lean.  All public conclusions print only Lean's standard
logical axioms.
