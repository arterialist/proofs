# Collective All-Prime Seed Weak Derivative and Mutually Singular Radon Measures

**Date:** 19 September 2026
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSeedAllPrimeDerivative.lean`](../../formalization/BuildingBlocks/PrimeSeedAllPrimeDerivative.lean), [`formalization/BuildingBlocks/PrimeSeedFiniteDerivative.lean`](../../formalization/BuildingBlocks/PrimeSeedFiniteDerivative.lean)
**Classification:** Distribution Theory / Measure Theory / Harmonic Analysis / Prime Distribution
**Taxonomy:** Building block; theorem content is retained for reuse. No priority claim is made.

---

## 1. Executive Summary and Mathematical Statement

The collective all-prime birth seed $\operatorname{allPrimeSeed}(v) = \sum_p \operatorname{seed}(\log p, v)$ represents the superposition of all prime renewal clocks across the logarithmic axis. While square-integrable ($L^2(\mathbb{R})$), its regularity, differentiability, and distributional structure remained unexamined.

This note records:

1. **Jordan Decomposition into Mutually Singular Positive Measures:**
   The weak derivative of $\operatorname{allPrimeSeed}$ decomposes into positive and negative measures:
   $$
   \mu_{\mathrm{all}}^+ = \sum_{p \text{ prime}} \mu_p^+, \quad \mu_{\mathrm{all}}^- = \sum_{p \text{ prime}} \mu_p^-.
   $$
   These infinite measures are **strictly mutually singular**:
   $$
   \mu_{\mathrm{all}}^+ \perp \mu_{\mathrm{all}}^-.
   $$
2. **Infinite Total Variation via Divergence of Prime Reciprocals:**
   Using the divergence of $\sum_p \frac{1}{p} = \infty$, the global total mass of both the positive and negative derivative measures is **unconditionally infinite**:
   $$
   \mu_{\mathrm{all}}^+(\mathbb{R}) = +\infty, \quad \mu_{\mathrm{all}}^-(\mathbb{R}) = +\infty.
   $$
   Thus, the collective seed does not have bounded total variation globally on $\mathbb{R}$.
3. **Local Finiteness via Finite Horizon Cutoff:**
   On every left half-line $(-\infty, A]$, the prime clock support implies that only primes $p \le \lfloor e^A \rfloor$ have non-zero mass. Because the number of primes below $e^A$ is finite:
   $$
   \mu_{\mathrm{all}}^+((-\infty, A]) < \infty, \quad \mu_{\mathrm{all}}^-((-\infty, A]) < \infty.
   $$
   Hence, $\mu_{\mathrm{all}}^+$ and $\mu_{\mathrm{all}}^-$ are valid Radon measures on $\mathbb{R}$.
4. **Exact Weak Distributional Derivative Identity:**
   For every $C^1$ test function $\varphi$ vanishing above an arbitrary horizon $A$:
   $$
   \int_{\mathbb{R}} \operatorname{allPrimeSeed}(v) \varphi'(v) dv = \int_{\mathbb{R}} \varphi(v) d\mu_{\mathrm{all}}^-(v) - \int_{\mathbb{R}} \varphi(v) d\mu_{\mathrm{all}}^+(v).
   $$
   This proves that in the sense of Schwartz distributions $\mathcal{D}'(\mathbb{R})$, the distributional derivative is represented by the difference of these two singular Radon measures:
   $$
   (\operatorname{allPrimeSeed})' = \mu_{\mathrm{all}}^+ - \mu_{\mathrm{all}}^-.
   $$

---

## 2. Mathematical Proof

### 2.1. Single-Prime Seed Structure
For a fixed prime $p$ with clock $L = \log p > 0$:
$$
\operatorname{seed}(L, v) = \begin{cases} 0 & v < L \\ e^{-(v - L)/2} & L \le v < 2L \\ e^{-(v - 2L)/2} (1 - e^{-L}) & 2L \le v < 3L \\ \vdots & \end{cases}
$$
Its derivative in distribution consists of:
- A continuous negative drift $- \frac{1}{2} \operatorname{seed}(L, v) dv$,
- Positive jump at $v = L$ of size $+1$,
- Negative jumps at integer multiples $v = (j+2)L$ of size $-(1 - e^{-L}) e^{-(j+1)L/2}$.

Grouping these terms:
$$
d\mu_p^+(v) = \delta_L(v) + \frac{1}{2} \operatorname{seed}(L, v) dv, \quad d\mu_p^-(v) = \sum_{j=0}^\infty (1 - e^{-L}) e^{-(j+2)L/2} \delta_{(j+2)L}(v).
$$
Because $\mu_p^+$ is supported on $\{L\} \cup [L, \infty)$ (with continuous density) while $\mu_p^-$ is a pure atomic measure supported on $\{2L, 3L, \dots\}$, they are mutually singular.

### 2.2. Infinite Total Mass
The total mass of $\mu_p^+$ and $\mu_p^-$ is proportional to:
$$
e^{-\log p} + e^{-3\log p / 2} = \frac{1}{p} + \frac{1}{p^{3/2}} > \frac{1}{p}.
$$
Summing over all primes:
$$
\sum_{p} \left( \frac{1}{p} + \frac{1}{p^{3/2}} \right) \ge \sum_p \frac{1}{p} = \infty.
$$
By monotone convergence of measures:
$$
\mu_{\mathrm{all}}^+(\mathbb{R}) = \sum_p \mu_p^+(\mathbb{R}) = \infty, \quad \mu_{\mathrm{all}}^-(\mathbb{R}) = \sum_p \mu_p^-(\mathbb{R}) = \infty.
$$

### 2.3. Local Finiteness and Weak Derivative
For $v \le A$, if $\log p > A$, then $p > e^A$, so $\operatorname{seed}(\log p, v) = 0$ identically. Thus:
$$
\mu_{\mathrm{all}}^+((-\infty, A]) = \sum_{p \le e^A} \mu_p^+((-\infty, A]) < \infty.
$$
Since test functions $\varphi$ vanish for $v > A$, the infinite sum reduces on $\operatorname{supp} \varphi$ to the finite sum over primes $p \le e^A$. Summation by parts on each finite prime seed then yields the distributional identity.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSeedMass`):
```lean
theorem allPrimeDerivative_mutuallySingular :
    allPrimeDerivativePositive ⟂ₘ allPrimeDerivativeNegative

theorem allPrimeDerivativePositive_mass :
    allPrimeDerivativePositive univ = ∞

theorem allPrimeDerivativeNegative_mass :
    allPrimeDerivativeNegative univ = ∞

theorem allPrimeDerivativePositive_Iic_finite (A : ℝ) :
    allPrimeDerivativePositive (Iic A) < ∞

theorem allPrimeSeed_weak_derivative {A : ℝ} {φ φ' : ℝ → ℝ}
    (hφ : ∀ v, HasDerivAt φ (φ' v) v) (hc : Continuous φ')
    (hb : ∃ M, ∀ v, |φ v| ≤ M) (hb' : ∃ M, ∀ v, |φ' v| ≤ M)
    (hz : ∀ v, A < v → φ v = 0) (hz' : ∀ v, A < v → φ' v = 0) :
    Integrable φ allPrimeDerivativePositive ∧ Integrable φ allPrimeDerivativeNegative ∧
      Integrable (fun v => allPrimeSeed v * φ' v) ∧
      (∫ v, allPrimeSeed v * φ' v) =
        (∫ v, φ v ∂allPrimeDerivativeNegative) - ∫ v, φ v ∂allPrimeDerivativePositive
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Scope and status

- **Literature context:** The displayed statements use standard identities or project-specific definitions; no priority claim is made.
