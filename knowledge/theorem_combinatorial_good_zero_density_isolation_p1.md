# Combinatorial Good Zero Density and Off-Line Isolation

Type: theorem
Confidence: high
Source: Aggregator Nodes L01_N09, L01_N10 (Level 1)
Relevant to: Unconditional zero-free ordinate isolation on the critical line and certifying zero-density bounds against off-line zeros

## Statement
Let $T > T_0$ be sufficiently large, and consider the dyadic window $\mathcal{I}_T = (T, 2T]$. Let $N = N(2T) - N(T)$ denote the total number of non-trivial zeros of $\zeta(s)$ with ordinates in $\mathcal{I}_T$, counted with multiplicity. Let $S \subset \mathcal{I}_T$ denote the set of simple zeros of $\zeta(s)$ lying strictly on the critical line $\operatorname{Re}(s) = 1/2$, satisfying $|S| \ge (\kappa - \varepsilon)N$ for some proportion $\kappa \in (0, 1]$.

Let $B \subset S$ be the subset of "bad" critical zeros sharing an ordinate $\gamma$ with at least one off-line zero $\rho = \beta + i\gamma$ ($\beta \ne 1/2$), and let $Q = S \setminus B$ denote the set of "good" critical zeros whose ordinate is completely free of off-line zeros.

Then the cardinality of $Q$ satisfies the combinatorial lower bound:
$$3|S| \le N + 2|Q|,$$
or equivalently,
$$\frac{|Q|}{N} \ge \frac{3\kappa - 1}{2} - \frac{3\varepsilon}{2}.$$
In particular, whenever $\kappa > 1/3$, $|Q| > 0$. When instantiated with the unconditional simple zero density bound of Alpöge-Furman (2026), $\kappa \ge HD(1) = \frac{3}{2} - \frac{1}{\sqrt{2}}\cot(1/\sqrt{2}) \approx 0.6725007 > 2/3$, the density of good zeros satisfies:
$$q_* = \frac{3 HD(1) - 1}{2} \approx 0.50875105 > \frac{1}{2}.$$
Consequently, more than $50.875\%$ of all non-trivial zeros in any dyadic window $(T, 2T]$ above $T_0$ are simple critical-line zeros that are unconditionally isolated and strictly zero-free across the entire open critical strip horizontal segment $\{\sigma + i\gamma \mid \sigma \in (0, 1) \setminus \{1/2\}\}$.

## Proof
1. By the functional equation and Schwarz reflection, if $\rho_0 = \beta_0 + i\gamma_0$ is an off-line zero with $\beta_0 \ne 1/2$ and $\gamma_0 \in \mathcal{I}_T$, then $1 - \bar{\rho}_0 = 1 - \beta_0 + i\gamma_0$ is also a zero of $\zeta(s)$ with identical imaginary part $\gamma_0$.
2. Because $\beta_0 \ne 1/2$, the points $\beta_0 + i\gamma_0$ and $(1 - \beta_0) + i\gamma_0$ are distinct and both lie off the critical line. Hence, every off-line ordinate $\gamma_0$ carries at least two off-line zeros (each of multiplicity at least 1).
3. If a critical-line zero $\gamma \in S$ belongs to $B$, then by definition its ordinate $\gamma$ also hosts at least two off-line zeros in the critical strip.
4. Since the zero on the critical line $\frac{1}{2} + i\gamma$ is simple and distinct from the off-line zeros, the total multiplicity of zeros of $\zeta(s)$ with ordinate $\gamma$ is at least $1 + 2 = 3$.
5. Let $\mathcal{O}$ be the set of distinct zero ordinates in $\mathcal{I}_T$. Partition $\mathcal{O}$ into:
   - $Q$: ordinates of simple critical-line zeros with no off-line zeros. Each ordinate $\gamma \in Q$ contributes at least $1$ to $N$.
   - $B$: ordinates of simple critical-line zeros with off-line zeros. Each ordinate $\gamma \in B$ contributes at least $3$ to $N$.
   - $R$: all other zero ordinates (multiple critical zeros, purely off-line zeros without critical zeros). Each ordinate contributes at least $1$ to $N$.
6. Summing zero counts with multiplicity:
   $$N \ge 1 \cdot |Q| + 3 \cdot |B| + 1 \cdot |R| \ge |Q| + 3|B|.$$
7. Since $|S| = |Q| + |B|$, we have $|B| = |S| - |Q|$. Substituting into the inequality yields:
   $$N \ge |Q| + 3(|S| - |Q|) = 3|S| - 2|Q|.$$
8. Rearranging gives $2|Q| \ge 3|S| - N$, or $3|S| \le N + 2|Q|$.
9. Dividing by $N$ and substituting $|S|/N \ge \kappa - \varepsilon$:
   $$\frac{|Q|}{N} \ge \frac{3|S|/N - 1}{2} \ge \frac{3\kappa - 1}{2} - \frac{3\varepsilon}{2}.$$
10. Evaluating with $\kappa \ge 0.6725007$:
    $$\frac{3(0.6725007) - 1}{2} = \frac{2.0175021 - 1}{2} = 0.50875105 > 0.5.$$

## Hypotheses / Conditions
- $T > T_0$ dyadic window $(T, 2T]$ above the threshold where the simple zero density $\kappa$ holds.
- Simple zero lower bound $|S| \ge (\kappa - \varepsilon)N$ on the critical line (e.g. Levinson, Conrey, or Alpöge-Furman).
- Functional equation reflection symmetry of non-trivial zeros across $\operatorname{Re}(s) = 1/2$.

## How It Applies
This result provides an unconditional lower bound on the density of critical-line ordinates that are guaranteed to have no off-line zeros anywhere on their horizontal lines. It proves that any hypothetical off-line zeros cannot occupy more than $< 49.125\%$ of spectral ordinates, certifying majority zero-free horizontal slices.

## Caveats
- This theorem does NOT rule out off-line zeros on the remaining $< 49.125\%$ of ordinates, nor off-line zeros in the gaps between critical zeros.
- Proving $|Q| = |S|$ (i.e., that $B = \emptyset$) carries the full depth of the Riemann Hypothesis.
- The bound guarantees ordinate isolation ($B = \emptyset$ on $Q$), but does not establish global zero-freeness off the critical line without external mechanisms.
