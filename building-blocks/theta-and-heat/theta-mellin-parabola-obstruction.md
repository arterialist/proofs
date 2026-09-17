# An actual theta Mellin zero outside a proposed multiplier region

The complete theta-derived Mellin function has a certified simple nonreal zero outside the region that would make each conjugate quadratic factor, individually, a classical multiplier sequence. This refutes that proposed sufficient condition for the actual function. It does not refute the Riemann Hypothesis or exclude multiplier preservation by groups of factors.

## Function and statement

Use the normalization

$$
\Phi(u)=\sum_{n\ge1}
\left(4\pi^2n^4e^{9u/2}-6\pi n^2e^{5u/2}\right)
e^{-\pi n^2e^{2u}},\qquad
M(q)=2\int_0^\infty u^q\Phi(u)\,du,\qquad Z=M(0).
$$

Initially the integral defining $M$ converges for $\Re q>-1$. Its meromorphic continuation gives

$$
H(s)=M(2s),\qquad
L(s)=F(s+1)=\frac{\sqrt\pi\,H(s)}{4^s\Gamma(s+1/2)Z}.
$$

The continuation and the fact that $L$ is real entire of order at most one are explained in the [theta Mellin obstruction](theta-mellin-bernstein-obstruction.md).

Let $c$ be the exact rational complex number with coordinates

$$
\Re c=-15.7411007975796356324473173878716903235743262045,
$$

$$
\Im c=11.4066450665758241266568702313955444990207623847,
\qquad R=2^{-140}.
$$

**Certified statement.** The disk $|s-c|<R$ contains exactly one zero of $H$, counted with multiplicity, hence one simple zero of $L$. Throughout its closure,

$$
(\Im s)^2+\Re s-\frac14
>114.1204508772589515903129518368.
$$

Thus this zero, written $-a+ib$, satisfies $b^2>a+1/4$.

## Complete-kernel certificate

The [Python/Arb source](../../certificates/theta_mellin_parabola_violation.py) uses 400-bit ball arithmetic. Its quadrature and coefficient computations are accompanied by bounds for every omitted theta summand and for the continuation remainder. The function being certified is the complete kernel, rather than a finite theta approximation.

On $0\le u\le r=1/8$, the script continues the even Taylor polynomial through degree $160$ by the identity

$$
\int_0^r u^{2s+k}\,du=\frac{r^{2s+k+1}}{2s+k+1}.
$$

The coefficients include theta summands $1\le n\le24$ and enclose the omitted coefficients by

$$
952\cdot25^4e^{-625/2}\,2^k.
$$

The complete kernel satisfies $|\Phi(u)|<10000$ on $|u|\le1/2$. Cauchy's estimate and evenness bound the remaining Taylor series on $[0,1/8]$ by

$$
\frac{16}{15}\,10000\,4^{81}u^{162}.
$$

This remainder and its first two derivatives with respect to $s$ are integrable uniformly on the disk, since

$$
2\inf_{|s-c|\le R}\Re s+163>0.
$$

On $[1/8,3]$, validated complex quadrature treats $1\le n\le8$. For each of the first three Mellin derivatives, the remaining theta summands contribute at most

$$
6U\cdot25\cdot160\cdot9^4e^{-243},
\qquad
U=\max\left(1,(1/8)^{2\sigma_-},3^{2\sigma_+}\right),
$$

where $\sigma_-$ and $\sigma_+$ enclose the real parts of the disk. For $u\ge3$, $\sigma_+\le-1$ implies
$u^{2\sigma_+}(2\log u)^j\le1$ for $0\le j\le2$.
With $T=e^6$, the complete remaining tail is bounded by

$$
16\pi T^{5/4}e^{-\pi T}.
$$

The source also encloses $H''$ uniformly on the disk, rather than only at its center. It verifies

$$
\sup_{|s-c|\le R}|H''(s)|<1.619649499124824\cdot10^{32},
$$

$$
|H(c)|+\frac{R^2}{2}\sup_{|s-c|\le R}|H''(s)|
<6.418\cdot10^{-53}
<3.049\cdot10^{-49}
<R|H'(c)|.
$$

Taylor's integral remainder and Rouché's theorem therefore compare $H(s)$ to $H'(c)(s-c)$ on the circle. The comparison function has exactly one simple zero. The prefactor relating $L$ to $H$ is holomorphic and nonzero on this nonreal disk, so the zero count transfers to $L$. Ball arithmetic separately verifies the stated strict parabola margin.

To reproduce the certificate, install Python 3 and python-flint 0.9.0, then run, without Python's optimization flag:

    python certificates/theta_mellin_parabola_violation.py

The source uses assertions for its rigorous comparisons. This is a computer-assisted analytic proof using Arb; it is not a Lean formalization.

## What the counterexample excludes

For $a>0$, the sequence

$$
q(n)=(n+a)^2+b^2
$$

has exponential generating function

$$
e^z\left(z^2+(2a+1)z+a^2+b^2\right).
$$

By the classical Pólya–Schur characterization, it is a multiplier sequence exactly when $b^2\le a+1/4$. The certified zero therefore excludes proving the multiplier property of $L(n)$ by requiring this condition of every individual nonreal pair.

It does not exclude a [grouped-factor construction](../analytic-methods/grouped-quadratic-multipliers.md): real factors can compensate a quadratic that fails the individual test. Neither such a factorization for the actual function nor RH follows from the present result.

## Attribution

The multiplier criterion and the distinction from complex-zero-decreasing sequences are classical; see Craven and Csordas, [*Problems and theorems in the theory of multiplier sequences*](https://math.hawaii.edu/~tom/mathfiles/serdica1.pdf), Sections 2–3. The complete theta Mellin function and its earlier literature are documented in the [existing obstruction note](theta-mellin-bernstein-obstruction.md).

This note contributes an explicit certificate against a specified sufficient condition. No claim of publication priority is made for the zero location, the numerical method, or the general multiplier theory.
