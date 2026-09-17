# Vaughan reduction of the signed friable--largest-prime cross

This note applies the complete von Mangoldt convolution to the exact
friable boundary correlation.  It keeps the prime-power correction and
the affine kernel.  The result is an explicit Type I/II reduction.  The
balanced Type II term requires power cancellation in a two-Mobius
correlation; classical unconditional prime exponential-sum estimates give
only a subpower saving after the outer friable sum and do not reach the
required \(X^{1+\varepsilon}\) scale.

## 1. Exact cross and the complete-Lambda replacement

Let

\[
 D_X=\lceil\sqrt X\rceil,\qquad T_X=\lceil X\log X\rceil,
 \qquad y=\frac{X}{(\log X)^A}.
\]

For this cutoff, if \(p>y\) and \(D_X<pm<T_X\), then

\[
 m<\frac{T_X}{y}<(\log X)^{A+2}.                       \tag{1}
\]

In particular \(P^+(m)<p\) automatically for large \(X\).  The exact
friable boundary cross is therefore

\[
 \mathfrak C_{X,y}=-2
 \sum_{\substack{D_X<h<T_X\\P^+(h)\le y}}
 \mu(h)
 \sum_{m<(\log X)^{A+2}}\mu(m)
 \sum_{\substack{p>y\\D_X<pm<T_X}}
 \mathcal G_X(h,pm),                                  \tag{2}
\]

where endpoint indicators in (2) are literal and

\[
 \mathcal G_X(h,e)=\sum_{a,b\ge1}\kappa_{a+b-2}
 e^{-2\max(ah,be)/X}.                                 \tag{3}
\]

For any function \(F\) supported above \(y\), the exact identity

\[
 \sum_pF(p)=\sum_{n\ge2}\frac{\Lambda(n)}{\log n}F(n)
 -\sum_{k\ge2}\frac1k\sum_qF(q^k)                    \tag{4}
\]

retains every prime power.  Define

\[
 W_{h,m}(n)=
 \frac{1_{n>y}1_{D_X<mn<T_X}}{\log n}\,
 \mathcal G_X(h,mn).                                  \tag{5}
\]

Then (2) becomes

\[
\boxed{\begin{aligned}
 \mathfrak C_{X,y}
 ={}&-2\sum_{h\in\mathcal S_y}\mu(h)
       \sum_m\mu(m)\sum_n\Lambda(n)W_{h,m}(n)\\
 &+2\sum_{h\in\mathcal S_y}\mu(h)
       \sum_m\mu(m)
       \sum_{k\ge2}\frac1k\sum_q
       1_{q^k>y}1_{D_X<mq^k<T_X}\mathcal G_X(h,mq^k),
\end{aligned}}                                        \tag{6}
\]

with \(\mathcal S_y=\{D_X<h<T_X:P^+(h)\le y\}\).  The
second line is the exact proper-prime-power carrier.  Estimating it
absolutely would cost \(X^{3/2}(\log X)^{O_A(1)}\), already too large for
all \(\varepsilon<1/2\); it must remain coupled to the complete-Lambda
line.

## 2. Exact Vaughan identity

For parameters \(U,V\ge1\), write \(\mu_{\le V}=\mu1_{[1,V]}\) and
\(\Lambda_{\le U}=\Lambda1_{[1,U]}\).  From
\(\Lambda=\mu*\log\), \(\log=\Lambda*1\), and \(\mu*1=\epsilon\), one
gets the exact identity

\[
\boxed{
 \Lambda=\mu_{\le V}*\log+\Lambda_{\le U}
 -\Lambda_{\le U}*\mu_{\le V}*1
 +\mu_{>V}*\Lambda_{>U}*1.}                           \tag{7}
\]

Thus, for each actual weight (5),

\[
 \sum_n\Lambda(n)W_{h,m}(n)=I_1+I_0-I_2+II,           \tag{8}
\]

where

\[
\begin{aligned}
 I_1(h,m)&=\sum_{r\le V}\mu(r)
             \sum_\ell(\log\ell)W_{h,m}(r\ell),\\
 I_0(h,m)&=\sum_{s\le U}\Lambda(s)W_{h,m}(s),\\
 I_2(h,m)&=\sum_{r\le V}\sum_{s\le U}\mu(r)\Lambda(s)
             \sum_\ell W_{h,m}(rs\ell),\\
 II(h,m)&=\sum_{r>V}\sum_{s>U}\mu(r)\Lambda(s)
             \sum_\ell W_{h,m}(rs\ell).
                                                               \tag{9}
\end{aligned}
\]

Equations (6), (8), and (9) are the requested complete Type I/II
decomposition.  No asymptotic replacement has been made.  The strict
bulk endpoints, the smooth outer label, the short cofactor \(m\), every
proper prime power, and every \((a,b)\) row of (3) remain present.

On a dyadic block \(n\asymp N\), the balanced classical choice is
\(U=V=N^{1/3}\).  Here \(N\asymp X/m\) and
\(m\le(\log X)^{A+2}\).  The Type I sums have a divisor variable at most
\(N^{1/3}\).  The last line contains genuinely balanced factors
\(r>N^{1/3}\), \(s>N^{1/3}\), \(rs\ell\asymp N\), while it is still
coupled to the independent outer coefficient \(\mu(h)\), \(h\asymp X\).

## 3. What estimate is actually required

Let \(\mathcal V_{I}\), \(\mathcal V_{II}\), and \(\mathcal V_{\rm pp}\)
denote (6) after insertion of respectively the first three lines of (9),
the last line of (9), and the proper-power line of (6).  They must be
estimated coherently.  After subtracting the explicitly computable
prime-density main terms, the required statement is

\[
\boxed{
 \mathcal V_I+\mathcal V_{II}+\mathcal V_{\rm pp}
 =\mathfrak C_{X,y}^{\rm main}
   +O_\varepsilon(X^{1+\varepsilon}),}                \tag{10}
\]

where \(\mathfrak C_{X,y}^{\rm main}\) is the negative quantity which
pays the two packet norms in

\[
 \|S_y+R_y\|^2=\|S_y\|^2+\|R_y\|^2+\mathfrak C_{X,y}. \tag{11}
\]

Neither the Type II term nor the proper-power carrier may be bounded by
absolute value in (10).

The scale in (10) is square-root scale for the effective \(X^2\) outer
\((h,n)\)-pairs.  Even after the short \(m\)-sum is absorbed into powers
of \(\log X\), a pointwise PNT or a classical zero-free-region estimate
for the inner complete-Lambda sum gives only

\[
 X^2\exp[-c(\log X)^{3/5}(\log\log X)^{-1/5}]
       (\log X)^{O_A(1)},                              \tag{12}
\]

after the outer \(h\)-sum is taken absolutely.  Relative to
\(X^{1+\varepsilon}\), the deficit is

\[
 X^{1-\varepsilon}
 \exp[-c(\log X)^{3/5}(\log\log X)^{-1/5}],            \tag{13}
\]

which tends to infinity for every fixed \(\varepsilon<1\).  Classical
Vaughan minor-arc estimates can replace (12) by strong bounds away from
the zero frequency, but the affine kernel (3) has a nonzero, slowly
varying zero-frequency component.  The major arc therefore restores the
same signed outer Möbius problem.

## 4. The surviving Type II obstruction

Already the \(a=b=1\) row of (3) contains

\[
 \kappa_0e^{-2\max(h,mn)/X},\qquad \kappa_0=\log2.     \tag{14}
\]

Its exact prefix representation is

\[
 e^{-2\max(h,e)/X}
 =\int_{\max(h,e)}^\infty\frac2X e^{-2t/X}\,dt.       \tag{15}
\]

Consequently the zero-frequency part of the Vaughan expression couples
weighted partial sums of the outer smooth Möbius coefficients to partial
sums of the Type II Möbius coefficients.  Differencing the moving
threshold in (15) produces localized correlations of two Möbius factors,
not an oscillatory prime sum.  Standard Type II bounds for
\(\Lambda(n)e(\alpha n)\) do not control this zero-frequency correlation.

A power-saving version of (10) would therefore supply a weighted,
localized two-Möbius cancellation at comparable scales.  This lies on the
parity/Chowla side of the sieve barrier: Vaughan's identity exposes it but
does not estimate it.  Complete prime powers do not remove the issue;
their exact term is the second line of (6), and separating it incurs the
\(X^{3/2}\) loss noted above.

This is sharper than an unsigned smooth-number obstruction.  The exact
Lambda decomposition has been performed, its Type I/II ranges are
explicit, and the quantitative unconditional deficit is (13).  The
remaining new arithmetic input is precisely a major-arc signed Type II
estimate of the form (10), uniform in the affine histories and strict
endpoints.  No currently unconditional Vaughan, Heath--Brown, PNT, or
smooth-number estimate supplies that bound.
