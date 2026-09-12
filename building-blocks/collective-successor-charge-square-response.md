# The collective prime-square response of the successor charge observation

This written proof is a consumer of the [successor charge-cocycle](actual-successor-resonance-charge-cocycle.md) and the [complete centered birth kernel](centered-infinite-prime-birth-kernel.md). It separates an individual clock's zero ordinary mean from the nonzero collective half moment. There is no Lean or full-arithmetic sign claim.

The actual successor charge functional has kernel
$$
 \varphi(x)=\frac12\left[
     \frac{\mathbf1_{x\ge2}}{\sqrt{x-1}}
       -\frac{\mathbf1_{x\ge1}}{\sqrt x}\right].
\tag{1}
$$
It vanishes below one, belongs to $L^1\cap L^2$, has exact integral zero, and is $O(x^{-3/2})$ at infinity. On causal sources it is the relative charge $\delta(H)=Q(SH)-Q(H)$. We use the continuous functional $\ell(f)=\int\varphi(x)f(x)dx$; for a general birth response this is the successor-charge observation after causal compression. This changes the observation, not the full centered response.

For the actual infinite centered birth kernel $A=\mathcal C_\infty h_1$, set
$$
 r_\infty(t)=\ell(\mathcal C_\infty h_t)
        =\frac1t\int_1^\infty\varphi(x)A(x/t)dx.
\tag{2}
$$
The integral exists for every fixed $t>0$, by $\varphi\in L^2$ and $t^{-1}A(\cdot/t)\in L^2$. Finite centered prime cutoffs converge to (2), since their birth images converge in original $L^2$.

We prove the nonzero collective asymptotic
$$
 \boxed{r_\infty(t)\sim
 \frac{2\log((1+\sqrt2)/2)}{\sqrt t\log t}>0
                         \qquad(t\to\infty).}
\tag{3}
$$
Thus the exact zero mean of each individual prime-clock profile does not eliminate this collective leading response. The constant comes from a different Mellin moment, computed below.

## The two distinct moments of the actual observation

Direct integration to $R>2$ gives
$$
 \int_1^R\varphi(x)dx=\sqrt{R-1}-\sqrt R\longrightarrow0.
\tag{4}
$$
This is the zero ordinary moment. The critical half moment is absolutely convergent and equals
$$
 \begin{aligned}
 I_{1/2}&:=\int_1^\infty\varphi(x)x^{-1/2}dx\\
 &=\lim_{R\to\infty}\left[
   \operatorname{arcosh}\sqrt R-\operatorname{arcosh}\sqrt2
                                     -\tfrac12\log R\right]\\
 &=\log2-\log(1+\sqrt2)<0.
 \end{aligned}
\tag{5}
$$
Here $d(2\operatorname{arcosh}\sqrt x)/dx=1/\sqrt{x(x-1)}$, which evaluates the first integral. In particular the coefficient in (3) is $-2I_{1/2}$, not the vanishing moment in (4).

For comparison with the individual prime clocks, let
$$
 \widetilde d(y)=d(\max(1,y)),\qquad
 k(u)=e^u\widetilde d(e^u).
$$
The birth identity gives
$\widetilde d(y)=\int_{\max(1,y)}^\infty\varphi(x)x^{-1}dx$.
Fubini is absolutely justified for $0<\Re s<3/2$, and proves
$$
 \int_0^\infty\widetilde d(y)y^{s-1}dy
        =\frac1s\int_1^\infty\varphi(x)x^{s-1}dx.
\tag{6}
$$
At $s=1$ this vanishes by (4); at $s=1/2$ it is $2I_{1/2}\ne0$. Consequently each periodic profile
$$
 F_p(\theta)=-(1-1/p)\sum_{j\in\mathbb Z}k(\theta-j\log p)
\tag{7}
$$
has zero mean, since its integral over one period is $-(1-1/p)\int k=0$. Absolute convergence follows from $k(u)=O(e^u)$ as $u\to-\infty$, and $k(u)=O(e^{-u/2})$ as $u\to+\infty$. The nonzero half moment in (6) is compatible with zero mean over each prime's period. The full local formula, endpoint checks, nonzero modes, and its finite-source remainder are given in the [charge-cocycle theorem](actual-successor-resonance-charge-cocycle.md#6-this-specific-port-removes-the-mean-of-the-late-prime-return-profile); further fixed-prime refinements are separate.

## Passing the complete kernel asymptotic through the observation

The [proved actual kernel estimates](centered-infinite-prime-birth-kernel.md), obtained from the complete prime-square tail using the classical PNT, are
$$
 A(y)\sim-\frac2{\sqrt y\log(1/y)}\quad(y\downarrow0),
 \qquad |A(y)|\le\frac C{\sqrt y\log(1/y)}
                      \quad(0<y<\varepsilon),
 \qquad A\in L^2.
\tag{8}
$$
Every prime power is retained in this kernel. Its leading small-coordinate term was obtained from the complete prime-square tail; all other terms were estimated in proving (8).

Split (2) at $x=\sqrt t$. On $1\le x\le\sqrt t$, for large $t$, (8) gives
$$
 \frac{\log t}{\sqrt t}|A(x/t)|\le\frac C{\sqrt x},
$$
since $\log(t/x)\ge\tfrac12\log t$. For each fixed $x\ge1$,
$$
 \frac{\log t}{\sqrt t}A(x/t)\longrightarrow-\frac2{\sqrt x}.
$$
The absolute function $|\varphi(x)|/\sqrt x$ is integrable. Extend the truncated integrand by zero and use dominated convergence to obtain
$$
 \lim_{t\to\infty}\sqrt t\log t\,
  \frac1t\int_1^{\sqrt t}\varphi(x)A(x/t)dx=-2I_{1/2}.
\tag{9}
$$

The complementary tail is smaller without any smoothness assumption on $A$. Cauchy–Schwarz and $\varphi(x)=O(x^{-3/2})$ give
$$
 \begin{aligned}
 \left|\frac1t\int_{\sqrt t}^\infty
                      \varphi(x)A(x/t)dx\right|
 &\le t^{-1}\left(\int_{\sqrt t}^\infty|\varphi|^2\right)^{1/2}
                  \left(\int_{\sqrt t}^\infty|A(x/t)|^2dx\right)^{1/2}\\
 &\ll t^{-1}\,t^{-1/2}\,\sqrt t\|A\|_2
 =O(t^{-1}).
 \end{aligned}
\tag{10}
$$
After multiplication by $\sqrt t\log t$, this tends to zero. Equations (5), (9), and (10) prove (3).

The conclusion holds for the changed successor-charge observation with its full kernel and thresholds. It supplies no sign or convergence theorem for the compensated infinite arithmetic sum of these birth readouts. In particular the per-prime cancellation of the zero Fourier mode is exact, but the collective prime-square response has the positive nonzero coefficient in (3); these are different averaging operations and require different moments of the actual observation.
