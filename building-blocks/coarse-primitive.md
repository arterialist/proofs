# Finite primitive-energy bounds for the prime error

[CoarsePrimitive.lean](BuildingBlocks/CoarsePrimitive.lean) proves finite test-integral bounds for the actual Chebyshev function, including prime powers:

```math
\psi(N)=\sum_{n=0}^{N}\Lambda(n),\qquad e(x)=\psi(\lfloor x\rfloor_+)-x.
```

For $`X>0`$, define

```math
P_X(t)=\int_X^t e(x)\,dx,\qquad R_X(t)=\int_t^{2X}e(x)\,dx,
\qquad S_X=\int_X^{2X}\bigl(P_X(t)^2+R_X(t)^2\bigr)\,dt.
```

The two primitives control both the terminal mass and the integrated prefix:

```math
X P_X(2X)^2\le2S_X,\qquad
\left(\int_X^{2X}|P_X(t)|\,dt\right)^2\le XS_X.
```

These squared inequalities also hold at $`X=0`$.

## Test functions and Mellin blocks

Let $`w:[X,2X]\to\mathbb C`$ be continuous, differentiable in the interior with derivative $`w'`$, and suppose $`w'`$ is interval integrable. Then

```math
\int_X^{2X}e(x)w(x)\,dx
=P_X(2X)w(2X)-\int_X^{2X}P_X(x)w'(x)\,dx.
```

If $`K\ge0`$ and $`\lVert w'(x)\rVert\le K`$ for every $`x\in(X,2X]`$, `coarsePrime_test_bound` gives

```math
\left\lVert\int_X^{2X}e(x)w(x)\,dx\right\rVert
\le\sqrt{\frac{2S_X}{X}}\,\lVert w(2X)\rVert+K\sqrt{XS_X}.
```

In the Lean statement, $`w`$ and $`w'`$ are functions on $`\mathbb R`$ with the stated conditions on the block. The general integration-by-parts identity also permits reversed intervals. The positive-$`X`$ estimates use the usual interval orientation.

For every $`s\in\mathbb C`$, `coarsePrime_mellin_block` specializes the identity to the principal complex power on the positive real axis:

```math
\int_X^{2X}e(x)x^{-s-1}\,dx
=P_X(2X)(2X)^{-s-1}
+(s+1)\int_X^{2X}P_X(x)x^{-s-2}\,dx.
```

The terminal term is retained. The proof establishes local integrability and right continuity of $`e`$, so its integer jumps require no two-sided derivative assumption. The primitive has the required right derivative at every point.

## Use and scope

The test estimate converts a bound on $`S_X`$ into bounds for smooth weighted prime-error integrals while preserving the terminal mass. The module proves no growth estimate for $`S_X`$, no convergence of an infinite Mellin series, and no implication from a global coarse-energy hypothesis to RH. The results are finite applications of established integration theory; no mathematical novelty or first-formalization claim is made.

The [written dyadic-energy criterion](coarse-energy-rh-criterion.md) explains the conditional connection to RH. Its infinite-series argument is separate from this finite formalization.

## Sources and verification

The proofs use Cauchy–Schwarz and one-sided integration by parts. The pinned mathlib [FTC and integration-by-parts formalization](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/MeasureTheory/Integral/IntervalIntegral/IntegrationByParts.lean) credits Yury Kudryashov, Patrick Massot and Sébastien Gouëzel. The [von Mangoldt module](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/NumberTheory/VonMangoldt.lean) credits Bhavik Mehta. Additional attribution and license details are in [the source record](verification/coarse-primitive.json).

The extracted module and library index were compiled with Lean 4.24.0 using the pinned dependency cache. Every exposed declaration and every generated module constant passed a full transitive axiom audit. The axiom union is `propext`, `Classical.choice` and `Quot.sound`. Imported mathlib artifacts were reused; a clean rebuild of all dependencies was not performed.

[Verification record](verification/coarse-primitive.json) · [Audit source](verification/CoarsePrimitiveAudit.lean) · [Axiom output](verification/coarse-primitive-axioms.txt).
