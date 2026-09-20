# Non-asymptotic divisor sums on square-root denominators and Farey boundary mass bounds: Lean 4 formalization

**Status:** machine-checked in Lean 4.24.0.
Lean modules:
- [formalization/BuildingBlocks/CyclotomicBoundarySums.lean](../../formalization/BuildingBlocks/CyclotomicBoundarySums.lean)
- [formalization/BuildingBlocks/CyclotomicDivisorPairs.lean](../../formalization/BuildingBlocks/CyclotomicDivisorPairs.lean)

Attribution: Arterialist RH research team, September 2026.
Foundational axioms: standard Lean 4 foundations only (`[propext, Classical.choice, Quot.sound]`), zero custom axioms.

## Statement

Let $\tau(n) = |\{d \in \mathbb{N} : d \mid n\}|$ be the number of divisors of $n$, and let $H_X = \sum_{n=1}^X \frac{1}{n}$ be the $X$-th harmonic number.

**Theorem (Divisor Sums on Square-Root Denominators and Farey Mass Bounds).**
1. **Telescoping Square-Root Sum:** For any $X \in \mathbb{N}$:
   \[
    \sum_{n=1}^X \frac{1}{\sqrt{n}} \le 2\sqrt{X}.
   \]
2. **Divisor Sum on Square-Root Denominator:** For any $X \in \mathbb{N}$:
   \[
    \sum_{n=1}^X \frac{\tau(n)}{\sqrt{n}} \le 2\sqrt{X} H_X.
   \]
3. **Small-Conductor Mass Cost Bound:** If $\operatorname{cost}(n) \le \tau(n) L \operatorname{mass}(n)$ with $\operatorname{mass}(n) \le 1$ for $n \le 2Y$ and $\operatorname{mass}(n) \le 2Y/n$ for $n > 2Y$, then:
   \[
    \sum_{n=1}^X \operatorname{cost}(n) \le 2 Y L H_X (1 + H_X).
   \]
4. **Recent-Conductor Moving-Band Cost Bound:** If $\operatorname{cost}(n) \le \tau(n) L \operatorname{mass}(n)$ with $\operatorname{mass}(n) \le \frac{2 H_n}{\sqrt{n}}$, then:
   \[
    \sum_{n=1}^X \operatorname{cost}(n) \le 4 \sqrt{X} H_X^2 L.
   \]
5. **Logarithmic Cost Specialization:** With pointwise cost $\operatorname{cost}(n) \le \tau(n) \log(n) \operatorname{mass}(n)$:
   \[
    \sum_{n=1}^X \operatorname{cost}(n) \le 4 \sqrt{X} H_X^2 \log X.
   \]

## Mathematical Proof Overview

1. **Discrete Induction:** The square-root bound $\sum_{n=1}^X \frac{1}{\sqrt{n}} \le 2\sqrt{X}$ is proved by discrete induction using the inequality $\frac{1}{\sqrt{X+1}} \le 2(\sqrt{X+1} - \sqrt{X})$, verified by clearing denominators and observing $( \sqrt{X+1} - \sqrt{X} )^2 \ge 0$. No improper integration or real analysis limit is needed.
2. **Divisor Pair Involution:** By regrouping pairs $(a, b)$ with $ab = n \le X$:
   \[
    \sum_{n=1}^X \frac{\tau(n)}{\sqrt{n}} = \sum_{a=1}^X \frac{1}{\sqrt{a}} \sum_{b=1}^{\lfloor X/a \rfloor} \frac{1}{\sqrt{b}} \le \sum_{a=1}^X \frac{1}{\sqrt{a}} \left( 2\sqrt{\frac{X}{a}} \right) = 2\sqrt{X} \sum_{a=1}^X \frac{1}{a} = 2\sqrt{X} H_X.
   \]
3. **Farey Partition Application:** In the two-boundary cyclotomic reduction (`CyclotomicBoundaryBridge.lean`), this supplies the unconditional upper bounds on small-conductor and recent-conductor boundary interaction energy, controlling the non-interior cost by $O(\sqrt{X} \log^3 X)$.

## Formalization Notes

- Machine-checked in `BuildingBlocks.CyclotomicBoundarySums`.
- Verified theorems:
  - `inv_sqrt_sum_le_two_sqrt`
  - `divisorCard_inv_sqrt_sum_le`
  - `small_mass_cost_bound`
  - `recent_mass_cost_bound`
  - `small_mass_log_cost_bound`
  - `recent_mass_log_cost_bound`
- Relies exclusively on `propext`, `Classical.choice`, and `Quot.sound`.
