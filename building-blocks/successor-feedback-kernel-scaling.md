# Scaling the actual successor coefficients, with the endpoint constant

Use the exact coefficients $E(r)=\sum_{n\ge2}\Lambda(n)W_r(n)$
from [the arithmetic kernel proof](successor-feedback-arithmetic-kernel.md).
Put $h=1-r$, $0<h\le1/2$. All estimates below have absolute
constants, unless explicitly stated otherwise.

## 1. The signed scaling kernel

Define
$$
 \Phi(t,x)=
 \begin{cases}
 x^{-1/2}\arcsin\sqrt{x/t},&0<x<t,\\
 \pi/(2\sqrt x),&x\ge t,
 \end{cases}
 \qquad \Phi(t,0)=t^{-1/2},
$$
$$
 K(t)=\int_0^\infty e^{-x}\Phi(t,x)\,dx-t^{-1/2},
 \qquad E_1(t)=\int_t^\infty e^{-x}\frac{dx}{x}.
 \tag{1}
$$
The two expressions for $\Phi$ agree at $x=t$. An equivalent
description, useful for its signs, is
$$
 b(t)=\int_0^t\frac{e^{-x}}{\sqrt{t-x}}\,dx-\frac1{\sqrt t}
 =2D(\sqrt t)-\frac1{\sqrt t},\qquad
 D(z)=e^{-z^2}\int_0^z e^{v^2}\,dv,
$$
$$
 K'(t)=-\frac{b(t)}{2t},\qquad
 K(t)=\frac12\int_t^\infty\frac{b(v)}v\,dv.
 \tag{2}
$$
Differentiation of (1), including its matching moving boundary,
proves the first identity. The second follows from $K(\infty)=0$.

The endpoint expansions are
$$
 \begin{aligned}
 K(t)&=-t^{-1/2}+\frac{\pi^{3/2}}2+O(\sqrt t)
 &&(t\downarrow0),\\
 b(t)&=\frac1{2t^{3/2}}+O(t^{-5/2}),\qquad
 K(t)=\frac1{6t^{3/2}}+O(t^{-5/2})
 &&(t\to\infty).
 \end{aligned}
 \tag{3}
$$
For the large-$t$ estimate, expand $(t-x)^{-1/2}$ on
$x\le t/2$ and bound the other half by its exponential weight.
The omitted exponential tail of the subtracted constant is included.

There is exactly one sign crossing of $K$. To see this without a
numerical zero count, $D'=1-2zD$ starts positive, and (3) makes it
negative for sufficiently large $z$. At every zero of $D'$,
$D''=-2D<0$. Thus there is just one such zero $z_*$.
Consequently $b$ is negative below $z_*^2$ and positive above it.
By (2), $K$ first increases and then decreases. Its negative initial
limit and positive final asymptotic imply a unique zero
$t_0\in(0,z_*^2)$, with
$$
 K(t)<0\ (0<t<t_0),\qquad K(t)>0\ (t>t_0).
 \tag{4}
$$

## 2. Density cancellation and a nonzero logarithmic moment

Both $K$ and $K\log t$ are integrable. Their exact moments are
$$
 \boxed{\int_0^\infty K(t)\,dt=0,\qquad
 \int_0^\infty K(t)\log t\,dt=\frac{\pi^{3/2}}2.}
 \tag{5}
$$
Here is an elementary calculation retaining the endpoint cancellation.
For $x>0$ put
$b_x(t)=\mathbf1_{t>x}(t-x)^{-1/2}-t^{-1/2}$.
Its integral is zero; its cumulative is
$2\sqrt{(t-x)_+}-2\sqrt t$. Integration by parts gives
$$
 \int_0^\infty b_x(t)\log t\,dt
 =2\int_0^\infty\frac{\sqrt t-\sqrt{(t-x)_+}}t\,dt
 =2\pi\sqrt x.
 \tag{6}
$$
For the last equality, scale by $x$. The integral on $(0,1)$
is 2; on $(1,\infty)$, substitute $v=\sqrt{t-1}$ to obtain
$\pi-2$. Averaging (6) with $e^{-x}dx$ gives
$\int b=0$ and $\int b\log t=\pi^{3/2}$.
The exchanges are absolute: after scaling, the absolute integral
with the logarithm is bounded by
$C\sqrt x(1+|\log x|)$, which is exponentially integrable.
Finally integrate $K'=-b/(2t)$ against $t$ and
$t(\log t-1)$; (3) removes both boundary terms. This proves (5).

In particular, for the actual logarithm readout the continuous identity is
$$
 \int_0^\infty K(hx)\log x\,dx
 =\frac{\pi^{3/2}}{2h}.
 \tag{7}
$$
The scale-dependent constant $-\log h$ cancels by the first moment
in (5). Equation (7) is a signed identity, not an estimate obtained
by replacing the kernel or divisor coefficients by their absolute values.

## 3. A global error estimate, strong enough for the actual prime sum

Let $g_0(t)=t^{-1/2}/(1+t)$. For every integer $n\ge2$,
$$
 \boxed{\left|W_{1-h}(n)-\sqrt h K(hn)+hE_1(hn)\right|
 \le C\left[h^{3/2}g_0(hn)+
 \frac{h^2e^{-hn/2}}{hn}\right].}
 \tag{8}
$$
This gives, in particular, the two-term scaling expansion uniformly
when $hn$ ranges in any fixed compact subset of $(0,\infty)$.
It also controls both ends of the infinite arithmetic sum.

To prove (8), set $t=hn$ and
$\Psi(t,x)=\Phi(t,x)-t^{-1/2}$. The exact arcsine/arctangent
coefficient formula gives
$$
 W_{1-h}(n)=
 \frac{\sqrt h}{r}\,h\sum_{j\ge0}r^j\Psi(t,hj)
 -\frac h r\sum_{j\ge n}\frac{r^j}{j}
 +O\left(h\sum_{j\ge n}\frac{r^j}{j^2}\right).
 \tag{9}
$$
This uses the elementary, signed expansion
$$
 \frac{\arctan\sqrt j}{\sqrt j}
 =\frac{\pi}{2\sqrt j}-\frac1j+\epsilon_j,\qquad
 0\le\epsilon_j\le\frac1{3j^2}.
 \tag{10}
$$
For $j<n$, the arcsine expression is exact; the correction in
(10) starts at $j=n$, not at a rounded real boundary.

The estimates needed for its Riemann sum are
$$
 \operatorname{Var}_{x\ge0}(e^{-x}\Psi(t,x))
 +\int_0^\infty xe^{-x}|\Psi(t,x)|\,dx
 \le Cg_0(t).
 \tag{11}
$$
For $t\le1$, use the total variation $O(t^{-1/2})$ of
$\Phi(t,\cdot)$, which increases up to $t$ and decreases afterward.
For $t\ge1$, on $x\le t/2$ the arcsine series gives
$|\Psi|\le Cxt^{-3/2}$ and
$|\partial_x\Psi|\le Ct^{-3/2}$.
On $x\ge t/2$, the total variation and supremum are
$O(t^{-1/2})$, while the exponential contributes $e^{-t/2}$.
This also handles the integrable derivative singularity at $x=t$.

The rectangle-rule error is at most $h$ times the variation in
(11). Moreover
$$
 0\le e^{-hj}-r^j\le Ch(hj)e^{-hj},
$$
since $0\le-\log(1-h)-h\le Ch^2$.
Discrete versions of the same split used in (11) control this
replacement error by $Chg_0(t)$. The factor $1/r$ contributes
only $Ch^{3/2}g_0(t)$, because $|K(t)|\le Cg_0(t)$.
Finally the decreasing rectangle sum for $e^{-x}/x$, starting
exactly at $x=hn$, and the same geometric replacement give
$$
 \left|\frac h r\sum_{j\ge n}\frac{r^j}{j}-hE_1(t)\right|
 +h\sum_{j\ge n}\frac{r^j}{j^2}
 \le Ch^2e^{-t/2}/t.
 \tag{12}
$$
Equations (9)--(12) prove (8).

Chebyshev's bound $\psi(x)\ll x$ now implies
$$
 \sum_{n\ge2}\Lambda(n)
 \left|W_{1-h}(n)-\sqrt hK(hn)+hE_1(hn)\right|
 \le C\sqrt h.
 \tag{13}
$$
Indeed $g_0$ is decreasing and integrable, so its weighted sum is
$O(h^{-1})$. The other weighted sum is
$O(h\log(2/h))=O(\sqrt h)$, by partial summation.
No cancellation of prime errors is used in controlling this error.
The principal signed sum itself has not been bounded absolutely.

## 4. The retained arithmetic constant and remainder

Define the exact, positive smoothing of the actual prime count
$$
 I_h=h\sum_{n\ge2}\Lambda(n)E_1(hn)
 =\int_0^\infty e^{-t}\frac{\psi(t/h)}{t/h}\,dt.
 \tag{14}
$$
The ordinary PNT and Chebyshev domination give $I_h\to1$.
More quantitatively, with
$\omega(X)=\sup_{x\ge X}|\psi(x)/x-1|$,
splitting at $t=\sqrt h$ gives
$$
 |I_h-1|\le C\sqrt h+\omega(h^{-1/2}).
 \tag{15}
$$
Consequently the actual all-power coefficient sum has the expansion
$$
 \boxed{E(1-h)=\sqrt h\sum_{n\ge2}\Lambda(n)K(hn)-I_h
 +O(\sqrt h)
 =\sqrt h\sum_{n\ge2}\Lambda(n)K(hn)-1
 +O(\sqrt h+\omega(h^{-1/2})).}
 \tag{16}
$$
The constant $-1$ is essential. It comes from the full arctangent
endpoint correction, not from the leading continuum kernel.

For comparison, the exact coefficient density satisfies
$$
 \int_1^\infty W_r(y)\,dy
 =-W_r(1)=\frac{1-hQ(r)}r\longrightarrow1.
 \tag{17}
$$
Here $W_r(y)$ denotes its defining tail integral at real $y$;
Fubini uses $\int w_r=0$. The leading continuous term alone would
give
$$
 \int_1^\infty\sqrt hK(hy)\,dy
 =-\frac1{\sqrt h}\int_0^hK(t)\,dt=2+O(\sqrt h).
 \tag{18}
$$
The omitted second term has integral
$-\int_h^\infty E_1(t)\,dt=-1+o(1)$.
Thus retaining only a pointwise scaling limit loses the collective
endpoint constant.

There is also an exact signed prime-error representation for the
principal term. Extend $\psi(x)=0$ on $0<x<1$ and put
$R(x)=\psi(x)-x$. Since the density moment in (5) is zero,
Stieltjes integration by parts gives
$$
 \boxed{\sqrt h\sum_{n\ge2}\Lambda(n)K(hn)
 =\frac{\sqrt h}{2}\int_0^\infty\frac{R(x)}x b(hx)\,dx.}
 \tag{19}
$$
Both boundaries vanish: at zero $R(x)=-x$, and at infinity
Chebyshev's bound together with (3) suffices.
The explicit initial interval contributes
$$
 -\frac1{2\sqrt h}\int_0^h b(t)\,dt=1+O(h).
 \tag{20}
$$
Therefore (16) can equivalently be kept in the fully signed form
$$
 E(1-h)=\frac{\sqrt h}{2}\int_1^\infty g(x)b(hx)\,dx
 -(I_h-1)+O(\sqrt h).
 \tag{21}
$$
This formula keeps the initial density, the exact smoothing correction,
all prime-power births, and the sign change of the rescaled kernel.

Equations (4), (5), and (16) sharpen the moving finite-negative-region
description: its limit has one crossing, exactly cancelling density,
and a specified logarithmic moment. The arithmetic task is now the
signed combination in (16) or (21), with its endpoint constant;
positivity of the older factorial cumulative alone still does not
sign this combination. No eventual sign or RH conclusion is proved.

The kernel $K$ is the same $k$ whose Mellin multiplier is evaluated in [the continuous-shift proof](actual-Abel-feedback-Mellin-kernel.md). This chapter retains a distinct real-variable moment and one-crossing proof, and its stronger uniform coefficient error keeps the entire arithmetic endpoint correction when summed.

This chapter contains written proofs and applications of the stated classical inputs. No Lean formalization of its scaling, moment or signed-core conclusion is asserted, and no unconditional boundary sign for the actual feedback is claimed.
