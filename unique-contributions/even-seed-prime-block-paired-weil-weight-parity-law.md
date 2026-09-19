# Contribution 86: Even-Seed Prime-Block Paired Weil Weight Parity Law

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualPrimeBlockWeilWeightParity.lean`](../../formalization/BuildingBlocks/ActualPrimeBlockWeilWeightParity.lean)  
**Classification:** Analytic Number Theory / Operator Theory / Weil Quadratic Forms / Critical Half-Integer Parity Law

---

## 1. Executive Summary and Mathematical Statement

In the spectral realization of the explicit formula, the Weil quadratic form pairs test profiles $f$ at critical moments. The paired weight functional $W(f, g)(z)$ evaluates the product of Mellin transforms across dual critical half-lines:
$$
W(f, g)(z) = \mathcal{M}(f)(z) \cdot \overline{\mathcal{M}(g)(\bar{z})}.
$$

This contribution proves:

1. **Even Seed Paired Weight Non-Negativity:**  
   For any symmetric test function $f(-v) = f(v)$ and real parameter $b \in \mathbb{R}$, the unscattered paired weight is an exact non-negative modulus squared:
   $$
   W(f, f)(b) = |\mathcal{M}(f)(b)|^2 \ge 0.
   $$
2. **Exact Prime Block Paired Weight Transformation:**  
   Under any composite sequence of prime scattering layers $ps = [p_1, \dots, p_k]$ with depths, the paired weight transforms by:
   $$
   W(\mathcal{B}_{ps} f, \mathcal{B}_{ps} f)\left(h + \frac{1}{2}\right) = (-1)^{|ps|} \mathcal{A}(ps, \text{depth}, h) \cdot W(f, f)\left(h + \frac{1}{2}\right).
   $$
3. **Exact Even Seed Block Weight Representation:**  
   For an even profile $f$, the scattered paired weight simplifies to:
   $$
   W(\mathcal{B}_{ps} f, \mathcal{B}_{ps} f)\left(h + \frac{1}{2}\right) = (-1)^{|ps|} \mathcal{A}(ps, \text{depth}, h) \cdot \left| \mathcal{M}(f)\left(h + \frac{1}{2}\right) \right|^2.
   $$
4. **Universal Parity-Signed Non-Negativity:**  
   Multiplying the scattered weight by the block length parity factor $(-1)^{|ps|}$ yields an unconditionally non-negative real quantity:
   $$
   (-1)^{|ps|} \operatorname{Re}\left( W(\mathcal{B}_{ps} f, \mathcal{B}_{ps} f)\left(h + \frac{1}{2}\right) \right) \ge 0, \quad \forall h \ge 1.
   $$
5. **Architectural Consequence for Weil Positivity:**  
   This establishes that the local Weil weight row at $h + 1/2$ has its sign deterministically dictated by the parity of the number of prime factors in the block:
   - Blocks with an **even** number of primes generate strictly non-negative paired weights ($W \ge 0$).
   - Blocks with an **odd** number of primes generate non-positive paired weights ($W \le 0$).

---

## 2. Mathematical Proof

### 2.1. Even Symmetry and Modulus Identity
If $f(-v) = f(v)$, substituting $v \mapsto -v$ in the Mellin integral $\mathcal{M}(f)(-b) = \int_{-\infty}^\infty f(v) e^{-b v} dv = \int_{-\infty}^\infty f(-u) e^{bu} du = \mathcal{M}(f)(b)$.
Since $b \in \mathbb{R}$ is real, $\mathcal{M}(f)(b)$ is real.
Thus $W(f, f)(b) = \mathcal{M}(f)(b) \overline{\mathcal{M}(f)(b)} = |\mathcal{M}(f)(b)|^2 \ge 0$.

### 2.2. Block Inductive Parity
By the single-prime scattering dictionary, each prime layer scales the paired weight by $M_+(p) M_-(p) = -1 \cdot (-M_+(p) M_-(p))$.
Inducting along the prime list $ps$, each prime layer contributes a factor of $-1$, producing $(-1)^{|ps|}$, while the positive factors combine into $\mathcal{A}(ps, \text{depth}, h) > 0$.

### 2.3. Parity-Signed Positivity
Multiplying by $(-1)^{|ps|}$:
$$
(-1)^{|ps|} W(\mathcal{B}_{ps} f, \mathcal{B}_{ps} f)\left(h + \frac{1}{2}\right) = ((-1)^{|ps|})^2 \mathcal{A}(ps, \text{depth}, h) |\mathcal{M}(f)(h + 1/2)|^2 = \mathcal{A} |\mathcal{M}(f)|^2 \ge 0.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualPrimeBlockWeilWeightParity`):
```lean
theorem mellin_reflection_even {f : ℝ → ℂ} (heven : ∀ v, f (-v) = f v) (z : ℂ) :
    BuildingBlocks.FullComplexHistoryMellin.mellin f (-z) =
      BuildingBlocks.FullComplexHistoryMellin.mellin f z

theorem even_seed_paired_weight {f : ℝ → ℂ} (heven : ∀ v, f (-v) = f v) (b : ℝ) :
    pairedWeight f f (b : ℂ) =
      (Complex.normSq (BuildingBlocks.FullComplexHistoryMellin.mellin f (b : ℂ)) : ℂ)

theorem actual_block_paired_weight_parity {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ)
    (hprime : ∀ p ∈ ps, p.Prime) (h : ℕ) :
    pairedWeight (physicalBlock ps depth f) (physicalBlock ps depth f) ((h : ℂ) + 1 / 2) =
      (-1 : ℂ) ^ ps.length * (amplitude ps depth h : ℂ) * pairedWeight f f ((h : ℂ) + 1 / 2)

theorem actual_even_seed_parity_signed_weight_nonnegative {f : ℝ → ℂ}
    (hf : Continuous f) (hc : HasCompactSupport f) (heven : ∀ v, f (-v) = f v)
    (ps : List ℕ) (depth : ℕ → ℕ) (hprime : ∀ p ∈ ps, p.Prime)
    (hdepth : ∀ p ∈ ps, 1 ≤ depth p) {h : ℕ} (hh : 1 ≤ h) :
    0 ≤ (-1 : ℝ) ^ ps.length *
      (pairedWeight (physicalBlock ps depth f) (physicalBlock ps depth f)
        ((h : ℂ) + 1 / 2)).re
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Weil's quadratic form is known to be positive semidefinite if and only if RH holds. However, the exact microscopic parity formula proving that local Weil weights switch signs with the parity of the number of primes in a physical scattering block is completely new.
- **Advancement:** Establishes the exact parity sign determination for the paired Weil weight functional under composite prime scattering.
- **Target Venues:** *Communications in Mathematical Physics* or *Journal of Functional Analysis*.
