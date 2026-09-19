# First Formalization: Exact Compact Scattering Packet Energy Identity and Orthogonal Translate Isometry

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CompactScatteringPackets.lean`](../../formalization/BuildingBlocks/CompactScatteringPackets.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the geometric finite-depth scattering energy identity, proves the bulk gain threshold, and proves the exact $L^2$ isometry for lattice translates in Lean 4:

1. **Finite-Depth Scattering Energy Identity:**
   Formal proof of `isolated_packet_energy`: $r^2 + (1 - r^2)^2 \sum_{j=0}^{M-1} (r^2)^j = 1 - (1 - r^2)(r^2)^M$.
2. **Bulk Gain Threshold Existence:**
   Formal proof of `exists_finite_bulk_gain`: For any $M$ and $G > 1$, there exists $J > M$ with $(J - M)G > J$.
3. **Pointwise Disjoint Translate Annihilation:**
   Formal proof of `separated_translate_values`: $\eta(v - i L) \cdot \eta(v - j L) = 0$ for $i \ne j$ when $b - a \le L$.
4. **Exact $L^2$ Translate Isometry:**
   Formal proof of `physical_translate_sum_square`: $\|\sum_{i \in s} c_i \eta(\cdot - i L)\|_2^2 = (\sum_{i \in s} |c_i|^2) \|\eta\|_2^2$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact finite-depth geometric packet energy identity
theorem isolated_packet_energy (r : ℝ) (M : ℕ) :
    r ^ 2 + (1 - r ^ 2) ^ 2 * ∑ j ∈ Finset.range M, (r ^ 2) ^ j =
      1 - (1 - r ^ 2) * (r ^ 2) ^ M

-- Existence of packet length achieving bulk gain
theorem exists_finite_bulk_gain (M : ℕ) {G : ℝ} (hG : 1 < G) :
    ∃ J : ℕ, M < J ∧ (J - M : ℝ) * G > J

-- Pairwise disjointness of translates under lattice spacing condition
theorem separated_translate_values {eta : ℝ → ℂ} {a b L : ℝ}
    (hL : 0 < L) (hw : b - a ≤ L)
    (hs : ∀ x, eta x ≠ 0 → a < x ∧ x < b)
    (i j : ℤ) (hij : i ≠ j) (v : ℝ) :
    eta (v - (i : ℝ) * L) = 0 ∨ eta (v - (j : ℝ) * L) = 0

-- Exact L² isometry for translate trains
theorem physical_translate_sum_square {eta : ℝ → ℂ} {a b L : ℝ}
    (hL : 0 < L) (hw : b - a ≤ L)
    (hs : ∀ x, eta x ≠ 0 → a < x ∧ x < b)
    (heta : MeasureTheory.Integrable (fun v => Complex.normSq (eta v)))
    (s : Finset ℤ) (c : ℤ → ℂ) :
    physicalSquare (fun v => ∑ i ∈ s, c i * eta (v - (i : ℝ) * L)) =
      (∑ i ∈ s, Complex.normSq (c i)) * physicalSquare eta
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the geometric finite-depth scattering energy identity and establishing the exact $L^2$ isometry for compactly supported lattice translates.
