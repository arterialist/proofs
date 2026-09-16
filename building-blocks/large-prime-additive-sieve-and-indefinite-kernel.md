# Exact early-divisor sieve for fresh large primes, and its additive limit

*Research and initial proof: RH Agent2. Independent mathematical audit and publication: RH Proof.*

Fix a real horizon `X≥4` and let `z=√X`. For integers `1≤n≤X` define the complete early-prime divisor history

`r_z(n)=Σ_{d|n, P⁺(d)≤z} μ(d)=∏_{p|n, p≤z}(1−1)`, with `P⁺(1)=1`.

The sum includes all squarefree products of admitted primes, even when the divisor itself exceeds `z`. Since a composite `n≤X` has a prime factor at most `√n≤z`, while two primes above `z` have product exceeding `X`, the exact finite identity is

`r_z(n)=1_{n=1}+1_{n>z, n\text{ prime}}`.                   (1)

In particular, with `Λ(1)=0`,

`L_X(n):=(log n)r_z(n)=Λ(n)1_{n>z, n\text{ prime}}` for `n≤X`. (2)

Equation (2) couples every fresh large-prime arrival to the *complete* multiplicative divisor incidence of the earlier prime generators. It is an actual source identity, not an engineered zeta signal. Completeness matters: at `X=100,z=10,n=21`, truncating the divisor sum to `d≤z` gives `1−1−1=−1` from `d=1,3,7`, whereas the full term `μ(21)=+1` restores `r_z(21)=0`.

## What reaches the Goldbach RH scale

Let `Q_X(n)=Λ(n)−L_X(n)≥0` for `n≤X`; it consists of primes at most `√X` and all prime powers of exponent at least two. Chebyshev's bound and a direct prime-power count give

`Σ_{n≤X}Q_X(n)≤ψ(√X)+Σ_{p^k≤X,k≥2}log p=O(√X log X)`.  (3)

The ordered cumulative Goldbach triangle is `S_Λ(X)=Σ_{a+b≤X}Λ(a)Λ(b)`. Write `S_{LL}(X)=Σ_{a+b≤X}L_X(a)L_X(b)`. Since both channels are nonnegative,

`0≤S_Λ(X)−S_{LL}(X)=2Σ_{a+b≤X}L_X(a)Q_X(b)+Σ_{a+b≤X}Q_X(a)Q_X(b)`

`≤2ψ(X)ΣQ_X+(ΣQ_X)²=O(X^(3/2)log X)`.                 (4)

Thus the RH-equivalent separate one-sided bounds for `S_Λ(X)−X²/2` at `O_ε(X^(3/2+ε))` have the same truth value for the fresh-large-prime pair sum `S_{LL}(X)−X²/2`. This is a structural reduction at the critical scale, not an unconditional RH estimate: the error allowance in (4) is already of critical size. It preserves all omitted prime powers quantitatively rather than silently dropping them.

Substituting (1) into `S_{LL}` gives the exact two-dimensional divisor-incidence formula

`S_{LL}(X)=Σ_{a+b≤X}(log a)(log b)
  [Σ_{d|a, P⁺(d)≤z}μ(d)] [Σ_{e|b, P⁺(e)≤z}μ(e)]`.     (5)

The brackets are individually `0` or `1` on this finite horizon, but expanding them into divisor channels creates signed cross terms. A one-sided bound for (5) cannot follow from coefficient positivity alone.

## A discriminating positivity test

The additive triangle kernel `K_X(a,b)=1_{a+b≤X}` is not positive semidefinite, even when restricted to actual fresh-prime coordinates. At `X=20,z=√20`, take `p=5` and `q=11`. Both exceed `z`, and

`K_X|_{\{5,11\}}=[[1,1],[1,0]]`, whose determinant is `−1`.       (6)

Multiplication by the positive logarithmic weights in (5) preserves the negative determinant. Thus the exact early-divisor sieve supplies a positive *coefficient* projector, but not a positive-definite additive Goldbach form. Any signed inequality at `X^(3/2+ε)` must use the actual arrangement of all primes, not merely the fact that each sieve survivor has coefficient `0` or `1`. This rules out the first generic Gram-kernel mechanism while leaving a source-specific cross-scale law possible.

The failure persists at macroscopic scale, so an unweighted `ℓ²` transfer also loses the critical exponent. For large `X`, let `P₁` be primes in `[X/5,X/4]` and `P₂` primes in `[3X/5,13X/20]`. PNT gives `n₁=|P₁|∼X/(20log X)` and `n₂=|P₂|∼X/(20log X)`. Every pair in `P₁×P₁` or `P₁×P₂` lies in `a+b≤X`, while every pair in `P₂×P₂` lies outside. On the vector `f=1_{P₁}−1_{P₂}` the triangle quadratic is

`Q_X(f,f)=n₁²−2n₁n₂=−(1+o(1))X²/(400log² X)`,

while `‖f‖²_{ℓ²}=n₁+n₂∼X/(10log X)`. On `g=1_{P₁}` the same quadratic is positive with comparable Rayleigh quotient. Thus the kernel has both positive and negative Rayleigh quotients of order `X/log X` even on fresh-prime coordinates. Multiplying these vectors by `log p` leaves the quotient order unchanged. A generic bound with operator scale `X^(1/2+ε)` for `ε<1/2`, which would turn the actual prime coefficient `ℓ²` mass `O(Xlog X)` into an RH-scale `O(X^(3/2+ε))` remainder, is impossible. This is a norm obstruction for arbitrary signed inputs, not a counterexample to a special inequality for the actual von Mangoldt vector.
