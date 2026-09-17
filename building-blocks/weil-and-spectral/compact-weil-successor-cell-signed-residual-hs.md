# A signed Hilbert–Schmidt estimate for the complete successor-cell residual

The [exact successor-cell refinement](compact-weil-successor-cell-refinement.md)
gives a finite matrix for every admitted von Mangoldt shift. The
[fourth-logarithm negative-index proof](compact-weil-successor-cell-negative-index-fourth-log.md)
bounds the large-shift matrix after deleting coarse cells. On those coarse
cells the prime matrix and continuous density are individually large, but
their **difference** can be bounded with the unconditional prime number
theorem. This yields a signed estimate on the entire cell space.

Put \(X=N+1\), let \(S_N\) have the orthonormal basis
\(e_n=\mathbf1_{I_n}/\sqrt{\ell_n}\) from the refinement theorem, and
write
\[
K_{>D,N}=\sum_{D<d\le N}\frac{\Lambda(d)}{\sqrt d}
              (R_{d,N}+R_{d,N}^{*}),\qquad
P_N=\bigl(\langle e_r,e^{|x-y|/2}e_n\rangle\bigr)_{r,n\le N}.
\]
Every prime power \(d=p^j\), \(j\ge1\), in \(D<d\le N\) is included
at its literal integer endpoint. Let
\(\Phi(y)=(\log y)^{3/5}(\log\log y)^{-1/5}\) for large \(y\).

**Theorem.** There are absolute constants \(\eta,c,C>0\) and \(N_0\)
such that, with \(D=\lfloor\exp(\eta\Phi(N))\rfloor\), for every
\(N\ge N_0\),
\[
\boxed{\quad
 \|K_{>D,N}-P_N\|_{\mathrm{HS}}^2
 \le C N\exp[-c\Phi(N)].
\quad}                                                   \tag{1}
\]
Consequently every orthonormal family \((f_j)\) in \(S_N\) obeys the
signed, arbitrary-vector estimate
\[
\boxed{\quad
\sum_j\bigl|\langle f_j,(K_{>D,N}-P_N)f_j\rangle\bigr|^2
\le C N\exp[-c\Phi(N)].
\quad}                                                   \tag{2}
\]
This is a bound on the paired arithmetic and continuous matrices, not
on either one separately. In the **complete** Weil form the exact split is
\[
Q_N(f)=\frac1{2\pi}\int_{\mathbb R}
 [b(t)-F_{\le D}(t)]|\widehat f(t)|^2\,dt
 -\langle f,(K_{>D,N}-P_N)f\rangle,
\quad b(t)=\Re\psi_{\rm digamma}(5/4+it/2)-\log\pi .       \tag{3}
\]
Here \(F_{\le D}(t)=2\Re\sum_{2\le d\le D}
\Lambda(d)d^{-1/2+it}\), with all smaller prime powers retained.
Thus both poles and the full gamma term remain present; (1) does not
sign (3) or prove RH.

## Exact entries and the unconditional input

For \(r>n\), write \(\ell_n=\log(1+1/n)\) and
\[
 U_{r,n}=\sqrt{\frac{\ell_r}{\ell_n}}
  \sum_{\substack{d>D\\r/(n+1)<d\le r/n}}
            \frac{\Lambda(d)}{\sqrt d},
\qquad
 P_{r,n}=\frac{4(\sqrt{r+1}-\sqrt r)
       (n^{-1/2}-(n+1)^{-1/2})}{\sqrt{\ell_r\ell_n}}.
                                                               \tag{4}
\]
These are the exact off-diagonal entries of \(K_{>D,N}\) and \(P_N\).
For \(r>n\), every \(x\in I_r\) lies left of every \(y\in I_n\);
integrating \(e^{(y-x)/2}\) over the two cells gives the second
formula in (4).
In particular, the lower endpoint in the prime sum is strict.
The diagonal of \(K_{>D,N}\) is zero and
\(0<P_{r,r}\le e^{\ell_r/2}\ell_r\ll1/r\).

We use only the established, unconditional PNT error
\[
 |\psi(y)-y|\le C_0y\exp[-a_0\Phi(y)]
 \quad(y\ge y_0),\qquad a_0>0,                              \tag{5}
\]
available from [Johnston's PNT theorem](https://arxiv.org/abs/2411.13791v2)
and the [fixed Korobov–Vinogradov zero-free region](https://arxiv.org/abs/2306.10680).
No zero estimate at the RH scale is used. We also use
\(\Lambda(d)\le\log d\), \(\ell_r/\ell_n\le(n+1)/r\), and
\(\sum_{d>D}\Lambda(d)^2/d^2\ll\log(2D)/D\); the last estimate
follows from Chebyshev's \(\psi(y)\ll y\) by partial summation,
as in the fourth-logarithm proof.

## Coarse parent cells: the signed payment

Choose \(0<\eta<a_0/16\), and put
\(M=D=\lfloor e^{\eta\Phi(N)}\rfloor\).
For large \(N\), both \(M\) and \(D\) are at least two and
\((M+1)D<\sqrt N\). If \(r\ge\sqrt N\) and \(n\le M\), then
\[
 a=\frac r{n+1}\ge\frac{\sqrt N}{M+1}\ge N^{2/5}>D,
 \qquad b=\frac rn,\qquad \Phi(a)\ge\tfrac12\Phi(N).       \tag{6}
\]
Hence every dilation in this child interval belongs to \(K_{>D,N}\).

Set \(E(y)=\psi(y)-y\). Stieltjes integration by parts, with the
same strict and closed endpoints as (4), gives the **exact** identity
\[
\sum_{a<d\le b}\frac{\Lambda(d)}{\sqrt d}
 -\int_a^b y^{-1/2}\,dy
=\frac{E(b)}{\sqrt b}-\frac{E(a)}{\sqrt a}
 +\frac12\int_a^b E(y)y^{-3/2}\,dy.                       \tag{7}
\]
Equations (5)--(6) bound (7) by
\(C\sqrt b\,e^{-a_0\Phi(N)/2}\). After the exact cell
normalization, \(\sqrt{\ell_r/\ell_n}\sqrt b\le\sqrt2\).

The continuous integral in (7), with the same normalization, is
\[
 C_{r,n}=2\sqrt{\frac{r\ell_r}{\ell_n}}
       (n^{-1/2}-(n+1)^{-1/2})\le\frac{2}{n}.
\]
The exact continuous cell entry in (4) satisfies
\[
 P_{r,n}=\alpha_r C_{r,n},\qquad
 \alpha_r=\frac{2(\sqrt{r+1}-\sqrt r)}{\sqrt r\,\ell_r}
 =1+O(1/r).                                                \tag{8}
\]
The last estimate follows by putting \(h=1/r\) in
\(2(\sqrt{1+h}-1)/\log(1+h)=1+O(h)\), uniformly for
\(0<h\le1\). Therefore the signed coarse entries obey
\[
 |U_{r,n}-P_{r,n}|
 \le C\left(e^{-a_0\Phi(N)/2}+\frac1{rn}\right),
 \quad r\ge\sqrt N,\ n\le M,
\]
and their squared row sum is
\[
 \sum_{n\le M}|U_{r,n}-P_{r,n}|^2
 \ll M e^{-a_0\Phi(N)}+r^{-2}.                            \tag{9}
\]

## Fine parent cells and the short initial rows

For \(M<n\le\sqrt r\), the child interval in (4) has at most
\(1+r/[n(n+1)]\) integers. The exact length ratio and
\(\Lambda(d)\le\log r\) give
\[
 0\le U_{r,n}\le(\log r)
       \left(\frac1n+\frac{n+1}{r}\right),\qquad
 \sum_{M<n\le\sqrt r}U_{r,n}^2
 \ll(\log r)^2\left(\frac1M+\frac1{\sqrt r}\right).
                                                               \tag{10}
\]
For \(n>\sqrt r\), the interval has length less than one. Each
active dilation \(d\) determines its unique parent
\(n=\lfloor r/d\rfloor\), and its squared normalized entry is at
most \(2\Lambda(d)^2/d^2\). Thus
\[
 \sum_{\sqrt r<n<r}U_{r,n}^2
 \ll\frac{\log(2D)}D.                                     \tag{11}
\]
The continuous entry satisfies \(P_{r,n}\le2/n\), so its fine
squared row sum is \(O(1/M)\). Combining this with (10)--(11),
\[
 \sum_{M<n<r}|U_{r,n}-P_{r,n}|^2
 \ll \frac{(\log r)^2}{M}+\frac{(\log r)^2}{\sqrt r}
       +\frac{\log(2D)}D+\frac1M.                         \tag{12}
\]

For the initial rows \(r<\sqrt N\), repeat (10) with parents
starting at \(n=1\), and (11) without restricting \(D\).
They give \(\sum_{n<r}U_{r,n}^2\ll(\log(2r))^2\);
the continuous off-diagonal row has bounded square sum. Together
with the diagonal estimate after (4), all initial rows cost
\[
 \sum_{r<\sqrt N}\sum_{n\le r}
   |(K_{>D,N}-P_N)_{r,n}|^2
 \ll\sqrt N(\log N)^2.                                    \tag{13}
\]
The entries with \(n>r\) are the symmetric counterparts of
entries already counted in lower rows, so the full Hilbert--Schmidt
sum is at most twice the lower-triangular sum plus the diagonal sum.

For \(r\ge\sqrt N\), equations (9) and (12) give a row cost
\[
 \ll M e^{-a_0\Phi(N)}+\frac{(\log N)^2}{M}
    +\frac{(\log N)^2}{N^{1/4}}
    +\frac{\log(2D)}D+\frac1M+\frac1{r^2}.
\]
Because \(M=D=\lfloor e^{\eta\Phi(N)}\rfloor\),
\(\Phi(N)\gg\log\log N\), and \(\Phi(N)=o(\log N)\),
the sum of these terms is \(O(e^{-c\Phi(N)})\) for some
absolute \(c>0\). The initial-row term (13) is smaller than
\(N e^{-c\Phi(N)}\) after decreasing \(c\). This proves (1).
Equation (2) follows by Bessel's inequality for the orthonormal
rank-one projectors \(f_jf_j^*\) in Hilbert--Schmidt space.

This is a written analytic proof of (1)--(2). The exact
high-parent, one-dilation row and its reciprocal-square
von Mangoldt weight are [Lean-compiled finite
lemmas](../../formalization/BuildingBlocks/SuccessorHighParentPrimeRow.lean);
the PNT input, continuous-cell comparison, Hilbert--Schmidt
aggregation, and full analytic theorem are not Lean formalized.
No literature-priority claim is made. A hypothetical zero with fixed
\(1/2<\Re\rho<1\) is compatible with (5) and (1), since
\(y^{\Re\rho}=o(y e^{-a\Phi(y)})\) for every fixed \(a>0\).
