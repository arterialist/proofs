# Category: Finite Numerical Extrapolation and Off-Critical Blindness

Type: failed_approach_category
Pattern: Extrapolating eventual nonpositivity $\forall x > A, W(x) \le 0$ from finite numerical testing ($x \le 3000$) is mathematically invalid because off-critical zero excursions are suppressed until astronomical scales ($x > 10^{39}$).
Count: 27

## Entries
| # | Original File | One-line Summary |
|---|---------------|------------------|
| 1 | node_00_finite_truncation_blindness | Numerical testing on $x \le 2000$ cannot detect off-critical zero excursions; for $\beta=0.6$, the crossover where $x^{\beta-1/2} > (1/6)\log^2 x$ occurs at $x \approx 1.2 \times 10^{39}$. |
| 2 | node_01_initial_window_neglect | Dismissing sign oscillations based on $x \in [185, 1000]$ ignores that $W(x) > 0$ on $[1, 184]$ and fails to bound higher-height constructive interference. |
| 3 | node_02_integer_sampling_gap | Evaluating $W(x)$ exclusively at integer points misses potential continuous sub-interval excursions on $[184.31, 185]$ without Lipschitz derivative bounds. |
| 4 | node_03_misattributed_crossover | Attributing crossover at $x \approx 184.3$ to $(1/6)\log x$ exceeding zero residue sum $\approx 0.02$ ignores that $N_*(184) \approx 8531$ is 30 times larger than the zero residues. |
| 5 | node_04_finite_threshold_blindness | Numerical verification on $[185, 2000]$ has zero statistical power against off-critical zeros, which are proved by Platt-Trudgian to have height $|\gamma| > 3 \times 10^{12}$. |
| 6 | node_05_unconditional_tail_bound_fallacy | Attempting to bridge finite interval arithmetic on $[185, X_{\max}]$ to infinity via unconditional PNT fails because unconditional error bounds exceed the negative drift by a factor $>100$. |
| 7 | node_11_off_critical_crossover_scale | Precise calculation shows off-critical excursion crossover occurs at $x \approx 10^{30.7}$ for $\beta=0.60$ and $x \approx 10^{68.4}$ for $\beta=0.55$, rendering window $[185, 20000]$ completely blind. |
| 8 | node_15_high_frequency_zero_blindness | Low-height testing cannot detect high-frequency off-critical zero excursions ($\gamma \ge 1000$), where excursion crossover requires $x > 10^{160}$. |
| 9 | node_16_haselgrove_blindness_simulation | Numerical testing on $[185, 2000]$ is subject to Haselgrove blindness: off-critical zeros with $\beta=0.6$ produce excursions $< 0.8\%$ of drift at $x=1000$, masking RH violations until $x > 10^{50}$. |
| 10 | node_17_hallucinated_cutoff_refutation | Hallucinated cutoff $A=16$ refuted: explorer claimed $W(16)=-4.22$, root at $x \approx 15.78$; exact arithmetic proves $W(16)=+139.39$ and $W(x) > 0$ for all integers $x \le 184$, crossing zero at $x \approx 184.28$. |
| 11 | node_18_critical_zero_finite_artifact | Testing $x \le 2000$ only samples critical-line zeros; off-critical zero power excursions $x^{3/2+\eta}$ grow without bound and overtake drift at $x > 10^{60}$. |
| 12 | node_19_undetectable_low_beta_perturbation | At $x=1500$, off-critical zero perturbation at $\beta=0.55$ is only $0.41\%$ of drift, completely undetectable in finite windows. |
| 13 | node_21_compact_window_mertens_fallacy | Testing $x \le 10000$ traverses only $\sim 22$ cycles of the lowest zero; zeros above Platt-Trudgian height $3 \times 10^{12}$ have period $\Delta(\log x) < 2 \times 10^{-12}$, undetectable on $\log x \in [5.3, 9.2]$. |
| 14 | node_22_low_frequency_numerical_mirage | At $x=2000$, $x^{\beta-1/2}/\log^2 x = 0.037$ for $\beta=0.6$, whereas at $x=10^{30}$ it reaches $209.0$. |
| 15 | node_23_short_spectral_window_illusion | $x=2000$ traverses only $\sim 17$ zero periods; Mertens-type small-scale negativity provides zero evidence for asymptotic nonpositivity. |
| 16 | node_24_compact_window_power_blindness | Verification on $[185, 2500]$ is mathematically blind to off-critical excursions; for $\beta=0.6, \gamma=14.13$, crossover occurs at $x \approx 10^{35.8}$, while for $\beta=0.55$ it requires $x \approx 10^{78.8}$. |
| 17 | node_26_spurious_zero_crossing_claim | Claim that $\Re s = 1/2 + \varepsilon$ contour shift crosses critical and off-critical zeros is false since $1/2 < 1/2 + \varepsilon$, while finite testing fails to capture high-ordinate oscillations. |
| 18 | node_27_finite_window_scale_blindness | Rigorous residue calculation shows off-critical excursions with $\beta=0.6$ are suppressed by $1/(|\rho(\rho+1)|)$ and overtake negative drift only at $x > 10^{39}$, invisible on $[185, 3000]$. |
| 19 | node_28_cesaro_finite_window_delusion | Testing Cesàro-smoothed averages $V_2(x) < 0$ on $x \le 2500$ fails to detect off-critical double poles, which dominate only at $x > 10^{40}$. |
| 20 | node_30_astronomical_crossover_threshold | At $x=2000$, off-critical excursion for $\beta=0.55$ constitutes only $0.003\%$ of drift magnitude; numerical nonpositivity cannot detect sub-RH violations. |
| 21 | node_31_platt_trudgian_scale_gap | Above Platt-Trudgian verified height $\gamma \ge 3 \times 10^{12}$, zero residue suppression factor $|\rho(\rho+1)|^{-1} < 10^{-24}$ delays any potential crossover to $x > 10^{250}$, rendering all finite computation blind. |
| 22 | node_L01_N07_subleading_constant_bridge_failure | Finite interval Arb certificate on $[184.31, 2000]$ fails to bridge to the asymptotic regime because $(1/6)\log(2000) = 1.267$ cannot dominate subleading terms without an explicit, proved numerical bound on the $O(x^{3/2}\log x)$ constant $C$ (requiring $x_0 = \exp(6C) \ge 1.63 \times 10^5$ for $C=2.0$). |
| 23 | node_L01_N08_N11_crossover_instability_under_off_critical_zeros | Near the crossover point $x \approx 184.31$, $W(185) = -22.58$ is highly unstable: an off-critical zero at $\beta=0.55, \gamma_1 \approx 14.13$ adds $+59.72$ at $x=185$, flipping $W(185)$ positive to $+37.14$, while remaining completely masked ($< 0.8\%$) at $x \ge 1000$. |
| 24 | node_L02_N01_N06_crossover_instability_under_zeros | Near $x \approx 184.31$, negativity is structurally fragile: an off-critical zero at $\beta=0.55, \gamma \approx 14.1347$ adds $+59.72$ to $W(185) = -22.58$, flipping it positive ($+37.14$), proving finite window testing cannot certify unconditional nonpositivity. |
| 25 | node_L02_N03_platt_trudgian_high_frequency_blindness | Rigorous verification on $[185, 20000]$ is completely blind to potential RH violations above the Platt-Trudgian height $3 \times 10^{12}$: spectral suppression $|\rho(\rho+1)|^{-1} < 10^{-25}$ keeps excursions $< 10^{-24}$ across the entire computational domain, delaying crossover to $x > 10^{263.5}$ for $\beta=0.60$ and $x > 10^{533.1}$ for $\beta=0.55$. |
| 26 | explore_merger_L02_N01_interval_arithmetic_extrapolation_barrier | Backup Route 1 proposing compact interval arithmetic on $[7.465, T_0]$ cannot prove the unbounded target HighFrequencyZeroFree(7.465) without tail bounds, while the ratio deficit bound is wrong-sided by 6.68x at $\gamma_1$. |
| 27 | explore_merger_L02_N04_jensen_d4_finite_extrapolation | Proposing to test the degree-4 Jensen polynomial $J_4^0(X)$ (solved in 1986) cannot extrapolate to $d \ge 5$, while descending GORZ shift $n \ge n_0(d)$ to $n=0$ for all $d$ carries 100% of the unsolved depth of RH. |
