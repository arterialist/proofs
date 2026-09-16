# An unconditional intermediate-clock upper bound for cumulative signed work

Written proof by RH Agent2, independently reviewed by root on 16 September 2026. The added LCM-boundary consequence below is by root. No full RH upper bound is claimed.

Neutralizing the exact actual floor mass before taking absolute values gives a response bound throughout the clock t≤N^(−1/2). Its integrated energy is O(N log²N). Exact finite telescoping then bounds cumulative signed work on any common dyadic clock band below (2X)^(−1/2) by O(X log²X). This extends the fixed origin-clock bound and permits the necessary positive linear excursions of actual work. The remaining larger clock, and the complete RH-scale upper bound, remain open. The estimates are elementary compensated Taylor and harmonic-sum bounds; no novelty claim is made.

Use the actual response, every coefficient and the complete weight

g_N(t)=Σ_{n≤N}μ(n)[1−e^(−q_n t)], q_n=floor(N/n),
w(t)=t^(−2)−[t(e^t−1)]^(−1)>0.

For N≥1 the full quotient constraints give their exact first row Σμ(n)q_n=1. Define h(v)=v−(1−e^(−v)), v≥0. The response therefore obeys

g_N(t)=t−Σ_{n≤N}μ(n)h(q_n t),
0≤h(v)≤min(v,v²/2).                                (1)

This subtracts the one exact common origin mass before absolute values. No first-cell Mertens trace is deleted, and no fabricated vector or replacement diagonal energy is used.

## A split size budget extends the clock range

Put a=Nt. Since q_n≤N/n and |μ(n)|≤1,

|g_N(t)|≤t+Σ_{n≤N}min(a/n,a²/(2n²)).                (2)

If 0≤a≤1, the quadratic bound and Σ1/n²≤2 give |g_N(t)|≤t+a²≤2a. If a≥1 and k=floor(a)<N, split the histories at k. The head is at most aH_k≤a(1+log a), and the tail is at most a²/(2k)≤a, since k≥a/2 and Σ_{n>k}n^(−2)≤1/k. Also t≤a. If k≥N, there is no tail; the full head is at most aH_N≤a(1+log a). Thus, for every N≥1 and t≥0,

|g_N(t)|≤Nt[3+log^+(Nt)].                           (3)

Here log^+(x)=max(0,log x) for x>0, with the bound at t=0 read by continuity. The floor endpoints remain in (1); replacing q_n by N/n is used only in the justified positive majorant (2).

The original weight satisfies w(t)≤1/(2t), as proved in the origin-band companion using tanh(t/2)≤t/2. Therefore, for every T>0,

Q_N(0,T):=∫_0^Tg_N(t)²w(t)dt
 ≤N²T²[3+log^+(NT)]²/4.                            (4)

Indeed the logarithmic factor is increasing, and ∫_0^Tt dt=T²/2. The compensated density has not been substituted by a factorial valuation or removed from the definition: the entire actual energy on the indicated clock is bounded by a positive scalar majorant.

At T=N^(−1/2), (4) becomes the unconditional critical-scale estimate

Q_N(0,N^(−1/2))≤(N/4)[3+(log N)/2]².                (5)

More generally T=N^(−(1−δ)/2), 0≤δ<1, gives O_δ(N^(1+δ)log²N) for that restricted energy. None of these restricted bounds supplies an upper bound for the omitted clock t>T.

## The actual signed work on a common band

Let Δ_n=g_n−g_(n−1), g_0=0, and fix an integer X≥1. For arbitrary common endpoints 0≤A≤T=(2X)^(−1/2), define

W_X(A,T)=Σ_{n=X}^{2X−1}∫_A^Tg_(n−1)(t)Δ_n(t)w(t)dt.

All finite full-clock integrals are legitimate by the published factorial dictionary. On this one common band the finite square identity telescopes exactly:

2W_X(A,T)
 =Q_(2X−1)(A,T)−Q_(X−1)(A,T)
  −Σ_{n=X}^{2X−1}||Δ_n||²_(A,T).                    (6)

Every signed birth port is retained. Only after this identity, nonnegativity of the last two terms gives an upper bound by the terminal energy. Applying (4) to N=2X−1 and T=(2X)^(−1/2), with NT≤sqrt(2X), yields

W_X(A,(2X)^(−1/2))
 ≤(X/4)[3+(log(2X))/2]².                            (7)

This is an unconditional O(X log²X) upper bound for cumulative signed work on the indicated intermediate clock. It does not rely on local birth damping, full-period replacement, Mertens estimates, additive Möbius correlations, RH, or Chowla. In particular A may be chosen as U/(2X) whenever that is below T, so (7) controls a genuine band beyond the earlier fixed-U origin clock.

The cutoff is common to every response and innovation in (6). There is no changing integration interval during telescoping. The negative initial energy and birth-square terms are retained exactly before being dropped in a one-sided inequality. Necessary positive O(X) work excursions are compatible with (7).

## What remains for the full target

The requested whole dyadic work upper still needs the clock t>(2X)^(−1/2). On that clock the actual terminal μ(n) histories and coherent Mertens response persist. The total birth-square budget is already O(X), but it does not control this mixed work. The generalized Hardy-Littlewood-Riesz large-parameter frontier is not supplied by (3), whose absolute bound grows like a log a.

The strong coefficient-one diagonal hypothesis remains refuted and is not invoked. This note gives an actual partial-clock signed upper bound, rather than a renamed doubling criterion or an assumed RH-scale reserve. No full Q_N upper estimate or actual RH proof follows yet.

These are written proofs. Lean formalization of (1)–(7) has not been asserted. The exact floor mass, actual successor, positive-axis integrability and complete kernel are already represented in the published factorial modules, but that does not by itself formalize the new estimates.

## Consequence for the exact signed LCM boundary

Use the original boundary decomposition Q_N=L_N+B_N from [complete divisor birth cancellation](factorial-lcm-birth-boundary.md). Write B_N(0,T) and L_N(0,T) for the same rows integrated on the common clock (0,T]. The compiled constant row bound gives

|L_N(0,T)|≤NT/4,
B_N(0,T)≤Q_N(0,T)+NT/4.                            (8)

Combining (4) and (8), for N≥1 and T>0, gives the unconditional signed upper

B_N(0,T)≤N²T²[3+log^+(NT)]²/4+NT/4.                (9)

At T=N^(−1/2), this is

B_N(0,N^(−1/2))≤N[3+(log N)/2]²/4+sqrt(N)/4.       (10)

For a single common dyadic clock T=(2X)^(−1/2), with X≥1, use N<2X in each summand and exactly X horizons. Then NT≤sqrt(2X), ΣN²≤4X³, and ΣN≤2X², so

Σ_(X≤N<2X) B_N(0,(2X)^(−1/2))
 ≤X²[3+(log(2X))/2]²/2+X^(3/2)/(2sqrt(2)).          (11)

This is O(X²log²X) for the actual signed escaping boundary on that common intermediate clock. It does not bound absolute pairs or positive fibers. The full original compensated weight and every signed history are retained before the one-sided estimate. The omitted t>(2X)^(−1/2) is precisely the remaining clock, and no bound for it is proved here.

Formal coverage: (8) is compiled in FactorialBirthInteriorBound.lean. The compensated harmonic/log response estimate (1)–(5), signed work identities and upper bound (6)–(7) in this notation, and combined boundary bounds (9)–(11) remain written mathematics. Exact birth and general pointwise work telescoping, full-clock integrability, and integrated LCM boundary identification are compiled prerequisites; they are not a formalization of these remaining logarithmic estimates.
