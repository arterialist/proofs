# Successor-clock discretization in localized trace norm

This is a written proof using the [semilocal negative-frequency Hardy convention](semilocal-weighted-scattering.md). It is not a Lean formalization.

Use the Hardy projection $P$ and Mellin-frequency variable $t$ of the semilocal scattering construction. For a unit-modulus multiplier $u$ and a fixed Schwartz function $\chi$, put

$$
N_\chi(u)=\|M_\chi(P-M_u^*PM_u)\|_1.
$$

The normalization agrees with [the weighted divided-difference factorization, section 3](semilocal-weighted-scattering.md) and [the complete-cutoff scattering phase, equation (5)](prime-discrepancy-scattering-norm.md). Those notes identify the Hardy convention with the local trace formula of Connes and Consani. Only the elementary kernel factorization is needed here.

For real $X\ge2$, define, with the integer endpoint included,

$$
\delta_X(t)=2\left[
\int_2^X\frac{\sin(t\log x)}{\sqrt x\log x}\,dx
-\sum_{2\le n\le X}\frac{\sin(t\log n)}{\sqrt n\log n}\right].
\tag{1}
$$

There is a real smooth function $\delta_\infty$ such that $\delta_X\to\delta_\infty$ locally in every smooth seminorm. For every fixed $j\ge0$,

$$
\sup_{X\ge2}|\delta_X^{(j)}(t)|+|\delta_\infty^{(j)}(t)|
\le C_j(1+|t|),
\tag{2}
$$

and the following localized trace estimates hold:

$$
\sup_{X\ge2}N_\chi(e^{i\delta_X})+N_\chi(e^{i\delta_\infty})<\infty,
\qquad
N_\chi(e^{i(\delta_X-\delta_\infty)})
\le C_\chi X^{-1/2}(1+\log X)^2.
\tag{3}
$$

No prime-counting estimate is used in these assertions.

## 1. Exact quadrature and derivative bounds

Put $f_j(x,t)=x^{-1/2}(\log x)^{j-1}\sin(t\log x+j\pi/2)$. This is the $j$th $t$ derivative of the integrand in (1). For $M=\lfloor X\rfloor$,

$$
\frac{\delta_X^{(j)}(t)}2
=\sum_{n=2}^M\left[\int_n^{n+1}f_j(x,t)\,dx-f_j(n,t)\right]
-\int_X^{M+1}f_j(x,t)\,dx.
\tag{4}
$$

This also holds when $X$ is an integer. The last integral then starts at that integer and retains its included summand.

Differentiation in $x$ gives

$$
|\partial_x f_j(x,t)|
\le x^{-3/2}\left[(\tfrac12+|t|)(\log x)^{j-1}
+|j-1|(\log x)^{j-2}\right].
$$

These bounds are integrable on $[2,\infty)$, uniformly on compact $t$ intervals. The infinite cell-error series defines $\delta_\infty$ and its derivatives. Equation (4) and its tail give (2), as well as

$$
|\partial_t^j(\delta_X-\delta_\infty)(t)|
\le C_j(1+|t|)X^{-1/2}(\log X)^{j-1}
\quad(j\ge0).
\tag{5}
$$

For $j=0$ the last factor means $1/\log X$.

## 2. The large-frequency estimate

The local bounds (5) alone are too crude in the far input column of a one-sided weighted kernel. A global weighted Fourier estimate supplies the missing control.

Let $h(x)=x^{-1/2}/\log x$ and $E(x)=\lfloor x\rfloor-x$. Define the convergent quadrature tail

$$
q(x)=\lim_{Y\to\infty}\left[\int_x^Yh(y)\,dy
-\sum_{x<n\le Y}h(n)\right]
=h(x)E(x)+\int_x^\infty E(y)h'(y)\,dy.
\tag{6}
$$

Stieltjes integration by parts proves (6), including its right-continuous endpoint convention. Since $|E|\le1$ and $h$ decreases to zero,

$$
|q(x)|\le2h(x).
\tag{7}
$$

Write $A=\log X$ and $J_A(a)=\mathbf1_{[A,\infty)}(a)q(e^a)$. The signed measure in the log variable corresponding to $h(x)\,dx-\sum_{n>X}h(n)\delta_n$ above the cutoff is, distributionally,

$$
\mu_X=q(X)\delta_A-dJ_A.
\tag{8}
$$

The boundary atom cancels the derivative's artificial atom at $A$; the actual integer at $X$ is excluded from this tail. Taking its Fourier transform with positive exponent, and using (1), gives the exact identity

$$
\delta_\infty(t)-\delta_X(t)
=2\operatorname{Im}\left[
q(X)e^{itA}+it\int_A^\infty q(e^a)e^{ita}\,da\right].
\tag{9}
$$

The tail primitive is integrable and square integrable. In fact

$$
|q(X)|^2\le\frac4{X\log^2X},\qquad
\|J_A\|_2^2\le4\int_A^\infty\frac{e^{-a}}{a^2}\,da
\le\frac4{X\log^2X}.
$$

Plancherel in (9), with $\int|\widehat J|^2=2\pi\int|J|^2$, therefore proves

$$
\int_{\mathbb R}\frac{|\delta_X(t)-\delta_\infty(t)|^2}{1+t^2}\,dt
\le\frac{96\pi}{X\log^2X}.
\tag{10}
$$

This estimate includes all real frequencies. It does not use a pointwise estimate for the zeta function or truncate a large-frequency region.

## 3. The unitary kernel estimate

The multiplier factors commute with $M_\chi$, so multiplication on the left by $M_u$ gives

$$
N_\chi(u)=\|M_\chi[P,M_u]\|_1.
\tag{11}
$$

Up to the fixed factor $-i/(2\pi)$, its kernel is

$$
K(t,s)=\chi(t)\frac{u(t)-u(s)}{t-s}.
$$

Here is a quantitative version of the weighted divided-difference argument. Suppose $v=u-1$ satisfies, for $j=0,1,2,3$,

$$
|v^{(j)}(t)|\le C\epsilon(1+|t|)^3,
\qquad
\left\|\frac{v(t)}{\sqrt{1+t^2}}\right\|_2\le C\epsilon.
\tag{12}
$$

Then

$$
N_\chi(u)\le C_\chi\epsilon.
\tag{13}
$$

To prove this, apply $L_t=1+t^2-\partial_t^2$ to $K$. In the region $|t-s|\le1$, the integral divided-difference formula and its first two $t$ derivatives use only $v',v'',v'''$ at points within distance one of $t$. Their $L^2(dt\,ds)$ norms are $O_\chi(\epsilon)$ by (12).

For $|t-s|\ge1$, put $b=t-s$. The three relevant quotients are

$$
\frac{v(t)-v(s)}b,\qquad
\frac{v'(t)}b-\frac{v(t)-v(s)}{b^2},\qquad
\frac{v''(t)}b-\frac{2v'(t)}{b^2}
+\frac{2(v(t)-v(s))}{b^3}.
$$

Terms depending only on $t$ have the required bound because $b^{-1}$ is square integrable on $|b|\ge1$. For the input-column terms use

$$
\int_{|t-s|\ge1}\frac{|v(s)|^2}{|t-s|^{2k}}\,ds
\le C(1+t^2)\int\frac{|v(s)|^2}{1+s^2}\,ds
\quad(k\ge1).
$$

The Schwartz factors and their first two derivatives absorb the remaining powers of $t$. Thus $\|L_tK\|_2\le C_\chi\epsilon$. The inverse $L_t^{-1}$ is Hilbert–Schmidt, with eigenvalues $(2n+2)^{-1}$. Factoring the kernel operator as $L_t^{-1}$ times the Hilbert–Schmidt operator with kernel $L_tK$ proves (13).

Take $\eta_X=\delta_X-\delta_\infty$, $u=e^{i\eta_X}$ and

$$
\epsilon_X=X^{-1/2}(1+\log X)^2.
$$

The chain rule and (5) prove the first inequality in (12), since $\epsilon_X$ is bounded for $X\ge2$. The inequality $|e^{i\eta_X}-1|\le|\eta_X|$ and (10) prove the second. This proves the vanishing estimate in (3). To prove the uniform estimate in (3), use (2), the chain rule and $|e^{i\delta_X}|=1$ directly in the same kernel argument. The far input column is bounded by $|e^{i\delta_X(s)}|=1$. The constants are independent of $X$; the argument also applies to $\delta_\infty$.

## 4. The exact successor normal form

After separating the fixed interval $0<a<\log2$, the stable rational factor and the gamma factor as in the [rational normalization](rational-scattering-pole-factor.md), the remaining actual semilocal phase is

$$
\theta_X(t)=2\int_2^X\frac{\sin(t\log x)}{\sqrt x\log x}\,dx
-2\sum_{2\le n\le X}\frac{\Lambda(n)\sin(t\log n)}{\sqrt n\log n}
-2\sum_{\substack{p\le X,\ k\ge2\\p^k>X}}
\frac{p^{-k/2}}k\sin(kt\log p).
$$

Subtracting the fixed phase $\delta_\infty$ gives exactly

$$
\theta_X(t)-\delta_\infty(t)=
-2\sum_{2\le n\le X}\frac{(\Lambda(n)-1)\sin(t\log n)}{\sqrt n\log n}
-2\sum_{\substack{p\le X,\ k\ge2\\p^k>X}}
\frac{p^{-k/2}}k\sin(kt\log p)
+\eta_X(t).
\tag{14}
$$

Every power of every admitted prime remains present. The last phase has the vanishing localized cost proved in (3). Subtracting the varying phase $\delta_X$ instead makes (14) exact without $\eta_X$, at uniformly bounded localized cost.

For commuting unitary multipliers, the conjugated defect identity gives

$$
|N_\chi(uv)-N_\chi(u)|\le N_\chi(v).
$$

Consequently (14) transfers the source's localized growth bounds and growth exponent to the successor-lattice form, with an additive $O_\chi(\epsilon_X)$ error after the fixed correction. This discretization establishes no new prime-discrepancy bound.

## 5. The divisor average and its origin term

Let $c(n)=1-\Lambda(n)$ for all $n\ge1$, including $c(1)=1$. The classical identity $\sum_{d\mid n}\Lambda(d)=\log n$ gives

$$
\sum_{d\mid n}c(d)=\tau(n)-\log n.
\tag{15}
$$

For the complete finite Dirichlet score $C_X(s)=\sum_{n\le X}c(n)n^{-s}$, this is equivalently

$$
\sum_{m\le X}m^{-s}C_{X/m}(s)
=\sum_{n\le X}(\tau(n)-\log n)n^{-s}.
$$

The $t$ derivative of the first sum in (14) is twice the real part of $C_X(1/2-it)-1$. Omitting the explicit origin term $1$ would change the divisor-average coefficients to $\tau(n)-1-\log n$.

If $D(q)=\sum_{n\le q}\tau(n)$ and the carry observable is $H(q)=\log(q!)-D(q)+2\gamma q$, then (15) sums to

$$
\sum_{n\le q}\sum_{d\mid n}c(d)=D(q)-\log(q!)=2\gamma q-H(q).
$$

This is an exact forward divisor average. No inverse estimate or subpower bound is asserted.

The [centered divisor-score theorem](coarse-divisor-scattering-storage.md) applies this exact forward divisor identity in the same localized trace norm. Its convergence does not supply an inverse estimate for the prime score.
