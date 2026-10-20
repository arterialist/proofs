# Deterministic Same-Prime Aggregated Asymptotic

Type: theorem
Confidence: high
Source: Candidates 00, 01, 02, 03, 04, 05, 06, 07 (Level 0), Aggregator Nodes L01_N01, L02_N00, L02_N05 (Levels 1-2), Master Aggregator L04_N00 (Level 4)
Relevant to: Macroscopic negative drift in Frontier 1 Critical Sign Criterion

## Statement
Let $T(u) = \sum_{p^k \le u, k \ge 2} (u - p^k)(k - 1)(\log p)^2$ for $u \ge 1$, and let $T_*(x) = \sum_{d \le x} \sqrt{d} \, T(x/d)$.
Then unconditionally as $x \to \infty$:
$$T_*(x) = \frac{1}{6} x^{3/2} \log^2 x - A_2 x^{3/2} \log x + O(x^{3/2})$$
where $A_2 = -\frac{1}{3}\gamma_0 + \frac{8}{9} \approx +0.696484$, and $\gamma_0 \approx 0.57721566$ is the Euler-Mascheroni constant.
Consequently, the same-prime diagonal term enters $W(x) = N_*(x) - T_*(x)$ with an unconditional two-term negative drift:
$$-T_*(x) = -\frac{1}{6} x^{3/2} \log^2 x + A_2 x^{3/2} \log x + O(x^{3/2}).$$

## Proof
1. **Prime Power Isolation**: In $T(u)$, terms with $k \ge 3$ satisfy $p \le u^{1/3}$, contributing:
   $$\sum_{k \ge 3} \sum_{p \le u^{1/k}} u (k-1)(\log p)^2 \ll u \cdot u^{1/3} \log u = O(u^{4/3} \log u) = o(u^{3/2}).$$
2. **Square Term Evaluation ($k=2$)**: For $k=2$, $k-1=1$ and $p^2 \le u \iff p \le \sqrt{u}$.
   By the quantitative Prime Number Theorem with two main terms, $\sum_{p \le y} (\log p)^2 = y\log y - y + O(y \exp(-c\sqrt{\log y}))$.
   Applying Stieltjes partial integration to $T_2(u) = \sum_{p \le \sqrt{u}} (u - p^2)(\log p)^2$:
   $$T_2(u) = \int_1^{\sqrt{u}} (u - y^2) d\left(\sum_{p \le y}(\log p)^2\right) = 2 \int_1^{\sqrt{u}} y (y\log y - y) dy + O(u^{3/2} e^{-c\sqrt{\log u}}).$$
   Evaluating the integral exactly (verified symbolically via SymPy in Level 4):
   $$2 \int_1^{\sqrt{u}} (y^2 \log y - y^2) dy = 2 \left[ \frac{y^3}{3}\log y - \frac{4}{9}y^3 \right]_1^{\sqrt{u}} = \frac{1}{3} u^{3/2}\log u - \frac{8}{9} u^{3/2} + \frac{8}{9}.$$
3. **Square-Root Divisor Aggregation**: Aggregating over all $d \le x$ with weight $\sqrt{d}$:
   $$T_*(x) = \sum_{d \le x} \sqrt{d} \, T_2(x/d) = \frac{x^{3/2}}{3} \sum_{d \le x} \frac{\log(x/d)}{d} - \frac{8}{9} x^{3/2} \sum_{d \le x} \frac{1}{d} + O(x^{3/2}).$$
4. **Harmonic and Logarithmic Divisor Sums**:
   By Euler-Maclaurin summation:
   $$\sum_{d \le x} \frac{1}{d} = \log x + \gamma_0 + O(1/x)$$
   $$\sum_{d \le x} \frac{\log d}{d} = \frac{1}{2}\log^2 x + \gamma_1 + O\left(\frac{\log x}{x}\right)$$
   Therefore:
   $$\sum_{d \le x} \frac{\log(x/d)}{d} = \log x \sum_{d \le x} \frac{1}{d} - \sum_{d \le x} \frac{\log d}{d} = \frac{1}{2}\log^2 x + \gamma_0 \log x + O(1).$$
5. **Combining Two-Term Asymptotic**:
   Substituting these sums:
   $$T_*(x) = \frac{x^{3/2}}{3} \left( \frac{1}{2}\log^2 x + \gamma_0 \log x \right) - \frac{8}{9} x^{3/2} (\log x) + O(x^{3/2}) = \frac{1}{6} x^{3/2} \log^2 x - \left( -\frac{1}{3}\gamma_0 + \frac{8}{9} \right) x^{3/2} \log x + O(x^{3/2}).$$
   This exactly matches the Mellin triple-pole Laurent expansion result $A_2 = -\frac{1}{3}\gamma_0 + \frac{8}{9} \approx +0.696484$.

## Hypotheses / Conditions
- Quantitative Prime Number Theorem with standard error term.
- Definitions of $T(u)$ and square-root aggregation $T_*(x)$.

## How It Applies
This theorem establishes the macroscopic negative drift that separates Frontier 1 from classical failed sign criteria (Pólya, Turán, Mertens). In Pólya/Mertens, sums have mean zero and oscillate symmetrically due to pure zero modes. In Frontier 1, $W(x)$ possesses an unconditional negative deterministic bias $-\frac{1}{6}x^{3/2}\log^2 x + A_2 x^{3/2}\log x$.
The positive subleading coefficient $A_2 \approx +0.6965$ counteracts the negative drift for small and moderate $x$, explaining the zero-crossing at $x \approx 184.31$. Under RH, oscillatory zero modes scale as $O(x^{3/2}\log x)$, which is strictly dominated by $\log^2 x$, trapping $W(x)$ below 0 for all sufficiently large $x$.

## Caveats
Earlier candidate drafts contained two compensating derivation errors: Method A dropped $\gamma_0 \log x$ from the divisor sum, while Method B inserted an extra factor of $1/(s+1)$ in the residue. In Level 3 drafts, an evaluation error asserted $\int_0^1 (1-t^2)\log t \, dt = -2/9$ instead of $-8/9$, creating an apparent discrepancy between arithmetic and complex methods. In Level 4 synthesis, the Abel integral was rigorously calculated and confirmed via SymPy as $\frac{1}{3} u^{3/2}\log u - \frac{8}{9} u^{3/2} + \frac{8}{9}$, conclusively proving that arithmetic summation and complex Laurent calculus yield the identical subleading coefficient $A_2 = -\frac{1}{3}\gamma_0 + \frac{8}{9} \approx +0.696484$.
Dominance over the fluctuating bilinear term $N_*(x)$ requires $N_*(x) = o(x^{3/2}\log^2 x)$, which remains open unconditionally.

