# Full-clock absolute envelope and the missing dyadic exponent

The complete original factorial energy has the elementary unconditional bound

\[
Q_N\le\frac{13}{8}N^2\qquad(N\ge1).
\]

This controls the entire clock, including the intermediate region omitted by the fixed origin-band estimates. It does not reach the RH-scale upper bound. The corresponding complete dyadic estimate is

\[
\sum_{N=X}^{2X-1}Q_N
\le\frac{13}{48}X(2X-1)(7X-1)=O(X^3).
\]

The desired RH consumer requires O_ε(X^{2+ε}) for every ε>0. For 0<ε<1 this absolute-value mechanism leaves an extra factor X^{1−ε}. This is a bounded attempt at the actual upper estimate and an explicit elementary envelope, not an RH proof or a novelty claim.

## Actual source and complete compensated density

Retain the original definitions

\[
g_N(t)=\sum_{n=1}^N\mu(n)(1-e^{-q_nt}),\qquad q_n=\lfloor N/n\rfloor,
\]

\[
w(t)=t^{-2}-\frac1{t(e^t-1)},\qquad Q_N=\int_0^\infty g_N(t)^2w(t)\,dt.
\]

For t≥0 each increment lies between zero and min(q_nt,1), and |μ(n)|≤1. Since q_n≤N/n,

\[
|g_N(t)|\le\sum_{n=1}^N\min(Nt/n,1),\qquad |g_N(t)|\le N.
\]

All actual quotient histories remain before the triangle inequality. No prime-power valuations, ordered pairs, compensation term or clock region is removed from Q_N.

## Exact absolute bound on the small and intermediate clock

Fix 0<t≤1 and put s=Nt. The function f_s(x)=min(s/x,1) is decreasing on x>0. For each integer 1≤n≤N, f_s(n)≤f_s(x) on (n−1,n]. Summing these exact cells gives

\[
\sum_{n=1}^N f_s(n)\le\int_0^N f_s(x)\,dx
=s+s\log(N/s)=Nt(1-\log t).
\]

Indeed f_s is one on (0,s] and s/x on [s,N]; 0<s≤N. The point x=0 has no measure contribution. This argument also covers Nt<1, retaining the fractional first cell rather than replacing it by a sum from a rounded lower endpoint.

The compiled compensated density bounds are

\[
0<w(t)\le\frac1{2t},\qquad w(t)\le\frac1{t^2}\quad(t>0).
\]

Consequently

\[
\int_0^1g_N(t)^2w(t)\,dt
\le\frac{N^2}{2}\int_0^1t(1-\log t)^2\,dt
=\frac58N^2.
\]

The last integral is 5/4: substitute t=e^{-v}, giving ∫_0^∞e^{-2v}(1+v)²dv=1/2+2(1/4)+1/4. All terms are integrable; elementary integration by parts evaluates the three exponential moments.

## Full tail and dyadic sum

On t≥1 use |g_N(t)|≤N and the full compensated density upper bound w(t)≤t^{-2}. Then

\[
\int_1^\infty g_N(t)^2w(t)\,dt\le N^2.
\]

Adding the two entire regions proves Q_N≤13N²/8. Since Σ_{N=X}^{2X−1}N²=X(2X−1)(7X−1)/6, the displayed dyadic bound follows for every integer X≥1.

The signed cancellation supplied by the complete floor constraints is not used in this absolute envelope. Its omission is a quantified limitation of this method. The fixed origin-band neutralization does exploit the exact first constraint, but does not pay the remaining factor X in the full averaged consumer. An actual coherent signed-work comparison is still required; no universal negative local port sign is assumed.

## Attribution and formal status

Root derived and independently checked this explicit whole-clock envelope while attempting the full dyadic upper bound. The elementary O(N²) norm estimate is also consistent with the absolute Hilbert-space majorant used in RH Agent2's response Mellin development. No claim of a new arithmetic exponent or priority is made.

[FactorialAbsoluteEnvelope.lean](../../formalization/BuildingBlocks/FactorialAbsoluteEnvelope.lean) proves three public theorems: the complete actual min envelope, |g_N(t)|≤N, and the complete compensated energy-density bound g_N(t)²w(t)≤N²/t². They include N=0 and their exact nonnegative/positive clock domains. The full umbrella build passes with only propext, Classical.choice and Quot.sound. The cell integral comparison, logarithmic moment calculation, whole-clock constant 13/8 and exact dyadic polynomial above are written proofs requiring further Lean formalization. The stated full RH-scale upper estimate remains unproved.
