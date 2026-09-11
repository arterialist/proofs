# Prime-error filters and exact Selberg convolution identities

These Lean formalizations concern the actual von Mangoldt function, including every prime power. They supply finite identities and norm comparisons. They do not establish a uniform prime-error estimate or the eventual sign of the distinct-prime convolution.

For real $x\ge1$, put

```math
e(x)=\psi(\lfloor x\rfloor)-x,\qquad P(x)=\int_1^x e(t)\,dt,
\qquad j(x)=e(x)-P(x)/x.
```

Here $\psi(N)=\sum_{n\le N}\Lambda(n)$. The functions use the inclusive convention at integers; the factor $x-n$ makes the endpoint contribution vanish in

```math
P(x)=\sum_{n\le x}(x-n)\Lambda(n)-\frac{x^2-1}{2}.
```

This identity is formalized in [PrimePrimitiveFormula](BuildingBlocks/PrimePrimitiveFormula.lean). In [PrimePrimitiveContraction](BuildingBlocks/PrimePrimitiveContraction.lean), integration by parts gives, for $T\ge1$,

```math
\int_1^T\frac{j(x)^2}{x^2}\,dx
=\int_1^T\frac{e(x)^2}{x^2}\,dx
-\frac{P(T)^2}{T^3}-2\int_1^T\frac{P(x)^2}{x^4}\,dx.       \tag{1}
```

The local integrability and primitive regularity needed for (1) are proved for this actual step function.

## A finite inverse estimate

Set $a(t)=e^{-t/2}e(e^t)$ and $r(t)=e^{-3t/2}P(e^t)$. Then $r(0)=0$ and the right derivative satisfies $r'=a-3r/2$. Define

```math
E_T=\int_0^T a(t)^2\,dt,\qquad Q_T=\int_0^T(a(t)-r(t))^2\,dt.
```

The exact identities are

```math
Q_T=E_T-r(T)^2-2\int_0^T r(t)^2\,dt,
```

```math
9Q_T-E_T=2\int_0^T(2a(t)-3r(t))^2\,dt+3r(T)^2.
```

Thus $Q_T\le E_T\le9Q_T$ for $T\ge0$. The proof expands the squares and uses $2\int ra=r(T)^2+3\int r^2$. See `primeLogFilter_energy_comparison` in [PrimeLogFilterReverse](BuildingBlocks/PrimeLogFilterReverse.lean), with the actual regularity in [PrimeLogFilter](BuildingBlocks/PrimeLogFilter.lean). The more general rate-$\lambda$ integration-by-parts identity is in [CausalFilterEnergy](BuildingBlocks/CausalFilterEnergy.lean). This is a standard first-order filter estimate, specialized without a smoothness assumption on the prime-error input.

The exact first-moment formulas, including terminal terms, are in [PrimeFirstMoment](BuildingBlocks/PrimeFirstMoment.lean):

```math
\int_1^N\frac{e(t)}{t^2}\,dt
=\sum_{n\le N}\frac{\Lambda(n)}n-\frac{\psi(N)}N-\log N,
\qquad
2\int_1^N\frac{P(t)}{t^3}\,dt
=\int_1^N\frac{e(t)}{t^2}\,dt-\frac{P(N)}{N^2}.
```

## Reflection and the centered convolution

Let $d\sigma=d\psi-\delta_1-dt$ on $[1,\infty)$, and define the finite tent convolution $\mathcal N(N)=\iint(N-ab)_+\,d\sigma(a)d\sigma(b)$. Its finite arithmetic expansion is

```math
\mathcal N(N)=\sum_{ab\le N}(N-ab)\Lambda(a)\Lambda(b)
-N^2\sum_{n\le N}\frac{\Lambda(n)}n+\sum_{n\le N}n\Lambda(n)
+\frac{N^2}{2}\log N+\frac{N^2-1}{4}.
```

[SelbergCenteredPairing](BuildingBlocks/SelbergCenteredPairing.lean) defines this exact finite expression; [SelbergReflection](BuildingBlocks/SelbergReflection.lean) proves, for integer $N\ge1$,

```math
\mathcal N(N)=N\int_1^N e(a)j(N/a)\,\frac{da}{a}.      \tag{2}
```

The atom at one is retained. Cauchy–Schwarz and the substitution $u=N/a$ yield

```math
\mathcal N(N)^2\le N^3 V_N Q_N\le N^3V_N^2,
\quad V_N=\int_1^N e(t)^2t^{-2}\,dt,
\quad Q_N=\int_1^N j(t)^2t^{-2}\,dt.                  \tag{3}
```

These are `selbergCenteredArea_sq_le_filtered` and `selbergCenteredArea_sq_le` in [SelbergReflectionBound](BuildingBlocks/SelbergReflectionBound.lean). The norm equivalence above does not reverse (3): a small reflected bilinear integral need not imply a small input norm. [SelbergLogReflection](BuildingBlocks/SelbergLogReflection.lean) records the logarithmic-coordinate version. [ReflectedConvolutionTransfer](BuildingBlocks/ReflectedConvolutionTransfer.lean) and [PrimeLogConvolutionTransfer](BuildingBlocks/PrimeLogConvolutionTransfer.lean) retain finite $L^2$ approximation errors. [SelbergSpectralModes](BuildingBlocks/SelbergSpectralModes.lean) evaluates each finite pair of exponential modes, including the resonant term $T e^{i\gamma T}$ when their frequencies coincide; no convergence of an infinite zero expansion is assumed.

## Removing same-prime interactions

Define

```math
P_2(n)=\Lambda(n)(\log n-\Lambda(n)),\qquad
D_2=\Lambda*\Lambda-P_2.
```

For $n=p^k$, $P_2(n)=(k-1)(\log p)^2$; otherwise it is zero. The exact coprime formula

```math
D_2(n)=\sum_{\substack{d\mid n\\(d,n/d)=1}}\Lambda(d)\Lambda(n/d)\ge0
```

is proved in [SelbergDistinctPrimes](BuildingBlocks/SelbergDistinctPrimes.lean). It gives the distinct-prime tent by subtracting $\sum_{n\le N}(N-n)P_2(n)$ from $\mathcal N(N)$; see [DistinctPrimeTent](BuildingBlocks/DistinctPrimeTent.lean). These are multiplicative-convolution identities, not covariance signs under a probability law.

There is a useful exact additive interpolation. On the cell $N\le x\le N+1$, put

```math
A_N=\sum_{n\le N}D_2(n),\quad
B_N=\sum_{n\le N}n(\Lambda(n)-D_2(n)),\quad
C_N=\sum_{n\le N}\Lambda(n)/n,
```

```math
f_N(x)=xA_N+B_N-x^2C_N+\frac{x^2}{2}\log x+\frac{x^2-1}{4}.
```

The cells join continuously. The derivative jump at $N+1$ is $D_2(N+1)-2\Lambda(N+1)$, and $f_N''(x)=\log x+2-2C_N$. Thus prime powers contribute downward slope jumps; other jumps are nonnegative. These statements are in [DistinctPrimeDynamics](BuildingBlocks/DistinctPrimeDynamics.lean). They do not determine the eventual sign of the joined function.

The arithmetic antecedent is [Selberg's elementary prime-number-theorem identity (1949)](https://www.math.lsu.edu/~mahlburg/teaching/handouts/2014-7230/Selberg-ElemPNT1949.pdf). [SelbergIdentity](BuildingBlocks/SelbergIdentity.lean), [SelbergTent](BuildingBlocks/SelbergTent.lean), [SmoothPrimeReadout](BuildingBlocks/SmoothPrimeReadout.lean), and [WeightedPrimePowers](BuildingBlocks/WeightedPrimePowers.lean) give the finite Möbius, smoothing and prime-power steps used here. The analytic tools are finite summation, the fundamental theorem of calculus and Cauchy–Schwarz. No mathematical originality or first-formalization claim is made.

All linked modules use Lean 4.24.0 and the repository's pinned mathlib. Their extracted sources compile independently against those dependencies. The companion's measure notation explains the finite expression; the finite-expression and reflection theorems, rather than a general signed-measure API, are what the linked Lean sources formalize.
