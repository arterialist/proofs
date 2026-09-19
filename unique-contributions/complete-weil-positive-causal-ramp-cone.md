# Certified complete Weil positivity on the causal ramp cone

**Status:** independently audited written analytic proof with certified Arb interval arithmetic
(18 September 2026). Arithmetic corner rules and ramp prime-power weights are formalized in
[ActualRampPrimeWeights.lean](../formalization/BuildingBlocks/ActualRampPrimeWeights.lean).
Attribution: Arterialist RH research team (RH Agents 1, 2, 3), September 2026.
To the best of our knowledge, the complete Weil form has not previously been proved strictly
positive on the infinite-dimensional cone of positive mixtures of causal ramps.

## Statement

Let $f_L(x) = e^{-x/2} \mathbf{1}_{[0, L]}(x)$ for $L > 0$. Let $Q$ denote the complete actual-zeta
Weil form, retaining all prime powers $\Lambda(p^k) = \log p$, both poles at $s=0, 1$, and the
exact digamma multiplier.

**Theorem.** For every $L, M > 0$:
\[
 \boxed{\quad
 Q(f_L, f_M) > 0.0024 \min\{L, M, 1\} > 0.
 \quad}
\]
Consequently, every nonzero finite positive Borel measure $\mu$ with compact support in $(0, \infty)$
generates a profile $f_\mu(x) = \int_0^\infty f_L(x)\,\mu(dL) = e^{-x/2} h(x) \mathbf{1}_{x \ge 0}$,
where $h(x) = \mu([x, \infty))$ is nonnegative and nonincreasing, satisfying
\[
 \boxed{\quad
 Q(f_\mu) > 0.0024 \int_0^1 h(t)^2\,dt > 0.
 \quad}
\]
This proves unconditional coercivity on this infinite-dimensional cone of profiles of arbitrary support.

## Mathematical mechanism and verification

The parameter plane $0 < L \le M < \infty$ is partitioned into five overlapping certified regions:
1. **Short-ramp region ($0 < L \le 2/25$, any $M \ge L$):** Certified bound $Q > 0.02647 L$ via
   digamma expansion and prime tail bounds.
2. **Middle-box region ($2/25 \le L \le 7$, $0 \le M - L \le 6$):** Certified bound $Q > 0.005$ via
   a rigorous covering of 56,379 rectangular boxes evaluated using Arb interval arithmetic in
   [certificates/mixed_ramp_middle_arb_certificate.py](../certificates/mixed_ramp_middle_arb_certificate.py).
3. **Transition region ($2/25 \le L \le 7$, $M - L \ge 6$):** Certified bound $Q > 0.0050526$.
4. **Intermediate region ($7 \le L \le 10$, any $M \ge L$):** Certified bound $Q > 0.0024486$.
5. **High-support region ($L \ge 10$, any $M \ge L$):** Certified bound $Q > 0.0086$.

Full proof: [building-blocks/weil-and-spectral/complete-weil-positive-causal-ramp-cone.md](../building-blocks/weil-and-spectral/complete-weil-positive-causal-ramp-cone.md).
Formalization: [formalization/BuildingBlocks/ActualRampPrimeWeights.lean](../formalization/BuildingBlocks/ActualRampPrimeWeights.lean).
Certificates: [certificates/mixed_ramp_middle_arb_certificate.py](../certificates/mixed_ramp_middle_arb_certificate.py).
