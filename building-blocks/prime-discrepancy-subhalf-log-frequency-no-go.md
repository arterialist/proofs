# A sub-half-log frequency barrier for the odd prime discrepancy

Use the actual finite prime-shift operator and the continuum decomposition in
[the odd continuum note](suzuki-odd-continuum-prime-square-and-arithmetic-remainder.md):
\(\mathcal R_a^{\rm odd}=P_a^{\rm odd}+\mathcal G_a\), with
\(\mathcal G_a\ge0\). The odd unitary map sends a full-interval odd function
\(f\in L^2(-a,a)\) to \(u(x)=\sqrt2f(x)\), \(0<x<a\). For
\(0\le\alpha<1/2\), define the nonnegative logarithmic-frequency form
\[
\mathfrak H_{\alpha,a}[u]
=\frac2\pi\int_0^\infty [\log(2+t)]^\alpha
 \left|\int_0^a u(x)\sin(tx)dx\right|^2dt.
\tag{1}
\]
For \(\alpha=0\), this is \(\|u\|_2^2\). Equivalently, (1) is the full-line
Fourier multiplier \([\log(2+|t|)]^\alpha\) on the odd extension \(f\).

**Theorem.** For every fixed \(0\le\alpha<1/2\), there are no finite
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
\[
W_a:=\sum_{n<X}w_n=(2+o(1))e^a,
\qquad
S_a:=\sum_{n<X}w_n(2a-\ell_n)=(4+o(1))e^a.
\tag{3}
\]
For the second equality, replacing \(d\psi(x)\) by \(dx\) has relative
\(o(1)\) error after integration by parts, and its main term is
\(\int_1^Xx^{-1/2}\log(X/x)dx=4e^a-4a-4\).

Let \(r_a\) be the number of admitted prime-power lengths; certainly
\(r_a\le e^{2a}\). Dirichlet simultaneous approximation with denominator
\(Q=1000\) supplies an integer \(1\le q\le Q^{r_a}\) such that each
\(q\ell_n\) is within \(2\pi/Q\) of an integer multiple of \(2\pi\).
Take \(M=1\) if \(q\ge10\), and otherwise take
\(M=\lceil10/q\rceil\le10\). Then \(t_a=Mq\) satisfies
\[
10\le t_a\le10Q^{r_a},\qquad
|e^{it_a\ell_n}-1|\le20\pi/Q<1/10,
\qquad \log(2+t_a)=O(e^{2a}).
\tag{4}
\]
In particular \(\cos(t_a\ell_n)\ge1/2\) for every admitted prime power.

Set \(N_{a,t}=\int_{-a}^a\sin^2(tx)dx
=a-\sin(2ta)/(2t)\) and define the normalized odd carrier
\(f_a(x)=N_{a,t_a}^{-1/2}\sin(t_ax)\mathbf1_{(-a,a)}(x)\).
For one shift \(\ell\), the identity
\(2\sin(tx)\sin(t(x+\ell))
=\cos(t\ell)-\cos(2tx+t\ell)\) and
\(\left|\int_{-a}^{a-\ell}\cos(2tx+t\ell)dx\right|\le1/t\)
give
\[
\begin{aligned}
\langle f_a,P_af_a\rangle
&=\frac1{N_{a,t_a}}\sum_{n<X}w_n
 \left((2a-\ell_n)\cos(t_a\ell_n)-E_{n,a}\right),
 &|E_{n,a}|\le1/t_a,\\
&\ge\frac{S_a/2-W_a/t_a}{N_{a,t_a}}
\ge\frac{e^a}{a}
\qquad\text{for all sufficiently large }a.
\end{aligned}
\tag{5}
\]
Because \(\mathcal R_a^{\rm odd}=P_a^{\rm odd}+\mathcal G_a\) and
\(\mathcal G_a\ge0\), the corresponding normalized halfline
\(u_a=\sqrt2f_a|_{(0,a)}\) satisfies
\(\langle u_a,\mathcal R_a^{\rm odd}u_a\rangle\ge e^a/a\).

It remains to bound (1) on the carrier. Let
\(q_a=(2a)^{-1/2}\mathbf1_{(-a,a)}\), so \(\|q_a\|_2=1\) and
\(\widehat q_a(\xi)=\sqrt{2/a}\sin(a\xi)/\xi\). For \(a\ge1\), scaling
\(s=a\xi\) shows that
\[
\frac1{2\pi}\int_{\mathbb R}
 [\log(2+|\xi|)]^\alpha|\widehat q_a(\xi)|^2d\xi
\le\frac1\pi\int_{\mathbb R}
 [\log(2+|s|)]^\alpha\frac{\sin^2s}{s^2}ds
=:B_\alpha<\infty.
\tag{6}
\]
The identity \(\sin(t_ax)q_a(x)
=(e^{it_ax}-e^{-it_ax})q_a(x)/(2i)\), the bound
\(|A-B|^2\le2(|A|^2+|B|^2)\), and
\(\log(2+|\xi+t_a|)
\le\log(2+t_a)+\log(2+|\xi|)\) imply, using
\((v+w)^\alpha\le v^\alpha+w^\alpha\),
\[
\mathfrak H_{\alpha,a}[u_a]
\le C_\alpha\bigl(1+[\log(2+t_a)]^\alpha\bigr)
=O_\alpha(1+e^{2\alpha a}).
\tag{7}
\]
The ratio of the lower bound in (5) to (7) tends to infinity when
\(\alpha<1/2\), contradicting (2).

The displayed carrier has a jump at \(x=a\), but lies in the domain of
(1), as (6)–(7) show. For each fixed \(a\) and \(t_a\), it can be approximated
by \(C_c^\infty(0,a)\) in a fractional \(H^s\) norm with any
\(0<s<1/2\), hence also in (1), while boundedness of
\(\mathcal R_a^{\rm odd}\) preserves (5). Thus the contradiction applies
already to the stated compact smooth test class. \(\square\)

No novelty or priority is claimed pending comparison with existing
prime-phase recurrence estimates.
