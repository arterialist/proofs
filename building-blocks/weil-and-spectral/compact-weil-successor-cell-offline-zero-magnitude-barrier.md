# Off-line zeros force growing negative successor-cell Weil eigenvalues

The [complete successor-cell matrices](compact-weil-successor-cell-refinement.md)
are form-dense finite models of the Weil criterion. Their
[unconditional negative-part bound](compact-weil-successor-cell-negative-part-vk-density.md)
still grows like \(N^{1/2-o(1)}\). This note proves why a uniformly
bounded negative part on these full spaces would already be RH-strength:
a hypothetical off-line zero forces negative eigenvalues of a fixed
power size along an unbounded sequence. The statement concerns the
actual von Mangoldt weights, every prime power, and the complete gamma
and pole terms. It is a written analytic proof, not a Lean theorem.
The related [smooth odd boundary-packet criterion](suzuki-odd-continuum-green-and-moving-prime-residual.md)
is the source of the Laplace-transform idea; the finite-step construction
below transfers a quantitative excursion to the exact successor cells.

Let \(Q_N\) denote equation (8) of the refinement note on \(S_N\), with
\(L=\tfrac12\log(N+1)\), and let \(\lambda_{\min}(Q_N)\) be its least
Hermitian eigenvalue.

**Conditional magnitude theorem.** If \(\zeta\) has a zero
\(\rho=\tfrac12+\sigma+i\gamma\) with \(0<\sigma<\tfrac12\) and
\(\gamma\ne0\), then for
every \(0<\varepsilon<\sigma\),
\[
 \boxed{\quad
 \limsup_{N\to\infty}
 \frac{-\lambda_{\min}(Q_N)}{N^{\sigma-\varepsilon}}
 =+\infty.\quad}                                          \tag{1}
\]
Consequently a uniform bound
\(\lambda_{\min}(Q_N)\ge-C_\theta N^\theta\), \(0\le\theta<1/2\),
would imply the zero-free strip
\(\operatorname{Re}\rho\le\tfrac12+\theta\). In particular,
\[
 \boxed{\quad
 \mathrm{RH}\quad\Longleftrightarrow\quad
 \inf_{N\ge2}\lambda_{\min}(Q_N)>-\infty.
 \quad}                                                   \tag{2}
\]
The forward direction of (2) is the Weil-positivity implication
already proved in the refinement note. A uniform bounded or decaying
negative allowance for these full spaces is therefore RH-equivalent.
Even a uniform \(N^{o(1)}\) negative-part bound would imply RH.

## A finite step that detects a specified zero

Put \(z=\rho-\tfrac12=\sigma+i\gamma\) and, for an integer \(j\ge2\), let
\[
 J_j=[\log j,\log(j+1)),\qquad
 A_j(w)=\int_{J_j}e^{-wt}dt.
\]
Fix \(m\ge2\). Since
\[
 \frac{A_n(z)}{A_n(1/2)}
 =n^{1/2-z}(1+O_z(n^{-1})),
\]
its modulus tends to infinity as \(n\to\infty\). Choose a fixed
\(n>m\) for which this ratio differs from \(A_m(z)/A_m(1/2)\), and
define the nonzero real compact step
\[
 g=A_n(1/2)\mathbf1_{J_m}-A_m(1/2)\mathbf1_{J_n},\qquad
 M_g(w)=\int_0^\infty g(t)e^{-wt}dt.
 \tag{3}
\]
Then \(M_g(1/2)=0\) while \(M_g(z)\ne0\).
The convolution \(k=g*g\) is compactly supported and Lipschitz.

For \(L\) larger than the support of \(g\), define the real odd
two-boundary function on \((-L,L)\) by
\[
 F_L(x)=g(L-x)\quad(x>0),\qquad
 F_L(x)=-g(L+x)\quad(x<0).                                 \tag{4}
\]
Its squared norm is \(2\|g\|_2^2\). The exact pole moments satisfy
\[
 E_+(F_L)=-E_-(F_L)
 =e^{L/2}M_g(1/2)-e^{-L/2}M_g(-1/2)
 =-e^{-L/2}M_g(-1/2).
\]
Thus the complete pole quadratic is \(O_g(e^{-L})\).
The gamma quadratic is \(O_g(1)\): translations change only Fourier
phases, and the fixed step has
\(|\widehat g(t)|=O_g((1+|t|)^{-1})\), whose square is integrable
against the absolute digamma weight. Same-side prime correlations
involve only
the finitely many \(\log d\) below the fixed support diameter and
are \(O_g(1)\).

The cross-boundary prime correlation is exact. With \(u=2L\), set
\[
 T_g(u)=-2\sum_{d\ge2}\frac{\Lambda(d)}{\sqrt d}
                   k(u-\log d).                           \tag{5}
\]
Because \(\operatorname{supp}g\subset(0,\infty)\), each nonzero term
in (5) has \(d<e^u\), exactly the admitted Weil cutoff. Direct
translation of the two shells in (4) gives
\[
 \langle F_L,K_LF_L\rangle=T_g(2L)+O_g(1),
 \qquad
 Q_L(F_L)=-T_g(2L)+O_g(1).                                 \tag{6}
\]
Every proper prime power stays in (5).
At \(u=\log(N+1)\), \(d>N+1\) contributes zero, and the
potential endpoint \(d=N+1\) has \(k(0)=0\). Thus (5) is exactly
compatible with the \(d\le N\) sum in the finite cell form.

## A nonreal pole forces positive terminal excursions

Chebyshev's \(\psi(x)\ll x\) gives \(T_g(u)=O_g(e^{u/2})\). For
\(\operatorname{Re}w>1/2\), absolute convergence and the convolution
identity yield the exact Laplace transform
\[
 \int_0^\infty T_g(u)e^{-wu}du
 =2M_g(w)^2\frac{\zeta'(w+1/2)}{\zeta(w+1/2)}.             \tag{7}
\]
At \(w=z\), the right side has a nonreal pole because
\(M_g(z)\ne0\). It is holomorphic at every positive real \(w\):
\(\zeta\) has no real zero for real argument \(>1/2\), and the
double zero \(M_g(1/2)^2=0\) cancels the zeta pole at \(w=1/2\).

Fix \(a=\sigma-\varepsilon>0\). If \(T_g(u)\le C e^{au}\)
eventually, then \(C e^{au}-T_g(u)\) on that tail is nonnegative
and has a finite Laplace abscissa \(\alpha\le1/2\).
The nonreal pole in (7) forces \(\alpha\ge\sigma>a\). Yet (7),
the elementary transform of \(Ce^{au}\), and the entire correction
from the omitted initial interval give a holomorphic continuation at
the positive real point \(w=\alpha\). This contradicts
[Landau's singularity theorem for nonnegative Laplace transforms](../../formalization/BuildingBlocks/LandauSingularity.lean),
also used in the smooth-packet note. Hence
\[
 \limsup_{u\to\infty}T_g(u)e^{-au}=+\infty.                \tag{8}
\]
The argument uses the complete signed prime sum, rather than an
isolated-zero term in an explicit formula.

## Transfer to the exact finite cell matrix

For \(u=\log(N+1)=2L\), the right shell \(g(L-x)\) in (4) is
already constant on the cells \(I_m,I_n\) of \(S_N\). Let \(P_N\)
be cellwise averaging. The reflected left shell has only finitely
many discontinuities at fixed distances from \(-L\); each lies in a
cell of length \(O_g(N^{-1})\). Therefore the zero-extended error
\(h_N=P_NF_L-F_L\) obeys
\[
 \|h_N\|_1=O_g(N^{-1}),\qquad
 \|h_N\|_2=O_g(N^{-1/2}),\qquad
 \operatorname{TV}(h_N)=O_g(1).                            \tag{9}
\]
The [spatial Schur bound](../prime-distribution/prime-shift-weighted-schur-window-asymptotic.md)
gives \(\|K_L\|=O(\sqrt N)\), so the prime quadratic changes by
\(O_g(1)\). The pole moments change by
\(O_g(e^{L/2}\|h_N\|_1)=O_g(N^{-3/4})\).
For the gamma form, split the Fourier integral at \(|t|=N\):
Plancherel and (9) bound its absolute-weight quadratic on
\(|t|\le N\) by \(O_g((\log N)/N)\), while
\(|\widehat h_N(t)|\le\operatorname{TV}(h_N)/|t|\) gives the same
bound above \(N\). Cauchy–Schwarz against the fixed bounded
absolute-weight gamma energy of \(F_L\) makes the mixed gamma
term \(o_g(1)\). Consequently
\[
 Q_N(P_NF_L)=-T_g(\log(N+1))+O_g(1),\qquad
 \|P_NF_L\|_2^2=2\|g\|_2^2+o_g(1).                         \tag{10}
\]

Finally \(k\) is globally Lipschitz and the active \(d\)'s in (5)
satisfy \(d\asymp_g e^u\). Chebyshev therefore gives
\[
 |T_g(u)-T_g(v)|\ll_g e^{u/2}|u-v|
 \quad(|u-v|\le e^{-u},\ u\ \text{large}).                \tag{11}
\]
Rounding \(e^u\) to an integer \(N+1\) changes \(u\) by
\(O(e^{-u})\), so (11) changes \(T_g\) by \(O_g(e^{-u/2})\).
The Rayleigh quotient of (10), followed by (8), proves (1).

The [negative-index density theorem](compact-weil-successor-cell-negative-index-density.md)
bounds the *number* of nonpositive cell eigenvalues by
\(O(N/(\log N)^2)\). Equation (1) concerns the *size* of at least
one negative eigenvalue if RH fails; it is compatible with that
unconditional count. This theorem is written analytic mathematics,
not a Lean formalization; the linked Lean file proves the general
Landau principle used here, not this successor-cell application.
It does not establish an off-line zero or RH. No priority claim is
made for the underlying odd-packet Laplace argument.
