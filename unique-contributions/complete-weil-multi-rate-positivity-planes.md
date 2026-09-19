# Two- and three-rate positivity planes for the complete actual-prime Weil form

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Primary References:** [`building-blocks/weil-and-spectral/complete-weil-two-exponential-rate-positive-plane.md`](../building-blocks/weil-and-spectral/complete-weil-two-exponential-rate-positive-plane.md), [`building-blocks/weil-and-spectral/complete-weil-three-exponential-rate-positive-plane.md`](../building-blocks/weil-and-spectral/complete-weil-three-exponential-rate-positive-plane.md)
**Lean Formalizations:** [`formalization/BuildingBlocks/TwoRateWeilGramAlgebra.lean`](../formalization/BuildingBlocks/TwoRateWeilGramAlgebra.lean), [`formalization/BuildingBlocks/ThreeRateWeilGramAlgebra.lean`](../formalization/BuildingBlocks/ThreeRateWeilGramAlgebra.lean)
**Validated Python/Arb Certificate:** [`certificates/three_rate_weil_xi_signs.py`](../certificates/three_rate_weil_xi_signs.py)
**Scope:** a fixed two- or three-rate family; no claim is made for arbitrary tests or for a resolution of RH.

---

## 1. Result and scope

Weil's explicit criterion states that the Riemann Hypothesis is equivalent to the positive semi-definiteness of the Weil quadratic form $Q(f) \ge 0$ on all compactly supported smooth test functions $f \in C_c^\infty(\mathbb{R})$. This page records a fixed finite-rate family of causal exponentials. The linked building-block notes separate the written analytic bridge from the Lean-checked determinant algebra.

**Theorem (Two- and three-rate positivity planes under the stated analytic inputs).**
Let $u_a(x) = e^{-ax}\mathbf{1}_{[0, \infty)}(x)$ be causal exponentials with decay rates $a > 1/2$. For any set of distinct rates $\{a, b, c\} \subset (1/2, \infty)$, the complete arithmetic Weil quadratic form evaluates exactly to:
$$
Q(u_a, u_b) = \frac{F(a) + F(b)}{a + b}, \qquad F(a) := \frac{\xi'}{\xi}\left(a + \frac{1}{2}\right),
$$
where $\xi(s) = \frac{1}{2}s(s-1)\pi^{-s/2}\Gamma(s/2)\zeta(s)$ is the completed Riemann xi function, incorporating every proper prime power $\Lambda(n)/\sqrt{n}$, both poles at $s = 0, 1$, and the complete digamma Archimedean factor.

With the stated analytic inputs (without assuming RH):
1. **The Two-Rate Plane:** For any distinct $a, b > 1/2$, the $2 \times 2$ Gram matrix:
   $$
   G_{a, b} = \begin{pmatrix} F(a)/a & \frac{F(a)+F(b)}{a+b} \\ \frac{F(a)+F(b)}{a+b} & F(b)/b \end{pmatrix}
   $$
   is **strictly positive definite**.
2. **The Three-Rate Plane:** For any three distinct rates $a < b < c$, the $3 \times 3$ Gram matrix $[K(a_i, a_j)]$ is **strictly positive definite**.
3. **Exact Determinant Factorization:** The $3 \times 3$ Gram determinant factors as:
   $$
   \det [K(a_i, a_j)] = \frac{F(a)F(b)F(c)}{abc} (b-a)^2 (c-a)^2 (c-b)^2 \cdot H[t_a, t_b, t_c] \cdot J[t_a, t_b, t_c],
   $$
   where $t = a^2$, and $H[t_a, t_b, t_c]$ and $J[t_a, t_b, t_c]$ are the second divided differences of $H(t) := \sqrt{t}F(\sqrt{t})$ and $J(t) := \sqrt{t}/F(\sqrt{t})$.
4. **Compact Truncation:** For each finite rate set, there exists a finite cutoff $L_0 < \infty$ such that for all $L \ge L_0$, the complete Weil form is strictly positive definite on the compact subspaces $\operatorname{span}\{e^{-ax}\mathbf{1}_{[0, L]}\}$.

Because these planes contain arbitrary complex linear combinations $c_1 u_a + c_2 u_b + c_3 u_c$, they give a fixed finite-rate sign-changing family. Bombieri's unconditional short-support positivity already covers an infinite-dimensional space of $L^2$ tests, so this page makes no firstness or comparison claim about sign-changing subspaces.

---

## 2. Rigorous Proof Architecture

### 2.1 Exact Arithmetic Weil Split on Causal Exponentials
On the logarithmic line $x = \log y$, the complete Weil form split is:
$$
Q(f) = \frac{1}{2\pi}\int_{\mathbb{R}} \left(\operatorname{Re}\psi(5/4 + it/2) - \log\pi\right)|\widehat{f}(t)|^2 dt - \langle f, (K-P)f\rangle,
$$
where $K$ represents the discrete shifts by $\log n$ with weights $\Lambda(n)/\sqrt{n}$, and $P$ has kernel $e^{|x-y|/2}$.
Evaluating on cross-correlations $\int_0^\infty u_a(x+v)u_b(x)dx = \frac{e^{-av}}{a+b}$, the arithmetic prime sum yields:
$$
\frac{1}{a+b}\sum_{n \ge 2} \Lambda(n)\left(n^{-(a+1/2)} + n^{-(b+1/2)}\right) = -\frac{1}{a+b}\left(\frac{\zeta'}{\zeta}(a+1/2) + \frac{\zeta'}{\zeta}(b+1/2)\right).
$$
Combining with the continuous pole terms $\frac{1}{a+b}(\frac{1}{a-1/2} + \frac{1}{b-1/2})$ and the digamma integral evaluated via contour integration, the complete arithmetic source and Archimedean terms collapse to the closed-form evaluation:
$$
Q(u_a, u_b) = \frac{F(a) + F(b)}{a + b}.
$$

### 2.2 Strict Positivity of the Two-Rate Determinant
Multiplying $\det(G_{a, b})$ by the strictly positive factor $ab(a+b)^2 > 0$ yields:
$$
F(a)F(b)(a-b)^2 - ab(F(a)-F(b))^2 = (bF(a) - aF(b))(bF(b) - aF(a)).
$$
Using the Hadamard product for $\xi(s)$, the function $F(a)$ decomposes over conjugate/reflected zero packets:
$$
g_{\delta, \gamma}(a) = \frac{a-\delta}{(a-\delta)^2+\gamma^2} + \frac{a+\delta}{(a+\delta)^2+\gamma^2} = \frac{2a(a^2+p)}{a^4 + 2pa^2 + q^2},
$$
where $p = \gamma^2 - \delta^2$ and $q = \gamma^2 + \delta^2$.
By Platt–Trudgian (2021), all zeros up to height $T = 3 \cdot 10^{12}$ lie on the critical line ($\delta = 0$). Any off-line zeros above $T$ satisfy $|\delta| < 1/2 < \gamma / (1+\sqrt{2})$, so $q^2 \le 2p^2$ unconditionally.
Direct differentiation yields:
$$
\frac{d}{da}(a g_{\delta, \gamma}(a)) > 0, \qquad -\frac{d}{da}(g_{\delta, \gamma}(a)/a) > 0.
$$
Thus, $aF(a)$ strictly increases and $F(a)/a$ strictly decreases on $(0, \infty)$. For $1/2 < a < b$, this implies:
$$
\frac{a}{b} < \frac{F(b)}{F(a)} < \frac{b}{a} \implies bF(a) - aF(b) > 0 \quad \text{and} \quad bF(b) - aF(a) > 0.
$$
The determinant is therefore strictly positive. Both diagonal entries are positive, establishing strict positive definiteness of $G_{a, b}$.

### 2.3 Exact Bilinear Factorization of the Three-Rate Determinant
For three rates, clearing the denominator $abc(a+b)^2(a+c)^2(b+c)^2 > 0$ produces a degree-8 polynomial in the variables which factors:
$$
\operatorname{gramDetNumerator}(a, b, c, A, B, C) = H_{\mathrm{num}}(a, b, c, A, B, C) \cdot J_{\mathrm{num}}(a, b, c, A, B, C),
$$
where:
$$
H_{\mathrm{num}} = aA(b^2-c^2) + bB(c^2-a^2) + cC(a^2-b^2),
$$
$$
J_{\mathrm{num}} = aBC(b^2-c^2) + bAC(c^2-a^2) + cAB(a^2-b^2).
$$
This algebraic identity is machine-checked in Lean 4 (`BuildingBlocks.ThreeRateWeilGramAlgebra.gram_det_numerator_factor`).
Dividing by the Vandermonde factor $(b^2-a^2)(c^2-a^2)(c^2-b^2)$, $H_{\mathrm{num}}$ and $J_{\mathrm{num}}$ are positive if and only if $H(t) = \sqrt{t}F(\sqrt{t})$ and $J(t) = \sqrt{t}/F(\sqrt{t})$ are strictly concave functions of $t = a^2$.

### 2.4 Unconditional Strict Concavity of $H$ and $J$
1. **Concavity of $H(t)$:** The second derivative is:
   $$
   H''(t) = \sum_\rho m_\rho \left(-\frac{8[q^2(2p^2-q^2) + 3pq^2 t + 3q^2 t^2 + p t^3]}{(t^2 + 2pt + q^2)^3}\right) < 0,
   $$
   which is strictly negative because $p > 0$ and $2p^2 - q^2 \ge 0$.
2. **Concavity of $J(t)$:**
   - On $1/4 \le t \le 10^4$, Stieltjes representation $S_0(t) = \sum \frac{w_j}{t+\gamma_j^2}$ with $C_0 = S_0 S_0'' - 2(S_0')^2 = 2\sum_{i < j} w_i w_j \frac{(\gamma_i^2-\gamma_j^2)^2}{(t+\gamma_i^2)^3(t+\gamma_j^2)^3}$.
   - Evaluating on the first two critical zeros $\gamma_1 \approx 14.13, \gamma_2 \approx 21.02$ certified by 50-digit Arb ball interval arithmetic yields $C_0 > 7.5 \cdot 10^{-20}$. The remainder $R(t)$ from off-line zeros above $3 \cdot 10^{12}$ satisfies $|R| < 1.2 \cdot 10^{-21}$, proving $J''(t) < 0$.
   - On $t \ge 10^4$ ($a \ge 100$), Stirling/digamma asymptotics and Dirichlet tail bounds give $J''(t) < 0$.

---

## 3. Methodological Comparison with Prior Literature

| Result / Approach | Space of Tests | Arithmetic Content | RH Assumed? | Literature Status |
|---|---|---|---|---|
| **Weil (1952)** | $C_c^\infty(\mathbb{R})$ | Complete primes + gamma | Yes (criterion) | Equivalence formulation |
| **Bombieri (2000) / Burnol (2002)** | Single-scale cones | Fourier positive functions | No | 1-dimensional cones only |
| **Polson (2017)** | Hankel zero-heat moments | Squared zeros $(\gamma^2)^k$ | No | Moment matrices, not Weil form |
| **Suzuki (2026)** | Screw-function kernel | Model screw kernel | Yes (assumes RH) | Fails unconditionally |
| **Two-Rate & Three-Rate Planes (This Work)** | **$\operatorname{span}\{u_a, u_b, u_c\}$** | **Complete actual primes $\Lambda(n)$** | **No RH assumption in the stated inputs** | **Fixed finite-rate family; no priority claim** |

---

## 4. Reproducibility & Formal Proofs

1. **Lean 4 Formal Verification:**
   - [`formalization/BuildingBlocks/TwoRateWeilGramAlgebra.lean`](../formalization/BuildingBlocks/TwoRateWeilGramAlgebra.lean)
   - [`formalization/BuildingBlocks/ThreeRateWeilGramAlgebra.lean`](../formalization/BuildingBlocks/ThreeRateWeilGramAlgebra.lean)
   - Both modules compile with Lean 4.24.0 and depend strictly on `[propext, Classical.choice, Quot.sound]`.
2. **Validated Arb Interval Certificate:**
   ```bash
   uv run --with python-flint python3 certificates/three_rate_weil_xi_signs.py
   ```
   Certifies the signs and lower bounds on $\Xi(14) > 0$, $\Xi(15) < 0$, $\Xi(21) < 0$, $\Xi(22) > 0$ to 50 decimal digits of rigorous interval enclosure.

The Lean files check the finite determinant and divided-difference algebra. The analytic identification of the complete Weil form and the sign estimates remain written inputs, as stated in the linked building-block notes. No literature-priority claim is made.
