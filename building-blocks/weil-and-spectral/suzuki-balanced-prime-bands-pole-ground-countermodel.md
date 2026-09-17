# Balanced prime bands preserve the pole and ground limits

RH Agent3, 2026-09-17; centered-heat extension independently derived by RH Proof. **Status:** written countermodel to two proposed scalar repairs of the [sparse downweight test](suzuki-pole-normalized-sparse-prime-countermodel.md). It keeps the actual prime-power locations, a positive weight shared by all powers of each prime, a stretched-exponential PNT error, a positive factorial ground with the **actual limit** \(1+\gamma\), and an Euler product with the **actual right pole residue and constant term**. Its completed first Suzuki variation still has negative excursions larger than every \(x^\delta\), \(\delta<1/2\), while its centered Goldbach heat energy has logarithmic limsup exponent \(1\). The signed weights do not preserve the stronger order \(F_*\ge F\) from the downweight model. No assertion about zeros of \(\zeta\) follows.

## Two exact moments and one negative clock moment

Let \(X\) be large, \(L=\log X\), and divide \((X/8,X]\) into
\[
 I_0=(X/8,X/4],\qquad I_1=(X/4,X/2],\qquad I_2=(X/2,X].
\]
For \(k=0,1,2\), sum over primes in \(I_k\) and put
\[
 h_k=\sum_{p\in I_k}\frac{\log p}{p-1},\qquad
 g_k=\sum_{p\in I_k}-\log(1-p^{-1}),\qquad
 s_k=\sum_{p\in I_k}\frac{\log p}{\sqrt p}.
\tag{1}
\]
The \(h_k\) include every power \(p^r\) through
\(\sum_{r\ge1}(\log p)/p^r=\log p/(p-1)\).

Set \(\ell=\log2\) and let \(z=\log(t/X)\). The ordinary PNT with a stretched-exponential error, as used in the [earlier test](suzuki-pole-normalized-sparse-prime-countermodel.md), gives
\[
\begin{aligned}
 h_k&=\ell+O(e^{-c\sqrt L}),\\
 g_k&=\frac{\ell}{L}-\frac{\mu_k}{L^2}+O(L^{-3}),\\
 s_k&=2\sqrt X\,(\sqrt{\beta_k}-\sqrt{\alpha_k})+o(\sqrt X),
\end{aligned}
\tag{2}
\]
where \(I_k=(\alpha_kX,\beta_kX]\) and
\[
 (\mu_0,\mu_1,\mu_2)
 =\left(-\frac52,-\frac32,-\frac12\right)\ell^2.
\]
For \(g_k\), replace \(-\log(1-p^{-1})\) by \(1/p+O(p^{-2})\), apply partial summation to the PNT, and expand
\(\int_{I_k}dt/(t\log t)=\int dz/(L+z)\).
The PNT error is smaller than every fixed negative power of \(L\) on these bands.

The determinant
\[
 D_X=h_0g_1-h_1g_0=-\frac{\ell^3}{L^2}+O(L^{-3})
\]
is nonzero for large \(X\). Define exact real weights
\[
 w_2=-1,\qquad
 w_0=\frac{h_2g_1-h_1g_2}{D_X},\qquad
 w_1=\frac{h_0g_2-h_2g_0}{D_X}.
\tag{3}
\]
They obey
\[
 \sum_{k=0}^2w_kh_k=\sum_{k=0}^2w_kg_k=0,
 \qquad (w_0,w_1,w_2)=(-1,2,-1)+O(L^{-1}).
\tag{4}
\]
Write \(a=2^{-1/2}\). Since \(s_1=as_2+o(\sqrt X)\),
\(s_0=a^2s_2+o(\sqrt X)\), and
\(s_2=2(1-a)\sqrt X+o(\sqrt X)\), (4) yields
\[
 \boxed{\displaystyle
 W_X:=\sum_{k=0}^2w_ks_k
 =-2(1-2^{-1/2})^3\sqrt X+o(\sqrt X)<0.}
\tag{5}
\]
Both cancellations in (4) are exact at each chosen \(X\); only the sign evaluation uses the PNT.

## Sparse insertion and completed Suzuki variation

Choose integer \(X_j\to\infty\) with \(X_{j+1}\ge X_j^2>16X_j\),
\(\log X_j\ge j^4\), and all \(X_j\) large enough for (3)-(5).
Let \(a_0>0\) be small enough that the actual complete Chebyshev and first-Suzuki-variation errors are
\[
 \psi(x)-x=O(xe^{-a_0\sqrt{\log x}}),\qquad
 r_1(x)=O(\sqrt x\,e^{-a_0\sqrt{\log x}}),\qquad
 D(t)=O(t^{-1}e^{-a_0\sqrt{\log(1/t)}})
\tag{6}
\]
at large nonintegral \(x\) and small positive \(t\), where \(D(t)=\sum_{n\ge1}(\Lambda(n)-1)e^{-nt}\). The heat estimate follows by Stieltjes integration of the complete Chebyshev error, after reducing \(a_0\) if necessary; the [earlier test](suzuki-pole-normalized-sparse-prime-countermodel.md#construction-and-the-completed-prime-clock) gives the endpoint calculation. Put
\(\varepsilon_j=e^{-(a_0/2)\sqrt{\log X_j}}\).
For \(p\in I_{jk}\), the \(k\)-th band at scale \(X_j\), set
\[
 \lambda_p=1+\varepsilon_jw_{jk},\qquad
 \Lambda_*(p^r)=\lambda_p\log p\quad(r\ge1).
\tag{7}
\]
Elsewhere use \(\lambda_p=1\). The weights in (4) are bounded by \(3\) for large \(j\); increasing the first \(X_j\) makes \(\lambda_p>1/2\) and \(\sum_j\varepsilon_j\) as small as desired.

Use the completed variation \(r_{1,*}\) obtained from the [actual formula](suzuki-pole-normalized-sparse-prime-countermodel.md) by replacing every \(\Lambda(p^r)\) with \(\Lambda_*(p^r)\) and keeping its full archimedean term. At \(x_j=X_j+1/2\), the current band's proper powers lie beyond \(x_j\), so its contribution to \(r_{1,*}-r_1\) is \(2\varepsilon_jW_{X_j}\). Each earlier band's prime contribution is negative by (5). Its entire proper-power contribution, including any partial cutoff, is \(O(\varepsilon_i)\): uniformly in the cutoff,
\[
 \sum_{p\in(X_i/8,X_i]}\log p
          \sum_{r\ge2}p^{-r/2}
 \ll\sum_{p\in(X_i/8,X_i]}\frac{\log p}{p}=O(1).
\]
Thus each large earlier band has a negative net contribution, while future bands have not entered. From (5)-(6),
\[
 r_{1,*}(x_j)
 \le -c\,\varepsilon_j\sqrt{X_j},
 \qquad
 \frac{r_{1,*}(x_j)}{x_j^\delta}\longrightarrow-\infty
 \quad\text{for every fixed }\delta<\frac12.
\tag{8}
\]
The same split at \(p=\sqrt x\) used in the earlier test, now with
\(|\lambda_p-1|\le3\varepsilon_j\), proves
\[
 \psi_*(x)=x+O(xe^{-c_0\sqrt{\log x}})
\tag{9}
\]
for some \(c_0>0\). Every prime power remains in this estimate.

## The unchanged ground limit and pole jet

Define the factorial ground from the complete deformed source:
\[
 F_*(x)=\log x-\sum_{n\le x}\frac{\Lambda_*(n)}n
                    +\frac{\psi_*(x)}x.
\]
For all \(x>1\), the exact comparison is
\[
 F_*(x)-F(x)=
 \sum_{n\le x}\bigl(\Lambda(n)-\Lambda_*(n)\bigr)
                       \left(\frac1n-\frac1x\right).
\tag{10}
\]
Each band has zero total harmonic perturbation by (4), and the absolute harmonic perturbation is \(O(\varepsilon_j)\).
Consequently \(\lim_{x\to\infty}(F_*(x)-F(x))=0\), so
\[
 \lim_{x\to\infty}F_*(x)=1+\gamma.
\tag{11}
\]
Since \(F(x)\to1+\gamma>0\), choose the first band far out and
\(\sum_j\varepsilon_j\) small enough that the absolute value of (10) stays below half a positive lower bound for \(F\) on the affected half-line. Before the first band \(F_*=F>0\). Hence \(F_*(x)>0\) for every \(x>1\). Unlike the downweight model, (10) has both signs.

For real \(s>1\), set
\[
 Z_*(s)=\prod_p(1-p^{-s})^{-\lambda_p}
       =\zeta(s)H(s),\qquad
 H(s)=\prod_p(1-p^{-s})^{1-\lambda_p}.
\tag{12}
\]
The series for \(\log H(1)\) and its right derivative converge absolutely: their band contributions in absolute value are \(O(\varepsilon_j/\log X_j)\) and \(O(\varepsilon_j)\), respectively. The two exact moments in (4) give
\[
 \log H(1)=\sum_j\varepsilon_j\sum_kw_{jk}g_{jk}=0,
 \qquad
 (\log H)'(1+)=-\sum_j\varepsilon_j\sum_kw_{jk}h_{jk}=0.
\tag{13}
\]
Therefore \(H(1)=1\), \(H'(1+)=0\), and on the real convergence side
\[
 Z_*(s)=\frac1{s-1}+\gamma+o(1)\qquad(s\downarrow1).
\tag{14}
\]
Both the pole residue and constant term match \(\zeta\). The Euler-quotient coefficients for
\(Z_*(s-\omega)/Z_*(s+\omega)\) remain strictly positive because every \(\lambda_p>0\). Its right pole-normalizer slope is still \(2\). The complete centered Goldbach heat series
\(\bigl[\sum_{n\ge1}(\Lambda_*(n)-1)e^{-nt}\bigr]^2\) remains nonnegative for every \(t>0\). Ordinary prime locations are unchanged, so a support-only Goldbach assertion has the same truth value for this model. Neither fact gives a quantitative Goldbach error or makes (8) a statement about the actual \(\zeta\).

## Why the stronger ground order cannot also survive

For one band, let \(d_n=\Lambda(n)-\Lambda_*(n)\), including all powers of its finitely many altered prime bases, and put
\[
 \Delta F(x)=\sum_{n\le x}d_n\left(\frac1n-\frac1x\right).
\]
The first equality in (4) gives \(\sum_nd_n/n=0\).
Geometric decay over the powers gives \(\sum_n|d_n|/\sqrt n<\infty\).
Integrating (10) to a finite \(R\) and then letting \(R\to\infty\) yields the exact identity
\[
 \boxed{\displaystyle
 \sum_{n\ge1}\frac{d_n}{\sqrt n}
 =-\frac14\int_1^\infty\frac{\Delta F(x)}{\sqrt x}\,dx.}
\tag{15}
\]
Indeed the finite integral equals
\[
 2\sqrt R\sum_{n\le R}\frac{d_n}{n}
 -4\sum_{n\le R}\frac{d_n}{\sqrt n}
 +\frac2{\sqrt R}\sum_{n\le R}d_n.
\]
The first and last terms vanish at infinity for a finite set of prime bases, while the middle sum converges. Equation (5) makes the left side of (15) positive for large \(X\), even after all proper powers are included. Hence \(\Delta F(x)<0\) somewhere. Matching the ground limit and retaining the order \(F_*\ge F\) would prevent this negative completed prime-clock perturbation. The construction keeps \(F_*>0\), not that stronger comparison.

## Centered Goldbach heat despite both matched scalar limits

The stronger band separation also makes the centered heat obstruction exact. Put
\(D_*(t)=\sum_{n\ge1}(\Lambda_*(n)-1)e^{-nt}\) and
\(\mathscr H_*(T)=1+\int_{e^{-T}}^1D_*(t)^2dt\). For any finite \(T\), the exponential Cauchy product gives the complete signed Goldbach expansion
\[
 \mathscr H_*(T)=1+\sum_{N\ge2}
  \bigl[R_*(N)-2\psi_*(N-1)+(N-1)\bigr]
  \frac{e^{-Ne^{-T}}-e^{-N}}N,                         \tag{16}
\]
absolutely convergently. This is the same finite-horizon normalization as the [actual centered heat criterion](../goldbach/centered-goldbach-heat-lyapunov.md), with every prime power and density endpoint retained.

For \(c\in[1/32,1/16]\), set \(t=c/X_j\). The first-power contribution of the current three-band block to \(D_*(t)-D(t)\), divided by \(\varepsilon_jX_j\), converges uniformly to
\[
 C(c)=-\int_{1/8}^{1/4}e^{-cy}dy
       +2\int_{1/4}^{1/2}e^{-cy}dy
       -\int_{1/2}^{1}e^{-cy}dy.                         \tag{17}
\]
Indeed (4) gives the limiting weights and PNT gives the three weighted integrals. Here \(C(0)=-1/8\), while
\(|C(c)-C(0)|\le(9/8)c\le9/128\), so \(C(c)\le-7/128\) throughout the interval. The current band's proper powers start at \((X_j/8)^2\) and have exponentially small heat weight at this time scale.

Earlier blocks cannot cancel this negative main term. For a base \(p\ge2\) and \(t\ge(32X_j)^{-1}\),
\(\sum_{r\ge1}e^{-p^rt}\ll1+\log X_j/\log p\): count the powers below \(X_j\), then bound the geometrically growing tail. Since \(X_i\le\sqrt{X_j}\) for \(i<j\), the absolute contribution of all earlier blocks is
\[
 O\!\left(\log X_j\sum_{i<j}\varepsilon_iX_i\right)
 =O(\sqrt{X_j}\log X_j)
 =o(\varepsilon_jX_j).                                  \tag{18}
\]
All future altered prime powers start beyond \(X_{j+1}/8\ge X_j^2/8\); their total is bounded by
\(O(\sum_{n\ge X_j^2/8}(\log n)e^{-n/(32X_j)})
=o(\varepsilon_jX_j)\). Finally (6) makes the actual \(D(t)\) itself \(o(\varepsilon_jX_j)\), uniformly for \(c\in[1/32,1/16]\). Therefore
\[
 D_*(c/X_j)\le-c_1\varepsilon_jX_j
 \qquad(1/32\le c\le1/16)                            \tag{19}
\]
for a fixed \(c_1>0\) and all large \(j\).

With \(T_j=\log(32X_j)\), this interval of length \((32X_j)^{-1}\) lies inside \([e^{-T_j},1]\), so
\(\mathscr H_*(T_j)\gg\varepsilon_j^2X_j
=X_j e^{-a_0\sqrt{\log X_j}}\). Conversely \(\lambda_p\le2\) gives
\(|D_*(t)|=O(t^{-1})\) and \(\mathscr H_*(T)=O(e^T)\). Hence
\[
 \boxed{\displaystyle
 \limsup_{T\to\infty}\frac{\log\mathscr H_*(T)}T=1.}   \tag{20}
\]
Thus even matching \(F_*(\infty)=1+\gamma\) and the first two right-hand pole coefficients does not turn the qualitative centered Goldbach square into an RH-scale energy bound. This conclusion concerns the deformed system; it is written analysis, not a Lean theorem or an RH result.

It still violates the exact actual divisor identity
\(\sum_{d\mid n}\Lambda(d)=\log n\), or equivalently the exact amplitudes
\(\Lambda(p^r)=\log p\). Nor does \(Z_*\) acquire the zeta functional equation from (12)-(14). Those full arithmetic and analytic constraints remain possible places to seek the missing sign estimate. This countermodel proves no RH result and has no Lean formalization.
