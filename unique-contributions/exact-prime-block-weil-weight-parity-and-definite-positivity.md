# Contribution 132: Exact Prime-Block Weil Weight Parity and Definite Positivity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualPrimeBlockWeilWeightParity.lean`](../../formalization/BuildingBlocks/ActualPrimeBlockWeilWeightParity.lean), [`building-blocks/weil-trace/actual-prime-block-weil-weight-parity.md`](../../building-blocks/weil-trace/actual-prime-block-weil-weight-parity.md)  
**Classification:** Analytic Number Theory / Weil Explicit Formula / Mellin Reflection / Prime Scattering / Parity Law / Quadratic Positivity

---

## 1. Executive Summary and Mathematical Statement

In the spectral evaluation of the Weil explicit formula with test functions $f \in C_c(\mathbb{R})$, the paired Mellin weight at $s = h + 1/2$ is defined by:
$$
\mathcal{W}_{f, g}(s) = \mathcal{M}(f)(s) \cdot \overline{\mathcal{M}(g)(\bar{s})}.
$$
For an even seed $f(-v) = f(v)$, the paired weight collapses to the squared norm: $\mathcal{W}_{f, f}(b) = |\mathcal{M}(f)(b)|^2 \ge 0$. Under the action of a finite composite block of prime scattering operators $U_{ps}$, the Mellin transform picks up local multipliers with strictly alternating signs.

This contribution proves:

1. **Even Reflection Invariance:**  
   If $f$ is even, its complex Mellin transform satisfies:
   $$
   \mathcal{M}(f)(-z) = \mathcal{M}(f)(z).
   $$
2. **Even Seed Paired Weight Norm Equivalence:**  
   For any real argument $b \in \mathbb{R}$:
   $$
   \mathcal{W}_{f, f}(b) = |\mathcal{M}(f)(b)|^2.
   $$
3. **Exact Block Weil Weight Parity Law:**  
   For any continuous, compactly supported seed $f$, and any block of primes $ps$ with lengths $k = |ps|$:
   $$
   \mathcal{W}_{U_{ps} f, U_{ps} f}\left(h + \frac{1}{2}\right) = (-1)^k A(ps, d, h) \mathcal{W}_{f, f}\left(h + \frac{1}{2}\right),
   $$
   where $A(ps, d, h) > 0$ is the strictly positive composite amplitude.
4. **Exact Real Representation for Even Seeds:**  
   $$
   \mathcal{W}_{U_{ps} f, U_{ps} f}\left(h + \frac{1}{2}\right) = (-1)^k A(ps, d, h) \left| \mathcal{M}(f)\left(h + \frac{1}{2}\right) \right|^2 \in \mathbb{R}.
   $$
5. **Universal Parity-Compensated Non-Negativity:**  
   Multiplying by the parity factor $(-1)^k$ yields an identically non-negative real quantity:
   $$
   (-1)^k \operatorname{Re}\left( \mathcal{W}_{U_{ps} f, U_{ps} f}\left(h + \frac{1}{2}\right) \right) \ge 0.
   $$

---

## 2. Mathematical Proof

### 2.1. Even Reflection Invariance
Using the substitution $u = -v$:
$$
\mathcal{M}(f)(-z) = \int_{-\infty}^\infty f(v) e^{-z v} dv = \int_{-\infty}^\infty f(-u) e^{z u} du = \int_{-\infty}^\infty f(u) e^{z u} du = \mathcal{M}(f)(z).
$$
Applying this to the paired weight $\mathcal{W}_{f, f}(b) = \mathcal{M}(f)(b) \overline{\mathcal{M}(f)(-b)} = \mathcal{M}(f)(b) \overline{\mathcal{M}(f)(b)} = |\mathcal{M}(f)(b)|^2$.

### 2.2. Block Inductive Step
By induction on the list of primes $ps$:
At each prime step $p$, the local history operator acts on Mellin transforms as:
$$
\mathcal{W}_{U_p f, U_p f}(s) = \mu^+(p) \mu^-(p) \mathcal{W}_{f, f}(s) = -(-\mu^+(p)\mu^-(p)) \mathcal{W}_{f, f}(s) = (-1) A(p) \mathcal{W}_{f, f}(s).
$$
Accumulating over $k = |ps|$ primes yields $(-1)^k A(ps, d, h) \mathcal{W}_{f, f}(s)$.

### 2.3. Parity-Compensated Non-Negativity
Multiplying the real part of $\mathcal{W}_{U_{ps} f, U_{ps} f}(h+1/2)$ by $(-1)^k$:
$$
(-1)^k \cdot \left( (-1)^k A(ps, d, h) |\mathcal{M}(f)(h+1/2)|^2 \right) = ((-1)^k)^2 A(ps, d, h) |\mathcal{M}(f)(h+1/2)|^2 = A(ps, d, h) |\mathcal{M}(f)(h+1/2)|^2.
$$
Since $A(ps, d, h) > 0$ and $|\mathcal{M}(f)|^2 \ge 0$, the product is non-negative.

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

theorem actual_even_seed_block_weight {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (heven : ∀ v, f (-v) = f v)
    (ps : List ℕ) (depth : ℕ → ℕ) (hprime : ∀ p ∈ ps, p.Prime) (h : ℕ) :
    pairedWeight (physicalBlock ps depth f) (physicalBlock ps depth f) ((h : ℂ) + 1 / 2) =
      (((-1 : ℝ) ^ ps.length * amplitude ps depth h *
        Complex.normSq (BuildingBlocks.FullComplexHistoryMellin.mellin f
          ((h : ℂ) + 1 / 2)) : ℝ) : ℂ)

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

- **Prior Literature:** Quadratic forms in the Weil explicit formula (Weil 1952, Burnol 2002, Connes 1999). The machine formalization of parity-signed paired Mellin weights and guaranteed positivity $(-1)^k \mathcal{W} \ge 0$ for prime-scattering blocks in Lean 4 is novel.
- **Advancement:** Establishes machine-verified exact parity laws and sign-compensated non-negativity for composite prime-scattering blocks.
- **Target Venues:** *Communications in Mathematical Physics* or *Journal of Number Theory*.
