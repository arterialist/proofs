# A finite operator Euler product on successor cells

The [dense successor-cell model](compact-weil-successor-cell-refinement.md)
turns every integer dilation into a finite floor-division transfer.
These transfers retain the exact multiplicative semigroup law despite
the hard window. Consequently the complete prime-power block of the
Weil form is the Hermitian part of a finite operator-valued Euler
logarithmic derivative. The finite Euler product is automatically
invertible and its uncentered critical-line norm grows like
\(\sqrt N\); neither fact signs the complete Weil form or proves RH.

Let \(C_N\) be the step space with cells
\(I_r=(L-\log(r+1),L-\log r]\),
\(\ell_r=\log((r+1)/r)\), and \(L=\tfrac12\log(N+1)\).
Use physical cell values \(z_r\), extended by \(z_0=0\).
The left-translation compression \(R_d\) acts by
\[
 (R_dz)_r=
 \begin{cases}
 z_{\lfloor r/d\rfloor},&1\le r\le N,\\
 0,&r>N.
 \end{cases}                                             \tag{1}
\]
The first case gives zero when \(r<d\). The Hilbert norm is
\(\|z\|_{C_N}^2=\sum_{r=1}^N\ell_r|z_r|^2\).

**Finite semigroup law.** For all positive integers \(a,b\),
\[
 R_1=I,\qquad R_aR_b=R_{ab}=R_bR_a,\qquad
 R_d=0\quad(d>N).                                        \tag{2}
\]
The key arithmetic identity is
\(\lfloor\lfloor r/a\rfloor/b\rfloor=\lfloor r/(ab)\rfloor\).
An intermediate label discarded beyond \(N\) cannot return under
another left dilation. In particular \(R_p^k=R_{p^k}\), and every
\(R_d\) with \(d>1\) is nilpotent. Equation (2) is a relation of
the **compressed left shifts**; their adjoints need not satisfy the
same product rule. Each \(R_d\) is a contraction, with its exact
terminal-column loss given in the successor-cell refinement note.

For \(s\in\mathbb C\), define the finite entire matrix
\[
 \mathscr Z_N(s)=\sum_{m=1}^N m^{-s}R_m,\qquad
 \mathscr M_N(s)=\sum_{m=1}^N\mu(m)m^{-s}R_m.             \tag{3}
\]
By unique factorization and the finite geometric series for each
nilpotent \(R_p\),
\[
 \boxed{\quad
 \mathscr Z_N(s)
 =\prod_{p\le N}(I-p^{-s}R_p)^{-1},\qquad
 \mathscr M_N(s)=\mathscr Z_N(s)^{-1}.
 \quad}                                                  \tag{4}
\]
The inverse identity also follows directly from
\(\sum_{d\mid n}\mu(d)=\mathbf1_{\{n=1\}}\):
terms with product \(mn>N\) vanish by (2), and the coefficient of
\(R_k\) for \(k\le N\) is
\(k^{-s}\sum_{d\mid k}\mu(d)\).

All factors in (4) commute. Differentiating the finite geometric
products gives the **complete actual prime-power operator**
\[
 \boxed{\quad
 -\mathscr Z_N'(s)\mathscr Z_N(s)^{-1}
   =\sum_{p^k\le N}(\log p)p^{-ks}R_{p^k}
   =\sum_{d=2}^N\Lambda(d)d^{-s}R_d.
 \quad}                                                  \tag{5}
\]
At \(s=\frac12\), the prime compression in the full Weil form is
\[
 K_L=B_N+B_N^*,\qquad
 B_N=-\mathscr Z_N'(\tfrac12)
            \mathscr Z_N(\tfrac12)^{-1}.                 \tag{6}
\]
The adjoint in (6) is taken in the weighted cell norm, so the
gamma multiplier and both pole rows of the full form remain
separate and unchanged.

## Why finite invertibility is insufficient

In the ordered cell basis every \(R_d\), \(d>1\), is strictly lower
triangular: a parent \(n\) has only children \(r\ge dn>n\).
Thus \(\mathscr Z_N(s)=I+\text{strictly lower triangular}\) has
determinant one for **every** complex \(s\). Its lack of finite
matrix zeros is tautological and gives no zero-free region for the
scalar zeta function. A meaningful infinite-volume argument would
need a controlled normalization and limit, with gamma and poles
retained.

The raw Euler transfer has no uniform critical-line operator bound.
Let \(e_1=\mathbf1_{I_1}/\sqrt{\ell_1}\), a unit vector. From (1),
the physical value of \(\mathscr Z_N(\frac12)e_1\) on cell \(I_r\)
is
\[
 \frac1{\sqrt{\ell_1}}
   \sum_{\lfloor r/2\rfloor<m\le r}m^{-1/2}
 =\frac{2(1-2^{-1/2})}{\sqrt{\ell_1}}\sqrt r
   +O(r^{-1/2}).                                        \tag{7}
\]
The estimate follows by comparing the monotone sum with its
integral on \((r/2,r]\). Since
\(\ell_r=r^{-1}+O(r^{-2})\), summing its cell energies gives
\[
 \boxed{\quad
 \|\mathscr Z_N(\tfrac12)e_1\|_{C_N}^2
 =\frac{4(1-2^{-1/2})^2}{\log2}\,N+O(\log N).
 \quad}                                                  \tag{8}
\]
Thus an uncentered operator-norm continuation at the critical line
is impossible in this model. The growth comes from the ordinary
integer count acting on all \(d\) consecutive successor children;
it is present before the specifically prime-weighted logarithmic
derivative (5). Any use of (4) toward RH must preserve the
integer-minus-continuum cancellation and the signed full Weil
completion, rather than deducing positivity from finite
invertibility.

The same finite child law controls the exact [opposite-collar prime
row](successor-cell-odd-collar-triangular-prime-oscillation.md).
For a parent at label 1 and a child in \(m\le r<2m\),
\[
 \lfloor r/d\rfloor=1
 \quad\Longleftrightarrow\quad
 \max(m,d)\le r<\min(2m,2d).
\]
The overlap is nonempty exactly when \(m<2d\) and \(d<2m\),
equivalently \(X/4<d<X\) for \(X=2m\). Both integer support
statements and the telescoping cell-length sum are now Lean theorems:
the weight is \(\log(2d/m)\) for \(m/2<d<m\),
\(\log(2m/d)\) for \(m\le d<2m\), and zero outside.
Its equivalent expression as the triangular function
\(W(\log(X/d))\) is written mathematics.

## A prime phase has an interior successor carry

The finite semigroup law does not make the dense successor-cell model
phase-equivalent to the exact-divisor graph. For a real sign
\(\chi(n)\in\{\pm1\}\) on positive integer labels, let
\(D_\chi z_r=\chi(r)z_r\). The exact
entrywise defect is
\[
 [(D_\chi R_dD_\chi-\chi(d)R_d)z]_r
 =\left[\chi(r)\chi(\lfloor r/d\rfloor)-\chi(d)\right]
       z_{\lfloor r/d\rfloor},\qquad r\le N.             \tag{9}
\]
If \(\chi\) is completely multiplicative, the bracket vanishes at
the exact-multiple child \(r=dn\). It need not vanish at the other
\(d-1\) successor children of the same parent.

Take the completely multiplicative sign on positive integers
\(\chi_2(n)=(-1)^{v_2(n)}\), which flips the prime 2 and leaves the
odd primes fixed. For any odd \(n\) with \(2n+1\le N\), the two
children of the unit cell vector
\(e_n=\mathbf1_{I_n}/\sqrt{\ell_n}\) give the exact identity
\[
 \boxed{\quad
 (D_{\chi_2}R_2D_{\chi_2}+R_2)e_n
 =2\sqrt{\frac{\ell_{2n+1}}{\ell_n}}\,e_{2n+1}.
 \quad}                                                  \tag{10}
\]
The multiple child \(2n\) cancels; the nondivisor carry child
\(2n+1\) survives. Since
\(\ell_{2n+1}/\ell_n\to\frac12\) as odd \(n\to\infty\),
\[
 \liminf_{N\to\infty}
 \|D_{\chi_2}R_2D_{\chi_2}+R_2\|_{C_N\to C_N}
 \ge\sqrt2.                                             \tag{11}
\]
This is an order-one interior obstruction to transferring a
fixed-prime phase argument from the exact-divisor graph by a diagonal
gauge. It does not settle the sign of the full Weil form. An argument
using such a phase must control the carry entries together with the
gamma and pole terms.

**Rigidity at the ninth successor cell.** More generally, suppose
\(\chi:\mathbb N_{>0}\to\{\pm1\}\) is completely multiplicative,
\(N\ge9\), and an exact phase conjugacy
\(D_\chi R_2D_\chi=\chi(2)R_2\) holds on every physical cell vector.
Testing the parent of each cell gives
\[
 \chi(r)\chi(\lfloor r/2\rfloor)=\chi(2),
 \qquad 2\le r\le N.                                  \tag{12}
\]
At \(r=9\), both \(9=3^2\) and \(\lfloor9/2\rfloor=4=2^2\)
have sign one, so (12) forces \(\chi(2)=1\). For even
\(r=2n\), multiplicativity then gives \(\chi(r)=\chi(n)\);
for odd \(r=2n+1\), (12) gives the same relation. Strong induction
from \(\chi(1)=1\) yields
\[
 \boxed{\quad \chi(r)=1\quad(1\le r\le N). \quad}     \tag{13}
\]
The cutoff nine is sharp for this statement: through \(N=8\),
\(\chi(n)=(-1)^{v_2(n)+v_3(n)}\) satisfies (12), but at \(r=9\)
its left side is \(+1\) while \(\chi(2)=-1\). The signs on labels
\(1,\ldots,8\) are \((1,-1,-1,1,1,1,1,-1)\), so each preceding
carry relation is checked directly. This is a precise
constraint imposed by additive successor carry on multiplicative
phase symmetry within the finite window.

There is also an operator-norm gap for sign gauges. If
\(\chi(r)\ne1\) for some \(1\le r\le N\), the contrapositive of
(13) supplies a cell \(2\le r\le N\) where (12) fails. Both sides
of (12) are signs, so their difference has magnitude two. With
\(n=\lfloor r/2\rfloor\), testing the unit vector \(e_n\) gives
\(\|D_\chi R_2D_\chi-\chi(2)R_2\|\ge
2\sqrt{\ell_r/\ell_n}\). For \(n\ge1\), the integral bounds
\(1/(r+1)<\ell_r\) and \(\ell_n<1/n\), together with
\(r\le2n+1\), give \(\ell_r/\ell_n>1/4\). Hence
\[
 \boxed{\quad
 \chi|_{\{1,\ldots,N\}}\not\equiv1, N\ge9
 \quad\Longrightarrow\quad
 \|D_\chi R_2D_\chi-\chi(2)R_2\|_{C_N\to C_N}>1.
 \quad}                                                  \tag{14}
\]
This excludes an operator-norm-small approximation by a nontrivial
multiplicative sign gauge. It leaves open localized packet arguments
and gauges that vary continuously rather than taking signs.

## A successor-tree phase and a two-prime obstruction

The doubling carry can be repaired exactly by abandoning
multiplicativity. Put
\(\eta(n)=(-1)^{\lfloor\log_2 n\rfloor}\) for \(n\ge1\),
with its harmless value at zero chosen as one. Every child
\(r\ge2\) is one binary-tree level deeper than
\(\lfloor r/2\rfloor\), so
\[
 \eta(r)\eta(\lfloor r/2\rfloor)=-1,
 \qquad D_\eta R_{2^k}D_\eta=(-1)^kR_{2^k}
 \quad(k\ge0)
 \quad\text{on every finite successor window}.           \tag{15}
\]
Indeed binary depth drops by exactly \(k\) under division by
\(2^k\) whenever the parent is positive; when it is zero, the
physical vector is zero there. Thus every proper power of the
prime 2 is compatible with this phase.
This phase is not a multiplicative character:
\(\eta(3)^2=1\) while \(\eta(9)=-1\). It also cannot assign a
single scalar phase to the 3-shift. At child \(r=3\) its parent
is 1 and the phase product is \(-1\); at \(r=4\) its parent
is again 1 and the product is \(+1\).

In fact, the conflict is independent of the choice of sign gauge.
Let \(N\ge4\), \(\chi(1)=1\), \(\chi(2)^2=1\), and suppose both
\(D_\chi R_2D_\chi=s_2R_2\) and
\(D_\chi R_3D_\chi=s_3R_3\) hold on every physical vector.
Testing children 2 and 3 for the 2-shift gives
\(\chi(2)=\chi(3)=s_2\); child 3 for the 3-shift gives
\(s_3=s_2\). Child 4 for the 2-shift gives
\(\chi(4)s_2=s_2\), hence \(\chi(4)=1\), while child 4 for
the 3-shift gives \(s_3=\chi(4)=1\). The 2-shift relation then
propagates \(\chi(r)=1\) from parent \(\lfloor r/2\rfloor\)
to every label in the window. Therefore
\[
 \boxed{\quad
 s_2=s_3=1,\qquad \chi(r)=1\quad(1\le r\le N).
 \quad}                                                  \tag{16}
\]
The two smallest prime shifts already make every simultaneous
scalar diagonal sign conjugacy trivial by cell four. The binary
phase in (15) handles one shift exactly, but the complete prime-power
operator (5) contains the incompatible 3-shift and every other
prime-power history. In the underlying undirected arrival graph,
the 2-shift edges \(1\leftrightarrow2\) and \(2\leftrightarrow4\), together with
the 3-shift edge \(1\leftrightarrow4\), form a triangle; the full prime
graph is already nonbipartite at cell four. This identifies a concrete mixed-prime carry
that any phase-based Weil argument must retain; it provides no sign
for the full form.

The obstruction is not restricted to signs. For a nonvanishing complex
gauge, the usual conjugacy \(D_\chi R_dD_\chi^{-1}=s_dR_d\)
requires
\(\chi(r)=s_d\chi(\lfloor r/d\rfloor)\) on every positive
child. With \(\chi(1)=1\), the same five child relations at
\(r=2,3,4\) give \(s_3=s_2\) and \(s_2^2=s_2\).
Nonvanishing forces \(s_2=s_3=1\), and binary-tree induction
forces \(\chi=1\) throughout the window. This covers arbitrary
unit-circle phases as a special case. The Lean theorem proves the
broader complex phase relation directly; the inverse-operator
notation is its consequence when the gauge is everywhere nonzero.

The 3-shift conflict persists arbitrarily far from the first four
cells. Fix \(k\ge2\), write \(q=2^k\), and take the two parents
\(n_-=q\) and \(n_+=2q-1\). For each \(j=0,1,2\), binary depth gives
\[
\begin{aligned}
 \eta(3n_-+j)\eta(n_-)&=-1,\\
 \eta(3n_++j)\eta(n_+)&=+1.
\end{aligned}                                             \tag{17}
\]
Indeed the low parent's children lie in \([2q,4q)\), one level
deeper, while the high parent's children lie in \([4q,8q)\), two
levels deeper. If \(N\ge3(2q-1)+2=6q-1\), both complete child
columns occur in the window. Their weights telescope exactly:
\[
 \sum_{r=3n}^{3n+2}\ell_r
 =\log\frac{3n+3}{3n}=\ell_n,
 \qquad \|R_3e_n\|_{C_N}=1.                         \tag{18}
\]
For any scalar \(s\in\mathbb C\), testing these two unit columns
therefore yields
\[
\boxed{\quad
 \|D_\eta R_3D_\eta-sR_3\|_{C_N\to C_N}
 \ge\max\{|s+1|,|s-1|\}\ge1.
\quad}                                                   \tag{19}
\]
When \(|s|=1\), the first lower bound is at least \(\sqrt2\), since
\(|s+1|^2+|s-1|^2=4\). Both parents tend to infinity with \(k\).
On the infinite weighted cell space, their unit vectors tend weakly
to zero, so (19) also bounds the essential norm against any compact
correction. A change confined to the first finitely many cells cannot
remove the discrepancy. This is an operator-norm obstruction for the
individual 3-shift. It does not bound a localized packet chosen to
avoid these columns, or sign the full prime-power and archimedean
Weil form.

There is a useful counterweight to exact phase rigidity. For real
\(t\), put \(\chi_t(n)=n^{it}=e^{it\log n}\) on positive labels.
This phase is completely multiplicative. If \(r=dn+j\),
\(0\le j<d\), and \(n\ge1\), its successor carry obeys
\[
 0\le \log\frac{r}{dn}
   =\log\left(1+\frac{j}{dn}\right)
   \le\frac{j}{dn}<\frac1n.
                                                               \tag{20}
\]
The last bound is uniform in \(d\). The unit-circle estimate
\(|e^{ix}-e^{iy}|\le|x-y|\) now gives
\[
 \left|\chi_t(r)\overline{\chi_t(n)}-d^{it}\right|
 \le\frac{|t|}{n}.
\]
Let \(P_{\ge R}\) project onto parent labels \(n\ge R\) in
\(C_N\). Different parents have disjoint child intervals, and the
sum of the retained child weights is at most \(\ell_n\). Hence, for
every \(N,d,R\ge1\),
\[
 \boxed{\quad
 \|(D_{\chi_t}R_dD_{\chi_t}^{-1}-d^{it}R_d)P_{\ge R}\|
 \le\frac{|t|}{R}.
 \quad}                                                   \tag{21}
\]
The same bound holds on the infinite weighted cell space, where
the complete child weights sum to \(\ell_n\). Thus the exact
four-cell obstruction and the binary-depth gap (19) do not exclude
approximate mixed-prime phases on high cells.

Write \(\mathscr B_N(s)=-\mathscr Z_N'(s)\mathscr Z_N(s)^{-1}\),
the complete finite prime-power operator in (5). A dilation
\(d>N/R\) has no children of parents \(n\ge R\) inside the
window. Summing (21) with every actual \(\Lambda(d)\) retained gives
\[
 \boxed{\quad
 \|(D_{\chi_t}\mathscr B_N(s)D_{\chi_t}^{-1}
          -\mathscr B_N(s-it))P_{\ge R}\|
 \le\frac{|t|}{R}
       \sum_{2\le d\le\lfloor N/R\rfloor}
          \Lambda(d)d^{-\Re s}.
 \quad}                                                   \tag{22}
\]
At \(\Re s=1/2\), the elementary bound
\(\Lambda(d)\le\log d\) makes the right side
\(O_t(\sqrt N\,R^{-3/2}\log(2N))\). It tends to zero for
\(R=\lfloor N^a\rfloor\), \(1/3<a<1\), while the active
prime-power range \(d\le N/R\) grows. This is a precise finite
correspondence between the arithmetic phase \(n^{it}\) and a
spectral-parameter translation. The estimate is for fixed \(t\);
growing heights must pay its explicit \(|t|\) factor. It supplies
no bound for the gamma and pole rows, and no sign for the complete
Weil form.

[SuccessorCellTransferFinite.lean](BuildingBlocks/SuccessorCellTransferFinite.lean)
formalizes the child-index equivalence, opposite-collar support,
exact logarithmic overlap weights, cutoff semigroup law,
commutation, vanishing beyond the cutoff, the gauge defect (9),
prime-two sign multiplicativity, exact-multiple cancellation, and the
physical-value identity underlying the normalized carry in (10).
It also proves the rigidity conclusion (13) from (12) and from
operator conjugacy, and the existence of a nonzero carry coefficient
for a nontrivial sign. The multiplicative \(\chi_2\chi_3\) witness,
its exact conjugacy through eight cells, and its failure at nine are
also formalized. The exact binary-tree phase for all \(2^k\) shifts,
simultaneous 2-/3-shift sign rigidity (16), and its nonzero-complex
phase extension compile as well. The two interior shell identities
(17), exact three-child weight (18), logarithmic carry bound (20),
and the normalized estimate
\(|e^{it\log(r/dn)}-1|\le|t|/n\) also compile, all
with standard mathlib axioms. Equations
(4)--(8), the weighted Hilbert realization and norm bounds (11),
(14), (19), (21), (22), and the full analytic Weil comparison are
written mathematics, not Lean formalized. These finite identities
give no RH conclusion.
