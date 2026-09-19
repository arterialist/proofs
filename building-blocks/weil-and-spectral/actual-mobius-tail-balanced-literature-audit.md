# Applicability audit for the balanced Möbius energy

**Status:** primary-source applicability audit, 20 September 2026. This note
compares published estimates with the reciprocal energy target in the
[balanced hard-shell audit](actual-mobius-tail-balanced-hard-shell.md).
It proves no new exponential-sum estimate and makes no claim that the list
exhausts future methods. The balanced audit performs its cross-term
cancellation globally before the free factor is sliced.

## Target and scale

The needed input is a fixed \(\rho>0\) such that, uniformly for the actual
cutoffs, Mellin characters, and physical \(X\)-range,

\[
 \mathcal C_\beta(B;T)
 \ll_\varepsilon T^\varepsilon
 \left(B^4T^{-1-\rho}+B^2\right).
\tag{1}
\]

Here \(\beta\) contains the coefficient

\[
 c=\mu*\mu
\]

and the energy contains the archimedean reciprocal phase

\[
 \frac1T\int \widehat\Phi(x/T)
 \left|\sum_{b\asymp B}\beta_b e(xB/b)\right|^4dx.
\tag{2}
\]

The Poisson form samples \(c(q)\) in windows of length \(Q/T\). At

\[
 d_*=\frac{2(\lambda+1)}5,
\]

this length is

\[
 \frac QT=T^{(2\lambda-3)/5}=Q^\theta,
 \qquad
 \theta=\frac{2\lambda-3}{2\lambda+2}.
\tag{3}
\]

For \(2<\lambda<29/14\), one has

\[
 \frac16<\theta<\frac8{43}.
\tag{4}
\]

An applicable result must therefore use the signs of \(\mu*\mu\), retain
the reciprocal geometry, and give a fixed power rather than an unspecified
\(o(1)\) or logarithmic saving.

## Exact coefficient, wrong phase

Basak, Robles and Zaharescu,
[*Exponential sums over Möbius convolutions with applications to
partitions*](https://arxiv.org/html/2312.17435v2), Theorem 1.5, is the
closest coefficient match. They write \(\mu_k=\mu^{*k}\), so \(\mu_2=c\).
The displayed logarithmic exponent differs between versions: arXiv v2 has
\((\log X)^{k^2}\), while the
[published version](https://doi.org/10.4153/S0008414X24000701) has
\((\log X)^k\). If \(|\alpha-a/q|\leq q^{-2}\), the arXiv-v2 statement
specializes at \(k=2\) to

\[
 \sum_{n\leq Y}c(n)e(n\alpha)
 \ll_\varepsilon
 Y^{16/17+\varepsilon}
 +Yq^{-1/6}(\log Y)^4
 +Y^{7/8}q^{1/8}(\log Y)^4.
\tag{5}
\]

The published statement replaces both fourth powers of the logarithm in
(5) by squares. This version difference has no bearing on the power scale.
The estimate is a linear additive twist. Neither the summand \(e(xB/b)\)
in (2) nor the reciprocal four-variable relation obtained by expanding (2)
is a linear phase in \(b\). Moreover, the last term in (5) is of order
\(Y\) times a logarithmic factor when \(q\asymp Y\). Neither source version
therefore implies a uniform fixed-power estimate of the form (1).

## Polynomial and modular-inverse phases

Bordignon, Bortolotto and Kerr,
[*Weyl sums with multiplicative coefficients and joint
equidistribution*](https://doi.org/10.2140/ant.2025.19.1549), Theorem 1,
assume a polynomial phase and, among other conditions,

\[
 \sum_{n\leq Y}|f(n)|=O(Y).
\]

For the actual coefficient,

\[
 \sum_{n\geq1}\frac{|c(n)|}{n^s}
 =\prod_p(1+2p^{-s}+p^{-2s})
 =\left(\frac{\zeta(s)}{\zeta(2s)}\right)^2,
\tag{6}
\]

so a standard Selberg--Delange consequence is

\[
 \sum_{n\leq Y}|c(n)|
 \sim \frac{Y\log Y}{\zeta(2)^2}.
\tag{7}
\]

Thus both the coefficient hypothesis and polynomial-phase geometry miss
(1).

Korolev,
[*On Kloosterman sums with multiplicative
coefficients*](https://doi.org/10.1070/IM8633), studies

\[
 \sum_{n\leq y}' f(n)e_q(an^*+bn),
\]

where \(n^*\) is the inverse of \(n\) modulo \(q\). Gong and Jia,
[*Kloosterman sums with multiplicative
coefficients*](https://arxiv.org/abs/1401.4556), similarly prove, for
\(|f|\leq1\), an estimate for

\[
 \sum_{\substack{n\leq y\\(n,q)=1}} f(n)e(a\bar n/q).
\]

These are finite-field modular-inverse phases. The phase in (2) is the real
number \(xB/b\), not \(a\bar b/q\), and \(|c(p)|=2\), so neither theorem
applies to (1). In particular, fixed powers obtained for special modular
Kloosterman sums cannot be transferred by identifying \(1/b\) with a
modular inverse.

## Short intervals and additive correlations

Matomäki, Radziwiłł and Tao,
[*Correlations of the von Mangoldt and higher divisor functions I. Long
shift ranges*](https://doi.org/10.1112/plms.12181), Theorem 1.3, treat
additive correlations of \(\Lambda\) and fixed divisor functions for

\[
 Y^{8/33+\varepsilon}\leq H\leq Y^{1-\varepsilon}
\]

with logarithmic error savings for almost all shifts. The window exponent
in (4) is below \(8/33\), the coefficient is \(\mu*\mu\), and the energy is
reciprocal and fourfold.

Their companion paper,
[*Correlations of the von Mangoldt and higher divisor functions II: divisor
correlations in short ranges*](https://doi.org/10.1007/s00208-018-01801-4),
Theorem 1.1, reaches polylogarithmic \(H\) for averaged additive
correlations, but the error is only

\[
 o\!\left(HY(\log Y)^{k+\ell-2}\right),
\]

described quantitatively by a logarithmic saving whose exponent tends to
zero. It does not provide the fixed \(T^{-\rho}\) required in (1).

Matomäki and Radziwiłł,
[*Multiplicative functions in short
intervals*](https://doi.org/10.4007/annals.2016.183.3.6), Theorem 1, treats
first moments of \(1\)-bounded multiplicative functions in almost all short
intervals. Its saving is qualitative or logarithmic, and \(c\) is not
\(1\)-bounded.

Matomäki, Radziwiłł, Shao, Tao and Teräväinen,
[*Higher uniformity of arithmetic functions in short intervals II. Almost
all intervals*](https://arxiv.org/abs/2411.05770), proves several strong
almost-all results. The fixed-power statements concern different
coefficients such as a divisor-function remainder and operate in the
polynomial/nilsequence setting. The Möbius statements either require
longer power windows for quantitative uniformity or give a prescribed
\(\eta H\) qualitative bound. They do not estimate the deterministic
reciprocal fourth moment (2) for \(\mu*\mu\).

Matthiesen,
[*Linear correlations of multiplicative
functions*](https://doi.org/10.1112/plms.12309), Theorem 1.2, gives a
qualitative asymptotic for a broad class of multiplicative functions at
systems of linear forms. Even if \(c\) is placed in that coefficient
class, the theorem has no fixed-power error and the reciprocal relation in
(2) is not a system of linear forms.

## Result of the audit

The sources above supply one or more of the following:

1. the exact coefficient with a linear phase;
2. fixed powers for polynomial or modular-inverse phases;
3. logarithmic or qualitative cancellation in additive short intervals;
4. arbitrary-coefficient reciprocal estimates that recover the existing
   Robert--Sargos bound.

None of their stated theorems gives (1), or an equivalent fixed-power
estimate on the windows (3), with the actual coefficient, reciprocal
geometry, cutoffs, twists, and uniform \(X\)-range. This is an applicability
conclusion about the cited theorems. It does not prove that (1) is false.
The justified analytic endpoint remains \(d_*\).
