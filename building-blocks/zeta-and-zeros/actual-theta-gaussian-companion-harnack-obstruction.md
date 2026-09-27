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
