# Category: Renewal Feedback Neutral Boundary Contact and Loss of Coercivity

Type: failed_approach_category
Pattern: Proving stability for the causal renewal equation $(\mathcal{Z}b)(v) = f(v)$ fails because every critical-line zero has transfer function $T(i\gamma) = -1$ (neutral boundary contact), ruling out strict small-gain bounds $\|\mathcal{T}\| < 1$, while high-frequency modes cancel damping on the first cell.
Count: 7

## Entries
| # | Original File | One-line Summary |
|---|---------------|------------------|
| 1 | node_00_causal_renewal_arch_cancellation | Euler discrepancy memory kernel $\tilde{J}(u)$ cancels nominal damping on the first cell ($T < \log 2$), and neutral boundary contact $T(i\gamma) = -1$ prevents global small-gain bounds. |
| 2 | node_01_mobius_total_variation_loss | Unrestricted Möbius inversion $\mathcal{Z}^{-1} = \sum \mu(m) m^{-1/2} T_{\log m}$ loses the critical scale due to total variation growth $\sum_{m \le X} m^{-1/2} \asymp X^{1/2}$. |
| 3 | node_02_renewal_boundary_contact | At every critical-line zero $\rho = 1/2 + i\gamma$, the renewal transfer function satisfies $T(i\gamma) = -1$, ruling out any strict operator-norm contraction $\|\mathcal{T}\| < 1$. |
| 4 | node_03_renewal_small_gain_failure | Strict small-gain stability fails because non-negative Lyapunov methods cannot distinguish critical-line zeros from off-line zeros without phase cancellation. |
| 5 | node_06_renewal_high_frequency_cancellation | Centered Euler discrepancy $J(u) - \ell$ changes sign (limiting values $-1/12$ and $+1/24$), and high-frequency modes $e^{i\omega v}$ cancel nominal damping on the first cell $T < \log 2$. |
| 6 | node_13_passivity_negativity_and_forcing_resonance | Preconditioned Euler discrepancy Fourier transform $M(\omega) < 0$ on $\omega \in [10, 14]$ ($M(12) \approx -0.05516$), destroying passivity, while forcing residue at zeta zeros is $-\Gamma(\rho) \ne 0$. |
| 7 | node_L02_N01_feedback_neutral_boundary_passivity_loss | Renewal operator formulation $(\mathcal{Z}b)(v) = f(v)$ fails small-gain contraction because transfer function $T(i\gamma) = -1$ at every zeta zero, while preconditioned kernel Fourier transform $M(\omega)$ violates passivity on $\omega \in [10, 14]$ ($M(12) \approx -0.05516 < 0$). |
