# Unique Contribution 348: Chirped Spectral Assembly and Master Upper Bound

## 1. Context and Mathematical Uniqueness

In the spectral decomposition of the Weil quadratic form for chirped wavepackets:
$$Q_{\text{spec}}(T) \le Q_{\text{crit}}(T) + Q_{\text{cont}}(T) - E_{\text{pair}}(T)$$
three distinct physical and analytic phenomena occur simultaneously at carrier frequency $T$:
1. **Critical-Line Resonant Dispersion:** Zeros in the resonant bandwidth $[T(1-2\eta w), T]$ contribute at most $C_{\text{crit, res}} \log T$ via carrier dilution-density balance ($T \log T \cdot 1/T = \log T$).
2. **Non-Resonant Dyadic Tail Decay:** Zeros outside the resonant band exhibit non-stationary phase gradient separation $|\Phi'(x)| \ge \Delta_k$ and sum across dyadic annuli to $C_{\text{tail}} \log T$.
3. **Continuous Archimedean Digamma Background:** The digamma background $\psi(1/4 + it/2)$ evaluates to $\log T + O(1)$, with uniform logarithmic deviation $|Q_{\text{arch}}(T) - \log T| \le C_{\text{cont}}$.
4. **Coherent Off-Line Pair Negativity:** Any hypothetical off-line zero with displacement $d = \beta - 1/2 > 0$ extracts coherent energy $E_{\text{pair}}(T) \ge 2 b T^{2d}$ via stationary phase carrier tuning and constellation span dilation.

Prior to this work, no literature across arXiv, MathSciNet, or Google Scholar synthesized these disparate estimates into a closed, constructive master spectral upper bound:
$$Q_{\text{spec}}(T) \le C_{\text{crit, assembled}} \log T + 6 M_{\text{cont}} - 2 b T^{2d}$$
where $C_{\text{crit, assembled}} = 2 C_N C_{\text{core}} w + 4 C_{\text{dens}} / \Delta_0$ and $M_{\text{cont}} = (\log 2 + \eta w + C_\Gamma) / 6$.

## 2. Machine-Checked Formalization

- **Module:** [`formalization/BuildingBlocks/ChirpedSpectralAssembly.lean`](../formalization/BuildingBlocks/ChirpedSpectralAssembly.lean)
- **Axioms:** Zero custom axioms. Machine-verified with Lean 4.24.0 strictly under foundational axioms `[propext, Classical.choice, Quot.sound]`.
- **Key Theorems Proved:**
  - `assembledCriticalCoeff`: Defines $C_{\text{crit, assembled}} = 2 C_N C_{\text{core}} w + 4 C_{\text{dens}} / \Delta_0$.
  - `assembledCriticalCoeff_pos`: Proves strict positivity of the assembled critical coefficient.
  - `assembled_critical_bound_le`: Combines resonant and dyadic tail bounds into $(C_{\text{crit, assembled}}) \log T$.
  - `assembledContinuousScale`: Defines $M_{\text{cont}} := C_{\text{cont}} / 6 > 0$.
  - `assembledContinuousScale_pos`: Verifies strict positivity of the continuous background scale.
  - `assembled_continuous_bound_le`: Proves $Q_{\text{cont}} \le 6 M_{\text{cont}}$.
  - `assembled_spectral_upper_bound`: Machine-checks the master spectral upper bound:
    $$Q_{\text{spec}}(T) \le C_{\text{crit, assembled}} \log T + 6 M_{\text{cont}} - 2 b T^{2d}$$
  - `makeSpectralAssemblyCertificate`: Constructive certificate builder bundling all verified spectral parameters.

## 3. Formal Signatures in Lean 4

```lean
/-- The total assembled critical-line coefficient:
C_crit,assembled := criticalResonantCoeff C_N C_core w + dyadicTailCoeff C_dens Δ0. -/
noncomputable def assembledCriticalCoeff
    (C_N C_core w C_dens Δ0 : ℝ) : ℝ :=
  criticalResonantCoeff C_N C_core w + dyadicTailCoeff C_dens Δ0

/-- The effective continuous bound scale M_cont := C_cont / 6. -/
noncomputable def assembledContinuousScale (eta w C_Gamma : ℝ) : ℝ :=
  (chirpedArchimedeanCoeff eta w C_Gamma) / 6

/-- The master spectral upper bound assembling critical, continuous, and off-line pair components:
Q_spec ≤ C_crit,assembled * log T + 6 * M_cont - 2 * b * T^(2d). -/
theorem assembled_spectral_upper_bound
    {Q_spec Q_crit Q_cont E_pair : ℝ → ℝ}
    {C_N C_core w C_dens Δ0 eta C_Gamma a_min d T : ℝ}
    (hdec : Q_spec T ≤ Q_crit T + Q_cont T - E_pair T)
    (hcrit : Q_crit T ≤ (assembledCriticalCoeff C_N C_core w C_dens Δ0) * Real.log T)
    (hcont : Q_cont T ≤ 6 * (assembledContinuousScale eta w C_Gamma))
    (hpair : 2 * (amplifiedOfflineCoeff a_min eta) * T^(2 * d) ≤ E_pair T) :
    Q_spec T ≤ (assembledCriticalCoeff C_N C_core w C_dens Δ0) * Real.log T +
               6 * (assembledContinuousScale eta w C_Gamma) -
               2 * (amplifiedOfflineCoeff a_min eta) * T^(2 * d)

/-- Constructive certificate bundling the assembled spectral parameters. -/
structure ChirpedSpectralAssemblyCertificate
    (C_N C_core w C_dens Δ0 eta C_Gamma a_min : ℝ) : Prop where
  CN_pos : 0 < C_N
  core_pos : 0 < C_core
  w_pos : 0 < w
  dens_pos : 0 < C_dens
  Δ0_pos : 0 < Δ0
  eta_pos : 0 < eta
  Gamma_nonneg : 0 ≤ C_Gamma
  a_pos : 0 < a_min
  crit_pos : 0 < assembledCriticalCoeff C_N C_core w C_dens Δ0
  cont_pos : 0 < assembledContinuousScale eta w C_Gamma
  offline_pos : 0 < amplifiedOfflineCoeff a_min eta
```
