# Completed late-prime packets retain a macroscopic field

Let $N\to\infty$, fix $1/2\leq\alpha<1$, and put $z=N^\alpha$. Write

$$
F_z(x)=\sum_{\substack{n\leq x\\P^+(n)\leq z}}\mu(n),\qquad
R_z(x)=M(x)-F_z(x),\qquad
Z_N(f)=(1-e^{-2/N})\sum_{m\leq N}e^{-2m/N}f(m)^2.
$$

Because an integer at most $N$ has at most one prime factor greater than $z$,

$$
R_z(x)=-\sum_{z<p\leq N}M(\lfloor x/p\rfloor)
=:\sum_{z<p\leq N}H_p(x)\qquad(x\leq N). \tag{1}
$$

The summand $H_p$ includes **every** Möbius cofactor available under the observation horizon, rather than just the prime's unit birth.

For every fixed $\beta\in(\alpha,1)$, uniformly on $N^\beta\leq x\leq N$,

$$
R_z(x)=\frac{x}{(\log x)^2}+O_{\alpha,\beta}\!\left(\frac{x}{(\log x)^3}\right). \tag{2}
$$

Thus the completed packet has a positive macroscopic profile even though individual $H_p$ change sign when their cofactor histories develop. Its Abel energy is

$$
Z_N(R_z)\sim \kappa\frac{N^2}{(\log N)^4},\qquad
\kappa=2\int_0^1e^{-2t}t^2\,dt=\frac{1-5e^{-2}}2>0. \tag{3}
$$

The diagonal prime-channel energy is much smaller:

$$
\sum_{z<p\leq N}Z_N(H_p)
\ll \frac{N^2}{z\log z}
=o\!\left(\frac{N^2}{(\log N)^4}\right). \tag{4}
$$

Consequently the **aggregate covariance between distinct completed prime channels is positive**:

$$
2\sum_{z<p<q\leq N}\langle H_p,H_q\rangle_N
\sim\kappa\frac{N^2}{(\log N)^4}. \tag{5}
$$

Since the classical zero-free-region bounds imply $M(x)=o(x/(\log x)^2)$, (1)--(3) also force the opposite-sign compensation by the complementary small-prime history:

$$
Z_N(F_z)\sim\kappa\frac{N^2}{(\log N)^4},\qquad
\langle F_z,R_z\rangle_N\sim-\kappa\frac{N^2}{(\log N)^4}. \tag{6}
$$

Here $\langle f,g\rangle_N=(1-e^{-2/N})\sum_{m\leq N}e^{-2m/N}f(m)g(m)$. Equations (5)--(6) locate a necessary **nonlocal** cancellation: completing each late prime's available descendants does not make its packet small. Nor can one impose uniform negative covariance between distinct prime channels. The compensating covariance comes from the complementary arithmetic history. These estimates are unconditional and substantially above the RH energy scale; they do not establish RH-scale cancellation.

The packets $H_p$ regroup the rough-cofactor blocks of the [future-cone decomposition](rough-future-cone-covariance-load.md); their pair covariance is **not** the original blockwise $C_N(y)$. In particular, (5) does not settle the sign of that RH-equivalent cross term. The fixed-$\alpha<1$ result also does not cover a threshold tending to $N$.

## Direct proof of the packet profile

Set $Y=x/z$ and $L_x=\log x$. Reversing the sum in (1), with $\pi$ the prime-counting function, gives

$$
-R_z(x)=\sum_{k\leq Y}\mu(k)\{\pi(x/k)-\pi(z)\}. \tag{7}
$$

Uniformly for $x\in[N^\beta,N]$ we have $x/k\geq z$. The classical prime-number-theorem error $\pi(v)=\operatorname{li}(v)+O_A(v/(\log v)^A)$ therefore changes the right side of (7) by $O_{A,\alpha}(x/(\log N)^{A-1})$. The $\pi(z)$ error is included, using the trivial $|M(Y)|\leq Y$.

For the smooth comparison let $f(u)=\operatorname{li}(x/u)-\operatorname{li}(z)$. Crucially $f(Y)=0$ exactly, including when $Y$ is an integer. Abel summation has no endpoint remainder:

$$
\sum_{k\leq Y}\mu(k)f(k)
=x\int_1^Y\frac{M(u)}{u^2(L_x-\log u)}\,du. \tag{8}
$$

The standard zero-free-region consequence $M(u)\ll_B u/(\log(2u))^B$ for every fixed $B$ gives convergence of all fixed logarithmic moments in (8). The Mellin identity

$$
\frac1{s\zeta(s)}=\int_1^\infty M(u)u^{-s-1}\,du\qquad(\Re s>1)
$$

and the simple zero of $1/\zeta(s)$ at $s=1$ imply

$$
\int_1^\infty\frac{M(u)}{u^2}\,du=0,
\qquad
\int_1^\infty\frac{M(u)\log u}{u^2}\,du=-1. \tag{9}
$$

Expand

$$
\frac1{L_x-\log u}=\frac1{L_x}+\frac{\log u}{L_x^2}
+\frac{(\log u)^2}{L_x^2(L_x-\log u)}.
$$

Here $\log Y\geq(\beta-\alpha)\log N$ and $L_x-\log u\geq\log z\asymp\log N$. Taking $B$ large, the tails of the first two moments beyond $Y$ are smaller than $L_x^{-3}$, and the last integral contributes $O(L_x^{-3})$. Equations (7)--(9), with $A$ large, give (2).

For $m<N^\beta$, $|R_z(m)|\leq2m$ makes its contribution to $Z_N(R_z)$ at most $O(N^{3\beta-1})$, negligible relative to (3). On the remaining interval insert (2) and take a Riemann sum to obtain (3). Finally $|H_p(m)|\leq m/p$, so $Z_N(H_p)\ll N^2/p^2$; the prime number theorem gives $\sum_{p>z}p^{-2}\ll1/(z\log z)$, proving (4)--(5). The same classical Mertens estimate implies $Z_N(M)=o(N^2/(\log N)^4)$; Cauchy--Schwarz and $F_z=M-R_z$ yield (6).

## Relation to prior mathematics

The profile (2) is already contained, away from the endpoint $u=2$, in [de la Bretèche--Tenenbaum, *Friable averages of oscillating arithmetic functions*, Corollary 1.3](https://arxiv.org/pdf/2207.04777): for $f=\mu$, their $\psi_1$ is Buchstab's function, and $\psi_1'(u)=-1/u^2$ on $1<u<2$, giving $F_z(x)\sim-x/(\log x)^2$ in this regime. The direct Abel proof above handles the endpoint uniformly without relying on that paper's transition formula. The new point here is the explicit completed-packet energy and covariance reading (3)--(6) for the prime-channel decomposition used in this repository. Priority for that particular reading has not been established. The prime-number-theorem and arbitrary logarithmic-power Mertens estimates used in the direct proof are classical; effective bounds of the latter type were published by [El Marraki](https://jtnb.centre-mersenne.org/articles/10.5802/jtnb.149/). A mere $x/(\log x)^2$ bound, such as [Johnston--Leong--Tudzi, Theorem A.1](https://arxiv.org/html/2408.04143v3), is **not** enough for the second logarithmic moment in (8).
