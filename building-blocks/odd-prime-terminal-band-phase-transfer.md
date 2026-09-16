# Terminal primes, graph edge mass, and phase loss in the odd Weil window

This note concerns the actual finite prime-shift operator in Suzuki's localized
Weil form. It proves that primes in a terminal logarithmic band carry the
leading operator norm, even though none of those primes has an admitted square
or pairwise product. For one boundary-modulated class it also identifies the
prime phases measured by the graph energy and gives a sharp square-root
comparison with the ordinary prime-phase comb. These are structural statements
about the prime term. They do not sign the full Weil form.

Put \(X=e^{2a}\), \(I_a=(-a,a)\), and zero-extend functions outside \(I_a\).
For \(S_\ell f(x)=f(x+\ell)\), write
\[
 P_a=\sum_{p^r<X}\frac{\log p}{p^{r/2}}
       (S_{r\log p}+S_{-r\log p}),
 \qquad \phi(x)=\cosh(x/2),
 \qquad r_a(x)=\frac{(P_a\phi)(x)}{\phi(x)}.
\tag{1}
\]
The [weighted Schur calculation](prime-shift-weighted-schur-window-asymptotic.md)
gives \(r_a=e^a+o(e^a)\) uniformly on \(I_a\), and
\(\|P_a\|=(1+o(1))e^a\). The prime contribution to the Weil form is
\(-\langle F,P_aF\rangle\), as in [Suzuki, Section 2.4](https://arxiv.org/html/2606.09096v2).

## The leading operator uses multiplicatively isolated primes

**Theorem 1.** Fix \(1/2<\theta<1\), and retain only ordinary primes
\(X^\theta<p<X\):
\[
 P_a^{\mathrm{top}}
 =\sum_{X^\theta<p<X}\frac{\log p}{\sqrt p}
       (S_{\log p}+S_{-\log p}).
\]
Then
\[
 \|P_a-P_a^{\mathrm{top}}\|=O_\theta(X^{\theta/2})=o(e^a),
 \qquad \|P_a^{\mathrm{top}}\|=(1+o(1))e^a,
 \qquad \sup\sigma(P_a^{\mathrm{top}}|_{\mathrm{odd}})
             =(1+o(1))e^a.
\tag{2}
\]
Every retained prime satisfies \(p^2>X\), and the product of any two
retained primes exceeds \(X\). On the odd half-interval \((0,a)\), every
retained shift is purely reflected:
\[
 (P_a^{\mathrm{top,odd}}u)(x)
 =-\sum_{X^\theta<p<X}
   \frac{\log p}{\sqrt p}
   \mathbf 1_{\log p-a<x<a}\,u(\log p-x).
\tag{3}
\]

**Proof.** Each zero-extended shift has norm at most one. The total weight
of every discarded power is bounded by
\[
 \sum_{p\le X^\theta}\sum_{r\ge1}
       \frac{\log p}{p^{r/2}}
 \le \frac{1}{1-2^{-1/2}}
       \sum_{p\le X^\theta}\frac{\log p}{\sqrt p}
 =O(X^{\theta/2}),
\]
where the last estimate follows by partial summation from Chebyshev's
\(\sum_{p\le y}\log p=O(y)\). The triangle inequality proves the first
bound in (2), and the full operator norm asymptotic proves the second.
The [finite-shift parity recurrence theorem](prime-shift-parity-spectrum-recurrence-no-go.md)
says that a positive-coefficient finite shift sum has the same upper spectral
edge on the odd and full spaces. Applying it to \(P_a^{\mathrm{top}}\) gives
the third bound. Since \(\log p>a\) for every retained prime, its two
same-side half-interval shifts vanish; the odd reflection in the
[half-line shift formula](suzuki-odd-continuum-prime-square-and-arithmetic-remainder.md)
gives (3). In particular, no power \(p^r\), \(r\ge2\), has been omitted
from a retained base: \(p^2>X\) there.
The product claims follow from \(2\theta>1\). \(\square\)

More sharply, if \(R(a)\to\infty\) and \(0<R(a)<a\), the band
\(Xe^{-R(a)}<p<X\) alone still has norm and odd upper spectral edge
\((1+o(1))e^a\). Indeed the discarded weight is
\(O(\sqrt{Xe^{-R(a)}})=o(e^a)\), while every retained prime exceeds
\(\sqrt X\). This uses an arbitrarily slowly widening band in the
coordinate \(2a-\log p\).

## Exact graph edge weights

For \(\ell_n=\log n\), \(w_n=\Lambda(n)/\sqrt n\), define the edge mass
of the positive gauge by
\[
 E_{a,n}:=w_n\int_{-a}^{a-\ell_n}
             \phi(x)\phi(x+\ell_n)\,dx,
 \qquad T_a:=\sum_{n<X}E_{a,n}.
\tag{4}
\]
Only prime powers have nonzero weights. If \(c_n=\log(X/n)\), direct
integration gives
\[
 \begin{aligned}
 E_{a,n}
 &=\frac{\Lambda(n)}{\sqrt n}
   \left[\sinh(c_n/2)+\frac{c_n}{2}
                   \cosh(\ell_n/2)\right]\\
 &=\frac{\Lambda(n)c_n}{4}\left(1+\frac1n\right)
   +\frac{\Lambda(n)}2\left(\frac{e^a}{n}-e^{-a}\right).
 \end{aligned}
\tag{5}
\]
Thus \(T_a=\frac12\langle\phi,P_a\phi\rangle\). The prime number
theorem and partial summation give
\[
 T_a=\frac X4+o(X),
 \qquad
 \frac1{T_a}\sum_{\substack{n<X\\0<c_n<R}}E_{a,n}
 \longrightarrow \int_0^R c e^{-c}\,dc
 =1-(1+R)e^{-R}
\tag{6}
\]
for every fixed \(R>0\). In particular, the normalized edge-mass
distribution of \(c_n\) converges to the density \(c e^{-c}\).

To verify (6) directly, the first term in (5) contributes
\(\frac14\sum_{n<X}\Lambda(n)\log(X/n)
=\frac14\int_1^X\psi(y)dy/y=X/4+o(X)\).
The other terms in (5) total \(O(ae^a+a^2)=o(X)\).
On the fixed band \(Xe^{-R}<n<X\), partial summation with
\(\psi(y)\sim y\) gives the displayed integral. Proper powers have
\(o(X)\) total mass there: (5) gives
\(E_{a,n}\le\Lambda(n)[a+e^a/(2n)]\), while
\(\sum_{p^r<X,r\ge2}\Lambda(p^r)=O(ae^a)\) and
\(\sum_{p,r\ge2}\Lambda(p^r)/p^r=O(1)\).
Thus the limiting density is carried by
ordinary terminal primes.

The law (6) uses the *edge* weights. The ordinary comb weights have a
different limit. Set
\[
 W_a=\sum_{n<X}w_n=(2+o(1))e^a,
 \qquad Q_a(t)=\sum_{n<X}w_n\cos(t\log n).
\tag{7}
\]
Their normalized \(c_n\) distribution has density
\(\frac12e^{-c/2}\). It assigns order \(R\) mass to \(0<c<R\) for
small \(R\), while the graph edge law assigns order \(R^2\).

## A sharp comparison for boundary-modulated tests

For \(F_{a,t}(x)=\phi(x)\sin(tx)\mathbf1_{I_a}(x)\), let
\[
 S_a[F]=\int_{I_a}r_a(x)|F(x)|^2dx,
 \qquad D_a[F]=S_a[F]-\langle F,P_aF\rangle.
\]
The exact weighted graph identity makes \(D_a\ge0\). Put
\[
 \delta_a(t)=\frac1{T_a}\sum_{n<X}E_{a,n}
                \bigl(1-\cos(t\log n)\bigr),
 \qquad q_a(t)=1-\frac{Q_a(t)}{W_a}.
\tag{8}
\]

**Theorem 2.** There is an absolute constant \(C\) and a quantity
\(\rho_a\to0\) such that, uniformly for all \(a\) large and all
choices of phases in (8),
\[
 q_a(t)\le C\sqrt{\delta_a(t)}+\rho_a.
\tag{9}
\]
The same bound holds for any array \(z_n\in[0,2]\) in place of
\(1-\cos(t\log n)\). Uniformly for \(t\ge1\),
\[
 S_a[F_{a,t}]=T_a+O(X/t),
 \qquad
 D_a[F_{a,t}]
 =\sum_{n<X}E_{a,n}\bigl(1-\cos(t\log n)\bigr)+O(X/t).
\tag{10}
\]
Consequently, whenever \(a\to\infty\) and \(t=t_a\to\infty\),
\[
 1-\frac{Q_a(t_a)}{W_a}
 \le C\sqrt{\frac{D_a[F_{a,t_a}]}{S_a[F_{a,t_a}]}
                  +C_0/t_a}+o(1)
\tag{11}
\]
for an absolute \(C_0\). The exponent \(1/2\) in (9) cannot be
increased uniformly.

**Proof.** Let \(\mu_a(n)=E_{a,n}/T_a\) and
\(\nu_a(n)=w_n/W_a\). Write
\(\delta=\sum\mu_a(n)z_n\), \(q=\sum\nu_a(n)z_n\).
For \(\delta\ge1/25\), the bound follows from \(q\le2\) after
enlarging \(C\). Otherwise set
\(h=\max(\sqrt\delta,1/a)\) and \(B=2\log(1/h)\).
The prime number theorem applied uniformly above \(X/a^2\) gives
\[
 \nu_a(c_n<h)\le h/2+o(1),
 \qquad \nu_a(c_n>B)\le h+o(1),
\tag{12}
\]
where the errors are independent of \(z_n\) and \(\delta\).
Indeed, for \(W(y)=\sum_{n<y}\Lambda(n)/\sqrt n\), the supremum of
\(|W(y)/(2\sqrt y)-1|\) over \(y\ge X/a^2\) tends to zero.
On \(h\le c_n\le B\), (5) or its defining integral gives
\[
 \frac{E_{a,n}}{w_n}
 \ge\frac{c_n}{4}e^{a-c_n/2},
 \qquad
 \frac{\nu_a(n)}{\mu_a(n)}
 =\frac{T_a}{W_a}\frac{w_n}{E_{a,n}}
 \le (1+o(1))\frac{e^{c_n/2}}{2c_n}
 \le\frac1h
\tag{13}
\]
for all sufficiently large \(a\). The last step uses that
\(e^{c/2}/c\) decreases to \(c=2\) and then increases; at the two
endpoints \(h\) and \(B\) its displayed bound is at most \(1/h\).
Splitting the \(q\) sum into these three regions, using \(z_n\le2\),
gives \(q\le3h+\delta/h+o(1)\le4\sqrt\delta+4/a+o(1)\).
This proves (9) with a larger absolute \(C\).

For (10), expand the sine squares in the row and use
\(|\sin(tx)-\sin(t(x+\ell_n))|^2
=(1-\cos(t\ell_n))[1+\cos(2tx+t\ell_n)]\)
in the graph. Integration by parts against
\(\phi(x)\phi(x+\ell_n)
=\frac12[\cosh(x+\ell_n/2)+\cosh(\ell_n/2)]\)
costs at most \(O(1/t)\) times the endpoint height on each edge.
After multiplication by \(w_n\), the total is
\(O(t^{-1}\sum_{n<X}\Lambda(n)(1+e^a/n))=O(X/t)\).
Since \(T_a\sim X/4\), (10) and (9) give (11).

For sharpness, fix \(\eta>0\) and prescribe phase \(\pi\) on each
ordinary prime \(Xe^{-\eta}<p<X\), and phase zero on every other
admitted prime. The logarithms of the finitely many admitted primes
are rationally independent, so Kronecker's theorem gives arbitrarily
large \(t\) that approximate these targets. Prime powers outside the
terminal band also approach phase zero. Take such \(t=t_a\) high
enough for (10). Equations (6) and (7) then yield
\[
 \delta_a(t_a)\longrightarrow
       2[1-(1+\eta)e^{-\eta}]\sim\eta^2,
 \qquad
 q_a(t_a)\longrightarrow
       2(1-e^{-\eta/2})\sim\eta
 \quad(\eta\downarrow0).
\tag{14}
\]
Thus no bound \(q\le C\delta^\alpha+o(1)\), uniform in the window,
can have \(\alpha>1/2\). For example, at \(\eta=0.1\) the limiting
graph phase loss is about \(0.00936\), while
\(Q_a(t_a)/W_a\to 2e^{-0.05}-1\approx0.90246\). \(\square\)

There is also direct phase freedom below the terminal band. Fix
\(1/2<\theta<1\). Prescribe arbitrary phases for **every** prime
\(p\le X^\theta\) and phase zero for every larger admitted prime.
Kronecker's theorem supplies arbitrarily high carriers \(t_a\) that
approximate these targets. If the phase error at the larger primes is
\(\varepsilon_a=o(1)\), then the graph identity gives
\(D_{\mathrm{top}}[F_{a,t_a}]\le\varepsilon_a^2T_a\) and
\(D_{\mathrm{low}}[F_{a,t_a}]
\le2\|P_{\mathrm{low}}\|\|\phi\|_2^2\).
Also \(\|F_{a,t_a}\|_2^2=(1/2+O(1/t_a))\|\phi\|_2^2\).
Using (2) and
\(S_a[\phi\sin(t_a\cdot)]=(1+o(1))e^a
\|\phi\sin(t_a\cdot)\|_2^2\) give
\[
 \frac{D_a[F_{a,t_a}]}{S_a[F_{a,t_a}]}
 \le o(1)+O(X^{(\theta-1)/2})=o(1).
\tag{15}
\]
The estimate for the freely phased primes is specific to these gauge
trials: \(D_{\mathrm{low}}[F]\le2S_{\mathrm{low}}[F]
\le2\langle\phi,P_{\mathrm{low}}\phi\rangle
\le2\|P_{\mathrm{low}}\|\|\phi\|_2^2\).
It is **not** an operator bound on the low-prime graph form.
Taking phase \(\pi\) at \(p=2\), or at every prime
\(p\le X^\theta\), shows that normalized full-graph near-nullity does
not imply coordinatewise return of even a single small prime phase.

For each \(a\), the carriers in (14) and (15) may be chosen as high as
needed. Use even smooth cutoffs that rise monotonically from zero to one
on \(1\le|x|\le2\), equal one on
\(2\le|x|\le a-2\varepsilon_a\), and taper monotonically to zero
by \(|x|=a-\varepsilon_a\), where \(\varepsilon_a\downarrow0\).
A vanishing odd pole-moment
correction then gives \(C_c^\infty(0,a)\) half-line tests with exact
pole-nullity and the same limiting graph ratios. The central cutoff
loses \(O(e^{-a})\) of the normalized \(L^2\) mass, and the endpoint
cutoff loses \(O(\varepsilon_a)\); the pole moment is
\(O(e^{a/2}/t_a)\) after normalization by integration by parts: the
product of the cutoff with \(\sinh x\) has variation \(O(e^a)\),
independent of \(\varepsilon_a\).
A unit-moment bump near
\(a\) has norm \(O(e^{-a/2})\). The graph form has norm \(O(e^a)\),
so these changes cost \(o(e^a)\) in its quadratic value.

No upper bound on these carriers is asserted. Their logarithmic
archimedean energy may exceed the \(e^a\) prime row by a wide margin.
For these gauge trials the normalized logarithmic energy is
\(H_a[\sqrt2F_{a,t}|_{(0,a)}]/\|F_{a,t}\|_2^2=\log t+O(1)\)
uniformly for large \(t\), by the same Fourier-envelope calculation as in the
[finite-coordinate note](odd-prime-finite-coordinate-schur-barrier.md).
The operator result and the phase examples identify a missing step in a
graph-based proof of odd Weil positivity: one needs a quantitative
all-prime estimate at the logarithmic frequency scale that controls
the terminal-prime edge law while retaining the exact archimedean and
pole terms. Neither the multiplicative rigidity of lower primes nor a
pointwise requirement that every prime phase nearly return supplies
that estimate.
