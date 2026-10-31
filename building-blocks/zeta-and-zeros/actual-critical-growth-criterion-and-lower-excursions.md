# One-sided growth criteria for the actual critical sum, and its unconditional lower excursions

**Status.** Ten Lean 4 theorems, machine-checked under Lean 4.34.1 and Mathlib `d13f23b7` with only `propext`, `Classical.choice`, `Quot.sound`. Five are conditional implications toward RH with an explicitly weaker premise than the existing sign criterion. Five are unconditional, including the sharp two-sided constant $-1/6$.

Lean modules: [`ActualCriticalGrowthCriterion.lean`](../../formalization/BuildingBlocks/ActualCriticalGrowthCriterion.lean), [`ActualCriticalLowerExcursion.lean`](../../formalization/BuildingBlocks/ActualCriticalLowerExcursion.lean), [`ActualCriticalMajorantCriterion.lean`](../../formalization/BuildingBlocks/ActualCriticalMajorantCriterion.lean), [`ActualCriticalLogMajorant.lean`](../../formalization/BuildingBlocks/ActualCriticalLogMajorant.lean), [`ActualCriticalLowerMajorant.lean`](../../formalization/BuildingBlocks/ActualCriticalLowerMajorant.lean), [`ActualCriticalSharpConstant.lean`](../../formalization/BuildingBlocks/ActualCriticalSharpConstant.lean), [`PrimePowerLogSeries.lean`](../../formalization/BuildingBlocks/PrimePowerLogSeries.lean), [`ActualCriticalHDoublePole.lean`](../../formalization/BuildingBlocks/ActualCriticalHDoublePole.lean), [`ActualCriticalUpperSharpConstant.lean`](../../formalization/BuildingBlocks/ActualCriticalUpperSharpConstant.lean). Audit: [`ActualCriticalGrowthExcursionAudit.lean`](../../formalization/verification/ActualCriticalGrowthExcursionAudit.lean).

## Objects

$W(x) = \sum_{d \le x} \sqrt{d}\, V(x/d)$ is the actual critical sum of [the sign criterion](actual-critical-sign-criterion.md); it is real-valued. Its Mellin transform continues to $\mathcal{M}_W(s) = M(s)\,(G(s)^2 - H(s))$ with $M(s) = \zeta(s+1/2)/(s(s+1))$, $G(s) = -\zeta'/\zeta(s) - s/(s-1)$ and $H(s) = \sum_p (\log p)^2 p^{-2s}/(1-p^{-s})^2$, and has a pole of order two at every zero $\rho$ of $\zeta$ with $\operatorname{Re}\rho > 1/2$ (`CriticalTransformPoles.filled_pole_at_zeta_zero`).

## Theorems

1. **Upper one-sided growth criterion** (`RiemannHypothesis_of_growth_after`). For every real $C$ and every $A \ge 1$:
   $$\bigl(\forall x > A,\; W(x) \le C\,x^{3/2}\bigr) \implies \text{RiemannHypothesis}.$$
   The eventual-sign criterion is the case $C = 0$.

2. **Lower one-sided growth criterion** (`RiemannHypothesis_of_lower_growth_after`). For every real $C$ and every $A \ge 1$:
   $$\bigl(\forall x > A,\; -C\,x^{3/2} \le W(x)\bigr) \implies \text{RiemannHypothesis}.$$

3. **Unconditional lower excursions** (`not_eventually_lower_growth`, `exists_lower_excursion`). For every real $C$ and every $B$, there is $x > B$ with
   $$W(x) < -C\,x^{3/2}.$$
   Equivalently $\liminf_{x\to\infty} W(x)/x^{3/2} = -\infty$. In particular the premise of theorem 2 never holds, and $W$ is not eventually nonnegative.

4. **Abstract majorant criterion** (`RiemannHypothesis_of_majorant`). Let $g$ be measurable and let $F$ be analytic on $\operatorname{Re} s > 1/2$ with $F(s) = \int_A^\infty g(x)\,x^{-s-2}\,dx$ for $\operatorname{Re} s > 1$. Then $(\forall x > A,\; W(x) \le g(x)) \implies \text{RiemannHypothesis}$. Theorem 1 is the instance $g = C x^{3/2}$.

5. **Main-term majorant** (`RiemannHypothesis_of_log_growth_after`). For every real $C$ and $A \ge 1$:
   $$\bigl(\forall x > A,\; W(x) \le C\,x^{3/2}\log^2 x\bigr) \implies \text{RiemannHypothesis}.$$
   Here $F(s) = C A^{1/2-s}\bigl((\log A)^2/(s-\tfrac12) + 2\log A/(s-\tfrac12)^2 + 2/(s-\tfrac12)^3\bigr)$, computed from the explicit antiderivative $-C x^{1/2-s}\bigl((\log x)^2/(s-\tfrac12)+2\log x/(s-\tfrac12)^2+2/(s-\tfrac12)^3\bigr)$ on the half-line. The premise is now at the exact scale of the RH main term $-\tfrac16 x^{3/2}\log^2 x$.

6. **Abstract lower criterion** (`RiemannHypothesis_of_lower_majorant`). For any majorant datum $g$ as in theorem 4, $(\forall x > A,\; -g(x) \le W(x)) \implies \text{RiemannHypothesis}$.

7. **Abstract unconditional exclusion** (`not_eventually_lower_majorant`). If moreover $(\sigma - 1/2)F(\sigma)$ stays bounded as $\sigma \to 1/2^+$, i.e. the tail transform of $g$ has at most a simple pole at $1/2$, then the premise of theorem 6 fails for some $x > A$. Theorem 3 is the instance $g = C x^{3/2}$. So the scale that separates the two one-sided questions is the pole order of the majorant's transform at $s = 1/2$: a simple pole (order $x^{3/2}$) is excluded unconditionally on the lower side, while the upper side at the triple-pole scale $x^{3/2}\log^2 x$ is RH.

8. **The sharp constant, reduced to the double pole of $H$** (`not_eventually_lower_log_growth_of_HDoublePole`). Assume $(2\sigma-1)^2\,H(\sigma) \to 1$ as $\sigma \to 1/2^+$. Then for every $C < 1/6$ the bound $-C x^{3/2}\log^2 x \le W(x)$ fails for arbitrarily large $x$.

9. **The double pole, hence the sharp constant unconditionally** (`hDoublePole`, `ActualCriticalHDoublePole.not_eventually_lower_log_growth`, `exists_sharp_lower_excursion`). The asymptotic of theorem 8 holds: $(2\sigma-1)^2 H(\sigma) \to 1$. Proof: `PrimePowerLogSeries` shows that $T(w) = \sum_n \Lambda(n)\log n\, n^{-w}$ equals $\operatorname{Re}(\zeta'/\zeta)'(w)$ (Mathlib's $L$-series of $\Lambda$ and termwise differentiation), that $(w-1)^2 T(w) \to 1$ (since $\zeta'/\zeta = U'/U - 1/(s-1)$ with $U(s) = (s-1)\zeta(s)$ analytic and nonzero at $1$), and that $T(w) = \sum_p (\log p)^2 p^{-w} + E(w)$ with $0 \le E(w) \le 8\sum_p(\log p)^2 p^{-2}$ by reindexing prime powers through `Nat.Primes.prodNatEquiv`. Then $\sum_p (\log p)^2 p^{-2\sigma} \le H(\sigma) \le \sum_p (\log p)^2 p^{-2\sigma} + 32\sum_p (\log p)^2 p^{-3/2}$ for $\sigma > 1/2$, and squeezing gives the limit. Consequently, with no hypothesis,
   $$\liminf_{x \to \infty} \frac{W(x)}{x^{3/2}\log^2 x} \le -\frac16,$$
   the constant of the RH main term $-\tfrac16 x^{3/2}\log^2 x$. Under RH the liminf equals $-1/6$, so the theorem is sharp.

10. **The upper constant, and the two-sided theorem** (`not_eventually_upper_log_growth`, `exists_upper_excursion`, `two_sided_sharp_constant`). The upper majorant criterion accepts a negative constant, and following it to the pole at $1/2$ gives $2C + 1/3 \ge 0$ for any eventual bound $W(x) \le C x^{3/2}\log^2 x$. Hence for every $C < -1/6$ and every $B$ there is $x > B$ with $W(x) > C x^{3/2}\log^2 x$. Together with theorem 9, unconditionally,
    $$\liminf_{x\to\infty}\frac{W(x)}{x^{3/2}\log^2 x} \le -\frac16 \le \limsup_{x\to\infty}\frac{W(x)}{x^{3/2}\log^2 x}.$$
    So $W$ either converges to the RH main term $-\tfrac16 x^{3/2}\log^2 x$ in ratio or oscillates around it; by theorem 5 and the explicit formula, the first case is exactly RH.

A byproduct is `riemannZeta_half_ne_zero`: $\zeta(1/2) \ne 0$, obtained from the repository's unconditional bound $\operatorname{Re}\Lambda_0(\sigma) < 2$ on $(1/2,1)$ and continuity of $\Lambda_0$.

## Proofs

Theorems 1 and 2 are the Landau argument of the sign criterion with a different nonnegative measure. The sign hypothesis was used in exactly one place, to make $-W(x)\,x^{-2}\,dx$ a positive measure on $(A,\infty)$. With $(C x^{3/2} - W(x))\,x^{-2}\,dx$ (theorem 1) or $(C x^{3/2} + W(x))\,x^{-2}\,dx$ (theorem 2) the measure is again positive, and its Laplace transform differs from $\mp\mathcal{M}_W$ by the explicit term
$$C\int_A^\infty x^{-s-1/2}\,dx = \frac{C\,A^{1/2-s}}{s-1/2},$$
which is analytic on $\operatorname{Re} s > 1/2$. Landau's theorem forces the abscissa of convergence to be at most $1/2$, the transform continues analytically to $\operatorname{Re} s > 1/2$, and the order-two poles of $\mathcal{M}_W$ at off-line zeros are excluded as before.

Theorem 3 follows the argument of theorem 2 to its singularity at $s = 1/2$. Under the lower bound, the Laplace transform of the positive measure is nonnegative on the real ray $\sigma > 1/2$, and on $(1/2, 1)$ it equals $\mathcal{M}_W(\sigma) + C A^{1/2-\sigma}/(\sigma - 1/2) - (\text{entire initial part})$, using $\zeta(\sigma) \ne 0$ on $(1/2,1)$ (unconditional, `riemannZeta_ofReal_ne_zero_unconditional`). Multiply by $\sigma - 1/2$ and let $\sigma \to 1/2^+$:

- $(\sigma - 1/2) M(\sigma) \to 4/3$ by the residue of $\zeta$ at $1$;
- $G(\sigma)$ stays bounded because $\zeta(1/2) \ne 0$;
- $H(\sigma) \to +\infty$ because $\sum_p (\log p)^2/p$ diverges (from `Nat.Primes.not_summable_one_div`);
- the majorant term is bounded by $|C|$ and the initial part is entire.

So the real part tends to $-\infty$, contradicting nonnegativity. No explicit formula and no information about zeros is used.

## What this does and does not say

The conditional criteria are strictly stronger theorems than the sign criterion, since their premises are weaker. They are still of RH strength: under RH the main term of $W$ is $-\tfrac16 x^{3/2}\log^2 x$, so the upper premise is expected to hold with every $C \ge 0$, while a zero with $\operatorname{Re}\rho > 1/2$ forces excursions of size $x^{\operatorname{Re}\rho + 1}$ of both signs and violates both premises. Nothing here proves either premise.

The unconditional theorem shows an asymmetry: lower excursions of $W$ beyond every multiple of $x^{3/2}$ exist unconditionally, while upper excursions beyond some multiple of $x^{3/2}\log^2 x$ exist if and only if RH fails (the "only if" direction is theorem 5; the "if" direction is the standard explicit-formula argument and is not formalized here). The sign criterion's open premise is therefore exactly a one-sided upper bound; its lower side carries no information.

## Parameter ranges

$C \in \mathbb{R}$ arbitrary (including negative), $A \ge 1$, $B \in \mathbb{R}$ arbitrary. The statements are about $\operatorname{Re} W(x)$; $W$ is real-valued (`ActualCriticalMellin.W_real`).
