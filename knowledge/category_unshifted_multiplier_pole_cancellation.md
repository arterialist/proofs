# Category: Unshifted Multiplier Pole Cancellation

Type: failed_approach_category
Pattern: Aggregating with linear weight $d$ rather than square-root weight $\sqrt{d}$ introduces a factor $\zeta(s)$ into the Mellin transform, which vanishes at zeta zeros and cancels the double pole for multiplicities $m \ge 2$.
Count: 2

## Entries
| # | Original File | One-line Summary |
|---|---------------|------------------|
| 1 | node_00_unshifted_aggregation | Aggregation $\sum d V(x/d)$ multiplies the Mellin transform by $\zeta(s)$, which has a zero of order $m$ at $\rho$, canceling the pole of $G(s)^2$ for $m \ge 2$. |
| 2 | node_03_ordinary_aggregation_cancellation | Unshifted $d^1$ aggregation produces $(s-\rho)^m (s-\rho)^{-2} = (s-\rho)^{m-2}$, failing to preserve the double pole required for the Landau contradiction when $m \ge 2$. |
