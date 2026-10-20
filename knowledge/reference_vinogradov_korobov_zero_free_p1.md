# Vinogradov-Korobov Zero-Free Region and Tail Divergence Against Negative Drift

Type: reference
Confidence: high
Source: Strategy Nodes 16, 20, 23 falser reports (Level 0)
Relevant to: Auditing claims that classical zero-free regions can establish effective cutoffs $A_0$ for $W(x) \le 0$.

## Bibliographic Info
- Authors: I. M. Vinogradov, N. M. Korobov; quantitative constants by Ford (2002), Mossinghoff & Trudgian (2015)
- Title: Trud. Mat. Inst. Steklov (Vinogradov 1958) / Dokl. Akad. Nauk (Korobov 1958)
- Year: 1958
- ArXiv/DOI: Math. Comp. 84 (2015), 1999-2027 (Mossinghoff-Trudgian)
- Theorem/Lemma Number: Theorem 1 (Zero-free region)
- Verified via web search: yes

## Key Result
The Riemann zeta function $\zeta(\sigma+it)$ has no zeros in the region:
$$\sigma \ge 1 - \frac{c}{(\log |t|)^{2/3} (\log \log |t|)^{1/3}} \qquad (|t| \ge 3)$$
This zero-free region yields the classical prime error bound:
$$|\psi(x) - x| \le C x \exp\left(-c (\log x)^{3/5} (\log \log x)^{-1/5}\right)$$

## Hypotheses / Conditions
- $x \ge x_0$, unconditional.

## How It Applies
Used in Strategy Nodes 16, 20, and 23 to test whether contour integration within unconditional zero-free regions can bound the bilinear fluctuation $N_*(x)$ below the deterministic negative drift $T_*(x) \sim \frac{1}{6} x^{3/2} \log^2 x$.
Because the zero-free boundary satisfies $\sigma = 1 - o(1)$, the contour deformation for the double convolution Mellin transform remains restricted to $\Re s = 1 - o(1)$.
This produces an error bound on $N_*(x)$ of order:
$$|N_*(x)| \le C x^2 \exp\left(-c (\log x)^{3/5}\right)$$
Dividing by the deterministic negative drift $T_*(x) = \frac{1}{6} x^{3/2} \log^2 x$:
$$\frac{|N_*(x)|}{|T_*(x)|} \ge \frac{6C x^{1/2} \exp\left(-c (\log x)^{3/5}\right)}{\log^2 x}$$
Because $x^{1/2}$ asymptotically dominates $\exp(c (\log x)^{3/5})$, this ratio diverges monotonically to $+\infty$ as $x \to \infty$:
- At $x = 10^3$: ratio $\approx 0.81$
- At $x = 10^{20}$: ratio $\approx 1.95 \times 10^5$
- At $x = 10^{100}$: ratio $\approx 2.38 \times 10^{40}$
Consequently, unconditional Vinogradov-Korobov error bounds grow faster than the deterministic signal by a factor of $x^{1/2 - o(1)}$, proving that no finite crossover threshold $A_0$ can ever be certified using unconditional zero-free regions.

## Caveats
Unconditional bounds reflect potential off-critical zeros in the bulk of the strip $\Re s \in (1/2, 1-\delta)$. They cannot prove $W(x) \le 0$ because $W(x) \le 0$ is strictly equivalent to RH.
