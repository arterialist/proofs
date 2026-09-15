# Growing compact Euler products and admission error

Written mathematical result developed by RH Agent3 and independently
reviewed by RH Proof on 16 September 2026. These are transport bounds,
not an arithmetic cancellation estimate or a compiled Lean theorem.

Let p be prime, r=p^(-1/2), L=log p and z=-i xi. The complete factor
and its fixed-depth compact substitute are

    u_p(z) = (1-r exp(zL))/(1-r exp(-zL)),
    v_(p,M)(z) = -r exp(zL)+(1-r^2)sum_(k=0)^(M-1)r^k exp(-kzL).

On this axis |u_p|=1. The exact omitted denominator tail gives

    u_p-v_(p,M) = (1-r^2)r^M exp(-MzL)/(1-r exp(-zL)),
    |v_(p,M)/u_p-1| <= a_(p,M) = (1+r)p^(-M/2).

Every local factor and joint product is retained in these estimates.

For any fixed integer M>=3, a_(2,M)<1 and sum_p a_(p,M)<infinity.
Indeed this sum is bounded by a constant times the convergent integer
series sum_(n>=2)n^(-M/2). Define

    c_M = product_p(1-a_(p,M)),
    C_M = product_p(1+a_(p,M)).

Both constants are finite and c_M>0. One direct proof uses
log(1+a)<=a and log(1-a)>=-a/(1-a_(2,M)). Consequently, for every
finite prime set A and every positive Fourier-weight norm,

    c_M ||F|| <= ||V_(A,M)F|| <= C_M ||F||.

The multiplier inverse has norm at most c_M^(-1). Thus the complete
growing compact product has uniform norm and inverse bounds,
regardless of how its prime cutoff grows relative to the source
cutoff. Clock contraction and fixed-filter costs can be paid before
or after this comparison, since the multipliers commute. The
comparison preserves the actual source exponent; it does not
evaluate that exponent.

Depth two behaves differently. Here a_(p,2)=1/p+p^(-3/2), and

    product_(p<=P)(1-a_(p,2))
      = product_(p<=P)(1-1/p)
        product_(p<=P)(1-1/[sqrt(p)(p-1)]).

The second product converges to a positive constant. The classical
Mertens product theorem makes the first asymptotic to exp(-gamma)/log P.
[Tao's proof of Mertens' theorems](https://terrytao.wordpress.com/2013/12/11/mertens-theorems/)
establishes this without RH. The upper product is O(log P), using
sum_(p<=P)1/p=log log P+O(1). At xi=0, u_p=1 and
v_(p,2)=1-a_(p,2), so the lower bound is attained simultaneously
at every prime. The full depth-two inverse norm therefore grows
like log P. Vanishing error of each new dyadic block does not make
the entire depth-two product approach a unitary multiplier.

For the admission estimate, take P_j=2^j P_0 and
B_j={p:P_j<p<=2P_j}. Chebyshev's prime count gives

    E_(j,M)=sum_(p in B_j)a_(p,M)=O_M(P_j^(1-M/2)/log P_j),
    epsilon_(j,M)=exp(E_(j,M))-1.

Product telescoping gives

    ||V_(B_j,M)G-U_(B_j)G||_q <= epsilon_(j,M)||G||_q.

Here q is any positive Fourier weight for which the stated norm
and bounded Hermitian archimedean form are defined. If
|Arch(F)|<=C_H||F||_q^2, polarization yields

    |Arch(V_(B_j,M)G)-Arch(U_(B_j)G)|
      <= C_H(2epsilon_(j,M)+epsilon_(j,M)^2)||G||_q^2.

Suppose the current source states satisfy the established coarse
energy hypothesis ||F_j||_q^2<=C N_j(1+log N_j), with N_j<=K P_j.
Set G_j=V_(A_(P_j),M)F_j. The uniform bound for the old compact
head then proves

    |Arch(V_(B_j,M)G_j)-Arch(U_(B_j)G_j)|
      = O_(M,K)(P_j^(2-M/2)).

For fixed M>=5 this is absolutely summable over j. The coarse
energy hypothesis suffices; no subpower source estimate is used.
This compares two admissions at the same changing source state.
It does not estimate source-successor total variation.

The compact packet V_(A_P,M)phi has support diameter at most
diam(supp phi)+M sum_(p<=P)log p=O_M(P), and translation preserves
its smoothness and prescribed vanishing pole moments. A finite
prime-power row cutoff follows for these compact test packets.
An actual frozen source after the operators can be noncompact;
the finite-row statement must not be applied to it without a
separate domain and convergence proof.

The complete signed arithmetic row, both orientations, proper
powers, density and seed remain uncontrolled at RH strength. A
summable archimedean admission error and uniform transport do not
establish Weil positivity, an arithmetic upper-work budget or RH.

## Depth four from the unconditional prime number theorem

RH Agent3 derived this refinement, independently reviewed by RH Proof
on 16 September 2026. It is written mathematics. The PNT input and
this source estimate have not been compiled in Lean.

Let E(x)=psi(x)-x, including all proper prime powers. The unconditional
input |E(x)|<=C x exp(-a sqrt(log x)), x>=2, follows from
[Johnston and Yang, arXiv:2204.01980v2](https://arxiv.org/abs/2204.01980v2).
Their explicit bound has a logarithmic prefactor, absorbed by choosing
any smaller positive exponential constant. For the literal original
frozen source, its complete physical norm is

    H_N = integral_1^N E(x)^2/x^2 dx + E(N)^2/N.

Splitting the integral at sqrt(N), Chebyshev pays its lower part by
O(sqrt(N)); PNT pays the upper part by
O(N exp(-sqrt(2)a sqrt(log N))). The frozen endpoint has the stronger
bound O(N exp(-2a sqrt(log N))). Therefore some b>0 satisfies

    H_N <= B N exp(-b sqrt(log N)),   N>=2.

The literal Fourier formula retains density and seed:

    ahat_N(xi)=D_N(1/2+i xi)/(1/2+i xi),
    D_N(w)=-1+sum_(2<=n<=N)Lambda(n)n^(-w)-integral_1^N x^(-w)dx.

Partial summation and Chebyshev give sum Lambda(n)/sqrt(n)=O(sqrt(N)).
The absolute density integral is at most 2(sqrt(N)-1), uniformly in xi.
Consequently |ahat_N(xi)|^2<=C N/(1+xi^2).

Here is a direct logarithmic-moment estimate that preserves the PNT
exponential constant. Let r>=0 be measurable, H=integral r, and suppose
r(xi)<=A/(1+xi^2), A>0. For H>0, its tail mass is at most
min(H,2A/t) for t>0. Tonelli and
log(2+|xi|)=log 2+integral_0^|xi| dt/(2+t) give, with R=2A/H,

    integral log(2+|xi|)r(xi)dxi
      <= H log 2 + H log(1+R/2) + 2A/R
      = H[log 2 + log(1+A/H) + 1].

The tail integral used 1/[t(2+t)]<=1/t^2. This also proves logarithmic
integrability without assuming it. If H=0, nonnegativity gives r=0
almost everywhere and the weighted integral is zero.

Apply this with r=|ahat_N|^2/(2pi), so H=H_N by Plancherel and A=O(N).
The function h[1+log(1+A/h)] is increasing for h>0, since its derivative
is 1+log(1+A/h)-A/(A+h)>0. Thus for every positive weight satisfying
q(xi)<=C_q[1+log(2+|xi|)],

    ||a_N||_q^2 <= C_q N[1+sqrt(log N)]exp(-b sqrt(log N)).

A complete contractive clock, finite unitary Euler product and fixed
convolution filter preserve this bound up to their uniform constants.
The old depth-four compact head has the uniform bound proved above.
For N_j<=K P_j, these give

    ||G_j||_q^2 <= C_(q,K) P_j[1+sqrt(log P_j)]
                    exp(-d sqrt(log P_j))

for some d>0. Bounded small source cutoffs are absorbed separately;
x[1+sqrt(log x)]exp(-b sqrt(log x)) is eventually increasing.
The unchanged complete depth-four block defect is
O(1/[P_j log P_j]). Therefore the same-state signed archimedean errors
are bounded by

    C_(q,K) [1+sqrt(log P_j)]exp(-d sqrt(log P_j))/log P_j.

This is absolutely summable for P_j=2^j P_0. Integral comparison after
u=sqrt(j) bounds its tail by O(exp(-d_1 sqrt(J))) for some d_1>0.
Agent3's slightly weaker bound, after absorbing the square-root factor
by reducing d, also yields a tail
O(exp(-d_2 sqrt(J))/sqrt(J)). Both conclusions retain a fixed depth.
Depth three's resulting majorant is not summable; this says nothing
about divergence of its actual errors or optimality of depth four.

The review certifies this archimedean approximation estimate using an
external unconditional PNT theorem and the stated operator bounds.
It supplies no finite arithmetic-row cutoff for noncompact actual
states, no full signed arithmetic-row estimate, and no bound on
source-successor work. Its original-source upper exponent is still
at most one. The subpower bound required for RH remains open.


The scalar substitution step is now compiled in
[LogarithmicMassEnvelope](BuildingBlocks/LogarithmicMassEnvelope.lean),
Lean 4.24.0. It proves the exact derivative, strict positivity,
strict monotonicity on h>0 for A>=0, and the upper substitution rule.
All four printed declarations use only propext, Classical.choice and
Quot.sound. This certificate covers the scalar envelope only. The
layer-cake moment estimate, Fourier identification, source PNT input
and complete depth-four admission conclusion remain written results.
