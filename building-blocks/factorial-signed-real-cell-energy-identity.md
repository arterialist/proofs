# Signed real-cell reconstruction of the full factorial energy

This continues the actual integer sampling failure and first-cell trace calculation. It derives an exact response and energy identity using every real quotient jump, with the full compensated factorial density. It supplies no upper estimate or RH proof. The test-function inversion is classical finite divisor convolution; it does not solve the integer constraints back to the actual coefficients or claim a new inversion method.

Let N≥2, A_q=Σ_{n≤N:floor(N/n)=q}μ(n), and

F_N(x)=Σ_q A_q floor(q/x), x≥1,
G_N(t)=Σ_q A_q(1−e^(−qt)), t>0,
w(t)=t^(−2)−[t(e^t−1)]^(−1).

All q are positive integers at most N. The complete constraints give F_N(k)=1 for 1≤k≤N, and F_N(k)=0 for k>N. Write D_N(x)=F_N(x)−1 on [1,N]. This signed real-cell discrepancy is not zero almost everywhere merely because its integer samples vanish.

## A continuous test that cancels the origin jump

Put f_t(x)=1−e^(−xt), h_t(x)=f_t(x)−x f_t(1), and

Φ_t(x)=Σ_{1≤j≤x} μ(j)h_t(x/j), x≥1.                 (1)

Because h_t(1)=0, Φ_t is continuous at every integer where a summand enters. It is absolutely continuous on [1,N], with almost-everywhere derivative

Φ'_t(x)=Σ_{j≤x} μ(j)/j [t e^(−xt/j)−f_t(1)].         (2)

Finite divisor convolution gives, for each integer q≥1,

Σ_{j=1}^q Φ_t(q/j)
 =Σ_{m=1}^q h_t(q/m)Σ_{d|m}μ(d)=h_t(q).             (3)

This inversion acts on the test function of the real quotient coordinate. It retains every rational quotient q/j in the jump pairing, rather than recovering A from its integer rows.

The signed real jump measure is

λ_N=Σ_q A_q Σ_{j=1}^q δ_(q/j).                       (4)

On the open interval (1,∞), the distributional derivative of F_N is −λ_N restricted there. Pointwise floor values at jumps are left values; they do not affect Lebesgue integrals. At the origin λ_N({1})=Σ_q A_q=M(N). This atom is present in (4), but its pairing with Φ_t is exactly zero because Φ_t(1)=0. At the far endpoint the atom at N is retained, and F_N vanishes to its right.

Using the exact first row Σ_q A_q q=1, (3) yields

G_N(t)−f_t(1)=∫_[1,N] Φ_t(x)dλ_N(x)
             =∫_1^N F_N(x)Φ'_t(x)dx.               (5)

The last equality follows either from integration by parts with the stated one-sided endpoints or directly from each step floor(q/x): its jumps q/j>1 contribute Φ_t(q/j), and its interval integral against Φ'_t has the same telescoping value, since Φ_t(1)=0. Thus no origin or terminal jump is discarded.

Define C_N(t)=f_t(1)+Φ_t(N). The exact signed reconstruction is

G_N(t)=C_N(t)+∫_1^N D_N(x)Φ'_t(x)dx.                (6)

The constant interpolation of the complete integer samples supplies the C_N term. Their unsampled phases supply the signed integral, with no asserted contraction.

## Full positive-axis energy and retained signed work

Define

Q_C(N)=∫_0^∞ C_N(t)^2w(t)dt,
L_N(x)=∫_0^∞ C_N(t)Φ'_t(x)w(t)dt,
K(x,y)=∫_0^∞ Φ'_t(x)Φ'_t(y)w(t)dt.                 (7)

Squaring (6) and integrating gives

Q_N=Q_C(N)
    +2∫_1^N D_N(x)L_N(x)dx
    +∫_1^N∫_1^N D_N(x)D_N(y)K(x,y)dxdy.            (8)

The last term is the entire nonnegative phase energy

∫_0^∞ [∫_1^N D_N(x)Φ'_t(x)dx]^2w(t)dt≥0.           (9)

It retains all signed cross-cell products. Positivity of K means positivity after the complete quadratic pairing, not a sign for each offdiagonal value. The mixed term in (8) remains signed and is a possible compensation term. Dropping it cannot be justified by the integer sample constraints.

All exchanges in (5)–(9) are legitimate at fixed N. Uniformly for 1≤x≤N, (2) is O_N(t²) near zero: t e^(−at)−(1−e^(−t))=O_N(t²) for a=x/j in [1,N]. Also C_N(t)=t+O_N(t²). At infinity Φ'_t(x) and C_N(t) are uniformly bounded in x at fixed N, using t e^(−at)≤t e^(−t). Since w(t)=O(1/t) near zero and O(1/t²) at infinity, the products in (7) have integrable uniform majorants. D_N is a bounded finite step function on the compact x interval. Fubini therefore applies to the mixed and double integrals, including their absolute values. No infinite unproved source bound is introduced.

## Explicit density-minus-factorial phase kernel

For a,b≥1 set

P(a,b)=∫_0^∞ [t e^(−at)−f_t(1)][t e^(−bt)−f_t(1)]w(t)dt.

The complete real gamma extension B(a,b) of the published factorial kernel gives

P(a,b)=1/(a+b)−ψ'(a+b+1)
       −log(1+1/a)+1/(a+1)
       −log(1+1/b)+1/(b+1)+log2.                    (10)

Indeed its four terms are ∂_a∂_b B(a,b), −∂_a B(a,1), −∂_b B(1,b), and B(1,1). Here B(a,1)=a log(1+1/a), B(1,1)=log2, and the mixed derivative is 1/(a+b)−ψ'(a+b+1). Differentiation under the integral is justified by the same positive-axis exponential majorants. Thus the exact kernel in (8) is

K(x,y)=Σ_{j≤x,l≤y} μ(j)μ(l)/(jl) P(x/j,y/l).         (11)

Both the trigamma contribution and its compensating density remain in (10). The finite sums retain every inverse-test divisor pair. There is no replacement by only a factorial valuation, a diagonal kernel, or independent quotient directions.

## What remains uncontrolled

The baseline is not an elementary bounded forcing. Writing A_inv(N)=Σ_{j≤N}μ(j)/j, (1) gives

C_N(t)=(1−N A_inv(N))f_t(1)+Σ_{j≤N}μ(j)f_t(N/j),
lim_(t→∞) C_N(t)=1+M(N)−N A_inv(N).                 (12)

These complete signed quantities have not been bounded at the required scale. For comparison, G_N tends to M(N); (6) then forces the phase integral to tend to N A_inv(N)−1. This terminal cancellation is retained exactly and cannot be erased by declaring the integer samples constant. At the other end both G_N and C_N have slope one, so the phase term is O_N(t²).

The earlier first-cell identity remains compatible with (8): on 1<x≤N/(N−1), D_N(x)=−M(N). Its normalized squared mass is M(N)². Equation (8) does not replace this mass by a positive reserve bounded CN; it pairs it with the actual test derivative and retains mixed work with every other cell.

The complete product-boundary rectangles R(k,l)=Δ_kΔ_l F_N(kl) telescope to total signed mass one, as RH Proof checked, but have both signs at actual N=13. Conservation alone provides no upper bound on their absolute or quadratic costs. Equation (8) instead identifies a signed real-cell work and its complete quadratic cost. No estimate on the mixed work, Q_C, or their sum has been obtained. The identity leaves signed real-cell and boundary compensation available while proving none.

For implementation corroboration only, direct rational-breakpoint cell sums reproduced (5) at N=2,4,13,27,60 for three positive times each. These finite floating-point checks do not establish an all-scale bound; the written finite-convolution and step-function proof establishes the identity. No additional Lean formalization or novelty claim is made.

## Independent review: scalar positivity before Möbius weighting

The root reviewed the finite test convolution, step-function integral, origin and terminal conventions, absolute Fubini majorants, and the four differentiated gamma-kernel terms. In particular the floor integral for a single integer q pairs all q/j>1 with Φ_t(q/j); the q/j=1 term is present and zero because Φ_t(1)=0. The endpoint q=N is included. This verifies the written reconstruction without identifying its mixed work with a favorable sign.

For a≥1 and t>0 put s_a(t)=1−e^(−t)−t e^(−at). The elementary strict inequality e^t>1+t gives

    0<t e^(−at)≤t e^(−t)<1−e^(−t),
    0<s_a(t)<f_t(1).

Hence P(a,b)=∫s_a(t)s_b(t)w(t)dt obeys

    0<P(a,b)<∫f_t(1)²w(t)dt=log 2,  a,b≥1.

Strict positivity and the strict upper bound follow on any compact positive t interval, where the continuous integrands and w are strictly positive. Integrability follows from domination by f_t(1)²w. If a increases strictly, s_a increases strictly for every t>0. Thus P is strictly increasing in each argument. Dominated convergence gives P(a,b)→log 2 as both a and b tend to infinity. No density or trigamma term is discarded in these conclusions.

Let H(x)=Σ_{j≤x}1/j. The complete signed kernel therefore has the elementary bound

    |K(x,y)|≤(log 2)H(x)H(y),
    0≤Q_phase≤(log 2)[∫_1^N |D_N(x)|H(x)dx]².

The first inequality retains every signed inverse-test pair and uses |μ(j)|≤1. The second follows from the complete quadratic identity and absolute integration. The weighted real discrepancy in this estimate is uncontrolled; this bound is not a subpower or linear estimate for the actual factorial energy. Scalar positivity of P does not remove the signs μ(j)μ(l) in K or the signs of D_N in its pairing. The exact mixed term and baseline in (8) remain essential.

RH Agent2 supplied the signed real-cell reconstruction with an independent bounded mathematical audit. The root supplied the endpoint and analytic review and the scalar monotonicity, strict bounds, limit, and complete elementary kernel estimate above. These are reviewed written proofs; their Lean formalization and the arithmetic energy upper bound remain open.

[Formal scalar real-cell phase bounds](BuildingBlocks/FactorialRealCellPhase.lean) proves five unconditional theorems for the literal phase s_a(t)=1−exp(−t)−t exp(−at). For a≥1 and t>0 it is strictly positive and strictly less than the unit heat response; it is strictly increasing in a. Its complete product is positive and less than the unit response squared, including after multiplication by the original compensated factorial density. The upper row is identified with the existing full kernelRow(1,1), providing a pointwise majorant for future integral proofs. The integrated phase kernel bounds, real-cell reconstruction and signed arithmetic energy estimate remain further Lean obligations; no Möbius signs are removed and no RH bound follows.
