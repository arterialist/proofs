# A coarse primitive-energy condition implies RH

The Lean theorem `BuildingBlocks.CoarsePrimitive.target_of_coarsePrimitiveBound` proves a conditional implication to mathlib's full `RiemannHypothesis`. Its sole hypothesis is the all-epsilon dyadic bound below. The bound itself remains unproved.

Let

```math
\psi(N)=\sum_{n\le N}\Lambda(n),\qquad e(x)=\psi(\lfloor x\rfloor)-x,
```

and define

```math
P_X(t)=\int_X^t e(x)\,dx,\qquad R_X(t)=\int_t^{2X}e(x)\,dx,\qquad
S_X=\int_X^{2X}\bigl(P_X(t)^2+R_X(t)^2\bigr)\,dt.
```

The hypothesis `CoarsePrimitiveBound` is

```math
\forall\epsilon>0\ \exists C>0\ \forall k\in\mathbb N,\qquad
S_{2^k}\le C(2^k)^{4+\epsilon}.
```

Here $`\Lambda`$ is the actual von Mangoldt function, so proper prime powers are included. The definitions reuse [CoarsePrimitive.lean](BuildingBlocks/CoarsePrimitive.lean) without alteration. The dyadic index includes zero. Both primitives retain their endpoint means. No additional estimate at intermediate Haar scales is assumed.

## Use

```lean
import BuildingBlocks.CoarsePrimitiveCriterion

example
    (h : BuildingBlocks.CoarsePrimitive.CoarsePrimitiveBound) :
    RiemannHypothesis :=
  BuildingBlocks.CoarsePrimitive.target_of_coarsePrimitiveBound h
```

The final theorem's `Target` is definitionally `RiemannHypothesis`. It states that every nontrivial complex zero of zeta has real part one half, excluding the negative even integers and the pole at one as in mathlib's definition.

## Argument

For each dyadic $`X=2^k`$, put

```math
I_k(s)=\int_X^{2X}e(x)x^{-s-1}\,dx.
```

Each block is entire in $`s`$ by differentiation under the finite integral. The integrand's jumps in $`x`$ cause no problem because $`e`$ is locally integrable. Integration by parts gives

```math
I_k(s)=P_X(2X)(2X)^{-s-1}
 +(s+1)\int_X^{2X}P_X(x)x^{-s-2}\,dx.
```

The terminal term is retained. The finite energy estimates imply

```math
|P_X(2X)|\le\sqrt{2S_X/X},\qquad
\int_X^{2X}|P_X(x)|\,dx\le\sqrt{XS_X}.
```

On a compact set with $`\Re s\ge a>1/2`$ and $`|s+1|\le R`$, choose $`\epsilon=a-1/2`$. For its energy constant $`C`$, this yields

```math
|I_k(s)|\le
\bigl(\sqrt{2C}+R\sqrt C\bigr)(2^k)^{(1/2-a)/2}.
```

The geometric majorant proves local uniform convergence of $`F(s)=\sum_k I_k(s)`$ on $`\Re s>1/2`$. Thus $`F`$ is holomorphic there.

Unconditionally, on $`\Re s>1`$, the elementary Chebyshev bound gives absolute integrability. The disjoint blocks $`(2^k,2^{k+1}]`$ cover $`(1,\infty)`$, and Abel summation for the actual von Mangoldt series gives

```math
sF(s)=-\frac{\zeta'(s)}{\zeta(s)}-\frac{s}{s-1}.
```

Set $`G=sF`$. The denominator-free expression

```math
\zeta'(s)+\left(\frac{s}{s-1}+G(s)\right)\zeta(s)
```

continues as zero to $`\Re s>1/2`$, $`s\ne1`$. An analytic solution of this differential identity cannot have an isolated zero where its coefficient is analytic. Zeta is not locally identically zero, so it has no zero in that domain. The functional equation then gives the full RH conclusion.

The proof supplies the analytic sufficiency of the stated energy condition. It supplies no arithmetic cancellation estimate establishing that condition.

## Sources and attribution

The method is the classical Mellin-transform and holomorphic-continuation argument. No novelty or firstness claim is made. The finite terminal-mass estimates are reused from the published coarse primitive block. The elementary psi bounds use the published factorial and divisor-reindexing definitions; zeta analyticity and nonlocal vanishing reuse the published ZetaPole module.

The primary formal dependencies are the pinned mathlib sources:

- Yury Kudryashov's [differentiation under a parameter-dependent interval integral](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/Calculus/ParametricIntervalIntegral.lean).
- Vincent Beffara's [locally uniform limits of holomorphic functions](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/Complex/LocallyUniformLimit.lean).
- Xavier Roblot's [Abel integral representation for L-series](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/NumberTheory/LSeries/SumCoeff.lean).
- The [von Mangoldt logarithmic-derivative identity](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/NumberTheory/LSeries/Dirichlet.lean) and [full RH definition and functional equation](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/NumberTheory/LSeries/RiemannZeta.lean).

Mathlib retains its upstream authorship and Apache 2.0 license. The extracted local proofs follow this repository's MIT license. Declaration-level extraction provenance and source hashes are recorded in [coarse-conditional-provenance.json](verification/coarse-conditional-provenance.json) and [coarse-conditional-sources.json](verification/coarse-conditional-sources.json).

## Verification

The package is pinned to Lean 4.24.0 and mathlib commit f897ebcf72cd16f89ab4577d0c826cd14afaafc7. The verification script builds the final module and checks the complete transitive axiom closure of every constant in its imported BuildingBlocks modules, including generated constants. It also checks the explicit all-epsilon hypothesis against the full RH conclusion.

~~~sh
python3 building-blocks/verification/verify-coarse-conditional.py --lake lake
~~~

The recorded result is in [coarse-conditional-result.json](verification/coarse-conditional-result.json). Verification uses the ordinary Lean kernel and pinned upstream compiled dependencies. It is not a fresh build of every mathlib dependency or a separate proof-checker implementation.
