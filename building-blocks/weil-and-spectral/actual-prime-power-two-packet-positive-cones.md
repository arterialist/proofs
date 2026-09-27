# Positive two-packet spaces at every prime-power scale

This is an unconditional inequality for the complete actual-zeta Weil form
on explicit infinite-dimensional pole-null subspaces at arbitrarily large
support radii. It concerns those subspaces, not the whole test space at any
radius; it gives no RH implication. The arithmetic row and scalar reduction
are kernel checked in
[ActualWeilIsolatedPrimePowerCone.lean](../../formalization/BuildingBlocks/ActualWeilIsolatedPrimePowerCone.lean).

Let $q=p^k\ge7$, $d=\log q$, $w=1/(4q)$, and $c_q=\Lambda(q)/\sqrt q=(\log p)/\sqrt q$. Let real $g\in C_c^\infty((-w/2,w/2))$ obey both $M_\pm(g)=\int e^{\pm x/2}g(x)dx=0$, and set

$$
f(x)=g(x+d/2)-g(x-d/2).
$$

The disjoint packets have $\|f\|_2^2=2\|g\|_2^2$. Translation gives $M_\pm(f)=(e^{\mp d/4}-e^{\pm d/4})M_\pm(g)=0$, so both pole terms vanish exactly.

Put $C_u(s)=\langle\tau_su,u\rangle$. Then $C_f(s)=2C_g(s)-C_g(s-d)-C_g(s+d)$, and $C_g$ is supported in $[-w,w]$. For $s=\log n>0$, the diagonal and $s+d$ rows vanish because $\log2>w$. The remaining row is possible only for $qe^{-w}<n<qe^w$. Here $e^{-w}>1-w$ yields $qe^{-w}>q-1/4>q-1$, whereas $e^w<1/(1-w)=4q/(4q-1)<1+1/q$ yields $qe^w<q+1$. Thus the **only integer**, and therefore the only active prime power, is $n=q$. In particular $C_f(d)=-\|g\|_2^2$, and the exact full prime row is $+2c_q\|g\|_2^2$. This includes proper powers, with coefficient $\Lambda(p^k)=\log p$, not $\log q$.

Write $\Gamma(u)=(2\pi)^{-1}\int |\hat u(t)|^2[\operatorname{Re}\psi(1/4+it/2)-\log\pi]dt$. The digamma series gives the off-diagonal kernel

$$
-k(v),\qquad k(v)=\sum_{m\ge0}e^{-(2m+1/2)v}
=\frac{e^{-v/2}}{1-e^{-2v}},\quad v>0.
$$

No diagonal distribution couples disjoint packets. Consequently, for $I=\iint g(x)g(y)k(d+x-y)dxdy$, $\Gamma(f)=2\Gamma(g)+2I$, and $|I|\le w k(d-w)\|g\|_2^2$. The single-packet diameter $w<\log2$ has no prime row, and its poles vanish. Since its support lies within Zhu's certified $[-0.8,0.8]$ window, [Theorem 1.2 and Corollary 6.3](https://arxiv.org/html/2608.24827v2) give $\Gamma(g)=Q(g)\ge\varepsilon\|g\|_2^2$, $\varepsilon=8.9\cdot10^{-18}$. Hence

$$
\frac{Q(f)}{\|f\|_2^2}\ge\varepsilon+c_q-wk(d-w).
$$

Uniformly for $q\ge7$, $d-w>\log2$, so $k(d-w)<k(\log2)=4/(3\sqrt2)<1$. Also $1/\sqrt q\le1/\sqrt7<1/2<\log2\le\log p$, whence $w=1/(4q)<c_q/4$. Therefore

$$
\boxed{Q(f)>(\varepsilon+3c_q/4)\|f\|_2^2\ge\varepsilon\|f\|_2^2.}
$$

The $3c_q/4$ margin is uniform *relative to the active prime coefficient*. A fixed absolute margin also follows, but only the tiny $\varepsilon$ is supplied here uniformly as $q\to\infty$.

The assertion that every $q\ge7$ produces tests outside $[-1,1]$ is **false** with this width. At $q=7$, the enclosing radius is $R_7=(\log7+1/28)/2<1$, since the degree-five Taylor lower sum for $e^{55/28}$ exceeds $7$ by exactly $8536903/413048832>0$, i.e. $\log7<55/28=2-1/28$. For $q\ge8$, the stronger $d-w>2$ holds. At $q=8$, $e^{2+1/32}< (11/4)^2(32/31)=242/31<8$, using $e<11/4$ and $e^{1/32}<32/31$; the function $\log q-1/(4q)$ increases. Thus both packet supports lie wholly outside $[-1,1]$ for every $q\ge8$.

For each $q$, the space is infinite dimensional: $g=(D^2-1/4)h$ for arbitrary real $h\in C_c^\infty((-w/2,w/2))$ kills both pole moments by integration by parts. The differential operator is injective on compactly supported functions, as is the disjoint two-packet map. Even and odd choices of $h$ yield opposite pure parity sectors for $f$. This is a structured subspace of the actual full Weil form, not an all-test estimate at radius $(\log q+w)/2$ or an RH implication. The union of the $q\ge8$ images vanishes on $[-1,1]$ and is not dense in the pole-null test class.

The Lean module proves the nearest-integer logarithmic spacing for every
natural $q\ge8$, isolates the complete finite von Mangoldt row over
`2≤n≤q` from
explicit correlation-support hypotheses, checks
$\Lambda(p^k)=\log p$, proves the elementary prime-coefficient margin,
and derives the strict scalar bound. Its named
analytic hypotheses are the support-to-correlation identification,
$\|f\|_2^2=2\|g\|_2^2$, the exact complete Weil-form decomposition,
Zhu's self-form inequality, and the digamma cross-kernel bound. The smooth
packet construction, identification of the active condition
`log n<2R_q` with `2≤n≤q`, digamma integral, and source theorem are checked in
the written proof but are not formalized in Lean. The finite theorem is
conditional on those named analytic inputs; no Lean theorem asserts full
Weil positivity or RH.
