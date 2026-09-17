# A stretched-exponential bound on total negative successor-cell Weil mass

The [complete successor-cell matrix](compact-weil-successor-cell-refinement.md)
has a [stretched-exponential bound on the *number* of nonpositive
eigenvalues](compact-weil-successor-cell-negative-index-stretched-exponential.md)
and a separate [VK-rate bound on the most negative
eigenvalue](compact-weil-successor-cell-negative-part-vk-density.md).
The same high-moment and coarse-cell estimates also control the
*sum* of all negative eigenvalue magnitudes. This is an
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
 \le C N\exp(-c\sqrt{\log N}).
 \quad}                                                     \tag{1}
\]
Thus the average negative eigenvalue mass per cell decays at a
stretched-exponential rate. Equation (1) is an aggregate estimate;
it does not improve the established bound for
\(\lambda_{\min}(Q_N)\).

## The complete multiplier and a fine-cell block

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
 u=\sqrt{\log N},\qquad
 D=\lfloor e^u\rfloor,\qquad
 M=\lceil e^{2u}\rceil,\qquad
 k=\lfloor u/8\rfloor,\qquad T_0=\sqrt N.                 \tag{3}
\]
For large \(N\), \(2\le D<M<N\). Let \(\Pi_M\) project onto
the cells \(n>M\). Split the prime matrix into \(K_{\le D}\)
and \(K_{>D}\), including all proper powers in their literal
integer ranges. On the fine-cell space \(\Pi_MS_N\),
\[
 \Pi_MQ_N\Pi_M=A_N-T_N,\qquad
 T_N=\Pi_M(K_{>D}-P_N)\Pi_M,                              \tag{4}
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
          \omega_{M,N}(t)\,dt,\qquad
 \omega_{M,N}(t)=\sum_{n>M}|\widehat e_n(t)|^2.           \tag{8}
\]
Indeed the Fourier weights of the negative eigenvectors sum
pointwise to at most \(\omega_{M,N}\). The same variational
principle and trace-norm duality give
\[
 \operatorname{Tr}(\Pi_MQ_N\Pi_M)_-
 \le\operatorname{Tr}(A_N)_-+\|T_N\|_1.                   \tag{9}
\]

The large-dilation and continuous-density row calculation in the
[index proof](compact-weil-successor-cell-negative-index-stretched-exponential.md#the-large-dilation-residual-and-min--max)
is uniform in \(D\) and \(M\):
\[
 \|T_N\|_{\rm HS}^2
 \ll\frac{N(\log N)^2}{M}
       +\sqrt N(\log N)^2
       +N\frac{\log(2D)}D+\frac NM
 \ll N u e^{-u}.                                         \tag{10}
\]
This estimate includes every \(d>D\) prime power and the full
continuous matrix. Since \(\operatorname{rank}T_N\le N\),
\[
 \|T_N\|_1\le\sqrt N\,\|T_N\|_{\rm HS}
 \ll N\sqrt u\,e^{-u/2}.                                 \tag{11}
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
 \frac1{2\pi}\int_{|t|\le T_0}\omega_{M,N}(t)dt
 \le\frac{T_0}{\pi}\sum_{n>M}\ell_n
 \ll\sqrt N\log N.
\]
The low-frequency contribution to (8) is consequently
\[
 O(\sqrt N\sqrt D\,\log N)
 =O(\sqrt N e^{u/2}\log N).                              \tag{12}
\]

For large \(N\), (6) also makes
\(\|F_{\rm pow}\|_\infty\le(\log N)/12\). Thus on
\(|t|>T_0\),
\[
 \bigl(F_{\le D}(t)-b(t)\bigr)_+
 \le\bigl(F_{\rm pr}(t)-a_N\bigr)_+,\qquad
 a_N=\tfrac14\log N.
 \tag{13}
\]
For real \(x\) and \(a>0\),
\((x-a)_+\le |x|^{2k}/a^{2k-1}\). Hence the high-frequency
portion of (8) is at most
\[
 a_N^{1-2k}\frac1{2\pi}
   \int_{|t|>T_0}|F_{\rm pr}(t)|^{2k}
                     \omega_{M,N}(t)\,dt.                \tag{14}
\]
The [high-moment estimate](compact-weil-successor-cell-negative-index-stretched-exponential.md#low-frequency-prime-mass-and-high-moments)
proves, with
\(V_D=\sum_{p\le D}(\log p)^2/p\ll u^2\),
\[
 \frac1{2\pi}\int_{|t|>T_0}|F_{\rm pr}(t)|^{2k}
                  \omega_{M,N}(t)dt
 \ll N\,4^k k!V_D^k.                                     \tag{15}
\]
For clarity, the \(k\)-th power of the prime Dirichlet
polynomial has length \(D^k\le N^{1/8}\) and squared
coefficient norm at most \(k!V_D^k\). The elementary
mean-square bound on every dyadic interval
\([T,2T]\), \(T\ge\sqrt N\), is therefore
\(O(Tk!V_D^k)\). The exact cell Fourier weight is
\[
 \omega_{M,N}(t)\ll
 \begin{cases}
  1+\log^+(N/|t|),&1\le|t|\le N,\\
  N^2/t^2,&|t|\ge N,
 \end{cases}
\]
and its dyadic weighted sum is \(O(N)\), including
\(|t|\gg N\). This gives (15) with no truncated-frequency
remainder.

Since \(k!\le k^k\), \(k\asymp u\), \(V_D\ll u^2\), and
\(a_N\asymp u^2\), (14)--(15) are
\[
 \ll N a_N\left(\frac{CkV_D}{a_N^2}\right)^k
 \ll N u^2\left(\frac{C'}u\right)^k
 \ll N u^2 e^{-c_1u\log u}.                              \tag{16}
\]
Equations (8), (12), and (16) control the negative trace
on the fine-cell multiplier.

## Restore the coarse cells

The full form has a crude uniform lower bound
\[
 Q_N\ge-C\sqrt N\,I.                                      \tag{17}
\]
Indeed \(b\ge-C_b\), the prime shifts are contractions and
\(\sum_{d\le N}\Lambda(d)/\sqrt d\ll\sqrt N\), while
the continuous kernel \(e^{|x-y|/2}\) has spatial row
integral \(O(e^L)=O(\sqrt N)\). Thus (17) holds with
both poles retained through (2).

Let the eigenvalues of \(Q_N\) be
\(\lambda_1\le\cdots\le\lambda_N\), and those of its
fine-cell principal compression be
\(\mu_1\le\cdots\le\mu_{N-M}\). Cauchy interlacing gives
\(\mu_i\le\lambda_{i+M}\). The first \(M\) eigenvalues
cost at most \(CM\sqrt N\) by (17); each remaining
negative magnitude is bounded by the corresponding one
for the fine compression. Therefore
\[
 \operatorname{Tr}(Q_N)_-
 \le CM\sqrt N+
        \operatorname{Tr}(\Pi_MQ_N\Pi_M)_-.
 \tag{18}
\]
Combine (9), (11)--(12), (16), and (18). The result is
\[
 \operatorname{Tr}(Q_N)_-
 \ll e^{2u}\sqrt N+\sqrt N e^{u/2}\log N
      +Nu^2e^{-c_1u\log u}
      +N\sqrt u\,e^{-u/2}
 \ll N e^{-c u},
\]
for some absolute \(c>0\), proving (1).

This trace bound complements the index and least-eigenvalue
bounds. A sparse set of negative eigenvalues with large
magnitude is still allowed, so the signed full-space Weil
inequality remains open.

The [index proof's attribution paragraph](compact-weil-successor-cell-negative-index-stretched-exponential.md)
compares earlier compact Weil truncations with the different
successor-cell space used here. No literature-priority claim is made.
