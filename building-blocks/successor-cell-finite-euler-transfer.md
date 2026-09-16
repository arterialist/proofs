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

[SuccessorCellTransferFinite.lean](BuildingBlocks/SuccessorCellTransferFinite.lean)
formalizes the child-index equivalence, cutoff semigroup law,
commutation, and vanishing beyond the cutoff with standard mathlib
axioms. Equations (4)--(8), the weighted Hilbert realization, and
the full analytic Weil comparison are written mathematics, not
Lean formalized. No novelty or RH claim follows from the finite
Euler-product algebra alone.
