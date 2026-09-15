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
