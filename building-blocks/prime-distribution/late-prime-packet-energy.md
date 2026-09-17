# Coherent energy of complete late-prime packets

Whole late-prime packets can reinforce one another strongly. Their complete primitive energy cannot be bounded by a scale-independent multiple of the sum of their individual energies. This calculation uses actual smaller-scale prime errors and the exact divisor-forcing inverse.

Write

```math
H(q)=\log(q!)-\sum_{k\le q}\lfloor q/k\rfloor+2\gamma q,
\qquad E(u)=\psi(\lfloor u\rfloor)-\lfloor u\rfloor+2\gamma
\quad(u\ge1).
```

For $L>\sqrt{2X}$, let $a_L$ be zero off squarefree integers and, on squarefree integers, the sign determined by the number of prime factors at most $L$. Define

```math
F_{a_L}(t)=\sum_{d\le t}a_L(d)H(\lfloor t/d\rfloor),
\qquad R_L(t)=2\sum_{L<p\le t}E(t/p).
```

Every $d\le2X$ has at most one prime factor above $L$. If that factor is $p$, then $d=pm$, $m<L$, and the weight changes from $\mu(m)$ to $-\mu(m)$. Exact inversion of the complete $m$-packet therefore gives

```math
\boxed{E(t)=F_{a_L}(t)-R_L(t)\qquad(X\le t\le2X).}
\tag{1}
```

This is a later-history comparison. A prime still first arrives at its own integer $p$; no generator is being born anew at the later cutoff.

Use both chronological primitives,

```math
\mathbf P_Xf(T)=\left(\int_X^Tf(t)dt,\ \int_T^{2X}f(t)dt\right),
\quad
\mathcal Q_X(f)=\|\mathbf P_Xf\|_{L^2([X,2X];\mathbb R^2)}^2.
```

At the admissible choice $L=X>2$, every contributing quotient lies in $[1,2)$. Thus the actual error in every packet is exactly $c=2\gamma-1>0$, and

```math
R_X(t)=2c[\pi(t)-\pi(X)].
```

The exact prefix and suffix are

```math
A_X(T)=2c\sum_{X<p\le2X}(T-p)_+,
\qquad B_X(T)=A_X(2X)-A_X(T).
\tag{2}
```

They satisfy $A_X(X)=B_X(2X)=0$, and a prime at $2X$ contributes zero to these integrals. There are no omitted prime powers in the smaller argument: the interval $[1,2)$ contains only the integer state 1.

The full Gram matrix is explicit. For $p,q\in(X,2X]$, put $a_p=2X-p$, $b=\min(a_p,a_q)$, and $d=|p-q|$. The two entries are

```math
K^+_{p,q}=4c^2\left(\frac{b^3}{3}+\frac{db^2}{2}\right),
```


```math
K^-_{p,q}=4c^2\left[
Xa_pa_q-\frac{a_pa_q(a_p+a_q)}2
+\frac{b^3}{3}+\frac{db^2}{2}\right].
\tag{3}
```

They are nonnegative because they integrate products of the corresponding nonnegative primitives. No cross-prime term is dropped:

```math
\mathcal Q_X(R_X)=\sum_{p,q}(K^+_{p,q}+K^-_{p,q}).
```


Uniform PNT on the fixed scaled interval $[1,2]$, followed by integration, gives for $v=(T-X)/X$

```math
A_X(T)=\frac{cX^2}{\log X}(v^2+o(1)),
\quad B_X(T)=\frac{cX^2}{\log X}(1-v^2+o(1)),
```

uniformly for $0\le v\le1$. Therefore

```math
\boxed{\mathcal Q_X(R_X)\sim\frac{11c^2}{15}\frac{X^5}{\log^2X}.}
\tag{4}
```

The exact diagonal and its PNT asymptotic are

```math
\sum_p(K^+_{p,p}+K^-_{p,p})
=4c^2\sum_{X<p\le2X}\left[Xa_p^2-\frac{a_p^3}{3}\right]
\sim c^2\frac{X^4}{\log X}.
```

Hence

```math
\boxed{\frac{\text{complete packet energy}}{\text{sum of individual packet energies}}
\sim\frac{11X}{15\log X}.}
\tag{5}
```

In particular, a scale-uniform contraction based only on the independent smaller-scale packet energies is false.

The failure persists at every fixed fractional cutoff. Fix $0<\lambda\le1$, set $L=\lambda X$, and take $X$ large enough that $L>\sqrt{2X}$. On $1\le v\le2$, define

```math
r_\lambda(v)=2v\int_1^{v/\lambda}\frac{E(u)}{u^2}du.
```

Partitioning at the finitely many actual integer cells of $E$, uniform PNT gives

```math
R_{\lambda X}(Xv)=\frac X{\log X}(r_\lambda(v)+o(1)).
```

Thus

```math
\boxed{\mathcal Q_X(R_{\lambda X})
=(C_\lambda+o(1))\frac{X^5}{\log^2X},}
\tag{6}
```

where

```math
C_\lambda=\int_1^2\left[
\left(\int_1^v r_\lambda(s)ds\right)^2+
\left(\int_v^2r_\lambda(s)ds\right)^2\right]dv>0.
```

To prove strict positivity, a zero value would force both continuous primitives to vanish, and hence $r_\lambda=0$. Differentiating $r_\lambda(v)/v$ almost everywhere would then give $E=0$ almost everywhere on $(1/\lambda,2/\lambda)$. For $\lambda<1$, this interval has length greater than one and meets consecutive integer cells. Their error values differ by $\Lambda(n+1)-1\ne0$. For $\lambda=1$, $E=c>0$ on $(1,2)$. Both cases contradict the claimed vanishing.

The large packet energy is canceled in the actual arithmetic readout. The unconditional quantitative PNT gives

```math
\sup_{X\le t\le2X}|E(t)|=o(X/\log X),
\qquad\mathcal Q_X(E)=o(X^5/\log^2X).
```

For example, this follows from the estimates of [Johnston and Yang](https://arxiv.org/abs/2204.01980). Equation (1) consequently implies

```math
\|\mathbf P_XF_{a_{\lambda X}}\|^2
\sim\langle\mathbf P_XF_{a_{\lambda X}},\mathbf P_XR_{\lambda X}\rangle
\sim\|\mathbf P_XR_{\lambda X}\|^2.
\tag{7}
```

The bounded correction $2\gamma+\{t\}$ relating $E$ to the actual real prime error is lower order here and is not an RH-scale estimate.

Equations (4)–(7) exclude controlling the packet correction independently at any fixed fractional cutoff. They do not lower-bound the actual prime-error energy, exclude adaptive cutoffs with $L/X\to0$, or control the cancellation between the two terms in (1) at RH scale. The required interaction is their complete signed cross-correlation, not a sum of independent packet costs.

These are written consequences of exact Möbius inversion, integration and the classical prime number theorem. They are not Lean formalizations, and no priority claim is made. The cutoff-dependent weights $a_L$ are auxiliary; the complete inversion identity retains the actual prime-power error on its other side.
