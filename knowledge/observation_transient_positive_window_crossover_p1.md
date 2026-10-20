# Transient Positive Window and Macroscopic Sign Crossover of $W(x)$

Type: observation
Confidence: high
Source: Candidates 00, 01, 02, 03, 04, 05, 06, 07 (Level 0)
Relevant to: Finite verification and numerical bounds for Frontier 1

## Statement
The critical arithmetic observable $W(x) = \sum_{d \le x} \sqrt{d} V(x/d)$ is strictly positive on the initial interval $[1, 184.3097]$, attains a local maximum of $W(100) \approx +989.06$, crosses zero at $x_0 \approx 184.3097$, and remains strictly negative for all tested integers $x \in [185, 3000]$, plunging monotonically to $W(2000) \approx -466710.76$ and $W(3000) \approx -1065025.55$.

## Evidence
- Candidate 00 evaluated $W(x)$ up to $x=2000$, showing $W(184) = +9.7823$, $W(185) = -22.5828$, and continuous descent.
- Candidate 01 and Candidate 02 conducted fine-grid bisection searches, isolating the root at $x_0 \approx 184.309726$ and verifying continuous nonpositivity on $[185, 200]$ with step 0.01.
- Candidate 03 tested dense grids with step 0.5 up to $x=1000$, confirming $W(x) \le -22.58$ for all $x \ge 185$.
- Exact component decomposition at $x=184$:
  $T_*(184) \approx 8521.62$, while $N_*(184) \approx 8531.40$, yielding $N_*(184)/(x^{3/2}\log x) \approx 0.655$.
  The zero-residue sum over the first 100 zeta zeros accounts for only $\approx 0.01995$, showing that the non-diagonal mass $N_*(x)$ at crossover is driven by low-height poles and baseline terms ($s=1/2$ pole contributing $\approx 3.79 x^{3/2}$).

## Implications
1. Any presumption that $W(x) \le 0$ holds globally from $x=1$ is strictly false. The threshold parameter $A$ in `RiemannHypothesis_of_eventually_nonpos` must satisfy $A \ge 185$.
2. The crossover at $x \approx 184.31$ is a macroscopic transition where the cumulative same-prime bias $T_*(x)$ finally overtakes the positive distinct-prime sum $N_*(x)$.
3. Past $x=185$, the ratio $W(x) / (-\frac{1}{6}x^{3/2}\log^2 x)$ climbs monotonically from $0.0302$ at $x=200$ to $0.6067$ at $x=3000$, consistent with convergence to 1.

## Caveats
Numerical verification on $x \le 3000$ cannot rule out sign reversals at astronomical scales if off-critical zeros exist (which must have height $|\gamma| > 3 \times 10^{12}$ and crossover threshold $x > 10^{39}$).
