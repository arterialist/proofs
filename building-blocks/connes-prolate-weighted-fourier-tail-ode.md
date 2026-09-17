# The prolate ODE upgrades fixed-index leakage to a smoothed weighted tail

The [two-vector Weil min--max reduction](connes-weil-two-vector-tail-minmax.md)
needs a weighted Fourier bound $D_M(h_i)$ for its two exact
$\mathcal S_0$ prolate triples. Ordinary $L^2$ concentration leakage
does **not** imply that bound for a zero-extended prolate: its nonzero
endpoint values give a $1/v$ Fourier tail and hence $D_M=\infty$
for every $M>1$. The prolate differential equation supplies the
missing pointwise control, and an endpoint cutoff removes that jump.
This note proves the resulting bound for a specified Gevrey cutoff.
It concerns the two *smoothed radical vectors*, not Connes's
two-mode $k_\lambda$.

## Uniform theorem for a fixed prolate span

Let $c=2\pi\lambda^2$ and let $\psi_{j,c}$ be real,
$L^2(-1,1)$-normalized prolate eigenfunctions of fixed even orders
$j$ in a finite set $J$. They satisfy

\[
 L_c\psi_{j,c}:=-((1-t^2)\psi'_{j,c})'+c^2t^2\psi_{j,c}
     =\kappa_j(c)\psi_{j,c},
 \qquad
 F_j(y):=\int_{-1}^1\psi_{j,c}(t)e^{icty}\,dt
       =\frac{\chi_j(c)}{\lambda}\psi_{j,c}(y)
       \quad(|y|<1).
                                                               \tag{1}
\]

The sign of $\chi_j$ is allowed to be negative. With the unitary
physical Fourier convention in the earlier note,
$0<\chi_j^2<1$. For fixed $j$, the classical
[Fuchs fixed-index concentration asymptotic](https://doi.org/10.1016/0022-247X(64)90017-4)
implies, for some $A_j,C_j$ and all sufficiently large $c$,

\[
 1-\chi_j(c)^2\le C_jc^{A_j}e^{-2c},\qquad
 |\chi_j(c)|\ge\tfrac12,\qquad 0\le\kappa_j(c)<c^2.
                                                               \tag{2}
\]

The last inequality also follows from the fixed-index asymptotic
$\kappa_j=(2j+1)c+O_j(1)$; only eventual strictness is used.
Fuchs's interval half-width parameter is this $c$: his sinc kernel
on $[-c,c]$ becomes the concentration kernel on $[-1,1]$ after
scaling the spatial variable by $c$.

Let $P_c=\sum_{j\in J}d_j\psi_{j,c}$ with
$\sum|d_j|^2=1$, $P_c(0)=0$, and $\int_{-1}^1P_c=0$.
Choose a fixed even compactly supported Gevrey-2 function $b_0$ in
the *physical* variable with
$\operatorname{supp}b_0\subset(-1/4,1/4)$, $b_0(0)=0$, and
$\int b_0=1$. In the scaled variable put
$b_c(t)=\lambda b_0(\lambda t)$, so $\int b_c=1$.
For $\eta=(100c^2)^{-1}$ choose an even Gevrey-2 cutoff $\rho_c$
equal to $1$ on $|t|\le1-2\eta$ and zero on
$|t|\ge1-\eta$, with

\[
 \|\rho_c^{(r)}\|_\infty
     \le (C/\eta)^r(r!)^2\quad(r\ge0).                 \tag{3}
\]

Such cutoffs follow by scaling a fixed Gevrey-2 transition. Define
one, for example, from $g(s)=e^{-1/s}$ for $s>0$ and $g(s)=0$
for $s\le0$, using $g(s)/(g(s)+g(1-s))$ on $(0,1)$.
An even normalized multiple of $t^2g(1-25t^2)$ supplies $b_0$.
The usual Cauchy estimate for $g$ gives the stated
$C^r(r!)^2$ derivative bounds.

Define

\[
 H_c(t)=\rho_c(t)P_c(t)
       -\left(\int_{-1}^1\rho_c(s)P_c(s)\,ds\right)b_c(t),
 \qquad h_\lambda(v)=\lambda^{-1/2}H_c(v/\lambda).
                                                               \tag{4}
\]

Then $h_\lambda$ is even, smooth, supported strictly inside
$(-\lambda,\lambda)$, and satisfies $h_\lambda(0)=0$ and
$\int h_\lambda=0$. Its correction term is precisely
$(\int\rho_\lambda h^{\rm raw})b_0$ in the physical-variable
construction of the two-vector reduction. For every fixed real $M>1$ there are
$C_{J,M},K_{J,M},c_{J,M}$ such that, for $c\ge c_{J,M}$,

\[
 \boxed{D_M(h_\lambda):=
   \sup_{v\ge\lambda}(v/\lambda)^M
       (|\widehat h_\lambda(v)|+v|\widehat h_\lambda'(v)|)
   \le C_{J,M}c^{K_{J,M}}e^{-c}.}                   \tag{5}
\]

The constants are uniform in the unit coefficient vector $d$.
In particular (5) applies to the normalized exact triples of
orders $(0,4,8)$ and $(2,6,10)$ in the two-vector reduction.
The cutoff in (4) is a quantitative choice within that reduction's
allowed class; an arbitrary unspecified smooth cutoff need not
satisfy (5).

## The exterior ODE and the band-edge value

Integration by parts in (1) has no boundary term because
$(1-t^2)\psi'_{j,c}$ and $(1-t^2)\psi_{j,c}$ vanish at $t=\pm1$.
It gives the *same* differential equation for the entire Fourier
transform, including $y>1$:

\[
 ((y^2-1)F_j'(y))'
       +(c^2y^2-\kappa_j)F_j(y)=0.                  \tag{6}
\]

For $y\ge1$, put $q=y^2-1$, $V=c^2y^2-\kappa_j>0$, and
$W=q|F_j'|^2+V|F_j|^2$. Equation (6) yields

\[
 \left(\frac{W}{V}\right)'
   =-\left(\frac{q'}V+\frac{qV'}{V^2}\right)|F_j'|^2
   \le0.
\]

Since $q(1)=0$, this proves

\[
 |F_j(y)|\le|F_j(1)|\qquad(y\ge1).               \tag{7}
\]

Integrating (6) once from $1$ shows
$q(y)F_j'(y)=-\int_1^yV(s)F_j(s)ds$. On
$1\le y\le1+(10c^2)^{-1}$, this implies
$|F_j'|\le c^2\sup|F_j|$. The supremum is at most
$(10/9)|F_j(1)|$, so $|F_j(y)|\ge|F_j(1)|/2$ throughout
that short interval. Plancherel and even parity give

\[
 \int_1^\infty|F_j(y)|^2dy
       =\frac{1-\chi_j^2}{2\lambda^2}.
\]

Consequently

\[
 |F_j(1)|\le\frac{\sqrt{20}\,c}{\lambda}
                       \sqrt{1-\chi_j^2},\qquad
 |\psi_{j,c}(1)|\le
       \frac{\sqrt{20}\,c}{|\chi_j|}
                       \sqrt{1-\chi_j^2}.
                                                               \tag{8}
\]

By (2), every endpoint in the fixed span is
$O_J(c^{A}e^{-c})$ for some $A$. A second integration of (1) from
$t$ to $1$ gives

\[
 (1-t^2)\psi'_{j,c}(t)
  =-\int_t^1(c^2s^2-\kappa_j)\psi_{j,c}(s)ds.
\]

On $1-2\eta\le t\le1$ it follows that
$|\psi'_{j,c}(t)|\le c^2\sup_{[1-2\eta,1]}|\psi_{j,c}|$.
Because $2\eta c^2=1/50$, the supremum is at most
$(50/49)|\psi_{j,c}(1)|$. The same holds at $-1$ by parity.
Writing $g_c=(1-\rho_c)P_c$ and
$m_c=\int\rho_cP_c=-\int g_c$, we therefore have

\[
 \|g_c\|_1+|m_c|
       \le C_Jc^{A-2}e^{-c}.                         \tag{9}
\]

For completeness, (6) and (7) also give the crude but sufficient
derivative bound

\[
 |F_j'(y)|
 \le \frac{c^2\int_1^y s^2ds}{y^2-1}|F_j(1)|
 \le c^2y|F_j(1)|\quad(y\ge1),                  \tag{10}
\]

with the endpoint interpreted by continuity.

## Low and high exterior frequencies

Write $\mathcal F_cH(y)=\int H(t)e^{icty}dt$ and let
$Y=A_0c^3$, where $A_0$ is a sufficiently large fixed constant.
For $1\le y\le Y$, decompose
$\mathcal F_cH=\sum d_jF_j-\mathcal F_cg_c-m_c\mathcal F_cb_c$.
The elementary inequalities
$|\mathcal F_cg_c|\le\|g_c\|_1$ and
$|(\mathcal F_cg_c)'|\le c\|g_c\|_1$, with the analogous bounds
for $b_c$, combine with (7), (9), and (10) to give

\[
 \sup_{1\le y\le Y}y^M
   (|\mathcal F_cH(y)|+y|(\mathcal F_cH)'(y)|)
       \le C_{J,M}c^{K_{J,M}}e^{-c}.               \tag{11}
\]

For $y\ge Y$, use smoothness rather than the exterior ODE. The
compressed Fourier relation in (1) and $\|\psi_j\|_1\le\sqrt2$
give, for every integer $r\ge0$,

\[
 \|\psi_{j,c}^{(r)}\|_\infty
       \le C\lambda c^r.
\]

Leibniz's rule, (3), and
$\|b_c^{(r)}\|_1\le(C\lambda)^r(r!)^2$ from the fixed
Gevrey-2 bound for $b_0$ imply,
after increasing $C_1$,

\[
 \|H_c^{(r)}\|_1+\|(tH_c)^{(r)}\|_1
       \le C_J\lambda(C_1c^2)^r(r!)^2.             \tag{12}
\]

There are no boundary terms in integration by parts. Thus

\[
 |\mathcal F_cH(y)|+|\partial_y\mathcal F_cH(y)|
 \le C_J\lambda c\left(\frac{C_1c}{y}\right)^r(r!)^2.
                                                               \tag{13}
\]

Choose $r=\lceil c\rceil+\lceil M\rceil+2$ and
$A_0\ge8e^3C_1$. For large $c$, $r\le2c$, $r>M+1$,
and $r!\le r^r$. The maximum of the weighted right side of
(13) on $y\ge A_0c^3$ occurs at the left endpoint, where

\[
 \left(\frac{C_1cr^2}{A_0c^3}\right)^r
       \le e^{-3r}.
\]

The remaining factors are polynomial in $c$, proving the same
bound as (11), even with $e^{-2c}$ in place of $e^{-c}$, on the high
range. Finally

\[
 \widehat h_\lambda(\lambda y)=\sqrt\lambda\,
       \mathcal F_cH(y),\qquad
 \lambda y\,\widehat h_\lambda'(\lambda y)
       =\sqrt\lambda\,y(\mathcal F_cH)'(y),
\]

so (11)--(13) prove (5).

The proof uses [Fuchs's fixed-index eigenvalue asymptotic](https://doi.org/10.1016/0022-247X(64)90017-4),
the exact finite-Fourier/prolate ODE relation, and a specified
Gevrey smoothing. It supplies the Fourier-tail input in the
two-vector min--max estimate. It does not itself supply that note's
Gram lower bound, an estimate for Connes's separate two-mode
Rayleigh quotient, a positive Weil gap, or RH. These are written
analytic arguments, not Lean formalizations.
