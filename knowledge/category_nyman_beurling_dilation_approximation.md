# Category: Nyman-Beurling-Báez-Duarte Step-Dilation Approximation

Type: failed_approach_category
Pattern: Approximating the indicator $\chi_{(0,1)}$ by dilation steps $\sum_{k=1}^N c_k \{k/x\}$ in $L^2(0, 1)$ carries 100% of RH depth ($d_N \to 0 \iff \text{RH}$), while finite-$N$ projections suffer catastrophic Gram matrix ill-conditioning ($\kappa(G_6) \approx 50$) and astronomical scale blindness ($N \ge 10^{6.84 \times 10^{24}}$ to detect Platt-Trudgian verified zeros).
Count: 8

## Entries
| # | Original File | One-line Summary |
|---|---------------|------------------|
| 1 | explorer_r2_L00_N08_shifted_hardy_mellin_rkhs_barrier | Shifted Hardy-Mellin RKHS spectral projection $d_N \to 0$ is circularly equivalent to RH (Báez-Duarte 2003); finite testing ($N \le 100$) suffers astronomical scale blindness ($N \ge 10^{6.84 \times 10^{24}}$ required to reach Platt-Trudgian height); canonical arithmetic candidate $c_k = -\mu(k)$ diverges on $(0, 1/N)$ and hits the sieve parity barrier. |
| 2 | explorer_r2_L00_N09_nyman_beurling_baez_duarte_l2_projection | Proving $d_N \to 0$ unconditionally carries 100% of RH depth; claimed universal lower bound $d_N \ge \sqrt{2\beta_0-1}/|\rho_0|$ is false (counterexample at $\beta_0=0.99, \gamma_0=0.5$ gives $0.8926 > d_6 \approx 0.2342$); pole cancellation fails to force $\sum c_k^*/k = 0$ (empirically $\approx 0.65$); and Gram condition number explodes ($\kappa(G_6) \approx 50$). |
| 3 | explore_merger_r2_L01_N03 | Repaired reproducing kernel lower bound $d_N \ge \frac{|\gamma_0|\sqrt{2\beta_0-1}}{|\rho_0|^2 |\rho_0-1|}$ collapses to $< 1.1 \times 10^{-25}$ for Platt-Trudgian zeros, requiring $N > \exp(4.6 \times 10^{48})$ (vacuous on finite $N$), while Gram condition number explodes exponentially. |
| 4 | explore_merger_r2_L01_N14 | Báez-Duarte distance convergence $d_N \to 0$ carries 100% RH depth; testing $N \le 100$ has 24 orders of magnitude in $\log_{10} N$ Haselgrove scale blindness past Platt-Trudgian height; arithmetic minimizers $c_k = -\mu(k)$ diverge on $(0, 1/N)$ and fail $\sum c_k/k = 0$; and Gram matrix is exponentially ill-conditioned ($\kappa(G_4) \approx 505.1$). |
| 5 | explore_merger_r2_L01_N15 | Hardy-Mellin reproducing kernel spectral barrier $\|f_0 - g\| \ge \sqrt{2(\beta_0-1/2)}/|\rho_0|$ only proves contrapositive not-RH $\implies \liminf d_N > 0$; proving $d_N \to 0$ unconditionally has zero forward machinery; finite testing has astronomical scale blindness ($N \ge 10^{6.84 \times 10^{24}}$); and backup slit-plane / Hamiltonian routes are refuted. |
| 6 | explore_merger_r2_L02_N02_baez_duarte_bound_collapse | Repaired RKHS lower bound $d_N \ge \frac{|\gamma_0|\sqrt{2\beta_0-1}}{|\rho_0|^2|\rho_0-1|}$ collapses to $< 5 \times 10^{-26}$ for Platt-Trudgian zeros, requiring $N > \exp(4.6 \times 10^{48})$ along logarithmic sieve floor $0.215/\sqrt{\log N}$. |
| 7 | explore_merger_r2_L02_N07_mollified_mobius_neutral_failure | Regularized arithmetic mollifiers $c_k = -\mu(k)(1 - \log k / \log N)^2$ fail the neutral constraint $\sum c_k/k = 0$ completely ($+0.38$ at $N=100$), leaving the pole of $\zeta(s)$ at $s=1$ uncancelled. |

| 8 | explorer_r7_L00_N16 | Vasyunin Gram matrix $G_N$ eigenvalues decay super-exponentially with condition number $\kappa(G_{100}) > 10^{50}$, while an off-line zero $\beta_0 > 1/2$ creates a strictly positive projection floor $d_N \ge c_0 > 0$, rendering unconditional verification of $d_N \to 0$ equivalent to RH with 100% Millennium depth. |
