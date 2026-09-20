# Contribution 63: Truncated Prime Scattering Amplification and Non-Contractivity Obstruction

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CompactLocalScatteringSigns.lean`](../../formalization/BuildingBlocks/CompactLocalScatteringSigns.lean), [`notes/r39-compact-local-scattering-no-contraction.md`](../../notes/r39-compact-local-scattering-no-contraction.md)  
**Classification:** Scattering Theory / Spectral Theory / Semigroup Generators / Dissipative Operator Theory

---

## 1. Executive Summary and Mathematical Statement

In the operator-theoretic approach to the Riemann Hypothesis, unitary scattering multipliers $S_p(t) = \frac{1 - p^{-1/2 - it}}{1 - p^{-1/2 + it}}$ associated with prime Euler factors are contractive ($|S_p(t)| = 1$). However, numerical or analytical truncations of their causal history expansions are frequently proposed to establish accretivity or contractivity of the underlying generator.

This contribution proves a **rigorous obstruction to contractivity for finite history truncations**:

1. **Explicit Truncated Prime Scattering Multiplier:**  
   For any prime $p \ge 2$, frequency $t \in \mathbb{R}$, and history truncation depth $M \ge 1$, the truncated prime scattering multiplier is defined by:
   $$
   S_{p, M}(t) = -p^{it - 1/2} + (1 - p^{-1}) \sum_{j=0}^{M-1} p^{-j(it + 1/2)}.
   $$
2. **Exact Algebraic Geometric Factorization:**  
   Setting $r = 1/\sqrt{p}$ and $\theta = t \log p$, $S_{p, M}(t)$ factorizes algebraically as:
   $$
   S_{p, M}(t) = \frac{1 - r e^{i\theta}}{1 - r e^{-i\theta}} \left( 1 - \frac{(1 - r^2) r^M e^{-i M \theta}}{1 - r e^{-i\theta}} \right).
   $$
3. **Strict DC Attenuation vs. Resonant Amplification:**  
   For EVERY prime $p$ and EVERY truncation parameter $M \ge 1$:
   - **Zero-frequency attenuation:** At $t = 0$, the multiplier is strictly contractive:
     $$
     |S_{p, M}(0)|^2 = (1 - (1 + r)r^M)^2 < 1.
     $$
   - **Resonant frequency amplification:** At the exact resonant frequency $t_{\mathrm{res}} = \frac{\pi}{M \log p}$, the multiplier is strictly expansive:
     $$
     |S_{p, M}(t_{\mathrm{res}})|^2 > 1.
     $$
4. **Non-Contractivity Theorem:**  
   No truncated prime scattering multiplier operator $T_{p, M}$ is a contraction on $L^2(\mathbb{R})$; its operator norm strictly exceeds unity:
   $$
   \|T_{p, M}\|_{L^2 \to L^2} > 1 \quad (\forall p \text{ prime}, \forall M \ge 1).
   $$
   This proves that dissipative energy estimates cannot be obtained by naive causal history cutoffs.

---

## 2. Mathematical Proof

### 2.1. Factorization
Let $x = r e^{-i\theta}$ and $y = r e^{i\theta}$. Then $xy = r^2 = p^{-1}$. The finite geometric sum satisfies:
$$
\sum_{j=0}^{M-1} x^j = \frac{1 - x^M}{1 - x}.
$$
Then:
$$
-y + (1 - xy) \sum_{j=0}^{M-1} x^j = \frac{-y(1 - x) + (1 - r^2)(1 - x^M)}{1 - x} = \frac{1 - y - (1 - r^2)x^M}{1 - x} = \frac{1 - y}{1 - x}\left(1 - \frac{(1 - r^2)x^M}{1 - y}\right).
$$
Since $|1 - y| = |1 - x|$ on the critical line, $|(1 - y)/(1 - x)| = 1$.

### 2.2. Resonant Amplification
At $t_{\mathrm{res}} = \frac{\pi}{M \log p}$, the angle $\theta = t_{\mathrm{res}} \log p = \pi / M$, so $e^{-i M \theta} = e^{-i\pi} = -1$.
The perturbation term becomes:
$$
d = \frac{(1 - r^2) r^M (-1)}{1 - r e^{-i\pi/M}} = -\frac{(1 - r^2)r^M}{w}, \quad \text{where } w = 1 - r e^{-i\pi/M}.
$$
Since $r < 1$, $\operatorname{Re}(w) = 1 - r \cos(\pi/M) > 0$.
The real part of $d$ is:
$$
\operatorname{Re}(d) = -\frac{(1 - r^2)r^M}{|w|^2} \operatorname{Re}(w) < 0.
$$
For any complex number $d$ with $\operatorname{Re}(d) < 0$:
$$
|1 - d|^2 = (1 - \operatorname{Re} d)^2 + (\operatorname{Im} d)^2 = 1 - 2 \operatorname{Re} d + |d|^2 > 1.
$$
Since the phase factor has unit modulus, $|S_{p, M}(t_{\mathrm{res}})|^2 = |1 - d|^2 > 1$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CompactLocalScatteringSigns`):
```lean
theorem compact_attenuation_zero {r : ℝ} (hr : 0 < r) (hr1 : r < 1)
    (hr2 : r ^ 2 ≤ 1 / 2) {M : ℕ} (hM : 1 ≤ M) :
    Complex.normSq (compactPhase r 0 M) < 1

theorem compact_amplification_special {r : ℝ} (hr : 0 < r) (hr1 : r < 1)
    {M : ℕ} (hM : 1 ≤ M) :
    1 < Complex.normSq (compactPhase r (Real.pi / (M : ℝ)) M)

theorem original_prime_compact_signs (p : ℕ) (hp : p.Prime) {M : ℕ} (hM : 1 ≤ M) :
    Complex.normSq (originalCompact p 0 M) < 1 ∧
      1 < Complex.normSq
        (originalCompact p (Real.pi / ((M : ℝ) * Real.log (p : ℝ))) M)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Unitarity of full prime scattering multipliers $|S_p(t)| = 1$ is classical in the Lax–Phillips / Burnol / Connes frameworks. Whether truncated approximants $S_{p, M}$ preserve contractivity had not been analyzed rigorously.
- **Advancement:** Proves the sharp non-contractivity barrier, identifying the exact resonance $t = \frac{\pi}{M \log p}$ that violates contractivity.
- **Target Venues:** *Journal of Functional Analysis* or *Letters in Mathematical Physics*.
