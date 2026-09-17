# A local signed average gain for the actual prime-error convolution

Let $\Lambda$ include every prime power, and write

$$
\psi(x)=\sum_{n\le x}\Lambda(n),\qquad E(x)=\psi(x)-x,
\qquad e_h=E(h)/h\quad(h\ge2),
$$

$$
Q_s=\sum_{\substack{m,h\ge2\\m+h=s}}\Lambda(m)e_h
\quad(s\ge4).
\tag{1}
$$

Use Bellotti's [independent Vinogradov--Korobov zero-free-region theorem](https://arxiv.org/abs/2306.10680):

$$
\Phi(x)=\frac{(\log x)^{3/5}}{(\log\log x)^{1/5}},\quad
A_0=\frac1{48.0718},\quad
d=\left(\frac{5^6A_0^3}{2^2 3^4}\right)^{1/5}
=0.212579202\ldots,
\tag{2}
$$

Johnston's [PNT transfer theorem](https://arxiv.org/html/2411.13791) then gives $|E(x)|\ll_\delta x e^{-(d-\delta)\Phi(x)}$ for every fixed $\delta>0$. Put

$$c_2=2^{2/5}d=0.280499938\ldots,
\qquad \kappa_0=2d-c_2=0.144658465\ldots.
\tag{3}$$

**Theorem.** For every fixed $\varepsilon>0$, integers $X\ge4$, and $1\le H\le X$,

$$
\boxed{\displaystyle
\left|\sum_{X<s\le X+H}Q_s\right|
\ll_\varepsilon
HX\exp[-(c_2-\varepsilon)\Phi(X)]
+X^2\exp[-(2d-\varepsilon)\Phi(X)].}
\tag{4}
$$

In particular, if $H\ge X\exp[-\kappa_0\Phi(X)]$, then

$$
\left|\frac1H\sum_{X<s\le X+H}Q_s\right|
\ll_\varepsilon X\exp[-(c_2-\varepsilon)\Phi(X)].
\tag{5}
$$

Thus sufficiently long, moving signed intervals gain the exponent $c_2>d$ over direct use of the prime-number-theorem error. This is an interval-average estimate. At $H=1$, the second term of (4) is too large to improve a pointwise estimate for $Q_s$.

**Proof status.** The analytic estimates below are written proofs. The [Lean finite-swap theorem](../../formalization/BuildingBlocks/GoldbachCofactorCumulativeFinite.lean) verifies the underlying complete-prime-power cumulative identity; it does not formalize the zero estimates or (4). This theorem makes no RH claim.

## A two-power zero sum

The zero-free region gives $\beta\le1-A_0u(|\gamma|)$ for large ordinates, where $u(T)=(\log T)^{-2/3}(\log\log T)^{-1/3}$. We combine it with the classical uniform Ingham estimate $N(\sigma,T)\ll T^{3(1-\sigma)/(2-\sigma)}(\log T)^5$, independently documented by [Chourasiya and Simonič](https://arxiv.org/html/2507.15184). For nontrivial zeros $\rho=\beta+i\gamma$, counted with multiplicity, these imply

$$
Z_2(x):=\sum_\rho\frac{x^{\beta-1}}{|\rho|^2}
\ll_\varepsilon e^{-(c_2-\varepsilon)\Phi(x)}.
\tag{6}
$$

Indeed, split a dyadic block $T\le|\gamma|<2T$ at $\beta=1-2A_0u(2T)$. Ingham bounds the number above that line by $M(T)\ll T^{6A_0u(2T)/(1+2A_0u(2T))}(\log(2T))^5$; those zeros contribute $O(M(T)x^{-A_0u(2T)}/T^2)$. The $O(T\log T)$ remaining zeros contribute $O((\log T)x^{-2A_0u(2T)}/T)$. The optimizer for a term $x^{-Au(T)}/T^k$ has exponent constant $(A/A_0)^{3/5}k^{2/5}d$. The two constants are $2^{2/5}d=c_2$ and $2^{3/5}d=0.322209818\ldots$, respectively. Up to height $\exp(C\Phi(x))$, $\log M(T)=o(\Phi(x))$ uniformly, so the dyadic count and $M(T)$ cost only an arbitrarily small $\varepsilon\Phi(x)$; above that height the trivial zero count gives a geometric tail. Finitely many low zeros contribute a power saving. This proves (6).

## The signed prefix and the exact moving endpoint

Define $B(n)=\sum_{h=2}^{n}e_h$. Soundararajan's [logarithmically weighted explicit formula, Lemma 1](https://annals.math.princeton.edu/wp-content/uploads/annals-v170-n2-p17-p.pdf) gives

$$
R_0(y):=\int_1^y\frac{E(t)}t\,dt
=-\sum_\rho\frac{y^\rho}{\rho^2}+O(1+\log y).
\tag{7}
$$

The zero series converges absolutely. On $h\le t<h+1$, $E(t)=E(h)-(t-h)$; since $E(h)=O(h)$, comparing $E(h)/h$ with $\int_h^{h+1}E(t)/t\,dt$ costs $O(1/h)$. Including the fixed initial and final intervals,

$$
B(n)=R_0(n)+O(\log n)
\ll_\varepsilon n e^{-(c_2-\varepsilon)\Phi(n)}.
\tag{8}
$$

The last step uses (6); the logarithmic error is absorbed for large $n$.

The exact finite swap gives, for $Y\ge4$,

$$
\begin{aligned}
\sum_{s=4}^{Y}Q_s&=L_Y+V_Y,\\
L_Y&=\sum_{h=2}^{Y-2}(Y-h)e_h,\\
V_Y&=\sum_{h=2}^{Y-2}e_hE(Y-h).
\end{aligned}
\tag{9}
$$

The upper endpoint matters: direct subtraction yields

$$
L_{Y+1}-L_Y
=\sum_{h=2}^{Y-2}e_h+2e_{Y-1}
=B(Y-1)+e_{Y-1}.
\tag{10}
$$

For $X\le Y\le2X$, (8) bounds $B(Y-1)$ by $O_\varepsilon(Xe^{-(c_2-\varepsilon)\Phi(X)})$. Johnston's PNT bound on $e_{Y-1}$ is smaller than this quantity. Summing (10) for $Y=X,\ldots,X+H-1$ gives

$$
|L_{X+H}-L_X|\ll_\varepsilon
HXe^{-(c_2-\varepsilon)\Phi(X)}.
\tag{11}
$$

The quadratic remainder satisfies $|V_Y|\ll_\delta Y^2e^{-2(d-\delta)\Phi(Y)}$ by splitting its sum at $h=Y/2$ and using Johnston's bound on both $E(h)$ and $E(Y-h)$; the slow variation of $e^{-(d-\delta)\Phi}$ controls the two resulting partial sums. This is proved in the [global cumulative note](actual-prime-error-convolution-global-cesaro-gain.md#exact-convolution-split-and-its-quadratic-remainder). Choose $\delta=\varepsilon/2$. Consequently, for $X\le Y\le2X$,

$$
|V_{X+H}-V_X|\ll_\varepsilon X^2e^{-(2d-\varepsilon)\Phi(X)}.
\tag{12}
$$

Equations (9), (11), and (12) prove (4). If $H\ge Xe^{-\kappa_0\Phi(X)}$, then $X^2e^{-(2d-\varepsilon)\Phi(X)}\le HXe^{-(c_2-\varepsilon)\Phi(X)}$, which proves (5). All constants implicit in the asymptotic bounds can absorb the finite initial range. The proof does not use the near-edge zero-density claim or sharp $\delta=0$ PNT estimate of Bellotti's later 2025 preprint.
