# Two-prime obstruction to a global scalar gauge for Weil positivity

## Statement

Let $W$ be the actual Weil distribution for the Riemann zeta function, with its prime-power coefficients $-\Lambda(n)/\sqrt n$ at $t=\pm\log n$. Let $h:\mathbb R\to S^1$ be continuous, and conjugate the convolution form $Q_W(f,g)=W(f*\widetilde g)$ by multiplication with $h$. No such $h$ makes every off-diagonal coefficient of the conjugated kernel real and nonpositive. In particular, the actual Weil form cannot be converted into a Markov-type form merely by a continuous scalar phase gauge on the full line.

## Proof

The singular coefficient at a prime displacement $t=\log p$ is $-\log p/\sqrt p<0$. After conjugation its coefficient between $x$ and $x+\log p$ is

$$
-\frac{\log p}{\sqrt p}\,h(x+\log p)\overline{h(x)}.
$$

For it to be real and nonpositive at every $x$, its unit-modulus phase must be $1$. Hence $h(x+\log p)=h(x)$ for every prime $p$. Already $p=2,3$ suffice: $\log2/\log3$ is irrational, since a rational ratio would imply $2^a=3^b$ for some positive integers $a,b$. The additive subgroup $\mathbb Z\log2+\mathbb Z\log3$ is dense in $\mathbb R$. Continuity therefore makes $h$ constant.

For $0<t<\log2$, there are no prime-power atoms. Away from $t=0$, the continuous coefficient of the actual Weil distribution is

$$
w(t)=e^{t/2}+e^{-t/2}-\frac{e^{-t/2}}{1-e^{-2t}}
    =e^{t/2}-\frac{e^{-5t/2}}{1-e^{-2t}}.
$$

It is positive exactly when $e^{3t}-e^t-1>0$. If $r>1$ solves $r^3-r-1=0$, then $1<r<2$, so the interval $(\log r,\log2)$ has positive continuous off-diagonal coefficient. A constant phase gauge leaves that coefficient unchanged, contradicting the required nonpositivity. ∎

## Scope

This rules out one global phase-gauge route to a positivity-preserving semigroup. It does **not** assert that the Weil form has a negative eigenvalue, disprove RH, or rule out methods that use signed cancellation, a nonlocal transform, or finite-interval gauges with different boundary conditions. The sign formula comes from the actual Weil distribution in [Suzuki, *Weil's quadratic form via the screw function*, equation in the introduction](https://arxiv.org/html/2606.09096v1). The density-of-two-periods argument is elementary; no novelty claim is made.
