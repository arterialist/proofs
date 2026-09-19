# Contribution 263: Exact Finite Scattering Box History Coefficients and Bulk Prime Amplification

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CompactScatteringCoefficients.lean`](../../formalization/BuildingBlocks/CompactScatteringCoefficients.lean), [`building-blocks/scattering/compact-scattering-coefficients.md`](../../building-blocks/scattering/compact-scattering-coefficients.md)  
**Classification:** Scattering Theory / Unitary Networks / Finite Phase Boxes / History Convolution / Bulk Amplification / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

For a finite phase box $c_k = q^{-k} \cdot \mathbf{1}_{[0, J-1]}(k)$ representing an incoming plane-wave packet of length $J$, passing through a causal scattering history operator of memory depth $M$ with reflection coefficient $r$:
$$
\text{historyCoefficient}(r, M, c)(k) = -r c(k - 1) + (1 - r^2) \sum_{m=0}^{M-1} r^m c(k + m).
$$
In the bulk region away from the boundaries ($1 \le k \le J - M$), the boundary truncations do not truncate the sum, so the operator acts as a pure multiplier on the incoming phase.

This contribution proves:

1. **Exact Interior History Coefficient Identity:**  
   For any non-zero phase $q \in \mathbb{C}^\times$ and any interior index $1 \le k \le J - M$:
   $$
   \text{historyCoefficient}(r, M, \text{box}(q, J))(k) = q^{-k} \left[ -r q + (1 - r^2) \sum_{m=0}^{M-1} (r q^{-1})^m \right].
   $$
2. **Phase Factorization on the Circle:**  
   When $q = e^{i\theta}$ on the unit circle, $q^{-1} = \overline{q}$, and:
   $$
   \text{historyCoefficient}(r, M, \text{box}(e^{i\theta}, J))(k) = e^{-ik\theta} \cdot \text{compactPhase}(r, \theta, M),
   $$
   where $\text{compactPhase}(r, \theta, M) = -r e^{i\theta} + (1 - r^2) \sum_{m=0}^{M-1} r^m e^{-im\theta}$.
3. **Pointwise Bulk Energy Invariance:**  
   The energy density of the scattered field is completely uniform across the entire interior $1 \le k \le J - M$:
   $$
   |\text{historyCoefficient}(r, M, \text{box}(e^{i\theta}, J))(k)|^2 = |\text{compactPhase}(r, \theta, M)|^2.
   $$
4. **Unconditional Bulk Prime Amplification:**  
   For every prime $p$, setting the reflection parameter $r = 1/\sqrt{p}$, resonance phase $\theta = \pi/M$, and memory depth $M \ge 1$:
   $$
   |\text{historyCoefficient}(1/\sqrt{p}, M, \text{box}(e^{i\pi/M}, J))(k)|^2 > 1 \quad \text{for all } 1 \le k \le J - M.
   $$
   Every single prime generates genuine strictly super-unitary gain $> 1$ throughout the bulk!

---

## 2. Mathematical Proof

### 2.1. Interior Factorization
For $1 \le k \le J - M$:
- The predecessor term evaluates at $k - 1$. Since $k \ge 1$, $k - 1 \ge 0$. Since $k \le J - M \le J - 1$, $k - 1 < J$. Thus $\text{box}(q, J)(k - 1) = q^{-(k-1)} = q^{-k} q$.
- The lookahead terms evaluate at $k + m$ for $0 \le m < M$. Since $k \ge 1 \ge 0$, $k + m \ge 0$. Since $k \le J - M$ and $m \le M - 1$, $k + m \le J - 1 < J$. Thus $\text{box}(q, J)(k + m) = q^{-(k+m)} = q^{-k} (q^{-1})^m$.
Substituting into the definition:
$$
\text{historyCoefficient}(r, M, \text{box}(q, J))(k) = -r (q^{-k} q) + (1 - r^2) \sum_{m=0}^{M-1} r^m (q^{-k} (q^{-1})^m) = q^{-k} \left[ -r q + (1 - r^2) \sum_{m=0}^{M-1} (r q^{-1})^m \right].
$$

### 2.2. Modulus on the Unit Circle
For $q = e^{i\theta}$, $|q^{-k}| = |e^{-ik\theta}| = 1$.
By multiplicativity of the complex modulus:
$$
|\text{historyCoefficient}(r, M, \text{box}(e^{i\theta}, J))(k)|^2 = |e^{-ik\theta}|^2 |\text{compactPhase}(r, \theta, M)|^2 = |\text{compactPhase}(r, \theta, M)|^2.
$$

### 2.3. Prime Super-Unitary Amplification
By the localized prime scattering sign theorem (`actual_prime_compact_signs`), $|\text{compactPhase}(1/\sqrt{p}, \pi/M, M)|^2 > 1$ for every prime $p$ and $M \ge 1$.
Thus the interior scattered intensity strictly exceeds 1 for every bulk lattice site.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CompactScatteringCoefficients` in `formalization/BuildingBlocks/CompactScatteringCoefficients.lean`):
```lean
theorem history_box_interior (r : ℝ) (q : ℂ) (hq : q ≠ 0) (J M : ℕ) (k : ℤ)
    (hk : 1 ≤ k) (hbulk : k ≤ (J : ℤ) - (M : ℤ)) :
    historyCoefficient r M (box q J) k = q ^ (-k) *
      (-(r : ℂ) * q + (1 - (r : ℂ) ^ 2) *
        ∑ m ∈ Finset.range M, ((r : ℂ) * q⁻¹) ^ m)

theorem history_phase_box_interior (r theta : ℝ) (J M : ℕ) (k : ℤ)
    (hk : 1 ≤ k) (hbulk : k ≤ (J : ℤ) - (M : ℤ)) :
    historyCoefficient r M (box (phase theta) J) k =
      (phase theta) ^ (-k) * compactPhase r theta M

theorem history_phase_box_normSq (r theta : ℝ) (J M : ℕ) (k : ℤ)
    (hk : 1 ≤ k) (hbulk : k ≤ (J : ℤ) - (M : ℤ)) :
    Complex.normSq (historyCoefficient r M (box (phase theta) J) k) =
      Complex.normSq (compactPhase r theta M)

theorem prime_interior_amplification (p : ℕ) (hp : p.Prime)
    (J M : ℕ) (hM : 1 ≤ M) (k : ℤ) (hk : 1 ≤ k)
    (hbulk : k ≤ (J : ℤ) - (M : ℤ)) :
    1 < Complex.normSq (historyCoefficient (1 / Real.sqrt (p : ℝ)) M
      (box (phase (Real.pi / (M : ℝ))) J) k)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Phase-box wave packets and scattering transfer matrices (Lax-Phillips 1989, Dyatlov-Zworski 2019). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the exact local mechanism producing bulk gain across the prime scattering network.
- **Target Venues:** *Communications in Mathematical Physics* or *Journal of Spectral Theory*.
