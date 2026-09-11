# A finite transfer from Mertens quotients to the prime error

The theorem `BuildingBlocks.MertensTransfer.primeError_bound_of_Mertens_quotients` gives an explicit finite way to use bounds on the actual summatory Möbius function. It assumes those bounds; it does not prove them.

Write $`M(n)=\sum_{d\le n}\mu(d)`$ and $`\psi(n)=\sum_{d\le n}\Lambda(d)`$. For integers $`1\le K\le N`$, a real $`\eta\ge0`$, and the hypothesis

```math
\left|M\!\left(\left\lfloor\frac Nk\right\rfloor\right)\right|
\le \eta\,\frac Nk
\qquad\text{for every integer }1\le k\le K,
```

the theorem proves

```math
|\psi(N)-N+2\gamma|
\le 4\eta N(1+\log K)^2+\frac{39N}{\sqrt{K+1}}.
```

The argument of $`M`$ is the integer quotient; the right side of its hypothesis uses the real ratio $`N/k`$. Here $`\gamma`$ is the Euler–Mascheroni constant. The constant $`2\gamma`$ and the endpoint $`K+1`$ are retained. The prime sum uses the actual von Mangoldt function, including proper prime powers.

## Use

~~~lean
import BuildingBlocks.MertensPrimeTransfer

example {N K : ℕ} (hN : 1 ≤ N) (hK : 1 ≤ K) (hKN : K ≤ N)
    {η : ℝ} (hη : 0 ≤ η)
    (hM : ∀ k ∈ Finset.Icc 1 K,
      |(BuildingBlocks.MertensTransfer.mertens (N / k) : ℝ)| ≤
        η * ((N : ℝ) / k)) :
    |BuildingBlocks.CoarsePrimitive.psi N - (N : ℝ) +
      2 * Real.eulerMascheroniConstant| ≤
      4 * η * N * (1 + Real.log K) ^ 2 +
        39 * N / Real.sqrt ((K + 1 : ℕ) : ℝ) :=
  BuildingBlocks.MertensTransfer.primeError_bound_of_Mertens_quotients
    hN hK hKN hη hM
~~~

## Retained finite identities

Let

```math
a(k)=\log k-\tau(k)+2\gamma,\qquad
H(q)=\sum_{k\le q}a(k),\qquad
A(N,K)=\sum_{k\le K}a(k)M(\lfloor N/k\rfloor).
```

The arithmetic support proves $`|H(q)|\le13\sqrt q`$ and exact Möbius inversion

```math
\psi(N)-N+2\gamma=\sum_{d\le N}\mu(d)H(\lfloor N/d\rfloor).
```

Grouping terms with quotient at most $`K`$ and applying finite summation by parts gives

```math
\sum_{N/(K+1)<d\le N}\mu(d)H(\lfloor N/d\rfloor)
=A(N,K)-H(K)M(\lfloor N/(K+1)\rfloor).
```

The last term is not discarded. The complementary contribution is bounded by $`26N/\sqrt{K+1}`$, and this boundary term by $`13N/\sqrt{K+1}`$. Consequently,

```math
|\psi(N)-N+2\gamma-A(N,K)|\le\frac{39N}{\sqrt{K+1}}.
```

The coefficient estimate

```math
\sum_{k\le K}\frac{|a(k)|}{k}\le4(1+\log K)^2
```

then yields the stated transfer. The module also exposes these intermediate identities and estimates for separate use.

The Mertens quotient estimates remain the arithmetic input to be proved.

## Sources and verification

The classical hyperbola transfer appears in Granville and Soundararajan's 2014 draft of [Multiplicative number theory: The pretentious approach](https://dms.umontreal.ca/~andrew/PDF/Book.To2.1.pdf), sections 1.1.4–1.1.5, printed pages 8–9. Page 9 gives the coefficient-weighted Mertens prefix with an $`O(N/\sqrt K)`$ remainder. The formal statements here retain explicit constants and finite endpoints.

The definitions of psi, logFactorial, divisorSum, and centeredDivisorForcing reuse the existing CoarsePrimitive and FloorCorrection modules. Finite divisor reindexing and the Möbius divisor-sum identity reuse HyperbolaProduct. CoarsePrimeBounds supplies existing elementary psi summation identities. The module has no dependency on the conditional RH theorem.

Pinned mathlib inputs include Aaron Anderson's [arithmetic functions and Möbius inversion](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/NumberTheory/ArithmeticFunction.lean), Arend Mellendijk's [harmonic bounds](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/NumberTheory/Harmonic/Bounds.lean), and Kevin H. Wilson's [sum-integral comparisons](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/SumIntegralComparisons.lean). Mathlib retains its authorship and Apache 2.0 license; the extracted local proofs follow the repository's MIT license.

The package uses Lean 4.24.0 and mathlib f897ebcf72cd16f89ab4577d0c826cd14afaafc7. [Provenance](verification/mertens-transfer-provenance.json), [exact source hashes](verification/mertens-transfer-sources.json), and the [verification result](verification/mertens-transfer-result.json) record the source and dependency scope. Reproduce the build and complete imported-local axiom audit with:

~~~sh
python3 building-blocks/verification/verify-mertens-transfer.py --lake lake
~~~

Verification uses the ordinary Lean kernel with pinned upstream compiled dependencies. It is not a fresh rebuild of every mathlib dependency or a separate proof-checker implementation.
