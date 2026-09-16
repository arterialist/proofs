# Two-prime rigidity and logarithmic cost for the odd Weil graph

This is a fixed-window uncertainty statement for the **actual** odd Weil
operator, with every admitted prime power retained. It also gives an exact
pole-null counterexample to extending the statement to every window. The
compactness argument supplies no effective constant uniform in the window,
and the result makes no assertion of positivity for arbitrary tests.

Let \(I_a=(-a,a)\), \(\phi(x)=\cosh(x/2)\), and let \(P_a\) be the
zero-extended prime-shift operator in [the weighted Schur identity](prime-shift-weighted-schur-window-asymptotic.md):
\[
(P_aF)(x)=\sum_{\ell_n<2a}w_n\bigl(F(x+\ell_n)+F(x-\ell_n)\bigr),
\qquad \ell_n=\log n,\quad w_n=\frac{\Lambda(n)}{\sqrt n}.
\]
Write \(r_a=P_a\phi/\phi\), \(C_a=\mathop{\rm ess\,sup}r_a\), and
\[
 S_a[F]=\int_{I_a}r_a(x)|F(x)|^2dx,
 \qquad D_a[F]=S_a[F]-\langle F,P_aF\rangle.
\tag{1}
\]
The exact graph identity is
\[
D_a[F]=\sum_{\ell_n<2a}w_n\int_{-a}^{a-\ell_n}
 \phi(x)\phi(x+\ell_n)
 \left|\frac{F(x)}{\phi(x)}-
             \frac{F(x+\ell_n)}{\phi(x+\ell_n)}\right|^2dx.
\tag{2}
\]
In particular, \(0\le D_a[F]\le 2C_a\|F\|_2^2\), and both \(D_a\)
and \(S_a\) are continuous quadratic forms on \(L^2(I_a)\).

For odd \(F\), identify \(u(x)=\sqrt2 F(x)\) on \((0,a)\), so
\(\|u\|_2=\|F\|_2\). Use the positive logarithmic form from
[the normalized first-prime analysis](first-prime-log-normalized-remainder-schatten-transition.md):
\[
\begin{split}
 H_a[u]&=\frac2\pi\int_0^\infty h(t)
       \left|\int_0^a u(x)\sin(tx)dx\right|^2dt,\\
 h(t)&=1+b(t)-b(0),\qquad
 b(t)=\Re\psi(5/4+it/2)-\log\pi,\qquad c=1-b(0).
\end{split}
\tag{3}
\]
Here \(H_a\ge I\), its form-domain unit ball is relatively compact in
\(L^2(0,a)\), and \(h(t)=\log(1+t)+O(1)\) at high frequency. In fact
\(h(t)\ge1+\tfrac12\log(1+4t^2/25)\). The full odd Weil form and the
continuous-prime square satisfy the exact identity
\[
\boxed{\mathcal W_a[u]
 =H_a[u]-c\|u\|_2^2-S_a[F]+D_a[F]-\mathcal G_a[u],
 \qquad \mathcal G_a\ge0,
 \quad\operatorname{Tr}\mathcal G_a=e^a-1-a.}
\tag{4}
\]
To check the signs, the odd prime term is
\(-\langle F,P_aF\rangle=-S_a[F]+D_a[F]\). In the
[continuum-prime decomposition](suzuki-odd-continuum-prime-square-and-arithmetic-remainder.md),
\(H_a=\mathcal A_a+\mathcal K_a+cI\),
\(\mathcal R_a=P_a^{\rm odd}+\mathcal G_a\), and
\(\mathcal W_a=\mathcal A_a+\mathcal K_a-\mathcal R_a\), which gives (4).
This retains the original pole rank one in \(\mathcal G_a\); no pole term
has been dropped.

**Theorem (a fixed-window graph/logarithmic uncertainty).** Put
\(a_*=(\log2+\log3)/2=\tfrac12\log6\). For each \(a\ge a_*\) and
each finite \(M\), the number
\[
 d_a(M):=\inf\{D_a[F]:F\text{ odd},\ \|F\|_2=1,
                          \ H_a[\sqrt2F|_{(0,a)}]\le M\}
\tag{5}
\]
is strictly positive whenever the constraint set is nonempty. Also
\[
\frac{\log2}{2}\|F\|_2^2\le S_a[F]\le C_a\|F\|_2^2.
\tag{6}
\]
Consequently, if \(F_j\ne0\) are odd form-domain tests in this fixed
window and \(D_a[F_j]/S_a[F_j]\to0\), then
\[
\frac{H_a[\sqrt2F_j|_{(0,a)}]}{\|F_j\|_2^2}\longrightarrow\infty.
\tag{7}
\]
In particular, there exists \(\varepsilon_a>0\) such that every odd
test satisfying \(D_a[F]\le\varepsilon_aS_a[F]\) has
\(\mathcal W_a[\sqrt2F|_{(0,a)}]\ge\|F\|_2^2\). This is a signed
positivity statement on an explicit *type* of near-invariant cone; its
threshold \(\varepsilon_a\) is not computed.

**Proof.** If \(D_a[F]=0\), every nonnegative summand in (2) vanishes.
Thus \(g=F/\phi\in L^2(I_a)\) is invariant under translation by
\(L=\log2\) wherever both points remain in \(I_a\), and also under
\(M_3=\log3\). Choose \(J=(-a,-a+L)\). The first invariance identifies
\(g\) almost everywhere on \(I_a\) with the periodic extension of
\(g|_J\) of period \(L\): moving by integral multiples of \(L\)
between any point and \(J\) stays in \(I_a\). As
\(2a\ge L+M_3\), the whole open cell \(J\) lies in
\((-a,a-M_3)\), up to its endpoints. The second invariance therefore
says that this periodic function is also invariant under rotation by
\(M_3\) on the circle of length \(L\). The ratio \(M_3/L\) is
irrational, since a rational ratio would give \(3^q=2^p\) for some
positive integers \(p,q\). Its Fourier coefficients except the
constant coefficient vanish. Hence \(g\) is constant almost
everywhere, and the oddness of \(g\) forces \(F=0\).
The same interval-length and irrational-rotation geometry appears for
continuous scalar phases in [the prime-gauge obstruction](weil-prime-gauge-frustration.md);
here it is applied to an almost-everywhere \(L^2\) graph nullspace.

For \(a\ge a_*>L\), every \(x\in I_a\) has at least one of
\(x+L,x-L\) in \(I_a\). Since
\(\phi(x\pm L)/\phi(x)\ge e^{-L/2}=1/\sqrt2\), the contribution
of \(n=2\) alone to \(r_a(x)\) is at least
\(w_2/\sqrt2=L/2\), proving (6). If (5) vanished, compactness of
the \(H_a\)-sublevel ball would give an \(L^2\)-convergent subsequence
of normalized odd tests with a nonzero limit \(F\). Continuity of
\(D_a\) would give \(D_a[F]=0\), contradicting the graph rigidity.
This proves (5) and (7), since \(D_a[F]\le\varepsilon S_a[F]\le
\varepsilon C_a\|F\|_2^2\).

For the signed consequence, put
\(T_a=e^a-1-a\) and \(M_a=c+C_a+T_a+1\). Equation (5) supplies
\(\varepsilon_a>0\) so small that
\(D_a[F]\le\varepsilon_aS_a[F]\) is incompatible with
\(H_a[u]\le M_a\|u\|_2^2\). If the latter sublevel is empty, any
sufficiently small positive \(\varepsilon_a\) works. The positive
trace-class operator \(\mathcal G_a\) satisfies
\(\mathcal G_a[u]\le T_a\|u\|_2^2\). Thus (4) and
\(S_a[F]\le C_a\|u\|_2^2\) give
\(\mathcal W_a[u]\ge(H_a[u]-(c+C_a+T_a)\|u\|_2^2)+D_a[F]
>\|u\|_2^2\) on this cone. \(\square\)

Near-invariant tests do exist at every such window. This gives a useful
upper limit on what (7) can say. Let \(N_a\) count the primes
\(p<e^{2a}\), and let \(K_a=\lceil2a/L\rceil\). Dirichlet's
simultaneous approximation, applied to \(\log p/L\) for those primes
\(p\ne2\), gives, for each integer \(Q\ge2\), an integer
\(1\le q\le Q^{N_a-1}\) with
\(\|q\log p/L\|_{\mathbb R/\mathbb Z}\le1/Q\) for all of them.
Set \(\kappa=2\pi q/L\) and
\(F_\kappa(x)=\phi(x)\sin(\kappa x)\mathbf1_{I_a}(x)\).
Every prime-power phase then has distance at most \(2\pi K_a/Q\)
from a multiple of \(2\pi\). If
\(S_a[\phi]=\int_{I_a}r_a\phi^2\), (2) gives
\[
D_a[F_\kappa]\le\frac12(2\pi K_a/Q)^2S_a[\phi],
\qquad S_a[F_\kappa]\longrightarrow\frac12S_a[\phi].
\tag{8}
\]
The limit holds as \(Q\to\infty\): the selected \(q\) must tend to
infinity, since \(\log3/L\) is irrational. The bounded-variation
cutoff \(\phi\mathbf1_{I_a}\) has Fourier decay \(O_a(1/|t|)\), so
\(F_\kappa\) belongs to the logarithmic form domain and elementary
modulation of its two separated Fourier packets gives
\[
H_a[\sqrt2F_\kappa|_{(0,a)}]/\|F_\kappa\|_2^2
 =\log\kappa+O_a(1).
\tag{9}
\]
Choosing \(Q\asymp_a\varepsilon^{-1/2}\) therefore shows that the
minimum logarithmic energy under \(D_a[F]\le\varepsilon S_a[F]\)
diverges by (7), but is at most
\((N_a-1)\log(1/\varepsilon)/2+O_a(1)\) as
\(\varepsilon\downarrow0\). These trials do not claim positivity or
pole-nullity. Their role is to show that the qualitative uncertainty
modulus does not conceal a uniform positive graph gap.

**First-prime counterexample, including the pole-null constraint.**
For every \(L/2<a<M_3/2\), only \(n=2\) enters the prime sum.
The nonzero odd test
\[
F_a(x)=\phi(x)\sin(2\pi x/L)\mathbf1_{I_a}(x)
\tag{10}
\]
has \(D_a[F_a]=0\) exactly, because \(F_a/\phi\) has period \(L\)
on every edge, while \(S_a[F_a]>0\). Its Fourier decay is
\(O_a(1/|t|)\), so \(H_a[\sqrt2F_a|_{(0,a)}]\) is finite. More strongly, the
odd pole moment vanishes at some \(a_0\in(L/2,M_3/2)\). Indeed, with
\(k=2\pi/L\), \(u_a=\sqrt2F_a|_{(0,a)}\), and
\(h_a(x)=\sqrt2\sinh(x/2)\), it is
\[
\langle h_a,u_a\rangle
=\int_0^a\sinh x\sin(kx)dx
=\frac{\cosh a\sin(ka)-k\sinh a\cos(ka)}{1+k^2}.
\tag{11}
\]
At \(a=L/2\), the numerator is \(k\sinh(L/2)>0\).
At \(a=M_3/2\), \(ka=\pi M_3/L\in(3\pi/2,2\pi)\), so both
terms in the numerator are negative. Continuity gives the claimed
root \(a_0\) (numerically about \(0.4937399435\)).

This obstruction persists for smooth compactly supported, exactly
pole-null odd tests in the fixed window \(a_0\). Choose even smooth
cutoffs \(\chi_\rho\) that equal one away from boundary strips of
width \(O(\rho)\), and put \(F_\rho=\chi_\rho F_{a_0}\).
The difference \(F_\rho-F_{a_0}\) has \(L^1\)-norm \(O(\rho)\)
and uniformly bounded variation. Its Fourier transform is bounded by
\(O(\min(\rho,|t|^{-1}))\), giving squared logarithmic form norm
\(O(\rho\log(1/\rho))\). Thus \(F_\rho\to F_{a_0}\) in the
\(H_{a_0}\)-form norm. Subtract a vanishing multiple of a fixed smooth
odd function with nonzero pole moment to enforce exact pole-nullity.
Continuity of (1) then gives \(D_{a_0}/S_{a_0}\to0\) while the
normalized logarithmic energies stay bounded. In particular, no
version of (7) can hold for *every* \(a>L/2\), even after imposing
exact pole-nullity and smoothness.

The threshold \(a_*\) is sufficient for the two-prime periodicity
argument, not proved optimal. The interval between \(M_3/2\) and
\(a_*\) is not classified here. The theorem controls only tests whose
graph deficit is sufficiently small, and \(\varepsilon_a\) has no
effective lower bound as \(a\to\infty\). It does not settle the sign
of the full Weil form on the other tests.

The prime shifts and logarithmic Fourier form come from
[Suzuki, *Weil's quadratic form via the screw function*, §2.4 and §4.1](https://arxiv.org/html/2606.09096v2).
