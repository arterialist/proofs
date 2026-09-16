# Persistent signed phase current and a logarithmic-form obstruction

This note continues the [actual prime phase-current identity](actual-prime-phase-current-entropy-reversal.md). Its conclusion is unconditional and retains every von Mangoldt prime-power atom. The sign reversal in that identity is not confined to rare simultaneous phase recurrences: both signs occupy a positive proportion of long frequency intervals. A direct attempt to pay for the resulting current derivative with Suzuki's logarithmic archimedean multiplier fails on the current's own Mellin profile. This does not estimate Suzuki's full odd Weil form, whose test functions and prime weights differ.

Let
\[
E(x)=\psi(x)-x,\quad
F(x)=\log x-\sum_{n\le x}\frac{\Lambda(n)}n+\frac{\psi(x)}x,
\quad r(x)=\frac{E(x)}{xF(x)}.
\]
Take \(1<a<b\) with \(E(a^-)=E(a)=E(b^-)=E(b)=0\). Set
\[
J_c(t)=\int_a^b(x/c)^{it}r(x)\,dx,\quad
M_c(t)=\int_{[a,b)}\frac{(x/c)^{it}}{F(x)}\,dE(x),
\]
and write
\[
\mathcal N=\{n\in[a,b):\Lambda(n)>0\},\quad
\alpha_n=\frac{\Lambda(n)}{F(n)},\quad
A=\sum_{n\in\mathcal N}\alpha_n,\quad
S_2=\sum_{n\in\mathcal N}\alpha_n^2,\quad
B=\max_{a\le x\le b}F(x).
\tag{1}
\]
The endpoint condition gives \(\sum_{n\in\mathcal N}\Lambda(n)=b-a\), so \(\mathcal N\ne\varnothing\) and \(A,S_2>0\). The ground \(F\) is continuous and positive on \([a,b]\).

**Theorem (two-sided Cesàro current).** For every \(0<c\le a\), let \(X_c(t)=\operatorname{Im}(tJ_c(t))\). Then
\[
\lim_{T\to\infty}\frac1T\int_0^T X_c(t)\,dt=0,\qquad
\lim_{T\to\infty}\frac1T\int_0^T X_c(t)^2dt=\frac{S_2}{2},
\tag{2}
\]
and the two positive-part means exist and obey the signed inequalities
\[
\boxed{\begin{aligned}
\lim_{T\to\infty}\frac1T\int_0^T (X_c(t))_+dt
&=\lim_{T\to\infty}\frac1T\int_0^T (-X_c(t))_+dt\\
&\ge\frac{S_2}{4A}\ge\frac{\log2}{4B}>0.
\end{aligned}}
\tag{3}
\]
Writing \(\eta=S_2/(8A)\), each sign also has an explicit lower frequency density:
\[
\boxed{\begin{aligned}
\liminf_{T\to\infty}\frac1T\operatorname{meas}\{0\le t\le T:X_c(t)\ge\eta\}
&\ge\frac{S_2}{8A^2},\\
\liminf_{T\to\infty}\frac1T\operatorname{meas}\{0\le t\le T:X_c(t)\le-\eta\}
&\ge\frac{S_2}{8A^2}.
\end{aligned}}
\tag{4}
\]
In particular the threshold \(\eta\) is at least \(\log2/(8B)\). Equations (2)--(4) also hold with \(X_c\) replaced by \(\operatorname{Re}M_c\).

**Proof.** Put \(v=\log(x/c)\), \(x=ce^v\), and extend \(q_c(v)=E(x)/F(x)\) by zero outside \([\log(a/c),\log(b/c)]\). The zero endpoints make this extension continuous there. The measure product rule \(d(E/F)=F^{-1}dE+r^2dx\), together with \(dE=\sum_n\Lambda(n)\delta_n-dx\), gives
\[
dq_c=\sum_{n\in\mathcal N}\alpha_n\delta_{\log(n/c)}
  +g_c(v)dv,
\qquad g_c(v)=x\left(r(x)^2-\frac1{F(x)}\right)\mathbf1_{[\log(a/c),\log(b/c)]}(v).
\tag{5}
\]
Here \(g_c\in L^1(\mathbb R)\) and \(J_c(t)=\int e^{itv}q_c(v)dv\). Integration by parts and the Riemann--Lebesgue lemma yield the exact asymptotic
\[
\boxed{tJ_c(t)=i\sum_{n\in\mathcal N}\alpha_ne^{it\log(n/c)}
       +i\int_{\mathbb R}e^{itv}g_c(v)dv
       =i\sum_{n\in\mathcal N}\alpha_ne^{it\log(n/c)}+o(1).}
\tag{6}
\]
For \(c\le a\), all frequencies \(\log(n/c)\) are positive and distinct. Hence
\(X_c(t)=\sum_n\alpha_n\cos(t\log(n/c))+o(1)\).
Cesàro orthogonality of distinct nonzero frequencies gives (2), while
\(|X_c(t)|\le A+o(1)\). The leading trigonometric polynomial is Bohr almost periodic, and composing it with the continuous map \(s\mapsto s_+\) preserves that property. The \(o(1)\) term does not affect its Cesàro mean. Thus both positive-part means exist. Since the mean of \(X_c\) is zero, they are equal. Also
\[
\frac{S_2}{2}=\lim_{T\to\infty}\frac1T\int_0^T X_c(t)^2dt
\le A\lim_{T\to\infty}\frac1T\int_0^T|X_c(t)|dt
=2A\lim_{T\to\infty}\frac1T\int_0^T(X_c(t))_+dt.
\]
Every \(n\in\mathcal N\) is a prime power, so \(\Lambda(n)\ge\log2\) and \(F(n)\le B\). Consequently \(S_2=\sum_n\alpha_n(\Lambda(n)/F(n))\ge(\log2/B)A\), proving (3).

For \(\eta=S_2/(8A)\), the elementary bound
\((X_c)_+\le\eta+(A+o(1))\mathbf1_{\{X_c\ge\eta\}}\) on late frequencies, combined with (3), gives the first inequality in (4); apply it to \(-X_c\) for the second. Finally the phase-current identity gives
\(\operatorname{Re}M_c(t)=X_c(t)-\operatorname{Re}\int_a^b(x/c)^{it}r(x)^2dx\).
The last integral tends to zero, so the same Cesàro statements hold for \(\operatorname{Re}M_c\). \(\square\)

For \(c=1\) there is an exact limiting law behind (3). Let \(\mathcal P\) be the finite set of primes with a power in \(\mathcal N\), and put
\(Q_p(\theta)=\sum_{r:p^r\in\mathcal N}\alpha_{p^r}\cos(r\theta)\).
Unique factorization makes \(\{\log p:p\in\mathcal P\}\) rationally independent. Kronecker equidistribution and (6) give, for every continuous \(\Phi\),
\[
\lim_{T\to\infty}\frac1T\int_0^T\Phi(X_1(t))dt
=\int_{\mathbb T^{|\mathcal P|}}\Phi\!\left(\sum_{p\in\mathcal P}Q_p(\theta_p)\right)
\prod_{p\in\mathcal P}\frac{d\theta_p}{2\pi}.
\tag{7}
\]
Thus the common value in (3) is exactly the torus integral of the positive part. Powers of one prime remain correlated inside their single coordinate.

The concrete interval \(a=\psi(103)\), \(b=\psi(107)\) from the [zero-to-zero entropy note](full-f-zero-to-zero-reciprocal-ground-entropy-covariance.md) has just the atom \(n=107\) in \([a,b)\). Here (6) becomes
\(X_1(t)=(\log107/F(107))\cos(t\log107)+o(1)\). Each sign has frequency density \(1/2\), and the common positive-part mean in (3) equals \(\log107/(\pi F(107))\).

**No direct logarithmic-form bound.** Let \(b_{\rm odd}(t)=\operatorname{Re}\psi(5/4+it/2)-\log\pi\), the multiplier after adding the positive Green term to Suzuki's odd archimedean form in the [continuum-prime decomposition](suzuki-odd-continuum-prime-square-and-arithmetic-remainder.md). Suzuki's [Fourier formula](https://arxiv.org/html/2606.09096v1) and the [digamma asymptotic](https://dlmf.nist.gov/5.11.E2) give \(|b_{\rm odd}(t)|=O(1+\log(2+t))\). From (5), \(q_c\) is compactly supported and of bounded variation, with
\[
\operatorname{Var}(q_c)\le A+\int_a^b\left(\frac1{F(x)}+r(x)^2\right)dx.
\]
Its zero endpoints give \(|J_c(t)|\le\operatorname{Var}(q_c)/|t|\) for \(t\ne0\). Therefore
\[
\int_0^\infty(1+|b_{\rm odd}(t)|)|J_c(t)|^2dt<\infty,
\qquad
\int_0^T|X_c(t)|^2dt=\frac{S_2}{2}T+o(T).
\tag{8}
\]
No finite constant, even one depending on this fixed interval, can make the proposed same-profile estimate
\[
\int_0^\infty|\operatorname{Im}(tJ_c(t))|^2dt
\le C_{a,b,c}\int_0^\infty(1+|b_{\rm odd}(t)|)|J_c(t)|^2dt
\tag{9}
\]
true. Partial summation from (2) shows that dividing the left integrand by \(1+\log(2+t)\) still leaves an integral asymptotic to \((S_2/2)T/\log T\). This is a precise obstruction to inserting the actual phase-current profile directly into a logarithmic archimedean Sobolev bound. Suzuki's archimedean form acts on an odd Weil test and its prime term uses \(\Lambda(n)n^{-1/2}\), whereas (1)--(9) use \(\Lambda(n)/F(n)\). The fixed-interval frequency density in (4) supplies no all-test bound for Suzuki's remainder and proves nothing about RH.

There is also a useful low-frequency signed check. For \(c=1\), Abel regularization of the cosine and sine transforms of \((1+t^2)^{-1}\) gives
\[
\frac2\pi\int_0^\infty\frac{X_1(t)}{1+t^2}dt
=\int_a^b\frac{r(x)}x dx
=\log\frac{F(a)}{F(b)},
\tag{10}
\]
and hence, from the exact phase-current identity,
\[
\boxed{\frac2\pi\int_0^\infty\frac{\operatorname{Re}M_1(t)}{1+t^2}dt
 -\log\frac{F(a)}{F(b)}
=-\int_a^b\frac{r(x)^2}{x}dx<0.}
\tag{11}
\]
The rational weight in (10)--(11) is a Poisson resolvent weight. It is not Suzuki's full logarithmic archimedean form.
