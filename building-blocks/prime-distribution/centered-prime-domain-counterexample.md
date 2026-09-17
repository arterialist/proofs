# A domain counterexample for the centered infinite-prime history

This written counterexample concerns the [mixed additive completion](../dynamics-and-feedback/actual-source-mixed-dirichlet-completion.md) and the [centered prime multiplier](centered-prime-mellin-domain.md). It uses the classical PNT and an explicit auxiliary profile. Its conclusion does not concern the sign or convergence of the actual arithmetic source. It is not a Lean formalization.

Fix $0<\alpha\le1/2$, and define the auxiliary causal profile
$$
g_\alpha(x)=1_{x\ge1}x^{-\alpha},
\tag{1}
$$
extended by zero to the rest of the real line. This is not the actual prime-error source.

Use the mixed energy
$$
\mathcal E(f)=\int_0^1\|\tau_hf-f\|_2^2dh+
\int_1^\infty\|\tau_hf-f\|_2^2\frac{dh}{h^2},
\qquad \tau_hf(x)=f(x+h).
\tag{2}
$$
Then $g_\alpha$ belongs to the same completion of $L^2(\mathbb R)$ for this norm. For every fixed $c>0$, it satisfies a PNT-style envelope
$$
|g_\alpha(x)|\le \exp\!\left(\frac{c^2}{4\alpha}\right)
e^{-c\sqrt{\log x}}\qquad(x\ge1).
\tag{3}
$$
Nevertheless, its actual full-power centered prime history diverges on every fixed compact positive window.

Specifically, let $\mathsf D_a f(x)=\sqrt a\,f(ax)$, and retain the complete kernel
$$
L_p=2p^{-1}I+p^{-3/2}(\mathsf D_p+\mathsf D_{1/p})
-(1-p^{-1})\sum_{j\ge2}p^{-j/2}(\mathsf D_{p^j}+\mathsf D_{p^{-j}}).
\tag{4}
$$
Write
$$
C_P=\sum_{p\le P}(L_p-2p^{-1}I).
\tag{5}
$$
For $0<\alpha<1/2$, uniformly on each compact $K\subset(0,\infty)$,
$$
\boxed{C_Pg_\alpha(x)
=-x^{-\alpha}\frac{P^{1-2\alpha}}{(1-2\alpha)\log P}\,[1+o(1)].}
\tag{6}
$$
For $\alpha=1/2$, on the same type of window,
$$
\boxed{C_Pg_{1/2}(x)=-x^{-1/2}\log\log P+O_K(1).}
\tag{7}
$$
The finite-prime contributions and every power in (4) are retained in these statements. Constants and convergence rates may depend on the fixed $\alpha$ and window.

## Membership in the completion without an $L^2$ premise

Put $I_\alpha(h)=\|g_\alpha(\cdot+h)-g_\alpha\|_2^2$. Directly splitting at the causal boundary gives
$$
I_\alpha(h)=\int_1^{1+h}u^{-2\alpha}du
+\int_1^\infty\bigl[(x+h)^{-\alpha}-x^{-\alpha}\bigr]^2dx.
\tag{8}
$$
This identity retains the jump at one. For $0<h\le1$, the first integral is at most $h$, while the mean-value bound
$$
|(x+h)^{-\alpha}-x^{-\alpha}|
\le\alpha h x^{-\alpha-1}
$$
makes the second $O_\alpha(h^2)$. Hence $I_\alpha(h)\le C_\alpha h$.

For $h\ge2$, split the second integral at $x=h$. On $[1,h]$, bound the difference by $x^{-\alpha}$; on $[h,\infty)$, use the displayed mean-value estimate. This proves
$$
I_\alpha(h)\le
\begin{cases}
C_\alpha h^{1-2\alpha},&0<\alpha<1/2,\\
C\log(2h),&\alpha=1/2.
\end{cases}
\tag{9}
$$
Equations (8)--(9) make the mixed energy finite. They do not assert $g_\alpha\in L^2$, which is false throughout this range.

To verify membership in the actual completion, take the $L^2$ functions
$f_R=1_{[1,R]}x^{-\alpha}$, $R\ge2$. Their tails are
$q_R=g_\alpha-f_R=R^{-\alpha}g_\alpha(x/R)$, up to an immaterial endpoint value. Scaling the increments exactly gives
$$
\begin{aligned}
\mathcal E(q_R)
={}&R^{2-2\alpha}\int_0^{1/R}I_\alpha(v)dv\\
&+R^{-2\alpha}\int_{1/R}^\infty I_\alpha(v)\frac{dv}{v^2}
\le C_\alpha R^{-2\alpha}(1+\log R)\longrightarrow0.
\end{aligned}
\tag{10}
$$
Here the small-$v$ part uses $I_\alpha(v)\le C_\alpha v$, and the integral from one to infinity is finite by (9). Thus the compact $L^2$ truncations converge in the mixed norm to the causal representative (1).

For (3), set $t=\log x$. Completing the square gives
$c\sqrt t-\alpha t\le c^2/(4\alpha)$. The prefactor depends on the fixed exponent $c$; no common prefactor for all $c$ is asserted.

## Each individual prime retains its full convergent history

The individual series in (4) is meaningful in the mixed completion on $g_\alpha$. Indeed the exact dilation identity is
$$
\mathcal E(\mathsf D_a g_\alpha)
=\frac1a\int_0^a I_\alpha(v)dv
+a\int_a^\infty I_\alpha(v)\frac{dv}{v^2}.
\tag{11}
$$
For $a\ge2$, (9) bounds this by $C_\alpha a^{1-2\alpha}$ when $\alpha<1/2$, and by $C\log(2a)$ when $\alpha=1/2$. For $0<a\le1$, it is at most
$C_\alpha a(1+\log(1/a))$, hence is uniformly bounded. The remaining compact range of $a$'s is bounded as well.

Consequently the positive-power terms of (4), in energy norm, are bounded by a summable multiple of $p^{-j\alpha}$ when $\alpha<1/2$. At the endpoint they are bounded by
$C p^{-j/2}\sqrt{1+j\log p}$, also summable. The negative-power terms are bounded by a summable geometric series. Therefore every fixed $L_pg_\alpha$, and every finite $C_Pg_\alpha$, is well-defined in the completion.

The same series converges locally uniformly in its sufficiently large positive-power tail on every compact positive window. The negative-power part has only finitely many nonzero terms there. Thus the formulas below are actual function representatives of those completed-space elements.

## The exact contribution beyond a compact window

First take $x\ge1$ and $p>x$. Every negative dilation in (4) vanishes on $g_\alpha$, while every positive dilation samples its nonzero power-law part:
$$
\mathsf D_{p^j}g_\alpha(x)
=p^{j(1/2-\alpha)}x^{-\alpha}.
$$
Subtracting the exact diagonal $2p^{-1}g_\alpha$ leaves
$$
\boxed{(L_p-2p^{-1}I)g_\alpha(x)
=x^{-\alpha}\left[
p^{-1-\alpha}-(1-p^{-1})\frac{p^{-2\alpha}}{1-p^{-\alpha}}
\right].}
\tag{12}
$$
The fraction is the sum of every depth $j\ge2$, not a first-power approximation.

More generally, for a fixed $K=[a,b]\subset(0,\infty)$, choose a fixed $P_0>\max(b,1/a,2)$. Formula (12) holds simultaneously on $K$ for every prime $p>P_0$: all positive samples are above one, and all negative samples are below one. Hence
$$
C_Pg_\alpha(x)=V_{\alpha,K}(x)+x^{-\alpha}
\sum_{P_0<p\le P}b_\alpha(p),
\tag{13}
$$
where
$$
b_\alpha(p)=p^{-1-\alpha}
-(1-p^{-1})\frac{p^{-2\alpha}}{1-p^{-\alpha}},
$$
and $V_{\alpha,K}$ is the exact contribution of all primes at most $P_0$, including all their powers. It is bounded on $K$; it can have jumps at their fixed causal thresholds. Those finitely many primes are not discarded or re-centered.

For fixed $0<\alpha\le1/2$,
$$
b_\alpha(p)=-p^{-2\alpha}
+O_\alpha(p^{-3\alpha}+p^{-1-\alpha}+p^{-1-2\alpha}).
\tag{14}
$$
In particular $b_\alpha(p)/p^{-2\alpha}\to-1$. At $\alpha=1/2$, the sharper useful form is
$$
b_{1/2}(p)=-p^{-1}+O(p^{-3/2}),
\tag{15}
$$
whose remainder is absolutely summable over the primes.

## Prime summation and the asymptotic constants

The classical PNT gives, for each fixed $0<s<1$,
$$
\sum_{p\le P}p^{-s}\sim
\frac{P^{1-s}}{(1-s)\log P}.
\tag{16}
$$
One direct proof uses $\theta(t)=t+o(t)$ and the exact Stieltjes weight
$w_s(t)=t^{-s}/\log t$:
$$
\sum_{P_0<p\le P}p^{-s}
=\int_{(P_0,P]}w_s(t)d\theta(t).
$$
Partial summation retains the boundary at $P$ and the fixed boundary at $P_0$. Replacing $\theta(t)$ by $t$ has error $o(P^{1-s}/\log P)$, by bounding its relative error uniformly after an arbitrarily large fixed initial point. The main integral is $\int_{P_0}^P t^{-s}dt/\log t$, with the asymptotic in (16), by integration by parts.

At $s=1$, the quantitative PNT envelope gives
$$
\sum_{p\le P}\frac1p=\log\log P+B_{\rm pr}+o(1).
\tag{17}
$$
For precision, the primary input can be taken as Trudgian, *Updating the error term in the prime number theorem*, [Theorem 1](https://arxiv.org/pdf/1401.2689). After reducing the positive exponent it supplies
$|\psi(t)-t|\le Ct e^{-c\sqrt{\log t}}$. The difference
$\psi(t)-\theta(t)$ is $O(\sqrt t\log^2(2t))$ by elementary prime-power counting, so the same type of envelope holds for $\theta(t)-t$. Apply partial summation with $w_1(t)=1/(t\log t)$. The resulting error integral converges absolutely, and its upper boundary tends to zero. The main integral is $\log\log P-\log\log P_0$, proving (17) with the fixed lower endpoint absorbed in $B_{\rm pr}$.

For $\alpha<1/2$, the divergent positive sum (16) and the pointwise relative estimate in (14) imply
$$
\sum_{P_0<p\le P}b_\alpha(p)
\sim-\frac{P^{1-2\alpha}}{(1-2\alpha)\log P}.
\tag{18}
$$
To justify summing the relative error, fix an arbitrarily small bound on
$|b_\alpha(p)/p^{-2\alpha}+1|$ beyond a fixed prime. The earlier finite contribution is negligible compared with the divergent sum, and the remaining error is bounded by that small constant times the sum. No summability of the $p^{-3\alpha}$ error is falsely required when $3\alpha\le1$.

At the critical endpoint, (15)--(17) give
$$
\sum_{P_0<p\le P}b_{1/2}(p)
=-\log\log P+B_\alpha+o(1).
\tag{19}
$$
Equations (13), (18)--(19) prove (6)--(7). The asymptotics are uniform on $K$, because the only $x$-dependence in the infinite-prime part is the fixed function $x^{-\alpha}$, and the finite remainder is bounded.

## The original two-pole-null readout detects the divergence

Take a nonnegative nonzero $\eta\in C_c^\infty((0,\infty))$, with the variable denoted by $v$, and define
$$
\varphi(x)=x^{-1/2}\left(\eta''(\log x)-\tfrac14\eta(\log x)\right)
\quad(x>0).
\tag{20}
$$
It is a smooth compactly supported additive test in a fixed window above one. Two integrations by parts show its exact pole moments:
$$
\int_0^\infty\varphi(x)dx=0,\qquad
\int_0^\infty\frac{\varphi(x)}x dx=0.
\tag{21}
$$
Indeed the exponential weights after $x=e^v$ are respectively $e^{v/2}$ and $e^{-v/2}$, both annihilated by the adjoint of $\partial_v^2-1/4$.

The divergent component has nonzero pairing with this same test:
$$
\begin{aligned}
J_\alpha
&:=\int_0^\infty x^{-\alpha}\varphi(x)dx\\
&=\left[(\tfrac12-\alpha)^2-\tfrac14\right]
\int_{\mathbb R}e^{(1/2-\alpha)v}\eta(v)dv\\
&=\boxed{\alpha(\alpha-1)
\int_{\mathbb R}e^{(1/2-\alpha)v}\eta(v)dv<0.}
\end{aligned}
\tag{22}
$$
All boundary terms vanish by compact support. Therefore
$$
\int (C_Pg_\alpha)(x)\varphi(x)dx
\sim -J_\alpha\frac{P^{1-2\alpha}}{(1-2\alpha)\log P}
\longrightarrow+\infty
\quad(0<\alpha<1/2).
\tag{23}
$$
At the endpoint it is
$$
\int (C_Pg_{1/2})(x)\varphi(x)dx
=-J_{1/2}\log\log P+O(1)\longrightarrow+\infty.
\tag{24}
$$

The test is also a continuous mixed-energy dual functional. Its zero additive mean makes its Fourier transform $O(\xi)$ at zero, while its compact smoothness gives rapid decay. The established mixed multiplier
$m(\xi)\asymp\min(|\xi|,1)$ therefore gives
$\int|\widehat\varphi(\xi)|^2/m(\xi)d\xi<\infty$.
Thus (23)--(24) also force $\|C_Pg_\alpha\|_{\mathcal E}\to\infty$, rather than merely a failure of pointwise convergence. The second pole moment is retained even though the first already supplies membership in this dual space.

The limited conclusion is a domain obstruction. Membership in the mixed completion, even together with every fixed PNT-style pointwise envelope, does not imply convergence of the centered infinite-prime history. The auxiliary profile (1) has no actual prime-error cancellations. Whether the centered operator exists on the specific source $g(x)=(\psi(x)-x)/x$ requires its own arithmetic argument. This counterexample neither settles that domain question nor proves or refutes RH.
