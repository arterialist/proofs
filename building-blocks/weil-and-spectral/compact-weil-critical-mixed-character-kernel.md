# The mixed prime-phase kernel at the critical Weil packet scale

The [critical second-order tests](compact-weil-critical-packet-second-order-tests.md)
give a positive complete-Weil residual for each fixed finite-prime
multiplicative phase. Positivity on individual vectors does not
settle their linear combinations. Here the full mixed kernel has a
limit that is a positive \(L^2\) form, a prime-shift Dirichlet
energy, and a positive rank-one moment. This is a theorem for each
fixed finite collection of phase characters. The convergence is not
uniform when the prime set, phases, or number of characters vary
with \(N\).

Keep \(L_N=\frac12\log(N+1)\), \(T=cN\) with fixed \(c>4\), and a real
norm-one packet profile \(p\in C_c^\infty(-\delta,0)\),
\(0<\delta<1\), as in the [critical crossover](compact-weil-critical-packet-crossover.md).
Write \(R=\log N\), \(H_N=\sum_{n\le N}1/n\), and
\[
 a_{p,c}=\log c+\gamma+g_p>0,\qquad
 \mu_p=\int p,\qquad
 g_p=\frac1{2\pi}\int
       \log\frac{|u|}{2\pi}|\widehat p(u)|^2du.
 \tag{1}
\]
The positivity follows from
\(g_p\ge\log(1/(2\delta))-1\), \(c>4\), and
\(\gamma>1-\log2\).

Fix a finite set \(S\) of primes. For phase vectors
\(z=(z_p)_{p\in S}\), \(|z_p|=1\), define
\[
 \chi_z(n)=\prod_{p\in S}z_p^{v_p(n)},\qquad
 F_{N,z}=\frac1{\sqrt{H_N}}
       \sum_{n=1}^N\frac{\chi_z(n)}{\sqrt n}p_n.
 \tag{2}
\]
Let \(\Omega_S=\mathbb Z_{\ge0}^S\) carry the product probability
law \(\pi_S\) with
\(\pi_p(v)=(1-p^{-1})p^{-v}\).
The same character on this valuation space is
\(\chi_z(v)=\prod_{p\in S}z_p^{v_p}\).
For \(j\ge1\), let \(\tau_{p,j}v=v+j e_p\), and define
\[
 \begin{aligned}
 \langle F,G\rangle_\pi
   &=\mathbb E_{\pi_S}[\overline F G],\\
 \mathcal E_S(F,G)
   &=\sum_{p\in S}\sum_{j\ge1}\frac{\log p}{p^j}
      \mathbb E_{\pi_S}
      [\overline{F(\tau_{p,j}v)-F(v)}
       (G(\tau_{p,j}v)-G(v))].
 \end{aligned}
 \tag{3}
\]
The series is absolutely convergent on finite linear combinations
of characters and \(\mathcal E_S(F,F)\ge0\).

**Theorem.** For any two fixed phase vectors \(z,w\),
the polarization of the complete compact Weil form satisfies
\[
 \boxed{\quad
 \lim_{N\to\infty}Q_{L_N}(F_{N,z},F_{N,w})
 =a_{p,c}\langle\chi_z,\chi_w\rangle_\pi
  +\mathcal E_S(\chi_z,\chi_w)
  +\frac{\mu_p^2}{c}\,
       \overline{\mathbb E_\pi\chi_z}\,
       \mathbb E_\pi\chi_w.
 \quad}
 \tag{4}
\]
Here \(Q(f,g)\) is conjugate-linear in \(f\), linear in \(g\), and
\(Q(f,f)=Q(f)\). Consequently, for every fixed finite linear
combination \(F=\sum_{\ell=1}^r b_\ell\chi_{z^{(\ell)}}\),
\[
 \lim_{N\to\infty}
 Q_{L_N}\!\left(\sum_{\ell=1}^r b_\ell F_{N,z^{(\ell)}}\right)
 =a_{p,c}\|F\|_{L^2(\pi_S)}^2
  +\mathcal E_S(F,F)
  +\frac{\mu_p^2}{c}|\mathbb E_\pi F|^2
 \ge a_{p,c}\|F\|_{L^2(\pi_S)}^2.
 \tag{5}
\]
After duplicate characters are removed, the corresponding finite
Gram matrix is positive definite: distinct phase characters are
linearly independent on the full-support space \(\Omega_S\), by
successive one-variable Vandermonde arguments. Thus for each fixed finite
character family, (5) gives a positive lower bound on its whole
span for all sufficiently large \(N\). The required \(N\) can
depend on that family.

## Mixed arithmetic block

Write \(\theta=\overline{\chi_z}\chi_w\) and
\[
 \kappa_\theta
 =\mathbb E_\pi[\overline{\chi_z}\chi_w]
 =\prod_{p\in S}
     \frac{1-p^{-1}}{1-\overline z_p w_p p^{-1}}.
 \tag{6}
\]
For any phase vector \(u\), put
\[
 L_u=\sum_{p\in S}\sum_{j\ge1}
       \frac{\log p}{p^j}(u_p^j-1).
 \tag{7}
\]
The local factor
\(P_\theta(s)=\prod_{p\in S}
(1-p^{-s})/(1-\overline z_p w_p p^{-s})\)
has \(P_\theta(1)=\kappa_\theta\) and
\(P_\theta'(1)=-\kappa_\theta L_\theta\).

The exact mixed prime numerator is
\[
 H_N\langle F_{N,z},K_{L_N}F_{N,w}\rangle
 =\sum_{\substack{n\ge1,\ d\ge2\\nd\le N}}
    \frac{\Lambda(d)}{nd}\,
    \theta(n)\,[\chi_w(d)+\overline{\chi_z(d)}].
 \tag{8}
\]
Let \(g_\theta\) be the finite-prime Dirichlet-convolution
coefficient defined by \(\theta=\mathbf1*g_\theta\).
All logarithmic moments
\(\sum_m|g_\theta(m)|(\log m)^k/m\) are finite.
The baseline part of (8), replacing its bracket by \(2\), is
\[
 \begin{aligned}
 2\sum_{m\le N}\frac{(\theta*\Lambda)(m)}m
 &=2\sum_{r\le N}\frac{g_\theta(r)}r
      \sum_{m\le N/r}\frac{\log m}{m}\\
 &=\kappa_\theta R^2
      +2P_\theta'(1)R+O(1).
 \end{aligned}
 \tag{9}
\]
Here \(\mathbf1*\Lambda=\log\) and
\(\sum_{m\le x}(\log m)/m
=\frac12(\log x)^2+O(1)\).
The bracket correction in (8) is supported only on powers of
primes in \(S\). Using
\[
 \sum_{n\le x}\frac{\theta(n)}n
 =\kappa_\theta(\log x+\gamma)
   +P_\theta'(1)+o(1)
 \tag{10}
\]
and the absolutely convergent local series (7), it contributes
\(\kappa_\theta(L_w+L_{\overline z})R+O(1)\). This use of
(10) with a growing prime power is justified by the uniform estimate
\(\sum_{n\le x}\theta(n)/n=\kappa_\theta\log x+O(1)\)
for \(x\ge1\): the resulting error is summable against
\(\sum_{p\in S,j\ge1}(\log p)/p^j\), and the term
\(\log d=j\log p\) is summable against the same weights.
Divide by \(H_N=R+\gamma+o(1)\) to obtain
\[
 \langle F_{N,z},K_{L_N}F_{N,w}\rangle
 =\kappa_\theta R
  +2P_\theta'(1)
  +\kappa_\theta(L_w+L_{\overline z}-\gamma)
  +o(1).
 \tag{11}
\]

## Mixed gamma and pole blocks

The packet Gram entry is
\[
 \langle F_{N,z},F_{N,w}\rangle
 =\frac1{H_N}\sum_{n\le N}\frac{\theta(n)}n
 =\kappa_\theta+\frac{P_\theta'(1)}R+o(R^{-1}).
 \tag{12}
\]
The local logarithmic gamma term is
\((\log T+g_p)\) times this Gram entry.
The \(L^1\) digamma remainder has mixed matrix entry \(o(1)\).
The off-center logarithmic kernel is
\(-\frac12\iint p(v)p(u)/|s+v-u|\,dv\,du\), as in the
critical crossover. Its profile-denominator error is \(o(1)\)
after division by \(H_N\).

For two fixed finite-prime phases, the remaining neighboring-label
correlation has the limit
\[
 \frac1{N R}\sum_{n<m\le N}
   \frac{\overline{\chi_z(n)}\chi_w(m)}{m-n}
 \longrightarrow
 \overline{\kappa_z}\kappa_w,
 \qquad
 \kappa_z=\mathbb E_\pi\chi_z.
 \tag{13}
\]
To prove (13), truncate each \(p\)-adic valuation at \(K\).
The resulting two sequences are periodic with a common period
\(q_K=\prod_{p\in S}p^K\). For fixed \(K\), the lag correlation
is periodic in \(m-n\); its mean over one period is the product
of the two periodic means. Summation with weight \(1/(m-n)\)
then proves (13) for the truncated sequences. The upper-triangular
matrix \(\mathbf1_{\{m>n\}}/(m-n)\) has row and column sums
\(O(\log N)\). Replacing a truncated phase by the original one
therefore changes the normalized quadratic by at most
\(O((\sum_{p\in S}p^{-K})^{1/2})\). Let \(N\to\infty\)
before \(K\to\infty\). Swapping \(z,w\) and conjugating this
argument gives the same product for the opposite orientation.
The absolute replacement of
\(1/(\sqrt{nm}\log(m/n))\) by \(1/(m-n)\) costs only
\(O(N)\), as proved in the critical crossover. Both shift
orientations now give
\[
 \Gamma_{\mathrm{off}}(z,w)
 \longrightarrow
 -\frac{\mu_p^2}{c}\overline{\kappa_z}\kappa_w.
 \tag{14}
\]
The Cesàro and harmonic means of each phase tend respectively to
\(\kappa_z N\) and \(\kappa_z R\). In the two exact pole moments
this gives
\[
 P_{\mathrm{pole}}(z,w)
 \longrightarrow
 \frac{2\mu_p^2}{c}\overline{\kappa_z}\kappa_w.
 \tag{15}
\]

Combine (11), (12), (14), and (15). The resulting mixed limit is
\[
 \kappa_\theta
   (a_{p,c}+L_\theta-L_w-L_{\overline z})
 +\frac{\mu_p^2}{c}\overline{\kappa_z}\kappa_w.
 \tag{16}
\]
On characters, the middle term equals
\[
 \begin{aligned}
 \mathcal E_S(\chi_z,\chi_w)
 &=\kappa_\theta
   \sum_{p\in S}\sum_{j\ge1}
     \frac{\log p}{p^j}
     (\overline z_p^{\,j}-1)(w_p^j-1)\\
 &=\kappa_\theta
   (L_\theta-L_w-L_{\overline z}).
 \end{aligned}
 \tag{17}
\]
This proves (4)--(5).

## A two-character check and the remaining limit

For \(S=\{2\}\), let \(\chi_0=1\) and
\(\chi_1(n)=(-1)^{v_2(n)}\). Their valuation-space Gram matrix is
\(\left(\begin{smallmatrix}1&1/3\\1/3&1\end{smallmatrix}\right)\),
and \(\mathcal E_S(\chi_1,\chi_1)=(8/3)\log2\), with all
Dirichlet cross terms involving \(\chi_0\) equal to zero.
Writing \(a=a_{p,c}\), the limiting complete-Weil matrix is
\[
 \begin{pmatrix}
 a+\mu_p^2/c&
 a/3+\mu_p^2/(3c)\\
 a/3+\mu_p^2/(3c)&
 a+(8/3)\log2+\mu_p^2/(9c)
 \end{pmatrix}.
 \tag{18}
\]
It is positive definite by (5); in particular, the
Gram-orthogonal difference
\(\chi_1-\chi_0/3\) has limiting Weil value
\(8a/9+(8/3)\log2>0\).

At any fixed \(N\), characters using enough prime coordinates can
separate the exponent vectors of labels \(n\le N\), and linear
combinations can represent arbitrary packet coefficients. The
limit above does not pass through that \(N\)-dependent spanning
operation. A mixed kernel bound uniform in growing prime sets,
phase meshes, and combinations would be required to conclude
positivity on the entire critical packet space. Even that would
not cover all compactly supported Weil tests or prove RH.
