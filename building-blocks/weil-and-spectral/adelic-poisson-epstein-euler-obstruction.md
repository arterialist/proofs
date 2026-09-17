# Poisson self-duality and positive lattice counts do not force critical-line zeros

Written geometric counterexample and source audit, 2026-09-17. This note
falsifies one proposed unconditional route from adelic/lattice geometry to the
Riemann hypothesis. It does **not** prove an all-window sign for the actual
Riemann zeta Weil form, and it is not Lean-formalized.

## A self-dual positive theta source with off-line zeros

Put
\[
 Q(m,n)=m^2+5n^2,\qquad
 A=\begin{pmatrix}5^{-1/2}&0\\0&5^{1/2}\end{pmatrix},\qquad
 \Theta_Q(t)=\sum_{(m,n)\in\mathbb Z^2}
       e^{-\pi t(m^2+5n^2)/\sqrt5}.
\tag{1}
\]
Every coefficient \(r_Q(N)=\#\{(m,n):Q(m,n)=N\}\) is a nonnegative
integer. The determinant of \(A\) is one, and its inverse is obtained by
interchanging the two coordinates. Poisson summation of the Gaussian,
followed by that integral coordinate permutation, therefore gives the
**exact self-duality**
\[
 \Theta_Q(t)=t^{-1}\Theta_Q(1/t),\qquad t>0.
\tag{2}
\]
In particular this example does not merely have a functional equation
relating two unrelated lattices: its normalized theta series is fixed by
Poisson duality.

Let
\[
 E_Q(s)=\sum_{(m,n)\ne(0,0)}Q(m,n)^{-s}
       =\sum_{N\ge1}r_Q(N)N^{-s},\qquad
 \widehat E_Q(s)=\left(\frac{\sqrt5}{\pi}\right)^s
       \Gamma(s)E_Q(s).
\tag{3}
\]
For \(\Re s>1\), Gaussian Mellin integration gives
\(\widehat E_Q(s)=\int_0^\infty(\Theta_Q(t)-1)t^{s-1}dt\).
Splitting at one and using (2) yields the meromorphic continuation
\[
 \widehat E_Q(s)
 =\int_1^\infty(\Theta_Q(t)-1)
       \bigl(t^{s-1}+t^{-s}\bigr)dt
       +\frac1{s-1}-\frac1s.
\tag{4}
\]
Thus \(\widehat E_Q(s)=\widehat E_Q(1-s)\), with only the displayed poles
at zero and one; \(s(s-1)\widehat E_Q(s)\) is entire and symmetric.
These identities are also the stated functional equation of
[Lee, *On the zeros of Epstein zeta functions*, Section 1](https://arxiv.org/pdf/1204.6297).

Despite (1)–(4), \(E_Q\) has many off-critical zeros. The discriminant
of \(Q\) is the fundamental discriminant \(-20\), whose two reduced
primitive positive forms are \((1,0,5)\) and \((2,2,3)\), so the class
number is two. Voronin's theorem, stated as Theorem 1.1 in
[Lee](https://arxiv.org/pdf/1204.6297), says that for every
\(1/2<\sigma_1<\sigma_2<1\), there are at least
\(c(\sigma_1,\sigma_2,Q)T\) zeros of \(E_Q\) in
\(\sigma_1<\Re s<\sigma_2\), \(|\Im s|<T\), for large \(T\).
Lee's Theorem 1.3 sharpens the count to \(cT+o(T)\) and explicitly
includes \(Q=m^2+5n^2\). The same paper records the earlier
Davenport–Heilbronn result of infinitely many zeros even in
\(\Re s>1\). Thus positive lattice multiplicities and exact Poisson
self-duality cannot imply a critical-line theorem for the associated
completed zeta function. This is a two-dimensional lattice with
archimedean factor \(\Gamma(s)\), so the counterexample does not
invalidate a theorem that genuinely uses the one-dimensional
\(\Gamma(s/2)\) factor of Riemann zeta.

## The missing local arithmetic invariant

The finite coefficient witness is already visible at \(2\), \(3\), and
\(6\):
\[
 r_Q(1)=2,\qquad r_Q(2)=r_Q(3)=0,\qquad r_Q(6)=4.
\tag{5}
\]
Indeed \(Q=6\) has the four solutions \((\pm1,\pm1)\), while
\(Q=2\) and \(Q=3\) have none. Consequently the normalized
coefficients \(a_N=r_Q(N)/2\) satisfy
\(a_1=1\) but \(a_6=2\ne a_2a_3=0\). Any Euler product with
normalized local constant terms has multiplicative coefficients at
coprime indices. Hence \(E_Q/2\) has no such Euler product, despite
the positivity and Poisson identity. In class-group language, this
Epstein function is a *sum* of two Hecke \(L\)-functions rather than a
single Euler-product \(L\)-function; see [Lee, Section 1](https://arxiv.org/pdf/1204.6297).

The actual Riemann zeta function has a sharper source invariant:
\[
 \zeta(s)=\prod_p(1-p^{-s})^{-1},\qquad
 -\frac{\zeta'}{\zeta}(s)
   =\sum_p\sum_{k\ge1}(\log p)p^{-ks}
   =\sum_{N\ge1}\Lambda(N)N^{-s},\qquad\Re s>1.
\tag{6}
\]
Its primitive local exponent is exactly one **at every prime**.
The logarithm of the product converges absolutely for \(\Re s>1\),
which proves \(\zeta(s)\ne0\) there. Equation (5) shows why that
elementary conclusion cannot be transferred from lattice-count
positivity to \(E_Q\); in fact the latter has zeros there.

This invariant also separates the two finite countermodels used in the
Suzuki-form audit. A coherent modification of the \(p=2\) Euler factor
to \((1-2^{-s})^{-c}\) changes every \(2^k\) logarithmic-derivative
weight from \(\log2\) to \(c\log2\) when \(c\ne1\). Multiplying
\(\xi(s)\) by a nonconstant polynomial symmetric under
\(s\mapsto1-s\) preserves the functional equation but, after removing
the standard completion, gives \(P(s)\zeta(s)\). As real \(s\to+\infty\),
its absolute value grows polynomially instead of tending to one, so it cannot be a
normalized absolutely convergent Dirichlet Euler product. The
unit-local-factor condition is therefore a genuine arithmetic
distinction. It does **not** establish positivity of the actual Weil
form in \(1/2<\Re s<1\): the familiar zero-free argument from (6)
stops at \(\Re s=1\).

## Comparison with the adelic and screw-operator proposals

[Connes–Consani–Marcolli, *The Weil proof and the geometry of the adeles
class space*, Proposition 6.2 and Corollary 6.3](https://arxiv.org/pdf/math/0703392)
identify positivity of their number-field trace pairing with RH for
the relevant Grössencharakter \(L\)-functions. That is an exact
geometric formulation of the missing sign, not an unconditional
positivity proof. Their Section 7.2 shows that the adelic reduction
cannot be manipulated by naive Fubini: for a nonzero Schwartz function
\(\eta\), the sum of absolute dilation integrals is
\((\int|\eta|)\sum_{n\ge1}1/n=\infty\). The Epstein example is not
itself a Grössencharakter \(L\)-function and is not presented as a
counterexample to their proposition; it disproves the broader proposal
that positive lattice counts plus Poisson duality supply the sign.

[Suzuki, *Weil's quadratic form via the screw function*, Section 7](https://arxiv.org/html/2606.09096v2)
begins by assuming RH. Its global factorization
\(A_\infty=U^*U\) is stated under that assumption; Section 7.7
observes that an unconditional identification of this positive kernel
with the actual screw kernel would prove RH. No unconditional kernel
identification follows from (1)–(6). A route based only on positive
theta counts and Poisson duality therefore fails. Combining the exact
local factors with the archimedean term and both poles is one possible
way to retain the information this counterexample lacks; no sign
estimate of that kind is obtained here.
