# A positive primitive for the full actual successor resolvent

The failure of the fifth individual primitive does not persist under sufficiently small geometric averaging. For the literal completed source $a$ and the same compensated successor $C$, define
$$
\overline a_r=(1-r)\sum_{k\ge0}r^kC^ka,
\qquad 0<r\le\frac1{32}.
$$
The sum means convergence of the correction to $a$ in causal $L^1$; it does not assign an absolute $L^1$ norm to the completed source itself. We prove
$$
\boxed{\frac{19r}{1100}\vartheta(v)
<\overline P_r(v):=I(\overline a_r-a)(v)
<r\vartheta(v)\quad(v>0),\qquad
\vartheta(v)=e^{-v/2}-e^{-3v/2}.}
\tag{1}
$$
Every iterate is present with its literal positive geometric weight. In particular this is not a convex combination restricted to the two previously positive stages. The entire contribution from stages $j\ge3$, including the certified negative initial part of $P_5$, is bounded rather than discarded.

The arithmetic inputs are the proved [first-primitive bounds](../zeta-and-zeros/actual-W-positive-primitive-analysis.md) and [second-primitive bounds](second-successor-tilted-order.md). The exact renewal representation is imported from [the literal compensated-successor iterates](literal-compensated-successor-iterates.md). The new ingredient is a bounded signed operator on normalized potentials and a quantified interior margin for the actual first primitive. This yields a full reflected-source comparison after the same three integrations used in the existing W consumer.

## 1. Literal renewal and resolvent formulas

All ages are causal. For $x=e^v\ge1$, write
$$
a(v)=\sqrt x\,g_0(x),\quad g_0(x)=\psi(x)/x-1,\quad
a_0(v)=x^{-1/2},\quad
(Sf)(v)=\sqrt{\frac{x}{x+1}}f(\log(x+1)),
$$
$$
Cf=Sf-\kappa(f)a_0,\qquad
\kappa(f)=\frac12\int_0^\infty(Sf-f).
$$
The successor is zero at negative ages. The relative integral, not a difference of separately divergent charges, is used on the completed source. Set $a_j=C^ja$, $\kappa_j=\kappa(a_j)$, and $g_j(x)=x^{-1/2}a_j(\log x)$. Then
$$
g_j(x)=\frac{\psi(x+j)}{x+j}-1
-\sum_{i<j}\frac{\kappa_i}{x+j-1-i}.
\tag{2}
$$
Thus all translations, the density $-1$, and the initial feedback seed remain explicit.

For completeness, the known scalar renewal is
$$
q_0=1,\quad q_j=\frac{\arctan\sqrt j}{\sqrt j}\ (j>0),\quad
d_j=q_j-q_{j+1}>0,
$$
$$
e_j=\kappa(S^ja),\qquad
\kappa_j=e_j+\sum_{i<j}d_{j-1-i}\kappa_i.
\tag{3}
$$
Let $Q(r)=\sum q_jr^j$, $E(r)=\sum e_jr^j$, and $K(r)=\sum\kappa_jr^j$. In the range used here all series converge absolutely, and
$$
K(r)=\frac{E(r)}{(1-r)Q(r)}.
$$
Summing (2) yields the exact normalized resolvent
$$
\boxed{\overline g_r(x)
=(1-r)\sum_{k\ge0}r^k\left[\frac{\psi(x+k)}{x+k}-1\right]
-\frac{rE(r)}{Q(r)}\sum_{l\ge0}\frac{r^l}{x+l}.}
\tag{4}
$$
In particular the density is still exactly $-1$. The last coefficient is the full renewal feedback, not a fitted correction. Its relative charge is $\kappa(\overline a_r)=E(r)/Q(r)$.

The same formulas hold at a fixed natural cutoff $N$, replacing $g_0(x)$ by $g_{0,N}(x)=E_\psi(\min(x,N))/x$ and every driver/charge by its corresponding finite-source value. The terminal $E_\psi(N)/(x+k)$ terms are then retained. The positivity statement (1) below concerns the completed actual source; it is not asserted uniformly over all finite $N$ solely from formula (4).

## 2. Source convergence without putting the completed source in L1

For an arbitrary causal $f\in L^1$, the exact change of variables gives
$$
\|Sf\|_1\le\sqrt2\|f\|_1,
\quad |\kappa(f)|\le\frac{1+\sqrt2}{2}\|f\|_1,
\quad \|Cf\|_1\le(1+2\sqrt2)\|f\|_1<4\|f\|_1.
\tag{5}
$$
Also $\int Cf=\int f$, because $\int a_0=2$. The first actual difference $d_1=(C-I)a$ is in $L^1$, has integral zero, and has the already established positive primitive $P_1$. Therefore
$$
d_j=a_j-a_{j-1}=C^{j-1}d_1,\qquad
\|d_j\|_1\le4^{j-1}\|d_1\|_1,
\quad \int d_j=0.
$$
For $r<1/4$,
$$
\boxed{\overline a_r-a=\sum_{j\ge1}r^jd_j\quad\text{in }L^1,
\qquad \overline P_r=\sum_{j\ge1}r^jP_j,\quad P_j=Id_j.}
\tag{6}
$$
This follows by summing the triangular finite identity $a_k-a=\sum_{j\le k}d_j$; absolute $L^1$ convergence justifies the interchange. The primitive series converges uniformly and has zero endpoints. Relative charges and (3) converge in the same range by (5). Ordinary shifted-source drivers in (4) are well-defined by their convergent relative-charge kernel, as in the fifth-primitive note.

The natural cutoffs are compatible with this construction. In fact
$$
\|d_{1,N}-d_1\|_1\ll\frac{1+\log N}{\sqrt N}.
\tag{7}
$$
Here is an elementary justification, separate from any sign assertion. In physical coordinates put $q_N=g_{0,N}-g_0$, zero below $N$. Above $N$ it equals $[E_\psi(N)-E_\psi(x)]/x$, and its weighted variation satisfies
$$
\int_N^\infty y^{-1/2}|dq_N|(y)
\le\sum_{n>N}\frac{\Lambda(n)}{n^{3/2}}
+\int_N^\infty y^{-3/2}dy
+\int_N^\infty\frac{|E_\psi(N)-E_\psi(y)|}{y^{5/2}}dy
\ll\frac{1+\log N}{\sqrt N}.
$$
Only $\Lambda(n)\le\log n$ and $\psi(y)\le y\log y$ are required. The literal cutoff has no jump in $q_N$ at $N$. Moreover
$$
\int_1^\infty\frac{|q_N(x+1)-q_N(x)|}{\sqrt x}dx
\le\sqrt2\int_N^\infty y^{-1/2}|dq_N|(y).
$$
The charge subtraction costs at most this same difference norm, proving (7). Equations (5)–(6) then give
$$
\| (\overline a_{r,N}-a_N)-(\overline a_r-a)\|_1
\le\frac{r}{1-4r}\|d_{1,N}-d_1\|_1.
\tag{8}
$$
Thus the completed correction is the actual natural-cutoff limit. The sources themselves converge locally (with their completed charge corrections); no global $L^1$ convergence of $a_N$ to $a$ is invoked.

## 3. A bounded signed operator on normalized potentials

For a difference primitive $P$, write $F(x)=\sqrt xP(\log x)$. The exact update with its initial boundary term, derived in [the fifth-primitive note](actual-successor-fifth-primitive-failure.md), is
$$
\begin{aligned}
(TF)(x)={}&F(x+1)-F(2)
+\frac12\int_2^{x+1}\frac{F(y)}{y(y-1)^{3/2}}dy\\
&-\frac{\sqrt x-1}{2}\int_{x+1}^\infty
                         \frac{F(y)}{y(y-1)^{3/2}}dy.
\end{aligned}
\tag{9}
$$
For actual primitives, $TF$ is the normalized primitive of $CP'$. The equivalent formula is
$$
(TF)(x)=F(x+1)-F(2)
+\frac12\int_2^\infty k_*(y)F(y)dy
-\frac{\sqrt x}{2}\int_{x+1}^\infty k_*(y)F(y)dy,
\quad k_*(y)=\frac1{y(y-1)^{3/2}}.
$$
This retains exactly the initial boundary and the relative charge. It is a signed operator, not a positive one.

Use the Banach space of bounded Lipschitz functions on $[1,\infty)$ with $F(1)=0$, norm
$$
\|F\|_{\mathcal B}=\max(\|F\|_\infty,\|F'\|_\infty).
$$
The derivative is the almost-everywhere weak derivative; prime-power corners are allowed. Since
$$
\int_{x+1}^\infty k_*(y)dy\le\frac{2}{3x^{3/2}},
$$
formula (9) gives $\|TF\|_\infty\le(8/3)\|F\|_\infty$. Differentiating its absolutely convergent tail at almost every $x$ gives
$$
(TF)'(x)=F'(x+1)-\frac1{4\sqrt x}\int_{x+1}^\infty k_*F
 +\frac{F(x+1)}{2x(x+1)},
$$
so
$$
\|(TF)'\|_\infty\le\|F'\|_\infty+\frac5{12}\|F\|_\infty.
$$
Also $(TF)(1)=0$. Consequently
$$
\boxed{\|T\|_{\mathcal B\to\mathcal B}\le\frac83.}
\tag{10}
$$
For a general member of this space no assertion that $P'$ lies in the original source domain is needed: $T$ is defined by the convergent integral formula. On the actual orbit, identification with $I(CP')$ is justified separately by the $L^1$ difference and boundary facts in section 2.

For any $F\in\mathcal B$,
$$
|F(x)|\le\|F\|_{\mathcal B}\min(1,x-1)
\le2\|F\|_{\mathcal B}(1-1/x).
\tag{11}
$$
Thus this norm gives a uniform bound relative to the vanishing-endpoint profile $\vartheta$, including both age zero and infinity.

## 4. Actual arithmetic margins and all-history tail control

The established first-primitive bounds imply the quantitative lower margin
$$
\boxed{\frac1{25}\vartheta(v)<P_1(v)<\frac{93}{100}\vartheta(v).}
\tag{12}
$$
For clarity, the lower bound needs no new cell calculation. On $1\le x<2$,
$$
P_1'(\log x)=\frac{\sqrt x}{x+1}\log2-\frac\kappa{\sqrt x}
\ge\frac{\sqrt2}{3}\log2-.279>.04.
$$
The inequality applies to the left derivative at $2$; integration and continuity give the endpoint. Since $\vartheta(v)\le v$, it proves the initial bound. The accepted cell certificate gives $P_1>1/25$ on $2\le x\le23$, which is stronger than (12). For $x\ge23$, the accepted exact error-kernel estimate gives
$$
\sqrt xP_1(\log x)\ge2\kappa-2\epsilon_{23}
>.5578-.324>.04,
$$
again implying (12). This imports exactly the earlier unconditional PNT/cell proof, not a new prime estimate.

For $F_1(x)=\sqrt xP_1(\log x)$, the upper envelope gives $\|F_1\|_\infty<.93$. On $n<x<n+1$ its derivative is exactly
$$
F_1'(x)=\frac{F_1(x)}{2x}
 +\frac{\Lambda(n+1)}{x+1}
 -\frac{\psi(n)}{x(x+1)}-\frac\kappa x.
$$
Using $\Lambda(n+1)\le\log(x+1)$, $\psi(n)\le x\log x$, and $\log y/y\le1/e$ gives
$$
\|F_1'\|_\infty\le.465+.279+2/e<\frac32.
$$
Therefore $\|F_1\|_{\mathcal B}\le3/2$. Equations (10)–(11) imply for every actual $j\ge1$
$$
\boxed{|P_j(v)|\le3(8/3)^{j-1}\vartheta(v).}
\tag{13}
$$
This controls both signs. It does not contradict the negative interval of $P_5$.

For $r<3/8$, the series of normalized potentials and their weak derivatives
converges in this Banach norm. On every bounded age interval this also
gives a bounded density for the correction $\sum r^jP_j'$, since
$P_j'(\log x)=\sqrt xF_j'(x)-F_j(x)/(2\sqrt x)$.
Thus the averaged source is locally bounded, and the subsequent local
source convolutions and arithmetic aggregation are literal functions.

Now retain the proved $0<P_2<.93\vartheta$ and estimate the complete remaining tail:
$$
\left|\sum_{j\ge3}r^jP_j(v)\right|
\le\frac{64r^3}{3(1-8r/3)}\vartheta(v)
\le\frac r{44}\vartheta(v),\qquad 0<r\le1/32.
\tag{14}
$$
The last constant uses the largest permitted $r$, and is uniform in age. Combining (12), $P_2>0$, and (14) gives
$$
\overline P_r>r\left(\frac1{25}-\frac1{44}\right)\vartheta
=\frac{19r}{1100}\vartheta.
$$
For the upper bound,
$$
\overline P_r<r\left[\frac{93}{100}(1+1/32)+\frac1{44}\right]\vartheta
<r\vartheta.
$$
This proves (1). In Banach-space language the arithmetic initial vector lies strictly inside the positive primitive cone relative to $\vartheta$, and its resolvent remains inside for this explicit interval. No assertion that the cone is preserved by $T$ itself is used or true in general.

## 5. The complete reflected-source W comparison

Let $\alpha=e^{-v/2}a$, $\overline\alpha_r=e^{-v/2}\overline a_r$, and set $A_0=I\alpha$, $\overline A_{0,r}=I\overline\alpha_r$. If $p_r=e^{-v/2}\overline P_r$, then
$$
\overline A_{0,r}-A_0=p_r+\tfrac12Ip_r>0.
$$
The envelope (1) bounds this difference by
$$
r\min(v,1/3).
$$
The actual factorial identity gives $A_0=-v$ for $v\le\log2$ and $A_0\le-(\log2)/2$ afterwards. Hence
$$
\boxed{A_0(v)<\overline A_{0,r}(v)<0\quad(v>0).}
\tag{15}
$$
All endpoint constants are retained. Put $U=-A_0$ and $V_r=-\overline A_{0,r}$. Then
$$
Q_r=U*U-V_r*V_r=(U-V_r)*(U+V_r)>0.
$$
Equivalently, before tilting, the source-square correction remains exactly
$$
\overline a_r*\overline a_r-a*a
=a*\overline P_r'+\overline P_r'*a+\overline P_r'*\overline P_r'.
\tag{16}
$$
Both mixed orders and the correction square are included. No sign is assigned to the three terms individually.

Define the actual comparison readout with the unchanged complete same-prime subtraction,
$$
w_f=\rho*[(\operatorname{Id}-k*) (f*f)-\tau],\quad
\rho=\sum_{d\ge1}d^{-1}\delta_{\log d},\quad
k=e^{-3v/2}\mathbf1_{v\ge0},\quad
W_f(x)=x^{3/2}w_f(\log x).
$$
The literal $\tau$ retains every $p^m$, $m\ge2$, with multiplicity $m-1$. It cancels only because it is identical in $w_a$ and $w_{\overline a_r}$. Exponential tilting and three causal integrations give the same exact original-filter identity as in the preceding W comparison:
$$
I^3[e^{-v/2}(w_a-w_{\overline a_r})]
=\rho_{3/2}*K_0*Q_r>0,
$$
$$
\rho_{3/2}=\sum_{d\ge1}d^{-3/2}\delta_{\log d},\qquad
K_0=\tfrac12(1+e^{-2v})\mathbf1_{v\ge0}.
$$
Thus the full geometric average satisfies the strict finite-cutoff comparison
$$
\boxed{\int_1^x\log^2(x/y)
\frac{W_a(y)-W_{\overline a_r}(y)}{y^3}dy>0
\quad(x>1,\ 0<r\le1/32).}
\tag{17}
$$
Its value at $x=1$ is zero. The convergent correction and local convolution arguments above justify the full average, rather than only a formal generating function. This is a new all-history averaged comparison beyond finite convex combinations of the first two good stages. It is not a pointwise W order, a sign for either individual W readout, an assertion for $r$ near one, or an RH conclusion.

This chapter preserves a written mathematical proof. The actual resolvent, its arithmetic sign or profile consumer, and its stated limiting quantifiers are not asserted to be Lean formalized.
