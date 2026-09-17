# Rare prime phases can carry Paley–Wiener mass

This is an obstruction to using the *frequency density alone* of large prime-comb values to control all compact pole-null odd tests. It does not give a sign for the actual odd Weil form.

Use the odd half-line normalization of the [continuum-prime decomposition](../weil-and-spectral/suzuki-odd-continuum-prime-square-and-arithmetic-remainder.md). Write
\[
h_a(x)=\sqrt2\sinh(x/2),\qquad
S_u(t)=\int_0^a u(x)\sin(tx)\,dx,
\qquad \frac2\pi\int_0^\infty |S_u(t)|^2dt=\|u\|_2^2.
\]
For \(a>0\), set \(N=e^{2a}\), \(w_n=\Lambda(n)n^{-1/2}\), and
\[
W_a=\sum_{2\le n<N}w_n,\qquad
Q_a(t)=\sum_{2\le n<N}w_n\cos(t\log n),\qquad
E_a=\{t\ge0:Q_a(t)\ge0.97W_a\}.
\tag{1}
\]
Terms with \(\Lambda(n)=0\) contribute zero.

**Theorem.** As \(a\to\infty\), the following hold.

1. For an absolute \(c>0\), the upper natural density of \(E_a\) is at most \(\exp(-c e^{2a}/a^2)\). More precisely, the bound is \(\exp(-(0.9409+o(1))e^{2a}/a^2)\).
2. There is a \(t_a\) with \(100\le t_a\le100(10^5)^{r_a}\), where \(r_a=\#\{2\le n<N:\Lambda(n)>0\}=O(e^{2a}/a)\), such that
   \[
   [t_a-0.01/a,t_a+0.01/a]\subset E_a.
   \tag{2}
   \]
3. An absolute \(c_0>0\) exists such that, for all large \(a\), some real \(u_a\in C_c^\infty(0,a)\) satisfies \(\|u_a\|_2=1\), \(\langle h_a,u_a\rangle=0\), and
   \[
   \frac2\pi\int_{E_a}|S_{u_a}(t)|^2dt\ge c_0.
   \tag{3}
   \]
   The odd extension has both Weil pole moments zero exactly.

**Proof.** The prime number theorem and partial summation give
\(W_a=(2+o(1))e^a\). For each prime \(p<N\), put
\[
q_p(\theta)=\sum_{r:p^r<N}\frac{\log p}{p^{r/2}}\cos(r\theta),
\qquad
M_p=\sum_{r:p^r<N}\frac{\log p}{p^{r/2}}.
\]
The \(q_p\) have mean zero and \(|q_p|\le M_p\). Unique factorization makes the prime logarithms rationally independent, so the continuous prime-phase flow is equidistributed on the finite torus. Hoeffding's lemma on each independent coordinate and the exponential Markov inequality therefore give, for \(0<\lambda\),
\[
\overline d\{t\ge0:Q_a(t)\ge\lambda\}
\le \exp\!\left(-\frac{\lambda^2}{2\sum_{p<N}M_p^2}\right).
\tag{4}
\]
Since \(M_p\le(\log p)/(\sqrt p-1)\), the prime number theorem also gives
\[
\sum_{p<N}M_p^2
=\sum_{p<N}\frac{(\log p)^2}{p}+O(1)
=\left(\frac12+o(1)\right)(\log N)^2
=(2+o(1))a^2.
\]
Putting \(\lambda=0.97W_a\) in (4) proves part 1.

Apply simultaneous Dirichlet approximation to the \(r_a\) numbers \(\log n/(2\pi)\) with denominator parameter \(10^5\). It supplies \(1\le q\le(10^5)^{r_a}\) for which every \(q\log n\) is within \(2\pi/10^5\) of \(2\pi\mathbb Z\). If \(q<100\), multiply by \(\lceil100/q\rceil\); otherwise leave it unchanged. The resulting \(t_a\) obeys the stated bounds and \(\cos(t_a\log n)>0.99\) for every admitted prime power. Thus \(Q_a(t_a)>0.99W_a\). The derivative bound
\[
|Q_a'(t)|\le\sum_{n<N}w_n\log n\le2aW_a
\]
then proves (2). The prime number theorem gives \(r_a=O(N/\log N)\), since primes dominate the higher powers.

Fix a nonnegative \(\varphi\in C_c^\infty(1/4,3/4)\) with \(\|\varphi\|_2=1\), and set
\(v_a(x)=a^{-1/2}\varphi(x/a)\sin(t_ax)\). Then \(\|v_a\|_2^2\to1/2\). Write
\(C_\varphi(s)=\int_{1/4}^{3/4}\varphi(y)\cos(sy)dy\). For \(t=t_a+s/a\),
\[
S_{v_a}(t)=\frac{\sqrt a}{2}
\left[C_\varphi(s)-C_\varphi(2at_a+s)\right].
\tag{5}
\]
The second term tends uniformly to zero for \(|s|\le0.01\). Therefore the fraction of the sine spectral mass of \(v_a\) in the interval (2) tends to
\[
c_\varphi
=\frac1\pi\int_{-0.01}^{0.01}C_\varphi(s)^2ds>0.
\tag{6}
\]

To impose the pole condition, choose a fixed nonnegative \(\beta\in C_c^\infty(1/2,1)\) and define
\[
b_a(x)=\frac{\beta(a-x)}{\int_0^a h_a(y)\beta(a-y)dy}.
\]
For large \(a\), this is compact smooth, \(\langle h_a,b_a\rangle=1\), and \(\|b_a\|_2=O(e^{-a/2})\). The support of \(v_a\) lies below \(3a/4\), so Cauchy–Schwarz gives \(|\langle h_a,v_a\rangle|=O(e^{3a/8})\). Hence
\[
\widetilde u_a=v_a-\langle h_a,v_a\rangle b_a,
\qquad
\|\widetilde u_a-v_a\|_2=O(e^{-a/8}).
\]
Normalize \(\widetilde u_a\) to obtain \(u_a\). Sine Plancherel preserves the limiting mass (6), so (3) holds, for example with \(c_0=c_\varphi/2\). The pole condition for the odd extension follows from \(\langle h_a,u_a\rangle=0\). \(\square\)

The interval width in part 2 is the uncertainty scale. For every \(u\in L^2(0,a)\) and interval \(I\subset[0,\infty)\), Cauchy–Schwarz gives
\[
\frac2\pi\int_I|S_u(t)|^2dt
\le\frac{2a}{\pi}|I|\,\|u\|_2^2.
\tag{7}
\]
For the tests above, the mass in an interval of width \(2\delta/a\) is of order \(\delta\) as \(\delta\downarrow0\), matching (7) in scale.

Thus even this exponentially sparse **actual prime-phase set** carries a fixed fraction of the Fourier mass of some admissible pole-null tests. Its density cannot by itself supply a decaying all-test bound. A bound that also uses the spatial envelope and the exact prime-shift quadratic form remains possible; this theorem neither proves nor disproves all-scale odd Weil positivity. The operator normalization comes from [Suzuki, *Weil's quadratic form via the screw function*](https://arxiv.org/html/2606.09096v1). The classical time-bandwidth concentration problem is treated by [Slepian and Pollak](https://www.math.ucdavis.edu/~saito/data/ONR15/PSWF-I.pdf); the construction here needs only sine Plancherel. No novelty or priority is claimed.
