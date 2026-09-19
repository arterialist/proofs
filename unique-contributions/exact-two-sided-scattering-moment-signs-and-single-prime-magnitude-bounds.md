# Unique Contribution 128: Exact Two-Sided Scattering Moment Signs and Single-Prime Magnitude Bounds

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualScatteringMomentSigns.lean`](../../formalization/BuildingBlocks/ActualScatteringMomentSigns.lean), [`formalization/BuildingBlocks/ActualScatteringMomentMagnitude.lean`](../../formalization/BuildingBlocks/ActualScatteringMomentMagnitude.lean), [`building-blocks/scattering/actual-scattering-moment-signs.md`](../../building-blocks/scattering/actual-scattering-moment-signs.md)  
**Classification:** Operator Scattering / Mellin Multipliers / Prime Scattering / Discrete Geometric Sums / Sign Definiteness / Two-Sided Estimates

---

## 1. Executive Summary and Mathematical Statement

The local scattering operator associated with a prime $p$ and history depth $M$ acts on Mellin transforms at $\pm\beta = \pm(h + 1/2)$ through the multipliers:
\[
\mu^+(p, h, M) = -p^h + (1 - p^{-1}) \sum_{j=0}^{M-1} (p^{-(h+1)})^j,
\]
and:
\[
\mu^-(p, h, M) = -p^{-(h+1)} + (1 - p^{-1}) \sum_{j=0}^{M-1} (p^h)^j.
\]

This contribution proves:

1. **Strict Opposite Signs for Multipliers:**  
   For any real base $p \ge 2$, integer moment index $h \ge 1$, and finite depth $M \ge 1$:
   \[
   \mu^+(p, h, M) < 0 \quad \text{and} \quad \mu^-(p, h, M) > 0.
   \]
2. **Strict Negativity of Local Multiplier Product:**  
   For any prime $p$:
   \[
   \mu^+(p, h, M) \cdot \mu^-(p, h, M) < 0.
   \]
3. **Exact Block Parity Factorization:**  
   For any finite set of primes $B$ with depths $d(p) \ge 1$:
   \[
   \prod_{p \in B} (\mu^+(p, h, d(p)) \cdot \mu^-(p, h, d(p))) = (-1)^{|B|} \prod_{p \in B} (-\mu^+ \mu^-),
   \]
   where the magnitude product is strictly positive: $\prod_{p \in B} (-\mu^+ \mu^-) > 0$.
4. **Sharp Single-Prime Magnitude Bounds:**  
   For any prime $p$, moment $h \ge 1$, and depth $M \ge 1$:
   \[
   \frac{1}{8} p^{h M} \le -\left(\mu^+(p, h, M) \cdot \mu^-(p, h, M)\right) \le 2 p^{h M}.
   \]

---

## 2. Mathematical Proof

### 2.1. Multiplier Signs
Let $U = p^{-(h+1)}$ and $R = p^h$. For $p \ge 2, h \ge 1$:
\[
U \le \frac{1}{4}, \quad R \ge 2, \quad 1 - p^{-1} \le 1 - U.
\]
By the geometric sum identity:
\[
(1 - p^{-1}) \sum_{j=0}^{M-1} U^j \le (1 - U) \sum_{j=0}^{M-1} U^j = 1 - U^M \le 1.
\]
Since $p^h \ge 2$, we have $\mu^+ = -p^h + (1 - p^{-1})\sum U^j \le -2 + 1 = -1 < 0$.
For the negative multiplier, the leading term is $-U \ge -1/4$, while the sum contains $j=0$ giving at least $1 - p^{-1} \ge 1/2$. Thus:
\[
\mu^- \ge -1/4 + 1/2 = 1/4 > 0.
\]

### 2.2. Product Negativity and Parity
Since $\mu^+ < 0$ and $\mu^- > 0$, their product is strictly negative: $\mu^+ \mu^- < 0$.
Multiplying over a set $B$ of cardinality $|B|$:
\[
\prod_{p \in B} (\mu^+ \mu^-) = \prod_{p \in B} (-1)(-\mu^+ \mu^-) = (-1)^{|B|} \prod_{p \in B} (-\mu^+ \mu^-).
\]

### 2.3. Magnitude Bounds
The factor $-\mu^+$ satisfies $R/2 \le -\mu^+ \le R$.
The factor $\mu^-$ satisfies $R^{M-1}/4 \le \mu^- \le 2 R^{M-1}$.
Multiplying the two bounds:
\[
\frac{R}{2} \cdot \frac{R^{M-1}}{4} \le -\mu^+ \mu^- \le R \cdot 2 R^{M-1} \implies \frac{1}{8} R^M \le -\mu^+ \mu^- \le 2 R^M.
\]
Since $R = p^h$, $R^M = p^{h M}$, which establishes the claim.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualScatteringMomentSigns` and `BuildingBlocks.ActualScatteringMomentMagnitude`):
```lean
theorem literal_multiplier_signs {p : ℝ} {h M : ℕ}
    (hp : 2 ≤ p) (hh : 1 ≤ h) (hM : 1 ≤ M) :
    positiveMultiplier p h M < 0 ∧ 0 < negativeMultiplier p h M

theorem actual_prime_multiplier_product_negative {p h M : ℕ}
    (hp : p.Prime) (hh : 1 ≤ h) (hM : 1 ≤ M) :
    positiveMultiplier (p : ℝ) h M * negativeMultiplier (p : ℝ) h M < 0

theorem actual_prime_block_product_parity (B : Finset ℕ) (depth : ℕ → ℕ)
    {h : ℕ} (hh : 1 ≤ h) (hprime : ∀ p ∈ B, p.Prime)
    (hdepth : ∀ p ∈ B, 1 ≤ depth p) :
    let A := fun (p : ℕ) => positiveMultiplier (p : ℝ) h (depth p) *
      negativeMultiplier (p : ℝ) h (depth p)
    (0 < ∏ p ∈ B, -A p) ∧
      (∏ p ∈ B, A p) = (-1 : ℝ) ^ B.card * ∏ p ∈ B, -A p

theorem literal_multiplier_magnitude {p : ℝ} {h M : ℕ}
    (hp : 2 ≤ p) (hh : 1 ≤ h) (hM : 1 ≤ M) :
    (p ^ h) ^ M / 8 ≤
        -(positiveMultiplier p h M * negativeMultiplier p h M) ∧
      -(positiveMultiplier p h M * negativeMultiplier p h M) ≤
        2 * (p ^ h) ^ M

theorem actual_prime_multiplier_magnitude {p h M : ℕ}
    (hp : p.Prime) (hh : 1 ≤ h) (hM : 1 ≤ M) :
    ((p : ℝ) ^ (h * M)) / 8 ≤
        -(positiveMultiplier (p : ℝ) h M * negativeMultiplier (p : ℝ) h M) ∧
      -(positiveMultiplier (p : ℝ) h M * negativeMultiplier (p : ℝ) h M) ≤
        2 * (p : ℝ) ^ (h * M)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Scattering multipliers in non-symmetric and open quantum systems (Rotter 2009, Moiseyev 2011). The machine formalization of explicit sign opposition and two-sided power bounds for prime-scattering Mellin multipliers in Lean 4 is novel.
- **Advancement:** Establishes machine-verified strict sign alternation and two-sided magnitude scaling $p^{hM}$ for prime-scattering multipliers.
- **Target Venues:** *Journal of Mathematical Physics* or *Linear Algebra and its Applications*.
