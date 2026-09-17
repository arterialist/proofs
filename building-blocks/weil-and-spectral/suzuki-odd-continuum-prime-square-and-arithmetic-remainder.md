# The odd prime square in the continuum model and its arithmetic remainder

This note uses the normalization of [Suzuki's localized Weil form](https://arxiv.org/html/2606.09096v1), especially its prime shifts and Fourier multiplier in §2.4. It is an exact decomposition of the actual odd operator into a continuous-prime model and a signed arithmetic remainder. The continuous model is positive in the Weil form; no corresponding positivity is claimed for the actual remainder or for RH.

Identify an odd function \(F\in L^2(-a,a)\) unitarily with \(u(x)=\sqrt2F(x)\), \(0<x<a\), and extend \(u\) by zero outside \((0,a)\). For \(0<\ell<2a\), define the self-adjoint shift/reflection operator
\[
 (T_{\ell,a}u)(x)
 =\mathbf1_{x+\ell<a}u(x+\ell)
  +\mathbf1_{x>\ell}u(x-\ell)
  -\mathbf1_{\max(0,\ell-a)<x<\min(a,\ell)}u(\ell-x),
 \qquad 0<x<a.
\tag{1}
\]
The last term has a minus sign because the original function is odd. With \(w_n=\Lambda(n)/\sqrt n\), the actual prime operator is \(P_a^{\rm odd}=\sum_{\log n<2a}w_nT_{\log n,a}\); its contribution to the odd Weil form is **minus** \(\langle u,P_a^{\rm odd}u\rangle\). In particular, for \(a<\log2\), each admitted shift is purely reflected. When \(a>\log n\), its same-side direct terms also occur.

Replace the discrete Chebyshev measure \(d\psi(X)=\sum_n\Lambda(n)\delta_n\) by \(dX\). Under \(X=e^\ell\), the resulting shift density is \(e^{\ell/2}d\ell\). Its odd operator is
\[
 P_{a,\mathrm{cont}}^{\rm odd}
 :=\int_0^{2a}e^{\ell/2}T_{\ell,a}\,d\ell,
 \qquad
 (P_{a,\mathrm{cont}}^{\rm odd}u)(x)
 =\int_0^a\bigl(e^{|x-y|/2}-e^{(x+y)/2}\bigr)u(y)dy.
\tag{2}
\]
The Fourier-to-halfline normalization introduces no extra factor in (2): the two direct shifts supply \(e^{|x-y|/2}\), and odd reflection supplies \(-e^{(x+y)/2}\). Since
\[
 e^{(x+y)/2}-e^{|x-y|/2}
 =e^{(x+y)/2}\int_0^{\min(x,y)}e^{-t}dt,
\]
Fubini gives the exact square
\[
 \boxed{-\langle u,P_{a,\mathrm{cont}}^{\rm odd}u\rangle
 =\int_0^a e^{-t}\left|\int_t^a e^{x/2}u(x)dx\right|^2dt\ge0.}
\tag{3}
\]
Thus the same-side and reflected prime edges compensate completely in the continuous model, for arbitrary complex \(u\), not only nonnegative ones.

Let \(E(X)=\psi(X)-(X-1)\), so \(E(1)=0\) and \(dE=d\psi-dX\). The **exact arithmetic remainder** is the bounded self-adjoint operator
\[
 \mathcal R_a^{\rm odd}
 :=P_a^{\rm odd}-P_{a,\mathrm{cont}}^{\rm odd}
 =\int_1^{e^{2a}} X^{-1/2}T_{\log X,a}\,dE(X).
\tag{4}
\]
The Stieltjes integral is simply a finite prime-power shift sum minus the continuous integral (2). With
\(h_a(x)=\sqrt2\sinh(x/2)\), Suzuki's **full** odd Weil form is therefore exactly
\[
 \boxed{A_a^{\rm odd}=\mathcal A_a+\mathcal G_a-\mathcal R_a^{\rm odd}
             -2|h_a\rangle\langle h_a|,}
 \qquad \mathcal G_a=-P_{a,\mathrm{cont}}^{\rm odd}\ge0,
\tag{5}
\]
where \(\langle u,\mathcal A_au\rangle=(2/\pi)\int_0^\infty
 [\Re\psi(1/4+it/2)-\log\pi]
 |\int_0^a u(x)\sin(tx)dx|^2dt\).

The continuum square also absorbs **the entire pole rank one at every finite
window**. Put \(F_t=\int_t^a e^{x/2}u(x)\,dx\) and
\(d\mu(t)=e^{-t}dt\), so \(\mu([0,a])=1-e^{-a}\) and
\(\langle u,\mathcal G_au\rangle=\int_0^a|F_t|^2d\mu(t)\).
Fubini, including Suzuki's factor \(h_a=\sqrt2\sinh(x/2)\), gives
\[
\int_0^a F_t\,d\mu(t)
=\int_0^a(e^{x/2}-e^{-x/2})u(x)\,dx
=\sqrt2\langle h_a,u\rangle.
\]
Consequently Cauchy–Schwarz and the variance identity yield the exact formula
\[
\boxed{\begin{aligned}
\langle u,(\mathcal G_a-2|h_a\rangle\langle h_a|)u\rangle
&=e^{-a}\int_0^a|F_t|^2d\mu(t)\\
&\quad+\frac12\int_0^a\!\int_0^a|F_s-F_t|^2d\mu(s)d\mu(t)
\ \ge e^{-a}\langle u,\mathcal G_au\rangle\ge0.
\end{aligned}}
\tag{5a}
\]
Thus (5) may be written exactly as
\(A_a^{\rm odd}=\mathcal A_a+(\mathcal G_a-2|h_a\rangle\langle h_a|)-\mathcal R_a^{\rm odd}\).
This conservation is a statement about the continuum model and the actual pole
normalization; it gives no sign for the signed arithmetic remainder. In
particular, \(\mathcal G_a\) is compact, so the positive form in (5a) supplies
no uniform positive multiple of \(\|u\|_2^2\).

There is a simpler kernel form for this compensated positive operator. Expanding
\(4\sinh(x/2)\sinh(y/2)\) in exponentials shows that
\[
\boxed{\mathcal K_a:=\mathcal G_a-2|h_a\rangle\langle h_a|,
\qquad K_a(x,y)=e^{-|x-y|/2}-e^{-(x+y)/2}.}
\tag{5b}
\]
On \(L^2(0,\infty)\), this is the Green kernel of the Dirichlet resolvent
\((-d^2/dx^2+1/4)^{-1}\): the full-line resolvent kernel is
\(e^{-|x-y|/2}\), and the second term is its reflected image enforcing zero
boundary value at the origin. Since the Dirichlet Laplacian is nonnegative,
compression to \((0,a)\) gives the uniform operator inequality
\[
\boxed{0\le\mathcal K_a\le4I,
\qquad A_a^{\rm odd}=\mathcal A_a+\mathcal K_a-\mathcal R_a^{\rm odd}.}
\tag{5c}
\]
The compensated operator is compact for each finite \(a\), despite its
uniform norm bound. Formula (5c) isolates the remaining all-scale problem:
the signed arithmetic discrepancy must be controlled by the archimedean form
plus this bounded Green operator. An estimate asserting that inequality for
every \(a\) would be the full odd Weil positivity criterion itself, so (5c)
does not establish it.

The positive Green term does **not** make the full continuum baseline
\(\mathcal A_a+\mathcal K_a\) positive. With the sine-transform convention in
(5), the half-line Dirichlet resolvent has multiplier
\((t^2+1/4)^{-1}\). The digamma recurrence therefore gives, for compact
smooth \(u\),
\[
\langle u,(\mathcal A_a+\mathcal K_a)u\rangle
=\frac2\pi\int_0^\infty b(t)
 \left|\int_0^a u(x)\sin(tx)dx\right|^2dt,
\qquad
b(t)=\Re\psi(5/4+it/2)-\log\pi.
\tag{5d}
\]
This is the same rational pole-factor normalization recorded in the earlier
[rational scattering note](rational-scattering-pole-factor.md). Its value at
zero is
\[
b(0)=4-\gamma-\frac\pi2-3\log2-\log\pi<0.
\]
For any \(\varphi\in C_c^\infty(0,1)\) with \(\|\varphi\|_2=1\), set
\(u_a(x)=a^{-1/2}\varphi(x/a)\). Sine Plancherel, the substitution \(s=at\),
and dominated convergence (the sine transform of \(\varphi\) decays rapidly
and \(b(t)=O(1+\log(2+t))\)) give
\[
\langle u_a,(\mathcal A_a+\mathcal K_a)u_a\rangle
\longrightarrow b(0)<0\qquad(a\to\infty).
\tag{5e}
\]
Thus all-scale positivity of the *actual* Weil form would require the signed
arithmetic remainder to contribute an order-one favorable correction on
these low-frequency tests:
\(\langle u_a,\mathcal R_a^{\rm odd}u_a\rangle\le b(0)+o(1)\).
This is a necessary condition under that positivity hypothesis, not an
unconditional assertion about the remainder.

Here are two precise limitations on a one-sided bound for the remainder. If \(a\le\log2\) and \(u\ge0\) is real, all prime shifts in (1) are reflected, so \(\langle u,P_a^{\rm odd}u\rangle\le0\). Equivalently,
\[
 \langle u,\mathcal R_a^{\rm odd}u\rangle\le
 \langle u,\mathcal G_au\rangle
 \qquad(u\ge0,\ a\le\log2).
\tag{6}
\]
This cone inequality is much weaker than positivity of the full form. It fails for every \(a>\log2\): choose generic \(0<x_0<x_0+\log2<a\), avoiding the finitely many reflected prime-power center relations, and put two identical narrow nonnegative bumps at \(x_0\) and \(x_0+\log2\). The direct \(n=2\) overlap contributes \(+2w_2\) to \(\langle u,P_a^{\rm odd}u\rangle\) after \(L^2\)-normalizing each bump, while all other prime overlaps vanish for sufficiently small widths. The continuous square in (3) is \(O(\text{width})\) for these bumps. Hence the one-sided relation (6) reverses strictly once the first direct shift is admitted.

There is also an unconditional discrepancy estimate, but it loses too much regularity. For \(u\in C_c^\infty(0,a)\), put \(D_u(\ell)=\langle u,T_{\ell,a}u\rangle\). Zero extension and Cauchy–Schwarz give \(|D_u(\ell)|\le3\|u\|_2^2\), \(|D'_u(\ell)|\le3\|u\|_2\|u'\|_2\). Integration by parts in (4), using \(E(1)=0\) and \(D_u(2a)=0\), yields
\[
 \langle u,\mathcal R_a^{\rm odd}u\rangle
 =-\int_0^{2a}E(e^\ell)e^{-\ell/2}
       \bigl(D'_u(\ell)-\tfrac12D_u(\ell)\bigr)d\ell,
\]
and thus, with \(B_a=\int_0^{2a}|E(e^\ell)|e^{-\ell/2}d\ell\),
\[
 |\langle u,\mathcal R_a^{\rm odd}u\rangle|
 \le B_a\bigl(3\|u\|_2\|u'\|_2+\tfrac32\|u\|_2^2\bigr).
\tag{7}
\]
This is a rigorous, finite-window inequality strictly weaker than RH. It does not close (5): the archimedean multiplier grows only logarithmically at high frequency, while the derivative norm in (7) grows linearly on modulated smooth tests. Replacing this derivative loss by a bound adapted to the logarithmic arch form is the arithmetic problem exposed by (4).
