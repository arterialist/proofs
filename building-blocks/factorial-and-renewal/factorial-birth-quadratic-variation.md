# Actual integer-birth energy: quadratic variation and signed work

Written mathematics. This uses the factorial Bernstein kernel already published in the proofs repository. The divisor-count estimate is classical; no mathematical priority claim is made. This note does not prove RH.

Let H=L²((0,∞),w(t)dt), where w(t)=t⁻²−[t(eᵗ−1)]⁻¹>0. Put g₀=0 and

g_N(t)=Σ_{n≤N} μ(n)(1−exp(−t floor(N/n))), Q_N=||g_N||²_H.

The exact integer birth is

δ_N(t)=g_N(t)−g_{N−1}(t)
       =(1−e⁻ᵗ) Σ_{d|N} μ(d)e^{−t(N/d−1)}.

Indeed, floor(N/d) changes precisely at divisors d of N; this includes the newly admitted d=N term. Every exponent is nonnegative.

Thus |δ_N(t)|≤2^{ω(N)}(1−e⁻ᵗ), where ω(N) counts distinct prime factors. The published kernel gives ||1−e⁻ᵗ||²_H=B(1,1)=log 2. Consequently

V(X):=Σ_{N≤X}||δ_N||²_H ≤(log 2) Σ_{N≤X}4^{ω(N)}
     ≤(log 2) X(1+log X)³, for integers X≥1.

For the last bound, 4^{ω(N)}≤d₄(N): assigning each complete prime-power block to one of four factors injects into ordered factorizations N=abcd. Hence Σ_{N≤X}d₄(N)≤X(Σ_{n≤X}1/n)³≤X(1+log X)³. No Möbius cancellation estimate, PNT, RH or independence assumption is used.

## Retaining collision decay improves the bound to linear

Define K_h=∫₀∞(1−e⁻ᵗ)²e^{−(h−2)t}w(t)dt for integers h≥2. Then K₂=log 2 and K_h≤9/(2h²) for every h≥2. For h≥3 use w(t)≤1/(2t), 1−e⁻ᵗ≤t and integrate t e^{−(h−2)t}/2; h/(h−2)≤3. The h=2 case follows from log 2≤1<9/8. The weight inequality follows from coth(t/2)≥2/t.

In the complete ordered divisor-pair expansion, write d=ga, e=gb, gcd(a,b)=1 and N=gabk. This parametrization is unique and N/d=bk, N/e=ak. Taking absolute Möbius coefficients, there are at most X/(abk) possible g. Therefore

V(X)≤(9X/2) Σ_{a,b≥1}1/[ab(a+b)²] Σ_{k≥1}k⁻³
    ≤(9X/8)ζ(2)²ζ(3)≤27X/4.

Here (a+b)²≥4ab, ζ(2)≤2 and ζ(3)≤3/2 suffice. All bounds are unconditional; complete divisor collisions remain before estimation. This improves the coarse divisor-count budget without estimating Mertens cancellation. Agent2 independently derives a finer signed asymptotic coefficient; that is separate from this absolute upper proof.

The exact signed-work identity is

Q_X=V(X)+2 Σ_{N≤X}〈g_{N−1},δ_N〉_H.

It follows by telescoping the Hilbert norm increment. The sum on the right retains all interactions between old histories and new integer births. Its terms need not be nonpositive. Controlling V alone does not bound Q.

More precisely, the published RH-equivalent statement Q_X=O_ε(X^{1+ε}) for every ε>0 is equivalent to the one-sided cumulative-work estimate

Σ_{N≤X}〈g_{N−1},δ_N〉_H ≤ C_ε X^{1+ε}

for every ε>0. One direction uses the unconditional V bound; the other uses V≥0 and Q=V+2 work. This equivalence is a consumer, not a proof of the work estimate.

The useful separation is exact: individual integer births have an unconditional near-linear total squared energy; the unresolved difficulty is their coherent accumulated signed work. The classical divisor bound must not be reported as an RH-closing advance.

## Independent review and formal status

Developed by the coordinating RH root and independently reviewed by the RH Proof lead. The refined proof retains all ordered divisor pairs before taking absolute values. For each pair, g=gcd(d,e), a=d/g, b=e/g and k=N/lcm(d,e) give the unique positive parametrization N=gabk with gcd(a,b)=1. Dropping coprimality and the absolute Möbius coefficients enlarges the nonnegative sum only after this exact parametrization. The number of admissible g is floor(X/(abk)); the bound uses its full upper X/(abk). The k-collision factor contributes k^(−2), so counting g leaves k^(−3). AM–GM and the elementary convergent inverse-square and inverse-cube sums give exactly 27X/4. The case h=2 is checked separately and cannot be passed through the h−2 denominator.

The complete compensated weight bound w(t)≤1/(2t) is already compiled in [FactorialOriginNeutralization.lean](../../formalization/BuildingBlocks/FactorialOriginNeutralization.lean), and the unit-response energy log 2 follows from the compiled [full kernel dictionary](../../formalization/BuildingBlocks/FactorialKernelDictionary.lean). The divisor-pair parametrization, integrated linear total-birth bound, and RH consumer above are written proofs requiring further Lean formalization. The collision bound, exact integer-birth formula, and pointwise signed-work telescope are compiled below. No compiled theorem asserting the integrated linear birth budget is claimed here. The full signed cumulative work estimate remains unproved; a linear quadratic-variation budget alone does not imply the RH energy bound.

[Compiled complete birth-collision kernel decay](../../formalization/BuildingBlocks/FactorialBirthCollisionKernel.lean) adds seven public theorems: nonnegative compensated collision rows, their full positive-clock absolute integrability, exact K₂=log 2, nonnegative integrated kernels, the complete exponential row majorant, K_h≤1/[2(h−2)²] for h≥3, and K_h≤9/(2h²) for every h≥2. The full original compensated density remains. The proof uses its compiled half-inverse upper bound, the exact full Gamma moment, and a separate h=2 calculation; no divergent h−2 denominator is used there. The full umbrella build passes with only propext, Classical.choice and Quot.sound. This discharges the collision-integral and decay obligations in the linear birth-budget proof. Complete divisor-pair parametrization, the integrated linear total budget, and its full RH consumer still require formalization; the arithmetic cumulative work upper bound remains unproved.

The literal additive birth is now formalized in `BuildingBlocks/FactorialIntegerBirth.lean`. For every natural N and every real t, it proves

δ_(N+1)(t) = (1−exp(−t)) Σ_(1≤d≤N+1, d∣N+1) μ(d) exp(−⌊N/d⌋t).

The formal statement uses an indicator on the complete common support, including d=N+1. Seven compiled theorems establish support extension, the exact quotient increment, the actual response identity, exact arrival support, the divisor-sum form, birth telescoping, and the pointwise signed-work telescope. This identifies the arithmetic births underlying the collision kernels; divisor-pair parametrization, the integrated linear variation budget, and the required signed work upper bound remain further obligations.

[Complete LCM cancellation](factorial-lcm-birth-boundary.md) now has a compiled exact finite arithmetic chain, including the full signed escaping-pair boundary identity. This retains the actual response and supplies a different consumer from estimating local birth signs. Its explicit linear interior bound, dyadic allowance, and one-sided boundary/energy transfers are compiled. The final signed arithmetic boundary estimate remains open.
