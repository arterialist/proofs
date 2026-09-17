# The actual two-prime mixed second moment takes both signs

This is a written mathematical proof, not a Lean theorem. The [semilocal foundation](semilocal-weighted-scattering.md) fixes the negative-frequency Hardy projection, trace normalization and ordinary localized trace domains. No priority claim is made for these operator calculations.


The cross term in the [exact prime cocycle](exact-prime-scattering-fibers.md) can be computed on the actual first two prime factors. For unimodular $u$, the [Hardy kernel](semilocal-weighted-scattering.md) without its weight gives
$$
\operatorname{diag}(\Delta_u^2)(t)
=\frac1{4\pi^2}\int_{\mathbb R}
\frac{|1-\overline{u(t)}u(v)|^2}{(t-v)^2}\,dv
=\frac1{2\pi}\Re\bigl(\overline{u(t)}\,|D_t|u(t)\bigr).
\tag{25.1}
$$
For the local prime factors, the multiplier $|D_t|$ can be applied termwise to their Fourier series; coefficients and every polynomially weighted delay sum are absolutely summable.

Define the auxiliary mixed second-moment trace
$$
\mathfrak D_{pq}(\chi)=\operatorname{Tr}\left(
M_\chi[\Delta_{u_pu_q}^2-\Delta_{u_p}^2-\Delta_{u_q}^2]
\right)=\int\chi(t)d_{pq}(t)\,dt.
$$
Each localized product is trace class by the semilocal trace-class proof and multiplication by a bounded defect. The squared-kernel diagonal also follows directly by Hilbert–Schmidt localization. Algebra in (25.1) gives the absolutely convergent formula
$$
d_{pq}(t)=-\frac1{2\pi^2}\int_{\mathbb R}
\frac{\Re[(1-\overline{u_p(t)}u_p(v))
(1-\overline{u_q(t)}u_q(v))]}{(t-v)^2}\,dv.
\tag{25.2}
$$
The numerator is $O((t-v)^2)$ at the diagonal and bounded away from it. This is a second moment of the actual local-factor defect, not the Weil quadratic form.

Put $a=\log p$, $b=\log q$, $r=p^{-1/2}$, $s=q^{-1/2}$. The [local expansion](exact-prime-scattering-fibers.md), equation (24.1), is
$u_p(t)=-r e^{iat}+(1-r^2)\sum_{k\ge0}r^ke^{-ikat}$.
In $|D|(u_pu_q)-u_p|D|u_q-u_q|D|u_p$, equal-sign delays cancel, while opposite-sign delays use
$|\alpha+\beta|-|\alpha|-|\beta|=-2\min(|\alpha|,|\beta|)$.
Hence
$$
\begin{aligned}
d_{pq}(t)=\frac1\pi\Re\Bigg[\overline{u_p(t)u_q(t)}
\Bigg\{&r(1-s^2)\sum_{\ell\ge1}s^\ell\min(a,\ell b)e^{i(a-\ell b)t}\\
&+s(1-r^2)\sum_{k\ge1}r^k\min(ka,b)e^{i(b-ka)t}\Bigg\}\Bigg].
\end{aligned}
\tag{25.3}
$$
These are the exact delay differences $\log(p/q^\ell)$ and $\log(q/p^k)$. Expanding the remaining conjugate factors yields an absolutely convergent series in $\log(n/m)$ involving just these two actual primes. No independence assumption or proper-power truncation is used. The resulting density is bounded, smooth and even.

For $p=2,q=3$, one has $a<b<2a$, so the minima in (25.3) can be summed explicitly. With $z=e^{iat}$, $w=e^{ibt}$,
$$
\boxed{
d_{23}(t)=\frac1{2\pi}\Re
\frac{2rs}{(1-rz)(1-sw)}
\left[
a(1-s^2)\frac{z-r}{w}
+(1-r^2)(w-s)\left(\frac a z+\frac{r(b-a)}{z^2}\right)
\right].
}
\tag{25.4}
$$
Define positive constants
$$
A=2rs(1-s^2)a,\qquad
B=2s(1-r^2)\left(ra+\frac{br^2}{1-r}\right).
$$
At zero frequency,
$$
d_{23}(0)=\frac1{2\pi}\left(\frac A{1-s}+B\right)>0.
\tag{25.5}
$$
At $t_*=2\pi/\log2$, one has $z=1$. Write $c=\Re w$. Then
$$
2\pi d_{23}(t_*)=
\frac{A(c+s-2sc^2)+B((1+s^2)c-2s)}{1+s^2-2sc}.
\tag{25.6}
$$
The exact integer inequalities $2^5<3^4<2^7$ imply
$5/4<\log3/\log2<7/4$, and therefore $c<0$. Moreover
$A/B<(1-s^2)/(1-r^2)=4/3<2$.
The numerator in (25.6) is
$c[A+B(1+s^2)]-2As c^2+s(A-2B)<0$.
Thus $d_{23}(t_*)<0$. This is an exact sign change at actual arithmetic phases.

Both signs occur on the actual compact pole-null theta test class. Use the theta kernel $\Phi$ and measure $d\nu=2\cosh(u/2)\Phi(u)du$ from the [theta normalization](../theta-and-heat/theta-derivative-kernel-logconcavity.md). Choose nonzero even real $\eta\in C_c^\infty$ and set
$$
g_R(x)=R^{-1/2}\eta(x/R)\cos(t_0x),\qquad
f_R=(-\partial_x^2+\tfrac14)g_R,\qquad h_R=f_R/\Phi.
$$
For $t_0=0$, this is the unmodulated packet. The function $h_R$ is even compact smooth, and
$$
F_R(t)=\widehat f_R(t)=(t^2+\tfrac14)\widehat g_R(t),
\quad F_R(i/2)=F_R(-i/2)=0,
\quad\nu h_R=0.
$$
The pole cancellations are exact, with no compact spectral cutoff substituted for compact physical support. The normalized measures $|F_R|^2dt/\int|F_R|^2$ tend to $\tfrac12(\delta_{t_0}+\delta_{-t_0})$ for $t_0>0$, and to $\delta_0$ at $t_0=0$. Schwartz decay of $\widehat\eta$ controls the polynomial Fourier factor and the separated-packet cross terms. Since $d_{23}$ is bounded continuous and even,
$$
\frac{\mathfrak D_{23}(|F_R|^2)}{\int|F_R(t)|^2dt}
\longrightarrow d_{23}(t_0).
\tag{25.7}
$$
Taking $t_0=0$ or $t_0=t_*$ gives the two strict signs for sufficiently large finite physical supports.

There is therefore no universal positive or negative sign for this mixed second moment, even after both pole moments are removed on admissible compact theta tests. The distinguished theta radical and the full archimedean/all-prime aggregate can have additional cancellation. No sign for that aggregate, and no negative Weil-form witness, is obtained here. The calculation specifies the actual two-history interaction that a proposed multiplicative second-moment estimate must retain.


## Physical overlap and a signed two-history Gram estimate


The preceding mixed interaction also has a physical-space representation. To fix all constants, in this section let
$\mathcal Ff(t)=(2\pi)^{-1/2}\int e^{-itx}f(x)\,dx$,
$T_af(x)=f(x+a)$, and $(f,g)_2=\int\overline f g$.
Write $L=\log p$, $M=\log q$, $r=p^{-1/2}$, $s=q^{-1/2}$, $\mathcal U=U_pU_q$, and
$K_f(a)=(f,\mathcal U^*T_af)_2$.
The normalized weighted trace
$$
D_{pq}(f)=\mathfrak D_{pq}(|\mathcal Ff|^2)
$$
satisfies
$$
\begin{aligned}
D_{pq}(f)=\frac1\pi\Re\Big[&
r(1-s^2)\sum_{j\ge1}s^j\min(L,jM)K_f(L-jM)\\
&+s(1-r^2)\sum_{k\ge1}r^k\min(M,kL)K_f(M-kL)\Big].
\end{aligned}
\tag{26.1}
$$
For an even physical test and the unnormalized transform used elsewhere in this note, the trace is $2\pi D_{pq}(f)$. The complete phase expansions and Parseval's identity give (26.1) from (25.3).

The minima are exact boundary-overlap lengths. For $A,B>0$, with $P=1_{x>0}$,
$$
PT_{-B}(1-P)T_AP
=1_{(\max(0,B-A),B)}T_{A-B}.
\tag{26.2}
$$
The interval on the right has length $\min(A,B)$. Oppositely directed $p$ and $q^j$ histories therefore share a crossing interval of length $\min(\log p,j\log q)$, and retain the net displacement $\log(p/q^j)$.

In $\mathscr H=L^2((0,\infty)_\tau;L^2(\mathbb R))$, define
$$
A_p(\tau)=r1_{(0,L)}(\tau)U_pT_{-L}f,
\quad
B_q(\tau)=(1-s^2)U_q^*
\sum_{j\ge1}s^j1_{(0,jM)}(\tau)T_{-jM}f.
$$
Interchanging $p,q$ defines the other pair. Resolving the minimum into crossing levels gives the exact signed Gram identity
$$
D_{pq}(f)=\frac1\pi\Re\big[(A_p,B_q)_{\mathscr H}
+(A_q,B_p)_{\mathscr H}\big].
\tag{26.3}
$$
All phase filters and adjoints remain in the channels. The overlap lengths alone do not fix their relative sign.

These channels also give an explicit interaction bound. Put
$$
R_q=(I-sT_{-M})^{-1},\qquad
C_s(A,B)=\int_0^A s^{2(\lfloor\tau/B\rfloor+1)}\,d\tau.
$$
If $m=\lfloor A/B\rfloor$, $\alpha=A-mB$, then
$$
C_s(A,B)=\frac{Bs^2(1-s^{2m})}{1-s^2}+\alpha s^{2(m+1)}.
$$
The geometric tail at level $\tau$ equals
$s^nT_{-nM}R_qf$, $n=\lfloor\tau/M\rfloor+1$.
Consequently
$$
\|A_p\|_{\mathscr H}^2=r^2L\|f\|_2^2,
\qquad
\int_0^L\|B_q(\tau)\|_2^2\,d\tau
=(1-s^2)^2C_s(L,M)\|R_qf\|_2^2.
$$
Cauchy–Schwarz on the actual crossing intervals gives
$$
\boxed{
|D_{pq}(f)|\le\frac{\|f\|_2}{\pi}
\left[r(1-s^2)\sqrt{LC_s(L,M)}\|R_qf\|_2
+s(1-r^2)\sqrt{MC_r(M,L)}\|R_pf\|_2\right].
}
\tag{26.4}
$$
This keeps the finite overlap windows; for example $L<M$ gives $C_s(L,M)=Ls^2$.

Finally,
$$
\|R_qf\|_2^2=
\frac{\|f\|_2^2+2\sum_{k\ge1}s^k\Re(f,T_{kM}f)_2}{1-s^2}.
\tag{26.5}
$$
For compact $f$, only finitely many correlations survive, although the underlying division-history channels contain every proper power. Both pole moments remain conditions on the original $f$; auxiliary filtered histories need not be compact or pole-null. Equations (26.3)–(26.5) supply a signed interaction representation and a computable bound, consistent with the two signs proved above. They do not discard the cross terms or establish a sign for their full arithmetic aggregate.
