# Fixed-profile Green admissions oscillate along primes

This note gives an independently audited proof for the **fixed-profile limiting Green vectors**. It is not a statement about finite-$X$ admissions: that passage would require convergence uniform on the exponentially small scale $o(e^{-2p})$.

## Correct theorem

For a prime $p$, put

\[
 P_{p^-}=\prod_{\ell<p}\ell,\quad
 F_p=\sum_{d\mid P_{p^-}}\mu(d)G_d,\quad
 U_p=\sum_{e\mid P_{p^-}}\mu(e)G_{pe},
\]
\[
 G_d(y)=\frac{e^{-d}}{2d}e^{-|y-d|},\qquad
 \Delta_p=2(\|U_p\|^2-2\langle F_p,U_p\rangle),
\]
and
\[
 \mathcal T(x)=\sum_{n\le x}\mu(n)(x/n-1).
\]
Then, uniformly over primes $p$,

\[
 p e^{2p}\Delta_p=-\mathcal T(p)+E_p,
 \qquad |E_p|\le C_0,
\]

where $C_0$ is an absolute constant.  One completely explicit admissible constant is

\[
\begin{split}
C_0={}&\frac14+2+\frac{-\log(1-e^{-2})}{2}
 +\frac{e^{-2}(2-e^{-2})}{2(1-e^{-2})^2}\\
&+\frac{e^{-2}}{4(1-e^{-2})}
 +\frac{e^{-4}}{16(1-e^{-2})^2}
 +\frac{-\log(1-e^{-1})}{2(1-e^{-2})}.
\end{split}
\]

Consequently, for every $1/20<\delta<1/2$,

\[
 \limsup_{p\to\infty\atop p\ \mathrm{prime}}
 p^{1-\delta}e^{2p}\Delta_p=+\infty,
 \qquad
 \liminf_{p\to\infty\atop p\ \mathrm{prime}}
 p^{1-\delta}e^{2p}\Delta_p=-\infty.
\]

Thus the proposed eventual nonpositivity of these limiting natural Green admissions is false.

## Normalization and complete-face audit

Write $U_p=G_p+V_p$ and $\epsilon_p=\langle F_p,G_p\rangle$.  The doubled-energy convention gives exactly

\[
 \frac{\Delta_p}{2}=K_G(p,p)-2\epsilon_p+\mathcal D_p,
\]
\[
 \mathcal D_p=2\langle G_p,V_p\rangle+\|V_p\|^2-2\langle F_p,V_p\rangle.
\]

For

\[
 A_p=\sum_{d<p}\frac{\mu(d)}d,\quad
 M_p=\sum_{d<p}\mu(d),\quad
 B_p=\sum_{d<p}\frac{\mu(d)e^{-2d}}d,
\]

the lower rows give

\[
 \epsilon_p=\frac{e^{-2p}}{4p}
 [(p+1)A_p-M_p-B_p/2]+J_p
 =\frac{e^{-2p}}{4p}[\mathcal T(p)+A_p-B_p/2]+J_p.
\]

The row $d=p$ is not omitted: it does not divide $P_{p^-}$.  Its would-be contribution to $\mathcal T(p)$ is also zero.  Every squarefree $d<p$ occurs because all its prime factors are below `p`.

The upper/cofactor face is retained as

\[
 J_p=\sum_{d\mid P_{p^-},\ d>p}\mu(d)K_G(d,p),
\]

and, on writing $d=p+s$,

\[
 |J_p|\le \frac{e^{-2p}}{4p^2}
 \sum_{s\ge1}(s+1)e^{-2s}.
\]

All delayed $pe$ faces occur in $V_p$.  The literal all-face bounds

\[
 \|F_p\|\le\frac12\sum_{d\ge1}\frac{e^{-d}}d,
 \qquad
 \|V_p\|\le\frac{e^{-2p}}{4p(1-e^{-p})}
\]

make $pe^{2p}\mathcal D_p$ uniformly bounded.  Also
$|A_p|\le1+1/(p-1)\le2$, by
$\sum_{d\le n}\mu(d)\lfloor n/d\rfloor=1$, and $B_p$ is absolutely bounded.
After multiplying the displayed expansion by $2pe^{2p}$, its main term is exactly $-\mathcal T(p)$.  This checks both the minus sign and the factor of two.

The [companion checker](verification/fixed_profile_green_admission_check.py) evaluates the literal finite double sums.  For example, at $p=23$ it retains all 256 old faces and finds

```
T(23)                         = 1.9742281454355757761
23*exp(46)*Delta_23           = -1.9325563667484438815
scaled value + T(23)          = 0.041671778687131894596
```

This is a numerical audit of the algebra, not the proof of uniformity.

## Exact Mellin and two-sign argument

For $\operatorname{Re}s>1$, absolute Tonelli integration gives

\[
\begin{split}
 \int_1^\infty \mathcal T(x)x^{-s-1}\,dx
 &=\sum_{n\ge1}\mu(n)
   \int_n^\infty(x/n-1)x^{-s-1}\,dx\\
 &=\frac1{s(s-1)}\sum_{n\ge1}\frac{\mu(n)}{n^s}
 =\frac1{s(s-1)\zeta(s)}.
\end{split}
\]

The factor at $s=1$ is removable because $(s-1)\zeta(s)\to1$.
There are no real zeta zeros in $(0,1)$, while any known nonreal critical-line zero gives a genuine pole of this reciprocal Mellin transform.

The precise Landau use should be stated as follows.  Fix $0<\delta<1/2$ and $C>0$. If
$\mathcal T(x)+Cx^\delta$ were eventually nonnegative, apply Landau's theorem to that piecewise-continuous function with $\sigma_0=\delta$.  Its transform

\[
 \frac1{s(s-1)\zeta(s)}+\frac C{s-\delta}
\]

is analytic in a neighborhood of the open real ray $(\delta,\infty)$.  Landau therefore forces the defining integral to converge absolutely on $\operatorname{Re}s>\delta$, which is impossible because its continuation has a nonreal zeta-zero pole with real part $1/2>\delta$.  Applying the same argument to $-\mathcal T(x)+Cx^\delta$ gives

\[
 \limsup_{x\to\infty}\frac{\mathcal T(x)}{x^\delta}=+\infty,
 \qquad
 \liminf_{x\to\infty}\frac{\mathcal T(x)}{x^\delta}=-\infty.
\]

This is the needed two-sign theorem.  It is stronger than mere sign changes but weaker than an unconditional $\Omega_\pm(x^{1/2})$ assertion.  No simplicity or linear-independence hypothesis on zeta zeros is used.

## Prime interpolation audit

$\mathcal T$ is continuous and piecewise affine, with distributional curvature

\[
 \mathcal T''=\sum_{n\ge1}\frac{\mu(n)}n\,\delta_n.
\]

If $p<p'$ are consecutive primes, $h=p'-p$, and $L$ is the chord through the endpoint values, the Dirichlet Green kernel on $[p,p']$ gives

\[
 \sup_{p\le x\le p'}|\mathcal T(x)-L(x)|
 \le \frac h4\sum_{p<n<p'}\frac1n
 \le \frac{h(h+1)}{4p}.
\]

The unconditional Baker--Harman--Pintz gap estimate $h\ll p^{0.525}$ therefore makes the chord error $O(p^{0.05})$.  Hence for every $\delta>0.05$, a one-sided $O(p^\delta)$ bound at all primes would interpolate to the same one-sided bound for every real $x$, contradicting the Landau conclusion.  The strict threshold $\delta>1/20$ is essential to this proof; the cited prime-gap theorem does not give the endpoint $\delta=1/20$.

## Scope

The theorem concerns the exact limiting Green kernel and its full finite Boolean divisor packets.  It neither proves a sign statement for the finite-$X$ admission process nor supplies the exponentially uniform fixed-profile-to-finite-$X$ approximation needed for that transfer.  It also makes no RH claim.


## References

The oscillation step uses the classical Landau principle in the framework reviewed by Mahatab and Mukhopadhyay, [*Measure Theoretic Aspects of Oscillations of Error Terms*](https://arxiv.org/abs/1512.03144). The interpolation step uses Baker, Harman and Pintz, [*The Difference Between Consecutive Primes, II*](https://doi.org/10.1112/plms/83.3.532), which supplies a prime in $[x,x+x^{0.525}]$ for all sufficiently large $x$.
