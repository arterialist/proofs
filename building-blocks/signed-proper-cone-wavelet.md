# Signed proper-cone equipartition and the second-moment obstruction

The signed estimate identified here is **equivalent to RH**, not proved. The finite identities and counterexamples to a natural positivity extension are proved directly.

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

One direction follows immediately from the preceding relation. For the other, put $F=E-H$. An integer bound for $F$ extends between integers with an $O(\log(2x))$ adjustment from jumps of $\psi$. Almost everywhere, $(H(x)/x)'=F(x)/x^2$. Integrating from $x$ to infinity with the PNT boundary condition gives

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

## Provenance and limits

The finite proper-cone positivity and its large uniform slack are in the [proper-cone note](proper-prime-cone-zero-preserving-slack.md). The prime number theorem and the RH prime-error equivalence are recorded by the [NIST Digital Library of Mathematical Functions, §25.16(i)](https://dlmf.nist.gov/25.16.i). The divisor estimate is the elementary Dirichlet hyperbola method; the displayed finite counterexamples were enclosed with rational interval arithmetic as above. The signed equipartition is an exact restatement of the still-open square-root prime-error estimate, not an unconditional improvement.
