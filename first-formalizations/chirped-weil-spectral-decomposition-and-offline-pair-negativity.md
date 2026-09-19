# First Formalization 354: Chirped Weil Spectral Decomposition and Off-Line Pair Negativity

## 1. Overview and Formal Specification

- **Module:** [`formalization/BuildingBlocks/ChirpedWeilSpectralDecomposition.lean`](../formalization/BuildingBlocks/ChirpedWeilSpectralDecomposition.lean)
- **Axioms:** Zero custom axioms. Strictly depends on core Lean 4 foundational axioms: `[propext, Classical.choice, Quot.sound]`.
- **Primary Definitions and Theorems:**
  - `spectral_upper_bound_of_decomposition`: Derivation of the spectral upper bound hypothesis `ChirpedSpectralUpperBound Q_spec C_crit M b d` from the decomposition $Q_{\text{spec}} \le Q_{\text{crit}} + Q_{\text{cont}} - E_{\text{pair}}$.
  - `pair_energy_product_eq`: Verification of the off-line zero quadruplet coherent energy product identity with target exponent $\mu = 2d$.

## 2. Formalized Theorems and Types

```lean
/-- Derivation of `ChirpedSpectralUpperBound` from the three constituent spectral bounds:
critical line zero bound, continuous background bound, and off-line pair energy lower bound. -/
theorem spectral_upper_bound_of_decomposition
    {Q_spec Q_crit Q_cont E_pair : ℝ → ℝ} {C_crit M b d : ℝ}
    (h_decomp : ∀ᶠ (T : ℝ) in atTop, Q_spec T ≤ Q_crit T + Q_cont T - E_pair T)
    (h_crit : ∀ᶠ (T : ℝ) in atTop, Q_crit T ≤ C_crit * Real.log T)
    (h_cont : ∀ᶠ (T : ℝ) in atTop, Q_cont T ≤ 6 * M)
    (h_pair : ∀ᶠ (T : ℝ) in atTop, 2 * b * T^(2 * d) ≤ E_pair T) :
    ChirpedSpectralUpperBound Q_spec C_crit M b d

/-- The coherent off-line pair energy product identity with target exponent μ = 2 * d. -/
theorem pair_energy_product_eq
    {d a_min η : ℝ} (hd : d ≠ 0) {T : ℝ} (hT : 0 < T) :
    2 * ((a_min^2 / (η * T)) * T^(2 * spanDilation d (2 * d) * d)) =
    2 * amplifiedOfflineCoeff a_min η * T^(2 * d)
```

## 3. Antecedents and Literature Context

In classical analytic number theory (Weil 1952, Bombieri 2000), the spectral side of Weil's explicit formula evaluated on a test function $\Phi$ decomposes into:
$$Q_{\text{spec}}(\Phi) = \sum_{\gamma} |\widehat{\Phi}(i\gamma)|^2 + \text{continuous archimedean terms} - \sum_{\rho} \widehat{\Phi}(\rho - 1/2) \overline{\widehat{\Phi}(1 - \overline{\rho} - 1/2)}$$
Zeros off the critical line enter with an uncompensated negative sign. While this sign convention and qualitative decomposition are standard in the analytic literature without Lean, formalizing the non-asymptotic filter-theoretic bound:
$$Q_{\text{spec}}(T) \le C_{\text{crit}} \log T + 6M - 2b T^{2d}$$
and machine-verifying the extraction of the negative off-line pair energy from the spectral sum has never been formalized in Lean 4 or any other proof assistant.
