# A stretched-exponential negative-index bound for the complete successor-cell Weil form

The [exact successor-cell refinement](compact-weil-successor-cell-refinement.md)
defines the complete \(N\)-cell Weil form \(Q_N\), including every admitted
\(\Lambda(p^j)=\log p\), the full gamma multiplier, and both poles. The
[fourth-logarithm bound](compact-weil-successor-cell-negative-index-fourth-log.md)
deletes coarse cells and splits small from large prime dilations. Keeping
that large-dilation estimate, but using high moments of the *prime-only*
small-dilation Fourier multiplier, gives a stronger unconditional count.
This is a written analytic proof, not a Lean formalization. It does not
bound the size of a negative eigenvalue or prove RH.

**Theorem.** There are absolute \(c,C>0\) and \(N_0\) such that, for
\(N\ge N_0\), the complete form has a complex subspace
\(V_N\subseteq S_N\) with
\[
 \boxed{\quad
 \operatorname{codim}_{S_N}V_N
 \le C N\exp(-c\sqrt{\log N}),\qquad
 Q_N(f)\ge c\log N\,\|f\|_2^2\quad(f\in V_N).
 \quad}                                                       \tag{1}
\]
In particular,
\[
 \boxed{\quad
 \operatorname{ind}_{\le0}(Q_N)
 \ll N\exp(-c\sqrt{\log N}).
 \quad}                                                       \tag{2}
\]

## Exact split and the gamma budget

Put \(X=N+1\), \(L=\frac12\log X\), and
\(e_n=\mathbf1_{I_n}/\sqrt{\ell_n}\), with
\(\ell_n=\log((n+1)/n)\). Write \(R_d\) for the exact child-cell
matrix, \(K_N=\sum_{d=2}^N\Lambda(d)d^{-1/2}(R_d+R_d^*)\), and
\(P_N\) for the continuous prime-density operator with kernel
\(e^{|x-y|/2}\). The pole cancellation and digamma recurrence give
the **complete** identity
\[
 Q_N(f)=\frac1{2\pi}\int_{\mathbb R}
 b(t)|\widehat f(t)|^2dt-\langle f,(K_N-P_N)f\rangle,
 \qquad b(t)=\Re\psi_{\rm digamma}(5/4+it/2)-\log\pi.
 \tag{3}
\]
It retains both poles; \(P_N\) is not discarded.

Set \(u=\sqrt{\log N}\), and, for large \(N\), choose
\[
 D=\lfloor e^u\rfloor,\qquad
 M=\lceil e^{2u}\rceil,\qquad
 k=\lfloor u/8\rfloor,\qquad T_0=\sqrt N.
 \tag{4}
\]
Let \(\Pi_M\) project onto the cells \(n>M\), so its complement has
dimension \(M\). All estimates below take place on \(\Pi_MS_N\).
Split \(K_N=K_{\rm pr}+K_{\rm pow}+K_{>D}\): \(K_{\rm pr}\) has the
terms \(d=p\le D\), \(K_{\rm pow}\) has \(d=p^j\le D\), \(j\ge2\),
and \(K_{>D}\) has every prime power \(D<d\le N\). These sets are
disjoint and exhaustive, including their integer endpoints.

Chebyshev's \(\psi(y)\ll y\) and partial summation give
\[
 \|K_{\rm pow}\|
 \le2\sum_{\substack{p^j\le D\\j\ge2}}
     \frac{\log p}{p^{j/2}}
 \ll\sum_{p\le\sqrt D}\frac{\log p}{p}
    +\sum_p\frac{\log p}{p^{3/2}(1-p^{-1/2})}
 \ll\log D=O(u).                                             \tag{5}
\]
Thus the full proper-power contribution costs less than
\((\log N)/32\) for all sufficiently large \(N\).

The shifted multiplier satisfies \(b(t)\ge-C_b\) everywhere and
\(b(t)\ge\frac13\log N\) on \(|t|>T_0\). For a small parameter
\(\eta_N>0\) fixed below, let \(B_{\rm low}\) be the compressed
Fourier-mass form on \(|t|\le T_0\). As
\(|\widehat e_n(t)|^2\le\ell_n\),
\[
 0\le B_{\rm low}\le I,\qquad
 \operatorname{Tr}B_{\rm low}
 \le \frac{T_0}{\pi}\sum_{n>M}\ell_n
 \ll\sqrt N\log N.                                          \tag{6}
\]
Delete its eigenvectors with eigenvalue greater than \(\eta_N\).
The remaining space \(W_N\subseteq\Pi_MS_N\) has
\[
 \operatorname{codim}_{\Pi_MS_N}W_N
 \ll\frac{\sqrt N\log N}{\eta_N},\qquad
 \frac1{2\pi}\int_{|t|\le T_0}|\widehat f(t)|^2dt
 \le\eta_N\|f\|_2^2\quad(f\in W_N).
 \tag{7}
\]
If \(\eta_N\to0\), (3) gives a gamma budget of at least
\((\log N)/4\) on \(W_N\), for large \(N\).

## Low-frequency prime mass and high moments

The exact prime-only Fourier multiplier is
\[
 F_D(t)=2\Re P_D(t),\qquad
 P_D(t)=\sum_{p\le D}\frac{\log p}{\sqrt p}\,p^{it}.
 \tag{8}
\]
In particular,
\(\langle f,K_{\rm pr}f\rangle
 =(2\pi)^{-1}\int F_D(t)|\widehat f(t)|^2dt\).
Chebyshev gives \(\|F_D\|_\infty\ll\sqrt D\). Choose
\[
 \eta_N=c_0\,\frac{\log N}{\sqrt D},                          \tag{9}
\]
where the absolute \(c_0>0\) is small enough that the
\(|t|\le T_0\) portion of (8) costs at most
\((\log N)/32\) on \(W_N\). For large \(N\),
\(\eta_N<1/4\), and (7) costs
\[
 O(\sqrt N\sqrt D)
 =O(\sqrt N e^{u/2})                                         \tag{10}
\]
dimensions.

Let \(H_D\) be the Hermitian operator on \(\Pi_MS_N\) defined by
the high-frequency quadratic
\[
 \langle f,H_Df\rangle
 =\frac1{2\pi}\int_{|t|>T_0}
          F_D(t)|\widehat f(t)|^2dt.
 \tag{11}
\]
For any orthonormal eigenbasis \(f_j\) of \(H_D\), scalar Jensen's
inequality applied to the Plancherel probability measure
\(|\widehat f_j(t)|^2dt/(2\pi)\) gives
\[
 \operatorname{Tr}|H_D|^{2k}
 \le\frac1{2\pi}\int_{|t|>T_0}
     |F_D(t)|^{2k}\,\omega_{M,N}(t)\,dt,\qquad
 \omega_{M,N}(t)=\sum_{n>M}|\widehat e_n(t)|^2.              \tag{12}
\]
This is a trace bound for the **compressed** multiplier; it makes no
pointwise claim about its spectrum.

For every cell,
\[
 |\widehat e_n(t)|^2
 =\ell_n\,\operatorname{sinc}^2(t\ell_n/2)
 \le\min\{\ell_n,\,4/(t^2\ell_n)\}.
\]
Since \(1/(n+1)\le\ell_n\le1/n\), summation yields, uniformly in
\(M\),
\[
 \omega_{M,N}(t)\ll
 \begin{cases}
 1+\log^+(N/|t|),&1\le|t|\le N,\\
 N^2/t^2,&|t|\ge N.
 \end{cases}                                               \tag{13}
\]

Put \(V_D=\sum_{p\le D}(\log p)^2/p\ll(\log D)^2\ll u^2\),
where the bound follows from \(\psi(y)\ll y\) by partial
summation. Expanding the \(k\)-th power,
\[
 P_D(t)^k=\sum_{m\le D^k}b_k(m)m^{it},\qquad
 \sum_m|b_k(m)|^2\le k!V_D^k.                              \tag{14}
\]
Indeed, unique factorization makes each coefficient a multinomial
in distinct prime weights, and comparing its square with the
multinomial expansion of \(V_D^k\) gives the \(k!\) factor.

For completeness, any Dirichlet polynomial
\(Z(t)=\sum_{m\le Y}a_m m^{it}\) and any real interval \(I\) of
length \(T\) satisfy the elementary mean-value bound
\[
 \int_I|Z(t)|^2dt
 \le\bigl(T+C Y\log(2Y)\bigr)\sum_m|a_m|^2.                 \tag{15}
\]
After expanding the square, the off-diagonal integral is at most
\(2/|\log(m/n)|\le2Y/|m-n|\); applying
\(2|a_ma_n|\le|a_m|^2+|a_n|^2\) and summing the harmonic series
proves (15). In (14),
\(D^k\le e^{u^2/8}=N^{1/8}\). Thus for every dyadic interval
\([T,2T]\) with \(T\ge T_0=\sqrt N\), (14)--(15) give
\[
 \int_T^{2T}|P_D(t)|^{2k}dt
 \ll T\,k!V_D^k.                                           \tag{16}
\]
The same estimate holds on negative-frequency intervals.

On each dyadic interval, combine (13), (16), and
\(|F_D|\le2|P_D|\). The geometric sums
\(\sum_{T_0\le T\le N}T[1+\log(N/T)]\ll N\) and
\(\sum_{T\ge N}N^2/T\ll N\) show from (12) that
\[
 \operatorname{Tr}|H_D|^{2k}
 \ll N\,4^k k!V_D^k.                                       \tag{17}
\]
At the threshold \(h_N=(\log N)/32=u^2/32\), Markov's
eigenvalue count, \(k!\le k^k\), and (4) give
\[
 \#\{j:|\lambda_j(H_D)|>h_N\}
 \ll N\left(\frac{Ck u^2}{u^4}\right)^k
 \le N\left(\frac{C'}u\right)^k
 \le N\exp(-c_1u\log u).                                  \tag{18}
\]
Delete these eigenspaces. On their complement the high-frequency
prime quadratic is at most \(h_N\|f\|_2^2\).

## The large-dilation residual and min--max

The row calculation in the fourth-logarithm proof applies for any
\(1\ll M<N\) and \(2\le D<N\). With \(\Pi_M\) as above, it gives
for the **complete** remaining prime powers and continuous density
\[
 T_N=\Pi_M(K_{>D}-P_N)\Pi_M,\qquad
 \|T_N\|_{\rm HS}^2
 \ll \frac{N(\log N)^2}{M}
      +\sqrt N(\log N)^2
      +N\frac{\log(2D)}D+\frac NM.                         \tag{19}
\]
For clarity, the large-dilation entry on \(r>n\) is
\(\sqrt{\ell_r/\ell_n}
 \sum_{d>D,\ r/(n+1)<d\le r/n}\Lambda(d)/\sqrt d\).
For \(M<n\le\sqrt r\), its squared row sum is
\(O((\log r)^2(M^{-1}+r^{-1/2}))\); for \(n>\sqrt r\),
the interval has at most one integer and the squared row sum is
\(O(\sum_{d>D}\Lambda(d)^2/d^2)
 =O(\log(2D)/D)\). The continuous coefficient is at most \(2/n\)
off the diagonal and \(O(1/n)\) on it, yielding \(O(N/M)\) in
(19). These are exact cell-matrix bounds; no prime power is omitted.

Substituting (4) in (19) gives
\[
 \|T_N\|_{\rm HS}^2\ll N u e^{-u}.                          \tag{20}
\]
Delete its eigenvectors with eigenvalue greater than \(h_N\).
Their dimension is at most
\[
 \frac{\|T_N\|_{\rm HS}^2}{h_N^2}
 \ll \frac{N e^{-u}}{u^3}.                                \tag{21}
\]
On the intersection of this complement, the complement from
(18), and \(W_N\), equations (3), (5), (7), (9), and
(11) give
\[
 Q_N(f)\ge
 \left(\frac14-\frac1{32}-\frac1{32}
                  -\frac1{32}-\frac1{32}\right)
      \log N\,\|f\|_2^2
 =\frac18\log N\,\|f\|_2^2.
\]
The total codimension, including the \(M\) coarse cells, is
\[
 O\!\left(e^{2u}+\sqrt N e^{u/2}
          +N e^{-c_1u\log u}
          +\frac{Ne^{-u}}{u^3}\right)
 =O(Ne^{-c u})
\]
for some absolute \(c>0\), since \(u=\sqrt{\log N}\).
The finite-dimensional min--max principle proves (1)--(2).

The bound counts possible nonpositive directions; one large negative
direction is still permitted. The unconditional
[VK-rate negative-part bound](compact-weil-successor-cell-negative-part-vk-density.md)
remains a separate magnitude estimate. No claim is made that this
elementary high-moment argument settles the signed Weil criterion.

For attribution, [Bombieri's 2000 study of the compact Weil functional](https://www.bdim.eu/item?fmt=pdf&id=RLIN_2000_9_11_3_183_0)
examines spectral behavior and negative eigenvalues in different
finite truncations. [Groskin's numerical study](https://arxiv.org/abs/2605.20224v4)
and [finite Guinand--Weil dictionary](https://arxiv.org/abs/2607.02828v3)
use a Connes--van Suijlekom Galerkin space, rather than these
successor cells. This note makes no absolute literature-priority
claim.
