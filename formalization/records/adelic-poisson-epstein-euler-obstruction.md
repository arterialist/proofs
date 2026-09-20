# Contribution 30: The Adelic Poisson–Epstein Geometric Obstruction to the Riemann Hypothesis

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Primary Reference:** [`building-blocks/weil-and-spectral/adelic-poisson-epstein-euler-obstruction.md`](../../building-blocks/weil-and-spectral/adelic-poisson-epstein-euler-obstruction.md)  
**Related Lean Formalizations:** [`formalization/BuildingBlocks/PhysicalThetaParity.lean`](../../formalization/BuildingBlocks/PhysicalThetaParity.lean), [`formalization/BuildingBlocks/ActualPhysicalResidues.lean`](../../formalization/BuildingBlocks/ActualPhysicalResidues.lean)  
**Target Venue:** *Bulletin of the American Mathematical Society* or *Expositiones Mathematicae*

---

## 1. Result and scope

A central ambition in spectral number theory, non-commutative geometry, and operator-theoretic approaches to the Riemann Hypothesis (Pólya–Hilbert, Connes–Consani–Marcolli 2007, Burnol, Meyer, Suzuki 2026) is to deduce the critical-line location of zeros from three geometric and analytic properties:
1. **Pointwise Non-Negativity:** The underlying representation multiplicities or spectral weights are non-negative integers ($r(N) \ge 0$).
2. **Exact Poisson Self-Duality:** The associated theta function is invariant under Poisson inversion $\Theta(t) = t^{-d/2}\Theta(1/t)$ (a strict self-dual fixed point, not merely an equivalence between dual pairs).
3. **Completed Meromorphic Reflection Symmetry:** The completed zeta function $\widehat{Z}(s) = \pi^{-s/2}\Gamma(s/2)Z(s)$ satisfies $\widehat{Z}(s) = \widehat{Z}(1-s)$ with poles only at $s = 0, 1$.

**Theorem (The Adelic Poisson–Epstein Geometric Obstruction).**  
Pointwise non-negativity of representation counts, exact Poisson self-duality, and completed meromorphic reflection symmetry $\widehat{Z}(s) = \widehat{Z}(1-s)$ are **strictly insufficient** to place the zeros of a completed zeta function on the critical line $\operatorname{Re}(s) = 1/2$.

Specifically, the two-dimensional lattice quadratic form $Q(m, n) = m^2 + 5n^2$ with theta series:
$$
\Theta_Q(t) := \sum_{(m, n) \in \mathbb{Z}^2} e^{-\pi t(m^2 + 5n^2)/\sqrt{5}}
$$
satisfies:
1. $r_Q(N) \in \mathbb{N}_0$ for all $N \ge 0$,
2. $\Theta_Q(t) = t^{-1}\Theta_Q(1/t)$ for all $t > 0$ identically,
3. $\widehat{E}_Q(s) := (5^{1/2}/\pi)^s \Gamma(s) \sum_{(m, n) \ne (0, 0)} Q(m, n)^{-s} = \widehat{E}_Q(1-s)$ with poles only at $s = 0, 1$.

Yet, $E_Q(s)$ possesses **infinitely many zeros strictly off the critical line**, including zeros in the half-plane of absolute convergence $\operatorname{Re}(s) > 1$ (Davenport–Heilbronn 1936) and $\gg T$ off-line zeros in every strip $1/2 < \sigma_1 < \operatorname{Re}(s) < \sigma_2 < 1$ with $|\operatorname{Im}(s)| \le T$ (Voronin 1976, Lee 2012).

**Arithmetic Consequence:** Any valid deduction of the Riemann Hypothesis or the positive semi-definiteness of the Weil quadratic form **must fundamentally exploit the primitive unit exponent** of the Euler product:
$$
\zeta(s) = \prod_p (1 - p^{-s})^{-1}, \qquad -\frac{\zeta'}{\zeta}(s) = \sum_{n \ge 1} \Lambda(n) n^{-s}.
$$
Every program attempting to establish RH purely from adelic trace formulas, Poisson summation, or self-adjoint operator realizations that do not enforce the local multiplicativity of the primes is categorically obstructed by the Epstein lattice.

---

## 2. Rigorous Proof of the Countermodel

### Step 1: Exact Poisson Self-Duality
Let $Q(m, n) = m^2 + 5n^2$ and consider the unimodular transformation matrix $A = \operatorname{diag}(5^{-1/4}, 5^{1/4})$. The lattice $\Lambda = A \mathbb{Z}^2 \subset \mathbb{R}^2$ has volume $\det(A) = 1$. The squared Euclidean length of a vector $x = (5^{-1/4}m, 5^{1/4}n) \in \Lambda$ is:
$$
\|x\|^2 = \frac{m^2}{\sqrt{5}} + \sqrt{5}n^2 = \frac{m^2 + 5n^2}{\sqrt{5}}.
$$
The dual lattice $\Lambda^*$ has vectors $y = (5^{1/4}u, 5^{-1/4}v)$ with $u, v \in \mathbb{Z}$. The coordinate permutation $(u, v) \mapsto (n, m)$ gives:
$$
\|y\|^2 = \sqrt{5}u^2 + \frac{v^2}{\sqrt{5}} = \frac{v^2 + 5u^2}{\sqrt{5}},
$$
which is isometric to $\Lambda$. By the two-dimensional Poisson summation formula for the Gaussian:
$$
\Theta_Q(t) = \sum_{x \in \Lambda} e^{-\pi t \|x\|^2} = t^{-1} \sum_{y \in \Lambda^*} e^{-\pi t^{-1} \|y\|^2} = t^{-1} \Theta_Q(1/t).
$$
This holds pointwise for all $t > 0$.

### Step 2: Completed Analytic Continuation and Reflection
For $\operatorname{Re}(s) > 1$:
$$
\widehat{E}_Q(s) = \left(\frac{\sqrt{5}}{\pi}\right)^s \Gamma(s) E_Q(s) = \int_0^\infty (\Theta_Q(t) - 1) t^{s-1} dt.
$$
Splitting the integral at $t = 1$ and applying the Poisson self-duality $\Theta_Q(t) = t^{-1}\Theta_Q(1/t)$ on $(0, 1)$:
$$
\widehat{E}_Q(s) = \int_1^\infty (\Theta_Q(t) - 1)(t^{s-1} + t^{-s}) dt + \frac{1}{s-1} - \frac{1}{s}.
$$
Because $\Theta_Q(t) - 1 = O(e^{-\pi t/\sqrt{5}})$ decays exponentially as $t \to \infty$, the integral defines an entire function of $s$. The poles at $s = 0, 1$ have residues $-1$ and $+1$ respectively, and the entire expression is manifestly invariant under $s \mapsto 1-s$.

### Step 3: Failure of Local Multiplicativity (The Coprime Obstruction)
Let $a_N := r_Q(N)/2$. Examining small integers:
$$
r_Q(1) = 2 \implies a_1 = 1,
$$
$$
r_Q(2) = 0 \implies a_2 = 0,
$$
$$
r_Q(3) = 0 \implies a_3 = 0,
$$
$$
r_Q(6) = \#\{(\pm 1, \pm 1)\} = 4 \implies a_6 = 2.
$$
Because $\gcd(2, 3) = 1$, any function possessing a normalized Euler product $\prod_p (1 + a_p p^{-s} + \cdots)$ must satisfy $a_6 = a_2 a_3$. Here:
$$
a_6 = 2 \ne 0 = a_2 \cdot a_3.
$$
Thus $E_Q(s)/2$ is **not** an Euler product; it is the sum of two distinct primitive Hecke $L$-functions for the ideal class group of $\mathbb{Q}(\sqrt{-5})$ (which has class number $h(-20) = 2$):
$$
E_Q(s) = 2 \left( \zeta_{\mathbb{Q}(\sqrt{-5}), \mathbf{1}}(s) + L(s, \chi) \right).
$$
Because the two $L$-functions have different phases along vertical lines, their sum undergoes catastrophic destructive interference, creating infinitely many off-line zeros.

---

## 3. Methodological Comparison with the Literature

| Proposal / Program | Assumed Axioms | Subject of Claim | Critical Line Preserved? | Reason for Failure / Status |
|---|---|---|---|---|
| **Connes–Consani–Marcolli (2007)** | Adelic trace formula | Grössencharakter $L$-functions | Yes, conditionally | Requires individual Euler character, not general lattice |
| **Suzuki Screw Operator (2026)** | Positive kernel factor $A_\infty = U^*U$ | Abstract screw function | **False unconditionally** | Assumes RH to construct $U$; general self-dual theta fails |
| **Epstein Zeta $E_Q(s)$** | Poisson self-duality + $r_Q(N) \ge 0$ | $m^2 + 5n^2$ lattice | **Fails completely** | Has $\gg T$ zeros in $1/2 < \sigma < 1$ (Voronin, Lee) |
| **Actual Riemann Zeta $\zeta(s)$** | Poisson + Unit Euler Exponents | $\sum \Lambda(n) n^{-s}$ | Preserved | Unit Euler power $(1-p^{-s})^{-1}$ prevents cancellation in $\sigma > 1$ |

---

## 4. Key Takeaways and Attributions

1. **Boundary of Geometric Approaches:** Exact self-duality and non-negative integer representation counts are insufficient to imply the Riemann Hypothesis.
2. **The Euler Product is Indispensable:** Any valid spectral or operator-theoretic proof of the Riemann Hypothesis must encode the exact local prime valuation $\operatorname{ord}_p(n)$ and the fact that the arithmetic coefficients $\Lambda(n)$ are supported solely on prime powers with weight $\log p$.
