# Hardy control of the critical Weil packet's additive interaction

The [exact divisor-graph identity](compact-weil-divisor-graph-dirichlet-energy.md)
turns the prime deficit at the critical packet scale into a positive
multiplicative edge energy and boundary potential. The gamma multiplier
also couples *additive* neighbors, with a logarithmic singularity near
the packet diagonal. This note compares that interaction, and the
signed pole, with the exact graph energy **uniformly on the whole
resolved packet space**. It gives a uniform lower bound, not positivity
of the full Weil form.

Fix \(0<\delta<1\), \(c>4\), and a real
\(p\in C_c^\infty(-\delta,0)\) with \(\|p\|_2=1\). Use the
[critical packet setup](compact-weil-critical-packet-crossover.md):
\(L_N=\frac12\log(N+1)\), \(T=cN\), and orthonormal packets \(p_n\)
for \(1\le n\le N\), once \(N\) is sufficiently large. For
\(g=(g_1,\ldots,g_N)\), put
\[
 f_g=\sum_{n\le N}\frac{g_n}{\sqrt n}p_n,\qquad
 h_N(g)=\|f_g\|_2^2=\sum_{n\le N}\frac{|g_n|^2}{n},
 \tag{1}
\]
and
\[
 \begin{aligned}
 \mathcal E_N(g)
  &=\sum_{\substack{n,d\ge1,\ d>1\\nd\le N}}
      \frac{\Lambda(d)}{nd}|g_n-g_{nd}|^2,\\
 V_N(g)
  &=\sum_{n\le N}
      \frac{\log(N/n)-A(N/n)}{n}|g_n|^2,\qquad
 A(x)=\sum_{2\le d\le x}\frac{\Lambda(d)}d.
 \end{aligned}
 \tag{2}
\]
Both are nonnegative by the cited graph identity and the
[Ramaré--Zuniga-Alterman--Balazard inequality](https://arxiv.org/abs/2312.05138)
\(A(x)\le\log x\).

Let
\[
 B_p=\|p\|_1^2\le\delta,\quad
 g_p=\frac1{2\pi}\int_{\mathbb R}
          \log\frac{|u|}{2\pi}|\widehat p(u)|^2\,du,\quad
 \mu_\pm(T)=\int p(s)e^{\pm s/(2T)}\,ds.
 \tag{3}
\]
The off-center logarithmic gamma kernel is
\[
 \kappa_p(s)
 =-\frac12\iint_{\mathbb R^2}
        \frac{p(u)p(v)}{|s+u-v|}\,du\,dv
 \qquad (|s|>\delta).
 \tag{4}
\]
Define its full off-center form
\[
 \Gamma_{\rm off,N}(g)
 =\sum_{\substack{n,m\le N\\n\ne m}}
   \frac{\overline{g_n}g_m}{\sqrt{nm}}\,
   \kappa_p\!\left(T\log\frac mn\right).
 \tag{5}
\]
The exact pole form is
\[
 P_N(g)
 =\frac2T\operatorname{Re}\left[
    \mu_+(T)\mu_-(T)
    \left(\sum_{n\le N}\frac{g_n}{n}\right)
    \overline{\left(\sum_{n\le N}g_n\right)}
   \right].
 \tag{6}
\]

**Theorem.** A constant \(C_{p,c}\) exists, independent of \(N\)
and \(g\), such that
\[
 \boxed{\quad
 |\Gamma_{\rm off,N}(g)|
 \le \rho_{p,c}\mathcal E_N(g)+C_{p,c}h_N(g),
 \qquad
 \rho_{p,c}=\frac{16B_p}{9(c-\delta)}
 <\frac{16}{27}<1.
 \quad}
 \tag{7}
\]
For every \(\xi>0\), another constant \(C_{\xi,p,c}\) gives
\[
 |P_N(g)|\le \xi\mathcal E_N(g)
                  +C_{\xi,p,c}h_N(g).
 \tag{8}
\]
Writing \(Q_{L_N}\) for the **complete** compact Weil form, including
its digamma remainder, the consequence is
\[
 Q_{L_N}(f_g)\ge
 \frac{1-\rho_{p,c}}2\,\mathcal E_N(g)
 +V_N(g)-C'_{p,c}h_N(g).
 \tag{9}
\]
Thus the full critical packet compression is uniformly bounded
below as \(N\to\infty\). The constant in (9) is not shown to be
positive, and (9) does not give a sign for every packet vector.

## A dyadic graph Hardy estimate

The elementary estimate \(A(x)=\log x+O(1)\), proved in the
[divisor-matrix addendum](compact-weil-divisor-matrix-sharpness.md),
gives the finite interval mass
\[
 C_0=\sup_{x\ge1}\sum_{x<d\le2x}\frac{\Lambda(d)}d<\infty.
 \tag{10}
\]
For \(j\ge0\), put
\(S_j=\{m\le N:N2^{-j-1}<m\le N2^{-j}\}\).
For the unique shell containing \(m\), set \(\omega_m=2^{-j}\).
Then \(m/N\le\omega_m<2m/N\). If \(m\in S_j\) and
\(m=nd\) with \(d\ge2\), then \(n\le N2^{-j-1}\);
every edge descends below its upper endpoint's shell.

For \(0<\eta<1\),
\[
 |g_m-g_n|^2
 \ge (1-\eta)|g_m|^2-(\eta^{-1}-1)|g_n|^2.
 \tag{11}
\]
Multiply the edge in (2) by \(\omega_m\le1\) and sum (11).
The upper-endpoint coefficient is
\(\omega_m\log m/m\), by
\(\sum_{d\mid m}\Lambda(d)=\log m\).
For a fixed lower endpoint \(n\), the \(d\)'s landing in \(S_j\)
lie in an interval of ratio two and have mass at most \(C_0\).
Since \(\sum_{j\ge0}2^{-j}=2\), their total weighted penalty is at
most \(2C_0/n\). Consequently
\[
 \sum_{m\le N}\frac{m}{N}\frac{\log m}{m}|g_m|^2
 \le\frac{\mathcal E_N(g)}{1-\eta}
     +\frac{2C_0}{\eta}h_N(g).
 \tag{12}
\]

For any \(0<\varepsilon<1\), split the unweighted square sum at
\(n=N^{1-\varepsilon}\). Above that cutoff,
\(\log n\ge(1-\varepsilon)\log N\) and (12) applies.
Below it, \((\log N)n/N\le(\log N)N^{-\varepsilon}\).
Thus, with \(R=\log N\),
\[
 \frac{R}{N}\sum_{n\le N}|g_n|^2
 \le
 \frac{\mathcal E_N(g)}
      {(1-\eta)(1-\varepsilon)}
 +\left(\frac{2C_0}{\eta(1-\varepsilon)}
             +RN^{-\varepsilon}\right)h_N(g).
 \tag{13}
\]
The last coefficient is bounded uniformly in \(N\). In particular,
choosing \(\eta=\varepsilon=\frac14\) gives
\[
 \frac{R}{N}\sum_{n\le N}|g_n|^2
 \le\frac{16}{9}\mathcal E_N(g)+C_Hh_N(g)
 \quad\text{with an absolute }C_H.
 \tag{14}
\]
This estimate is for the actual prime-power graph. No prime
density or replacement graph enters it.

## The gamma and pole comparison

Equation (4) gives
\(|\kappa_p(s)|\le B_p/[2(|s|-\delta)]\).
For \(n\ne m\), the elementary inequalities
\[
 T\left|\log\frac mn\right|
 \ge\frac{cN|m-n|}{\max(m,n)},\qquad
 \frac{N|m-n|}{\max(m,n)}\ge1
 \tag{15}
\]
therefore imply
\[
 \frac{\left|\kappa_p(T\log(m/n))\right|}{\sqrt{nm}}
 \le\frac{B_p}{2(c-\delta)N}
       \frac{\sqrt{\max(m,n)/\min(m,n)}}{|m-n|}.
 \tag{16}
\]
Splitting the row at \(m=n/2\) and \(m=2n\) shows
\[
 \sum_{m<n}\frac{\sqrt{n/m}}{n-m}
 +\sum_{m>n}\frac{\sqrt{m/n}}{m-n}
 \le H_{n-1}+H_{N-n}+C\sqrt{N/n}
 \le2R+C\sqrt{N/n}.
 \tag{17}
\]
The first difference from its harmonic sum is \(O(1)\);
the far part of the second sum is \(O(\sqrt{N/n})\).
Using \(2|g_ng_m|\le|g_n|^2+|g_m|^2\) in (5), and then
\(1/\sqrt{nN}\le1/n\), yields
\[
 |\Gamma_{\rm off,N}(g)|
 \le\frac{B_p}{c-\delta}\frac{R}{N}
        \sum_{n\le N}|g_n|^2+C_{p,c}h_N(g).
 \tag{18}
\]
Inserting (14) proves (7).

Cauchy--Schwarz and (14) give
\[
 \left|\sum_{n\le N}\frac{g_n}{n}\right|
       \le\sqrt{H_Nh_N(g)},\qquad
 \left|\sum_{n\le N}g_n\right|
       \le\sqrt{N\sum|g_n|^2}
       \le\frac{N}{\sqrt R}
             \sqrt{\tfrac{16}{9}\mathcal E_N(g)+C_Hh_N(g)}.
 \tag{19}
\]
The factors \(\mu_\pm(T)\) are uniformly bounded by
\(e^{\delta/(2T)}\|p\|_1\), and \(H_N/R\) is bounded for
\(N\ge2\). Equation (6), followed by Young's inequality, now
proves (8).

Finally, let
\(q(t)=\operatorname{Re}\psi(1/4+it/2)-\log\pi
 -\log(|t|/(2\pi))\).
As in the critical crossover, \(q\in L^1(\mathbb R)\).
The Fourier integral for each packet-matrix entry of this
remainder is bounded by
\((2\pi T)^{-1}\|q\|_1\|\widehat p\|_\infty^2\).
Since \((\sum_{n\le N}|g_n|/\sqrt n)^2\le Nh_N(g)\),
its full quadratic is bounded by \(C_pN/T\,h_N(g)=C_p/c\,h_N(g)\).
The exact decomposition is
\[
 Q_{L_N}(f_g)
 =(\log c+g_p)h_N(g)+\mathcal E_N(g)+V_N(g)
  +\Gamma_{\rm off,N}(g)+P_N(g)+\mathcal R_{q,N}(g).
 \tag{20}
\]
Apply (7)--(8) with \(\xi=(1-\rho_{p,c})/2\) to obtain (9).

The estimate absorbs the logarithmically large additive interaction
into a strict fraction of the actual multiplicative graph energy.
Its constant norm term still leaves the coherent low-energy sector
unresolved. The fixed-character result computes a positive limit
there for each fixed finite family, but it supplies no uniform bound
over all \(N\)-dependent coefficients. This note neither proves
positivity of the full critical packet space nor RH.
