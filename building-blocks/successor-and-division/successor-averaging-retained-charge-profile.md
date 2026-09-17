# The signed profile retained by long successor averages

Fix an actual natural cutoff $N\ge2$ and its literal frozen source
$$
g_N(x)=\mathbf1_{x\ge1}\frac{E_\psi(\min(x,N))}{x},\qquad
M_N=\sum_{n\le N}\frac{\Lambda(n)}{\sqrt n}-2\sqrt N+1.
$$
All proper powers and the frozen endpoint occur in $M_N$ and $g_N$. We use the original physical $L^2(0,\infty)$, with zero extension below $1$, and the unitary dilation
$$
(D_t f)(x)=\sqrt t f(tx),\qquad t>0.
$$
The exact compensated successor is the one in [the exact renewal source](literal-compensated-successor-iterates.md). The proved input from [the signed-source stabilization theorem](signed-source-successor-stabilization.md) is
$$
D_k C^kg_N\longrightarrow M_N\mathcal V\quad\text{strongly in }L^2,
\qquad \sup_{k\ge0}\|C^kg_N\|_2=B_N<\infty,
\tag{1}
$$
where
$$
\mathcal V(x)=\frac4{\pi^2}
\frac{\operatorname{atanh}((1+x)^{-1/2})}{\sqrt{1+x}}
=\frac2{\pi^2}\int_0^1\frac{du}{\sqrt u(x+1-u)},
\qquad \|\mathcal V\|_2^2=\frac{28\zeta(3)}{\pi^4}.
\tag{2}
$$
The signed source coefficient in (1) is essential. We do not repeat the exact renewal proof or replace its signed driver by positive source weights.

## 1. Strong limits for the complete averages

For $0<r<1$, let $n=(1-r)^{-1}$ and define the geometric average as the absolutely convergent $L^2$ series
$$
G_{r,N}=(1-r)\sum_{k\ge0}r^k C^kg_N.
$$
For an integer $K\ge1$, define the Cesàro average
$$
H_{K,N}=\frac1K\sum_{k=0}^{K-1}C^kg_N.
$$
Then, for each fixed actual $N$,
$$
\boxed{D_nG_{r,N}\longrightarrow M_N\mathcal V_{\rm geo}
\quad(r\uparrow1),\qquad
D_KH_{K,N}\longrightarrow M_N\mathcal V_{\rm Ces}
\quad(K\to\infty)}
\tag{3}
$$
strongly in $L^2(0,\infty)$, with the Bochner integrals
$$
\boxed{\mathcal V_{\rm geo}(x)=\int_0^\infty e^{-t}t^{-1/2}\mathcal V(x/t)dt,
\qquad
\mathcal V_{\rm Ces}(x)=\int_0^1t^{-1/2}\mathcal V(x/t)dt.}
\tag{4}
$$
These integrals exist in $L^2$: $t^{-1/2}\mathcal V(x/t)=D_{1/t}\mathcal V(x)$ has norm $\|\mathcal V\|_2$ for every $t>0$, and both averaging measures in (4) have mass one.

Here are the convergence details, including the small-index boundary. Put $f_k=C^kg_N$ and, for $k\ge1$, $e_k=D_kf_k-M_N\mathcal V$. Equation (1) gives $e_k\to0$ in norm and $\sup_k\|e_k\|<\infty$. The identity
$$
D_n f_k=D_{n/k}(M_N\mathcal V+e_k)
$$
retains the ratio of the actual iteration index to the averaging scale. For indices $\epsilon n\le k\le Mn$, the error is at most $\sup_{k\ge\epsilon n}\|e_k\|\to0$ after summing the averaging weights. On this interval the continuous $L^2$-valued function $t\mapsto D_{1/t}\mathcal V$ is uniformly continuous. For the geometric average,
$$
(1-r)r^k=\frac1n(1-1/n)^k
=\frac1n e^{-k/n}(1+o(1))
$$
uniformly for $k\le Mn$. Its middle sum therefore converges in $L^2$ to the corresponding integral in (4). Cesàro averaging gives the same Banach-valued Riemann-sum argument with $M=1$.

The total geometric weight of $k<\epsilon n$ is at most $\epsilon+1/n$, and that of $k>Mn$ is bounded by $e^{-M+o(1)}$. The norm bound $B_N$ in (1) controls these entire pieces without approximating small $k$ by their large-$k$ asymptotic. The analogous Cesàro small-index weight is at most $\epsilon+1/K$. The $k=0$ term has norm $B_N/n$ or $B_N/K$ and vanishes. The corresponding integral pieces have norm at most $|M_N|\|\mathcal V\|_2\epsilon$ and, for the geometric tail, $|M_N|\|\mathcal V\|_2e^{-M}$. First taking the averaging scale to infinity, then $\epsilon\downarrow0$ and $M\uparrow\infty$, proves (3). No continuity assertion at $t=0$ is required.

## 2. Exact positive profiles and retained charge

The Cesàro profile has the elementary closed form
$$
\boxed{\mathcal V_{\rm Ces}(x)=\frac8{\pi^2}
\left[\sqrt{1+x}\operatorname{atanh}((1+x)^{-1/2})-1\right].}
\tag{5}
$$
Indeed the integrand in (4) is
$$
\frac4{\pi^2\sqrt{x+t}}\operatorname{atanh}\sqrt{\frac{t}{x+t}}.
$$
Substitution $z=\sqrt{t/(x+t)}$, followed by integration by parts, gives the integral from $0$ to $1$ as
$\frac8{\pi^2}[\sqrt{1+x}\operatorname{atanh}((1+x)^{-1/2})-1]$.
Both profiles in (4) are strictly positive for $x>0$.

They also have exact scale-invariant charge one. Define
$$
Q(f)=\frac12\int_0^\infty f(x)x^{-1/2}dx
$$
when the integral is absolute. Positivity and (2) permit Tonelli:
$$
Q(\mathcal V)=\frac1{\pi^2}\int_0^1\frac{du}{\sqrt u}
\int_0^\infty\frac{dx}{\sqrt x(x+1-u)}
=\frac1\pi\int_0^1\frac{du}{\sqrt{u(1-u)}}=1.
\tag{6}
$$
The endpoint $u=1$ is harmless in this positive double integral. Since $Q(D_t f)=Q(f)$, another positive Tonelli exchange gives
$$
\boxed{Q(\mathcal V_{\rm geo})=Q(\mathcal V_{\rm Ces})=1.}
\tag{7}
$$
This charge identity is computed directly; it is not deduced from $L^2$ convergence by treating the charge as a bounded $L^2$ functional. The limiting signed profiles have charge $M_N$.

For reference, the profiles have tails
$$
\mathcal V_{\rm Ces}(x)\sim\frac8{3\pi^2x},\qquad
\mathcal V_{\rm geo}(x)\sim\frac2{\pi^{3/2}x}\quad(x\to\infty).
\tag{8}
$$
The first follows directly from (5). For the second, $y\mathcal V(y)\to4/\pi^2$, and $\sup_{y>0}y\mathcal V(y)<\infty$ follows from (2). Thus $x t^{-1/2}\mathcal V(x/t)$ is dominated by a constant times $\sqrt t$, integrable against $e^{-t}dt$, proving (8) by dominated convergence. In particular these are $L^2$ profiles, not unweighted $L^1$ profiles.

## 3. Explicit nonzero norm bounds

Minkowski and the isometric dilations in (4) give
$$
\|\mathcal V_{\rm geo}\|_2^2,\ \|\mathcal V_{\rm Ces}\|_2^2
\le\frac{28\zeta(3)}{\pi^4}.
$$
The power series $\operatorname{atanh}z/z-1\ge z^2/3$ in (5) yields
$$
\mathcal V_{\rm Ces}(x)\ge\frac8{3\pi^2(x+1)},\qquad
\boxed{\|\mathcal V_{\rm Ces}\|_2^2\ge\frac{64}{9\pi^4}>0.}
\tag{9}
$$
For the geometric profile, $\operatorname{atanh}z\ge z$ gives
$$
\mathcal V_{\rm geo}(x)\ge\frac4{\pi^2}
                  \int_0^\infty\frac{e^{-t}\sqrt t}{x+t}dt.
$$
Normalize $e^{-t}\sqrt t\,dt$ to its Gamma$(3/2)$ probability law. Its mass is $\sqrt\pi/2$ and its mean is $3/2$. Jensen's inequality for the convex function $t\mapsto1/(x+t)$ therefore proves
$$
\mathcal V_{\rm geo}(x)\ge\frac2{\pi^{3/2}(x+3/2)},\qquad
\boxed{\|\mathcal V_{\rm geo}\|_2^2\ge\frac8{3\pi^3}>0.}
\tag{10}
$$
Consequently the actual averaged norms have the exact limits
$$
\boxed{\|G_{r,N}\|_2^2\longrightarrow M_N^2\|\mathcal V_{\rm geo}\|_2^2,
\qquad
\|H_{K,N}\|_2^2\longrightarrow M_N^2\|\mathcal V_{\rm Ces}\|_2^2.}
\tag{11}
$$
For $M_N\ne0$ these limits are strictly positive, with the explicit lower bounds (9)–(10) multiplied by $M_N^2$. The actual nonvanishing assertion, when used, is the one retained in the stabilization source. The sign of $M_N$ is not replaced by an absolute value in the profile limits (3).

## 4. Quantifier and W scope

Every limit above holds at a fixed actual $N$. Both $B_N$ and the index beyond which the stabilization error is small may depend on $N$. Thus (3) neither interchanges $N\to\infty$ with $r\uparrow1$ nor asserts a geometric or Cesàro limit for the completed non-$L^1$ source $a$. The averaged source retains its signed charge on an expanding physical scale even though the ordinary frozen shift tends to zero.

This does not contradict the small-$r$ positive primitive theorem for the completed source: that theorem is an absolutely convergent perturbative resolvent on $0<r\le1/32$, with a specific cumulative W comparison. The present theorem concerns long averaging at a fixed frozen source and identifies its surviving signed channel. Neither result supplies a sign for the original complete reflected W product or licenses deleting the charge carrier or its cross terms.

This chapter preserves a written mathematical proof. The actual resolvent, its arithmetic sign or profile consumer, and its stated limiting quantifiers are not asserted to be Lean formalized.
