# Dyadic largest-prime layer Gram and the all-layer remainder

This note continues the complete largest-prime packet calculation without
separating its absolute value.  It forms the exact localized Gram matrix
between dyadic largest-prime layers, tests the adjacent-layer sign, and
then sums all layers.  There is a genuine negative adjacent cross and an
exact leading row-sum cancellation.  The cancellation propagates through
all scales, however, and the final signed inequality is precisely the
finite-\(X\) affine bulk remainder already isolated in the central
reduction.

## 1. Exact layer partition and Gram kernel

For each integer \(j\), let

\[
 \mathcal P_j(X)=\{p:2^{-j-1}X<p\le2^{-j}X,\ p\text{ prime}\}.
\]

Empty or radially negligible layers are allowed.  Define

\[
 B_{X,j}(z)=-\frac1{1-z}
 \sum_{p\in\mathcal P_j(X)}\mathcal M_{<p}(z^p),         \tag{1}
\]

where

\[
 \mathcal M_{<p}(w)=
 \sum_{\substack{a\ge1\\P^+(a)<p}}\mu(a)w^a .
\]

Every squarefree \(n>1\) occurs in exactly one \(B_{X,j}\), according to
its largest prime.  Thus all common cofactors and delayed composites are
inside one packet, rather than being counted in several layers.

For a symmetric angular window \(I\), put

\[
 \mathcal K_{I,r}(n,m)=\frac1{2\pi}\int_I
 \frac{r^{n+m}e^{i(n-m)\theta}}
      {|1-re^{i\theta}|^2}\,d\theta .                  \tag{2}
\]

The exact Hermitian layer matrix is

\[
\boxed{\begin{aligned}
 G_{jk}(I)={}&\langle B_{X,j},B_{X,k}\rangle_I\\
 ={}&\sum_{p\in\mathcal P_j}\sum_{q\in\mathcal P_k}
 \sum_{\substack{P^+(a)<p\\P^+(b)<q}}
 \mu(a)\mu(b)\mathcal K_{I,r}(pa,qb).
\end{aligned}}                                         \tag{3}
\]

This includes the radial denominator and every squarefree cofactor.
No absolute value has been moved inside any sum. The matrix \(G\) is a
Gram matrix, but its off-diagonal entries may have either sign.

On the far-clock interval
\([\log(4X),\log(4X)+1]\), which lies above the moving paid boundary on
the central \(1/X\) scale, the Lambert field equals the Möbius field up to
a bounded error and \(w(t)\asymp(\log X)^{-2}\). Hence (3), multiplied by
this common clock factor, is the corresponding literal contribution to
\(R_X^\varepsilon\).

## 2. Fixed-layer scaling profiles

Write \(\theta=u/X\). For each fixed \(j\), weighted PNT and the uniform
replacement \(\mathcal M_{<p}(z^p)=\mathcal M(z^p)+O(e^{-c_jX})\) give

\[
 B_{X,j}(re^{iu/X})
 =-\frac{X^2}{\log X}
   \frac{C_j(u)+o(1)}{1-iu},                            \tag{4}
\]

locally uniformly in \(u\), where

\[
 C_j(u)=\int_{2^{-j-1}}^{2^{-j}}
 \mathcal M(e^{-\alpha+i\alpha u})\,d\alpha.           \tag{5}
\]

Consequently, after any fixed compact Fejér localization in \(u\),

\[
 G_{jk}\sim\frac{X^3}{\log^2X}
 \frac1{2\pi}\int
 \frac{C_j(u)\overline{C_k(u)}}{|1-iu|^2}
 \widehat W(u)\,du,                                    \tag{6}
\]

for the corresponding nonnegative compact profile \(\widehat W\).
Formula (6) computes the cross before estimating it.

## 3. The adjacent layer is genuinely negative

At \(u=0\), the top two profiles are

\[
 C_0(0)=\int_{1/2}^{1}\mathcal M(e^{-\alpha})d\alpha,
 \qquad
 C_1(0)=\int_{1/4}^{1/2}\mathcal M(e^{-\alpha})d\alpha.
\]

Exact rational interval arithmetic proves

\[
 0.053<C_0(0)<0.054,
 \qquad
 -0.061<C_1(0)<-0.060.                                 \tag{7}
\]

The certificate is
`verification/largest_prime_packet_profile_certificate.py`.
By continuity, \(G_{01}\) is strictly negative for a sufficiently narrow
fixed Fejér profile about \(u=0\). Its size is
\(X^3/\log^2X\), so the adjacent layer cancels a main-scale portion of the
top diagonal.  In fact the two zero-frequency constants nearly cancel and
change sign when added.

This is an actual negative admission cross.  It arises only after all
cofactors inside both largest-prime packets have been recombined.

## 4. Exact leading row-sum cancellation through all layers

The fixed-layer profiles telescope over all dyadic scales:

\[
 \sum_{j\in\mathbb Z}C_j(u)
 =\int_0^\infty\mathcal M(e^{-(1-iu)\alpha})d\alpha
 =\frac1{1-iu}\sum_{n\ge1}\frac{\mu(n)}n=0.             \tag{8}
\]

The last equality is the PNT identity
\(\sum_n\mu(n)/n=0\), interpreted by Abel convergence. Thus the leading
\(X^3/\log^2X\) profile has an exact zero row sum when every largest-prime
scale is retained.  Complete-Lambda convolution is compatible with this
cancellation, but does not localize it to a finite set of layers.

At finite \(X\), the exact non-asymptotic identity is stronger and clearer:

\[
\boxed{
 \mathcal M(z)=z-\sum_p\mathcal M_{<p}(z^p).}          \tag{9}
\]

so

\[
 \frac{\mathcal M(z)}{1-z}
 =\frac z{1-z}+\sum_jB_{X,j}(z).                        \tag{10}
\]

Equation (9) is merely the unique-largest-prime partition of every
squarefree integer.  It shows both what cancels and what remains.  The
all-layer sum does not vanish: after the leading continuum cancellation it
is exactly the original Mertens field.  Small-prime boundary layers,
large-prime radial tails, and the nonuniform prime density collectively
carry that remainder. Expanding \(1/\log(\alpha X)\) a finite number of
times does not close it; the cancellation propagates to the boundary and
is quantitatively the same PNT/Mertens problem.

## 5. Goldbach identities do not give an extra row relation

For each \(2p\), the complete identity

\[
 \Lambda(2p)=\log(2p)-\log p-\log2=0
\]

is already contained inside (9).  Selberg symmetry and the complete
Goldbach square retain all prime powers, but after substituting
\(\Lambda=\mu*\log\), they reproduce the same largest-prime packet crosses.
They do not force
\(\sum_kG_{jk}=0\) at finite \(X\): by (10), that row sum is the pairing of
the \(j\)-th packet with the actual Mertens field and unit endpoint.

Thus there is a negative adjacent cross of the right main scale, but no
proved finite-\(X\) dominance saying that adjacent layers alone pay each
diagonal.  The exact cancellation requires all layers simultaneously.

## 6. Identification with the finite-X affine bulk

Let the bulk set from the finite-\(X\) reduction be

\[
 \mathcal B_X=\{D_X<d<T_X\},
\]

and split it by largest-prime layer:

\[
 \mathcal B_{X,j}=\{d\in\mathcal B_X:P^+(d)\in\mathcal P_j(X)\}.
\]

Define the exact affine layer blocks

\[
\boxed{\begin{aligned}
 \mathfrak A_{jk}={}&
 \sum_{a,b\ge1}\kappa_{a+b-2}
 \sum_{\substack{d\in\mathcal B_{X,j}\\e\in\mathcal B_{X,k}}}
 \mu(d)\mu(e)\\
 &\qquad\times
 \exp[-(ad+be+|ad-be|)/X].
\end{aligned}}                                         \tag{11}
\]

Largest-prime uniqueness gives the exact final all-layer identity

\[
\boxed{
 \mathfrak A_X^{\rm bulk}=\sum_{j,k}\mathfrak A_{jk}.} \tag{12}
\]

Therefore the signed inequality left after all layer cancellations is
precisely

\[
\boxed{
 \sum_{j,k}\mathfrak A_{jk}
 =\mathfrak A_X^{\rm bulk}
 \ll_\varepsilon X^{1+\varepsilon}.}                  \tag{13}
\]

By the established finite-\(X\) reduction, (13) implies
\(R_X^\varepsilon\ll_\varepsilon X^{2+\varepsilon}\).
No new positive term or comparison loss appears in (12); conversely,
layerwise absolute values destroy the cancellation in (8) and return the
\(X^3/\log^2X\) packet cost.

## 7. Scope

The calculation proves a real mechanism: the adjacent layer has negative
main-scale cross, and all fixed dyadic layers have an exact leading row-sum
cancellation. It does not prove the uniform finite-\(X\) estimate (13).
That estimate is the simultaneous growing-horizon affine Möbius
correlation, including unbounded slopes and boundary layers.  The radial
factor, singular denominator, retained far-clock interval, all squarefree
cofactors, complete prime powers, density endpoint, and moving cutoff are
unchanged.  No RH premise or absolute separation of layer energies is
used.
