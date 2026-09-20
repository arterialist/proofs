# Explicit zeta zero-free region through height 7.465

**Status:** machine-checked in Lean 4.24.0, provisional first-Lean record for this exact explicit region.

Lean module: [`RiemannZetaRatioSurplus.lean`](../formalization/BuildingBlocks/RiemannZetaRatioSurplus.lean)

The theorem

```lean
theorem cumulative_zero_free_to_seven_four_six_five {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 0 < s.im)
    (hsim2 : s.im ≤ 1493 / 200) :
    riemannZeta s ≠ 0
```

proves unconditionally that

$$
\zeta(s) \ne 0
\qquad
\left(\operatorname{Re}(s)>\frac12,\quad
0<\operatorname{Im}(s)\le\frac{1493}{200}=7.465\right).
$$

The module derives this from the preceding formalized low-frequency and ratio-deficit estimates. Its declarations use only Lean's standard foundational axioms. No RH hypothesis or custom analytic axiom appears in the theorem.

This is known mathematics, not a new zero-free region. Platt and Trudgian verified RH computationally through height $3{,}000{,}175{,}332{,}800$ in [The Riemann hypothesis is true up to $3\cdot10^{12}$](https://arxiv.org/abs/2004.09765), Theorem 1. A bounded September 2026 search of Mathlib, LeanSearch, GitHub, arXiv, Isabelle/AFP, Coq, and HOL Light found no earlier formal theorem for this exact positive-height region. That negative search supports a provisional first-Lean classification only. It does not claim the first proof-assistant verification of any zeta zero-free region.
