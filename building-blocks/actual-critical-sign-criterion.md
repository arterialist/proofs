# A formal eventual-sign implication for the critical arithmetic sum

The Lean theorem `BuildingBlocks.ActualCriticalSignCriterion.RiemannHypothesis_of_eventually_nonpos` proves

```math
\bigl[W(x)\leq0\text{ for every sufficiently large real }x\bigr]
\quad\Longrightarrow\quad\mathrm{RH}.
```

The eventual sign remains unproved. This formalization supplies the implication to mathlib's full `RiemannHypothesis`; it supplies no formal converse and makes no publication-priority claim.

Let $\Lambda$ be the von Mangoldt function, with all prime powers included, and define

```math
c(n)=\sum_{ab=n}\Lambda(a)\Lambda(b)
      -\Lambda(n)\bigl(\log n-\Lambda(n)\bigr).
```

The variables in every sum are positive integers. For real $x>1$, put

```math
V(x)=\sum_{n\leq x}\left[(x-n)c(n)
       -\Lambda(n)\frac{x^2-n^2}{n}\right]
       +\frac{x^2}{2}\log x+\frac{x^2}{4}-\frac14,\qquad
W(x)=\sum_{d\leq x}\sqrt d\,V(x/d),
```

and set $V(x)=0$ for $x\leq1$. The implementation uses finite sums at the actual real cutoff. Its complex-valued `W` has zero imaginary part, so its real-part inequality is precisely the displayed sign condition. The square-root weight includes every positive integer $d$, rather than only squarefree integers.

The central identity, proved with absolute convergence for $\Re s>1$, is

```math
\int_1^\infty W(x)x^{-s-2}\,dx
=\frac{\zeta(s+\tfrac12)}{s(s+1)}\bigl(G(s)^2-H(s)\bigr),
\qquad
G(s)=-\frac{\zeta'(s)}{\zeta(s)}-\frac{s}{s-1},
```

where

```math
H(s)=\sum_{n\geq1}\frac{\Lambda(n)(\log n-\Lambda(n))}{n^s}
```

is holomorphic for $\Re s>1/2$. The same-prime subtraction, both centering terms, and the constant $-1/4$ are retained.

Given the eventual sign, choose $A\geq1$ beyond its cutoff. The positive measure used in the proof is

```math
d\mu_A(x)=\mathbf1_{x>A}(-W(x))x^{-2}\,dx,
\qquad \tau(x)=\log x\quad(x>A).
```

Its Laplace transform agrees with the entire compact initial contribution minus the displayed Mellin transform. A proved Landau singularity theorem and real-axis continuation force actual convergence throughout $\Re s>1/2$. The argument treats both a finite convergence abscissa and a convergence set unbounded below. Holomorphy follows from this convergence. A cleared analytic identity then transfers agreement from $\Re s>1$ to neighborhoods of possible zeta zeros. A zero $\rho$ with multiplicity $m\geq1$ and $\Re\rho>1/2$ would contribute the nonzero double-pole coefficient

```math
\frac{m^2\zeta(\rho+\tfrac12)}{\rho(\rho+1)}.
```

This contradicts the holomorphic continuation. Reflection of nontrivial zeros gives full RH, with no simplicity assumption.

The analytic method is classical. [Suzuki, *On variants of Chebyshev's conjecture*, Proposition 1, printed p. 11](https://arxiv.org/pdf/2411.07436), states the Mellin form of Landau's theorem and cites Widder's *The Laplace Transform*, 1941, Chapter II, Theorem 5b, and Montgomery and Vaughan's *Multiplicative number theory I*, Lemma 15.1. Here the Lean dependency chain proves the positive-measure version through differentiation of Laplace moments and the nonnegative Taylor-series interchange.

The [formal target](BuildingBlocks/ActualCriticalSignCriterion.lean) has exactly one hypothesis:

```lean
(hsign : ∀ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re ≤ 0)
```

There is no additional convergence, continuation, or pole-exclusion premise. The target compiles with the repository's Lean 4.24.0 and pinned mathlib. Its axiom dependencies are only `propext`, `Classical.choice`, and `Quot.sound`.
