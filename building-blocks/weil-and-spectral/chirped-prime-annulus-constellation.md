# Chirped Weil packets form growing positive constellations

**Status:** unconditional written analytic proof, 18 September 2026.
RH Agent 3 derived the chirped two-packet estimate and its exact
pole-null upgrade. The current task supplied the growing-rank row-sum
argument and independently audited the complete-form calculation.
This is a theorem for [actual zeta's complete Weil form](actual-signed-annulus-bump-gram.md#exact-prime-orientation-and-analytic-remainder)
and actual Λ; the analytic proof is not Lean-formalized. It does not
prove RH or phase cancellation for a fixed profile. The packet depends
on T. All prime powers, endpoints, gamma, and both zeta poles are retained.

Fix 0<w<log 2 and a real a∈C_c^∞(0,w), ||a||₂=1. Fix constants
0<α<2 and α/2<κ<1. For T→∞ put K=T^κ and
  u_T(x)=a(x) exp(iKx²−iTx),
  v_{T,L}(x)=u_T(x−L),   w<L≤α log T.
These supports are disjoint. Let Q be the complete Weil Hermitian form.
For the exact pole-null profile

\[
q_T=\frac{(\partial_x^2-1/4)u_T}
          {\|(\partial_x^2-1/4)u_T\|_2},
\]

**the growing-rank theorem** says that, for any
`0<=x_1<...<x_M<=alpha log T` with adjacent gaps `>w`, and any
complex coefficients `c_j`,

\[
\boxed{\quad
Q\!\left(\sum_{j=1}^M c_j\tau_{x_j}q_T\right)
\ge\bigl(\log(T/(2\pi))-C_{a,w}-o(1)\bigr)
       \sum_{j=1}^M|c_j|^2.
\quad}                                                   \tag{1}
\]

The estimate is uniform over all such center sets, including those
with `M` proportional to `log T`. No RH assumption enters the proof.
Then uniformly in the stated L range, the 2×2 Hermitian Gram on
span(u_T,v_{T,L}) satisfies
  λ_min(Q|span) = log(T/(2π)) + o(log T),
indeed λ_min ≥log(T/(2π))−O_a,α,κ(1)
−O_a,α,κ((log T)T^{α/2−κ})−o(1).
In particular it is strictly positive for all sufficiently large T,
for every complex signed combination of the two packets.

## Autocorrelation geometry and exact prime-power estimate

Write h_K(x)=a(x)e^{iKx²} and
  C_K(y)=∫ h_K(x+y)overline{h_K(x)} dx
        =e^{iKy²}∫a(x+y)a(x)e^{2iKxy}dx.
C_K is supported in |y|≤w, and for each integer m>1, integration by
parts in x gives
  |C_K(y)|≤A_{a,m}(1+K|y|)^{-m}
for all real y. The derivative L¹ norms of a(x+y)a(x) are bounded
uniformly in y, and Cauchy--Schwarz supplies |C_K(y)|≤1 near y=0.
For u_T, C_{u_T}(y)=e^{-iTy}C_K(y).

Since w<log2, the self-prime terms are absent. For L>w the negative
cross shift cannot meet a positive prime-power shift; the entire exact
prime cross is the finite sum
  P_T(L)=Σ_{n≥2} Λ(n)n^{-1/2} C_{u_T}(log n−L).
Set N=e^L. On its support, n∈[Ne^{-w},Ne^w], so n≈_w N,
Λ(n)≤log n≤L+w, and
|log(n/N)|≥c_w |n−N|/N. The elementary lattice bound
  Σ_{n∈Z}(1+K|n−N|/N)^{-m}≤C_m(1+N/K)
then gives, uniformly even when N is nonintegral,
  |P_T(L)|≤C_{a,w,m}(L+w)(N^{-1/2}+N^{1/2}/K).
This counts *all integers*, hence every prime power and any endpoint.
At every prime power `n=p^j`, the retained coefficient is exactly
`Lambda(p^j)=log p`.
For w<L≤αlogT, the first term is bounded uniformly in L; the second
is O((log T)T^{α/2−κ})=o(log T). Consequently
  sup_{w<L≤αlogT}|P_T(L)|=O(1)+o(log T).
No prime-phase cancellation or PNT is used.

## Gamma and pole uniformity

Use the Fourier convention U_T(s)=∫u_T(x)e^{isx}dx and the exact
archimedean multiplier
  b(s)=Re ψ(1/4+is/2)−log π.
Set r_T(s)=b(s)−log(T/(2π)). Plancherel gives
  (2π)^{-1}∫|U_T(s)|²ds=1,
  (2π)^{-1}∫|s−T|²|U_T(s)|²ds=||h_K'||₂²=O_a(K²),
and analogous 2m-th spectral moments are O_{a,m}(K^{2m}).
The standard digamma asymptotic and a split at |s−T|=T/2 yield
  R_T:=(2π)^{-1}∫|r_T(s)||U_T(s)|²ds
     =O_a(K/T)+O_{a,m}((K/T)^{2m}log T)=o(1).
On |s−T|≤T/2 this follows from
|r_T(s)|≤C(|s−T|+1)/T; on the tail, b(s) is smooth and has at most
logarithmic growth, so one higher spectral moment controls it. Because
v_{T,L} is a translate, V(s)=e^{isL}U(s). The constant multiplier
log(T/(2π)) contributes exactly log(T/(2π))(|A|²+|B|²) to
Q_gamma(Au+Bv), since ∫|U|²e^{isL}ds/(2π)=0 for disjoint supports.
The residual contributes at most 2R_T(|A|²+|B|²), independent of L.

For z=±i/2, U_T(z)=∫a(x)e^{iKx²−iTx+izx}dx.
Its real oscillatory phase has derivative −T+2Kx, of magnitude ≥T/2
for all x∈supp a and large T. Repeated nonstationary-phase integration
by parts, uniformly for K=T^κ=o(T), gives
  U_T(±i/2)=O_{a,m}(T^{-m}) for every m.
Translation multiplies these transforms by e^{izL}, of modulus at
most e^{L/2}≤T^{α/2}. Thus every entry of the pole Gram is o(1)
uniformly in L, by taking m sufficiently large. This treats both poles.

The full Gram therefore equals log(T/(2π))I plus a gamma matrix of
operator norm o(1), a pole matrix of norm o(1), and a prime cross
matrix of norm |P_T(L)|=O(1)+o(log T), proving the claim.

## Exact pole-null upgrade

The same theorem holds with u_T replaced by
  q_T=(∂_x²−1/4)u_T / ||(∂_x²−1/4)u_T||₂
and v_{T,L}=τ_L q_T. Its two pole transforms vanish *exactly*:
qhat_T(±i/2)=0. To check that the prime and gamma bounds survive,
write θ(x)=Kx²−Tx. Direct differentiation gives
  (∂²−1/4)u_T=e^{iθ(x)}[
    (−θ′(x)²+2iK−1/4)a(x)+2iθ′(x)a′(x)+a″(x)].
The normalizing denominator is T²(1+o(1)). Thus q_T=e^{iθ}b_T,
where b_T is supported in (0,w), ||b_T||₂=1, and for every fixed m,
||b_T||_{C^m} is bounded uniformly in T because K/T→0.
Its autocorrelation has the same factor e^{iKy²+2iKxy}
with b_T(x+y)overline{b_T(x)} in place of a(x+y)a(x).
Uniform derivative bounds give the same
|C_{q_T}(y)|≤C_m(1+K|y|)^{-m}; its Fourier spectral moments about T
remain O(K^{2m}). The exact prime bound and gamma estimate above
therefore apply unchanged, while the pole matrix is identically zero.

## Growing-rank signed constellation

The exact pole-null packet q_T also yields a growing-dimensional result.
Choose any positions 0≤x_1<⋯<x_M≤αlogT with adjacent gaps >w, and
put f_j=τ_{x_j}q_T. There may be M≈logT/w packets. They are pairwise
L²-orthogonal. For every coefficient vector c∈C^M,
  Q(Σ_j c_j f_j) ≥[log(T/(2π))−O_{a,w}(1)−o(1)]Σ_j|c_j|²,
uniformly over M and every allowed choice of positions. In fact,
  ||G_T−log(T/(2π))I_M||_op ≤ C_{a,w}+o(1).

The constant gamma multiplier is exactly diagonal by disjoint
support. The residual gamma Gram has each entry ≤R_T=o(1), so its
row sum is ≤M R_T=O(logT·T^{κ−1})+o(1). Both pole channels vanish.
The prime off-diagonal for a pair at distance d>w is at most
  C(d+w)(e^{-d/2}+e^{d/2}/K).
For each row, separation >w places at most two other positions in
each shell kw≤d<(k+1)w. Therefore the sum of the first term is
bounded by the convergent series
  CΣ_{k≥1}(kw+w)e^{-kw/2}=O_{a,w}(1).
The second term summed over all M≤1+αlogT/w positions is at most
  C M(αlogT+w)e^{αlogT/2}/K
   =O((logT)²T^{α/2−κ})=o(1).
Gershgorin's Hermitian row bound proves the displayed estimate.
Thus the rank can grow on the order of logT while the whole signed
subspace keeps a logT spectral margin. This remains a microlocal
geometric class, not arbitrary-test Weil positivity.

## Scope and barrier

This does not establish the proposed fixed-profile phase saving at
L=c loglogT. The chirp bandwidth K grows with T and suppresses the
absolute autocorrelation mass before prime phases are considered.
The proof here uses both `K≫e^(L/2)` to make the prime interaction
`o(log T)` and `K=o(T)` to make the archimedean residual `o(1)`.
These conditions coexist for `L≤αlog T` when `α<2`. The
[critical-span extension](chirped-critical-span-constellation.md) instead
takes `K=ηT`, controls the complete archimedean quadratic form with an
`O(1)` residual, and reaches `2log T-B` for fixed `B`. That still gives
no fixed-profile prime-phase saving or RH conclusion.

The fixed-profile phase-resonance problem remains unresolved. No claim
of literature priority is made here.
