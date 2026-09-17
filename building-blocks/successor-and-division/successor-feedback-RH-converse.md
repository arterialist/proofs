# Conditional positive margin for the actual successor feedback

Let $E(r)=\sum_{j\ge0}e_jr^j$ be the literal signed successor driver from [the Abel-pole theorem](successor-feedback-tail-Abel-poles.md), with every prime power, density term, and clipped initial birth retained. We prove the conditional converse
$$
\boxed{\mathrm{RH}\ \Longrightarrow\ E(r)>\frac53
\quad\text{for all sufficiently large }r<1.}
\tag{1}
$$
Together with the proved forward implication, this gives an equivalence between RH and eventual nonnegativity (or positivity) of this specific feedback on a whole interval below one. It does not prove that arithmetic sign unconditionally.

The proof gives a full conditional oscillatory expansion and bounds all zero contributions, including multiplicities, without a numerical zero table. In particular the constant term receives no additional contribution from an index or clock correction.

## 1. Exact indexing and the kernel remainder under RH

Use
$$
g(y)=\frac{\psi(y)}y-1,\qquad
A(z)=\frac{-\zeta'(z+1/2)}{(z+1/2)\zeta(z+1/2)}-\frac1{z-1/2},
\quad D_e(z)=\sum_{j\ge0}\frac{e_j}{(j+1)^z}.
$$
The preceding proof establishes, initially for $1/2<\Re z<1$,
$$
D_e(z)=a_*(z)A(z)+R(z),\qquad
 a_*(z)=\frac{z-1/2}{2}\mathrm B(1-z,1/2),
\tag{2}
$$
$$
R(z)=-\frac12\int_1^\infty g(y)
\left[K_z'(y)-(1/2-z)\mathrm B(1-z,1/2)y^{-z-1/2}\right]dy,
$$
$$
K_z(y)=\int_0^{y-1}(\lfloor u\rfloor+1)^{-z}(y-u)^{-1/2}du.
\tag{3}
$$
The derivative is the a.e. derivative of a locally absolutely continuous kernel. No derivative of a PNT error is taken.

Assume RH. We import only its classical Chebyshev consequence
$$
|g(y)|\ll y^{-1/2}(1+\log y)^2.
\tag{4}
$$
An explicit version is given in Schoenfeld, *Sharper bounds for the Chebyshev functions theta(x) and psi(x). II*, Mathematics of Computation 30 (1976), 337–360, [DOI 10.1090/S0025-5718-1976-0457374-X](https://doi.org/10.1090/S0025-5718-1976-0457374-X). No numerical constant from that theorem is needed here.

The remainder in (3) now extends holomorphically to
$$
-\frac12<\Re z<1.
\tag{5}
$$
Here are the bounds needed for this extension and the later contour shift. Fix $0<\delta<1/2$ and $c<1$. Uniformly for $-\delta\le\sigma=\Re z\le c$, the step-weight error satisfies
$$
|(\lfloor u\rfloor+1)^{-z}-(u+1)^{-z}|
\le C_{\delta,c}(1+|z|)(u+1)^{-\sigma-1}.
$$
Its integral up to $y/2$ is at most $C_{\delta,c}(1+|z|)(1+\log y)y^\delta$. Splitting the differentiated error kernel at $y/2$, just as in the preceding proof, bounds its derivative by
$$
C_{\delta,c}(1+|z|)
 [y^{-3/2+\delta}(1+\log y)+y^{-1+\delta}].
\tag{6}
$$
The continuous beta endpoint estimates can be made explicit. Write
$$
L_z(y)=\int_0^1u^{-z}(y+1-u)^{-1/2}du,\qquad
U_z(y)=\int_0^1(y+1-v)^{-z}v^{-1/2}dv.
$$
These are exactly the lower and upper pieces omitted when completing $K_z^c$ to its beta integral. For $y\ge2$ and $-\delta\le\sigma\le c<1$,
$$
|L_z'(y)|\le\frac{y^{-3/2}}{2(1-c)},\qquad
|U_z'(y)|\le2|z|y^{-\sigma-1}\le2|z|y^{\delta-1}.
$$
In the first bound the derivative does not fall on $u^{-z}$; in the second it contributes the displayed single factor $z$. Also
$$
|(y+1)^{-z-1/2}-y^{-z-1/2}|
\le|z+1/2|y^{-\sigma-3/2}.
$$
The gamma quotient for $\mathrm B(1-z,1/2)$ gives
$$
|\mathrm B(1-\sigma-iT,1/2)|
\le C_{\delta,c}(1+|T|)^{-1/2}.
$$
The exponential factors of the two gamma functions cancel. Thus replacing $y+1$ by $y$ in the derivative of the full beta integral costs at most $C_{\delta,c}(1+|T|)^{3/2}y^{\delta-3/2}$. Together with (6), all bounds are polynomial in $|T|$; none uses an exponentially growing endpoint estimate. Multiplication by (4) makes them integrable at infinity since $\delta<1/2$. The bounded $y$ interval is holomorphic with the same kind of polynomial bounds. Thus dominated holomorphy proves (5), and on each such closed strip
$$
|R(\sigma+iT)|\le C_{\delta,c}(1+|T|)^B
\tag{7}
$$
with, for example, $B=2$.

At zero the cancellation is exact:
$$
K_0(y)=2(\sqrt y-1),\qquad K_0'(y)=y^{-1/2},\qquad
(1/2)\mathrm B(1,1/2)=1.
$$
Therefore
$$
\boxed{R(0)=0,\qquad D_e(0)=-\frac12A(0).}
\tag{8}
$$
This value refers to the continuation proved above, not to an assumed convergent ordinary sum of the $e_j$.

There is a particularly direct inverse transform keeping the index exactly right:
$$
\boxed{\int_0^\infty t^{z-1}e^{-t}E(e^{-t})dt
=\Gamma(z)D_e(z)\qquad(\Re z>1/2).}
\tag{9}
$$
Indeed $e^{-t}E(e^{-t})=\sum_{j\ge0}e_j e^{-(j+1)t}$. Absolute integration and summation follow from $|e_j|\ll\log(j+2)/\sqrt{j+1}$. Mellin inversion on any line $c\in(1/2,1)$ also follows termwise from the exponential Mellin inversion formula, since $\sum|e_j|(j+1)^{-c}<\infty$ and $\Gamma(c+iT)$ is integrable. Consequently no separate constant can enter through a $j$ versus $j+1$ shift, an initial $e_0$ subtraction, or the replacement of one boundary clock by another.

## 2. The exact constant and the critical-zero coefficient

The multiplier in the zero term is
$$
M(z)=\Gamma(z)a_*(z)
=\frac{\Gamma(z)(z-1/2)}2\mathrm B(1-z,1/2).
$$
The [gamma reflection and recurrence formulas](https://dlmf.nist.gov/5.5) give the useful exact simplification
$$
\boxed{M(z)=-\frac{\pi^{3/2}}{2\sin(\pi z)\Gamma(1/2-z)}
=-\frac{\sqrt\pi}{2}\Gamma(1/2+z)\cot(\pi z).}
\tag{10}
$$
At a critical zero $\rho=1/2+i\gamma$ of multiplicity $m_\rho$, the residue of $\Gamma(z)D_e(z)$ is therefore
$$
b_\rho=-\frac{m_\rho}{\rho}M(i\gamma).
\tag{11}
$$
Gamma reflection also gives, for real $\gamma\ne0$,
$$
\boxed{|M(i\gamma)|=\frac\pi2
\frac{\coth(\pi|\gamma|)}{\sqrt{\cosh(\pi\gamma)}}.}
\tag{12}
$$
This is exponentially small in the actual zero height; no zero coefficient is replaced by its linear Gaussian approximation or an omitted proper-power term.

By (8), the only real pole crossed at $z=0$ has residue
$$
\begin{aligned}
C_*&=-A(0)/2=\frac{\zeta'(1/2)}{\zeta(1/2)}-1\\
&=\frac12[\log\pi+\gamma_{\!E}+\pi/2+3\log2]-1>1.68.
\end{aligned}
\tag{13}
$$
Here $\gamma_E$ is Euler's constant, distinct from a zero ordinate. The [functional equation for xi](https://dlmf.nist.gov/25.4) gives its logarithmic derivative zero at $1/2$; the quarter-argument digamma value gives the last expression. This exact logarithmic-derivative value is also stated in [Suzuki, *On variants of Chebyshev’s conjecture* (2025), equation (47)](https://link.springer.com/article/10.1007/s11139-025-01238-9#Equ47). The value $\zeta(1/2)\ne0$ is unconditional. Equation (8) proves that $\Gamma(z)R(z)$ is regular at zero, so no remainder constant changes (13).

## 3. A bound for the entire zero series without computed zeros

All zero sums below run over distinct nontrivial zeros, include both signs of the ordinate, and carry the displayed multiplicity $m_\rho$ exactly once. Under RH the standard Hadamard/functional-equation identity becomes the positive identity
$$
\boxed{S_*:=\sum_\rho\frac{m_\rho}{1/4+\gamma^2}
=2+\gamma_E-\log(4\pi)<\frac1{20}.}
\tag{14}
$$
The corresponding unconditional identity is discussed explicitly in [Brent, *A sum over non-trivial zeros of the Riemann zeta-function*, slide 4](https://maths-people.anu.edu.au/~brent/pd/Brent-NTDU9.pdf). To fix the normalization, the canonical product gives
$\xi'/\xi(1)-\xi'/\xi(0)=\sum_\rho m_\rho/[\rho(1-\rho)]$; symmetry makes the left side $2\xi'/\xi(1)=2+\gamma_E-\log(4\pi)$. Under RH the summands are exactly those in (14).

Conjugate zeros occur in pairs. If some $|\gamma|\le6$, its pair alone would contribute at least $2/(36+1/4)=8/145>1/20$, contradicting (14). Thus
$$
|\gamma|>6
\tag{15}
$$
for every zero under RH, without using a computed first zero. For $y\ge6$, (12), $\cosh(\pi y)\ge e^{\pi y}/2$, and $\coth(\pi y)<2$ give
$$
\sqrt{y^2+1/4}|M(iy)|
\le\frac{13}{12}y\sqrt2\pi e^{-\pi y/2}
\le\frac{13}{2}\sqrt2\pi e^{-3\pi}.
$$
The last step uses the decreasing function $y e^{-\pi y/2}$ on this range. With the elementary inequalities $\sqrt2\pi<5$ and $e^{3\pi}>8000$, equations (11) and (14) imply
$$
\boxed{\sum_\rho|b_\rho|
\le S_*\frac{13}{2}\sqrt2\pi e^{-3\pi}
<\frac1{1000}.}
\tag{16}
$$
This controls the entire signed oscillatory contribution, rather than selected zeros. The coarse margins $C_*>1.68$ and $S_*<.05$ follow directly from the explicit elementary constants in (13)–(14); no zero certificate is involved.

## 4. Justified contour shift and the full conditional expansion

For every fixed $0<\delta<1/2$, we claim
$$
\boxed{E(e^{-t})=C_*+\sum_\rho b_\rho t^{-i\gamma}
+O_\delta(t^\delta)\qquad(t\downarrow0),}
\tag{17}
$$
where the sum converges absolutely and uniformly for all real $\log t$ by (16). We now justify the contour bounds needed for this statement.

The completed xi function has its canonical logarithmic derivative
$$
\frac{\xi'}\xi(s)=B_\xi+
\sum_\rho m_\rho\frac{s}{\rho(s-\rho)}.
\tag{18}
$$
The series is locally normally convergent away from zeros, and (14) bounds its squared-denominator sum. On the line $\Re s=1/2-\delta$, every zero is at horizontal distance at least $\delta$. Splitting (18) at $|\rho|=2|s|$ gives a polynomial bound in $|s|$: the near part is bounded using $|s-\rho|\ge\delta$ and $1/|\rho|\le2|s|/|\rho|^2$, while the far part is bounded by $2|s|\sum m_\rho/|\rho|^2$. The elementary gamma factors converting $\xi'/\xi$ to $\zeta'/\zeta$ also have polynomial bounds on this line, by Stirling's formula. Thus $A(-\delta+iT)$ is polynomially bounded.

One can choose horizontal contour heights without assuming an off-contour estimate. Equation (14) bounds the number of zeros with $|\gamma|\le2(n+2)$, counting multiplicity, by $O(n^2)$. Delete intervals of radius $n^{-4}$ about these ordinates from $[n,n+1]$. For all large $n$ their total length is less than one, so a height $T_n\in[n,n+1]$ remains. On the horizontal sides at $\pm T_n$, every relevant zero has distance at least $n^{-4}$. The same split of (18) now gives a polynomial bound uniformly on the finite real strip $-\delta\le\Re z\le c$, with $s=z+1/2$. Far zeros are automatically farther away. This argument includes all multiplicities.

Combining these bounds with (7), the gamma quotient formula for $a_*$, and the vertical Stirling bound
$$
|\Gamma(\sigma+iT)|\ll_{\delta,c}
(1+|T|)^{\sigma-1/2}e^{-\pi|T|/2}
$$
shows that the horizontal integrals of $\Gamma(z)D_e(z)t^{-z}$ vanish along the chosen heights. The integral on $\Re z=-\delta$ is absolutely convergent and bounded by $C_\delta t^\delta$. These estimates establish the required contour shift rather than presuming it from a formal residue calculation.

The crossed poles are precisely the simple gamma pole at zero, with residue $C_*$, and the logarithmic-derivative poles at the actual zeros $z=i\gamma$, with residues (11). There is no pole at $z=1/2$: the source expression has its filled cancellation there. No other gamma pole lies in the shifted strip. The absolutely convergent residue sum permits passage to the infinite-height limit. Equation (9) therefore gives
$$
e^{-t}E(e^{-t})=C_*+\sum_\rho b_\rho t^{-i\gamma}
+O_\delta(t^\delta).
$$
Multiplying by $e^t$ changes the bounded main terms by $O(t)$, absorbed into $O_\delta(t^\delta)$. This proves (17). The conjugate-zero pairing makes its main term real, but the proof of positivity uses the complete absolute bound (16), not a presumed phase sign.

## 5. Conditional margin and the resulting equivalence

Equations (13), (16), and (17) imply
$$
\liminf_{r\uparrow1}E(r)\ge C_*-\frac1{1000}>1.679>\frac53.
\tag{19}
$$
Here $t=-\log r\downarrow0$ in (17); there is no asymptotic change of the clock inside the oscillatory terms. This proves (1).

Combining this conditional result with the accepted forward Abel-pole argument yields
$$
\boxed{\mathrm{RH}
\iff E(r)\ge0\text{ throughout some interval }(r_0,1)
\iff E(r)>0\text{ throughout some interval }(r_0,1).}
\tag{20}
$$
Under RH the stronger eventual margin $5/3$ holds. No unconditional proof of either interval sign is supplied. The first-primitive positivity for small $r$ remains a different, proved parameter range; this converse does not extend it to the boundary without assuming RH.

A minor unconditional logical consequence is that $E$ cannot be eventually nonpositive: that sign would imply RH by the forward theorem, whereas RH gives (1). Thus positive feedback values occur arbitrarily close to one. This supplies no interval sign and no primitive positivity there. If RH is false, the forward theorem applied to either sign forces both positive and negative feedback values arbitrarily close to one.

The result calibrates the exact scalar response of the full arithmetic successor family. It does not replace the W source square by this scalar, assert pointwise W order, or remove its same-prime, density, charge, or mixed-history terms. RH itself remains unproved.


## 6. Exact boundary mean, nonzero variance, and the alternative to RH

Under RH, define the uniformly almost-periodic real function
$$
\mathcal F(h)=C_*+\sum_\rho b_\rho e^{i\gamma h}.
$$
For the exact logarithmic clock $r=e^{-e^{-h}}$, (17) gives
$$
E(e^{-e^{-h}})=\mathcal F(h)+O_\delta(e^{-\delta h}).
\tag{21}
$$
The same statement holds for the literal clock $r=1-e^{-h}$. Indeed $-\log(1-e^{-h})=e^{-h}(1+O(e^{-h}))$, and $\sum_\rho|\gamma b_\rho|<\infty$ by the exponential coefficient formula and (14). The resulting phase error is $O(e^{-h})$, absorbed in (21). Thus, writing $H(h)=E(1-e^{-h})$,
$$
\boxed{\lim_{T\to\infty}\frac1T\int_0^T H(h)dh=C_*,}
\tag{22}
$$
$$
\boxed{\lim_{T\to\infty}\frac1T\int_0^T|H(h)-C_*|^2dh
=\sum_\rho|b_\rho|^2>0.}
\tag{23}
$$
The series is indexed by distinct zeros with their full multiplicities in $b_\rho$. Under RH equal ordinates are therefore already grouped into a single coefficient, rather than counted as independent frequencies. The sums include both signs of each ordinate.

For proof, absolute uniform convergence permits approximation of $\mathcal F$ by finite trigonometric sums. Each nonzero exponential has mean zero, and two distinct ordinates are orthogonal in the long-interval mean. Taking the finite sums first and then using their uniform tails proves (22)–(23); the decaying remainder contributes zero to both means. The standard existence of critical zeros (indeed infinitely many, as recalled in [DLMF §25.10](https://dlmf.nist.gov/25.10)) ensures that at least one $b_\rho$ is nonzero: the multiplier in (10) is nonzero at every actual nonzero critical ordinate. Hence the variance is strictly positive. It follows that $E(r)$ does not converge as $r\uparrow1$: a finite limit would equal the mean $C_*$ and force the variance in (23) to vanish; infinite limits are excluded by the bounded expansion. This is a Bohr-mean calibration of the actual log-time response, not an independence hypothesis on zeros.

There is also a sharp unconditional alternative if RH fails:
$$
\boxed{\neg\mathrm{RH}\quad\Longrightarrow\quad
\limsup_{r\uparrow1}E(r)=+\infty,\qquad
\liminf_{r\uparrow1}E(r)=-\infty.}
\tag{24}
$$
Suppose, for example, $E(r)\le B$ throughout some final interval, where $B$ is any finite real number. Then $B-H(h)$ is nonnegative for all sufficiently large $h$. Its Laplace transform is $B/z-\mathfrak E(z)$, initially for $\Re z>1/2$, with an entire correction if the initial segment is removed. The source growth bound still makes its convergence set nonempty. On every positive real $z\le1/2$, this expression has exactly the same real-axis regularity as the established Abel transform; $B/z$ is regular there. The positive-tail Landau argument would therefore exclude all its off-critical poles and imply RH. The explicit multiplier at such poles is unchanged and nonzero. A lower bound $E(r)\ge B$ is treated with $H(h)-B$ in exactly the same way, with the sign of the nonzero residues reversed.

Thus under not-RH no upper or lower bound can hold on any final interval, which is precisely (24) in the extended-real sense. Combined with (21)–(23), a valid boundary estimate must allow bounded, nonconvergent oscillation with the specified positive mean under RH, and arbitrarily large excursions in both directions if RH is false. None of these deductions supplies the currently missing unconditional interval sign.

This is a written conditional proof. The general Landau obstruction is already formalized in the repository, but this arithmetic converse and its zero-series calibration are not claimed as Lean theorems.
