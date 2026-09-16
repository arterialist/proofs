# General base-weight rigidity for the factorial-ground first window

RH Agent3, 2026-09-17. This extends the power-weight calculation in [the first-window note](factorial-f-ground-first-window-base-weight-support-obstruction.md). It is an algebraic statement about the first-window functional, including the actual von Mangoldt source when inserted. The source-uniform tests below also use artificial smooth sources and therefore do not assert an unconditional sign of the unrestricted actual score or prove RH.

Put $L=\log 2$, $E=\psi-x$, and let $F>0$ be the actual continuous factorial ground, so that $F'=-E/x^2$ almost everywhere. For a bounded measurable base weight $q:(0,\infty)\to\mathbb R$, let
\[
H_q(x)=\frac1{x^2}\int_{x/2}^{x}Yq(Y)\log^2(x/Y)\,dY
=\int_0^L k(t)q(xe^{-t})\,dt,
\qquad k(t)=t^2e^{-2t}\mathbf1_{[0,L]}(t).
\tag{1}
\]
For a finite zero-to-zero source interval $[a,b)$ with $E(a^-)=E(a)=E(b^-)=E(b)=0$, finite-variation Fubini followed by Stieltjes integration by parts gives the exact identity
\[
\boxed{\quad
\int_0^\infty q(Y)B_s^{[a,b)}(Y)\,dY
=-p_s^2\int_a^b
\left(\frac{E(x)H_q'(x)}{F(x)}
+\frac{E(x)^2H_q(x)}{x^2F(x)^2}\right)dx.
\quad}\tag{2}
\]
Here $B_s^{[a,b)}(Y)=\int_{[a,b)}p_s^2Y\log^2(x/Y)/(x^2F(x))\mathbf1_{[Y,2Y)}(x)\,dE(x)$. In logarithmic coordinates $u=\log x$, $Q(u)=q(e^u)$, equation (1) is $H_q(e^u)=(k*Q)(u)$. The kernel $k$ has bounded variation, so $H_q$ is locally Lipschitz for bounded $q$; the derivative in (2) exists almost everywhere.

The signed linear term in (2) vanishes for every smooth compactly supported source-ground pair satisfying $F'=-E/x^2$ if and only if $H_q$ is constant on the tested source region. Necessity follows by setting $E=\epsilon\varphi$ with arbitrary $\varphi\in C_c^\infty$ and $F=F_0+O(\epsilon)>0$: the first-order term is $-\epsilon p_s^2 F_0^{-1}\int\varphi H_q'$, while the square is second order. Thus the criterion is about an algebraic, source-uniform cancellation; a special actual-source correlation might still cancel the linear term for other $q$.

**Bilateral rigidity.** If $H_q(x)$ is constant for every $x>0$, then $q$ is constant almost everywhere. To prove this, $k$ has no real Fourier zeros. Set $f(t)=t^2e^{-2t}$ on $[0,L]$. Since $L<1$, $f(0)=0$ and $f'(t)=2t(1-t)e^{-2t}>0$ for $0<t<L$. If $\widehat k(\omega)=\int_0^L f(t)e^{-i\omega t}dt=0$ for a nonzero real $\omega$, integration by parts would imply
\[
\int_0^L f'(t)e^{i\omega(L-t)}dt=f(L)=\int_0^L f'(t)dt.
\tag{3}
\]
Equality in the triangle inequality forces $e^{i\omega(L-t)}=1$ for almost every $t\in(0,L)$, impossible. Also $\widehat k(0)>0$. If $H_q=C$, subtract $c=C/\int k$ from $Q$ to get $k*(Q-c)=0$. The bounded function $Q-c$ is a tempered distribution; Fourier transformation gives $\widehat k\,\widehat{(Q-c)}=0$. Local division by the smooth, nowhere-zero $\widehat k$ shows $Q=c$ almost everywhere. In particular the ordinary base weight is the only bounded weight on the full positive base line that removes the linear source term everywhere.

**Sharp tail rigidity on the actual source domain.** If $H_q(x)$ is constant for every $x>1$, then $q(Y)$ is that constant divided by $\int k$ for almost every $Y>1/2$. Values of $q$ on $Y\le1/2$ are invisible to all $H_q(x)$ with $x>1$, so this is sharp. Here is a self-contained one-sided proof. Let $c=H_q/\int k$ and $U(u)=Q(u)-c$. Then $k*U=0$ for $u>0$. In distributions, since $f(t)=t^2e^{-2t}$ has $f(0)=0$ and $f'>0$ on $(0,L)$,
\[
0=(k*U)'(u)=\int_0^L f'(t)U(u-t)dt-f(L)U(u-L).
\]
Putting $v=u-L$ gives the forward harmonic equation
\[
U(v)=\int_0^L U(v+s)\,d\mu(s)
\quad(v>-L),\qquad
d\mu(s)=\frac{f'(L-s)}{f(L)}ds.
\tag{4}
\]
The measure $\mu$ is a probability with a bounded-variation density positive on $(0,L)$ and positive variance. Every bounded solution of (4) is constant on $(-L,\infty)$. Since convolution of an $L^1$ density with bounded $U$ is continuous, replace $U$ on a null set by this continuous harmonic representative; then (4) holds everywhere on the half-line and can be iterated to get $U(v)=\int U(v+s)d\mu^{*n}(s)$. For any fixed displacement $h$, the total-variation distance between $\mu^{*n}$ and its translate by $h$ tends to zero. Indeed the characteristic function $\widehat\mu(\xi)$ has modulus strictly less than one off zero, has $|\widehat\mu(\xi)|^2=1-\operatorname{Var}(\mu)\xi^2+O(|\xi|^3)$ near zero, and decays as $O(1/|\xi|)$ at infinity. Plancherel gives $\|\mu^{*n}-\tau_h\mu^{*n}\|_2=O_h(n^{-3/4})$; on an interval of width $O(n^{1/2+\varepsilon})$ around the common mean, Cauchy--Schwarz makes its $L^1$ contribution $O_h(n^{-1/2+\varepsilon/2})$, and Chebyshev makes the two tails $O_h(n^{-2\varepsilon})$. Thus $U(v)=U(w)$ for almost every $v,w>-L$. Since $k*U=0$ on $u>0$, this constant must be zero. Equivalently, $q=c$ almost everywhere on $Y>e^{-L}=1/2$.

**Causal-base obstruction.** If $q(Y)=0$ for $Y<1$ and $H_q$ is constant for every $x>1$, the tail theorem gives $q=c$ on $Y>1/2$; on $(1/2,1)$ it is also zero, so $c=0$ and $q=0$ almost everywhere. Thus a nonzero base mixture using only $Y\ge1$ cannot remove the linear term algebraically over all actual-source scales $x>1$. The constant ordinary base weight necessarily uses subunit bases for $1<x<2$.

These rigidity statements do not bound the unrestricted first-window score. They only identify which base averages turn the exact Stieltjes integration by parts into a pure negative ground entropy by a source-independent algebraic mechanism. This is a written proof, not a Lean formalization.
