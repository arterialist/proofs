# The actual mixed prime–density overlap correction

This is a written mathematical proof for the full finite cutoff law. Its conclusions concern the stated auxiliary comparison or generator, not a sign of the full Weil form.

The exact density score uses $S(n)=\sum_{d\mid n}\sqrt d\,\Lambda(d)=\sum_pm_p(n)$, $m_p(n)=\log p\sum_{j\le v_p(n)}p^{j/2}$ and $Q(z)=z^2/4-R(z)$, where $R(z)=z^{-1}\int_0^z(z-u)\log(1+u)du$ and $R(0)=0$. The full $W$ normalization and density baseline are those of the [allocation identity](prime-allocation-critical-identity.md). Here $\operatorname{id}_{-1}(n)=1/n$, $*$ denotes Dirichlet convolution, and $\mu$ is the Möbius function.


Fix $x>1$ and put

$$
\rho_x(n)=\frac{x-n}{\sqrt n}\mathbf1_{n<x},\qquad
\Gamma_x(d,e)=\sum_n\rho_x(n)\mathbf1_{[d,e]\mid n},
\qquad \mathcal K_x(d,e)=\Gamma_x(d,e)-\Gamma_x(de,de).
$$

All sums below are finite. Let $J=\mu*\operatorname{id}_{-1}$, so that
$\sum_{d\mid n}J(d)=1/n$, and let $c$ be any real divisor coefficient vector.
The mixed correction has the exact formula

$$
\boxed{
c^{\mathsf T}\mathcal K_xJ
=\sum_{n<x}\frac{\rho_x(n)}n
\sum_{d\mid n}(1-d)c(d).
}
\tag{1}
$$

Indeed, the Gram contribution is

$$
\sum_{n<x}\rho_x(n)
\left(\sum_{d\mid n}c(d)\right)
\left(\sum_{e\mid n}J(e)\right)
=\sum_{n<x}\frac{\rho_x(n)}n\sum_{d\mid n}c(d).
$$

For the product contribution, first sum over the divisors $e$ of $n/d$:

$$
\sum_{n<x}\rho_x(n)\sum_{de\mid n}c(d)J(e)
=\sum_{n<x}\rho_x(n)\sum_{d\mid n}c(d)\frac d n.
$$

Subtracting proves (1). Thus this mixed correction is nonpositive whenever
$c(d)\ge 0$ for $d\ge 2$. It is strictly negative if an active $d\ge 2$ has
$c(d)>0$. This argument does not impose an independence law on the prime
exponents.

For the actual prime coefficient $u(d)=\sqrt d\,\Lambda(d)$, every prime power
is retained, and (1) reads

$$
\boxed{
-u^{\mathsf T}\mathcal K_xJ
=\sum_{p^j<x}(p^j-1)\sqrt{p^j}\log p
\sum_{\substack{n<x\\p^j\mid n}}\frac{x-n}{n^{3/2}}>0
\quad(x>2).
}
\tag{2}
$$

The value is zero for $1<x\le 2$; an index at the cutoff has zero weight.
The coefficient at $1$ is harmless because the first correction row is zero.

## Its place in the complete square

The exact density-centered score is

$$
H_x(n)=S(n)-1-\frac{x/n-1}{2}
=\sum_{d\mid n}\ell_x(d),\qquad
\ell_x=u-\frac x2J-\frac12\delta_1.
$$

Consequently

$$
\boxed{
\ell_x^{\mathsf T}\mathcal K_x\ell_x
=u^{\mathsf T}\mathcal K_xu
+\frac{x^2}{4}J^{\mathsf T}\mathcal K_xJ
-x\,u^{\mathsf T}\mathcal K_xJ.
}
\tag{3}
$$

The first term has the [prime-chain positive square formula](prime-power-gram-correction.md).
The last term is positive for $x>2$ by (2). The remaining term is the
specific pure Jordan correction, not a general composite matrix problem.
In a comparison intended to upper-bound the full square by its product
version, the mixed term therefore has the adverse sign.

Equation (3) does not discard the original baseline or the scalar density
cost $Q$: the exact target remains

$$
\frac{W(x)}{Z_x}
=\mathbb E_x H_x^2-
\mathbb E_x\sum_p m_p^2-\mathbb E_xQ(x/n-1).
$$

Neither a sign of (3) nor the nonnegative prime-chain term establishes this
upper bound. The complete density contribution must still be paid.

## The specific pure Jordan correction has an RH-strength sign condition

Put $g=\mu*\operatorname{id}_{-1}*\operatorname{id}_{-1}$. Dirichlet convolution gives, exactly,

$$
g(p^k)=p^{-k}[(k+1)-kp],\qquad
D_J(x):=J^{\mathsf T}\mathcal K_xJ
=\sum_{n<x}\frac{x-n}{\sqrt n}[n^{-2}-g(n)].
\tag{4}
$$

Here $g(1)=1$, so the coefficient at $1$ vanishes. The local formula and
Bernoulli's inequality imply $|g(p^k)|\le 1$; multiplicativity gives
$|g(n)|\le 1$. Consequently $D_J(x)=O(x^{3/2})$.

For $\Re(s)>1/2$, absolute integration and the Euler products yield

$$
\boxed{
\int_1^\infty D_J(x)x^{-s-2}\,dx
=\frac{\zeta(s+5/2)-\zeta(s+3/2)^2/\zeta(s+1/2)}{s(s+1)}
=:L(s).
}
\tag{5}
$$

Every nontrivial zeta zero $\rho$ gives a genuine pole at $s=\rho-1/2$,
with its multiplicity preserved: $\zeta(\rho+1)$ is in the zero-free
half-plane $\Re>1$. There is no cancellation with the first term, and the
elementary denominator is nonzero there. On the positive real axis,
however, $L$ is analytic everywhere. At $s=1/2$, the pole of zeta in the
denominator becomes a zero of its reciprocal.

For completeness, the needed positivity principle is Landau's Laplace
argument: the Laplace transform of an eventually nonnegative function
with a finite convergence abscissa has a singularity at that real
abscissa. Remove the finite initial interval. If the transform were
analytic across the real abscissa, expand around a real point just to its
right. Its alternating derivatives are the nonnegative moments of the
tail. Monotone convergence of the Taylor expansion to the left would
then give a finite Laplace integral to the left of the asserted
abscissa, a contradiction.

Apply this to $F(t)=e^{-t}D_J(e^t)$, whose Laplace transform is (5).
An eventually nonnegative $D_J$ would have no positive convergence
abscissa, since (5) has no positive-real singularity. Thus (5) would be
analytic in the entire right half-plane. Its genuine poles then exclude
all zeros with $\Re(\rho)>1/2$; zeta zero symmetry gives

$$
\boxed{D_J(x)\ge0\text{ eventually}\quad\Longrightarrow\quad\mathrm{RH}.}
\tag{6}
$$

There is an unconditional orientation, without assuming (6). At zero,

$$
L(s)=C_0/s+O(1),\qquad
C_0=\zeta(5/2)-\frac{\zeta(3/2)^2}{\zeta(1/2)}>0.
$$

The constant is positive because $\zeta(1/2)<0$; the alternating eta series is positive there and $\eta(s)=(1-2^{1-s})\zeta(s)$. For $c<C_0$, eventual $F(t)\le c$ would make $c-F(t)$ eventually
nonnegative. Its transform has no positive-real singularity and has
negative residue $c-C_0$ at zero. The same positivity argument forces
its convergence abscissa to be zero: a negative abscissa would contradict
the pole there. But its nonnegative tail transform cannot tend to
negative infinity as $s$ decreases to zero. Therefore

$$
\boxed{\limsup_{x\to\infty}D_J(x)/x\ge C_0.}
\tag{7}
$$

In particular, $D_J$ cannot be eventually nonpositive. If RH is false,
it takes both signs arbitrarily far out. No converse to (6) is asserted.

## Exactly what the scalar density cost cancels

Write

$$
T_Q(x)=\sum_{n<x}\rho_x(n)Q(x/n-1),\qquad
\mathcal R(x)=\frac{x^2}{4}D_J(x)-T_Q(x).
$$

The scalar identity

$$
(t-1)Q(t-1)=t^3/4-(t^2/2)\log t-t/4
$$

cancels the whole $x^3\sum_{n<x}n^{-5/2}$ contribution. The result is

$$
\boxed{
\mathcal R(x)=P(x)-\frac{x^2}{4}G(x),\qquad
G(x)=\sum_{n<x}\rho_x(n)g(n),
}
\tag{8}
$$

$$
P(x)=\sum_{n<x}\sqrt n\,p(x/n),\qquad
p(t)=\frac t4[2t\log t-t+1].
$$

Since $t\ge 1$, one has $0\le p(t)\le t^2 \log(t)/2$. Thus

$$
0<P(x)\le\tfrac12\zeta(3/2)x^2\log x\qquad(x>1).
\tag{9}
$$

The remaining arithmetic term has not disappeared. Its exact Mellin
transform, initially for $\Re(s)>7/2$, is

$$
\boxed{
\int_1^\infty\mathcal R(x)x^{-s-1}\,dx
=\frac{s\zeta(s-1/2)}{4(s-1)(s-2)^2}
-\frac{\zeta(s-3/2)^2}{4(s-2)(s-3)\zeta(s-5/2)}.
}
\tag{10}
$$

Every nontrivial zero $\rho$ gives a genuine pole at $s=\rho+5/2$;
the numerator there is $\zeta(\rho+1)^2\ne 0$, and the positive density
term is analytic there. There is no real singularity above $3$.
The bound $|g(n)|\le 1$ gives $\mathcal R(x)=O(x^{7/2})$, so the convergence
abscissa is finite. Applying the same eventual-positivity principle to
either sign of $\mathcal R$ shows that either eventual fixed sign of $\mathcal R$ would
already imply RH.

Thus $Q$ removes the large density square exactly, while leaving a signed
divisor convolution with uncancelled reciprocal-zeta poles. This closes
the proposed separate comparison. It does not close the full target,
whose mixed prime--density and baseline terms remain in the original
identity.
