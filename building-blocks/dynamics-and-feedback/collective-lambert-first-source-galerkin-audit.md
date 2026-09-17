# Finite edge-cell Galerkin tests for the first two collective sources

## Outcome

The published edge-cell family gives finite **necessary observations** of
the two weighted-crossing range equations. It is not a vertex-space basis
for \(L^2(\gamma)\), so it does not give a finite projection of the source
equation itself.

For every finite stage, the observed equations have an exact
Moore--Penrose feasibility test and an exact minimum core-energy Gram. A
generalized Schur block then tests any prescribed two-column energy budget.
These formulae retain the coherent difference of the first two Lambert
columns.

At radius two, the rational-window stages \(M=2\) and \(M=3\) contain no
admissible prime edge. The first geometrically nonzero stage is
\((M,L)=(4,0)\). It has sixteen nonempty labelled cells, but its cell
masses, crossing matrix, target vectors, and common-constraint rows have not
been numerically validated. The first nontrivial stage is therefore
**UNEVALUATED**, rather than passed or failed.

## 1. What the edge cells can test

Let

\[
 \mathcal S_Rx=\rho^{-1}
 \left(B_Rx-\langle x,a_{c,R}\rangle1_O\right)
       \in L^2_0(\gamma)                                  \tag{1}
\]

be the actual centered weighted-crossing map, and let
\(Y_1(\theta),Y_2(\theta)\) be the clock-smeared, fibrewise centered
columns from the
[first source-range audit](collective-lambert-first-source-range-audit.md).
The desired equations are

\[
 \mathcal S_Rx_j(\theta)=Y_j(\theta),\qquad j=1,2.         \tag{2}
\]

The canonical observation theorem uses the full directed prime
conductance

\[
 J_{\rm p}^{\psi}(du,dv)=
 \sum_{q=p^k}\sum_{\sigma=\pm1}
 \frac{\log p}{p^{k/2}}\psi(u)\psi(v)\Phi(u)\Phi(v)\,
 du\,\delta_{u+\sigma k\log p}(dv),                       \tag{3}
\]

and the exactly-one-jump measure

\[
 \mathsf P_1(du,dv)=
 \frac{J_{\rm p}^{\psi}(du,dv)}
 {(a+\ell(u))(a+\ell(v))}.                                \tag{4}
\]

For a labelled cell \(D=D_{q,\sigma,I}\), write
\(m_D=\mathsf P_1(D)\), \(e_D=1_D/\sqrt{m_D}\) when
\(m_D>0\), and

\[
 (\mathcal O_{M,L}f)_D=
 \frac1{\sqrt{2m_D}}\int_D
 \left(\frac{f(v)}{\rho(v)}-\frac{f(u)}{\rho(u)}\right)
 d\mathsf P_1.                                           \tag{5}
\]

Equations (3)--(5) are exactly the construction in
[Canonical finite prime observations, equations (6)--(15)](../prime-distribution/canonical-finite-prime-observation-and-ground-input.md#2-what-the-published-theorem-actually-chooses).
Every \(p^k\le M\) and both orientations are separate labels; all prime
powers remain in the departure rates \(\ell\) in (4).

The functions \(e_D\) live in \(L^2(\mathsf P_1)\), not
\(L^2(\gamma)\). Hence the well-typed finite consequence of (2) is

\[
 \boxed{\quad
 \mathcal O_{M,L}(\rho\mathcal S_Rx_j(\theta))
 =\mathcal O_{M,L}(\rho Y_j(\theta)),\qquad j=1,2.
 \quad}                                                   \tag{6}
\]

Writing \(f=\rho F\), formula (5) observes
\(2^{-1/2}(F(v)-F(u))\). There is no published map that turns
\(e_D\) into a vertex-space orthogonal projection. Therefore feasibility
of (6) at one finite stage is necessary for (2), but is not sufficient for
(2). Failure of (6) rigorously refutes a Galerkin preimage in the chosen
core space; success only passes that finite observation.

## 2. Core and common-constraint matrices

Use the published even rational hats \(h_0,\ldots,h_4\) on the nodes

\[
 0,\frac12,1,\frac32,2
\]

and reflect them evenly to \(C=[-2,2]\). More generally, the following
formulae apply to any finite core family
\(\phi_1,\ldots,\phi_N\subset D(E_C)\).

Let \(H\) be a certified positive-definite core energy Gram. One may take
the form norm

\[
 H_{ij}=E_C(\phi_j,\phi_i)+
          \langle\phi_j,\phi_i\rangle_{\nu_C},             \tag{7}
\]

so the algebra does not assume a spectral gap. Let \(D\) collect every
common linear constraint required by the intended consumer. If the hats
have already been projected exactly as in the variable-row certificate,
then \(D\) is absent.

For the nonzero cells at stage \((M,L)\), define

\[
\begin{aligned}
 T_{rj}
 &=\left(\mathcal O_{M,L}
       (\rho\mathcal S_R\phi_j)\right)_r,\\
 b_{\ell,r}(\theta)
 &=\left(\mathcal O_{M,L}(\rho Y_\ell(\theta))\right)_r,
 \qquad \ell=1,2.                                        \tag{8}
\end{aligned}
\]

Stack the common constraints and edge observations:

\[
 \mathbb L=\begin{pmatrix}D\\T\end{pmatrix},\qquad
 \eta_\ell(\theta)=\begin{pmatrix}0\\b_\ell(\theta)\end{pmatrix},
 \qquad
 \mathbb Y(\theta)=\begin{pmatrix}\eta_1(\theta)&
                                   \eta_2(\theta)\end{pmatrix}.
                                                               \tag{9}
\]

Thus a coefficient vector \(c_\ell(\theta)\in\mathbb C^N\) passes the
finite observed range equation exactly when

\[
 \mathbb Lc_\ell(\theta)=\eta_\ell(\theta).               \tag{10}
\]

All entries in (8) are coherent integrals of the complete crossing column
before an absolute value is taken. In particular the continuous and
prime pieces of \(B_R\), both crossing orientations, and every prime power
must be combined in \(T\).

## 3. Moore--Penrose feasibility and minimum energy

Put

\[
 G=\mathbb L H^{-1}\mathbb L^*.                           \tag{11}
\]

This is positive semidefinite, possibly singular. For almost every
angular fibre, the exact feasibility conditions are

\[
 \boxed{\quad
 GG^\dagger\eta_\ell=\eta_\ell\quad(\ell=1,2),
 \qquad\text{equivalently}\qquad
 (I-GG^\dagger)\mathbb Y=0.
 \quad}                                                   \tag{12}
\]

When (12) holds, the minimum-\(H\)-energy coefficient columns are

\[
 c_{\ell,\min}=H^{-1}\mathbb L^*G^\dagger\eta_\ell,       \tag{13}
\]

and their exact \(2\times2\) energy Gram is

\[
 \boxed{\quad
 E_{\min}(\theta)=\mathbb Y(\theta)^*G^\dagger
                         \mathbb Y(\theta).
 \quad}                                                   \tag{14}
\]

Every other solution is \(c_{\min}+z\), with
\(\mathbb Lz=0\), and its energy is the minimum energy plus
\(z^*Hz\). This proves both necessity and sufficiency of (12)--(14);
no inverse of a singular matrix is silently used.

If \(K(\theta)\) is a prescribed Hermitian two-column energy budget, there
exists a coefficient matrix \(C\) with
\(\mathbb LC=\mathbb Y\) and \(C^*HC\preceq K\) exactly when

\[
 (I-GG^\dagger)\mathbb Y=0,\qquad
 K-\mathbb Y^*G^\dagger\mathbb Y\succeq0.                \tag{15}
\]

Equivalently, the singular Schur block satisfies

\[
 \boxed{\quad
 \begin{pmatrix}G&\mathbb Y\\
                 \mathbb Y^*&K\end{pmatrix}\succeq0.
 \quad}                                                   \tag{16}
\]

The range condition in (15) is essential; a determinant test by itself is
invalid when \(G\) is singular.

The coherent Lambert difference is retained automatically. For
\(e_-=(1,-1)^T\),

\[
 e_-^*E_{\min}e_-
 =E_{11}-2\operatorname{Re}E_{12}+E_{22}.                \tag{17}
\]

It is the minimum core energy of the observed difference
\(\eta_1-\eta_2\). Estimating the two columns separately before (17)
would erase the cancellation proved in the preceding audit.

For the joint angular problem, (12) must hold almost everywhere and the
integral of (14) against \(d\omega_X(\theta)\) must be finite. This is an
additional requirement beyond pointwise solvability.

## 4. The first geometrically nonzero radius-two stage

Use the rational-window variant

\[
 W_M=\{|u|\le M,\ \operatorname{dist}(u,C)\ge M^{-1}\}.
                                                               \tag{18}
\]

For \(C=[-2,2]\), \(W_2\) has no exterior point and each component of
\(W_3\) has length \(2/3<\log2\). Since \(q\le3\), no displacement
\(\pm\log q\) joins two points of \(W_3\), and no displacement is large
enough to join its two components. Thus the \(M=2,3\) edge observations
are identically zero.

At \(M=4,L=0\), the prime powers are

\[
 q=2,3,4,
\]

the start intervals have width one, and direct interval intersection gives
sixteen nonempty labelled cells:

* eight for \(q=2\);
* four for \(q=3\); and
* four for \(q=4\).

Both signs and both exterior components are included in these counts.
The proper power \(4=2^2\) is retained. The
[exact interval ledger](../geometry/radius-two-first-edge-cell-geometry.md) lists
the sixteen labels and the target/action integrals.
The [reversal reduction](../geometry/radius-two-edge-reversal-rank.md) identifies six
exact relations between their raw integral rows, leaving at most ten
complex observation coordinates. The four \(q=3,4\) pairs reverse
one to one; \(q=2\) has two aggregate relations because its shifted
cells cross a start-cell boundary. This does not supply a numerical Gram.

Lean certifies the exhaustive sixteen-cell count: it checks that the
listed labels are distinct and nonempty, that their interiors satisfy
the actual cell condition, and that every one of the 48 possible labels
with an actual edge appears in the list. This is a geometric result, not
a validated Gram evaluation. The proof uses the elementary strict bounds

\[
 \frac23<\log2<\frac34,\qquad
 1<\log3<\frac32,\qquad
 \frac43<\log4<\frac32.                                  \tag{19}
\]

The first pair follows by integrating \(1/x\) and the standard symmetric
log bound; the bounds for \(3\) use
\(\log3=\log(3/2)+\log2\), and those for \(4\) use
\(\log4=2\log2\). Intersecting
\([9/4,4]\cup[-4,-9/4]\), its unit start cells, and their translates
then gives the counts \(8,4,4\). No value of \(\psi_2\), \(\ell\), or a
cell integral is used in the count.

This stage cannot presently be classified as feasible or infeasible.
The exact missing finite data are:

1. the positive cell masses (the normalized fixed-stage cells are
   orthogonal once these masses are known), determined by
   \(\psi_2,a,\ell\);
2. the \(16\times5\) coherent crossing matrix \(T_{4,0}\);
3. the two sixteen-coordinate target functions
   \(b_1(\theta),b_2(\theta)\);
4. the common-constraint matrix \(D\); and
5. a certified positive core Gram \(H\) in the same basis.

The earliest missing analytic datum is still a validated normalized
radius-two ground profile with the local/translated error control needed
for (3)--(5). The published interval for \(\alpha_2\) alone supplies none
of these entries. Without them, neither the residual in (12) nor the
Schur block (16) can be enclosed. The status is therefore

> **FIRST NONTRIVIAL STAGE \((4,0)\): NUMERICALLY UNEVALUATED.**

This is not evidence for or against full source range membership.

The repository does contain the exact five-hat geometry and its
unweighted Lebesgue check Gram, the symbolic all-power/orientation cell
ledger, the formulas (1)--(5), and the proved outward interval for
\(\alpha_2\). It does not contain the theta-weighted hat Gram, a validated
\(\psi_2\), validated \(a\) and \(\ell\), the \(a_c\) constraint row, or
any entry of \(T_{4,0}\) and \(b_1,b_2\). The existing unweighted hat Gram
cannot be substituted for \(H\).

## 5. Formal status

[CollectiveSourceGalerkinFinite.lean](../../formalization/BuildingBlocks/CollectiveSourceGalerkinFinite.lean)
formalizes the exact finite algebra after the analytic matrices are
supplied: feasibility is range membership, an orthogonal feasible lift is
minimum norm, the energy-cap condition reduces to its minimum, and the
two-column coherent contraction is preserved. It also proves the
nonsingular scalar Schur determinant criterion and the singular
zero-leading-block criterion, where positivity forces the off-diagonal
target to vanish. The Moore--Penrose
identities and positive-definite change of metric are explicit hypotheses.
The module asserts no theta matrix entry, source range theorem, or
numerical stage result.
