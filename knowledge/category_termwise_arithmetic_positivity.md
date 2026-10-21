# Category: Termwise Arithmetic Positivity Failure

Type: failed_approach_category
Pattern: Attempting to prove $W(x) \le 0$ by establishing that each individual summand in the arithmetic expansion of $W(x)$ is nonpositive fails because composite divisor brackets are strictly positive.
Count: 12

## Entries
| # | Original File | One-line Summary |
|---|---------------|------------------|
| 1 | node_00_termwise_domination | Termwise nonpositivity fails in the discrete bracket: at $n=36, x=72$, the bracket $2uv - 3(u+v) = +1.9102 > 0$, showing negativity is strictly collective. |
| 2 | node_02_divisor_bracket_positivity | The discrete bracket $L(n)^2 - Q(n) - (1+x/n)L(n)$ takes strictly positive values at composite integers with $\ge 2$ prime factors, refuting term-by-term bounds. |
| 3 | node_06_composite_bracket_failure | At $n=36, x=36$, the discrete bracket evaluates to $+9.4755$, and at $x=72$ to $+1.9102$, confirming failure of termwise covariance domination. |
| 4 | node_07_dropped_discrete_bracket | Attempting to prove $W(x) \le 0$ from elementary prime-power identities dropped the fatal obstacle that composite numbers generate positive counter-terms. |
| 5 | node_12_composite_scaling_positivity | Divisor brackets at $x=2n$ evaluate to positive values across all composite numbers ($n=30: +5.04, n=36: +1.91, n=60: +16.13, n=84: +24.71, n=120: +31.82$). |
| 6 | node_14_highly_composite_bracket_positivity | Covariance brackets evaluate to large positive quantities on numbers with multiple prime factors, confirming that negativity of $W(x)$ requires collective analytic cancellation. |
| 7 | node_22_massive_density_positive_brackets | At $x=200$, exactly 88 out of 199 integers $n \le 200$ (44.2%) have strictly positive brackets $\mathcal{B}(n, 200) > 0$ (e.g. $n=65: +14.188, n=63: +10.335$). |
| 8 | node_23_composite_bracket_obstruction | Discrete bracket at $n=36, x=72$ equals $+1.9102 > 0$, confirming that cancellation across composite and prime-power integers is essential. |
| 9 | node_L01_N06_composite_bracket_density_failure | Divisor bracket at $n=36, x=72$ equals $+1.9102 > 0$, and 105 of 139 composite integers (75.54%) in $[2, 200]$ have positive brackets at $x=2n$, proving termwise nonpositivity is mathematically unachievable. |
| 10 | node_L01_N12_composite_bracket_universal_positivity | In the divisor expansion $W(x) = B_*(x) + \sum_{n \le x} \frac{x-n}{\sqrt{n}} [L(n)^2 - Q(n) - (1+x/n)L(n)]$, 139 of 139 (100.0%) composite numbers with $\ge 2$ prime factors up to $n=200$ have strictly positive brackets at $x=2n$ (e.g. $+31.82$ at $n=120$), refuting termwise nonpositivity. |
| 11 | node_L02_N06_composite_bracket_density_barrier | Termwise nonpositivity of divisor brackets is false at 105 of 139 composite numbers $\le 200$ (75.54%), confirming that negativity of $W(x)$ is an inherently collective spectral phenomenon requiring massive arithmetic cancellation between prime powers and composites. |
| 12 | explore_merger_r2_L01_N07 | Li coefficient arithmetic formula $\lambda_n = \sum_{j=1}^n \binom{n}{j} b_j$ suffers catastrophic alternating binomial cancellation ($10^{26.6}$ at $n=100$, $10^{146}$ at $n=500$), precluding termwise bounds, while proposed positive Laplace-Stieltjes measure is refuted by strict convexity ($\Delta^2 \lambda_1 = +0.04604 > 0$). |

