# Knowledge Index

## Failed Approach Categories (167 entries in 13 categories)
| Pattern | Count | Summary | File |
|---------|-------|---------|------|
| sieve_parity_barrier | 31 | Sieve/bilinear identities hit parity barrier and cannot save $x^{1/2}$ on prime convolutions | category_sieve_parity_barrier.md |
| termwise_arithmetic_positivity | 11 | Individual arithmetic summands in $W(x)$ are strictly positive at composite integers (e.g. $n=36$) | category_termwise_arithmetic_positivity.md |
| finite_numerical_extrapolation | 25 | Numerical testing on $x \le 20000$ is completely blind to off-critical zero excursions ($x > 10^{35}$ or $x > 10^{263.5}$) | category_finite_numerical_extrapolation.md |
| unshifted_multiplier_pole_cancellation | 2 | Unshifted $d^1$ aggregation introduces $\zeta(s)$ factor, canceling double poles for multiplicities $m \ge 2$ | category_unshifted_multiplier_pole_cancellation.md |
| goldbach_hard_wall_divergence | 6 | Positive majorants for Goldbach spectral continuation diverge at $\sigma \le 2$ ($c \le 1$), and $c_4^{(3)} < 0$ | category_goldbach_hard_wall_divergence.md |
| renewal_small_gain_neutral_boundary | 7 | Causal renewal transfer function has neutral boundary contact $T(i\gamma) = -1$ at every critical zero | category_renewal_small_gain_neutral_boundary.md |
| unsmoothed_comparison_oscillation | 6 | Unsmoothed comparison differences $W_b - W$ oscillate indefinitely due to critical-line zero poles | category_unsmoothed_comparison_oscillation.md |
| perron_contour_divergence | 16 | Perron inversion contour shifts diverge along zero ordinates or hit $H(s)$ convergence boundary | category_perron_contour_divergence.md |
| conditional_sign_premise_circularity | 23 | Forward deduction from eventual nonpositivity of $W(x)$ carries full RH depth, while formalization attempts suffer dependency bitrot and rely on isolated shadow types | category_conditional_sign_premise_circularity.md |
| threshold_partition_sub_unit_degeneracy | 18 | Parametric threshold partitions $H \le 1$ are mathematically static because $|t| \le 1$ is already unconditionally zero-free, while extension to $H > 1$ fails without unformalized certificates | category_threshold_partition_sub_unit_degeneracy.md |
| tautological_zero_identity_refutation | 9 | Refutation criteria claiming disparity between $\Lambda_0(s)$ and $-1/(s(s-1))$ fail because at actual zeros equality holds tautologically, while along 1D nodal curves $\operatorname{Im}(\xi)=0$ phase equality holds identically | category_tautological_zero_identity_refutation.md |
| herglotz_theta_de_bruijn_newman_barrier | 8 | Herglotz/Pick positivity of $-\Xi_*'/\Xi_*$ carries full RH depth as off-line poles collapse positivity, while backward heat flow hits Rodgers-Tao barrier $\Lambda \ge 0$ and non-vanishing zero spacing fails | category_herglotz_theta_de_bruijn_newman_barrier.md |
| weil_quadratic_autocorrelation_positivity_fallacy | 5 | Dilated chirped wavepackets on Weil explicit formula cannot extract negative quadruplet energy because stationary phase exits support for $T > T_{\mathrm{exit}}$ and autocorrelation cross-terms are positive | category_weil_quadratic_autocorrelation_positivity_fallacy.md |

## Theorems
| File | Confidence | Summary |
|------|------------|---------|
| theorem_landau_singularity_transfer_p1.md | high | Nonnegative tail measure forces convergence abscissa $\sigma_c \le 1/2$ by real singularity barrier |
| theorem_shifted_multiplier_double_pole_preservation_p1.md | high | Shifted multiplier $\zeta(s+1/2)$ is non-vanishing for $\Re s > 1/2$, preserving off-critical double poles |
| theorem_dominant_same_prime_asymptotic_p1.md | high | Deterministic same-prime extraction yields two-term negative drift $-\frac{1}{6} x^{3/2} \log^2 x + A_2 x^{3/2} \log x$ ($A_2 \approx +0.6965$) |
| theorem_bidirectional_critical_sign_equivalence_p1.md | high | Exact equivalence: RH $\iff \exists A \ge 1, \forall x > A, W(x) \le 0$; off-line zeros force two-sided power blowup |
| theorem_triple_pole_drift_origin_p1.md | high | Analytic derivation of two-term negative drift $-\frac{1}{6} x^{3/2} \log^2 x + A_2 x^{3/2} \log x$ ($A_2 \approx +0.6965$) from triple pole $-\frac{1}{3(s-1/2)^3}$ |
| theorem_zero_residue_subleading_magnitude_p1.md | high | Double pole residue $(a_{-2} \log x + a_{-1}) x^{\rho+1}$ has $|a_{-1}|/|a_{-2}| \approx 1.83 - 2.81$ on $\rho_1 \dots \rho_5$, with zero-spacing divergence risk |
| theorem_secular_constructive_resonance_p1.md | high | Self-convolution of off-critical zero modes produces exact secular resonance $\frac{1}{2}t e^{(\beta-1/2)t}\cos(\gamma t)$, amplifying oscillations |
| theorem_riesz_smoothing_double_pole_persistence_p1.md | high | Riesz smoothing preserves off-critical double poles with non-zero residue $\frac{m^2 \zeta(\rho+1/2)}{(\rho-1)^{k+1} \rho(\rho+1)}$ |
| theorem_central_window_pole_isolation_p1.md | high | Central window $|t| \le 1$ around $t=0$ pole of $\zeta(s+1/2)$ integrates to $O(x^{3/2}\log\log x) = o(x^{3/2}\log x)$ |
| theorem_bilateral_offline_reflection_duality_p1.md | high | Involutive functional reflection $s \mapsto 1-s$ bijectively pairs LeftOfflineSupport and RightOfflineSupport, proving LeftOfflineSupport = ∅ ↔ RightOfflineSupport = ∅ ↔ RH while avoiding trivial zeros ($2n+3 \ge 3$) |
| theorem_high_frequency_slice_support_identity_p1.md | high | Stratified Support-Height Duality: HighFrequencyZeroFree(H) ↔ {s ∈ RightOfflineSupport | H < |s.im|} = ∅ ↔ ∀ s ∈ RightOfflineSupport, |s.im| ≤ H for all $H \in \mathbb{R}$ |

## Observations
| File | Confidence | Summary |
|------|------------|---------|
| observation_transient_positive_window_crossover_p1.md | high | $W(x) > 0$ on $[1, 184.3]$ peaking at $x=100$ ($+989.06$), crossing zero at $184.31$, and negative thereafter |
| observation_distinct_prime_convolution_support_p1.md | high | $c(n) \ge 0$ vanishes on all prime powers and on $\omega(n) \ge 3$; strictly positive iff $\omega(n) = 2$ |
| observation_composite_bracket_positivity_density_p1.md | high | Divisor bracket $\mathcal{B}(n, 200) > 0$ on 88 of 199 integers (44.2%), disproving termwise cone nonpositivity |
| observation_off_critical_crossover_horizons_p1.md | high | Off-critical excursions masked ($< 10^{-24}$) on $x \le 20000$; crossover requires $x > 10^{35}$ (low height) or $x > 10^{263.5}$ (Platt-Trudgian zeros) |
| observation_displacement_rigidity_strip_boundary_p1.md | high | Displacement numerator $P(d) = 2d(1/4-d^2)$ strictly positive on critical strip interior $0 < d < 1/2$, zero on boundaries $d \in \{0, 1/2\}$, and negative for $d > 1/2$ |
| observation_subunit_threshold_static_degeneracy_p1.md | high | Low-frequency partitions $H \le 7.465$ are mathematically static because $|t| \le 7.465$ contains zero zeros, while for $H > 7.465$ collapse strictly fails |
| observation_mathlib_zeta_one_nonzero_junk_value_p1.md | high | Mathlib 4 convention sets riemannZeta 1 = 0, creating a non-zero junk value requiring explicit $s \ne 1$ hypotheses to avoid false zero detections |
| observation_resolvent_positive_zero_interference_p1.md | high | Real-zero interference in rational resolvents cancels off-line negative wells for small displacements, precluding local negative dissipation signatures |
| observation_weil_autocorrelation_quadruplet_positivity_p1.md | high | Autocorrelation test functions $\Phi = f * \tilde{f}$ force strictly positive quadruplet cross-terms $2\operatorname{Re}(\hat{g}_+\overline{\hat{g}_-}) > 0$, refuting negative energy extraction |
| observation_calogero_moser_lattice_screening_p1.md | high | Multi-particle Calogero-Moser zero repulsion undergoes lattice screening and zero spacing infimum decays to 0, refuting isolated 2-particle collision thresholds |
| observation_critical_boundary_quadratic_vanishing_p1.md | high | Real coordinate disparity vanishes quadratically $O((\beta-1/2)^2)$ at critical line zeros, and ratio deficit reverses at $\gamma \approx 7.49$ due to $O(1/\gamma)$ vs $O(1/\gamma^4)$ decay |
| observation_completed_zeta_nodal_phase_matching_p1.md | high | Phase ratio equality $\Theta_{\mathrm{int}} = \Theta_{\mathrm{alg}}$ holds identically along continuous 1D nodal curves $\operatorname{Im}(\xi)=0$ throughout the strip and at all actual zeros |
| observation_chirped_wavepacket_support_exit_p1.md | high | Stationary phase point $x_{\mathrm{stat}}(T) \to 1/(2\eta) > w$ exits support for $T > T_{\mathrm{exit}}$, extinguishing zero coupling super-polynomially ($< 5\times 10^{-14}$ at $T=500$) |
| observation_symmetrized_resolvent_off_critical_pole_collapse_p1.md | high | Reflection-invariant mapping $z(s) = s(1-s)$ collapses Herglotz positivity under off-critical poles ($\operatorname{Im}(F) \to -\infty$), while finite critical-zero sampling is blind to off-critical poles |
| observation_conjugate_zero_dissipation_cancellation_p1.md | high | Complex conjugate zero pair dissipation kernels cancel identically on the real axis ($D(s, x) + D(\bar{s}, x) \equiv 0$), precluding symmetric resolvent energy signatures |

## References
| File | Confidence | Summary |
|------|------------|---------|
| reference_widder_laplace_transform_p1.md | high | Widder (1941) Thm 5b: Real boundary singularity of Laplace transforms of non-negative measures |
| reference_montgomery_vaughan_multiplicative_number_theory_p1.md | high | Montgomery & Vaughan (2007) Lemma 15.1 (Landau theorem) and Ch 13 (bilinear sieve limits) |
| reference_platt_trudgian_zero_verification_p1.md | high | Platt & Trudgian (2021) Thm 1: RH verified to height $3 \times 10^{12}$; bounds off-critical sensitivity |
| reference_johnston_yang_explicit_pnt_p1.md | high | Johnston & Yang (2023) Thm 1.1: Explicit PNT bounds $O(x^2 \exp(-c\sqrt{\log x}))$ cannot close tail drift |
| reference_vinogradov_korobov_zero_free_p1.md | high | Vinogradov-Korobov (1958): Zero-free bound $O(x^2 \exp(-c(\log x)^{3/5}))$ diverges vs drift by $x^{1/2-o(1)}$ |
| reference_titchmarsh_zeta_zero_spacing_p1.md | high | Titchmarsh (1986) Section 9.3: Zero-spacing lemma $|T_k - \gamma| \gg 1/\log T_k$ for horizontal Perron contour shifts |
| reference_rodgers_tao_newman_conjecture_p1.md | high | Rodgers & Tao (2020): Proof of Newman's conjecture $\Lambda \ge 0$, establishing the de Bruijn-Newman barrier |

## Node Directions
### Iteration 1, Round 1

**L3/N00**: Frontier 1 shifted-multiplier critical sign equivalence aggregating candidates [0, 3, 6, 1, 4]. Pairs second-order Riesz prime convolution with square-root divisor aggregation $W(x) = \sum_{d \le x}\sqrt{d}V(x/d)$, shifting the exterior multiplier to $\zeta(s+1/2)$ to preserve off-critical double poles via Euler product convergence. Aims to establish bidirectional equivalence $RH \iff W(x) \le 0$ eventually via triple-pole negative drift $-(1/6)x^{3/2}\log^2 x$ dominating zero fluctuations. **Obstacle**: Falser rejected the strategy as an impassable circular equivalence wall: proving $W(x) \le 0$ unconditionally carries the full depth of RH since off-critical zeros induce power oscillations $\Omega_\pm(x^{\beta+1}\log x) \gg x^{3/2}\log^2 x$, causing pipeline paralysis (ready_for_decomposition: false) and strategic goal displacement toward conditional converse formalization.

**L3/N01**: Frontier 1 shifted-multiplier sign equivalence synthesizing [L02_N03, L02_N06, L02_N01, L02_N04, L02_N07]. Establishes forward deduction in Lean 4 via Landau's theorem and shifted multiplier $\zeta(s+1/2)$ preserving off-critical double poles, while driving converse negativity under RH via real triple-pole drift $-(1/6)x^{3/2}\log^2 x$ dominating $O(x^{3/2}\log x)$ fluctuations with $t=0$ pole isolation. **Obstacle**: Decisively rejected: proving $W(x) \le 0$ is strictly equivalent to RH, sieves produce wrong-sided positive quadratic defects $+2.612\varepsilon x^2$, and Section 5 Method A fabricated an algebraic identity to hide a prime-square Abel integration error ($-2/9$ vs $-8/9$), while finite numerics suffer extreme Haselgrove blindness past $x > 10^{263}$.

**L3/N02**: Frontier 1 multiplicity-robust shifted-Mellin sign equivalence synthesizing [1, 4, 7, 2, 5]. Leverages square-root aggregation to place potential off-critical zeros into the zero-free half-plane $\Re(s+1/2) > 1$, ensuring uncancelable double poles for arbitrary multiplicities $m \ge 1$ and proving bidirectional equivalence $RH \iff W(x) \le 0$ eventually via $(1/6)x^{3/2}\log^2 x$ drift domination over $O(x^{3/2}\log x)$ Perron fluctuations under RH. **Obstacle**: Rejected for retaining an undecomposable fatal equivalence blocker (ready_for_decomposition: false) against unanimous child rejections. The converse derivation omits dominant simple-pole residues $a_{-1}$ (2.8x larger than $a_{-2}$ at $\rho_1$) requiring unproved zero-spacing bounds, while positive subleading offset $A_2 = +0.6965$ cancels up to 80% of drift.

**L3/N03**: Multiplicity-robust shifted-Mellin sign equivalence synthesizing [4, 7, 2, 5, 0] on Frontier 1. Employs second-order Riesz prime convolution and square-root aggregation to shift the exterior multiplier to $\zeta(s+1/2)$, preserving off-critical double poles. Under RH, repaired Perron contour shifting with $t=0$ central pole isolation bounds fluctuations by $O(x^{3/2}\log x)$, which is outgrown by the unconditional triple-pole negative drift $-(1/6)x^{3/2}\log^2 x$. **Obstacle**: Decisively rejected: proving $W(x) \le 0$ unconditionally carries the full depth of RH, leaving Active Obligation 0 fatal and undecomposable (ready_for_decomposition: false). Sieve methods fail due to the parity barrier (yielding wrong-sided $+2.612\varepsilon x^2$ defects), classical zero-free bounds diverge by $x^{1/2-o(1)}$, and substituting conditional converse formalization evades the proof mandate.

**L3/N04**: Multiplicity-robust shifted Mellin-Landau critical sign equivalence synthesizing [02, 05, 00, 03, 06]. Establishes the exact bidirectional characterization $RH \iff W(x) \le 0$ eventually by combining Lean-4-verified forward Landau deduction, double-pole preservation on $\Re(s+1/2) > 1$, and deterministic negative drift $-(1/6)x^{3/2}\log^2 x$ from the real triple pole at $s=1/2$ dominating $O(x^{3/2}\log x)$ fluctuations under RH. **Obstacle**: Decisively rejected: the card admits eventual nonpositivity is an undecomposable fatal blocker of full RH depth (ready_for_decomposition: false), defying unanimous child rejections. Sieve majorants produce wrong-sided positive quadratic defects $+2.61\varepsilon x^2$, zero-free bounds diverge as $x^{1/2-o(1)}$, simple-pole residues $a_{-1}$ dominate $a_{-2}$ across the spectrum, and finite testing is blind to off-line zeros by over 260 orders of magnitude.

**L4/N00**: Frontier 1 shifted critical Mellin-Landau master synthesis aggregating candidates [L03_N00 through L03_N04]. Pairs second-order Riesz prime convolution with square-root divisor aggregation $W(x) = \sum_{d \le x} \sqrt{d} V(x/d)$ to shift the multiplier to $\zeta(s+1/2)$, preserving off-critical double poles to trigger machine-checked Landau holomorphy extension. Derives macroscopic negative drift $-\frac{1}{6} x^{3/2}\log^2 x + A_2 x^{3/2}\log x$ from the boundary triple pole at $s=1/2$ with corrected prime-square Abel integration, establishing bidirectional spectral equivalence $RH \iff W(x) \le 0$ eventually. **Obstacle**: Decisively rejected: proving $W(x) \le 0$ unconditionally carries full RH depth against off-critical oscillations $\Omega_\pm(x^{\beta+1}\log x)$, leaving an undecomposable fatal blocker (ready_for_decomposition: false) while sieves yield wrong-sided positive quadratic defects $+2.612\varepsilon x^2$ and converse formalization evades the affirmative proof mandate.

### Root Gate Review (Level 02 Consensus)

**Gate Merger L02/N00**: Root gate review synthesizing all 8 Level-0 feasibility judges and 5 Level-1 gate mergers on Strategy Card L04_N00 (Frontier 1).
- **Consensus Verdict**: Unanimous **REJECT** (`should_decompose: false`, `recommended_action: "restart_exploration"`, `fatal_flaw: true`, `feasibility_verdict: "reject"`, `obligation_severity: "not_applicable"`).
- **Consensus Findings**:
  1. *Equivalence Circularity & Full RH Depth*: The forward reduction $W(x) \le 0 \implies \text{RH}$ is machine-checked in Lean 4 (`BuildingBlocks.ActualCriticalSignCriterion.RiemannHypothesis_of_eventually_nonpos`), but proving eventual nonpositivity unconditionally carries the full analytical depth of RH itself. Landau's two-sided oscillation theorem proves that any off-critical zero $\rho = \beta + i\gamma$ ($\beta > 1/2$) forces power oscillations $\Omega_\pm(x^{\beta+1}\log x)$ that overpower deterministic negative drift $-(1/6)x^{3/2}\log^2 x$ by $\frac{6 x^{\beta-1/2}}{\log x} \to \infty$. Thus $W(x) \le 0$ cannot be proved without already knowing RH.
  2. *Sieve Parity Barrier & Wrong-Sided Defects*: Sieve methods hit Selberg's parity barrier floor $O(x^2/\log^A x)$ and introduce fatal wrong-sided positive quadratic defects $+2.612\varepsilon x^2$ exceeding drift by 15.08x at $x=10^{14}$ for $\varepsilon=10^{-4}$ (growing as $\sqrt{x}/\log^2 x \to \infty$).
  3. *Haselgrove Scale Blindness*: Finite numerical testing on $[185, 20000]$ has zero diagnostic sensitivity against off-critical zeros due to Haselgrove blindness past $x > 10^{263.53}$ for Platt-Trudgian verified zeros ($|\gamma| \ge 3 \times 10^{12}$).
  4. *Goal Displacement*: Pivoting from an affirmative proof of RH to formalizing the conditional converse asymptotic in Lean 4 leaves the forward unconditional debt 100% open while requiring unformalized zero-spacing and Hadamard machinery absent from Mathlib 4.
- **Structural Boundary Classification**: Frontier 1 is formally cataloged as a verified machine-checked bidirectional spectral characterization boundary in Lean 4 (standard axioms `[propext, Classical.choice, Quot.sound]`, 0 custom axioms, 0 `sorry`), but cannot serve as an affirmative proof route. Exploration must restart for alternative non-arithmetic mechanisms.


