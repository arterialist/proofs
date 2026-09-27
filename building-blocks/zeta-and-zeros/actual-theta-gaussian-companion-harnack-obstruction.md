# Gaussian smoothing cannot give a Hermite–Biehler companion for the actual theta kernel

**Status: unconditional method obstruction, not progress toward RH.** A natural attempt pairs the undeformed Riemann Xi function with a Gaussian-smoothed odd theta transform. The pair fails the strict Hermite–Biehler inequality for every fixed positive smoothing parameter. This says nothing about zeros of Xi or other possible companions.

Use the root-coordinate theta kernel

$$
\Phi(u)=2\sum_{n\ge1}\pi n^2(2\pi n^2e^{2u}-3)
 e^{5u/2-\pi n^2e^{2u}},\qquad u\ge0.
$$

In this normalization, $A(z)=\int_0^\infty\Phi(u)\cos(zu)\,du=\Xi(z)/2$. The kernel and heat deformation are the complete theta series used in [D. H. J. Polymath, *Effective approximation of heat flow evolution of the Riemann xi function*](https://arxiv.org/abs/1904.12438), after doubling the Fourier variable. In particular, every theta term is retained. For $c>0$ define

$$
B_c(z)=\int_0^\infty u e^{-cu^2}\Phi(u)\sin(zu)\,du,
\qquad E_c(z)=A(z)-iB_c(z).
$$

**Theorem.** For every fixed $c>0$, $E_c$ is not a strict Hermite–Biehler function: the inequality $|E_c(z)|>|E_c^\#(z)|$ cannot hold for every $\operatorname{Im}z>0$, where $E_c^\#(z)=\overline{E_c(\bar z)}$.

**Proof.** Each summand of $\Phi$ is positive for $u\ge0$, since $2\pi n^2e^{2u}-3>0$. The $n=1$ term gives a constant $C>0$ such that

$$
\Phi(u)\ge C\exp(9u/2-\pi e^{2u})\qquad(u\ge0). \tag{1}
$$

The complete series is positive and decays doubly exponentially. Hence all transforms below are entire. On the positive imaginary axis, put

$$
R_c(y)=\frac{\int_0^\infty u e^{-cu^2}\Phi(u)\sinh(yu)\,du}
{\int_0^\infty\Phi(u)\cosh(yu)\,du}>0,
\qquad \frac{B_c(iy)}{A(iy)}=iR_c(y). \tag{2}
$$

We show that $R_c(y)=o(1/y)$. Let $u_1=(\log y)/8$ and $u_2=(\log y)/4$. By (1), integration over $[u_2,u_2+1]$ bounds the denominator $D(y)$ in (2) below by

$$
D(y)\ge C_1 y^{9/8}
 \exp\!\left(\frac y4\log y-\pi e^2\sqrt y\right). \tag{3}
$$

On $[0,u_1]$, use $\sinh(yu)\le e^{yu}/2$ and $\int_0^\infty u\Phi(u)\,du<\infty$. Dividing by (3), this portion of the numerator is at most

$$
C_2 y^{-9/8}\exp\!\left(-\frac y8\log y+\pi e^2\sqrt y\right)
=o(1/y).
$$

On $[u_1,\infty)$, the function $u e^{-cu^2}$ is decreasing once $u_1>(2c)^{-1/2}$. Since $\sinh(yu)\le\cosh(yu)$, the remaining portion divided by $D(y)$ is at most

$$
u_1e^{-cu_1^2}=\frac{\log y}{8}
 \exp\!\left(-\frac c{64}(\log y)^2\right)=o(y^{-N})
$$

for every fixed $N>0$. Thus $yR_c(y)\to0$.

Suppose now that $E_c$ were strict Hermite–Biehler. Then $A$ has no zero in the upper half-plane, because a zero would make $|E_c|=|E_c^\#|$ there. Moreover $q_c=B_c/A$ maps that half-plane into itself: direct expansion gives $|E_c|^2-|E_c^\#|^2=4|A|^2\operatorname{Im}q_c>0$. The positive harmonic function $\operatorname{Im}q_c$ obeys Harnack's inequality along the imaginary axis,

$$
\operatorname{Im}q_c(iy)\ge\frac{\operatorname{Im}q_c(i)}{y}
=\frac{R_c(1)}{y}>0\qquad(y\ge1). \tag{4}
$$

For completeness, (4) also follows from the Herglotz representation: each positive-measure term $y/(x^2+y^2)$ is at least $1/y$ times its value at $y=1$, and the nonnegative linear term strengthens the bound. Equations (2)–(3) instead give $y\operatorname{Im}q_c(iy)=yR_c(y)\to0$, a contradiction. $\square$

The obstruction is global and uses the actual completed theta kernel. It does not assert a real-zero boundary failure for every $c$, nor does it locate any nonreal zero of Xi. It closes this particular fixed-Gaussian odd-companion construction; it supplies no unconditional estimate of a signed Weil form or the prime error.

## A decay threshold for other odd companions

The same obstruction has a wider exact form. Let $v:[0,\infty)\to\mathbb R$ be locally bounded and satisfy $v(u)=o(e^{-2u})$. Define

$$
B_v(z)=\int_0^\infty v(u)\Phi(u)\sin(zu)\,du.
$$

Then $A-iB_v$ cannot satisfy the strict Hermite–Biehler inequality. To see the critical decay scale, write $D(y)=A(iy)=\xi(y+1/2)/2$ by the functional equation. For $s=y+1/2$ and sufficiently large $y$, the gamma recurrence gives the exact ratio

$$
\frac{D(y-2)}{D(y)}
=\frac{\xi(s-2)}{\xi(s)}
=\frac{2\pi(s-3)}{s(s-1)}\frac{\zeta(s-2)}{\zeta(s)}
=\frac{2\pi+o(1)}{y}. \tag{5}
$$

Because $e^{-2u}\cosh(yu)\le\cosh((y-2)u)$, equation (5) bounds the tilted average of $e^{-2u}$ by $(2\pi+o(1))/y$. Given $\eta>0$, choose $U$ with $|v(u)|\le\eta e^{-2u}$ for $u\ge U$. The contribution of this tail to $\operatorname{Im}(B_v(iy)/A(iy))$ is at most $\eta(2\pi+o(1))/y$. The contribution of $[0,U]$ is $O_U(e^{Uy}/D(y))=o(1/y)$: positivity of $\Phi$ on any interval above $U$ makes $D(y)$ grow faster than $e^{Uy}$. Letting $\eta\to0$ gives $y\operatorname{Im}(B_v(iy)/A(iy))\to0$. A strict Pick quotient would instead obey (4); if its imaginary part at $i$ were nonpositive, strict Pick would already fail. This proves the claim even for sign-changing $v$.

The endpoint of this argument is sharp as a growth test. If $v(u)=e^{-2u}$, the same computation, with $\sinh$ in place of $\cosh$, gives

$$
y\frac{\int_0^\infty e^{-2u}\Phi(u)\sinh(yu)\,du}{D(y)}
\longrightarrow 2\pi.
$$

The difference between this numerator and $D(y-2)$ is uniformly bounded, while $D(y)\to\infty$. Thus the Harnack contradiction does not exclude weights at the $e^{-2u}$ threshold or slower decay; it provides no positive Hermite–Biehler result for them.
