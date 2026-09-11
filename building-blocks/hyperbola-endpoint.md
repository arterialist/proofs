# Exact integer-endpoint correction for a Möbius hyperbola sum

[HyperbolaEndpoint.lean](BuildingBlocks/HyperbolaEndpoint.lean) evaluates the full signed endpoint count. For a positive integer $`N`$, define

```math
c(q)=\#\{m\mid q:1\le m\le\lfloor\sqrt q\rfloor\},
\qquad E(N)=\sum_{d\mid N}\mu(d)c(N/d).
```

The module proves

```math
2E(N)=1+(-1)^{\Omega(N)},\qquad E(N)\in\{0,1\},
```

where $`\Omega(N)`$ counts prime factors with multiplicity. It is `ArithmeticFunction.cardFactors` in Lean. The same correction is proved equal to the original inclusive double sum:

```math
E(N)=\sum_{n=1}^{N}\mu(n)
\sum_{m=1}^{\lfloor\sqrt{\lfloor N/n\rfloor}\rfloor}
\mathbf 1_{\{nm\mid N\}}.
```

The nonzero hypothesis is essential. Lean's divisor conventions give $`E(0)=0`$, while the displayed parity expression would give $`2`$ on the right. The square-root-cutoff identity for $`c(q)`$ itself holds also at $`q=0`$.

## Proof and formal scope

Pair each divisor with its complement, retaining the square diagonal. This gives

```math
2c(q)=\tau(q)+\mathbf 1_{\{q\text{ is a square}\}}\qquad(q\ge1).
```

Möbius convolution gives

```math
\sum_{d\mid N}\mu(d)\tau(N/d)=1,\qquad
\sum_{d\mid N}\mu(d)\mathbf 1_{\{N/d\text{ is a square}\}}=(-1)^{\Omega(N)}.
```

The second identity uses the unique squarefree part of $`N`$. Combining the two proves the endpoint value. The double-sum theorem then includes the nondivisor outer labels, whose inner contributions vanish.

The nine formal declarations comprise two definitions and seven theorems: `moebius_square_quotient_sum`, `halfDivisorCount`, `twice_halfDivisorCount`, `moebius_divisorCard_sum`, `hyperbolaEndpointCorrection`, `twice_hyperbolaEndpointCorrection`, `hyperbolaEndpointCorrection_zero_or_one`, `halfDivisorCount_eq_sqrt_divisors`, and `hyperbolaEndpointCorrection_eq_jump_sum`. They are in the namespace `BuildingBlocks.HyperbolaEndpoint`.

## Use: changing the sawtooth convention

Write $`\sigma(x)=\{x\}-1/2`$, and let $`\sigma_0(x)`$ equal $`\sigma(x)`$ away from integers and zero at integers. The finite count implies

```math
\begin{aligned}
&\sum_{n=1}^{N}\mu(n)\sum_{1\le m\le\sqrt{N/n}}
  \sigma\!\left(\frac{N}{nm}\right)\\
&\quad=\sum_{n=1}^{N}\mu(n)\sum_{1\le m\le\sqrt{N/n}}
  \sigma_0\!\left(\frac{N}{nm}\right)
  -\frac{1+(-1)^{\Omega(N)}}4.
\end{aligned}
```

Here $`m`$ is integral, so the real square-root cutoff equals the formal natural-number cutoff. Each integer argument contributes $`-1/2`$ to the difference, and integer arguments occur exactly when $`nm\mid N`$. The complete signed correction is therefore zero or $`-1/2`$. This real-valued sawtooth conversion is a written consequence; the Lean module formalizes the integer endpoint count and its double-sum equality.

The full outer range matters. At $`N=6`$, retaining only $`n=1`$ gives endpoint count $`c(6)=2`$ and sawtooth correction $`-1`$. The result cannot be substituted into an arbitrary restricted outer block. It evaluates an endpoint contribution left unevaluated by the separate `HyperbolaProduct` grouping; it provides no bound on the remaining oscillatory sum or on prime-counting error.

## Attribution and verification

Complementary-divisor pairing, including the square exception, appears in Granville and Soundararajan's *Multiplicative number theory: The pretentious approach*, 2014 draft, §1.1.4, printed pages 7–8. [Author-hosted text](https://dms.umontreal.ca/~andrew/PDF/Book.To2.1.pdf).

The equivalent Liouville identity $`\sum_{d\mid N}\lambda(d)=\mathbf 1_{\{N\text{ is a square}\}}`$ is [DLMF 27.6.1](https://dlmf.nist.gov/27.6.E1), whose section cites Apostol, Chapter 2. Möbius inversion gives the square-quotient identity above. These are classical methods; no mathematical originality or first-formalization claim is made.

Pinned mathlib dependencies provide arithmetic functions, squarefree decomposition and divisor arithmetic, by Aaron Anderson; natural square roots, by Floris van Doorn, Leonardo de Moura, Jeremy Avigad and Mario Carneiro; and finite natural intervals, by Yaël Dillies. Their Apache 2.0 licenses and institutional notices remain applicable. Repository proof code is under MIT; no dependency source is copied. Exact source provenance and dependency revisions appear in the [verification record](verification/hyperbola-endpoint.json).

The extracted source, standalone index and integrated library were compiled afresh with Lean 4.24.0 and mathlib `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`. The audit checks every exposed declaration and every generated local constant through its full transitive axiom closure. The integrated audit covers 117 exposed declarations, including all 19 constants in this module. Only `propext`, `Classical.choice` and `Quot.sound` occur. Pinned dependency caches were reused; this is not a clean rebuild of all mathlib sources.

[Audit source](verification/HyperbolaEndpointAudit.lean) · [Axiom output](verification/hyperbola-endpoint-axioms.txt) · [Verification record](verification/hyperbola-endpoint.json).
