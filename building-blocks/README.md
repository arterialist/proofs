# Building blocks

Results used in the study of prime-counting errors, with their formal verification scope stated individually. No originality or first-formalization claim is made. Throughout, $\gamma$ is the Euler–Mascheroni constant.

## Local poles at zeta zeros

[ZetaPole.lean](BuildingBlocks/ZetaPole.lean) proves that if $\zeta(\rho)=0$ and $\rho\ne0,1$, there are a positive integer $m$ and a function $a$ analytic at $\rho$ such that, on a punctured neighborhood,

```math
-\frac{\zeta'(s)}{s\zeta(s)}-\frac{1}{s-1}+\frac{2\gamma}{s}
=\frac{-m/\rho}{s-\rho}+a(s).
```

The residue is $-m/\rho\ne0$, including at multiple zeros. This identifies the singularity that remains after cancellation of a shared reciprocal-zeta term in prime-error formulas. Controlling the remaining arithmetic expression is still necessary to locate the zeros.

The result uses classical analytic zero factorization and logarithmic derivatives; see [Apostol's explicit formula, DLMF 25.16.2](https://dlmf.nist.gov/25.16.E2). Formal dependencies include mathlib's [isolated-zero factorization](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/Analytic/IsolatedZeros.lean) and [logarithmic derivative rules](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/Calculus/LogDeriv.lean).

[Verification](verification/zeta-pole.json).

## Explicit floor correction

Define

```math
\begin{aligned}
D(q)&=\sum_{k=1}^{q}\left\lfloor\frac{q}{k}\right\rfloor,\\
H(q)&=\log(q!)-D(q)+2\gamma q,\\
\Delta(x)&=D(\lfloor x\rfloor)-x\log x-(2\gamma-1)x,\\
c_0&=\tfrac12\log(2\pi)-\gamma.
\end{aligned}
```

[FloorCorrection.lean](BuildingBlocks/FloorCorrection.lean) proves, for every real $x\ge1$,

```math
\left|H(\lfloor x\rfloor)+\Delta(x)-c_0
+\left(\{x\}-\tfrac12\right)(\log x+2\gamma)\right|
\le\frac{2}{x}.
```

The bound includes integers, where $`\{x\}=0`$. It separates a constant mean from a weighted sawtooth, allowing Fourier estimates to be applied. On an integer block $B<n\le2B$ with $2B\le N$, the residuals at $x=N/n$ sum absolutely to at most $4B^2/N$. This block consequence is a written deduction; the formal theorem is the pointwise bound.

The mathematics follows from the [Stirling expansion and remainder estimates](https://dlmf.nist.gov/5.11). The imported mathlib [Stirling module](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/SpecialFunctions/Stirling.lean) credits Moritz Firsching, Fabian Kruse, and Nikolas Kuhn; the [Euler–Mascheroni module](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/NumberTheory/Harmonic/EulerMascheroni.lean) credits David Loeffler. Mathlib dependencies retain their Apache 2.0 license.

[Verification](verification/floor-correction.json).

## Möbius hyperbola product estimate

[HyperbolaProduct.lean](BuildingBlocks/HyperbolaProduct.lean) proves the finite product-grouping and complementary-divisor identities for

```math
a_N(k)=\sum_{\substack{d\mid k\\k^2\le Nd}}\mu(d).
```

The [written proof](hyperbola-product.md) applies classical Fourier and derivative estimates to obtain, for every $\delta>0$ and integer $\sqrt N\le A\le N/2$,

```math
\left|\sum_{\sqrt N<k\le A}a_N(k)
\left(\{N/k\}-\tfrac12\right)\right|
\ll_\delta N^\delta A^{4/3}N^{-1/3}.
```

Thus products through $N^{5/8}$ contribute $O_\delta(N^{1/2+\delta})$. The analytic estimate is not formalized in Lean. Larger products and the other terms in the prime-error formula remain unresolved. Exact publication priority is unestablished; this entry records a useful application of classical methods.

[Sources and proof](hyperbola-product.md) · [Verification](verification/hyperbola-product.json).

## A regular source with a large Möbius inverse

[RegularSource.lean](BuildingBlocks/RegularSource.lean) proves that for each real $r<2/3$ there is a single sequence $f:\mathbb N\to\mathbb R$ satisfying, for every $q\ge0$,

```math
|f(q)|\le\sqrt q,\qquad |f(q+1)-f(q)|\le1,
```

whose Möbius floor inverse has no eventual bound of order $N^r$:

```math
\nexists C>0,\,N_0\ge1\quad
\forall N\ge N_0:\quad
\left|\sum_{d=1}^{N}\mu(d)f\!\left(\left\lfloor N/d\right\rfloor\right)\right|
\le C N^r.
```

The sequence may depend on $r$. At $N=t^3$, separated tent functions first give a sequence with inverse at least $t^2/64$ for $t\ge256$. The Banach–Steinhaus theorem then yields a fixed sequence for each exponent.

This excludes deriving the desired inverse bound from size and bounded increments alone. It does not give a lower bound for the particular arithmetic source $H$, or settle RH.

The proof uses elementary squarefree counting and the classical uniform boundedness principle. Its formal dependencies include mathlib's [Banach–Steinhaus theorem](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/Normed/Operator/BanachSteinhaus.lean), by Jireh Loreaux, and [bounded-function normed spaces](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Topology/ContinuousMap/Bounded/Normed.lean), by Sébastien Gouëzel, Mario Carneiro, Yury Kudryashov, and Heather Macbeth. These dependencies retain their Apache 2.0 license. Priority of this exact counterexample and its formalization is unestablished; no originality claim is made.

[Verification](verification/regular-source.json).

## Finite primitive-energy bounds

[CoarsePrimitive.lean](BuildingBlocks/CoarsePrimitive.lean) bounds weighted integrals of the actual prime error $`e(x)=\psi(\lfloor x\rfloor_+)-x`$. Put $`P_X(t)=\int_X^t e(x)\,dx`$, $`R_X(t)=\int_t^{2X}e(x)\,dx`$ and $`S_X=\int_X^{2X}(P_X(t)^2+R_X(t)^2)\,dt`$.

For $`X>0`$, a continuous complex test function $`w`$ differentiable inside the block, with interval-integrable derivative satisfying $`\lVert w'\rVert\le K`$ for $`K\ge0`$, obeys

```math
\left\lVert\int_X^{2X}e(x)w(x)\,dx\right\rVert
\le\sqrt{2S_X/X}\,\lVert w(2X)\rVert+K\sqrt{XS_X}.
```

The module also proves the exact finite Mellin identity, retaining the terminal mass and integer jumps. It supplies no growth bound for $`S_X`$ or infinite-series continuation theorem. The mathematics uses classical Cauchy–Schwarz and one-sided integration by parts.

[Assumptions, use and attribution](coarse-primitive.md) · [Written RH criterion](coarse-energy-rh-criterion.md) · [Verification](verification/coarse-primitive.json).

## Exact hyperbola endpoint correction

[HyperbolaEndpoint.lean](BuildingBlocks/HyperbolaEndpoint.lean) evaluates the complete signed endpoint count, for every integer $`N\ge1`$:

```math
E(N)=\sum_{d\mid N}\mu(d)\#\{m\mid N/d:m\le\sqrt{N/d}\},
\qquad 2E(N)=1+(-1)^{\Omega(N)}.
```

Here $`\Omega`$ counts prime factors with multiplicity. The original inclusive double-sum equality is also formalized. The full ordinary-to-midpoint sawtooth correction is consequently zero or $`-1/2`$; that real-valued conversion is a written consequence and does not apply to arbitrary restricted outer blocks. The proof uses classical divisor pairing and Möbius inversion.

[Statement, use and attribution](hyperbola-endpoint.md) · [Verification](verification/hyperbola-endpoint.json).
