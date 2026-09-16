# Prime-coordinate phase law for the actual odd Weil remainder

This is an unconditional phase-averaged statement for a fixed family of compact pole-null tests. It gives no uniform signed bound on the odd Weil form and no RH result.

## Exact setting

Use the half-line odd normalization of the [actual continuum-prime decomposition](suzuki-odd-continuum-prime-square-and-arithmetic-remainder.md). For \(a>0\), the actual signed remainder is

\[
\mathcal R_a=P_a^{\rm odd}-P_{a,\mathrm{cont}}^{\rm odd}
=P_a^{\rm odd}+\mathcal G_a,
\qquad
\mathcal G_a=2|h_a\rangle\langle h_a|+\mathcal K_a,
\qquad h_a(x)=\sqrt2\sinh(x/2),
\]

on \(L^2(0,a)\). Here \(\mathcal K_a\) is the compression of the Dirichlet resolvent \((-\partial_x^2+1/4)^{-1}\), with kernel \(e^{-|x-y|/2}-e^{-(x+y)/2}\). The full odd form is \(\mathcal A_a+\mathcal K_a-\mathcal R_a\). All prime powers carry their actual coefficient \(\Lambda(n)/\sqrt n\). The localized prime operator is the sum of the shift/reflection operators \(T_{\log n,a}\) in the cited decomposition, with \(\log n<2a\).

Fix a real \(g\in C_c^\infty(0,a)\), and choose a real \(b\in C_c^\infty(0,a)\) such that \(\langle h_a,b\rangle=1\). For \(\kappa>0\) put

\[
c_\kappa=\int_0^a h_a(x)g(x)e^{i\kappa x}\,dx,
\qquad
u_\kappa(x)=g(x)e^{i\kappa x}-c_\kappa b(x).
\tag{1}
\]

Then \(\langle h_a,u_\kappa\rangle=0\) exactly. The odd extension \(u_\kappa/\sqrt2\) is compact smooth and has both Weil pole moments zero; its Fourier transform is Paley–Wiener. Integration by parts gives \(c_\kappa=O_{a,g,b,N}(\kappa^{-N})\) for every \(N\).

For \(\ell\ge0\), define the real autocorrelation

\[
C_g(\ell)=\int_0^{a-\ell}g(x+\ell)g(x)\,dx
\quad(0\le\ell<a),\qquad C_g(\ell)=0\quad(\ell\ge a).
\]

Set \(b_n=\Lambda(n)n^{-1/2}C_g(\log n)\) and

\[
Q_g(\kappa)=2\sum_{2\le n<e^a}b_n\cos(\kappa\log n).
\tag{2}
\]

**Phase decomposition.** For fixed \(a,g,b\),

\[
\boxed{\langle u_\kappa,\mathcal R_a u_\kappa\rangle
=Q_g(\kappa)+O_{a,g,b}(\kappa^{-2})\qquad(\kappa\to\infty).}
\tag{3}
\]

To prove (3), expand each \(T_{\ell,a}\). Its two same-side shifts contribute \(2C_g(\ell)\cos(\kappa\ell)\). Its reflected term is a finite Fourier integral of \(g(\ell-x)g(x)\) at frequency \(2\kappa\), so repeated integration by parts makes it \(O_N(\kappa^{-N})\). There are finitely many prime powers with \(\ell<2a\). The correction \(c_\kappa b\) changes their sum by \(O_N(\kappa^{-N})\). On the pole-null vector, \(\langle u_\kappa,\mathcal G_a u_\kappa\rangle=\langle u_\kappa,\mathcal K_a u_\kappa\rangle\). The sine spectral multiplier of \(\mathcal K_a\) is \((t^2+1/4)^{-1}\); the sine transform of \(g(x)e^{i\kappa x}\) consists of Schwartz packets centered at \(t=\pm\kappa\). Splitting at \(t=\kappa/2\) gives \(\langle u_\kappa,\mathcal K_a u_\kappa\rangle=O_{a,g,b}(\kappa^{-2})\).

## Exact prime-torus law

For each prime \(p<e^a\), put

\[
q_p(\theta)=2\sum_{r\ge1:\,p^r<e^a}
\frac{\log p}{p^{r/2}}C_g(r\log p)\cos(r\theta),
\qquad M_p=2\sum_{r\ge1:\,p^r<e^a}
\frac{\log p}{p^{r/2}}|C_g(r\log p)|.
\tag{4}
\]

Write \(\mathcal P_a=\{p:p<e^a\}\). Unique factorization makes \(\{\log p:p\in\mathcal P_a\}\) linearly independent over \(\mathbb Q\): an integer relation would say \(\prod p^{k_p}=1\). The continuous flow \(\kappa\mapsto(\kappa\log p\bmod2\pi)_p\) is therefore equidistributed on the prime torus. Equation (3) implies, for every continuous \(F:\mathbb R\to\mathbb C\),

\[
\boxed{\lim_{H\to\infty}\frac1H\int_0^H
F(\langle u_\kappa,\mathcal R_a u_\kappa\rangle)\,d\kappa
=\int_{\mathbb T^{|\mathcal P_a|}}
F\!\left(\sum_{p<e^a}q_p(\theta_p)\right)
\prod_{p<e^a}\frac{d\theta_p}{2\pi}.}
\tag{5}
\]

For \(F(x)=e^{zx}\), with real \(z\), this is the exact product law

\[
\lim_{H\to\infty}\frac1H\int_0^H
e^{z\langle u_\kappa,\mathcal R_a u_\kappa\rangle}\,d\kappa
=\prod_{p<e^a}\frac1{2\pi}\int_0^{2\pi}e^{zq_p(\theta)}\,d\theta.
\tag{6}
\]

The factors retain all correlations among powers of the same prime and separate distinct prime coordinates. In particular the first two phase moments are

\[
\lim_{H\to\infty}\frac1H\int_0^H
\langle u_\kappa,\mathcal R_a u_\kappa\rangle\,d\kappa=0,
\]

\[
\boxed{\lim_{H\to\infty}\frac1H\int_0^H
\langle u_\kappa,\mathcal R_a u_\kappa\rangle^2\,d\kappa
=2\sum_{2\le n<e^a}\frac{\Lambda(n)^2}{n}C_g(\log n)^2.}
\tag{7}
\]

Each \(q_p\) has mean zero and lies in \([-M_p,M_p]\). Convexity gives \(\mathbb E e^{zq_p}\le\cosh(zM_p)\le e^{z^2M_p^2/2}\); multiply these bounds over independent prime coordinates, apply the exponential Markov inequality, and use (6). For every \(t>0\) this gives

\[
\boxed{\limsup_{H\to\infty}\frac1H
\operatorname{meas}\{0\le\kappa\le H:
\langle u_\kappa,\mathcal R_a u_\kappa\rangle\ge t\}
\le\exp\!\left(-\frac{t^2}{2\sum_{p<e^a}M_p^2}\right).}
\tag{8}
\]

The same bound holds for the negative tail. If all \(M_p=0\), the remainder in (3) tends to zero and (8) is read with a zero right side for \(t>0\). Since \(|C_g(\ell)|\le\|g\|_2^2\), the PNT and partial summation yield the uniform large-window budget

\[
\sum_{p<e^a}M_p^2
\le4\|g\|_2^4\sum_{p<e^a}\frac{(\log p)^2}{(\sqrt p-1)^2}
=(2+o(1))a^2\|g\|_2^4
\quad\text{as an upper bound when }a\to\infty.
\tag{9}
\]

The last equality means that the explicit upper-bound sum is asymptotic to \(2a^2\|g\|_2^4\); the actual left side may be smaller. It shows a polynomial phase-averaged scale in a setting where the unsigned sum of actual prime-power coefficients grows exponentially in \(a\).

## Finite phase-window second moment

The variance has an elementary quantitative version that does not require torus equidistribution. Let \(N=\lfloor e^a\rfloor\ge2\) and \(H_{N-1}=\sum_{j=1}^{N-1}j^{-1}\). For every \(K\ge0,H>0\),

\[
\left|\frac1H\int_K^{K+H}Q_g(\kappa)^2\,d\kappa
-2\sum_{n\le N}b_n^2\right|
\le\frac{8NH_{N-1}+4N/\log2}{H}\sum_{n\le N}b_n^2.
\tag{10}
\]

Indeed, expand pairs of cosines. The diagonal oscillatory terms cost at most \(2(H\log2)^{-1}\sum b_n^2\). For \(m>n\), \(|\log(m/n)|\ge(m-n)/N\), while \(\log(mn)\ge2\log2\). The inequality \(2|b_nb_m|\le b_n^2+b_m^2\) gives \(\sum_{n<m}|b_nb_m|/(m-n)\le H_{N-1}\sum b_n^2\) and \(\sum_{n<m}|b_nb_m|\le(N/2)\sum b_n^2\). Combining these elementary estimates gives (10), with room in its stated constant. Equation (3) transfers it to the actual pole-null remainder on intervals with large \(K\), with an additional \(O_{a,g,b}(K^{-2})\) error in the mean square. Thus phase windows of length \(H\gg e^a a\) already exhibit the variance scale in (7).

## Scope

This is a signed upper-tail estimate for an actual family of pole-null Paley–Wiener tests, not a bound for every test. Kronecker density also permits rare near-alignment of many prime phases; the torus average gives no control of the supremum over \(\kappa\). The full all-test inequality \(\mathcal R_a\le\mathcal A_a+\mathcal K_a\) remains Weil positivity and hence RH-strength. The high-frequency regime is additionally helped by the archimedean multiplier's growth like \(\log\kappa\). No arithmetic improvement toward a uniform RH-scale remainder bound is claimed.

The operator formulas are from [Suzuki, *Weil's quadratic form via the screw function*](https://arxiv.org/html/2606.09096v1), with the exact continuum subtraction in the linked odd decomposition. The prime-phase independence in (5) is the elementary unique-factorization/Kronecker argument shown above; (10) is proved here directly. The PNT used in (9) is recorded in [DLMF §25.16(i)](https://dlmf.nist.gov/25.16.i).
