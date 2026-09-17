# An integrated entropy balance for the actual first-window source

The complete actual first-window score has a finite
weighted balance with a nonnegative quadratic gap. The balance gives
an unconditional lower bound for that gap along a sequence of
windows. It does not bound the boundary flux at RH scale.

Fix $p_s>0$ and use the actual von Mangoldt coefficients throughout:
$$
E(x)=\psi(x)-x,\qquad
F(x)=\log x-\sum_{n\le x}\frac{\Lambda(n)}n+\frac{\psi(x)}x,
$$
$$
B_s(Y)=\int_{[Y,2Y)}
  \frac{p_s^2Y\log^2(x/Y)}{x^2F(x)}\,dE(x).
$$
Put $L=\log2$, $H(t)=t^2e^{-t}$,
$a=H(L)=L^2/2$, and $b(t)=H'(t)-H(t)=2t(1-t)e^{-t}$.
Thus $b\ge0$ on $[0,L]$. For $v>0$, write
$$
r(v)=\frac{E(e^v)}{e^vF(e^v)},\qquad
R(v)=e^v r(v)=\frac{E(e^v)}{F(e^v)}.
$$
Define the boundary flux
$$
G(v)=\int_0^L b(t)e^{L-t}
          \int_{v-L+t}^{v}R(w)\,dw\,dt.                 \tag{1}
$$

**Theorem.** For all sufficiently large real $V<W$, the exact identity
$$
\begin{aligned}
G(W)-G(V)
 -\frac1{p_s^2}\int_V^W e^v B_s(e^{v-L})\,dv
={}&\int_0^L H(t)e^{L-t}
   \int_{V-L+t}^{W-L+t}e^w r(w)^2\,dw\,dt
\ge{}&0.                                                   \tag{2}
\end{aligned}
$$
If $W-V\ge L$, its right side is at least
$$
H_1\int_{e^V}^{e^{W-L}}\frac{E(x)^2}{x^2F(x)^2}\,dx,
\qquad
H_1=\int_0^L H(t)e^{L-t}dt
=\frac38-\frac{L^2+L}{4}>0.                            \tag{3}
$$
Thus the integrated actual source lies below its boundary flux by
at least the energy in (3). The boundary term is linear in $E$ and
has no asserted sign.

The half-open endpoint in $B_s$ matters pointwise. Distributionally,
since $F'(x)=-E(x)/x^2$ away from prime-power atoms and $F$ is
continuous through them,
$$
\frac{dE(x)}{xF(x)}=dr(v)+(r(v)-r(v)^2)dv,
\qquad x=e^v.
$$
Stieltjes integration by parts on $[Y,2Y)$ gives, with $u=\log Y$,
$$
\frac{B_s(e^u)}{p_s^2}
=a r((u+L)^-)
 -\int_0^L b(t)r(u+t)dt
 -\int_0^L H(t)r(u+t)^2dt.                           \tag{4}
$$
The lower endpoint vanishes because $H(0)=0$; $2Y$ is excluded, so
the upper value is the left limit. When (4) is integrated in $v=u+L$,
the countable set of prime-power endpoint values has Lebesgue measure
zero. Multiply (4) by $e^v$ and integrate over $V\le v\le W$.
For $h=L-t$,
$$
\int_V^W e^v r(v-h)dv
=e^h\int_{V-h}^{W-h}R(w)dw,
$$
and the same change of variables sends the quadratic term to
$e^h\int_{V-h}^{W-h}e^w r(w)^2dw$. Integration by parts in $t$ gives
$$
\int_0^L b(t)e^{L-t}dt=a.                              \tag{5}
$$
Subtracting the shifted linear integral from
$a\int_V^W R(w)dw$ leaves
$$
\int_0^L b(t)e^{L-t}
 \left(\int_{W-L+t}^{W}R(w)dw
       -\int_{V-L+t}^{V}R(w)dw\right)dt
=G(W)-G(V),
$$
which proves the equality in (2). For every $h\in[0,L]$,
$[V,W-L]\subseteq[V-h,W-h]$ when $W-V\ge L$.
Multiplying this interval inclusion by the positive kernel proves
(3), since $e^wr(w)^2dw=E(x)^2dx/(x^2F(x)^2)$.

There is a quantitative unconditional consequence. Littlewood's
$E(x)=\Omega_-(x^{1/2}\log\log\log x)$ supplies arbitrarily large
$x_j$ and a constant $c>0$ such that
$$
A_j:=-E(x_j)\ge c x_j^{1/2}\log\log\log x_j.
$$
Because $\psi$ is nondecreasing, for
$x_j-A_j/2\le x\le x_j$ we have
$E(x)\le E(x_j)+(x_j-x)\le-A_j/2$. Also $A_j=o(x_j)$ by PNT and
$F$ is bounded above on a tail. Therefore
$$
\int_{x_j-A_j/2}^{x_j}
 \frac{E(x)^2}{x^2F(x)^2}dx
\ge c_1\frac{A_j^3}{x_j^2}
\gg x_j^{-1/2}(\log\log\log x_j)^3.                 \tag{6}
$$
Take $V_j=\log(x_j-A_j/2)$ and $W_j=\log(2x_j)$.
Then $W_j-V_j>L$, $e^{W_j-L}=x_j$, and (2)--(3) give
$$
G(W_j)-G(V_j)
 -\frac1{p_s^2}\int_{V_j}^{W_j}
        e^v B_s(e^{v-L})dv
\gg x_j^{-1/2}(\log\log\log x_j)^3.                 \tag{7}
$$
This lower bound concerns the *difference* between boundary flux and
integrated score. It does not give either term a sign on its own.

The flux can also be written without log coordinates:
$$
G(\log z)=\int_0^L b(t)e^{L-t}
 \int_{ze^{-(L-t)}}^z\frac{E(x)}{xF(x)}\,dx\,dt.      \tag{8}
$$
It is a local first moment of the actual prime error. Its absolute
size is bounded by classical PNT error, but (2) alone gives no
RH-scale control of $G(W)-G(V)$. Any attempt to discard it must
prove signed arithmetic cancellation for this first moment.

For the Littlewood input in (6), see Montgomery and Vaughan,
[*Multiplicative Number Theory I*, Chapter 15, Theorem 15.11](https://personal.science.psu.edu/rcv4/personal/Publications/MNTI/19.0_pp_463_485_Oscillations_of_error_terms.pdf).
