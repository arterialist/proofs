# Signed proper-cone equipartition and the second-moment obstruction

The signed estimate identified here is **equivalent to RH**, not proved. The finite identities and a counterexample to a natural positivity extension are proved directly.

## Exact signed conservation target

Use the proper-cone kernel $L_{X,f}(d)=\sum_{2\le m\le X/d}(f(dm)-\bar f_X)$ from the [proper-cone note](proper-prime-cone-zero-preserving-slack.md). For $f(n)=\log n$ write $\ell_X=X^{-1}\log(X!)$ and

$$P_X=\sum_{d\le X}\Lambda(d)L_{X,\log}(d),\qquad
N_X=\sum_{d\le X}L_{X,\log}(d).$$

Both are nonnegative. Dirichlet convolution gives the exact signed difference

$$P_X-N_X=B_X-A_X,$$

where

$$A_X=\sum_{n\le X}\Lambda(n)(\log n-\ell_X),\qquad
B_X=\sum_{n\le X}(\log n-\tau(n))(\log n-\ell_X).$$

Indeed $(\Lambda-1)*(1-\delta_1)=\log-\tau-\Lambda+1$, and the centered clock kills the final constant $1$. The elementary divisor hyperbola estimate $\sum_{n\le x}\tau(n)=x\log x+(2\gamma-1)x+O(\sqrt x)$, Stirling, and summation by parts give $B_X=O(\sqrt X)$: the centered weight removes the linear mean $-2\gamma$ of $\log n-\tau(n)$.

The prime number theorem implies $A_X=o(X)$. Thus $P_X=X+o(X)$ and $N_X=X+O(\sqrt X+\log^2X)$. The sought bound

$$|P_X-N_X|=O_\varepsilon(X^{1/2+\varepsilon})\quad\text{for every }\varepsilon>0$$

is an order-$X^{-1/2}$ relative equipartition of two positive cone energies. It is RH-equivalent, by the next argument. Their separate positivity and order-$X$ asymptotics do not prove it.

## Why the centered log score still detects every zero

Let $E(x)=\psi(x)-x$, $H(x)=\int_1^x E(u)\,du/u$. Partial summation and Stirling show, for integer $X$,

$$A_X=E(X)-H(X)+O(\log X).$$

The prime number theorem supplies $E(x)=o(x)$ and hence $H(x)/x\to0$. For any fixed $0<\theta<1$, the following are equivalent:

$$A_X=O(X^\theta)\quad\text{and}\quad E(X)=O(X^\theta).$$

One direction follows immediately from the preceding relation. For the other, put $F=E-H$. An integer bound for $F$ extends between integers with an $O(\log x)$ adjustment, because $\psi$ can jump by at most $\log x$ at an integer. Almost everywhere, $(H(x)/x)'=F(x)/x^2$. Integrating from $x$ to infinity with the PNT boundary condition gives

$$H(x)=-x\int_x^\infty\frac{F(u)}{u^2}\,du=O(x^\theta),$$

so $E=F+H=O(x^\theta)$. The standard equivalence between RH and $E(X)=O_\varepsilon(X^{1/2+\varepsilon})$ therefore gives the signed cone criterion above.

In the continuum approximation, the centered log clock has profile $w_1(u)=1+\log u$ for $0<u\le1$. Its Mellin transform is

$$\int_0^1u^{s-1}w_1(u)\,du=\frac{s-1}{s^2}.$$

It vanishes at the density pole $s=1$ and is nonzero at every nontrivial zeta zero. The factor $\zeta(s)-1$ from proper cofactors also equals $-1$ at a zeta zero. The exact finite Volterra inversion above verifies that centering has not hidden zero information.

## A second vanishing moment loses cone positivity

To remove the order-$X$ deterministic log budget as well as the density term, the natural next profile is

$$w_2(u)=(\log u)^2+4\log u+2.$$

Direct integration gives $\int_0^1w_2(u)\,du=\int_0^1w_2(u)\log u\,du=0$, while

$$\int_0^1u^{s-1}w_2(u)\,du=\frac{2(s-1)^2}{s^3}.$$

This still detects all nontrivial zeros. But the proper-cone response can be negative: for $X=50,d=3$,

$$\sum_{m=2}^{\lfloor50/3\rfloor}w_2(3m/50)=-1.83380500007020\ldots<0.$$

The issue is not an artifact of replacing finite centering by an integral. Put $y_n=\log n-\ell_X$, $v_X=X^{-1}\sum y_n^2$, $t_X=X^{-1}\sum y_n^3$, and $h_X(n)=y_n^2-v_X-(t_X/v_X)y_n$. Then $\sum_{n\le X}h_X(n)=\sum_{n\le X}\log n\,h_X(n)=0$ exactly. Yet

$$L_{20,h_{20}}(3)=-0.62422710555917\ldots<0.$$

Both signs can be certified without relying on floating-point rounding. For a positive rational $r$, put $z=(r-1)/(r+1)$ and use the rational truncation $2\sum_{j=0}^{99}z^{2j+1}/(2j+1)$ for $\log r$; the omitted tail has absolute value at most $2|z|^{201}/(201(1-z^2))$. Rational interval propagation gives $-0.625<L_{20,h_{20}}(3)<-0.623$ and $-1.834<\sum_{m=2}^{16}w_2(3m/50)<-1.833$. Thus both are strict finite counterexamples.

The twice-compensated clock is necessarily oscillatory: a nonzero real sequence orthogonal to both $1$ and the strictly increasing $\log n$ must have at least two sign changes. If it had at most one, an affine function of $\log n$ with the same sign pattern would have strictly positive inner product with it, contradicting both orthogonality conditions. The first compensated moment is compatible with increasing-concave cone order; this second moment is not. A new signed pairing or other cancellation estimate is needed to control its negative middle lobe.

**Universal twice-compensated cone sign theorem.** Let $w:(0,1]\to\mathbb R$ be measurable and not identically zero as an $L^1$ function, and assume

$$\int_0^1 |w(u)|(1+|\log u|^2)\,du<\infty,
\qquad \int_0^1w(u)\,du=\int_0^1w(u)\log u\,du=0.$$

Set $S_w(u)=\sum_{m\ge2,\,mu\le1}w(mu)$ for $0<u\le1/2$, and assume $S_w\in L^1(0,1/2)$. Then $S_w$ is positive on a set of positive measure and negative on a set of positive measure. In particular no nontrivial twice-compensated wavelet with an integrable proper-cone profile can satisfy a one-sided cone sign law.

To prove this, write $W(s)=\int_0^1u^{s-1}w(u)\,du$. For every real $s>1$, absolute convergence permits Fubini and gives

$$\int_0^{1/2}u^{s-1}S_w(u)\,du=(\zeta(s)-1)W(s).$$

The two vanishing moments and the weighted $L^1$ assumption imply $W(s)=O((s-1)^2)$ as $s\downarrow1$. Since $\zeta(s)-1\sim1/(s-1)$, the right side tends to zero. Dominated convergence on the left, using $S_w\in L^1$, gives $\int_0^{1/2}S_w(u)\,du=0$. If $S_w$ had only one sign almost everywhere, it would therefore vanish almost everywhere. The Mellin identity would then give $W(s)=0$ for every real $s>1$, because $\zeta(s)-1>0$ there. Uniqueness of the Laplace transform of $x\mapsto e^{-x}w(e^{-x})\in L^1(0,\infty)$ forces $w=0$ almost everywhere, a contradiction.

The integrability condition on $S_w$ is concrete. For example, it follows if $w$ is continuously differentiable on $(0,1]$, has zero integral, and for some finite $r$ obeys $|w(u)|+|u w'(u)|\le C(1+|\log u|^r)$: Euler summation gives $S_w(u)=O(1+|\log u|^{r+1})$. The displayed $w_2$ satisfies these hypotheses. The sign theorem is about the continuum-scale cofactor profile; it does not assert that every individual finite cone has both signs.

## The negative cones have macroscopic total mass

Write $S(u)=\sum_{2\le m\le\lfloor1/u\rfloor}w_2(mu)$ for $0<u\le1/2$, and $S_+(u)=\max(S(u),0)$, $S_-(u)=\max(-S(u),0)$. This is the continuum-scale score of a proper cone at $d\sim uX$. The negative region is not confined to tiny divisors: the certified value $S(3/50)<0$ above gives an open negative neighborhood of $u=0.06$, whereas $S(u)>0$ for $0.4\le u\le0.45$.

The prime number theorem gives the two separate limits

$$\frac1X\sum_{d\le X/2}\Lambda(d)S_\pm(d/X)
\longrightarrow c_\pm:=\int_0^{1/2}S_\pm(u)\,du.$$

Here prime powers of exponent at least two vanish after division by $X$. To justify passage through $u=0$, Euler summation and the two vanishing moments of $w_2$ give the uniform cone bound $S(u)=O(1+\log^2(1/u))$; Chebyshev's bound $\psi(y)=O(y)$ makes the part $d\le\alpha X$ at most $O(\alpha X[1+\log^2(1/\alpha)])$. On $[\alpha,1/2]$, $S_\pm$ are bounded and piecewise continuous, so ordinary PNT weighted summation applies.

In fact $c_+=c_->0$. One way to see equality directly is the Mellin identity, initially for $\Re s>1$,

$$\int_0^{1/2}u^{s-1}S(u)\,du
=(\zeta(s)-1)\frac{2(s-1)^2}{s^3}.$$

The bound $S(u)=O(1+\log^2(1/u))$ permits passage to $s=1$, where the right side is zero. Thus $\int_0^{1/2}S(u)\,du=0$ and $c_+=c_-$.

This contrasts with the first compensated clock $w_1(u)=1+\log u$: its proper-cone profile $S_1(u)=\sum_{m\ge2,\,mu\le1}w_1(mu)$ is nonnegative, and $(\zeta(s)-1)(s-1)/s^2\to1$ as $s\to1^+$. Hence $\int_0^{1/2}S_1(u)\,du=1$. The first Mellin zero cancels the zeta pole but leaves a positive extensive budget; the second zero cancels that budget and forces a signed balance.

The exact arithmetic convolution identity also gives

$$\sum_{d\le X/2}\Lambda(d)S(d/X)
=\sum_{n\le X}(\log n-\Lambda(n))w_2(n/X).$$

The logarithm sum on the right is $O(\log^3X)$ by Euler summation and $\int_0^1w_2=\int_0^1w_2\log u=0$; the prime sum is $o(X)$ by PNT. This gives an independent check of the zero total. Positivity of $c_+$ follows already from $S(u)>0$ on $[0.4,0.45]$. A finite Riemann-grid check suggests $c_\pm\approx0.55$, but no numerical value is needed for the argument.

Thus the positive and negative proper-prime-cone populations each carry a fixed positive multiple of $X$, while their signed difference is $o(X)$. Obtaining an $O(X^{1/2+\varepsilon})$ signed bound requires a relative square-root cancellation between these extensive populations; controlling the negative cones one by one cannot supply it.

There is nevertheless a rigorous gain from grouping by joint composite history *before* taking absolute values. At the integer level,

$$U_X:=\sum_{n\le X}(\log n-\Lambda(n))|w_2(n/X)|
\sim I\,X\log X,$$

where elementary summation and $\psi(X)=O(X)$ suffice, and

$$I=\int_0^1|w_2(u)|\,du
=4\left[(1+\sqrt2)e^{-2-\sqrt2}+(\sqrt2-1)e^{-2+\sqrt2}\right]
\approx1.24005.$$

After the proper-prime-cone grouping, the absolute mass is only

$$C_X:=\sum_{d\le X/2}\Lambda(d)|S(d/X)|\sim 2c_+X.$$

Thus the factorization geometry saves a full factor of $\log X$ in unsigned mass. The remaining order-$X$ cross-cone cancellation is exactly the hard part; this unconditional gain is not an RH-scale estimate.

## A one-sided signed bound would already imply RH

Let $T_2(X)=\sum_{n\le X}(\log n-\Lambda(n))w_2(n/X)$ for real $X\ge1$. For $\Re s>1$, absolute convergence permits interchanging the sum and integral, and the change of variable $u=n/X$ gives

$$\int_1^\infty T_2(X)X^{-s-1}\,dX
=\left(-\zeta'(s)+\frac{\zeta'(s)}{\zeta(s)}\right)
\frac{2(s-1)^2}{s^3}.$$

The double zero of the wavelet factor cancels the double and simple poles at $s=1$. At any nontrivial zero $\rho$ of multiplicity $m$, the right side has a pole with residue $2m(\rho-1)^2/\rho^3\ne0$. It is analytic on the real interval $(0,\infty)$: $\zeta$ has no real zero there, and the pole at $1$ has just canceled.

Fix $1/2<\theta<1$. If the **one-sided** inequality $T_2(X)\ge-C_\theta X^\theta$ held for all $X\ge1$, then $g(X)=T_2(X)+C_\theta X^\theta\ge0$. Its Mellin transform equals the preceding meromorphic function plus $C_\theta/(s-\theta)$. A Mellin transform of a nonnegative function must have a singularity at its real abscissa of convergence, unless it converges in every half-plane. This elementary Landau principle follows by expanding at a real $\sigma_0$ to the left: all Taylor coefficients after alternating the sign are nonnegative integrals of $g(X)(\log X)^kX^{-\sigma_0-1}$, so analytic continuation across a purported real abscissa would, by monotone convergence, force convergence farther left.

The displayed continuation has no real singularity for $s>\theta$. Therefore the nonnegative transform's convergence abscissa is at most $\theta$, and it is holomorphic throughout $\Re s>\theta$. No zeta zero can have real part greater than $\theta$. If such a one-sided estimate held for every $\theta=1/2+\varepsilon$, the functional equation would give RH. Conversely, RH gives the two-sided estimate $T_2(X)=O_\varepsilon(X^{1/2+\varepsilon})$ by partial summation of the standard $\psi$ bound and the deterministic $O(\log^3X)$ term. This is a precise target for joint-history cancellation, not a proved estimate.

## Provenance and limits

The finite proper-cone positivity and its large uniform slack are in the [proper-cone note](proper-prime-cone-zero-preserving-slack.md). The prime number theorem and the RH prime-error equivalence are recorded by the [NIST Digital Library of Mathematical Functions, §25.16(i)](https://dlmf.nist.gov/25.16.i). The divisor estimate is the elementary Dirichlet hyperbola method; the displayed finite counterexamples were enclosed with rational interval arithmetic as above. The signed equipartition is an exact restatement of the still-open square-root prime-error estimate, not an unconditional improvement.
