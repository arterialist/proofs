# Simultaneous carry compensation and the original heat charge

The exact Bernoulli multiplication law permits compensation before summing the complete arithmetic family. The compensated Möbius and actual prime-minus-density carrier works have global polynomial bounds and absolutely summable tails. Their common modes are retained exactly. No small summatory Möbius quantity or automatic density cancellation is assumed, and these carrier works are not identified with the full renewal dissipation.

## Common and dilated phases

Write

    B_1(x)={x}−1/2,
    U(x)=({x}²−{x})/2=−{x}(1−{x})/2.

U is continuous and periodic, U'=B_1 almost everywhere, U is zero at integers, and |U|≤1/8. The actual integer carry primitive is exactly

    Ξ_m(x)=mU(x)−U(mx)/m.                         (1)

Both sides have derivative mB_1(x)−B_1(mx)=ξ_m(x) and vanish at x=1, so this identity retains every cell endpoint. It is the Bernoulli B_2 formula with its constant 1/6 explicitly subtracted.

For the genuine heat response b and w(x)=|b(log x)|²/x, define

    I_*(T)=∫_1^(exp T)B_1(x)w(x)dx,
    I_m(T)=∫_1^(exp T)[mB_1(x)−B_1(mx)]w(x)dx.

Then

    I_m(T)−mI_*(T)=−∫_1^(exp T)B_1(mx)w(x)dx.

Integration by parts using U(mx)/m gives exactly

    I_m−mI_* =−U(m exp T)w(exp T)/m
                       +(1/m)∫_1^(exp T)U(mx)w'(x)dx.     (2)

The starting trace U(m)w(1)/m is zero for integer m. Fractional terminal traces remain. At integer exp(T) the terminal trace also vanishes.

The [reviewed global heat bounds](integer-carry-heat-work-and-weight-obstruction.md) using only Λ(n)≤log n give

    w(exp T)≤(T+3)²,
    ∫_1^(exp T)|w'(x)|dx≤(5/3)T³+19T²+69T.

Put D(T)=(T+3)²+(5/3)T³+19T²+69T. Equation (2) therefore yields the simultaneous family estimate

    |I_m−mI_*|≤D(T)/(8m).                        (3)

The common O(m) phase has been separated exactly, rather than bounded independently for each history.

## Complete Möbius family: a bounded residual and an unestimated coefficient

The actual causal division inverse has coefficients μ(m)/√m. All arithmetic sums in this section start at m=1. For every finite integer M≥2,

    Σ_(m≤M) μ(m)I_m/√m
        =I_*(T) B_μ(M)+R_μ(M,T),
    B_μ(M)=Σ_(m≤M)μ(m)√m,
    R_μ(M,T)=Σ_(m≤M)μ(m)[I_m−mI_*]/√m.          (4)

Since |μ(m)|≤1, equation (3) proves absolute convergence of the complete compensated residual, with

    |R_μ(∞,T)|≤(D(T)/8)Σ_(m≥1)m^(−3/2),
    |R_μ(∞,T)−R_μ(M,T)|≤D(T)/(4√M).             (5)

The m=1 carry is zero but its decomposition has opposite common and residual terms; it is retained in (4). No estimate for B_μ(M) follows from (5). For the actual source I_*(T) is strictly negative at sufficiently small positive T. To prove the required nonzero trace without numerical brackets, put q=e^(−1)<1/2. The complete coefficient bound Λ(n)≤log n≤n−1 gives

    P(1)≤Σ_(n≥1)(n−1)q^n=q²/(1−q)²<2q.

The strict inequality is equivalent to (2q−1)(q−2)>0, which holds for 0<q<1/2. Thus b(0)=P(1)−2q<0. By continuity b remains nonzero near zero, while B_1(x)<0 on (1,3/2). Hence I_*(T)<0 for sufficiently small T>0. The common mode does not vanish identically on this source.

With A(x)=Σ_(m≤x)μ(m)/m, partial summation retains the terminal exactly:

    B_μ(M)=M^(3/2)A(M)−(3/2)∫_1^M sqrt(x)A(x)dx.    (6)

This is the still-unestimated weighted Möbius quantity in this concrete carrier. Treating B_μ as small would add an unsupported arithmetic hypothesis.

## What the actual renewal inverse does to the continuum density

Let ν=Σm^(−1/2)δ_(log m), κ=exp(u/2)1_(u≥0)du, and ν_μ=Σμ(m)m^(−1/2)δ_(log m). These are locally finite causal measures. Exact integer convolution gives

    ν_μ*ν=δ_0,
    ν_μ*κ=exp(u/2)A(exp u)1_(u≥0)du,
    ν_μ*(ν−κ)=δ_0−exp(u/2)A(exp u)1_(u≥0)du.    (7)

Thus the continuum counterpart is not zero after Möbius inversion. The original density term survives with its actual finite partial Möbius coefficient and its origin atom. For a finite horizon T, the adjoint of this difference sends a test a(s) to

    a(s)−∫_s^T a(v)exp((v−s)/2)A(exp(v−s))dv.

It retains both terminal limit and causal lower endpoint. The original negative-time history, when moved to the forcing, is an additional specified term. Equations (4) and (7) do not identify the quadratic carry work with this actual retarded adjoint; such an identification requires proof.

Marking the complete histories by log m gives ν_μ*(logν)=ΣΛ(m)m^(−1/2)δ_(log m), because μ*log=Λ. This produces the original prime-power coefficients rather than making A disappear.

## The original heat charge: exact density and atom cancellation

For an integer cutoff M≥1, the actual centered heat charge is the signed measure

    α_M=Σ_(2≤n≤M)Λ(n)δ_n−δ_1−1_[1,M](r)dr.

Writing P_M(t)=Σ_(n≤M)Λ(n)e^(−nt), its exact Laplace transform for t>0 is

    ∫e^(−tr)dα_M(r)=P_M(t)−e^(−t)−[e^(−t)−e^(−Mt)]/t.

Thus the terminal e^(−Mt)/t remains. As M tends to infinity this gives exactly the original P(t)−(1+t^(−1))e^(−t); the complete prime heat series converges at every t>0. This identifies the charge with the original heat source, not with its quadratic dissipation. Dropping the finite terminal term before that limit would change the cutoff source.

For real r≥1 define the explicit phase carrier I_r by replacing m with r in mB_1(x)−B_1(mx). For noninteger r this is a phase extension, not the literal floor carry floor(r{x})−(r−1)/2. The real extension is needed for the continuum density. It obeys (2) with the additional starting trace +U(r)w(1)/r. Let E(T)=D(T)+9, using w(1)≤9. Then

    |I_r−rI_*|≤E(T)/(8r), r≥1.

The carrier of the actual original heat charge has the exact decomposition

    W_M(T):=∫r^(−1/2)I_r(T)dα_M(r)
          =I_*(T)B_Λ(M)+R_Λ(M,T),
    B_Λ(M)=Σ_(n≤M)Λ(n)√n−1−∫_1^M sqrt(r)dr.     (8)

All actual prime powers, the origin-counting atom, the continuum density, and the real-dilation starting traces remain. Even though I_1=0, the atom's common and residual terms cancel in (8); it cannot be silently removed from the decomposition.

The compensated residual converges absolutely through the entire signed heat charge, with

    |R_Λ(∞,T)|≤(E(T)/8)[Σ_nΛ(n)n^(−3/2)+3],
    |R_Λ(∞,T)−R_Λ(M,T)|
          ≤E(T)(2log M+6)/(8√M), integer M≥8.    (9)

The tail uses Λ(n)≤log n, the decreasing log x/x^(3/2) for x≥8, and the continuum tail ∫_M^∞r^(−3/2)dr=2/√M. No Mertens cancellation or RH-scale bound is imported.

The common density and atom cancel their deterministic main term exactly. With e(x)=ψ(x)−x, Stieltjes partial summation in (8) gives

    B_Λ(M)=sqrt(M)e(M)−(1/2)∫_1^M e(x)/sqrt(x)dx.    (10)

The constant −δ_1 is essential for the displayed exact cancellation, including at M=1. The remaining coefficient is a weighted actual prime error with its frozen endpoint, not zero and not controlled by (9). Equivalently its arithmetic sum can be expanded using Λ=μ*log, retaining the coherent logarithmic cofactor and every multiplicative history.

Equations (5) and (9) give closed simultaneous polynomial bounds for compensated complete carrier works. Equations (6), (7), and (10) expose precisely the common-mode arithmetic quantities and endpoint terms still needed to turn them into an original-energy estimate. Neither the compensations nor their tail bounds prove RH, lower its original heat-energy exponent, or establish automatic cancellation in the full renewal adjoint.

## Attribution and formal scope

The Bernoulli primitive, Möbius convolution, partial summation and exponential sums are classical. RH Agent2 supplied the simultaneous compensation and the complete arithmetic residual estimates. The root review checks the constants, real-dilation initial traces, prime-power coefficients, integer-cutoff tails and origin atom, states the exact cutoff Laplace transform with its terminal term, and proves the nonzero actual initial heat trace by a complete geometric-series bound. These are reviewed written proofs awaiting Lean formalization; no numerical certificate, new axiom, novelty claim or RH conclusion is asserted.

The [growing-mode limitation](integer-carry-heat-work-and-weight-obstruction.md#growing-modes-pass-all-these-carry-tests) concerns carry bounds without the actual source relation. The present coupled coefficient decomposition is additional arithmetic information, but its weighted common coefficient and identification with a full original-energy consumer remain unresolved. The earlier mode test neither refutes this decomposition nor supplies those missing steps.

[Formal initial heat trace](BuildingBlocks/GoldbachHeatInitialTrace.lean) proves five unconditional theorems: a complete geometric majorant for the actual prime-power heat series at every positive time, negativity of the atom-and-continuum centered source at t=1, and negativity and continuity of its literal logarithmic-time profile at v=0, with negativity throughout a neighborhood. Every von Mangoldt coefficient remains; no finite numerical truncation, RH bound or carry-work identification is assumed. The complete carry energy and compensation proofs remain additional Lean obligations.
