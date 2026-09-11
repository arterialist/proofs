# Two failures of contraction in actual cyclotomic derivative histories

Let $\Phi_n$ be the $n$th cyclotomic polynomial, including $\Phi_1(z)=z-1$, and put

```math
F_N(z)=\prod_{n=1}^N\Phi_n(z),\qquad
L_{n,N}(a)=\log|F_N'(e^{2\pi ia/n})|\quad((a,n)=1,\ n\le N).
```

The roots are simple. At each cutoff, give a root the mean of its two adjacent angular gaps divided by $2\pi$. Denote that positive weight by $w_N(a/n)$. These are the actual circular Farey weights. Norm preservation or permutation of an unweighted orbit does not imply contraction of the resulting weighted convex observables. Two exact small examples isolate different failures.

## A weight permutation reverses every negative-power comparison

Put $\gamma=(1+\sqrt5)/2$, $u=\log\gamma$, and $\ell=\log10$. At conductor five the two conjugate-pair representatives $a=1,2$ have full derivative logarithms

```math
\begin{array}{c|ccc}
 &N=10&N=11&N=12\\ \hline
 a=1&\ell-u&\ell-u&\ell+u\\
 a=2&\ell+u&\ell+u&\ell-u.
\end{array}
```

Direct reduction modulo $\Phi_5$ gives

```math
F_{10}'(z)\equiv F_{11}'(z)\equiv10(z+z^4),
\qquad F_{12}'(z)\equiv10(1+z^4),
\qquad \Phi_{11}(z)\equiv1.
```

The identities $2\cos(2\pi/5)=\gamma^{-1}$ and $2\cos(\pi/5)=\gamma$ prove the table, with its physical phase labels retained. These remainders can be obtained by differentiating the finite product, or by the usual cyclotomic dilation identity; see [Bzdęga–Herrera-Poyatos–Moree, Lemma 2](https://archive.mpim-bonn.mpg.de/1705/1/preprint_2016_45.pdf).

At cutoff $12$, the neighbors of $1/5$ are $2/11$ and $2/9$, and the neighbors of $2/5$ are $3/8$ and $5/12$. Their reduced denominators sum to more than $12$ in each neighboring pair, so these are the Farey neighbors. Including each conjugate partner gives weights

```math
W_{12}(1)=2w_{12}(1/5)=\frac4{99},\qquad
W_{12}(2)=2w_{12}(2/5)=\frac1{24},
\qquad W_{12}(2)-W_{12}(1)=\frac1{792}.
```

The update at $11$ is zero at every phase. Thus, for every real $t$, the complete two-step old-root stop-loss response is exactly

```math
\begin{aligned}
J(t)&=\sum_{a\in(\mathbb Z/5\mathbb Z)^\times}
 w_{11}(a/5)\big([t-L_{5,11}(a)]_+-[t-L_{5,10}(a)]_+\big)\\
&\quad+\sum_a w_{12}(a/5)
\big([t-L_{5,12}(a)]_+-[t-L_{5,11}(a)]_+\big)\\
&=\frac1{792}\big([t-\ell+u]_+-[t-\ell-u]_+\big).
\end{aligned}
```

It is strictly positive for $t>\ell-u$. For every $s>0$ the corresponding negative-power response is

```math
\sum_a w_{12}(a/5)
\big(e^{-sL_{5,12}(a)}-e^{-sL_{5,11}(a)}\big)
=\frac{10^{-s}}{792}(\gamma^s-\gamma^{-s})>0.
```

The unweighted endpoint distributions are identical: this is exactly a phase permutation. Yet the actual weights turn that permutation into strict expansion. All displayed logs are positive, so the zero-threshold deficit response is zero. The example does not claim deficit creation.

## Even the unweighted soft determinant can increase

For an odd conductor, take one representative of each conjugate pair and define

```math
R_{n,N}(T)=\prod_{a\bmod\pm1}\big(T+|F_N'(\zeta_n^a)|^2\big),
\qquad
\mathcal S_{n,N}(s)=\frac12\log\frac{R_{n,N}(s)}{R_{n,N}(0)}.
```

At conductor seven, direct polynomial reduction gives

```math
F_8'(z)\equiv7z^3,
\qquad F_{10}'(z)\equiv-7(z^5+z^4+z^2+1),
```

```math
\Phi_9(z)\Phi_{10}(z)\equiv1+z^3+z^5\pmod{\Phi_7(z)}.
```

The full scalar is seven at both cutoffs. For $y=\zeta_7+\zeta_7^{-1}$,

```math
y^3+y^2-2y-1=0,
\qquad |1+\zeta_7^3+\zeta_7^5|^2=y^2-y.
```

Writing $x=y^2-y$, its three conjugates have elementary symmetric functions $6,5,1$. Indeed $\operatorname{Tr}y=-1$, $\operatorname{Tr}y^2=5$, and $x^2=6y^2-5y-3$, so $\operatorname{Tr}x=6$, $\operatorname{Tr}x^2=26$ and the second symmetric function is five. Also $\operatorname{Norm}y=\operatorname{Norm}(y-1)=1$. Therefore

```math
R_{7,8}(T)=(T+49)^3,
\qquad R_{7,10}(T)=T^3+294T^2+12005T+117649.
```

Their constant terms agree, but

```math
R_{7,10}(s)-R_{7,8}(s)=147s^2+4802s>0\qquad(s>0).
```

Consequently $\mathcal S_{7,10}(s)>\mathcal S_{7,8}(s)$ at every positive scale. This is redistribution of actual derivative units at unchanged scalar, rather than scalar growth. All full derivative magnitudes still exceed one: the sum of their squared reciprocals at cutoff ten is $5/49<1$. Again, this smooth-observable counterexample does not create a positive zero-threshold deficit.

These examples use classical cyclotomic identities and exact finite algebra. They distinguish weighted convexity, unweighted orbit invariance, and clipped derivative deficits. They do not provide an asymptotic bound or make a priority or RH claim.
