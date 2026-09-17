# A positive three-rate plane for the complete actual-prime Weil form

**Status:** independently audited written analytic proof (18 September
2026). The rational Gram determinant factorization and its positive-sign
implication are
[Lean compiled](../../formalization/BuildingBlocks/ThreeRateWeilGramAlgebra.lean)
with only standard Lean axioms; the derivative algebra was checked
symbolically. The low-zero and constant comparisons have a rigorous
[Arb/exact-rational certificate](../../certificates/three_rate_weil_xi_signs.py).
The analytic bridge is not formalized in Lean. This result signs a fixed
three-dimensional plane, not arbitrary tests, and does not prove RH.

Let `F(a)=xi'(1/2+a)/xi(1/2+a)` and
`K(a,b)=(F(a)+F(b))/(a+b)` for real `a,b>1/2`. The
[two-rate theorem](complete-weil-two-exponential-rate-positive-plane.md)
establishes this exact complete Weil Gram kernel from the actual
von Mangoldt weights, including every proper prime power and the
gamma and pole terms. For every three distinct rates `a<b<c`, its
Gram matrix is strictly positive definite. Thus each fixed complex
three-dimensional plane of compactly truncated exponentials is
positive for all sufficiently large common cutoffs.

## Exact determinant reduction

Put `t_i=a_i^2`, `H(t)=sqrt(t) F(sqrt(t))`, and `J(t)=sqrt(t)/F(sqrt(t))`. Direct rational expansion gives

`det[K(a_i,a_j)] = [F(a)F(b)F(c)/(abc)] (b-a)^2(c-a)^2(c-b)^2 H[t_a,t_b,t_c] J[t_a,t_b,t_c]`,

where brackets denote the second divided difference. This rational
identity was independently checked by symbolic expansion for arbitrary
rates and `F` values. The Lean file clears the rational denominators
explicitly and proves determinant positivity from the two signed
divided-difference numerators; their signs are supplied below. The 1x1
and 2x2 principal minors are positive
by the [two-rate theorem](complete-weil-two-exponential-rate-positive-plane.md).
Thus strict concavity of both `H` and `J` proves the assertion.

The zero-packet formula in the two-rate theorem makes `H` strictly
concave. A critical pair contributes `H=2t/(t+gamma^2)`. An off-line
quartet contributes `H=4t(t+p)/(t^2+2pt+q^2)` because its contribution
to `F` is `2g_delta,gamma`, where `p=gamma^2-delta^2>0`,
`q=gamma^2+delta^2`, and `q^2<=2p^2` by finite-height verification
and the critical strip. Its second derivative is

`H''=-8 [q^2(2p^2-q^2)+3pq^2 t+3q^2 t^2+p t^3]/(t^2+2pt+q^2)^3 < 0`.

Positive multiplicities and locally uniform differentiated convergence give `H''<0` for the actual `F`.

## Strict concavity of J on 1/4 <= t <= 10^4

Set `S(t)=F(sqrt(t))/(2sqrt(t))`, so `J=1/(2S)` and `J''=-(S S''-2(S')^2)/(2S^3)`. Let `T=3*10^12`. Write `S=S0+R`, where `S0` moves every hypothetical off-line quartet at ordinate `gamma>T` horizontally onto the critical line, with the same multiplicity. It is a positive Stieltjes sum

`S0(t)=sum_j w_j/(t+gamma_j^2)`, `w_j>0`.

Therefore

`C0:=S0 S0''-2(S0')^2 = 2 sum_{i<j} w_i w_j (gamma_i^2-gamma_j^2)^2/[(t+gamma_i^2)^3(t+gamma_j^2)^3]`.

There is a critical zero in each of `(14,15)` and `(21,22)`.
This does not rely on rounded zero tables: rigorous `python-flint==0.9.0`
Arb ball
evaluation of the real entire function `Xi(y)=xi(1/2+i y)` gives
`Xi(14)>0`, `Xi(15)<0`, `Xi(21)<0`, `Xi(22)>0`. The real-part
balls at 50 decimal digits are respectively
`[0.0002012944442352575... +/- 6.06e-53]`,
`[-0.0007056979588215474... +/- 1.98e-52]`,
`[-3.9774919877827035...e-7 +/- 3.55e-55]`, and
`[7.716314799755667...e-6 +/- 5.75e-54]`.
The functional equation and conjugation make `Xi(y)` real, so
continuity gives a zero in each open interval. The
[reproducible certificate](../../certificates/three_rate_weil_xi_signs.py)
uses `python-flint==0.9.0` and exact rational checks for the
elementary constants below.
[Platt--Trudgian](https://arxiv.org/abs/2004.09765) independently
certify that all zeros through `T` are on the critical line.

These two zeros alone imply, for `1/4<=t<=10^4`,

`C0 >= 2*216^2/[(t+225)^3(t+484)^3] > 7.5*10^-20`.

For one off-line quartet let `u=t+gamma^2` and `Delta=-delta^2+2i gamma delta`. Its contribution to `R` is

`(u+Delta)^-1+(u+conj(Delta))^-1-2u^-1`.

For `n=0,1,2`, Taylor's formula along the two complex segments, `|delta|<1/2`, `gamma>T`, `|Delta|^2<=2gamma^2`, and `u-|Delta|>=gamma^2/2` imply

`|R_packet^(n)(t)| <= 2000 gamma^(-2n-4)`.

Indeed with `m=n+1` the sharper displayed bound is

`n! [2m delta^2/u^(m+1) + m(m+1)|Delta|^2/(u-|Delta|)^(m+2)]`,

whose coefficient is at most 1539 for `n<=2`. Multiplicity is inserted linearly. Trudgian's Corollary 1 gives, with `T0=e`,

`N(U) <= [U/(2pi)] log[U/(2pi e)] + 7/8 + 0.111 log U + 0.275 loglog U + 2.450 + 0.2/e`.

For `U>=T`, use `pi>3`, `log U<=U`, `loglog U<=U`, and `0.2/e<0.1`
to obtain `N(U)<U^2/6+0.386U+4<U^2`. Endpoint zeros are covered by
taking a right limit. Dyadic summation, counting off-line packets
no more often than positive-ordinate zeros, gives

`|R^(n)| <= [8000/(1-2^(-2n-2))] T^(-2n-2)`.

Consequently `|R|<1.2*10^-21`, `|R'|<1.1*10^-46`, and
`|R''|<1.2*10^-71` on the finite interval. At `t=1/4`,
`S(t)=F(1/2)=1+EulerGamma/2-log(4pi)/2`. Here is an elementary
strict upper bound with a certified margin. The sequence
`H_n-log(n+1/2)` decreases to Euler's constant by convexity of
`1/x`, so `EulerGamma < H_10-log(21/2)`. The 20-term exponential
series with a geometric tail certifies `exp(2351/1000)<21/2`,
hence `EulerGamma < H_10-2351/1000=9103/15750`.
Machin's arctangent identity and four alternating terms give
`pi>3141/1000`; the same 20-term exponential bound gives
`exp(253/100)<3141/250<4pi`, hence `log(4pi)>253/100`.
Therefore

`S(1/4)=F(1/2)<1+(9103/15750)/2-(253/100)/2=1511/63000=0.023984126...`.

Since `|R(1/4)|<1.2*10^-21`, this certifies `S0(1/4)<0.024`. Since `S0` is Stieltjes and `t>=1/4`, `S0<=0.024`, `|S0'|<=0.096`, `S0''<=0.768`. Expanding `C=S S''-2(S')^2` around `C0`, the error is less than `10^-21`; thus `C>0` and `J''<0` throughout `1/4<=t<=10^4`.

## Strict concavity of J for a=sqrt(t)>=100

For `s=a+1/2>=100.5`, put `Z(s)=zeta'(s)/zeta(s)` and write

`F(a)=1/s+1/(s-1)-log(pi)/2+psi(s/2)/2+Z(s)`.

Euler's absolutely convergent series gives `Z^(k)(s)=(-1)^(k+1) sum_{n>=2} Lambda(n)(log n)^k n^-s` for `k=0,1,2`. Using `Lambda(n)<=log n` and `(log n)^j<=n^2` for `j=1,2,3`,

`|Z^(k)(s)| <= sum_{n>=2}n^(2-s) < 5*2^-s`.

For the last inequality, the `n=2` term is `4*2^-s` and the remaining
decreasing tail is at most the integral from 2 to infinity,
`[8/(s-3)]*2^-s < 2^-s`.

Elementary sum/integral comparisons yield `psi(x)>=log x-1/x`, `1/x<=psi'(x)<=1/x+1/x^2`, and `psi''(x)>=-2/x^3-1/x^2` for `x>0`. These give, for all `a>=100`,

`F(a)>1.3`, `F'(a)>0`, `a F'(a)<0.6`, `a^2 F''(a)>-0.6`.

For clarity, the displayed bounds imply the explicit inequalities

`F(a)>=0.5 log(s/(2pi))-5*2^-s>1.3`,

`F'(a)>=1/(2s)-1/s^2-1/(s-1)^2>0`,

`a F'(a)<=a/(2s)+a/s^2+5a*2^-s<0.6`,

`a^2 F''(a)>=-a^2/(2s^2)-5a^2*2^-s>-0.6`.

These hold for `s=a+1/2>=100.5`. The exact-rational certificate
checks `pi<22/7`, `exp(2.7)<175/11`, and generous left-endpoint
bounds for the exponential terms. The exponentially small terms
are bounded at the left endpoint because `s^2*2^-s` decreases on
this range. Direct differentiation yields

`J''(t)=-E(a)/(4a^3 F(a)^3)`,

`E(a)=F(a)^2+aF(a)F'(a)+a^2F(a)F''(a)-2a^2(F'(a))^2`.

Thus `E(a)> F(a)^2-0.6F(a)-0.72 >= 1.3^2-0.6*1.3-0.72=0.19`. Hence `J''<0` for `a>=100`.

## Scope and references

The proof uses only the actual completed-zeta identity, critical strip, explicit zero count, rigorous RH verification to height `3*10^12`, and two distinct verified low critical zeros; it does not assume RH. A hypothetical high off-line quartet remains compatible with the theorem. The compact cutoff bridge for each fixed finite rate set is by entrywise convergence of the complete Weil Gram, already written for two rates in `1188f85`.

The analytic inputs are the finite-height theorem of
[Platt--Trudgian](https://arxiv.org/abs/2004.09765) and
[Trudgian's zero-count Corollary 1](https://arxiv.org/html/1208.5846v2).
The [python-flint Arb documentation](https://python-flint.readthedocs.io/en/stable/arb.html)
describes the validated ball arithmetic used by the certificate.
[Polson's heat-trace work](https://arxiv.org/html/1708.02653v24)
proves unconditional positivity of large finite Hankel blocks formed
from derivatives of the squared-zero heat trace. Those heat-moment
blocks are different from the causal-exponential Weil Gram `K(a,b)`
studied here. No literature-priority claim is made for the three-rate
consequence.
