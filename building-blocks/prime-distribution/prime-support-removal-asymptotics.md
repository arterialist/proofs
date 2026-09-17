# Prime-support removal in a centered multiplicative convolution

Let $\Lambda$ be the von Mangoldt function and $\psi(x)=\sum_{n\le x}\Lambda(n)$. On $[1,\infty)$ put

```math
\nu_p=(\log p)\sum_{k\ge1}\delta_{p^k},\qquad
\eta=\delta_1+du,\qquad \sigma_P=\sum_{p\in P}\nu_p-\eta.
```

Convolution below is multiplicative. For $x\ge1$, define

```math
\mathcal T_x(\rho)=\int(x-u)_+\,d\rho(u),\qquad
V_P(x)=\mathcal T_x(\sigma_P*\sigma_P)
-\sum_{p\in P}\mathcal T_x(\nu_p*\nu_p).
```

Only compact parts of these locally finite measures contribute. Write $P_x=\{p:p\le x\}$, $V(x)=V_{P_x}(x)$ and $\sigma=\sum_p\nu_p-\eta$. The subtracted diagonal removes equal prime bases, not higher powers of distinct primes.

The following statements describe auxiliary removals from the actual prime support. They do not establish the eventual sign of $V$.

## Uniform removal theorem

Put $y=\sqrt x$. For any $T\subseteq P_y$, let

```math
\theta_T=\sum_{p\in T}\log p,\qquad m_T=\sum_{p\in T}p\log p,
\qquad R=P_x\setminus T.
```

Then, uniformly over all such subsets,

```math
\boxed{V_R(x)=x\theta_T^2-m_T^2+o(x^2).} \tag{1}
```

Consequently, for each fixed $0<\delta\le1$, the condition $\theta_T\ge\delta\sqrt x$ implies

```math
V_R(x)\ge\left(\delta^3-\frac{\delta^4}{4}+o(1)\right)x^2. \tag{2}
```

The coefficient is sharp at limiting mass $\theta_T/\sqrt x\to\delta$: terminal intervals $((1-\delta)\sqrt x,\sqrt x]$ attain it.

**Proof.** The classical quantitative PNT gives, for some $c>0$,

```math
\psi(u)=u+O(ue^{-c\sqrt{\log u}}),\qquad
J(u):=\mathcal T_u(\sigma)=\int_1^u(\psi(t)-t)dt
=O(u^2e^{-c\sqrt{\log u}}).
```

The atom at $1$ is necessary for the displayed identity for $J$. Decreasing $c$ absorbs the bounded initial range. The PNT used here is, for example, the zeta specialization of [Yashiro, Theorem 1.3](https://arxiv.org/html/1311.0754#S1).

Splitting the convolution at $y=\sqrt x$ gives exactly

```math
\mathcal T_x(\sigma*\sigma)
=2\int_{[1,y]}aJ(x/a)d\sigma(a)
-x\sigma([1,y])^2+
\left(\int_{[1,y]}a\,d\sigma(a)\right)^2. \tag{3}
```

Indeed, two factors above $y$ give zero weight, and the overlap $[1,y]^2$ has weight $x-ab$. PNT and partial summation give

```math
\sigma([1,y])=\psi(y)-y=o(y),\qquad
\int_{[1,y]}a\,d\sigma(a)
=\sum_{n\le y}n\Lambda(n)-\frac{y^2+1}{2}=o(y^2),
```

while $\int_{[1,y]}a^{-1}d|\sigma|(a)=O(\log y)$. Thus (3) is $o(x^2)$. The full same-prime diagonal is $O(x^{3/2}\log x)$: only $p\le y$ occur, and the number of exponent pairs times $(\log p)^2$ is at most $(\log x)^2$. In particular $V(x)=o(x^2)$.

Exact deletion gives

```math
V_R=V-2\mathcal T_x(\sigma*\nu_T)
+\mathcal T_x(\nu_T*\nu_T)
+\sum_{p\in T}\mathcal T_x(\nu_p*\nu_p). \tag{4}
```

The mixed term equals

```math
\sum_{p\in T,\ p^k\le x}(\log p)p^kJ(x/p^k).
```

Atoms $p^k\le y$ contribute $O(x^2\log y\,e^{-c\sqrt{\log y}})$. Atoms above $y$ are proper powers and satisfy

```math
\sum_{p,\ k\ge2,\ p^k>y}\frac{\log p}{p^k}
=O\left(\frac{\log y}{\sqrt y}\right). \tag{5}
```

For $p>\sqrt y$, sum the geometric tail starting at $p^2$ and compare with $\sum_{n>\sqrt y}(\log n)/n^2$. For $p\le\sqrt y$, the tail after $p^k>y$ is at most $2/y$ before multiplying by $\log p$; use $\theta(\sqrt y)=O(\sqrt y)$. The global estimate $J(u)=O(u^2)$ now proves the mixed term is $o(x^2)$ uniformly.

The first-power pairs in $\mathcal T_x(\nu_T*\nu_T)$ are exactly $x\theta_T^2-m_T^2$, since $pq\le x$. Pairs with a proper power and both atoms at most $y$ cost at most

```math
2x[\psi(y)-\theta(y)]\psi(y)=O(x^{7/4}\log^2x).
```

If an atom exceeds $y$, use (5) and $\psi(u)=O(u)$ to bound the contribution by $O(x^2\log y/\sqrt y)$. The final diagonal in (4) is bounded by the full diagonal. This proves (1); all bounds are independent of $T$.

For the sharp lower bound, set $d=\theta_T/y$, $e=m_T/y^2$ and $\epsilon_y=y^{-1}\sup_{0\le u\le y}|\theta(u)-u|\to0$. For $0\le t\le y$,

```math
m_T\le t\theta_T+\sum_{t<p\le y}(p-t)\log p
\le t\theta_T+\frac{(y-t)^2}{2}+2\epsilon_y y(y-t).
```

Choose $t/y=1-d$, clipped to $[0,1]$. Since $d\le1+\epsilon_y$,

```math
e\le d-d^2/2+r_y,\qquad r_y=2\epsilon_y+\epsilon_y^2/2=o(1).
```

For large $y$, $0\le d\le2$, so $0\le d-d^2/2\le1/2$ and

```math
d^2-e^2\ge d^3-d^4/4-r_y-r_y^2.
```

The polynomial $d^3-d^4/4$ is increasing on $[0,2]$. Equation (2) follows. PNT on the terminal interval gives $d\to\delta$ and $e\to\delta-\delta^2/2$, proving the asserted sharpness. $\square$

## Prime marginals and negative removed-support examples

For $p\notin P$, cancellation of the new diagonal gives the exact identity

```math
V_{P\cup\{p\}}(x)-V_P(x)
=2\log p\sum_{p^k\le x}p^k\mathcal T_{x/p^k}(\sigma_P). \tag{6}
```

If $p\le x<p^2$ and $P$ contains every prime below $p$, only the first power contributes and

```math
V_{P\cup\{p\}}(x)-V_P(x)=2p\log p\,J(x/p). \tag{7}
```

Extra primes above $p$ cannot interact with $p$ below $p^2$. For $1<u<2$, $J(u)=-(u^2-1)/2<0$. In contrast, $J$ takes positive and negative values arbitrarily far out.

For completeness, its Mellin transform is

```math
\int_1^\infty J(u)u^{-s-2}du
=\frac{-\zeta'(s)/\zeta(s)-s/(s-1)}{s(s+1)},\qquad \Re s>1. \tag{8}
```

The continued expression is regular near every positive real $s$, including $1$, but has residue $-m_\rho/[\rho(\rho+1)]\ne0$ at a nontrivial zeta zero $\rho$ of multiplicity $m_\rho$. If $J$ had either eventual sign, Landau's theorem for a nonnegative Mellin tail would force a singularity at its real abscissa of convergence. That abscissa is at most $1$, by $J(u)=O(u^2)$, and at least $\Re\rho>0$, since convergence to the left of $\rho$ would contradict its pole. This is impossible. See the continuous-integral statement in [Lay, Theorem 3](https://personal.math.ubc.ca/~gerg/teaching/592-Fall2018/papers/arXiv.Lay.pdf). No assertion about zeros off the critical line is required.

Every sufficiently large prime has both signs of marginal response at integer cutoffs before its square. The cutoff $x=p+1$ gives a negative response by (7). Choose a fixed interval $1<a<b$ with $J>0$. For every sufficiently large prime $p$, there is an integer $ap<n<bp<p^2$, and its response is positive by (7). This retains the actual smaller-scale prime history in $J$; increasing the number of admitted prime generators does not imply monotone response.

Choose $1<a<b$ with $J>0$ throughout $[a,b]$, and remove

```math
T_x=\{p:x/b<p\le x/a\},\qquad B_x=P_x\setminus T_x.
```

For $x>b^2$, all removed primes exceed $\sqrt x$, have no proper powers below $x$, and have no mutual interaction there. Hence

```math
V(x)-V_{B_x}(x)=2\sum_{p\in T_x}p\log p\,J(x/p).
```

Stieltjes partial summation and PNT on the fixed interval $[1/b,1/a]$ give

```math
\boxed{\frac{V_{B_x}(x)}{x^2}\longrightarrow
-2\int_a^bJ(u)u^{-3}du<0.} \tag{9}
```

The weight $tJ(1/t)$ is continuous and of bounded variation there. Moreover, every intermediate support $B_x\subseteq S\subseteq P_x$ satisfies $V_{B_x}(x)\le V_S(x)\le V(x)$. Thus a negative optimized subset cannot establish the sign at full support.

## Independent reservoirs cannot pay the baseline

Expanding in prime-presence variables gives

```math
V_P=B_0-\sum_{p\in P}c_p+\sum_{p<q\in P}w_{pq},
```

where

```math
B_0=\frac{x^2}{2}\log x+\frac{x^2}{4}-\frac14,
\quad c_p=\log p\sum_{p^k\le x}(x^2/p^k-p^k),
\quad w_{pq}=2\log p\log q\sum_{k,l\ge1}(x-p^kq^l)_+.
```

All $c_p,w_{pq}$ are nonnegative, and $w_{pq}>0$ exactly when $pq<x$. Call a prime set independent when all its internal $w_{pq}$ vanish. Then

```math
\max_{R\text{ independent}}\sum_{p\in R}c_p
=\frac{x^2}{2}\log x-\frac{x^2}{2}+o(x^2). \tag{10}
```

Indeed, $H=\{\sqrt x<p\le x\}$ is independent. Quantitative PNT gives $\sum_{p\le t}\log p/p=\log t+C+o(1)$ and $\sum_{p\le t}p\log p=t^2/2+o(t^2)$, proving (10) for $H$. Any independent set contains at most one $p_0\le\sqrt x$. If $p_0\ge x^{1/4}$, its capacity is at most $x^2\log p_0/(p_0-1)=o(x^2)$ and all other primes lie in $H$. If $p_0<x^{1/4}$, all other primes exceed $x^{3/4}$; their total capacity is at most $(\tfrac14\log x+o(1))x^2$, while $c_{p_0}\le x^2\log2$. This proves the uniform upper bound.

In particular, $B_0-\sum_{p\in R}c_p\ge(3/4+o(1))x^2$ for every independent $R$. Any scheme that places the whole baseline on such an $R$, charges nonnegative interaction loads to prime endpoints and limits each endpoint load by $c_p$ therefore fails even before charging interactions. Interacting reservoirs retaining all primes above $\sqrt x$ must, by (2), omit only $o(\sqrt x)$ logarithmic prime mass below that boundary if their value is nonpositive.

## Exact fractional allocation criterion

At a fixed $x\ge1$, take a finite prime set $P$ and a designated subset $R\subseteq P$. Allocate each interaction demand $w_{pq}$ fractionally to its two endpoints. Allocate the entire baseline $B_0\ge0$ only to vertices in $R$. Require the total load at each prime $p$ to be at most $c_p$. With

$$
c(S)=\sum_{p\in S}c_p,\qquad
W(S)=\sum_{p<q,\ p,q\in S}w_{pq},
$$

such an allocation exists if and only if

$$
W(S)\le c(S)\quad(S\subseteq P),\qquad
B_0+W(S)\le c(S)\quad(R\subseteq S\subseteq P).
\tag{11}
$$

This is an application of the classical [Ford–Fulkerson max-flow/min-cut theorem](https://www.cs.yale.edu/homes/lans/readings/routing/ford-max_flow-1956.pdf). Here is the complete reduction. Make one demand vertex for each pair and one for the baseline. Join the source to each demand vertex with its demand as capacity, and join each prime vertex to the sink with capacity $c_p$. A pair-demand vertex can send flow to its two endpoints, while the baseline vertex can send flow exactly to $R$. Give these intermediate arcs capacity greater than the sum $D=B_0+\sum_{p<q}w_{pq}$.

A minimum cut has capacity at most $D$, so it cannot cut an intermediate arc. If $S$ is its set of prime vertices on the source side, every demand vertex there must have all its allowed endpoints in $S$. For the cheapest cut with this $S$, put all such demand vertices on the source side. Its capacity is

$$
D-W(S)-B_0\mathbf1_{R\subseteq S}+c(S).
$$

Thus every cut has capacity at least $D$ exactly when (11) holds. A flow of value $D$ saturates all source-demand arcs and is the desired allocation. The same formula includes $R=\varnothing$: if $B_0>0$, the cut $S=\varnothing$ correctly prohibits an allocation.

The full-set cut implies $B_0+W(P)\le c(P)$, equivalently $V_P(x)\le0$. When $R=P$, this already appears as a required premise, so the criterion supplies no independent proof of the full-support sign. When $R$ is independent, the cut $S=R$ requires $B_0\le c(R)$ and fails by the preceding $3x^2/4$ deficit for all sufficiently large $x$. Adaptive choice of $R$ and arbitrary fractional splitting of every positive interaction cannot repair that specific failure. Interacting reservoirs remain subject to all the cuts in (11), not just their total capacity.

These are applications of classical PNT, Landau oscillation, finite convolution and weighted rearrangement. They do not give a new prime-error estimate, establish the full-support sign, or claim priority or Lean formalization of the analytic asymptotics.
