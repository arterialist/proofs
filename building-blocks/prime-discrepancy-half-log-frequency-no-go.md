# A half-log frequency barrier for the odd prime discrepancy

Use the actual finite prime-shift operator and the continuum decomposition in
[the odd continuum note](suzuki-odd-continuum-prime-square-and-arithmetic-remainder.md):
\(\mathcal R_a^{\rm odd}=P_a^{\rm odd}+\mathcal G_a\), with
\(\mathcal G_a\ge0\). The odd unitary map sends a full-interval odd function
\(f\in L^2(-a,a)\) to \(u(x)=\sqrt2f(x)\), \(0<x<a\). For
\(0\le\alpha\le1/2\), define the nonnegative logarithmic-frequency form
\[
\mathfrak H_{\alpha,a}[u]
=\frac2\pi\int_0^\infty [\log(2+t)]^\alpha
 \left|\int_0^a u(x)\sin(tx)dx\right|^2dt.
\tag{1}
\]
For \(\alpha=0\), this is \(\|u\|_2^2\). Equivalently, (1) is the full-line
Fourier multiplier \([\log(2+|t|)]^\alpha\) on the odd extension \(f\).

**Theorem.** For every fixed \(0\le\alpha\le1/2\), there are no finite
constants \(C,D\), independent of \(a\), for which
\[
\langle u,\mathcal R_a^{\rm odd}u\rangle
\le C\mathfrak H_{\alpha,a}[u]+D\|u\|_2^2
\tag{2}
\]
holds for all \(a\ge1\) and all odd-halfline compact smooth tests. The same
failure holds if the right side is augmented by any fixed multiple of the
pole-compensated continuum Green form \(\langle u,\mathcal K_au\rangle\),
since \(0\le\mathcal K_a\le4I\). This is a restriction on a proposed
uniform perturbative estimate; it does not address the actual archimedean
multiplier, whose high-frequency growth is \(\log t\), corresponding to the
larger exponent \(\alpha=1\).

**Proof.** Put \(X=e^{2a}\), \(\ell_n=\log n\),
\(w_n=\Lambda(n)/\sqrt n\), and sum only over \(n<X\) with
\(\Lambda(n)>0\). The prime number theorem and partial summation give
\(W_a:=\sum_{n<X}w_n=(2+o(1))e^a\). If \(r_a\) is the number of admitted
prime powers, the prime number theorem also gives
\(r_a=O(e^{2a}/a)\): primes dominate, and the number of higher powers is
\(O(e^a a)\).

Take \(\phi_a(x)=\cosh(x/2)\) on \((-a,a)\) and normalize
\(g_a=\phi_a\mathbf1_{(-a,a)}/\|\phi_a\|_2\), where
\(\|\phi_a\|_2^2=a+\sinh a\). The exact weighted-row identity and PNT
proved in the [spatial Schur note](prime-shift-weighted-schur-window-asymptotic.md)
give
\[
\frac{(P_a\phi_a)(x)}{\phi_a(x)}=e^a+o(e^a)
\quad\text{uniformly for }|x|<a,
\qquad
\langle g_a,P_ag_a\rangle=(1+o(1))e^a.
\tag{3}
\]
The function \(g_a\) is nonnegative and even. For \(a\ge1\),
\(g_a(a)^2\le1\), \(|g_a'|\le g_a/2\) in the interval, and both its
\(L^1\) norm and its total variation after zero extension are bounded
uniformly in \(a\).

Dirichlet simultaneous approximation with denominator \(Q=100000\)
supplies an integer \(1\le q\le Q^{r_a}\) such that each \(q\ell_n\)
is within \(2\pi/Q\) of an integer multiple of \(2\pi\).
Take \(M=1\) if \(q\ge100\), and otherwise take
\(M=\lceil100/q\rceil\le100\). Then \(t_a=Mq\) satisfies
\[
100\le t_a\le100Q^{r_a},\qquad
|e^{it_a\ell_n}-1|\le200\pi/Q<1/100,
\qquad \log(2+t_a)=O(e^{2a}/a).
\tag{4}
\]
In particular \(\cos(t_a\ell_n)>0.99\) for every admitted prime power.

Let \(F_a(x)=\sqrt2\sin(t_ax)g_a(x)\). It is odd, and
\(\|F_a\|_2^2=1-\int_{-a}^a\cos(2t_ax)g_a(x)^2dx=1+O(1/t_a)\), with
an absolute implied constant. For \(0<\ell<2a\), put
\(H_\ell(x)=g_a(x)g_a(x+\ell)\) on \((-a,a-\ell)\). Its two endpoint
values are at most \(g_a(a)^2\le1\), while
\(\int|H_\ell'|\le\int H_\ell\le1\). Integration by parts therefore gives
\[
\left|\int_{-a}^{a-\ell}
 \cos(2t_ax+t_a\ell)H_\ell(x)dx\right|
\le\frac3{2t_a}.
\tag{5}
\]
Using \(2\sin v\sin w=\cos(v-w)-\cos(v+w)\), the positivity of every
\(H_{\ell_n}\), (3), and (5), we obtain
\[
\langle F_a,P_aF_a\rangle
\ge0.99\langle g_a,P_ag_a\rangle-3W_a/t_a
\ge\tfrac12e^a
\quad\text{for all sufficiently large }a.
\tag{6}
\]
After normalizing \(F_a\), the corresponding halfline
\(u_a=\sqrt2F_a|_{(0,a)}/\|F_a\|_2\) has norm one and, since
\(\mathcal R_a^{\rm odd}=P_a^{\rm odd}+\mathcal G_a\) with
\(\mathcal G_a\ge0\), satisfies
\(\langle u_a,\mathcal R_a^{\rm odd}u_a\rangle\ge e^a/3\)
for all sufficiently large \(a\).

It remains to bound (1). The uniform \(L^1\) and total-variation bounds on
\(g_a\) imply
\(|\widehat g_a(\xi)|\le C\min(1,|\xi|^{-1})\), hence
\[
\sup_{a\ge1}\frac1{2\pi}\int_{\mathbb R}
 [\log(2+|\xi|)]^\alpha|\widehat g_a(\xi)|^2d\xi
<\infty.
\tag{7}
\]
Modulation by \(e^{\pm it_ax}\) shifts this Fourier transform by
\(\pm t_a\). The inequalities \(|A-B|^2\le2(|A|^2+|B|^2)\),
\(\log(2+|\xi+t_a|)
\le\log(2+t_a)+\log(2+|\xi|)\), and
\((v+w)^\alpha\le v^\alpha+w^\alpha\) give
\[
\mathfrak H_{\alpha,a}[u_a]
\le C_\alpha\bigl(1+[\log(2+t_a)]^\alpha\bigr)
=O_\alpha\left(1+\frac{e^{2\alpha a}}{a^\alpha}\right).
\tag{8}
\]
The ratio of the lower bound \(e^a/3\) to (8) tends to infinity even at
\(\alpha=1/2\), when the denominator is \(O(e^a/\sqrt a)\).
This contradicts (2).

The displayed carrier has a jump at \(x=a\), but lies in the domain of
(1), as (7)–(8) show. For each fixed \(a\) and \(t_a\), it can be approximated
by \(C_c^\infty(0,a)\) in a fractional \(H^s\) norm with any
\(0<s<1/2\), hence also in (1), while boundedness of
\(\mathcal R_a^{\rm odd}\) preserves (6). Thus the contradiction applies
already to the stated compact smooth test class. \(\square\)

No novelty or priority is claimed pending comparison with existing
prime-phase recurrence estimates.
