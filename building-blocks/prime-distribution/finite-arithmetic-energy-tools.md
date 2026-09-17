# Finite arithmetic and energy tools

The following Lean modules isolate finite identities and inequalities used in arithmetic energy calculations. Each statement has its own hypotheses. None supplies an unproved cancellation estimate for the prime error. They use Lean 4.24.0 and the repository's pinned mathlib; no mathematical novelty or first-formalization claim is made.

## Finite energies and transport

[PolygonalCoarseEnergy](../../formalization/BuildingBlocks/PolygonalCoarseEnergy.lean) evaluates a prefix-and-suffix square on a linearly interpolated cell. If its endpoints are $p,q$ and the terminal total is $A$, the cell integral, divided by the cell length, is

```math
\frac{p^2+pq+q^2+(A-p)^2+(A-p)(A-q)+(A-q)^2}{3}.
```

It lies between one sixth and one half of the sum of the four endpoint squares. The proof integrates the quadratic polynomial; summing with nonnegative cell lengths preserves the estimates. This is the ordinary piecewise-linear mass-matrix calculation, with the terminal mode retained.

[CarryWindowVariance](../../formalization/BuildingBlocks/CarryWindowVariance.lean) proves that, for $n>0$ and $|f_i-f_j|\ge L|i-j|$ with $L\ge0$,

```math
\sum_{i=0}^{n-1}(f_i-c)^2\ge L^2n(n^2-1)/12.
```

The proof uses the pairwise variance identity. [WindowVariance](../../formalization/BuildingBlocks/WindowVariance.lean) proves the local reciprocal estimate

```math
A^2\le24(j+1)^4\int_j^{j+1}(B-A/x)^2\,dx\qquad(j\ge1).
```

[FourierAliasTail](../../formalization/BuildingBlocks/FourierAliasTail.lean) is an abstract weighted Cauchy estimate: nonnegative weights bounded by $4/K^2$ and with total mass at most $2/K$ have square mass at most $8/K^3$. Applying it to a Fourier alias family still requires proving those hypotheses for that family.

[FiniteShiftEnergy](../../formalization/BuildingBlocks/FiniteShiftEnergy.lean) formalizes finite van der Corput differencing with its actual endpoints and signed shift correlations. [AggregateShiftEnergy](../../formalization/BuildingBlocks/AggregateShiftEnergy.lean) applies this to an aggregate and retains cross terms between its constituents. It is not a theorem that all cross terms are negative.

[AncestryFlow](../../formalization/BuildingBlocks/AncestryFlow.lean) proves the finite balance identity

```math
M_i=b_i+\sum_jM_jT_{ji}\quad\Longrightarrow\quad
\sum_iM_i\left(V_i-\sum_jT_{ij}V_j\right)=\sum_i b_iV_i.
```

Its occupation and traffic estimates require the stated nonnegativity, drift and complement-mass bounds. This is the finite adjoint balance identity; it does not construct an arithmetic transition law satisfying those bounds. [BirthDivisorCoupling](../../formalization/BuildingBlocks/BirthDivisorCoupling.lean) gives the exact finite coupling between birth labels and divisor coordinates used with such models.

## Exact divisibility tools

[ExactPrimePowerCRT](../../formalization/BuildingBlocks/ExactPrimePowerCRT.lean) handles a finite set of distinct primes, arbitrary integral shifts and prescribed nonnegative valuations. A residue class modulo $Q=\prod_p p^{e_p+1}$ realizes $v_p(n+h_p)=e_p$ for every selected prime. Its first representative above a real threshold $X$ lies below $X+Q$; the positivity hypotheses on $X$ and $X+h_p$ are retained. This specializes the Chinese remainder theorem already formalized in mathlib. The [fixed-prime successor-depth theorem](../successor-and-division/fixed-prime-successor-depth.md) uses this construction to attain a complete cluster set and sharp growing horizons; its smooth-part upper bound remains a written classical input.

[SmoothDivisorStopping](../../formalization/BuildingBlocks/SmoothDivisorStopping.lean) proves that if $Q>0$ has every prime factor at most $Y\ge2$ and $1\le T\le Q$, then some $d\mid Q$ satisfies $T\le d\le YT$. For $T>1$, taking the least such divisor gives $d<YT$ and $d/p<T$ for every prime $p\mid d$. This is the usual least-divisor stopping argument.

[LcmDifferenceProduct](../../formalization/BuildingBlocks/LcmDifferenceProduct.lean) proves

```math
\prod_i a_i\ \bigm|\ \operatorname{lcm}_i(a_i)\prod_{i<j}|a_i-a_j|.
```

The proof inductively bounds the new greatest common divisor by the product of differences. Degenerate equal entries are allowed in the divisibility statement; strict positivity statements separately require distinct positive entries.

For the abundancy $A(n)=\sigma(n)/n=\sum_{d\mid n}1/d$, [DivisorOverlap](../../formalization/BuildingBlocks/DivisorOverlap.lean) proves

```math
A(n)A(m)=A(\gcd(n,m))A(\operatorname{lcm}(n,m)),
```

and divisibility monotonicity. In particular $A(n)A(n+h)\le A(h)A(\operatorname{lcm}(n,n+h))$ under the positive-integer hypotheses in the theorem. The primewise identity is the standard multiplicative-function factorization; compare [DLMF §27.6](https://dlmf.nist.gov/27.6). [LogarithmicOverlap](../../formalization/BuildingBlocks/LogarithmicOverlap.lean) records the corresponding scalar logarithmic-loss inequalities with all additive-correction hypotheses explicit.

## Local rounding loss as relative entropy

For $p>1$, $T>p$ and $a\in\mathbb N$, write $q=1/T$, $r=p^{-a-1}$ and $\varepsilon=q/(1-q)$. [DivisorEntropy](../../formalization/BuildingBlocks/DivisorEntropy.lean) proves

```math
\begin{aligned}
&\left[\log\frac{1-q}{1-1/p}-\varepsilon\log(T/p)\right]
-\left[\log\frac{1-r}{1-1/p}-\varepsilon a\log p\right]\\
&\hspace{25mm}=\frac{D_{\rm Ber}(q\Vert r)}{1-q}\ge0,
\end{aligned}
```

where $D_{\rm Ber}(q\Vert r)=q\log(q/r)+(1-q)\log((1-q)/(1-r))$. Expansion proves the identity; $\log x\le x-1$ proves nonnegativity. The scalar loss corresponds exactly to Bell's equation `e-kappa`, with $x=\log p$ and $Y=\log T$, in [the integrality-gap manuscript](https://github.com/epicycloids/robin-integrality-gap/blob/main/paper/sections/integrality_gap.tex). No aggregate asymptotic claim from that manuscript is used. A nonnegative local rounding loss is not a bound for the remaining prime Euler-product fluctuation.

## Finite arithmetic conjugation

For Dirichlet convolution, define $Tf=f\log+\Lambda*f$. [ArithmeticTransport](../../formalization/BuildingBlocks/ArithmeticTransport.lean) proves

```math
\mathbf1*(Tf)=(\mathbf1*f)\log.
```

Thus this finite divisor transform conjugates $T$ to multiplication by $\log n$. Its coefficient-space kernel is generated by $\mu$. [FiniteTransport](../../formalization/BuildingBlocks/FiniteTransport.lean) makes the distinction between coordinate and Hilbert-space symmetry explicit: the first nontrivial matrix is $\bigl(\begin{smallmatrix}0&0\\ \log2&\log2\end{smallmatrix}\bigr)$, which is not symmetric and cannot be made symmetric by a positive diagonal weight. The Gram matrix $\bigl(\begin{smallmatrix}2&1\\1&1\end{smallmatrix}\bigr)$ obtained by pulling back the divisor coordinates does symmetrize it. These finite eigenvalues do not describe zeta zeros.

[MobiusVaughan](../../formalization/BuildingBlocks/MobiusVaughan.lean) formalizes the exact split $\mu=2\mu_{\le U}-\mu_{\le U}*\mu_{\le U}*\mathbf1+\mu_{>U}*\mu_{>U}*\mathbf1$. It follows by expanding $\mu=\mu_{\le U}+\mu_{>U}$ and using $\mu*\mathbf1=\delta_1$. It is a classical convolution decomposition, not an estimate of its bilinear remainder.

The mathematical ingredients are elementary divisibility, multiplicative functions, finite summation, variance and integration. Existing mathlib results supply CRT, arithmetic-function identities and analytic infrastructure; upstream dependencies retain their licenses. The linked statements specify the exact finite specializations formalized here.
