# A one-sided sign obstruction for the actual first-window score

This note gives an unconditional sign constraint on the
complete first-window score. It does not bound that score at RH scale.

Fix $p_s>0$. Write
$$
E(x)=\psi(x)-x,\qquad
F(x)=\log x-\sum_{n\le x}\frac{\Lambda(n)}n+\frac{\psi(x)}x,
$$
and use the literal half-open window
$$
B_s(Y)=\int_{[Y,2Y)}
 \frac{p_s^2Y\log^2(x/Y)}{x^2F(x)}\,dE(x).
$$
Here $F$ is continuous and positive for $x>1$, and $F(x)\to\kappa_F>0$.

**Theorem.** Unconditionally,
$$
B_s(Y)=\Omega_-\!\left(Y^{-1/2}\log\log\log Y\right).          \tag{A}
$$
In particular, $B_s(Y)<0$ for arbitrarily large $Y$. An eventual
nonnegative lower bound for the actual score cannot supply the missing
coupled estimate.

Set $u=\log Y$, $L=\log 2$, and
$$
r(v)=\frac{E(e^v)}{e^vF(e^v)},\quad
H(t)=t^2e^{-t},\quad a=H(L)=\frac{L^2}{2},\quad
b(t)=H'(t)-H(t)=2t(1-t)e^{-t}.
$$
Since $0<L<1$, $b(t)\ge0$ on $[0,L]$. The ground identity
$F'(x)=-E(x)/x^2$ holds away from prime-power atoms. Distributionally,
with $dE$ retaining its atoms,
$$
\frac{dE(x)}{xF(x)}=dr(v)+\bigl(r(v)-r(v)^2\bigr)\,dv,
\qquad x=e^v.                                                    \tag{1}
$$
Indeed $E=xFr$, while $d(xF)=F(1-r)\,dx$ and $F$ is continuous at
the atoms. The weight in $B_s$ equals $p_s^2H(v-u)/(xF(x))$.
Stieltjes integration by parts on $[u,u+L)$ therefore gives the exact
Volterra identity
$$
\frac{B_s(e^u)}{p_s^2}
=a\,r((u+L)^-)
 -\int_0^L b(t)r(u+t)\,dt
 -\int_0^L H(t)r(u+t)^2\,dt.                              \tag{2}
$$
The lower boundary vanishes because $H(0)=0$. The upper boundary is
the left limit because $2Y$ is excluded. At a prime-power atom $x$,
$r(\log x)-r((\log x)^-)=\Lambda(x)/(xF(x))>0$.

Suppose $B_s(Y)\ge0$ for every $Y\ge Y_0$. Write
$n(v)=\max\{0,-r(v)\}$. Equation (2), evaluated at $u=v-L$, and
the nonnegative quadratic term imply
$$
n(v^-)\le\frac1a\int_0^L b(t)n(v-L+t)\,dt
\qquad(v\ge\log Y_0+L).                                      \tag{3}
$$
The upward atomic jumps also give $n(v)\le n(v^-)$. For any
$0<\delta<1$, the weighted operator in (3) has norm
$$
q_\delta=\frac1a\int_0^L b(t)e^{\delta(L-t)}dt
=1-\frac{1-\delta}{a}
       \int_0^L H(t)e^{\delta(L-t)}dt<1.                       \tag{4}
$$
The equality follows by integrating $b=H'-H$ and using $H(0)=0$.
Take the supremum of $e^{\delta v}n(v)$ over a finite half-line.
The initial interval of length $L$ has a finite supremum; (3),
upward jumps, and $q_\delta<1$ show that the supremum never grows
after that interval. Hence
$$
n(v)=O_\delta(e^{-\delta v}),\qquad
E(x)^-=O_\delta(x^{1-\delta}),                              \tag{5}
$$
where $E(x)^-=\max\{0,-E(x)\}$ and $F$ is bounded above and below
on a tail. Taking $\delta=3/4$ contradicts Littlewood's
unconditional $\psi(x)-x=\Omega_-(x^{1/2}\log\log\log x)$.
For a precise printed statement, see Montgomery and Vaughan,
[*Multiplicative Number Theory I*, Chapter 15, Theorem 15.11](https://personal.science.psu.edu/rcv4/personal/Publications/MNTI/19.0_pp_463_485_Oscillations_of_error_terms.pdf).
Thus the supposition fails.

For the stated amplitude, let
$g(v)=e^{-v/2}\log\log v$ for large $v$. If (A) failed, then
$B_s(e^{v-L})^-=o(g(v))$, where the superscript minus denotes the
negative part. The same argument leading to (3) gives
$$
n(v)\le (Kn)(v)+f(v),\qquad
(Kn)(v)=\frac1a\int_0^L b(t)n(v-L+t)dt,
\quad f(v)=\frac{B_s(e^{v-L})^-}{ap_s^2}=o(g(v)).           \tag{6}
$$
Uniform slow variation of $\log\log v$ on intervals of length $L$
shows $(Kg)(v)/g(v)\to q_{1/2}<1$. Fix $q'$ strictly between
$q_{1/2}$ and $1$, and choose $V$ so that $Kg\le q'g$ and
$f\le\eta g$ for $v\ge V$, for any prescribed $\eta>0$. Choose
$\delta'\in(1/2,1)$. Equation (4) gives
$K(e^{-\delta'v})=q_{\delta'}e^{-\delta'v}$ with
$q_{\delta'}<1$. A sufficiently large $A$ makes
$$
w(v)=A e^{-\delta'v}+\frac{\eta}{1-q'}g(v)
$$
dominate $n$ on $[V,V+L]$. For all later $v$, $w-Kw\ge\eta g\ge f$;
the positive Volterra kernel and interval-by-interval comparison give
$n(v)\le w(v)$. Divide by $g(v)$, let $v\to\infty$, and then let
$\eta\downarrow0$. It follows that
$n(v)=o(e^{-v/2}\log\log v)$, contradicting the cited
Littlewood $\Omega_-$ theorem. This proves (A).

The sign argument is one-sided. If $B_s\le0$, the $r^2$ term in (2)
can support a positive $r$; the same comparison does not give a
positive-side bound for $E$.

## Why positivity and prime-power support alone do not suffice

The arithmetic values of $\Lambda$ matter. To see this, take a small
fixed $c>0$ and replace its values, but not its support, by
$$
\Lambda_c(n)=\Lambda(n)\left(1+\frac{c}{\log^2n}\right)
\quad(n\ge2),\qquad \Lambda_c(1)=0.
$$
Define $\psi_c,E_c,F_c$ by the same formulas as above and let
$B_{c,s}$ use $F_c$ and $dE_c$. Classical PNT with its zero-free-region
error and partial summation give
$$
E_c(x)=E(x)+c\sum_{n\le x}\frac{\Lambda(n)}{\log^2n}
\sim\frac{cx}{\log^2x}.                                     \tag{7}
$$
Also
$$
F_c(x)=F(x)-c\sum_{n\le x}\frac{\Lambda(n)}{n\log^2n}
       +\frac c x\sum_{n\le x}\frac{\Lambda(n)}{\log^2n}.
$$
The first new sum converges at infinity and the second term is
bounded. Since $F$ has a positive infimum on $[2,\infty)$, a small
enough $c$ makes $F_c>0$ there; on $(1,2)$ it equals $\log x$.
The limit $\kappa_c=\lim_{x\to\infty}F_c(x)$ is positive. The same
atom cancellation gives $F_c'=-E_c/x^2$ almost everywhere.

Put $\phi_Y(x)=p_s^2Y\log^2(x/Y)/(x^2F_c(x))$ on $[Y,2Y)$ and
$$
C_0=\int_1^2\frac{\log^2t}{t^2}\,dt>0.
$$
Uniformly on that window, (7) yields
$E_c(x)=cx/\log^2Y+o(Y/\log^2Y)$. Moreover
$\|\phi_Y\|_\infty+\operatorname{Var}_{[Y,2Y]}\phi_Y=O(1/Y)$;
this follows from $F_c\to\kappa_c$ and
$F_c'=-E_c/x^2=O(1/(x\log^2x))$ there. Stieltjes integration by
parts, including the left limit at $2Y$, now shows that replacing
$dE_c$ with $c\,dx/\log^2Y$ changes $B_{c,s}(Y)$ by
$o(\log^{-2}Y)$. Consequently
$$
B_{c,s}(Y)\sim
\frac{cp_s^2C_0}{\kappa_c\log^2Y}>0.                  \tag{8}
$$
Thus positive prime-power coefficients, their support, the continuous
factorial ground, and PNT do not force even a fixed-power bound for
the complete score. Any such bound for the actual $\Lambda$ must use
more of its arithmetic structure.
