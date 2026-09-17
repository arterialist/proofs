# Exact triangular Gram structure of frozen births

Developed in the RH Proof branch, with Lean implementation by Harvey and independent mathematical review and compilation by RH Proof. Written analytic claims are distinguished from compiled statements below; no novelty claim is made.

The two-birth product integrability and exact triangular entry (1)
are compiled in `BuildingBlocks/ChargeFrozenBirthGram.lean`,
independently parent-compiled without warnings, using only standard
Lean axioms. `BuildingBlocks/ChargeFrozenBirthFiniteGram.lean`
now proves the arbitrary finite coefficient double-sum energy, its
explicit piecewise kernel with evaluated diagonal, and nonnegativity
of the complete quadratic. Root independently reviewed and compiled
these results without warnings, with only standard Lean axioms. The
single ordered triangular-sum presentation below remains written.
This concerns the literal original dv metric and complete frozen increments
b_n=a_(n+1)-a_n. It is not a covariance claim for distinct primes.

For integers 2<=m<n put

\[
t_m=\Lambda(m+1)-1,\qquad
q_n=\frac{\Lambda(n+1)}{n+1}-\log(1+1/n).
\]

The support of b_n is contained in x>n, apart from immaterial
endpoints, with x=exp v. Since n>=m+1, the earlier birth is already
in its frozen tail throughout that support:
b_m=t_m exp(-v/2). Thus absolute integrability follows from the
compiled square-integrability results and

\[
\langle b_m,b_n\rangle=t_m q_n.                 \tag{1}
\]

Indeed the ramp contribution to integral exp(-v/2)b_n(v)dv is
-log(1+1/n)+1/(n+1), and its terminal contribution is
(Lambda(n+1)-1)/(n+1). Their sum is q_n. The adjacent case n=m+1
is included: the shared atom endpoint has zero dv measure, and the
earlier tail formula holds immediately to its right.

The exact diagonal, already compiled and evaluated, is

\[
\langle b_n,b_n\rangle
=J_n+\frac{t_n^2}{n+1},\qquad
J_n=1+\frac n{n+1}-2n\log(1+1/n)>0.             \tag{2}
\]

Consequently for every real finite coefficient family c_n,

\[
\left\|\sum_{n=2}^{N-1}c_n b_n\right\|^2
=\sum_{n=2}^{N-1}c_n^2\left(J_n+\frac{t_n^2}{n+1}\right)
+2\sum_{n=2}^{N-1}c_n q_n
       \sum_{m=2}^{n-1}c_m t_m.                \tag{3}
\]

All prime powers and continuum ramps remain. The off-diagonal
upper triangle is a product of one earlier and one later scalar.
Its signs are not uniformly negative or positive: for example two
non-prime-power arrivals have t_m=-1 and q_n<0, hence positive
interaction. A later non-prime-power arrival paired with an earlier
arrival having Lambda(m+1)>1 gives negative interaction.

The initial a_2 is retained separately. On the support of b_n for
n>=2 it equals E_2 exp(-v/2), E_2=psi(2)-2. Therefore
<a_2,b_n>=E_2 q_n. Taking c_n=1 gives

\[
\|a_N\|^2=\|a_2\|^2
+\sum_{n=2}^{N-1}\left[J_n+\frac{t_n^2}{n+1}
 +2q_n\left(E_2+\sum_{m=2}^{n-1}t_m\right)\right].
\]

The inner history is exactly E_n=psi(n)-n, by the complete Mangoldt
successor identity. This recovers the independently compiled mixed
work formula and the compiled norm-increment identity from the full
finite Gram matrix. Positive definiteness of this actual Gram matrix
holds because it is a Gram matrix; it does not bound its value on
the all-ones cumulative history. The missing RH-scale cancellation
is still in the coherent sums, not in omission of the cross orders.
