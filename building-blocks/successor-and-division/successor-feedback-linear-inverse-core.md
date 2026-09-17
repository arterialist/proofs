# A linear moving exterior for the actual division-inverted feedback

Let $h=1-r$, and retain the exact coefficients and division inversion
$$
 E(r)=\sum_{n\ge2}\Lambda(n)W_r(n)
 =\sum_{m\ge2}\varphi_r(m)\log m,\qquad
 \varphi_r(m)=\sum_{k\ge1}\mu(k)W_r(km).
 \tag{1}
$$
The coefficients come from [the actual arithmetic kernel](successor-feedback-arithmetic-kernel.md).
For each fixed parameter, its bound $W_r(n)=O_r(n^{-3/2})$
makes the double sum over $k,m$ absolutely convergent even with
the factor $\log m$. Regrouping by $n=km$ gives
$$
\sum_{k\mid n}\mu(k)\log(n/k)=\Lambda(n),
$$
which proves the second equality in (1), including every proper
power. The terminal state $m=1$ has zero logarithmic readout.
No finite-core coefficient is changed.

There are absolute constants $T\ge2$ and $h_0>0$ such that
$$
 \boxed{\varphi_{1-h}(m)\ge
 \frac{1}{12\zeta(3/2)\,h\,m^{3/2}}
 \quad\left(0<h\le h_0,\quad m\ge\left\lceil T/h\right\rceil\right).}
 \tag{2}
$$
Thus its positive exterior starts at $O((1-r)^{-1})$, rather than
the previously available $O((1-r)^{-1}\log(1/(1-r)))$ threshold.
This also gives an exact lower logarithmic mass and forces a negative
signed contribution from the moving core. It does not decide $E(r)$.

## 1. Inverting the two-term scaling formula

Use $K,E_1$ from
[the uniform scaling proof](successor-feedback-kernel-scaling.md).
Choose finite absolute constants $C_E,C_K>0$ for its bounds
$$
 |W_{1-h}(n)-\sqrt hK(hn)+hE_1(hn)|
 \le C_E\left[
 \frac{h^{3/2}}{\sqrt{hn}(1+hn)}
 +\frac{h^2e^{-hn/2}}{hn}\right],
 \quad n\ge2,\quad 0<h\le1/2,
 \tag{3}
$$
$$
 \left|K(t)-\frac1{6t^{3/2}}\right|
 \le C_Kt^{-5/2}\quad(t\ge1).
 \tag{4}
$$
The scaling proof establishes both constants independently of any
arithmetic cutoff. The large-$t$ expansion proves (4) initially
past an absolute threshold; continuity on the remaining compact
interval enlarges $C_K$ to give the displayed range.

Set $t=hm\ge1$, and define the absolutely convergent signed sums
$$
 J(t)=\sum_{k\ge1}\mu(k)K(kt),\qquad
 L(t)=\sum_{k\ge1}\mu(k)E_1(kt).
 \tag{5}
$$
Summing (3) at the actual integers $n=km$ gives
$$
 \varphi_{1-h}(m)=\sqrt hJ(t)-hL(t)+R_h(t),
 \tag{6}
$$
$$
 |R_h(t)|\le C_E\left[
 h^{3/2}\zeta(3/2)t^{-3/2}
 +\frac{h^2e^{-t/2}}{t(1-e^{-t/2})}\right].
 \tag{7}
$$
Here the harmless factors $1/k$ in the second sum were bounded by
one. Every $k$, and thus the complete divisor inversion, remains.

The leading Euler-product cancellation is used before an error bound:
$$
 J(t)=\frac{1}{6\zeta(3/2)t^{3/2}}+R_J(t),\qquad
 |R_J(t)|\le C_K\zeta(5/2)t^{-5/2}.
 \tag{8}
$$
This follows from $\sum\mu(k)k^{-3/2}=1/\zeta(3/2)$, in the
ordinary absolutely convergent half-plane. In particular, no
estimate for a summatory Möbius error, and no RH assumption, is used.
The endpoint correction in (6) is retained explicitly. The bound
$$
 |L(t)|\le\frac{e^{-t}}{t(1-e^{-t})}
 \tag{9}
$$
follows from $E_1(u)\le e^{-u}/u$; it is used only to control this
exponentially small correction in the positive exterior.

Writing $z=\zeta(3/2)$, equations (6)--(9) yield
$$
 \frac{\varphi_{1-h}(m)}{\sqrt h\,t^{-3/2}}
 \ge \frac1{6z}
 -\frac{C_K\zeta(5/2)}t
 -\frac{\sqrt h\,\sqrt t\,e^{-t}}{1-e^{-t}}
 -C_Ehz
 -\frac{C_Eh^{3/2}\sqrt t\,e^{-t/2}}{1-e^{-t/2}}.
 \tag{10}
$$

For clarity, the constants in (2) may be chosen by the following
explicit rules in terms of the already proved $C_E,C_K$:
$$
 h_0=\min\left(\frac12,\frac1{48C_Ez^2}\right),
 \tag{11}
$$
and choose any $T\ge2$ satisfying
$$
 T\ge48zC_K\zeta(5/2),\qquad
 \frac{\sqrt T e^{-T}}{1-e^{-T}}\le\frac1{48z},\qquad
 \frac{C_E\sqrt T e^{-T/2}}{1-e^{-T/2}}\le\frac1{48z}.
 \tag{12}
$$
Such an absolute $T$ exists. The last two functions decrease for
$t\ge2$. Each of the four errors in (10) is then at most
$1/(48z)$, so the right side is at least $1/(12z)$.
Finally $\sqrt h\,t^{-3/2}=1/(hm^{3/2})$, proving (2).
These choices give controlled existential constants, not a numerical
cutoff whose constants were left uncertified.

## 2. Logarithmic exterior mass

Put $M_h=\lceil T/h\rceil$. The function
$\log x\,x^{-3/2}$ is decreasing for $x\ge2$; therefore
$$
 \begin{aligned}
 \mathcal L_{\rm ext}(h)
 &:=\sum_{m\ge M_h}\varphi_{1-h}(m)\log m\\
 &\ge\frac1{12zh}\sum_{m\ge M_h}\frac{\log m}{m^{3/2}}\\
 &\ge\boxed{\frac{2\log M_h+4}{12zh\sqrt{M_h}}}.
 \end{aligned}
 \tag{13}
$$
In particular,
$$
 \liminf_{h\downarrow0}
 \frac{\sqrt h\,\mathcal L_{\rm ext}(h)}{\log(1/h)}
 \ge\frac1{6z\sqrt T}>0.
 \tag{14}
$$
All sums in (13) are the actual signed division-inverted coefficients;
their positivity follows only after the exterior estimate (2).

## 3. A forced negative moving core, without deciding the total

There is an unconditional normalization constraint on this large
positive exterior. The exact physical kernel satisfies
$$
 E(1-h)=\frac1{2r}\int_1^\infty g(y)w_r(y)\,dy,\quad
 \|w_r\|_1\le4h^{-1/2},\quad
 \int_1^L|w_r(y)|\,dy\le4\sqrt L.
 \tag{15}
$$
Since $g(y)=\psi(y)/y-1\to0$ by the ordinary PNT and $g$ is
bounded, split the integral at a fixed $L$. The initial piece,
multiplied by $\sqrt h$, tends to zero; the other piece is bounded
by a constant times $\sup_{y\ge L}|g(y)|$. Letting $L\to\infty$
proves
$$
 \boxed{E(1-h)=o(h^{-1/2}).}
 \tag{16}
$$
Only this normalization statement uses PNT; exterior positivity (2)
does not.
For the logarithmic comparison below, even the weaker
$E(1-h)=O(h^{-1/2})$ from bounded $g$ suffices. That weaker
bound follows from Chebyshev's estimate alone.

Now retain the exact logarithmic readout (1). Its moving core is
$$
 \mathcal L_{\rm core}(h)
 :=\sum_{2\le m<M_h}\varphi_{1-h}(m)\log m
 =E(1-h)-\mathcal L_{\rm ext}(h).
 \tag{17}
$$
Combining (14) and (16) gives the substantive signed conclusion
$$
 \boxed{\limsup_{h\downarrow0}
 \frac{\sqrt h\,\mathcal L_{\rm core}(h)}{\log(1/h)}
 \le-\frac1{6z\sqrt T}<0.}
 \tag{18}
$$
Consequently, for every sufficiently small $h$, at least one actual
nonterminal coefficient with $2\le m<M_h$ is negative. More
quantitatively its negative logarithmic mass is at least
$$
 \sum_{2\le m<M_h}[\varphi_{1-h}(m)]_-\log m
 \ge\frac{\log(1/h)}{12z\sqrt T\,\sqrt h}
 \tag{19}
$$
for all sufficiently small $h$.
This leaves the negative terminal coefficient at $m=1$ untouched:
that coefficient has zero logarithmic readout and cannot provide
the cancellation in (18).

Thus the positive division-resolved cone valid near $r=0$ cannot
remain positive at every nonterminal state near $r=1$.
The conclusion concerns a moving state, not eventual sign failure
at any one fixed $m$. Both the positive exterior and the signed
negative core are much larger than their total at this normalization.
Their finer difference, which is the actual $E(r)$, remains
uncontrolled; neither a sign for it nor RH follows.

This sharpens the explicit all-parameter exterior of [the constructive division proof](../factorial-and-renewal/actual-Abel-factorial-division-positivity.md). It disproves nonterminal positivity throughout a final parameter interval by producing a moving negative state. It does not disprove eventual positivity for any specified fixed state or for the complete signed feedback.

This chapter contains written proofs and applications of the stated classical inputs. No Lean formalization of its scaling, moment or signed-core conclusion is asserted, and no unconditional boundary sign for the actual feedback is claimed.
