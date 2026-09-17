# A log-log strengthened bound on total negative successor-cell Weil mass

The [complete successor-cell matrix](compact-weil-successor-cell-refinement.md)
has a [log-log strengthened bound on the *number* of nonpositive
eigenvalues](compact-weil-successor-cell-negative-index-stretched-exponential.md)
and a separate [VK-rate bound on the most negative
eigenvalue](compact-weil-successor-cell-negative-part-vk-density.md).
The same high-moment estimate, together with exact trace-norm
bounds for large dilations and the continuous kernel, also controls
the *sum* of all negative eigenvalue magnitudes. This is an
unconditional written proof for the actual von Mangoldt weights,
including every prime power, both poles, and the full gamma term.
It does not prove that any individual eigenvalue is nonnegative or
settle RH; no Lean formalization is claimed.

For a Hermitian matrix \(A\), write
\(A_-=\frac12(|A|-A)\), so
\(\operatorname{Tr}A_-=\sum_{\lambda_j(A)<0}|\lambda_j(A)|\).

**Theorem.** There are absolute \(c,C>0\) and \(N_0\) such that
the complete \(N\)-cell Weil matrix satisfies, for \(N\ge N_0\),
\[
 \boxed{\quad
 \operatorname{Tr}(Q_N)_-
 \le C N\exp\!\bigl(-c\sqrt{\log N\,\log\log N}\bigr).
 \quad}                                                     \tag{1}
\]
Thus the average negative eigenvalue mass per cell decays at this
log-log strengthened rate. Equation (1) is an aggregate estimate;
it does not improve the established bound for
\(\lambda_{\min}(Q_N)\).

## The complete multiplier and an exact split

Put \(X=N+1\), \(L=\tfrac12\log X\), and let \(S_N\) have the
orthonormal cell basis \(e_n=\mathbf1_{I_n}/\sqrt{\ell_n}\),
\(\ell_n=\log((n+1)/n)\). With \(K_N\) the exact
all-prime-power shift matrix and \(P_N\) the continuous
prime-density operator with kernel \(e^{|x-y|/2}\), the
pole--density cancellation and digamma recurrence give the full
form identity
\[
 Q_N(f)=\frac1{2\pi}\int_{\mathbb R}
 b(t)|\widehat f(t)|^2dt
          -\langle f,(K_N-P_N)f\rangle,\qquad
 b(t)=\Re\psi_{\rm digamma}(5/4+it/2)-\log\pi .
 \tag{2}
\]
Both exact poles are present in this identity.

Set
\[
 L=\log N,\qquad u=\sqrt{L\log L},\qquad
 D=\lfloor e^u\rfloor,\qquad
 k=\lfloor L/(8u)\rfloor,\qquad T_0=\sqrt N.             \tag{3}
\]
For large \(N\), \(2\le D<N\), \(u=o(L)\), \(k\to\infty\), and
\(D^k\le e^{uk}\le N^{1/8}\). Split the prime matrix into \(K_{\le D}\)
and \(K_{>D}\), including all proper powers in their literal
integer ranges. On the complete space \(S_N\),
\[
 Q_N=A_N-K_{>D}+P_N,                                      \tag{4}
\]
where \(A_N\) is the Fourier-multiplier compression with real
symbol \(b(t)-F_{\le D}(t)\), and
\[
 F_{\le D}(t)
 =2\Re\sum_{2\le d\le D}
        \frac{\Lambda(d)}{\sqrt d}\,d^{it}
 =F_{\rm pr}(t)+F_{\rm pow}(t).
 \tag{5}
\]
Here \(F_{\rm pr}(t)=2\Re\sum_{p\le D}(\log p)p^{-1/2+it}\)
and \(F_{\rm pow}\) contains every \(p^j\le D\), \(j\ge2\).
The exact cell refinements ensure (4)--(5); no boundary dilation
is replaced by an approximate shift.

Chebyshev's \(\psi(y)\ll y\) gives
\[
 \|F_{\le D}\|_\infty\ll\sqrt D,\qquad
 \|F_{\rm pow}\|_\infty
 \le2\sum_{\substack{p^j\le D\\j\ge2}}
      \frac{\log p}{p^{j/2}}
 \ll\log D=O(u).                                          \tag{6}
\]
The first estimate is partial summation. For the second, prime
squares cost \(\sum_{p\le\sqrt D}\log p/p=O(\log D)\), while
the sum over \(j\ge3\) converges after extending it to all primes.

## A variational negative-trace inequality

For any finite Hermitian \(A\),
\[
 \operatorname{Tr}A_-
 =\max_{0\le R\le I}-\operatorname{Tr}(RA).
 \tag{7}
\]
Applying this to the compression in (4), or simply summing over
an orthonormal basis of its negative spectral space, gives
\[
 \operatorname{Tr}(A_N)_-
 \le \frac1{2\pi}\int_{\mathbb R}
       \bigl(F_{\le D}(t)-b(t)\bigr)_+\,
          \omega_N(t)\,dt,\qquad
 \omega_N(t)=\sum_{n=1}^N|\widehat e_n(t)|^2.             \tag{8}
\]
Indeed the Fourier weights of the negative eigenvectors sum
pointwise to at most \(\omega_N\).

## Trace norms of the complete residual

Let \(R_d\) be the exact child-cell shift in the
[refinement theorem](compact-weil-successor-cell-refinement.md).
Only columns \(n\le\lfloor N/d\rfloor\) are nonzero, and their child
sets are disjoint. Thus
\(\operatorname{rank}R_d=\lfloor N/d\rfloor\) and
\(\|R_d\|_{\rm op}\le1\), including the clipped last column.
The triangle inequality for the nuclear norm gives
\[
 \begin{aligned}
 \|K_{>D}\|_1
 &\le2\sum_{D<d\le N}
        \frac{\Lambda(d)}{\sqrt d}\,\|R_d\|_1\\
 &\le2N\sum_{d>D}\frac{\Lambda(d)}{d^{3/2}}
 \ll\frac N{\sqrt D}.
 \end{aligned}                                            \tag{9}
\]
The final bound follows by partial summation from Chebyshev's
\(\psi(x)\ll x\). Every \(d>D\) prime power is retained.

The continuous operator \(P\) on \([-L,L]\) has kernel
\(e^{|x-y|/2}\). It has the exact factorization
\[
 e^{|x-y|/2}
 =g(x)g(y)-\int_{-L}^{L}h_s(x)h_s(y)\,ds,\qquad
 g(x)=e^{(x+L)/2},\quad
 h_s(x)=e^{(x-s)/2}\mathbf1_{x\ge s}.                     \tag{10}
\]
Indeed, integrating to \(\min(x,y)\) and subtracting from
\(e^{(x+y+2L)/2}\) leaves \(e^{|x-y|/2}\). Compression preserves
this rank-one-minus-positive form, so \(P_N\) has at most one
positive eigenvalue. Its trace is positive, because every diagonal
cell integral has a positive kernel. Its operator norm is
\(O(e^L)=O(\sqrt N)\) by the spatial Schur bound. Consequently,
if \(\lambda_+(P_N)>0\) is the sole positive eigenvalue, then
\[
 \|P_N\|_1=2\lambda_+(P_N)-\operatorname{Tr}P_N
 \le2\|P_N\|_{\rm op}\ll\sqrt N.                           \tag{11}
\]
This treats the full, indefinite continuous matrix; positivity
of \(P_N\) is not assumed.

The variational principle (7), trace-norm duality, and (4) now give
\[
 \operatorname{Tr}(Q_N)_-
 \le\operatorname{Tr}(A_N)_-
     +\|K_{>D}\|_1+\|P_N\|_1.                             \tag{12}
\]

## Low and high Fourier frequencies

The shifted gamma symbol satisfies \(b(t)\ge-C_b\) on the
whole line and \(b(t)\ge\frac13\log N\) for
\(|t|\ge T_0\), once \(N\) is large. On
\(|t|\le T_0\), (6) therefore implies
\((F_{\le D}-b)_+\ll\sqrt D\).
The cell transforms obey
\(|\widehat e_n(t)|^2\le\ell_n\), so their low-frequency
trace is at most
\[
 \frac1{2\pi}\int_{|t|\le T_0}\omega_N(t)dt
 \le\frac{T_0}{\pi}\sum_{n=1}^{N}\ell_n
 \ll\sqrt N\log N.
\]
The low-frequency contribution to (8) is consequently
\[
 O(\sqrt N\sqrt D\,\log N)
 =O(\sqrt N e^{u/2}L).                                   \tag{13}
\]

For large \(N\), (6) also makes
\(\|F_{\rm pow}\|_\infty\le(\log N)/12\). Thus on
\(|t|>T_0\),
\[
 \bigl(F_{\le D}(t)-b(t)\bigr)_+
 \le\bigl(F_{\rm pr}(t)-a_N\bigr)_+,\qquad
 a_N=\tfrac14\log N.
 \tag{14}
\]
For real \(x\) and \(a>0\),
\((x-a)_+\le |x|^{2k}/a^{2k-1}\). Hence the high-frequency
portion of (8) is at most
\[
 a_N^{1-2k}\frac1{2\pi}
   \int_{|t|>T_0}|F_{\rm pr}(t)|^{2k}
                     \omega_N(t)\,dt.                    \tag{15}
\]
The [high-moment estimate](compact-weil-successor-cell-negative-index-stretched-exponential.md#low-frequency-prime-mass-and-high-moments)
proves, with
\(V_D=\sum_{p\le D}(\log p)^2/p\ll u^2\),
\[
 \frac1{2\pi}\int_{|t|>T_0}|F_{\rm pr}(t)|^{2k}
                  \omega_N(t)dt
 \ll N\,4^k k!V_D^k.                                     \tag{16}
\]
For clarity, the \(k\)-th power of the prime Dirichlet
polynomial has length \(D^k\le N^{1/8}\) and squared
coefficient norm at most \(k!V_D^k\). The elementary
mean-square bound on every dyadic interval
\([T,2T]\), \(T\ge\sqrt N\), is therefore
\(O(Tk!V_D^k)\), with an absolute constant independent of \(k\):
the mean-square remainder \(D^k\log(2D^k)\ll\sqrt N\le T\).
The exact cell Fourier weight is
\[
 \omega_N(t)\ll
 \begin{cases}
  1+\log^+(N/|t|),&1\le|t|\le N,\\
  N^2/t^2,&|t|\ge N,
 \end{cases}
\]
and its dyadic weighted sum is \(O(N)\), including
\(|t|\gg N\). This gives (16) with no truncated-frequency
remainder.

Since \(k!\le k^k\), \(k\le L/(8u)\), \(V_D\ll u^2\), and
\(a_N\asymp L\), (15)--(16) are
\[
 \ll N L\left(\frac{Ck u^2}{L^2}\right)^k
 \le N L\left(\frac{C'u}{L}\right)^k.                    \tag{17}
\]
For all sufficiently large \(L\), \(k\ge L/(16u)\) and
\(\log(L/(C'u))\ge(2/5)\log L\). Since \(u^2=L\log L\),
the expression in (17) is at most
\(NL e^{-u/40}\ll N e^{-u/80}\).
Equations (8), (13), and (17) control the negative trace
of the complete small-prime multiplier. Combining with
(9), (11), and (12) gives
\[
 \operatorname{Tr}(Q_N)_-
 \ll \sqrt N e^{u/2}L
      +N e^{-u/80}
      +Ne^{-u/2}+\sqrt N
 \ll N e^{-c u},
\]
for some absolute \(c>0\), because \(u=o(L)\). This proves (1)
using only Chebyshev's \(\psi(x)\ll x\), which is weaker than RH.

This trace bound complements the index and least-eigenvalue
bounds. A sparse set of negative eigenvalues with large
magnitude is still allowed, so the signed full-space Weil
inequality remains open.

The [index proof's attribution paragraph](compact-weil-successor-cell-negative-index-stretched-exponential.md)
compares earlier compact Weil truncations with the different
successor-cell space used here. [Bombieri's study of the compact Weil
functional](https://eudml.org/doc/252338) analyzes negative eigenvalues
in another truncation. No literature-priority claim across all
truncations is made. A hypothetical fixed off-critical-line zero pair
is compatible with (1): a bounded number of negative directions
fits inside its right side. The full signed Weil criterion remains
open.
