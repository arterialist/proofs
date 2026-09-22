# A complete Bernstein obstruction for the actual theta Mellin interpolation

For the complete Riemann theta kernel, a normalized Mellin transform is an entire function of order at most one and has a nonreal zero. A validated numerical inequality proves this statement. It follows that the actual coefficient interpolation is not a complete Bernstein function. In particular it cannot satisfy the Bernstein–Pick one-separation condition in Konstantopoulos–Patie–Sarkar's sufficient real-zero theorem.

The function tested here is **an auxiliary Mellin transform, not the Riemann xi function**. The result neither proves nor disproves RH. It does not exclude the larger classes $B_J$ or $D_P$. The proof combines analysis with an Arb certificate; it has no Lean formalization and makes no originality or first-publication claim.

## Definitions and statement

Use the full kernel

```math
\Phi(u)=\sum_{n=1}^{\infty}
 \left(4\pi^2n^4e^{9u/2}-6\pi n^2e^{5u/2}\right)
 e^{-\pi n^2e^{2u}},
\qquad
\Xi(z)=\int_{\mathbb R}\Phi(u)e^{izu}\,du.
```

This normalization is [Romik, equations (1.8) and (1.11)](https://math.ucdavis.edu/~romik/data/uploads/papers/riemannxi.pdf). The kernel is positive and even, is analytic near zero, and its derivatives decay faster than every Gaussian on the real axis. Its strict decrease on the positive axis is recorded, with a rescaled variable, in [Csordas, Theorem 2.1(v)](https://web.math.pmf.unizg.hr/glasnik/33.1/33105.pdf).

Set

```math
M(q)=2\int_0^\infty u^q\Phi(u)\,du\quad(\Re q>-1),
\qquad Z=M(0)=\Xi(0)>0,
```

and define initially for $\Re s>-1/2$

```math
F(s+1)=\frac{\sqrt\pi\,M(2s)}{4^s\Gamma(s+1/2)Z}.
\tag{1}
```

Outside this half-plane, the expression uses the meromorphic continuation of $M$ specified below. Define also, for real $s>-1/2$,

```math
\phi_{\mathrm{nat}}(s)=
 -\frac{4\int_0^\infty u^{2s-1}\Phi'(u)\,du}{M(2s)}.
\tag{2}
```

Both integrals in (2) converge, since $\Phi'(u)=O(u)$ near zero. Its denominator is positive and its numerator is strictly positive.

**Theorem.** The function $F$ extends to a real entire function of order at most one. It satisfies $F(-7)\ne0$ and

```math
(\log|F|)''(-7)>
\frac{37218077686879}{420224790585600}>\frac{177}{2000}>0.
\tag{3}
```

Consequently $F$ is not in the Laguerre–Pólya class and has a nonreal zero. Moreover $\phi_{\mathrm{nat}}$ is not a complete Bernstein function. In particular $\phi_{\mathrm{nat}}\notin B_{P1}$, where $B_{P1}$ is the precise Bernstein–Pick class with one-separation used in [KPS, equation (4.14) and Theorem 4.4](https://www.numdam.org/item/10.5802/aif.3600.pdf).

Here one-separation includes a meromorphic Pick continuation with real zeros $z_k$ and paired poles $\rho_k=z_k-1>z_{k+1}$, with the finite limiting cases understood as in that paper. The complete Bernstein exclusion is stronger than exclusion of this separated subclass. General Bernstein functions, whose Lévy densities need not be completely monotone, remain outside the conclusion.

## Entire continuation and growth

Write the even Taylor expansion near zero as

```math
\Phi(u)=\sum_{m\ge0}a_m u^{2m}.
```

Choose $0<r<\min(1,r_0/2)$ so that $\Phi$ is analytic on a disk larger than $|u|\le r_0$, and $|a_m|\le C r_0^{-2m}$. Taylor subtraction gives

```math
\begin{aligned}
M(2s)={}&2\int_r^\infty u^{2s}\Phi(u)\,du\\
&+2\int_0^r u^{2s}
 \left(\Phi(u)-\sum_{m=0}^{N}a_m u^{2m}\right)du
 +\sum_{m=0}^{N}\frac{a_m r^{2s+2m+1}}{s+m+1/2}.
\end{aligned}
\tag{4}
```

The identity is meromorphic for $\Re s>-N-3/2$. It continues $M(2s)$ to the plane, with only possible simple poles at $s=-m-1/2$ and residues $a_m$. The zeros of $1/\Gamma(s+1/2)$ cancel all these poles. Thus (1) is entire, real on the real line, and $F(1)=1$.

For completeness, its values at the canceled poles are

```math
F(1/2-m)=\frac{2\sqrt\pi\,4^m(-1)^m m!}{Z}\,a_m.
```

On $|s|=N$, every denominator in the finite sum in (4) has modulus at least $1/2$. The coefficient bound and Taylor remainder bound show that this sum and the subtracted integral are at most $e^{CN}$. On $[r,1]$ the first integral has the same bound. On $[1,\infty)$ use $|\Phi(u)|\le C e^{-u^2}$ to obtain the bound $C\Gamma(N+1/2)$. The reciprocal-gamma product similarly gives

```math
\max_{|s|=N}|F(s+1)|\le \exp\!\bigl(CN\log(N+2)\bigr).
\tag{5}
```

The maximum-modulus principle extends (5) to the enclosed disks, proving order at most one. The gamma product used here is [DLMF 5.8.2](https://dlmf.nist.gov/5.8.E2).

A nonzero real entire function of order at most one with only real zeros has the classical Hadamard factorization

```math
F(z)=Cz^m e^{az}\prod_k(1-z/r_k)e^{z/r_k},
\quad C,a,r_k\in\mathbb R,\quad r_k\ne0,\quad
\sum_k r_k^{-2}<\infty.
```

This is a Laguerre–Pólya factorization. At every real nonzero value of $F$ it implies

```math
(\log|F|)''(x)=-\frac{m}{x^2}-\sum_k\frac1{(x-r_k)^2}\le0,
\tag{6}
```

with the analytic interpretation at zero when appropriate. Equivalently, $F'(x)^2-F(x)F''(x)\ge0$. This proves both consequences for $F$ once (3) is established; negative values of $F$ cause no difficulty because the logarithm is $\log|F|$.

## Moment identification for any Bernstein candidate

A Bernstein function here is a nonnegative function on $(0,\infty)$ with completely monotone derivative, equivalently the Laplace exponent of a possibly killed subordinator. The identically zero function is irrelevant because (2) is strictly positive.

Integration by parts gives, for $s>1/2$,

```math
s\phi_{\mathrm{nat}}(s)=(2s)(2s-1)\frac{M(2s-2)}{M(2s)}.
\tag{7}
```

In particular these are the ratios of successive coefficients in
$\Xi(z)/Z=\sum_{n\ge0}(-1)^nM(2n)z^{2n}/[Z(2n)!]$.
If a Bernstein function $\phi$ matches these ratios, then

```math
\prod_{k=1}^n\phi(k)=\frac{(2n)!Z}{n!M(2n)}.
\tag{8}
```

Let $I_\phi=\int_0^\infty e^{-Y_t}dt$ be the exponential functional of the subordinator with exponent $\phi$, with the integral stopped at killing. Its moments are

```math
\mathbb E I_\phi^n=\frac{n!}{W_\phi(n+1)},
\qquad W_\phi(n+1)=\prod_{k=1}^n\phi(k).
```

Let $J=2\varepsilon\sqrt B$ be independent, with a symmetric sign $\varepsilon$ and $B\sim\operatorname{Beta}(1/2,1/2)$. Direct beta integration gives

```math
\mathbb E|J|^{2s}=
\frac{4^s\Gamma(s+1/2)}{\sqrt\pi\Gamma(s+1)},\qquad s>-1/2.
```

Thus $D=\sqrt{I_\phi}J$ is symmetric and, by (8), has even moments $M(2n)/Z$. The theta law $\Phi/Z$ has finite exponential absolute moments of every order. In particular, for every fixed $a>0$,
$M(2n)/Z\le C_a(2n)!a^{-2n}$, so its Carleman sum diverges. Moment determinacy identifies $D$ with the actual theta law. Consequently, for real $s>0$,

```math
F(s+1)=\frac{\mathbb E I_\phi^s}{\Gamma(s+1)}
       =\frac1{W_\phi(s+1)}.
\tag{9}
```

The last equality is the subordinator specialization of [Patie–Savov, Theorem 2.4(1), equation (2.23)](https://arxiv.org/pdf/1604.05960), with $\phi_-=1$ and $\phi_+=\phi$. Their Theorem 4.1(1) and product (4.7) give analyticity and absence of zeros of $W_\phi$ on $\Re z>0$. Analytic continuation of (9) therefore gives

```math
F(z)=1/W_\phi(z)\ne0\qquad(\Re z>0),
\qquad F(z)=\phi(z)F(z+1)\qquad(\Re z>0).
\tag{10}
```

For $s>1/2$, formula (1) and the gamma recurrence also give $F(s)/F(s+1)=\phi_{\mathrm{nat}}(s)$. Thus any such Bernstein candidate equals $\phi_{\mathrm{nat}}$ there, and hence on $(0,\infty)$ by analyticity. This establishes the needed uniqueness among Bernstein candidates, rather than assuming uniqueness of an arbitrary interpolation of integer data.

This argument also explains why a bare recurrence is insufficient: it does not by itself exclude multiplication of $F$ by a periodic factor. The actual probability law and moment determinacy establish (9).

## Excluding all complete Bernstein candidates

Use the analytic characterization of a complete Bernstein function on the slit plane $\Omega=\mathbb C\setminus(-\infty,0]$:

```math
\phi(z)=a+bz+\int_{(0,\infty)}\frac{z}{z+t}\,\rho(dt),
\qquad a,b\ge0,\quad \rho\ge0,\quad
\int_{(0,\infty)}\frac{\rho(dt)}{1+t}<\infty.
\tag{11}
```

This is the standard complete Bernstein representation, equivalent to the Pick characterization; see [Schilling–Song–Vondraček, Theorem 6.2](https://www.degruyterbrill.com/document/doi/10.1515/9783110215311.49/html). For nonreal $z$,

```math
\Im\phi(z)=\Im z\left[b+\int_{(0,\infty)}
                    \frac{t}{|z+t|^2}\rho(dt)\right].
```

If $b>0$ or $\rho\ne0$, this has the strict sign of $\Im z$. Otherwise $\phi=a>0$ is constant. Therefore a nonzero complete Bernstein candidate is finite and nonzero at every nonreal point.

Suppose now that $\phi_{\mathrm{nat}}$ were complete Bernstein. By (10), $F$ is zero-free on $\Re z>0$, and the recurrence $F(z)=\phi_{\mathrm{nat}}(z)F(z+1)$ holds there. Both sides are holomorphic on the connected slit plane $\Omega$, so the identity theorem extends the recurrence to that plane.

Equations (3)–(6) prove that $F$ has a nonreal zero $z_0$. The recurrence and $\phi_{\mathrm{nat}}(z_0)\ne0$ force $F(z_0+1)=0$. Repeating this step preserves the imaginary part and eventually reaches $\Re(z_0+n)>0$, contradicting (10). Hence

```math
\boxed{\phi_{\mathrm{nat}}\ \text{is not a complete Bernstein function}.}
\tag{12}
```

This argument uses the entire continuation of the actual $F$. It makes no corresponding assertion for arbitrary reciprocal Bernstein-gamma functions lacking such a continuation.

The primary comparison is exact. [KPS, Section 4.1](https://www.numdam.org/item/10.5802/aif.3600.pdf) asks whether the actual xi coefficients belong to their larger class $D_P$. Their Theorem 4.4 supplies a sufficient real-zero condition for $\Psi(s)=s\phi(s)$ with $\phi\in B_{P1}$, and explicitly distinguishes $D_P$ from the real-zero class. Their Section 5.2.6 continues $1/W_\phi$ using paired real zeros and poles. Equation (12) excludes their sufficient subclass even without imposing one-separation.

The larger $B_J$ question is unchanged. Its Lévy-density condition is nonincreasingness, which is weaker than complete monotonicity. The present proof does not exclude general Bernstein, $B_J$, or $D_P$ membership. It uses a Mellin transform in the Fourier variable $u$; this is not the ordinary Mellin variable in the classical integral representation of zeta. The auxiliary nonreal zero gives no nonreal zero of $\Xi$.

## The certified inequality

Write $\widetilde M(s)=M(2s)$ and differentiate with respect to $s$. The [certificate](../../certificates/theta_mellin_laguerre.py) proves

```math
-7281<\widetilde M(-8)<-7280,
\qquad 4902<\widetilde M'(-8)<4903,
\qquad -74929<\widetilde M''(-8)<-74928.
\tag{13}
```

Neither $s=-8$ nor $s+1/2=-15/2$ is a relevant Mellin or gamma pole. Therefore (1) gives

```math
(\log|F|)''(-7)=
\frac{\widetilde M''(-8)}{\widetilde M(-8)}
-\left(\frac{\widetilde M'(-8)}{\widetilde M(-8)}\right)^2
-\psi_1(-15/2).
```

The trigamma recurrence and its value at $1/2$ give
$\psi_1(-15/2)=\pi^2/2+4\sum_{j=1}^8(2j-1)^{-2}$; see [DLMF 5.15](https://dlmf.nist.gov/5.15). Thus (13) and $\pi<22/7$ imply

```math
(\log|F|)''(-7)>
\frac{74928}{7281}-\left(\frac{4903}{7280}\right)^2
-\frac12\left(\frac{22}{7}\right)^2
-4\sum_{j=1}^8\frac1{(2j-1)^2}
=\frac{37218077686879}{420224790585600}.
```

The script also encloses the curvature between $0.09327$ and $0.09328$. The proof uses only the coarse bounds (13) and the exact rational calculation above.

## All truncation and integration errors

Let $r=1/8$ and $\Phi(u)=\sum_{k\ge0}c_{2k}u^{2k}$. For $j=0,1,2$, the continued formula evaluated is

```math
\widetilde M^{(j)}(-8)=2\left[
\sum_{k=0}^{80}c_{2k}
 \left.\partial_s^j\frac{r^{2s+2k+1}}{2s+2k+1}\right|_{s=-8}
+\int_r^3u^{-16}(2\log u)^j\Phi(u)du+E_j\right].
\tag{14}
```

Every finite denominator is a nonzero odd integer. No divergent integral at zero is numerically evaluated.

The even Taylor coefficients through degree 160 are computed from theta terms $1\le n\le24$. For $p=\pi n^2$, expand $\exp(-p e^{2u})$ by

```math
b_j=-p\,2^j/j!,\qquad a_0=e^{-p},\qquad
 a_j=\frac1j\sum_{\ell=1}^j\ell b_\ell a_{j-\ell}.
```

Multiplication by $4p^2e^{9u/2}-6pe^{5u/2}$ gives the required coefficients. The finite theta sum is not assumed even; its even coefficients approximate those of the complete even kernel with the following error bounds.

### Coefficients on a complex disk

For $|u|\le1/2$, $\Re(e^{2u})\ge e^{-1}\cos1>1/6$. Elementary bounds $3<\pi<22/7$, $\pi^2<10$, $e^{9/4}<10$ and $e^{5/4}<4$ bound the modulus of the $n$th theta summand by

```math
476n^4e^{-n^2/2}.
```

For $n\ge4$ the ratio of successive terms of $n^4e^{-n^2/2}$ is less than $1/2$, and
$\sum_{n\ge1}n^4e^{-n^2/2}<1+3+2+512e^{-8}<7$.
Consequently $|\Phi(u)|<3332<10000$ on the disk. The omitted terms $n\ge25$ have disk norm at most

```math
\varepsilon_{\mathrm{disk}}=952\,25^4e^{-625/2}.
```

Cauchy's estimate bounds the error in coefficient of degree $k$ by $\varepsilon_{\mathrm{disk}}2^k$. For $p=k-15$, the three differentiated monomial factors in (14) are exactly

```math
A_{k,0}=\frac{r^p}{p},\qquad
A_{k,1}=\frac{2r^p}{p}\left(\log r-\frac1p\right),\qquad
A_{k,2}=\frac{4r^p}{p}
 \left[\left(\log r-\frac1p\right)^2+\frac1{p^2}\right].
```

The coefficient error for derivative $j$, before the outer factor two, is bounded by $\sum_{0\le k\le160,\ k\text{ even}}\varepsilon_{\mathrm{disk}}2^k|A_{k,j}|$.

### Taylor remainder below $1/8$

The disk bound gives

```math
\left|\Phi(u)-\sum_{k=0}^{80}c_{2k}u^{2k}\right|
\le\frac{10000(4u^2)^{81}}{1-4u^2}
\le\frac{16}{15}10000\,4^{81}u^{162}.
```

After multiplication by $u^{-16}$, use $p=147$, $L=-\log r$, and the exact positive integrals

```math
\int_0^r u^{p-1}(2|\log u|)^jdu
=\frac{r^p}{p}
\begin{cases}
1,&j=0,\\
2(L+1/p),&j=1,\\
4[(L+1/p)^2+1/p^2],&j=2.
\end{cases}
```

Multiplying by $(16/15)10000\,4^{81}$ gives the Taylor error before the outer factor two.

### Omitted theta terms on $[1/8,3]$

For real $u\ge0$ put $t=e^{2u}\ge1$. Each positive theta summand is at most
$4\pi^2n^4t^{9/4}e^{-\pi n^2t}\le40n^4e^{-3n^2}$,
since the expression in $t$ decreases. For $n\ge9$ the successive-term ratio is below $1/2$. Hence the omitted kernel after eight terms is at most $80\,9^4e^{-243}$, and certainly at most $160\,9^4e^{-243}$.

On this interval $u^{-16}\le r^{-16}$ and $(2|\log u|)^j\le25$. Including interval length less than three and the outer factor two, a common error bound is

```math
6r^{-16}\cdot25\cdot160\cdot9^4e^{-243}.
```

### The full tail beyond $3$

For $u\ge3$ and $j\le2$, $u^{-16}(2|\log u|)^j\le1$. Put $T=e^6$. Substitution $t=e^{2u}$ bounds the full tail by

```math
2\int_3^\infty\Phi(u)du
\le4\pi^2\int_T^\infty t^{5/4}\sum_{n\ge1}n^4e^{-\pi n^2t}dt.
```

The theta sum is at most $2e^{-\pi t}$ for $t\ge1$. Since $5/(4t)\le\pi/2$ for $t\ge T$,
$\int_T^\infty t^{5/4}e^{-\pi t}dt\le(2/\pi)T^{5/4}e^{-\pi T}$.
The resulting error, already including the outer factor two, is

```math
16\pi T^{5/4}e^{-\pi T}.
```

The script adds twice the coefficient and Taylor errors, plus the last two errors, to the Arb enclosure of each derivative. Their combined explicit radii are below $2.7\cdot10^{-81}$. Arithmetic and validated quadrature supply their own enclosing radii; the final three moment radii are below $3.4\cdot10^{-65}$ at the stated precision.

## Reproducing the certificate

From the repository root, with Python 3 and a compatible python-flint wheel:

```sh
python3 -m venv .venv-theta-mellin
.venv-theta-mellin/bin/python -m pip install python-flint==0.9.0
.venv-theta-mellin/bin/python certificates/theta_mellin_laguerre.py
```

Run normally, without Python's `-O` option, because the proof checks are assertions. The script uses 300-bit Arb arithmetic and validated complex integration over $[1/8,1/4]$, $[1/4,1/2]$, $[1/2,1]$, $[1,2]$ and $[2,3]$. Absolute and relative integration tolerances are $2^{-210}$, with evaluation limit 200000 and depth limit 40 per interval. A failure to establish the coarse inequalities stops execution. No data file or precomputed coefficient table is required.

The logarithm callback passes the integrator's analytic flag, as required by the [python-flint integration interface](https://python-flint.readthedocs.io/en/latest/acb.html#flint.acb.integral). The [FLINT complex integration documentation](https://flintlib.org/doc/acb_calc.html) describes the enclosing-ball contract. The certificate relies on that implementation and the explicit analytic tail estimates, not on agreement between floating-point approximations.

The mathematical ingredients are classical Mellin continuation, Cauchy estimates, Hadamard factorization and the Laguerre inequality, together with the Bernstein-gamma identity and complete Bernstein representation cited above. The proved obstruction concerns this actual auxiliary transform and all complete Bernstein coefficient interpolations; it leaves the Riemann hypothesis unresolved.

## Relation to the classical theta Mellin question

Csordas’s [1998 Problem 4, printed p. 49](https://web.math.pmf.unizg.hr/glasnik/33.1/33105.pdf) asks whether the meromorphic continuation of a theta square-root Mellin transform has only real negative zeros. In his normalization $\Phi_C(v)=\Phi(2v)/2$, write

```math
M_C(z)=\int_0^\infty t^{z-1}\Phi_C(\sqrt t)\,dt
=2^{-2z-1}M(2z-1),\qquad\Re z>0.
```

The change of variables is exact. Meromorphic continuation and the definition of $F$ give

```math
F(z+\tfrac12)=\frac{4\sqrt\pi}{Z\Gamma(z)}M_C(z).
```

At a nonreal point the gamma function is finite and nonzero. The nonreal zero of $F$ proved above therefore supplies a nonreal zero of the continued $M_C$, giving a negative answer to the stated all-real-negative-zero question. This is a consequence for an auxiliary Mellin transform, not for the zeros of $\Xi$.

There is a publicly accessible [numerical precursor](https://computoergosum.com/principia/run-2026-09.html) reporting $M_C$ zeros near $-7.9941822570\pm2.9377670686i$ and three further conjugate pairs. It explicitly describes double-precision calculations without interval certification. Those observations are not used in the proof here; the certificate establishes a Laguerre-inequality violation rather than enclosing one of the reported zeros. The page’s displayed date does not establish mathematical priority.

Csordas’s [2003 chapter, *Complex Zero Decreasing Sequences and the Riemann Hypothesis II*, pp. 121–134](https://link.springer.com/chapter/10.1007/978-1-4757-3741-7_9), treats this Mellin problem in §3. Its available publisher preview mentions Proposition 1, multiplier/complex-zero-decreasing conditions and a numerical Example 1. The full text was unavailable for this comparison, so overlap with its precise conclusions remains unresolved. No first-proof or originality claim is made. The recurrence and zero-propagation methods also have direct predecessors in KPS §5.2.6 and Patie–Savov; they are not claimed as new methods.

## Alternative direct Pick-sign certificate

A second certificate tests the Pick sign itself at one nonreal point. It
provides a shorter computational route to the exclusion of the natural
interpolation. It does not strengthen the complete Bernstein exclusion above.
The uniqueness argument in "Moment identification for any Bernstein candidate"
is still needed to exclude other complete Bernstein interpolations of the
same integer data.

Use a rescaled kernel and moment integral

$$
q(x)=\frac{\Phi(x/2)}{2\pi}
=\sum_{n\geq1}n^2(2\pi n^2e^x-3)e^{5x/4-\pi n^2e^x},
\qquad m(s)=\int_0^\infty x^{2s}q(x)\,dx.
$$

The moment integral initially converges for $\Re s>-1/2$. Its meromorphic
continuation defines

$$
\phi(s)=2(2s-1)\frac{m(s-1)}{m(s)}.
$$

Substitution $x=2u$ gives
$M(2s)=2\pi\,2^{-2s}m(s)$, so
$\phi_{\mathrm{nat}}(s)=4\phi(s)$. The certificate encloses

$$
-0.406130<\Im\phi(-29/4+i/2)<-0.406129<0.
$$

A Pick function is analytic on the upper half-plane with nonnegative
imaginary part there. This negative sign therefore excludes both $\phi$
and $\phi_{\mathrm{nat}}$ from the Pick class. The denominator is
nonzero at the specified point, as established by the integral enclosure
below. This additional certificate has no Lean formalization and makes no
priority claim.

### Convergent-integral formula

Define polynomials with rational coefficients by

$$
P_0(y)=2y-3,\qquad
P_{k+1}(y)=(5/4-y)P_k(y)+yP_k'(y).
$$

Termwise differentiation, justified by the Gaussian decay of the summands,
gives

$$
q^{(18)}(x)=\sum_{n\geq1}n^2P_{18}(\pi n^2e^x)
                            e^{5x/4-\pi n^2e^x}.
$$

Put $s_0=-29/4+i/2$ and

$$
I(s)=\int_0^\infty x^{2s+18}q^{(18)}(x)\,dx.
$$

Eighteen integrations by parts first give, for $\Re s>-1/2$,

$$
m(s)=\frac{I(s)}{\prod_{j=1}^{18}(2s+j)}.
$$

The right side continues meromorphically to $\Re s>-19/2$.
The integral defining $I(s)$ converges there because the derivative is
bounded near zero and decays faster than any exponential at infinity.
Consequently,

$$
\phi(s_0)=\frac{(2s_0+17)(2s_0+18)}{s_0}
                    \frac{I(s_0-1)}{I(s_0)}.
$$

Both integrals on the right converge ordinarily. Their powers of $x$
have real parts $3/2$ and $7/2$, respectively.

### Explicit tails

Write $P_{18}(y)=\sum_j c_jy^j$. Exact rational arithmetic verifies

$$
C=\sum_j|c_j|[2(j+2)]^{j+2}<10^{60}.
$$

For $x\geq0$ and $y=\pi n^2e^x$,
$n^2e^{5x/4}y^j\leq y^{j+2}$. Also
$y^ke^{-y/2}\leq(2k)^k$ for $k>0$. Therefore

$$
|q^{(18)}(x)|\leq C\sum_{n\geq1}e^{-\pi n^2e^x/2}<C.
$$

The certificate integrates only $1\leq n\leq12$ and
$\delta\leq x\leq8$, where $\delta=10^{-40}$.
For either exponent $a=3/2$ or $a=7/2$, the omitted lower integral is
bounded by

$$
C\int_0^\delta x^a\,dx
\leq \frac{C\delta^{5/2}}{5/2}<10^{-40}.
$$

On the finite interval, $\int_0^8x^a\,dx<3000$. Since consecutive
squares starting at $13^2$ differ by at least 27, the omitted modes
contribute at most

$$
3000C\sum_{n\geq13}e^{-\pi n^2/2}
\leq \frac{3000C e^{-169\pi/2}}{1-e^{-27\pi/2}}<10^{-51}.
$$

For $x\geq8$, $x^a\leq e^x$. Substitution $v=e^x$ bounds the
upper tail by

$$
C\sum_{n\geq1}\frac{2}{\pi n^2}e^{-\pi n^2e^8/2}
\leq\frac{2C}{\pi}\frac{e^{-b}}{1-e^{-3b}}<10^{-100},
\qquad b=\pi e^8/2.
$$

These are bounds for absolute complex errors, since the imaginary powers
of positive $x$ have modulus one. Adding a rectangle of radius
$10^{-35}$ in each coordinate to each computed integral encloses all
omitted contributions. The script checks the displayed numerical tail
bounds with ball arithmetic before dividing the integral enclosures.

### Reproducing the direct certificate

The [certificate script](../../certificates/theta_moment_ratio_pick_obstruction.py)
requires Python and `python-flint==0.9.0`. From the repository root, run

```sh
python -m pip install python-flint==0.9.0
python certificates/theta_moment_ratio_pick_obstruction.py
```

The default precision is 180 bits. A second run can use `--precision 256`.
The final check requires the whole imaginary-part enclosure to lie strictly
between the rational endpoints in the statement. An inconclusive enclosure
or a failed tail bound raises an error. The integration callback propagates
Arb's analyticity flag to the complex logarithm.

The computation relies on Python's exact rational arithmetic and the
correctness of the Arb implementation used by python-flint. It is not a
kernel-checked formal proof.
