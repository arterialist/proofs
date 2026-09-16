# Reciprocal-prefix cancellation and the actual Abel clock bound

## Status and attribution

The complete finite arithmetic, actual rounded-source correspondence, and restricted-clock integral bounds below are compiled in Lean 4/mathlib. The complete larger-clock energy upper bound and actual RH remain open. The cumulative signed-work specialization at the end remains written.

RH Agent2 developed the signed reciprocal-prefix head-tail argument giving 5Nt. The coordinator refined it by Abel summation to 3Nt; Agent2 independently audited that refinement. Root independently reviewed and formalized the exact arithmetic and analytic chain. Bounded reciprocal prefixes and Abel summation are classical tools; no novelty or first-formalization certificate is claimed.

## The actual reciprocal prefixes

Use the original Möbius response

    g_N(t)=Σ_(1≤n≤N) μ(n)(1−exp(−⌊N/n⌋t)),
    A(N)=Σ_(1≤n≤N) μ(n)/n.

For every positive N the exact complete floor row gives

    N A(N)=1+Σ_(1≤n≤N) μ(n)(N/n−⌊N/n⌋).

Each rounding error lies in [0,1), and the unit-divisor term is exactly zero. Thus the absolute phase sum is at most N−1, so |A(N)|≤1. The zero prefix is also included. This bounds the signed prefix, not its absolute coefficients, and assumes no decay of A or Mertens cancellation.

## Coherent Abel summation before rounding

For a≥0 define

    U_N(a)=Σ_(1≤n≤N) μ(n)(1−exp(−a/n)),
    b_a(x)=x(1−exp(−a/x)),  x>0.

On its exact positive domain,

    b_a'(x)=1−(1+a/x)exp(−a/x)≥0,
    0≤b_a(x)≤a.

The derivative sign follows from exp(u)≥1+u multiplied by exp(−u). The upper bound follows from 1−exp(−u)≤u for u≥0. Finite Abel summation gives

    U_N(a)=A(N)b_a(N)−Σ_(1≤n<N) A(n)(b_a(n+1)−b_a(n)).

All increments are nonnegative. The prefix bound and exact telescoping of the increments therefore yield

    |U_N(a)|≤b_a(N)+b_a(N)−b_a(1)≤2a.

The empty N=0 sum is retained. No integer-alphabet positivity or coefficient independence is used.

The scalar function f(v)=1−exp(−v) is one-Lipschitz on [0,∞). For t≥0, its arguments satisfy

    0≤⌊N/n⌋t≤Nt/n,
    Nt/n−⌊N/n⌋t=t(N/n−⌊N/n⌋)≤t.

Only at this last rounding comparison are absolute coefficients used. Every actual history remains in the sum, and |μ(n)|≤1 gives

    |g_N(t)−U_N(Nt)|≤Nt,
    |g_N(t)|≤3Nt                         (N≥0, t≥0).

## Original compensated clock integrals

Keep the full positive weight

    w(t)=t^(−2)−[t(exp(t)−1)]^(−1), t>0.

The compiled bound w(t)≤1/(2t) gives the actual density bound

    g_N(t)² w(t)≤9N²t/2.

Absolute integrability of the original energy row is already compiled. Integrating on the actual finite interval (0,T], for every T≥0, proves

    Q_N(0,T)≤9N²T²/4,
    Q_N(0,1/sqrt(N))≤9N/4                (N≥1).

For the exact signed escaping LCM boundary B_N and the complete interior L_N, the compiled same-clock transfer |L_N(0,T)|≤NT/4 gives

    B_N(0,T)≤9N²T²/4+NT/4,
    B_N(0,1/sqrt(N))≤9N/4+sqrt(N)/4      (N≥1).

On the SINGLE common dyadic clock T=1/sqrt(2X), X≥1, the full actual horizon block satisfies

    Σ_(X≤N<2X) Q_N(0,T)≤9X²/2,
    Σ_(X≤N<2X) B_N(0,T)
      ≤9X²/2+X(3X−1)/(8sqrt(2X)).

The square-horizon budget ΣN²≤4X³ and the exact linear horizon sum ΣN=X(3X−1)/2 are compiled. The latter retains the exact signed-boundary interior allowance. These are one-sided estimates of actual signed boundary totals, not absolute-pair or positive-fiber bounds.

## Coverage and remaining consumers

Four modules add twenty-six compiled theorems: seven compensated mixed-budget/harmonic-envelope theorems, four reciprocal-prefix/floor-phase theorems, seven Abel-weight/unrounded/rounded-response theorems, and eight actual energy and signed-boundary integral theorems. All use only propext, Classical.choice, and Quot.sound. Every natural horizon and every stated real-clock domain is explicit; no sorry, admit, or unproved mathematical axiom is used.

The new chain supersedes the logarithmic intermediate-clock bound for the restricted energy and the 25 constants of the head-tail reciprocal argument. The earlier compensated logarithmic envelope is also compiled, rather than discarded.

For the literal cumulative signed work on any common dyadic band 0≤B≤T=1/sqrt(2X), exact square telescoping followed by nonnegativity of the initial and birth-square energies gives the written consequence

    W_X(B,T)≤9(2X−1)²/(16X)<9X/4.

That block-work integral specialization is not asserted as newly compiled here. The complete larger clock t>1/sqrt(2X), the full signed escaping-boundary upper bound, and the actual RH consumer remain unproved. The all-t envelope grows with t and cannot be integrated to infinity as a replacement for that missing bound.
