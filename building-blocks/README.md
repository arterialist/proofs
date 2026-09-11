# Building blocks

Verified results used in the study of prime-counting errors. The results below are classical; no originality or first-formalization claim is made. Throughout, $\gamma$ is the Euler–Mascheroni constant.

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
