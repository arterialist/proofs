# Finite translation maps cannot intertwine the full theta form

This note tests the most direct candidate for transferring the theta common-score form to the certified Suzuki interval form: finitely many translations, reflections and bounded multipliers followed by restriction to a compact interval. The candidate fails on the actual constrained theta domain for two independent reasons.

First, it sees only a bounded spatial set, while exact common-score theta tests can live arbitrarily far outside that set and have unbounded conditional energy. Second, the first arithmetic half-shift reaches the sharp L² boundary of the theta equality seed. A literal physical translation is therefore not an everywhere-defined theta Hilbert operator at that shift.

The conclusion is limited to this natural class and its finite-rank endpoint repairs. It does not exclude a nonlocal infinite-history map.

## Candidate class

Fix a Suzuki interval I=[-L,L]. On a theta physical test h or ground potential v, consider

\[
(Uv)(t)=\sum_{j=1}^N a_j(t)v(\epsilon_jt+\tau_j),
\qquad t\in I,
\tag{1}
\]

where ε_j∈{+1,-1}, the shifts τ_j are fixed, and a_j are bounded measurable cutoffs. This includes finite translated restrictions, reflected restrictions, cell projections and their finite linear combinations. Its theta visibility set is

\[
E_U=\bigcup_{j=1}^N(\epsilon_j I+\tau_j),
\tag{2}
\]

which is compact.

Allow also a finite-rank endpoint or source repair

\[
\widetilde Uv=Uv+\sum_{k=1}^M\lambda_k(v)b_k,
\tag{3}
\]

where b_k∈L²(I) and λ_k are fixed continuous theta Hilbert-space functionals. Point evaluations or endpoint jets can be included on a smooth compact core; the countertests below can be chosen to vanish near all finitely many evaluation points.

The target quadratic form may be any certified finite-cutoff Suzuki form

\[
q_\sigma[x]=\|x\|_2^2+\sigma\langle H_\omega x,x\rangle,
\qquad\sigma=\pm1.
\tag{4}
\]

The full Euler coefficients and Suzuki compression endpoints remain in H_ω.

## Actual constrained tests outside every visibility set

Fix the actual theta exterior radius T large enough that a compact annulus A⊂O_T is disjoint from E_U and from the finitely many endpoint sampling points in (3). Choose a nonzero nonnegative even smooth χ supported in A. In the notation of the actual common-score radius theorem, set

\[
v_\xi^{(0)}(u)=\chi(u)\sin(\xi u),
\qquad v_0=\tau\chi,
\]
\[
a_\xi=
\frac{\langle\psi_Tv_\xi^{(0)},\tau\rangle_\nu}
{\langle\psi_Tv_0,\tau\rangle_\nu},
\qquad
v_\xi=v_\xi^{(0)}-a_\xi v_0.
\tag{5}
\]

The denominator is positive and a_ξ tends to zero by Riemann-Lebesgue. The physical test h_ξ=ψ_Tv_ξ is odd, compactly supported in A, and satisfies both exact pole constraints

\[
\langle h_\xi,1\rangle_\nu=0,
\qquad
\langle h_\xi,\tau\rangle_\nu=0.
\tag{6}
\]

Thus v_ξ belongs to the actual common-score tangent space. Because its support misses E_U,

\[
Uv_\xi=0.
\tag{7}
\]

The actual theorem retains the full continuous clock, every prime power, the common score subtraction and both component crossing-mean subtractions. It gives

\[
n_T[v_\xi]
=\tfrac12\|\Phi\psi_T\chi\|_2^2\log|\xi|
+o(\log|\xi|)\longrightarrow\infty,
\tag{8}
\]

while

\[
\|v_\xi\|_{\gamma_T}^2
\longrightarrow\tfrac12\int\chi^2d\gamma_T>0.
\tag{9}
\]

Equations (7)-(9) give the precise kernel obstruction. On this actual constrained sequence, a finite translation-cutoff map has zero output while the complete theta residual energy diverges.

Consequently no U of the form (1) can satisfy any of the following identities or coercive comparisons on the full common-score domain with a positive constant c:

\[
n_T[v]=q_\sigma[Uv],
\qquad
n_T[v]\le Cq_\sigma[Uv],
\qquad
q_\sigma[Uv]\ge c\,n_T[v].
\tag{10}
\]

The zero target in (7) makes each proposed relation fail on v_ξ. This does not address the distinguished optimizer alone; it obstructs a form intertwiner on the stated domain.

## Finite-rank repairs do not restore the form

For the continuous functionals in (3), the normalized oscillatory tests converge weakly to zero in the theta Hilbert space. Hence

\[
\lambda_k(v_\xi)\to0
\qquad(1\le k\le M).
\tag{11}
\]

After taking a subsequence if needed,

\[
\|\widetilde Uv_\xi\|_{L^2(I)}\to0.
\]

Since H_ω is bounded at fixed cutoff,

\[
q_\sigma[\widetilde Uv_\xi]\to0,
\tag{12}
\]

whereas (8) diverges. Smooth endpoint evaluations vanish identically because χ is supported away from their finitely many sampling points. Thus a finite collection of endpoint ports or bounded source rows cannot repair (10).

This statement does not cover an unbounded observation specifically designed to measure logarithmic oscillation, nor an infinite family of translated ports. Such constructions would need their own domain and tail estimates.

## Source-normalization obstruction

There is also an adjoint version of the support mismatch. Suppose an interval row s∈L²(I) is meant to reproduce the actual theta score functional for every test:

\[
\langle Uv,s\rangle_{L^2(I)}
=\langle v,S_q\rangle_{\gamma_T}.
\tag{13}
\]

For (1), the adjoint vector U* s is supported in E_U. The actual score row S_q is proportional to the odd exterior score and has nonzero tails on arbitrarily distant exterior sets. Equality (13) would force

\[
U^*s=S_q
\]

in the theta Hilbert space, contradicting their supports. Finite-rank repair changes U* s only by the finite span of the representing rows of λ_k. Unless the actual S_q is explicitly included as one of those rows, source normalization still fails.

Including S_q as a rank-one row can enforce (13), but it does not repair the energy obstruction (8): choose the tests in (5), which already satisfy the exact score constraint, and that added coordinate vanishes.

## Sharp domain failure at the first half-shift

A different natural candidate tries to transport the arithmetic half-history shift itself. In physical theta coordinates, translation by ℓ induces the quotient

\[
(T_\ell h)(u)=
\frac{\Phi(u-\ell)}{\Phi(u)}h(u-\ell).
\tag{14}
\]

The established theta tail calculation shows

\[
\frac{\Phi(u-\ell)}{\Phi(u)}\in L^2(\nu)
\quad\text{for }|\ell|<\frac{\log2}{2},
\]

but not at

\[
\ell=\frac{\log2}{2}.
\tag{15}
\]

At the endpoint, the positive-tail norm integrand has asymptotic constant times e^{5u}; beyond it the Gaussian exponent grows. The first nontrivial Suzuki Kraus displacement is exactly log2/2. Therefore the literal half-history translation is not a bounded theta Hilbert operator on the equality seed at the first arithmetic shift.

Cutting (14) off to a compact interval makes it finite, but returns to the visibility obstruction (7). It also creates boundary ports. Dropping those ports would fail to retain the full theta prime edges crossing the cutoff.

## Prime edges and endpoint retention

The obstruction in (8) does not arise from deleting arithmetic terms. The form n_T used there is K_T-M_T with:

- the full archimedean logarithmic energy;
- every prime-power translation;
- the actual common-score rank subtraction;
- both separately centered crossing covariances;
- exterior killing and the original theta endpoints.

The leading logarithmic growth comes from the archimedean multiplier. The complete normalized prime part and the finite matched profiles are bounded on the theta Hilbert space and cannot cancel that growth. Thus retaining all prime powers strengthens the kernel obstruction rather than creating it artificially.

On the Suzuki side, q_σ retains the full Euler kernel and its compression endpoints. Its inability to see v_ξ follows solely from the finite visibility of U.

## Exact scope

The following class is ruled out as a full common-score form intertwiner:

- finitely many fixed translations or reflections;
- bounded multiplication and compact restriction to I;
- finitely many bounded source or endpoint rows;
- literal theta half-shifts at or beyond log2/2.

The proof does not exclude a source-specific map defined only on the actual optimizer, a nonlocal map with infinitely many tail ports, or a transform that converts logarithmic theta frequency into an interval coordinate. Any such proposal must still reproduce the score row, carry the full prime-power form, and pay a complement norm analogous to the Suzuki trial-tail residual.


This is written analysis. Its domain and oscillatory-energy statements have not been formalized in Lean.
