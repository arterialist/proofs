# Contribution 103: Exact Two-Sided Prime Scattering Multiplier Magnitude Envelope and Cardinal Parity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualScatteringMomentSigns.lean`](../../formalization/BuildingBlocks/ActualScatteringMomentSigns.lean), [`formalization/BuildingBlocks/ActualScatteringMomentMagnitude.lean`](../../formalization/BuildingBlocks/ActualScatteringMomentMagnitude.lean)  
**Classification:** Analytic Number Theory / Scattering Operators / Mellin Multipliers / Two-Sided Moment Envelope / Cardinal Parity Law

---

## 1. Executive Summary and Mathematical Statement

In the spectral analysis of prime scattering operators $\mathcal{S}_{p, M}$ acting on wave packets across the critical line, the discrete multipliers $\mathcal{P}_p^+(h, M)$ and $\mathcal{P}_p^-(h, M)$ determine how test functions are transformed at moments $s = h + 1/2$ and $s = -(h + 1/2)$.

This contribution proves:

1. **Strict Opposite Multiplier Signs:**  
   For any base $p \ge 2$, integer moment index $h \ge 1$, and truncation depth $M \ge 1$:
   $$
   \mathcal{P}_p^+(h, M) < 0 \quad \text{and} \quad \mathcal{P}_p^-(h, M) > 0.
   $$
   Consequently, their two-sided product is strictly negative:
   $$
   A(p) := \mathcal{P}_p^+(h, M) \cdot \mathcal{P}_p^-(h, M) < 0.
   $$
2. **Cardinal Parity Law for Finite Prime Blocks:**  
   For any finite set of primes $B$ and depth assignments $M_p \ge 1$, the composite block multiplier satisfies:
   $$
   \prod_{p \in B} A(p) = (-1)^{|B|} \prod_{p \in B} (-A(p)), \quad \text{with } \prod_{p \in B} (-A(p)) > 0.
   $$
   The sign of the total prime scattering block depends solely on the cardinality parity $(-1)^{|B|}$.
3. **Universal Non-Asymptotic Two-Sided Power Envelope:**  
   The positive magnitude $-A(p) = |\mathcal{P}_p^+ \cdot \mathcal{P}_p^-|$ is strictly pinched between universal geometric bounds:
   $$
   \frac{1}{8} p^{hM} \le -\left( \mathcal{P}_p^+(h, M) \cdot \mathcal{P}_p^-(h, M) \right) \le 2 p^{hM}.
   $$
   The prefactors $1/8$ and $2$ are absolute constants completely independent of $p, h$, and $M$.
4. **Finite Prime Block Power Majorization:**  
   For any finite prime block $B$:
   $$
   8^{-|B|} \prod_{p \in B} p^{h M_p} \le \left| \prod_{p \in B} A(p) \right| \le 2^{|B|} \prod_{p \in B} p^{h M_p}.
   $$

---

## 2. Mathematical Proof

### 2.1. Sign Asymmetry
Recall:
$$
\mathcal{P}_p^+(h, M) = -p^h + (1 - p^{-1}) \sum_{j=0}^{M-1} p^{-j(h+1)}.
$$
The geometric sum satisfies $(1 - p^{-1}) \sum_{j=0}^{M-1} p^{-j(h+1)} \le 1$. Since $p^h \ge 2$, $-p^h + 1 \le -1 < 0$.
Conversely:
$$
\mathcal{P}_p^-(h, M) = -p^{-(h+1)} + (1 - p^{-1}) \sum_{j=0}^{M-1} p^{jh}.
$$
The $j=0$ term gives $1 - p^{-1} \ge 1/2$. Since $p^{h+1} \ge 4$, $p^{-(h+1)} \le 1/4$. Thus $\mathcal{P}_p^- \ge 1/2 - 1/4 = 1/4 > 0$.

### 2.2. Power Magnitude Pinching
Let $R = p^h \ge 2$ and $U = p^{-(h+1)} \le 1/4$.
- Upper and lower bounds on $-\mathcal{P}_p^+$:
  $R/2 \le R - 1 \le -\mathcal{P}_p^+ \le R$.
- Upper and lower bounds on $\mathcal{P}_p^-$:
  The geometric sum $S = \sum_{j=0}^{M-1} R^j$ satisfies $R^{M-1} \le S \le 2 R^{M-1}$ because $S(R-1) = R^M - 1$.
  Multiplying by $a = 1 - p^{-1} \in [1/2, 1]$ gives $\frac{1}{4} R^{M-1} \le \mathcal{P}_p^- \le 2 R^{M-1}$.
- Multiplying the two independent factors:
  Lower bound: $(R/2) \cdot (R^{M-1}/4) = \frac{1}{8} R^M = \frac{1}{8} p^{hM}$.
  Upper bound: $R \cdot (2 R^{M-1}) = 2 R^M = 2 p^{hM}$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualScatteringMomentSigns` and `BuildingBlocks.ActualScatteringMomentMagnitude`):
```lean
theorem literal_multiplier_signs {p : ℝ} {h M : ℕ}
    (hp : 2 ≤ p) (hh : 1 ≤ h) (hM : 1 ≤ M) :
    positiveMultiplier p h M < 0 ∧ 0 < negativeMultiplier p h M

theorem actual_prime_block_product_parity (B : Finset ℕ) (depth : ℕ → ℕ)
    {h : ℕ} (hh : 1 ≤ h) (hprime : ∀ p ∈ B, p.Prime)
    (hdepth : ∀ p ∈ B, 1 ≤ depth p) :
    let A := fun (p : ℕ) => positiveMultiplier (p : ℝ) h (depth p) *
      negativeMultiplier (p : ℝ) h (depth p)
    (0 < ∏ p ∈ B, -A p) ∧
      (∏ p ∈ B, A p) = (-1 : ℝ) ^ B.card * ∏ p ∈ B, -A p

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

- **Prior Literature:** Multiplier bounds in discrete scattering theory typically rely on asymptotic estimates as depth $M \to \infty$. The explicit, non-asymptotic pinching $\frac{1}{8} p^{hM} \le -A(p) \le 2 p^{hM}$ with universal constants and the cardinal parity law $\operatorname{sgn}(\prod A(p)) = (-1)^{|B|}$ are novel.
- **Advancement:** Establishes machine-verified cardinal parity and exact power envelopes for prime scattering blocks.
- **Target Venues:** *Communications in Mathematical Physics* or *Journal of Spectral Theory*.
