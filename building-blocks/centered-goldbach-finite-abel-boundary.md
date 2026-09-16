# Finite Abel boundary for the centered Goldbach square

Keep the notation

\[
a_n=\Lambda(n)-1,
\qquad
A_N=\sum_{n\le N}a_n=\psi(N)-N,
\]

and

\[
c_N=\sum_{m=1}^{N-1}a_ma_{N-m},
\qquad
B_N=\sum_{m=1}^{N-1}A_mA_{N-m}.
\]

Every sum includes prime powers and the endpoint \(a_1=-1\). Set
\(A_0=B_0=B_1=0\). The exact generating relations are

\[
D(z)=\sum_{n\ge1}a_nz^n
=(1-z)\sum_{N\ge1}A_Nz^N, \tag{1}
\]

and

\[
D(z)^2=(1-z)^2\sum_{N\ge2}B_Nz^N. \tag{2}
\]

Coefficient extraction from (2) gives

\[
c_N=B_N-2B_{N-1}+B_{N-2}. \tag{3}
\]

This note performs the finite summation by parts and tests what the exact
centered successor transport pays.

## Finite Abel identity with both endpoint terms

For every integer \(X\ge2\) and every complex \(z\), summing (3) only
through \(X\) gives

\[
\boxed{
\sum_{N=2}^Xc_Nz^N
=(1-z)^2\sum_{N=2}^{X-2}B_Nz^N
 +(1-2z)B_{X-1}z^{X-1}+B_Xz^X.}
\tag{4}
\]

The empty interior sum has its usual value zero. Writing

\[
\mathcal C(X)=\sum_{N=2}^Xc_N=B_X-B_{X-1}, \tag{5}
\]

the two terminal terms take the more useful form

\[
\boxed{
\sum_{N=2}^Xc_Nz^N
=(1-z)^2\sum_{N=2}^{X-2}B_Nz^N
 +(1-z)B_{X-1}z^{X-1}
 +\mathcal C(X)z^X.}
\tag{6}

The last two terms are both necessary. Dropping the
\((1-z)B_{X-1}z^{X-1}\) term silently replaces a finite centered source by
an infinite one.

For fixed \(|z|<1\), Chebyshev gives \(B_N=O(N^3)\), so both terminal terms
vanish as \(X\to\infty\). Equation (6) then recovers (2). At a natural
moving cutoff \(X\asymp(1-z)^{-1}\), neither boundary term vanishes.

## Inserting the exact centered transport

Let

\[
\nu=\sum_{n\ge1}a_n\delta_n,
\qquad
\nu_S=\sum_{n\ge1}a_nK_n,
\]

where every \(K_n\), including \(K_1\), is the complete successor
probability with its atom and continuous tail. The centered transport
identity is

\[
\mathcal C(X)
=(\nu_S*\nu_S)([0,X-2])+L_c(X-2), \tag{7}
\]

with

\[
L_c(Y)=\sum_{m+n\le Y+2}a_ma_nr_{m,n}(Y),
\qquad |L_c(Y)|\le C(Y+2). \tag{8}
\]

Substitution into (6) yields

\[
\begin{aligned}
\sum_{N=2}^Xc_Nz^N
={}&(1-z)^2\sum_{N=2}^{X-2}B_Nz^N
 +(1-z)B_{X-1}z^{X-1}\\
&+z^X(\nu_S*\nu_S)([0,X-2])+z^XL_c(X-2).
\end{aligned}\tag{9}
\]

For real \(0<z<1\), choose \(X\) comparable to \((1-z)^{-1}\). The
known leakage pays

\[
|z^XL_c(X-2)|\ll Xz^X\ll(1-z)^{-1}. \tag{10}
\]

This is exactly the scale of the RH-strength bound for the squared centered
heat. Thus the complete centered leakage is not too large. The original
uncentered leakage alone does not give (10); the two mixed unit-reference
rows and the unit-unit row are required to form \(L_c\).

The remaining three terms in (9) are uncontrolled:

\[
(1-z)^2\sum_{N<X}B_Nz^N,\qquad
(1-z)B_{X-1}z^{X-1},\qquad
z^X(\nu_S*\nu_S)([0,X-2]). \tag{11}
\]

Neither \(B_N\) nor the transported interval convolution has a fixed sign.
The measure \(\nu_S\) is signed because \(a_1=-1\) and because
\(\Lambda(n)-1\) changes sign. Positivity of each \(K_n\) therefore does
not make its convolution positive on an interval.

## What positivity remains

On the complete positive real ray, (2) gives

\[
(1-z)^2\sum_{N\ge2}B_Nz^N=D(z)^2\ge0. \tag{12}
\]

This is positivity of the full Abel sum, not coefficientwise positivity.
Already the exact initial coefficients change sign. For example,

\[
c_2=1,\qquad
c_3=2-2\log2,\qquad
c_4=2-2\log3+(\log2-1)^2,
\]

and \(c_4<0\). Hence ordinary monotonicity cannot be obtained by declaring
the centered Goldbach coefficients nonnegative.

The autocorrelation coefficients \(B_N\) are also signed in principle,
since they are sums of products of the prime-number-theorem errors
\(A_mA_{N-m}\). PNT supplies no common sign for these errors. The fact that
the complete power series in (12) is a square does not sign its finite
prefixes or the boundary term in (6).

Differentiating (12) does not restore positivity:

\[
\frac d{dz}D(z)^2=2D(z)D'(z), \tag{13}
\]

whose sign depends on the linked prime heat and its derivative. A zero or
turning point of \(D\) is compatible with every identity above. Thus there
is no unconditional monotonicity consequence from the square alone.

## Real-axis cancellation versus coefficient energy

The prime number theorem gives

\[
A_N=o(N).
\]

Through (1), this implies only

\[
D(e^{-t})=o(t^{-1}),
\qquad
D(e^{-t})^2=o(t^{-2}) \quad(t\downarrow0). \tag{14}
\]

An effective zero-free-region remainder inserts its corresponding
subexponential saving into (14), but it remains far from the
\(t^{-1-\varepsilon}\) RH scale. This cancellation comes from PNT, not from
the \(O(X)\) transport error.

More importantly, a positive-real estimate such as (14) does not improve
the coefficient-square energy. Parseval requires the whole circle:

\[
\sum_{N\ge2}c_N^2r^{2N}
=\frac1{2\pi}\int_{-\pi}^{\pi}|D(re^{i\theta})|^4d\theta. \tag{15}
\]

The summation-by-parts identity becomes

\[
D(re^{i\theta})^2
=(1-re^{i\theta})^2
 \sum_{N\ge2}B_Nr^Ne^{iN\theta}. \tag{16}
\]

Away from \(\theta=0\), PNT gives no analogous cancellation. The known
unconditional estimate remains

\[
\sum_{X\le N<2X}c_N^2\ll X^3\log(2X). \tag{17}
\]

This limitation is structural. Finite-difference sequences can have an
exponentially small positive-real Abel transform while retaining large
coefficient norm. Finite-difference examples show that no polynomially stable real-ray inverse exists under coefficient bounds alone. Equations (4) and (6) expose the same boundary mechanism for the actual centered source.

## Summation-by-parts energy identity

There is also an exact discrete energy formula, but it has no sign. Let
\(d_N=B_N-B_{N-1}\), so \(c_N=d_N-d_{N-1}\). For \(X\ge2\), ordinary
summation by parts gives

\[
\boxed{
\sum_{N=2}^Xc_N^2
=c_Xd_X-c_2d_1
 -\sum_{N=2}^{X-1}d_N(c_{N+1}-c_N).}
\tag{18}
\]

Here \(d_1=0\), so the lower endpoint vanishes, and the exact birth in the
last factor is

\[
c_{N+1}-c_N
=\sum_{m=1}^{N-1}\Lambda(m)
 [\Lambda(N+1-m)-\Lambda(N-m)]-2\Lambda(N)+1. \tag{19}
\]

Formula (18) retains the terminal work \(c_Xd_X\). The interior work has
no sign because both \(d_N\) and the complete prime-power birth (19) change
sign. Replacing it by absolute values reproduces, rather than improves,
the cubic-scale energy allowance.

## Bounded conclusion

The finite Abel identity (9) yields one genuine gain: after all reference
rows are retained, the known centered successor leakage contributes only
\(O((1-z)^{-1})\) at the natural Abel cutoff. This is the desired squared
heat scale.

It does not close the estimate. The transported signed covariance, the
autocorrelation interior, and the finite boundary covariance remain. The
complete real-axis square is nonnegative, but its coefficients, derivative,
finite prefixes, and transported interval square have no common sign.
Consequently neither monotonicity nor a coefficient-energy improvement over
\(X^3\log X\) follows from the current transport and summation-by-parts
identities.

A useful next theorem would have to bound one of the three linked terms in
(11), while retaining the other two boundary terms. Bounding the leakage
again cannot supply that missing covariance estimate.


The displayed finite algebraic identities remain Lean formalization obligations. No RH conclusion is asserted.
