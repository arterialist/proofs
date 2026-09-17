# A first-prime transition in the logarithmically normalized odd remainder

This note concerns the **arithmetic remainder** in
[Suzuki's localized odd Weil form](../weil-and-spectral/suzuki-odd-continuum-prime-square-and-arithmetic-remainder.md),
not the sign of the full Weil form. It retains every prime power. The
first prime shift causes a sharp operator-ideal transition: below its
entry the normalized remainder is positive trace class; immediately
after entry it has two-sided eigenvalue tails too large for every
finite Schatten class.

Let \(L=\log2\), \(w_2=L/\sqrt2\), and work on \(L^2(0,a)\).
Write
\[
\mathcal R_a=P_a^{\rm odd}+\mathcal G_a,\qquad
\mathcal W_a=\mathcal A_a+\mathcal K_a-\mathcal R_a,
\]
where \(P_a^{\rm odd}\) is the complete prime-power shift/reflection
operator, \(\mathcal G_a\ge0\) is the continuum prime square, and
\(\mathcal K_a=\mathcal G_a-2|h_a\rangle\langle h_a|\).
Put
\[
b(t)=\Re\psi(5/4+it/2)-\log\pi,
\qquad c=1-b(0),
\]
and define the positive archimedean normalization \(H_a\) by its
closed quadratic form
\[
H_a[u]=\langle u,(\mathcal A_a+\mathcal K_a+cI)u\rangle
=\frac2\pi\int_0^\infty
 h(t)\left|\int_0^a u(x)\sin(tx)dx\right|^2dt,
\qquad h(t)=1+b(t)-b(0).
\tag{1}
\]
Finally set \(B_a=H_a^{-1/2}\mathcal R_aH_a^{-1/2}\).

**Theorem.** \(B_a\) is compact and self-adjoint for every finite
\(a\). If \(a\le L/2\), then \(B_a\ge0\) is trace class and
\[
\operatorname{Tr}B_a\le e^a-1-a.
\tag{2}
\]
If \(a>L/2\), choose \(\varepsilon>0\) sufficiently small that
\[
I=(L/2-\varepsilon,L/2+\varepsilon)\Subset(0,a),
\quad 2\varepsilon<L,
\quad L+2\varepsilon<\log3,
\quad 2\varepsilon e^{L/2+\varepsilon}\le w_2/2.
\]
For \(n\ge1\), put
\[
D_n=\frac95+\frac12\log\!\left(1+
             \left(\frac{2\pi n}{5\varepsilon}\right)^2\right).
\]
Denote the positive eigenvalues of \(B_a\) by \(\lambda_n^+\)
and the magnitudes of its negative eigenvalues by \(\lambda_n^-\),
both in decreasing order. Then
\[
\boxed{\lambda_n^+(B_a)\ge\frac{w_2}{D_n},
       \qquad\lambda_n^-(B_a)\ge\frac{w_2}{2D_n}.}
\tag{3}
\]
Neither sign part lies in \(S_p\) for any finite \(p>0\). The same
conclusion holds after imposing any finite number \(m\) of continuous
linear form-domain constraints, including exact pole-nullity; in
(3), replace \(D_n\) by \(D_{n+m}\).

**Proof.** The digamma series gives, with \(v=t/2\),
\[
h(t)-1=\sum_{j=0}^\infty
 \frac{v^2}{(j+5/4)((j+5/4)^2+v^2)}.
\]
The summand decreases with \(j\). Comparing the sum with its
integral and its first term gives the explicit bounds
\[
1+\frac12\log(1+4t^2/25)
\le h(t)\le
\frac95+\frac12\log(1+4t^2/25).
\tag{4}
\]
Thus \(H_a\ge I\). The lower bound makes Fourier tails uniformly
small on the \(H_a\)-form unit ball. At bounded frequencies, the sine
transform restricted to \((0,a)\) is a Hilbert–Schmidt integral
operator. Splitting into low and high frequencies proves that the
form-domain embedding into \(L^2(0,a)\), and hence
\(H_a^{-1/2}\), is compact. The finite-window remainder
\(\mathcal R_a\) is bounded, so \(B_a\) is compact.

For \(a\le L/2\), no prime-power shift has an overlap and
\(P_a^{\rm odd}=0\). The continuum square is positive trace class:
its continuous kernel has diagonal \(G_a(x,x)=e^x-1\), and its
square factorization gives
\(\operatorname{Tr}\mathcal G_a=\int_0^a(e^x-1)dx=e^a-1-a\).
Since \(0\le H_a^{-1}\le I\), conjugating \(\mathcal G_a\) proves
(2).

Now suppose \(a>L/2\), and let \(J\) reflect \(I\) around \(L/2\):
\((Ju)(x)=u(L-x)\). For tests supported in \(I\), every
same-side difference is below \(\log2\), while every reflected sum
lies between \(0\) and \(\log3\). Only the \(n=2\) reflected
shift remains. Thus the *exact compression* of the full prime-power
operator is
\[
\mathbf1_I P_a^{\rm odd}\mathbf1_I=-w_2J.
\tag{5}
\]
The positive continuum kernel satisfies
\(0\le G_a(x,y)\le e^{L/2+\varepsilon}\) on \(I^2\), so
\(\|\mathbf1_I\mathcal G_a\mathbf1_I\|
\le2\varepsilon e^{L/2+\varepsilon}\le w_2/2\).
Consequently
\[
\mathcal R_a[u]\ge w_2\|u\|_2^2\quad(Ju=-u),
\qquad
\mathcal R_a[u]\le-\frac{w_2}{2}\|u\|_2^2\quad(Ju=u)
\tag{6}
\]
for every test supported in \(I\).

Take the first \(n\) Dirichlet eigenfunctions on \(I\) of either
reflection parity, extended by zero. Every vector in either
\(n\)-dimensional span satisfies
\(\|u'\|_2^2\le(\pi n/\varepsilon)^2\|u\|_2^2\).
Sine Plancherel, the upper bound in (4), and Jensen's inequality for
\(\log\) give, for every vector in either span,
\[
H_a[u]\le\left[\frac95+
\frac12\log\!\left(1+
\frac4{25}\frac{\|u'\|_2^2}{\|u\|_2^2}\right)\right]\|u\|_2^2
\le D_n\|u\|_2^2.
\tag{7}
\]
Under \(v=H_a^{1/2}u\), the Rayleigh quotient of \(B_a\) is
\(\mathcal R_a[u]/H_a[u]\). Apply min–max on the two parity spans
using (6)–(7). This proves (3). For \(m\) linear constraints, start
with \(n+m\) modes in each parity and intersect with their common
kernel; at least \(n\) dimensions remain. Since \(D_n=O(\log(n+1))\),
\(\sum_n D_n^{-p}=\infty\) for every finite \(p\), proving the
Schatten assertions. \(\square\)

This also explains a limitation of the [traveling-wave prime-phase law](../weil-and-spectral/odd-weil-prime-coordinate-phase-law.md).
In the first-prime-only range \(L/2<a<(\log3)/2\), its direct-shift
polynomial is identically zero, because \(e^a<2\). But smooth
standing waves of opposite reflection parity supported in \(I\)
retain Rayleigh quotients tending respectively to \(-w_2\) and
\(+w_2\) for \(\mathcal R_a\) as their frequency grows: the compact
continuum part vanishes on weakly convergent oscillations. The
reflection channel couples opposite Fourier frequencies, which the
one-sided traveling-wave phase polynomial does not measure.

The [first-prime shift's infinite multiplicity](https://raw.githubusercontent.com/telleroutlook/weil-first-prime/main/paper/main.tex)
and [Suzuki's logarithmic-form compactness](https://arxiv.org/html/2606.09096v2)
are prior results. The explicit two-sided \(1/\log n\) lower bounds
for the normalized **actual remainder** and the sharp trace-class
transition above were not found in the targeted comparison; no
publication-priority claim is made. The theorem rules out ordinary
finite-Schatten trace moments or Fredholm determinants for \(B_a\).
It does not determine the sign of
\(H_a^{-1/2}\mathcal W_aH_a^{-1/2}=I-B_a-cH_a^{-1}\), and does not
prove or disprove RH.
