# Category: Unsmoothed Comparison Function Oscillation

Type: failed_approach_category
Pattern: While smoothed or integrated comparison functions (such as the causal successor $W_b$) satisfy positive cumulative inequalities, the unsmoothed differences oscillate infinitely often across zero due to critical-line zero residues.
Count: 6

## Entries
| # | Original File | One-line Summary |
|---|---------------|------------------|
| 1 | node_03_unsmoothed_difference_oscillation | While the 3-fold integrated difference $I^3(W_b - W) > 0$, the unsmoothed difference $W_b - W$ oscillates infinitely often due to a certified pole at the first zero $\gamma_0 \approx 14.1347$. |
| 2 | node_05_pointwise_successor_domination | Attempting to prove $W(x) \le W_b(x)$ pointwise fails because the unsmoothed difference $W_b - W$ oscillates indefinitely across zero. |
| 3 | node_06_arb_certified_successor_oscillation | Rigorous 256-bit Arb interval arithmetic confirms that the unsmoothed difference $W_b - W$ changes sign infinitely often, precluding pointwise comparison. |
| 4 | node_08_mellin_residue_truncation_error | Asserting finite convergence $H(1/2) \approx 76.4$ ignored the double pole of $H(s)$, generating false residue approximations that fail to match true oscillation dynamics. |
| 5 | node_22_wrong_sided_successor_bound | Cumulative successor comparison $\int_1^x (\log(x/y))^2 (W(y)-W_b(y))y^{-3} dy > 0$ gives a lower bound on $W$ (wrong-sided for $W \le 0$), while $W_b - W$ oscillates across zero. |
| 6 | node_24_successor_pointwise_violation | Transferring positivity of integrated causal successor $I^3(W_b - W) > 0$ to pointwise domination fails because unsmoothed difference oscillates with pole residue $\approx 0.00957$ at $\gamma_0 \approx 14.1347$. |

