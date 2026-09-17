# The real first-cell trace hidden by integer floor constraints

This companion to `factorial-floor-derivative-sampling-energy-failure.md` identifies an exact real-cell contribution of the actual arithmetic family. It explains which phase is discarded by integer sampling; it is not an energy upper bound or an RH proof.

Let N≥2 and use every actual grouped coefficient

A_q=Σ_{n≤N: floor(N/n)=q} μ(n), 1≤q≤N.

Extend the floor transform to real x≥1 by

F_N(x)=Σ_q A_q floor(q/x).

The complete integer constraints give F_N(k)=1 for every integer 1≤k≤N. In particular Σ_q A_q q=1. The grouped terminal sum, with every index retained, is Σ_q A_q=M(N).

For 1<x≤N/(N−1), all positive integers q≤N satisfy

q−1 ≤ q/x < q.

Indeed x≤N/(N−1) implies q/x≥q(N−1)/N≥q−1. Thus floor(q/x)=q−1, including the right endpoint. Consequently

F_N(x)=1−M(N),  1<x≤N/(N−1).                 (1)

The value at x=1 is still exactly one. The discrepancy is a one-sided phase trace, and a single endpoint has zero Lebesgue measure. Integrating the entire first real phase interval gives the exact identity

(N−1) ∫_1^{N/(N−1)} |F_N(x)−1|² dx = |M(N)|².    (2)

No Möbius inversion of the floor rows is used: (1) follows from their first row and the literal complete grouped sum. The full family, rather than a vector satisfying only that first row, is used throughout. Other integer rows fix the sampled bulk values but do not erase the trace in (1).

For the actual N=13 vector A_13=1, A_6=A_4=−1, A_1=−2, all thirteen rows equal one. Its M(13)=−3 and hence F_13(x)=4 on 1<x≤13/12. Its first-phase discrepancy integral is exactly 3/4, and the normalized value in (2) is nine. This is distinct from the positive factorial energy certificate in the sampling companion: Q_13−B(13,13)>0 is proved there by a full ordered-pair integer calculation.

Suppose a repair of integer floor-derivative sampling introduces a nonnegative real-cell reserve containing the left side of (2). An upper bound CN on that reserve would already imply |M(N)|≤sqrt(CN). It therefore cannot be justified merely by interpolating the integer values F_N(k)=1. Such a reserve would retain precisely an uncontrolled arithmetic trace. This observation does not rule out a signed compensation between the phase reserve and other terms, or a different weighted reserve derived from the full factorial density. No identity relating (2) to the original Q_N has been claimed.

The integrated contraction and every repair using only vanishing interior integer differences are already falsified by the actual N=13 certificate in the companion. Equation (2) locates a necessary issue for a particular continuum repair, rather than turning that obstruction into a successful upper mechanism. It is not a new no-go beyond the centered-consumer criterion: it is the literal endpoint quantity `M(N)^2`, and a target-scale positive bound for it would already provide the corresponding Mertens estimate.

The finite coefficient and interval-normalization algebra is compiled in
[FactorialFloorDerivativeObstruction.lean](../../formalization/BuildingBlocks/FactorialFloorDerivativeObstruction.lean).
The module deliberately does not assert an integral comparison between this
cell and the original factorial energy.
