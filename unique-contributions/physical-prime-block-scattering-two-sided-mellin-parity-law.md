# Contribution 85: Physical Prime-Block Scattering Two-Sided Mellin Parity Law

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualPrimeBlockMellinParity.lean`](../../formalization/BuildingBlocks/ActualPrimeBlockMellinParity.lean), [`formalization/BuildingBlocks/ActualScatteringMomentSigns.lean`](../../formalization/BuildingBlocks/ActualScatteringMomentSigns.lean), [`formalization/BuildingBlocks/ActualScatteringMellinSignBridge.lean`](../../formalization/BuildingBlocks/ActualScatteringMellinSignBridge.lean)  
**Classification:** Analytic Number Theory / Operator Theory / Scattering Theory / Mellin Transform / Critical Parity

---

## 1. Executive Summary and Mathematical Statement

In the scattering framework for the Riemann zeta function, physical history operators act on compactly supported profiles through sequential prime dilations. For each prime $p$ and truncation depth $M$, the discrete history Mellin multipliers at reciprocal dual points $\beta = h + 1/2$ and $-\beta = -(h + 1/2)$ are defined by:
$$
M_+(p, h, M) = -p^h + (1 - p^{-1}) \sum_{j=0}^{M-1} p^{-(h+1)j},
$$
$$
M_-(p, h, M) = -p^{-(h+1)} + (1 - p^{-1}) \sum_{j=0}^{M-1} p^{hj}.
$$

This contribution proves:

1. **Strict Opposing Sign Property for Single Primes:**  
   For every prime $p \ge 2$, every integer $h \ge 1$, and every depth $M \ge 1$:
   $$
   M_+(p, h, M) < 0 \quad \text{and} \quad M_-(p, h, M) > 0,
   $$
   whence the product multiplier is strictly negative:
   $$
   M_+(p, h, M) \cdot M_-(p, h, M) < 0.
   $$
2. **Positive Composite Block Amplitude:**  
   For any finite sequence of primes $ps = [p_1, \dots, p_k]$ and depths, the amplitude:
   $$
   \mathcal{A}(ps, \text{depth}, h) = \prod_{p \in ps} \left( - M_+(p, h, \text{depth}(p)) \cdot M_-(p, h, \text{depth}(p)) \right) > 0,
   $$
   is strictly positive.
3. **Exact Block Mellin Parity Law:**  
   For any continuous test function $f$ with compact support, applying the composite physical prime block operator $\mathcal{B}_{ps} f$ preserves regular support and satisfies the exact sign parity law:
   $$
   \mathcal{M}(\mathcal{B}_{ps} f)\left(h + \frac{1}{2}\right) \cdot \mathcal{M}(\mathcal{B}_{ps} f)\left(-\left(h + \frac{1}{2}\right)\right) = (-1)^{|ps|} \mathcal{A}(ps, \text{depth}, h) \left[ \mathcal{M}(f)\left(h + \frac{1}{2}\right) \cdot \mathcal{M}(f)\left(-\left(h + \frac{1}{2}\right)\right) \right].
   $$
4. **Significance for Weil Positivity and Spectral Rigidity:**  
   Every prime included in a physical scattering block deterministically toggles the sign of the two-sided Mellin product at real critical half-integers. This proves that no non-trivial scattering operator can maintain positive two-sided Mellin moments uniformly across blocks of varying prime length, establishing a fundamental obstruction to classical sign-regularity.

---

## 2. Mathematical Proof

### 2.1. Opposing Sign Analysis
Since $p \ge 2$ and $h \ge 1$, we have $p^h \ge 2$ and $p^{h+1} \ge 4$.
The geometric series bound yields:
$$
(1 - p^{-1}) \sum_{j=0}^{M-1} p^{-(h+1)j} \le (1 - p^{-1}) \frac{1}{1 - p^{-(h+1)}} \le 1.
$$
Since $p^h \ge 2$, $M_+(p, h, M) \le -2 + 1 = -1 < 0$.
Conversely, for $M_-$, the leading term of the sum is 1, so:
$$
(1 - p^{-1}) \sum_{j=0}^{M-1} p^{hj} \ge 1 - p^{-1} \ge \frac{1}{2} > \frac{1}{4} \ge p^{-(h+1)},
$$
proving $M_-(p, h, M) > 0$.
Thus $M_+(p) M_-(p) < 0$, so $-M_+(p) M_-(p) > 0$.

### 2.2. Block Multiplicativity and Parity Induction
By induction on the prime list $ps$, each prime layer acts by dilation and convolution, which factors on the Mellin transform:
$\mathcal{M}(\mathcal{H}_p f)(z) = \mathcal{H}_p(z) \mathcal{M}(f)(z)$.
At $z = \pm(h + 1/2)$, the multiplier factors into $M_+(p)$ and $M_-(p)$.
Writing $M_+(p) M_-(p) = -1 \cdot (-M_+(p) M_-(p))$, pulling out $-1$ for each prime factor yields the global sign $(-1)^{|ps|}$ times the strictly positive product amplitude $\mathcal{A} > 0$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualPrimeBlockMellinParity`):
```lean
theorem actual_block_amplitude_positive (ps : List ℕ) (depth : ℕ → ℕ)
    {h : ℕ} (hh : 1 ≤ h) (hprime : ∀ p ∈ ps, p.Prime)
    (hdepth : ∀ p ∈ ps, 1 ≤ depth p) : 0 < amplitude ps depth h

theorem actual_block_two_sided_mellin_parity {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ)
    (hprime : ∀ p ∈ ps, p.Prime) (h : ℕ) :
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) ((h : ℂ) + 1 / 2) *
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) (-((h : ℂ) + 1 / 2)) =
      (-1 : ℂ) ^ ps.length * (amplitude ps depth h : ℂ) *
        (BuildingBlocks.FullComplexHistoryMellin.mellin f ((h : ℂ) + 1 / 2) *
          BuildingBlocks.FullComplexHistoryMellin.mellin f (-((h : ℂ) + 1 / 2)))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior literature comparison:** Classical scattering models provide surrounding context. This page proves the stated parity law in its finite model. Priority for the formulation and formalization is provisional.
- **Advancement:** Establishes the exact parity theorem relating prime block length to the sign of the two-sided Mellin moment product.
- **Target Venues:** *Communications in Mathematical Physics* or *Journal of Functional Analysis*.
