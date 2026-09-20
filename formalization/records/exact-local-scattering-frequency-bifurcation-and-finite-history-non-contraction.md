# Contribution 275: Exact Local Scattering Frequency Bifurcation and Finite-History Non-Contraction

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CompactLocalScatteringSigns.lean`](../../formalization/BuildingBlocks/CompactLocalScatteringSigns.lean), [`building-blocks/spectral/compact-local-scattering-no-contraction.md`](../../building-blocks/spectral/compact-local-scattering-no-contraction.md)  
**Classification:** Scattering Theory / Lax-Phillips Theory / Prime-Power Filters / Spectral Contraction / Frequency Bifurcation / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the scattering approach to the zeros of the Riemann zeta function, a central question is whether individual prime scattering channels are strictly contractive ($|\mathcal{S}_p(t)| \le 1$ for all frequencies $t \in \mathbb{R}$). If true, uniform contractivity would immediately prevent growing modes in the scattering matrix.

This contribution proves:

1. **Failure of Uniform Local Scattering Contraction Across Frequencies:**  
   For every prime $p$ and every finite history cutoff depth $M \ge 1$, the discrete prime scattering filter $\mathcal{S}_p(t, M)$ defined by:
   $$
   \mathcal{S}_p(t, M) = - p^{it - 1/2} + (1 - p^{-1}) \sum_{j=0}^{M-1} p^{-j(it + 1/2)}
   $$
   strictly attenuates at frequency zero, but strictly amplifies at the Nyquist frequency $t_M = \frac{\pi}{M \log p}$:
   $$
   |\mathcal{S}_p(0, M)|^2 < 1 \quad \text{and} \quad |\mathcal{S}_p(t_M, M)|^2 > 1.
   $$
   Consequently, no uniform contractivity bound $|\mathcal{S}_p(t, M)| \le 1$ can hold for local prime scattering channels.
2. **Exact Phase Factorization Identity:**  
   With $r = 1/\sqrt{p}$ and $\theta = t \log p$, the scattering amplitude factorizes into a unitary phase ratio and an amplification modifier:
   $$
   \mathcal{S}(r, \theta, M) = \left( \frac{1 - r e^{i\theta}}{1 - r e^{-i\theta}} \right) \left( 1 - \frac{(1-r^2)(r e^{-i\theta})^M}{1 - r e^{i\theta}} \right),
   $$
   where the first factor has modulus identically 1:
   $$
   \left| \frac{1 - r e^{i\theta}}{1 - r e^{-i\theta}} \right|^2 = 1.
   $$
3. **Amplification Mechanism:**  
   At $\theta = \pi / M$, the phase $(e^{-i\theta})^M = e^{-i\pi} = -1$ flips the sign of the truncated tail. The real part of the second term becomes strictly positive:
   $$
   \text{Re}\left( - \frac{-(1-r^2)r^M}{1 - r e^{i\theta}} \right) > 0,
   $$
   which forces $|1 - d|^2 = (1 - \text{Re}(d))^2 + \text{Im}(d)^2 > 1$ whenever $\text{Re}(d) < 0$.
4. **Finite-History Closed-Form Numerator Identity:**  
   For any complex variables $x, y$:
   $$
   \left( -y + (1 - xy) \sum_{j=0}^{M-1} x^j \right) (1 - x) = (1 - y) - (1 - xy) x^M.
   $$

---

## 2. Mathematical Proof

### 2.1. Numerator Identity
Applying the geometric sum $(1-x)\sum_{j=0}^{M-1} x^j = 1 - x^M$:
$$
-y(1-x) + (1-xy)(1-x^M) = -y + xy + 1 - x^M - xy + x^{M+1} y = (1-y) - (1-xy)x^M.
$$
Dividing by $1-x$:
$$
-y + (1-xy)\sum_{j=0}^{M-1} x^j = \frac{1-y}{1-x} \left( 1 - \frac{(1-xy)x^M}{1-y} \right).
$$

### 2.2. Setting Coordinates
Setting $x = r e^{-i\theta}$ and $y = r e^{i\theta}$:
$$
xy = r^2 e^0 = r^2.
$$
Then $1-x = 1 - r e^{-i\theta} = \overline{1 - r e^{i\theta}}$. The ratio $(1-y)/(1-x)$ is therefore of the form $z / \overline{z}$, which has norm squared identically 1.

### 2.3. Zero Frequency ($t = 0, \theta = 0$)
Here $e^{i\theta} = 1$, so $x = y = r$:
$$
\mathcal{S}(r, 0, M) = 1 - (1+r) r^M.
$$
Since $r = 1/\sqrt{p} \le 1/\sqrt{2}$, $0 < (1+r)r^M \le (1+1/\sqrt{2})(1/\sqrt{2}) < 2$. Thus:
$$
|\mathcal{S}(r, 0, M)|^2 = (1 - (1+r)r^M)^2 < 1.
$$

### 2.4. Resonant Frequency ($t_M = \pi / (M \log p), \theta = \pi / M$)
Here $x^M = (r e^{-i\pi/M})^M = r^M e^{-i\pi} = - r^M$.
Then the modifier is $1 - d$, where:
$$
d = \frac{-(1-r^2)r^M}{1 - r e^{i\pi/M}}.
$$
The denominator has positive real part $1 - r \cos(\pi/M) > 0$. The numerator is negative real: $-(1-r^2)r^M < 0$.
Therefore, $\text{Re}(d) < 0$.
For any complex number $d$ with $\text{Re}(d) < 0$:
$$
|1 - d|^2 = (1 - \text{Re}(d))^2 + \text{Im}(d)^2 > 1^2 + 0 = 1.
$$
Hence $|\mathcal{S}(r, \pi/M, M)|^2 = 1 \cdot |1 - d|^2 > 1$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CompactLocalScatteringSigns` in `formalization/BuildingBlocks/CompactLocalScatteringSigns.lean`):
```lean
theorem finite_history_numerator (x y : ℂ) (M : ℕ) :
    (-y + (1 - x * y) * ∑ j ∈ Finset.range M, x ^ j) * (1 - x) =
      (1 - y) - (1 - x * y) * x ^ M

theorem compact_phase_factorization {r : ℝ} (hr : 0 < r) (hr1 : r < 1)
    (theta : ℝ) (M : ℕ) :
    compactPhase r theta M =
      ((1 - (r : ℂ) * phase theta) /
        (1 - (r : ℂ) * (starRingEnd ℂ) (phase theta))) *
      (1 - (1 - (r : ℂ) ^ 2) *
        ((r : ℂ) * (starRingEnd ℂ) (phase theta)) ^ M /
        (1 - (r : ℂ) * phase theta))

theorem actual_prime_compact_signs (p : ℕ) (hp : p.Prime) {M : ℕ} (hM : 1 ≤ M) :
    Complex.normSq (compactPhase (1 / Real.sqrt (p : ℝ)) 0 M) < 1 ∧
    1 < Complex.normSq
      (compactPhase (1 / Real.sqrt (p : ℝ)) (Real.pi / (M : ℝ)) M)

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

- **Prior Literature:** Scattering matrices in automorphic forms and the Lax-Phillips scattering framework applied to the Riemann zeta function (Lax-Phillips 1976, Pavlov-Faddeev 1972). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Disproves local contractivity conjectures across frequencies for finite-depth prime scattering channels, establishing that global stability must rely on multi-prime collective interference rather than channel-by-channel contraction.
- **Target Venues:** *Communications in Mathematical Physics* or *Journal of Spectral Theory*.
