# Profinite Haar independence does not control the finite prime successor orbit

**Status:** unconditional written obstruction, 20 September 2026.

This note tests a direct dynamical model of the arithmetic intuition behind
the project. Addition by one is the odometer on the profinite integers, while
divisibility by distinct primes is independent under Haar measure. That
independence is spatial. It does not make successive points of the odometer
independent. At the sieving depth needed to detect primes, the Haar mean and
the finite-orbit mean differ by a nonzero constant. The resulting
twice-integrated discrepancy has the full elementary scale $X^5$.

The result rules out a power-saving argument based only on replacing the
finite successor orbit by Haar measure. It does not rule out an argument that
adds a new signed arithmetic correlation estimate. The related
[finite-prefix refinement](../successor-and-division/actual-prefix-refinement.md)
computes the same change of measure at the level of residue towers.

## The successor operator

Let $G=\widehat{\mathbb Z}$, let $\mu_G$ be its Haar probability measure, and
put

$$
 Uf(x)=f(x+1).
$$

For an integer $X\ge1$, define the double-prefix operator

$$
 (\mathcal K_Xf)_m(x)
 =\sum_{k=X}^{X+m-1}\sum_{n=1}^{k}f(x+n),
 \qquad 1\le m\le X,
$$

and write

$$
 A_m=\sum_{k=X}^{X+m-1}k
 =mX+\frac{m(m-1)}2.
 \tag{1}
$$

For the arithmetic forcing $b(n)=\Lambda(n)-1$, the integer primitive in the
coarse-energy problem satisfies the exact identity

$$
 P(m)=(\mathcal K_Xb)_m(0)-\frac m2.
 \tag{2}
$$

The last term is the integral of $\lfloor t\rfloor-t$ across $m$ unit
intervals.

## Sharp $X^5$ norm on mean-zero cylinders

The continuous characters of $G$ are

$$
 \chi_\alpha(x)=e(\alpha x),
 \qquad \alpha\in\mathbb Q/\mathbb Z.
$$

They diagonalize $U$. On $\chi_\alpha$, the multiplier of the $m$-th
component of $\mathcal K_X$ is

$$
 H_{X,m}(\alpha)
 =\sum_{k=X}^{X+m-1}\sum_{n=1}^{k}e(n\alpha).
 \tag{3}
$$

Since $|H_{X,m}(\alpha)|\le A_m$, orthogonality of the characters gives

$$
 \|\mathcal K_X\|_{L^2_0(G)\to L^2(G;\ell^2_m)}^2
 \le \sum_{m=1}^{X}A_m^2.
$$

Conversely, the nontrivial rational characters $\chi_{1/q}$ are mean zero
and $H_{X,m}(1/q)\to A_m$ as $q\to\infty$. Hence

$$
 \boxed{
 \|\mathcal K_X\|_{L^2_0(G)\to L^2(G;\ell^2_m)}^2
 =\sum_{m=1}^{X}A_m^2
 =\frac{19}{30}X^5+O(X^4).}
 \tag{4}
$$

Thus Haar mean zero, by itself, gives exactly the exponent that must be
improved.

## A prime-detecting cylinder with $X^5$ discrepancy

Put

$$
 z=\sqrt{2X},\qquad Q=\prod_{p\le z}p,
 \qquad
 F_X(x)=(\log X)\mathbf 1_{(x,Q)=1}.
$$

The divisibility events indexed by the primes in $Q$ are independent under
Haar measure. Mertens' product theorem gives

$$
 c_X:=\int_G F_X\,d\mu_G
 =(\log X)\prod_{p\le z}\left(1-\frac1p\right)
 =2e^{-\gamma}+o(1).
 \tag{5}
$$

The finite successor orbit has a different mean. Every composite $n\le2X$
has a prime factor at most $\sqrt{2X}=z$. Therefore, for $1\le t\le2X$, the
integers selected by the cylinder are exactly $1$ and the primes greater
than $z$:

$$
 \sum_{n\le t}F_X(n)
 =(\log X)\bigl(1+\pi(t)-\pi(z)\bigr).
 \tag{6}
$$

The prime number theorem makes (6) equal to $t+o(X)$, uniformly for
$X\le t\le2X$. For the Haar-centered cylinder $f_X=F_X-c_X$, it follows
uniformly for $m\le X$ that

$$
 (\mathcal K_Xf_X)_m(0)
 =(1-2e^{-\gamma})A_m+o(X^2).
$$

Together with (4), this proves

$$
 \boxed{
 \sum_{m=1}^{X}|(\mathcal K_Xf_X)_m(0)|^2
 =\frac{19}{30}(1-2e^{-\gamma})^2X^5+o(X^5).}
 \tag{7}
$$

Meanwhile,

$$
 \|f_X\|_{L^2(G)}^2=O(\log X).
$$

The logarithmic size of the spatial $L^2$ norm cannot compensate for the
fixed-power failure in (7). The modulus

$$
 Q=\exp\bigl((1+o(1))\sqrt{2X}\bigr)
$$

is also far larger than the observed orbit.

## Exact von Mangoldt cylinder and the surviving signed sum

For $Y=2X$, the finite cylinder

$$
 L_Y(x)=-\sum_{d\le Y}\mu(d)\log d\,\mathbf 1_{d\mid x}
 \tag{8}
$$

agrees with $\Lambda(n)$ at every integer $n\le2X$. Its Haar mean is

$$
 a_Y=-\sum_{d\le Y}\frac{\mu(d)\log d}{d}.
$$

Set

$$
 R_d(k)=\left\lfloor\frac kd\right\rfloor-\frac kd,
 \qquad
 B_d(m)=\sum_{k=X}^{X+m-1}R_d(k).
$$

Expanding the divisibility cylinders gives the exact identity

$$
 \boxed{
 P(m)=-\sum_{d\le2X}\mu(d)\log d\,B_d(m)
 +(a_{2X}-1)A_m-\frac m2.}
 \tag{9}
$$

Since $|B_d(m)|\le m$, absolute summation in (9) gives only the elementary
$X^5$ energy scale, up to logarithms. Truncation does not fix the problem.
If $D<2X$ and

$$
 r_D(n)=\Lambda(n)+\sum_{\substack{d\mid n\\d\le D}}
 \mu(d)\log d,
$$

then every prime $p>D$ satisfies $r_D(p)=\log p$, and consequently

$$
 \sum_{n\le2X}|r_D(n)|
 \ge \vartheta(2X)-\vartheta(D).
 \tag{10}
$$

For any finitely supported remainder $r$, direct summation gives

$$
 \sum_{m\le X}|(\mathcal K_Xr)_m(0)|^2
 \le X^3\left(\sum_{n\le2X}|r(n)|\right)^2.
 \tag{11}
$$

When $D\le X$, the right side of (10) is of order $X$. An absolute
truncation estimate therefore again permits the full $X^5$ scale.

## Consequence

Prime coordinates are independent under Haar measure, but the successor
odometer has pure point spectrum and no mixing. At the depth required to
recognize primes, the finite orbit does not approximate Haar measure with a
power saving. Formula (9) shows what remains after the geometric lift: the
same signed Möbius divisor sum that the arithmetic formulation must control.

The obstruction is scoped. It excludes a proof based only on profinite
independence, generic $L^2$ control, or absolute truncation. A proof may still
combine this geometry with a new estimate that preserves the actual signed
divisor correlations.

## Sources

- J. B. Rosser and L. Schoenfeld, [*Approximate formulas for some functions of prime numbers*](https://projecteuclid.org/journals/illinois-journal-of-mathematics/volume-6/issue-1/Approximate-formulas-for-some-functions-of-prime-numbers/10.1215/ijm/1255631807.full), Illinois Journal of Mathematics 6 (1962), 64--94.
- T. Trudgian, [*Updating the error term in the prime number theorem*](https://arxiv.org/abs/1401.2689), Ramanujan Journal 39 (2016), 225--234.

The analytic inputs used above are the classical prime number theorem,
Mertens' product theorem, and the elementary identity
$\Lambda(n)=-\sum_{d\mid n}\mu(d)\log d$. No novelty or
first-formalization claim is made.

## Signed Fourier blocks: a gain below the hyperbola and its loss above

Center the exact-period sawtooth by
\[
 r_d(k)=R_d(k)+\frac{d-1}{2d},\qquad
 \widetilde B_d(m)=\sum_{h=0}^{m-1}r_d(X+h).
\]
For \(1\le j<d\), finite Fourier inversion gives
\[
 r_d(k)=\sum_{j=1}^{d-1}\beta_d(j)e(jk/d),\qquad
 \beta_d(j)=\frac1{d(1-e(-j/d))}.
\tag{12}
\]
Thus, for dyadic modulus blocks \(d\asymp D,e\asymp E\), the exact signed
quadratic block before any inequality is
\[
 \boxed{\mathcal Q_{D,E}=
 \sum_{m\le X}\left(\sum_{d\asymp D}-\mu(d)\log d\,\widetilde B_d(m)\right)
 \overline{\left(\sum_{e\asymp E}-\mu(e)\log e\,\widetilde B_e(m)\right)}.}
\tag{13}
\]
Writing \(S_m(\alpha)=\sum_{h<m}e(\alpha h)\), its exact Fourier form is
\[
 \mathcal Q_{D,E}=\sum_{d,j,e,k}\mu(d)\mu(e)\log d\log e\,
 \beta_d(j)\overline{\beta_e(k)}e(X(j/d-k/e))
 \sum_{m\le X}S_m(j/d)\overline{S_m(k/e)}.
\tag{14}
\]
All four sums have the ranges in (13) and (12); in particular the
\(\mu(d)\mu(e)\) signs remain present.

Reduce each fraction \(j/d=a/q\). For a fixed reduced \(a/q\), the
aggregated coefficient on the \(D\)-block is
\[
 c_{q,a}^{(D)}=\frac1{1-e(-a/q)}
 \sum_{D<q\ell\le2D}\frac{-\mu(q\ell)\log(q\ell)}{q\ell}.
\tag{15}
\]
The elementary absolute estimate in (15), together with
\(|1-e(-a/q)|\gg\min(a,q-a)/q\), gives
\[
 \sum_{q\le2D}\sum_{(a,q)=1}|c_{q,a}^{(D)}|^2\ll D\log^2(2D).
\tag{16}
\]
This step does not claim Möbius cancellation. The additive large sieve for
reduced Farey fractions, followed by the \(\ell^2\)-operator bound
\(\| (x_h)\mapsto(\sum_{h<m}x_h)_m\|\ll X\), now proves
\[
 \sum_{m\le X}\left|\sum_{d\asymp D}-\mu(d)\log d\,
 \widetilde B_d(m)\right|^2
 \ll X^2(X+D^2)D\log^2(2D).
\tag{17}
\]
Consequently Cauchy--Schwarz between the two already signed blocks gives
\[
 |\mathcal Q_{D,E}|\ll X^2
 \sqrt{D(X+D^2)E(X+E^2)}\log(2D)\log(2E).
\tag{18}
\]
If \(DE\le X\), (18) is \(O(X^4\log^2X)\), and summing the
\(O(\log^2X)\) dyadic pairs gives
\[
 \boxed{\left|\sum_{DE\le X}\mathcal Q_{D,E}\right|
\ll X^4\log^4X.}
\tag{19}
\]
This is a genuine one-power saving for the below-hyperbola centered
sawtooth blocks, using only exact residue Fourier inversion and the
unconditional additive large sieve.

The same calculation also supplies the decisive failure test. For
\(D,E\asymp X\), the right side of (18) is \(O(X^5\log^2X)\), with no
power saving. These blocks lie entirely in \(DE>X\). Their periods exceed
or match the observed interval, so residue orthogonality has no additional
averaging to spend.

There is also a direct prefix counterexample for arbitrary coefficients. Let
\(X=10M\) and \(\mathcal D=\{9M,\ldots,10M-1\}\). For
\(0\le h<M\) and \(d\in\mathcal D\), one has
\[
 r_d(X+h)=\frac32-\frac{X+h+1/2}{d}>\frac5{18}.
\]
Consequently, for \(1\le m\le M\),
\[
 \sum_{d\in\mathcal D}\widetilde B_d(m)>\frac{5Mm}{18},
 \qquad
 \sum_{m\le M}\left|\sum_{d\in\mathcal D}
 \widetilde B_d(m)\right|^2\gg X^5.
\tag{20}
\]
This is the prefix version of the
[cutoff-versus-period obstruction](../analytic-methods/cutoff-period-gcd-obstruction.md).
It shows that a uniform arbitrary-coefficient improvement is false.

For the actual Möbius coefficients, cancellation between the large blocks and
the affine terms in (9) remains possible but is not supplied by the large
sieve. Thus the available estimate for the complementary \(DE>X\) region
erases the saving from (19) when one forms a full upper bound. Summing (13)
over all blocks returns only the original \(X^5\) scale. This Fourier
decomposition stops here: a full fixed-power bound would require a new signed
estimate specifically for the actual above-hyperbola coefficients, not
another use of residue orthogonality. No novelty claim is made for the
large-sieve application.

## The top modulus block is a weighted Möbius Riesz mean

The largest-modulus range can be combined with the affine term in (9)
without approximation. If \(X<d\le2X\) and \(X\le k<2X\), then
\(\lfloor k/d\rfloor=\mathbf1_{d\le k}\). Hence
\[
 B_d(m)=(X+m-d)_+-\frac{A_m}{d},
 \qquad A_m=\frac{m(2X+m-1)}2.
\]
Using \(a_Y=-\sum_{d\le Y}\mu(d)\log d/d\), the complete contribution of
all \(d>X\), together with the affine term in (9), is exactly
\[
 \boxed{H_X(m)=-\sum_{X<d<X+m}\mu(d)\log d\,(X+m-d)
 +(a_X-1)A_m.}
\tag{20}
\]
Thus the apparent large-modulus reciprocal term cancels exactly against
the matching part of \(a_{2X}\). If
\(W_X(t)=\sum_{X<d\le t}\mu(d)\log d\), then the first term in (20) is
\(-\int_X^{X+m}W_X(t)\,dt\), with the usual step-function convention.
This is the requested moving-interval form, including both endpoints.

The standard unconditional short-interval mean-square input does not give a
fixed power here. Corollary 1.1 of Matomäki and Radziwiłł,
[*Multiplicative functions in short intervals II*](https://arxiv.org/abs/2007.04290),
compares a normalized short sum with its long mean at tolerance \(\eta\),
outside \(O(Xh^{-\eta^\kappa})\) starting points in its general form. In the
full-support case its stronger conclusion requires
\(\eta\ge(\log h)^{-1/300}\), and the exceptional set is bounded by
\(O(X(h^{-\eta/15}+X^{-\eta^4/10^{16}}))\). A fixed power saving in the
present energy would require polynomially small relative tolerance, outside
that stronger range; in the general estimate it makes
\(h^{-\eta^\kappa}=1-o(1)\). The present intervals also have one fixed
starting point and are nested, which removes the averaging in that theorem.
Applying the
classical zero-free-region bound to (20) reproduces only a
Vinogradov--Korobov saving.

There is also a precise analytic obstruction. The Dirichlet series of the
weight in (20) is
\[
 \sum_{n\ge1}\frac{\mu(n)\log n}{n^s}=\frac{\zeta'(s)}{\zeta(s)^2}.
\tag{21}
\]
A simple zero \(\rho\) of \(\zeta\) is a double pole of (21), so its
Riesz contribution to (20) has size
\(X^{\rho+1}\) times a nonzero affine-logarithmic profile in \(m/X\).
The correction \((a_X-1)A_m\) removes the reciprocal endpoint term used
to pass from \(a_{2X}\) to \(a_X\); it does not cancel this profile for
all \(0<m\le X\). Its squared norm therefore has scale
\(X^{2\Re\rho+3}\), up to powers of \(\log X\) and a nonzero
\(\rho\)-dependent factor. Consequently a proof of
\[
 \sum_{m\le X}|H_X(m)|^2\ll_\varepsilon X^{5-\delta+\varepsilon}
\tag{22}
\]
by contour separation or absolute zero-mode estimates would already force
the fixed zero-free half-plane \(\Re\rho\le1-\delta/2\). Joint treatment
with the affine term does not avoid this implication because (20) has
already performed its exact cancellation.

This isolates the decisive obstruction in the actual \(D\asymp X\)
block. A fixed-power estimate would require new cancellation among the
zero modes, equivalently a new signed mean-square theorem for the nested
weighted Möbius Riesz means in (20). Existing residue orthogonality,
large-sieve estimates and short-interval Möbius theorems do not supply it.

## Why the hyperbolic quadratic saving has no vector complement

The quantity in (19) is a scalar quadratic contribution, not a prefix
vector. Consequently an expression (U_X=P_X-Q_<) is not defined. This is
not repaired by choosing square roots blockwise: the hyperbolic mask
(mathbf1_{dele X}) is not positive semidefinite. Indeed, choose integers
(e<\sqrt X<d) with (dele X<d^2). On the two coordinates (e,d), its
matrix is
\[
 \begin{pmatrix}1&1\\1&0\end{pmatrix},
\]
which has determinant (-1). Thus the signed sum of all (DEle X)
blocks can be negative and cannot equal (|Q_<|_2^2) for any canonical
vector (Q_<). The cross terms that create the saving in (19) prevent the
proposed vector subtraction.

There is also a decisive obstruction for every legitimate replacement.
If one chooses an actual vector decomposition (P_X=V_X+U_X) with
\[
 \sum_{mle X}|V_X(m)|^2\ll X^{4+\varepsilon}
\]
and proves
\[
 \sum_{mle X}|U_X(m)|^2\ll X^{5-\delta+\varepsilon},
\]
then the exact triangle inequality gives
\[
 \sum_{mle X}|P_X(m)|^2
 \le2sum_{mle X}|V_X(m)|^2+2sum_{mle X}|U_X(m)|^2
 \ll X^{5-\min(\delta,1)+\varepsilon}.
\tag{23}
\]
The partial-power proposition in the coarse-energy note then excludes all
zeta zeros with
\(Re\rho>1-\min(\delta,1)/2\). Hence a bound for a genuine fully
recombined complement is already the corresponding fixed zero-free
half-plane theorem. It cannot follow from an input advertised as strictly
weaker merely by the present decomposition.

The (2\times2) matrix above is the fast coherent-model falsifier: even a
unit coefficient on each selected modulus makes the below-hyperbola form
indefinite, so treating (19) as energy silently discards cross terms. The
only exact existing full bound remains the elementary (O(X^5)) bound
(up to logarithms), while the proposed fixed-power exponent is precisely
(23). This closes the proposed (U_X) construction rather than producing
another coordinate decomposition.
