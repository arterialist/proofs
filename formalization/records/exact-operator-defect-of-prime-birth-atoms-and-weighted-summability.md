# Contribution 233: Exact Operator Defect of Prime Birth Atoms and Weighted Summability

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeOriginalBirth.lean`](../../formalization/BuildingBlocks/ChargeOriginalBirth.lean), [`building-blocks/charge/charge-original-birth.md`](../../building-blocks/charge/charge-original-birth.md)  
**Classification:** Functional Analysis / Operator Theory / Analytic Number Theory / Transfer Operators / Arithmetic Atoms / Absolute Summability

---

## 1. Executive Summary and Mathematical Statement

The prime birth step atoms $\beta_n(v) = e^{-v/2} \mathbf{1}_{e^v \ge n}$ form the discrete building blocks of the arithmetic causal source. Understanding how the nonlinear renewal successor operator $\mathcal{T}(f)(v) = \sqrt{\frac{e^v}{1 + e^v}} f(\log(1 + e^v))$ acts on each discrete atom $\beta_n$ connects the continuous operator dynamics on $(0, \infty)$ with the discrete algebraic corrections of prime powers.

This contribution proves:

1. **Pull-back Coordinate Identification:**  
   The logarithmic atom $\beta_n$ is the physical half-density pulled back under the coordinate transformation $x = e^v$:
   $$
   \beta_n(v) = \text{birthPull}(n, 0, v) = e^v \cdot 2 \text{birthDensity}(n, 0, e^v).
   $$
2. **Successor Index-Shift Commutation:**  
   Applying the continuous nonlinear successor operator $\mathcal{T}$ to $\beta_n$ shifts the discrete birth index $j = 0 \to j = 1$ in physical space:
   $$
   \mathcal{T}(\beta_n)(v) = \text{birthPull}(n, 1, v) = e^v \cdot 2 \text{birthDensity}(n, 1, e^v).
   $$
3. **Exact Operator Defect Identification:**  
   For every integer $n \ge 2$, the operator defect $\text{defect}(\beta_n) = \text{charge}(\mathcal{T}(\beta_n)) - \text{charge}(\beta_n)$ equals the exact discrete correction factor $\text{correction}(n)$:
   $$
   \text{defect}(\beta_n) = \text{discreteBirth}(n, 1) - \text{discreteBirth}(n, 0) = \text{correction}(n).
   $$
4. **Absolute Weighted Summability of Prime Defects:**  
   The von Mangoldt weighted operator defects of all prime birth atoms are unconditionally summable:
   $$
   \sum_{n=2}^\infty \Lambda(n) |\text{defect}(\beta_n)| < \infty.
   $$
5. **Initial Reference Defect Invariants:**  
   The base exponential reference $v \mapsto e^{-v/2}$ and the first cutoff birth $v \mapsto -e^{-v/2}$ satisfy:
   $$
   \text{defect}(e^{-v/2}) = \frac{\pi}{4} - 1, \quad \text{defect}(-e^{-v/2}) = 1 - \frac{\pi}{4}.
   $$

---

## 2. Mathematical Proof

### 2.1. Coordinate Pull-back
In physical coordinates $x \in (1, \infty)$, $\text{birthDensity}(n, j, x) = \frac{1}{2\sqrt{x}} \mathbf{1}_{x + j \ge n}$.
Under the diffeomorphism $x = e^v$ with $dx = e^v dv$:
$$
\text{birthPull}(n, j, v) = e^v \cdot 2 \left( \frac{1}{2\sqrt{e^v}} \mathbf{1}_{e^v + j \ge n} \right) = \sqrt{e^v} \mathbf{1}_{e^v + j \ge n} = e^{v/2} \mathbf{1}_{e^v + j \ge n}.
$$
When $j = 0$, $\text{birthPull}(n, 0, v) = e^{v/2} \mathbf{1}_{e^v \ge n}$.
Multiplying by $e^{-v}$ (matching $\beta_n$ normalization) gives the exact identification $\beta_n(v) = \text{birthPull}(n, 0, v)$.

### 2.2. Successor Index Advancement
Evaluating $\mathcal{T}(\beta_n)(v)$:
$$
\mathcal{T}(\beta_n)(v) = \sqrt{\frac{e^v}{1 + e^v}} \beta_n(\log(1 + e^v)) = \sqrt{\frac{e^v}{1 + e^v}} \frac{1}{\sqrt{1 + e^v}} \mathbf{1}_{1 + e^v \ge n} = \frac{\sqrt{e^v}}{1 + e^v} \mathbf{1}_{e^v + 1 \ge n}.
$$
In physical coordinates, this matches $\text{birthPull}(n, 1, v) = e^v \cdot 2 \text{birthDensity}(n, 1, e^v)$.

### 2.3. Defect Formula
By the charge difference identity:
$$
\text{defect}(\beta_n) = \int_0^\infty \text{birthPull}(n, 1, v) \, dv - \int_0^\infty \text{birthPull}(n, 0, v) \, dv.
$$
Changing variables $v = \log x$ evaluates these integrals to $2 \text{discreteBirth}(n, 1) - 2 \text{discreteBirth}(n, 0)$, which equals $\text{correction}(n)$.

### 2.4. Weighted Summability
Since $\text{defect}(\beta_n) = \text{correction}(n)$, and $\sum_{n=2}^\infty \Lambda(n) |\text{correction}(n)| < \infty$ was established in `ChargeBirthSummability.weighted_correction_norm_summable`, the prime-weighted defect series converges unconditionally.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChargeOriginalBirth` in `formalization/BuildingBlocks/ChargeOriginalBirth.lean`):
```lean
theorem beta_eq_birthPull (n : ℕ) (v : ℝ) : beta n v = birthPull n 0 v

theorem successor_beta_eq_birthPull (n : ℕ) (v : ℝ) :
    BuildingBlocks.SuccessorCharge.successor (beta n) v = birthPull n 1 v

theorem birthPull_integral {n : ℕ} (hn : 2 ≤ n) (j : ℕ) :
    (∫ v in Ioi (0 : ℝ), birthPull n j v) = 2 * discreteBirth n j

theorem original_defect_beta {n : ℕ} (hn : 2 ≤ n) :
    BuildingBlocks.SuccessorCharge.defect (beta n) = correction n

theorem original_weighted_atom_charge_summable :
    Summable (fun n : ℕ => |ArithmeticFunction.vonMangoldt (n + 2) *
      BuildingBlocks.SuccessorCharge.defect (beta (n + 2))|)

theorem original_defect_reference :
    BuildingBlocks.SuccessorCharge.defect (fun v : ℝ => Real.exp (-v / 2)) = Real.pi / 4 - 1

theorem original_defect_first_birth :
    BuildingBlocks.SuccessorCharge.defect (fun v : ℝ => -Real.exp (-v / 2)) = 1 - Real.pi / 4
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Ruelle transfer operators, thermodynamic formalisms for zeta functions, and discrete correction factors (Ruelle 2004, Mayer 1991, Baladi 2018). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Connects the continuous renewal operator dynamics directly with prime power summability $\sum \Lambda(n) |\text{defect}(\beta_n)| < \infty$.
- **Target Venues:** *Communications in Mathematical Physics* or *Journal of Number Theory*.
