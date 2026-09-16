# Prime histories in Suzuki's arithmetic coefficient

[Suzuki's Hankel construction](https://arxiv.org/html/1204.1827v2)
uses the positive arithmetic coefficient
\[
 c_\omega(n)=n^\omega\prod_{p\mid n}(1-p^{-2\omega})
 =\sum_{d\mid n}\mu(d)
   \exp\!\left(\omega\bigl(\log(n/d)-\log d\bigr)\right),
 \qquad n\ge1.                                           \tag{1}
\]
The second expression follows by expanding the finite Euler product.
It keeps every proper cofactor and makes differentiation at
\(\omega=0\) literal. The coefficient at \(n=1\) is one for every
\(\omega\).

## The first two variations

The Möbius identities
\[
 \sum_{d\mid n}\mu(d)\log(n/d)=\Lambda(n),\qquad
 \sum_{d\mid n}\mu(d)\log d=-\Lambda(n)
\]
give the exact first variation
\[
 \boxed{\quad c'_0(n)=2\Lambda(n).\quad}             \tag{2}
\]
Thus the ordinary prime-power source is the infinitesimal arrival
rate of Suzuki's positive coefficient family. In particular, a
prime power \(p^k\) contributes \(2\log p\) regardless of \(k\);
an integer with two distinct prime factors has zero first
variation.

For \(\Re s>1+|\omega|\), Suzuki's absolutely convergent Dirichlet
series is
\[
 C_\omega(s)=\sum_{n\ge1}\frac{c_\omega(n)}{n^s}
     =\frac{\zeta(s-\omega)}{\zeta(s+\omega)}.         \tag{3}
\]
The logarithm of the right side is odd in \(\omega\). Differentiating
twice at zero and using \(-\zeta'/\zeta=\sum_n\Lambda(n)n^{-s}\)
gives
\[
 \boxed{\quad c''_0(n)=4(\Lambda*\Lambda)(n),\quad}
 \qquad
 (\Lambda*\Lambda)(n)=\sum_{uv=n}\Lambda(u)\Lambda(v).
                                                               \tag{4}
\]
Here \(*\) is multiplicative Dirichlet convolution. Termwise
differentiation is justified in a smaller right half-plane around
\(\omega=0\), and uniqueness of absolutely convergent Dirichlet
series gives the coefficient identity for each fixed \(n\). The
pointwise Taylor expansion is
\[
 c_\omega(n)=\mathbf1_{\{n=1\}}+2\omega\Lambda(n)
       +2\omega^2(\Lambda*\Lambda)(n)+O_n(\omega^3).
                                                               \tag{5}
\]
The remainder in (5) depends on \(n\). It cannot be summed at the
critical line without a separate uniform estimate.

The repository's [original \(V/W\) coefficient](actual-W-positive-primitive-analysis.md)
keeps only ordered histories with distinct prime-power bases. The
[same-prime and distinct-prime split](BuildingBlocks/SelbergDistinctPrimes.lean)
is already formalized. Write
\(a_{\rm dist}(n)\) for it. Then
\[
 a_{\rm dist}(n)=\frac14c''_0(n)-b_{\rm same}(n),
 \qquad
 b_{\rm same}(n)=
 \begin{cases}
 (k-1)(\log p)^2,&n=p^k,\ k\ge2,\\
 0,&\text{otherwise}.
 \end{cases}                                             \tag{6}
\]
The subtraction is necessary. For \(n=p^k\), the \(k-1\) ordered
splits \(p^a p^{k-a}\) all repeat the same prime; for
\(n=p^a q^b\) with \(p\ne q\), the two ordered splits belong to
\(a_{\rm dist}\). This is a multiplicative two-history identity,
not the additive Goldbach convolution \(\sum_{a+b=n}\Lambda(a)\Lambda(b)\).

## Finite successor transfer

The [finite successor-cell Euler transfer](successor-cell-finite-euler-transfer.md)
has an exact operator counterpart. Define
\[
 \mathscr C_N(s,\omega)=
   \mathscr Z_N(s-\omega)\mathscr Z_N(s+\omega)^{-1}
   =\sum_{n=1}^N c_\omega(n)n^{-s}R_n.                \tag{7}
\]
This identity uses the finite semigroup law \(R_aR_b=R_{ab}\) and
the finite Möbius inverse. It holds for every complex \(s,\omega\)
after extending \(c_\omega(n)\) by the finite exponential sum in
(1), since each finite Euler factor is invertible. If
\(\mathscr B_N(s)=\sum_{d=2}^N\Lambda(d)d^{-s}R_d\), then
\[
 \left.\partial_\omega\mathscr C_N(s,\omega)\right|_0
   =2\mathscr B_N(s),\qquad
 \left.\partial_\omega^2\mathscr C_N(s,\omega)\right|_0
   =4\mathscr B_N(s)^2.                                \tag{8}
\]
The square in (8) contains same-prime repeats as well as distinct
prime pairs. Subtracting the same-prime operator from its
coefficients recovers the original \(a_{\rm dist}\) block. The
correspondence is exact at a finite cutoff, but finite
invertibility gives no zero-free region.

The completed Suzuki phase is
\(\Theta_\omega(z)=\xi(s-\omega)/\xi(s+\omega)\),
\(s=\tfrac12-iz\). For real \(z\) with \(\xi(s)\ne0\), its first
variation is
\[
 \left.\partial_\omega\Theta_\omega(z)\right|_0
  =-2\frac{\xi'(s)}{\xi(s)}
  =2\left(-\frac{\zeta'(s)}{\zeta(s)}
           -\frac{\gamma_\xi'(s)}{\gamma_\xi(s)}\right),
 \quad
 \gamma_\xi(s)=\tfrac12s(s-1)\pi^{-s/2}\Gamma(s/2).
                                                               \tag{9}
\]
Equation (9) keeps the gamma and pole contribution beside every
prime power. It extends meromorphically wherever the displayed
logarithmic derivatives make sense. Differentiating a positive
coefficient family does not sign Suzuki's full Hankel kernel: the
associated real gamma kernel has mixed signs, and the required
uniform Hankel inequality is still unproved.
These identities give an exact source map, not RH or Goldbach.

[SuzukiCoefficientVariation.lean](BuildingBlocks/SuzukiCoefficientVariation.lean)
formalizes the divisor-sum coefficient, (2), and the second
derivative as the literal finite sum
\(\sum_{d\mid n}\mu(d)(\log(n/d)-\log d)^2\), using mathlib's
actual Möbius and von Mangoldt functions with standard axioms only.
The finite-product identification in (1), the equality of this
second derivative with \(4\Lambda*\Lambda\) in (4), and operator
and completed analytic identities (7)--(9) are written mathematics,
not Lean theorems yet.
