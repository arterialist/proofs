# Dyadic factorial floor intersections and exact periodic boundary ports

The whole dyadic factorial energy has an exact joint floor-intersection kernel. For its rounding phases, full-period integer compatibility gives a Jordan-totient square formula, rather than an unspecified Möbius pair correlation. But an actual dyadic block generally is not a full residue period: coprime phases already have nonzero covariance on the actual block [2,4). The signed boundary prefixes are explicit and cannot be discarded. These identities do not establish the open dyadic energy upper bound.

## Whole dyadic kernel with all floors retained

Fix integer X≥1 and Y=2X−1. Extend the original quotient sizes by zero when n>N. Since B(0,a)=0, the actual complete average is

Σ_{N=X}^{2X−1}Q_N=Σ_{n,m≤Y}μ(n)μ(m)K_X(n,m),

K_X(n,m)=Σ_{a,b≥0}B(a,b)C_X(n,m;a,b),   (1)

where the exact integer intersection count is

C_X=max{0,min(2X,(a+1)n,(b+1)m)−max(X,an,bm)}.   (2)

Indeed floor(N/n)=a precisely on [an,(a+1)n), with the same convention in the second coordinate. All endpoints are integer and the intersection length equals its number of integers. Only finitely many a,b contribute. The zero-size rows are explicitly present and contribute zero, not an omitted history.

The kernel B is the original entropy-minus-log-binomial kernel, equivalently its full positive integral against w(t)=t^(−2)−[t(e^t−1)]^(−1). Formula (1) therefore retains every ordered pair, the full factorial prime-power valuations, density compensation, and the entire positive clock. Positivity of this averaged kernel is immediate from the original integral but is only a lower bound.

## Full-period two-dimensional phase compatibility

Define the centered discrete rounding phase

z_n(N)={N/n}−(n−1)/(2n).

Its mean over a complete residue period is zero. For L=lcm(n,m), let g=gcd(n,m). Direct residue counting gives

(1/L)Σ_{N=0}^{L−1}z_n(N)z_m(N)=(g²−1)/(12nm).   (3)

To prove this, write n=ga,m=gb with coprime a,b. Compatible residue pairs have r=c+gi and s=c+gj, c=0,...,g−1, i=0,...,a−1, j=0,...,b−1. Each occurs exactly once. Conditional on c, i and j are independent uniform variables. Their conditional fractional means vary as c/n and c/m, so the covariance is Var(c)/(nm)=(g²−1)/(12nm). This is a two-dimensional integer compatibility calculation before taking absolute values.

For any finite real coefficients v_n supported on n≤Y, averaging their common phase R(N)=Σv_nz_n(N) over the common period lcm(1,...,Y) gives

V_period=(1/12)Σ_{d=2}^Y J_2(d)[Σ_{n≤Y:d|n}v_n/n]²,   (4)

where J_2 is the Jordan totient of order two. The identity Σ_{d|g}J_2(d)=g² converts (3) into (4). Its d=1 term is subtracted exactly by the −1 in g²−1. Coprime covariance is zero in a full period; common divisors produce the indicated positive square structure. With v_n=μ(n), (4) is an actual arithmetic constraint without an unknown generic μ(n)μ(m) correlation. It supplies no upper bound for the original kernel (1).

The positive divisor-load factorization does give an unconditional full-period phase upper bound. With H_q=Σ_{j=1}^q1/j, the elementary estimates |μ(n)|≤1 and J_2(d)≤d² imply

V_period≤(1/12)Σ_{d=2}^Y H_floor(Y/d)²
        ≤(1/12)Σ_{d=1}^Y[1+log(Y/d)]²≤5Y/12.   (4a)

For the last inequality, x↦(1−log x)² is decreasing on (0,1], so its right-endpoint Riemann sum is at most its integral, which equals 5. This uses no cancellation estimate for μ. The coefficient support is fixed at n≤Y throughout the very long common residue period; outside N≤Y the actual divisor forcing Σ_{n≤Y}μ(n)floor(N/n)=1 need not hold. Neither this full-period phase bound nor its positive factorization bounds the short dyadic energy. The signed incomplete-period ports below remain essential.

## Exact dyadic boundary prefixes

For each pair define the centered periodic prefix

P_(n,m)(R)=Σ_{N=0}^{R−1}[z_n(N)z_m(N)−(g²−1)/(12nm)], R≥0 integer.

Its period is lcm(n,m), with P(0)=P(L)=0. The actual whole block satisfies

Σ_{N=X}^{2X−1}z_n(N)z_m(N)
 =X(g²−1)/(12nm)+P_(n,m)(2X)−P_(n,m)(X).   (5)

Summing against the literal μ(n)μ(m) retains a definite signed boundary term. Neither the pair periods nor their common full period are generally contained in the dyadic interval. Moreover the actual B-floor kernel itself is not periodic, since floor(N/n) increases by L/n over a residue period. Thus (3) is a constraint on phases, not permission to replace (1) by a periodic covariance kernel.

A concrete full-block decorrelation proposal would assign zero coprime phase covariance after dyadic averaging, mirroring (3). It is false already at actual X=2 for n=2,m=3. At N=2 the phases are −1/4,+1/3; at N=3 they are +1/4,−1/3. Consequently their dyadic mean product is −1/12, while their full six-point period product is zero. The actual Möbius coefficient product μ(2)μ(3)=+1, so this nonzero signed term survives in the genuine arithmetic rounding carrier. It is not produced by arbitrary substituted coefficients.

## Additional exact cancellation from all actual horizon constraints

With the fixed carrier v_n=μ(n), n≤Y, every N in the block satisfies Σ_{n≤Y}μ(n)floor(N/n)=1. Put A(Y)=Σ_{n≤Y}μ(n)/n and M(Y)=Σ_{n≤Y}μ(n). Then the actual coherent phase is exactly affine on the whole dyad:

R(N)=Σ_{n≤Y}μ(n)z_n(N)
     =(N+1/2)A(Y)−M(Y)/2−1.   (6)

Unused n>N have zero floor, but their fractional/continuous terms remain in this identity. Discarding them would alter the slope A(Y). Thus the dyadic block mean and centered variance are exactly

mean R=(3X/2)A(Y)−M(Y)/2−1,
mean |R−mean R|²=A(Y)²(X²−1)/12.   (7)

This is another whole-family arithmetic cancellation, without a random-sign or Chowla premise. Comparing (7) to (4) identifies the complete signed boundary cost in (5): the block second moment is the square of its mean plus the variance in (7), whereas the full-period second moment is (4).

For X=2,Y=3, A=1/6,M=−1, so the actual coherent block mean is zero and its variance is 1/144. The full-period variance from (4) is 1/16+2/27=59/432. The whole signed boundary contribution to the sum of phase squares is therefore −7/27. Boundary terms do not even have a universal nonnegative sign on the actual complete arithmetic carrier.

The affine phase identity and Jordan square formula characterize particular rounding observables. They do not identify them with the nonlinear factorial kernel energy or its heat response. An upper estimate for Σ_{N∈[X,2X)}Q_N still needs an integrated signed comparison with the exact intersection kernel (1), including these short-period and terminal ports. No such comparison, RH-strength upper bound, or claim of failure of every dyadic averaging mechanism is made here.

This is written mathematics based on exact finite residue counting, floor intersections, the actual divisor identity, and the published full factorial kernel. It needs no RH, PNT, Chowla theorem, or global source norm assumption.

## Attribution and formal status

Developed by RH Agent2 and its mathematical descendant, with independent root review of the floor intersections, compatible residue counting, divisor-square factorization, harmonic upper bound and signed boundary examples. These are alternate finite arithmetic derivations; no priority claim is made.

[FactorialDyadicPhase.lean](BuildingBlocks/FactorialDyadicPhase.lean) formalizes the literal discrete remainder phase as the real quotient minus the natural quotient and proves the complete coherent affine identity (6) for every 1≤N≤Y. Unused histories N<n≤Y remain in the fixed carrier. The full umbrella build passes, with only propext, Classical.choice and Quot.sound. The intersection-count kernel, complete-period covariance, Jordan square formula, period upper bound, dyadic variance and concrete boundary examples above remain written proofs requiring further Lean formalization. The nonlinear dyadic energy upper comparison remains open.

[Formal complete dyadic floor-intersection kernel](BuildingBlocks/FactorialDyadicIntersections.lean) adds seven compiled theorems: the exact positive-divisor quotient interval, the simultaneous half-open quotient fiber, its saturating cardinality, complete joint quotient distribution for a finite observable, the original compensated kernel specialization, actual energy extended to a common support, and the full original dyadic energy identity (1)–(2). The common support is 1≤n,m≤2X−1; zero-size quotient rows, all ordered signed Möbius pairs, every actual horizon X≤N<2X and the full original compensated factorial density remain. The result includes X=0 as an empty block. The full umbrella build passes with only propext, Classical.choice and Quot.sound. This discharges the intersection-count and whole-kernel reconstruction obligations. Complete-period covariance, Jordan factorization, period upper bound and signed boundary formulas remain written proofs requiring formalization. No nonlinear dyadic RH-scale upper bound is proved.
