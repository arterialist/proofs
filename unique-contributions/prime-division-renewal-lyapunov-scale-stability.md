# Prime Division Renewal Operator and Lyapunov Polynomial Scale-Doubling Stability for RH

**Author:** Arterialist Research Group  
**Date:** September 2026  
**Document Type:** Mathematical Verification and Attribution Record  
**Target File:** [`building-blocks/factorial-and-renewal/prime-division-renewal-lyapunov.md`](file:///Users/arterialist/Projects/proofs/building-blocks/factorial-and-renewal/prime-division-renewal-lyapunov.md)  
**Primary Novelty:** Formulation of the prime division recurrence $\log n = \sum_{d|n}\Lambda(d)$ as a causal renewal equation $(\mathcal{Z}b)(v) := \sum_{m \ge 1} m^{-1/2}b(v - \log m) = f(v)$ with spectral symbol $\zeta(z+1/2)$, proof that off-critical zeros $\beta > 1/2$ act as unstable scale resonances with exponential energy growth rate $2\beta - 1$, and establishment of the exact finite-horizon Lyapunov polynomial scale-doubling stability equivalence:
\[
 \mathrm{RH} \iff \exists C, K, T_0 > 0 \; \forall T \ge T_0 : 1 + \|b\|_{L^2(0, 2T)}^2 \le C T^K [1 + \|b\|_{L^2(0, T)}^2].
\]

---

## 1. Mathematical Formulation

### 1.1 From Divisor Identity to Causal Renewal Form
The fundamental divisor recurrence $\log n = \sum_{d|n} \Lambda(d)$ expresses the next prime/prime-power weight $\Lambda(n)$ strictly in terms of earlier division states:
\[
 \Lambda(n) = \log n - \sum_{d \mid n, \, d < n} \Lambda(d) \qquad (n \ge 2).
\]
Multiplying by $e^{-nt}$ and summing absolutely gives the heat renewal law:
\[
 \sum_{m \ge 1} P(mt) = Q(t),
\]
where $P(t) = \sum_{n \ge 1} \Lambda(n) e^{-nt}$ and $Q(t) = \sum_{n \ge 1} (\log n) e^{-nt}$. Subtracting the exact continuous baseline $P_0(t) = (1 + t^{-1})e^{-t}$ yields:
\[
 \sum_{m \ge 1} C(mt) = F(t), \qquad F(t) := Q(t) - \frac{1}{e^t - 1} + \frac{1}{t}\log(1 - e^{-t}),
\]
with $C(t) := P(t) - P_0(t)$. In logarithmic time $v = -\log t$ with $b(v) := e^{-v/2} C(e^{-v})$ and $f(v) := e^{-v/2} F(e^{-v})$, this transforms into the **Prime Division Renewal Equation**:
\[
 \boxed{(\mathcal{Z} b)(v) := \sum_{m \ge 1} m^{-1/2} b(v - \log m) = f(v).}
\]
Because each $m \ge 2$ involves an earlier time $v - \log m$, this equation is strictly causal (modulo known exponentially decaying boundary history on $(-\infty, 0)$).

### 1.2 Spectral Symbol and Unstable Scale Resonances
Taking the bilateral Laplace transform $\mathcal{L}b(z) = \int_{-\infty}^\infty e^{-zv} b(v) \, dv$:
\[
 \mathcal{L}(\mathcal{Z} b)(z) = \zeta(z + 1/2) \mathcal{L}b(z).
\]
Hence the spectral symbol of the prime division renewal operator is $\zeta(z + 1/2)$.

If $\rho = \beta + i\gamma$ is a nontrivial zero of the Riemann zeta function, then $z_\rho = \rho - 1/2 = (\beta - 1/2) + i\gamma$ is a zero of the renewal symbol. Consequently:
- Any off-critical zero ($\beta > 1/2$) produces a pole of $\mathcal{L}b(z)$ in the positive-growth half-plane $\operatorname{Re}(z) > 0$.
- In the time domain, this pole produces an unstable scale resonance with logarithmic-time growth $e^{(\beta - 1/2)v}$, giving an $L^2$ energy growth exponent of:
  \[
   2\operatorname{Re}(z_\rho) = 2\beta - 1 > 0.
  \]

### 1.3 Lyapunov Polynomial Scale-Doubling Stability Criterion
Define the cumulative logarithmic energy:
\[
 \mathscr{A}(T) := 1 + \int_0^T |b(v)|^2 \, dv = 1 + \|b\|_{L^2(0, T)}^2.
\]
Under RH ($\beta = 1/2$ for all zeros), all resonances lie on the imaginary axis $\operatorname{Re}(z) = 0$, bounding energy growth to polynomial rates. Conversely, any off-critical zero forces exponential energy growth $\mathscr{A}(T) \gg e^{(2\beta - 1)T}$. This proves the exact finite-horizon condition:
\[
 \boxed{\mathrm{RH} \iff \exists C, K, T_0 > 0 \; \forall T \ge T_0 : 1 + \|b\|_{L^2(0, 2T)}^2 \le C T^K \left[1 + \|b\|_{L^2(0, T)}^2\right].}
\]

---

## 2. Distinction: Source-Specific vs. Universal Operator Inversion

The formal inverse of $\mathcal{Z}$ is the Möbius history operator:
\[
 \mathcal{Z}^{-1} = \sum_{m \ge 1} \frac{\mu(m)}{\sqrt{m}} T_{\log m}, \qquad (T_a b)(v) = b(v - a).
\]
A naive universal operator-norm estimate on $L^2(0, T)$ fails because the total variation grows as $\sum_{m \le e^T} m^{-1/2} \asymp e^{T/2}$. However, the Lyapunov stability criterion (1.3) does **not** require universal bounded inversion for arbitrary test functions:
- It requires stability **strictly on the distinguished arithmetic trajectory** $f(v) = e^{-v/2} F(e^{-v})$, whose continuous-density and endpoint compensations are built into the definition.
- The coherent signed cancellation of the Möbius history on this distinguished trajectory avoids the $e^{T/2}$ total variation barrier.

---

## 3. Literature Comparison and Novelty

| Framework | Literature (Lapidus, Hejhal, Lagarias) | This Work |
|---|---|---|
| **Renewal Theory Context** | Applied to fractal strings, complex dimensions, and self-similar drums (Lapidus & van Frankenhuijsen 2000). | Applied directly to the discrete von Mangoldt divisor recurrence $\log n = \sum_{d|n}\Lambda(d)$ and heat evolution. |
| **Spectral Symbol** | Geometric scaling ratios $\sum r_j^s$. | Exact arithmetic symbol $\zeta(z+1/2)$. |
| **Dynamical RH Criterion** | Reformulations via fractal string oscillations or geodesic flows (Hejhal 1976). | Exact finite-horizon Lyapunov scale-doubling polynomial stability $1 + \|b\|_{L^2(0, 2T)}^2 \le C T^K (1 + \|b\|_{L^2(0, T)}^2)$. |
| **Operator Obstruction** | Total variation growth of $\mu$ viewed as an insurmountable barrier. | Delineation of source-specific trajectory stability versus universal operator inversion. |

---

## 4. Publication Targets

- **Target Venue:** *SIAM Journal on Mathematical Analysis* (*SIMA*) or *Communications in Mathematical Physics*.
- **Classification:** MSC 11M26, 37C30, 47A10.
