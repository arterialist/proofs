# Dirichlet future observations: exact factorization and sparse inverse obstruction

Fix `L ≥ 2`, write `M(L)=∑_{d≤L} μ(d)` and `c_L=M(L)/L`, and set

\[
x^{(L)}(d)=\mu(d)-c_L1_{d\le L}.
\]

The first `L` coefficients have zero sum.  For the divisor-log observation

\[
(Tx)(n)=\sum_{d\mid n}x(d)\log(n/d),
\]

the centered coefficients are exactly

\[
(Tx^{(L)})(n)=\Lambda(n)-c_LR_L(n),\qquad
R_L(n)=\sum_{\substack{d\mid n\\d\le L}}\log(n/d).
\tag{1}
\]

Thus, for `Re(s)>1`,

\[
\sum_{n\ge1}\frac{(Tx^{(L)})(n)}{n^s}
=-\frac{\zeta'(s)}{\zeta(s)}+c_L\zeta'(s)H_L(s),
\qquad H_L(s)=\sum_{d\le L}d^{-s}.
\tag{2}
\]

For `n≤2L`, every proper divisor of `n` is at most `L`, while the omitted
`d=n` term has `log 1=0`.  Hence

\[
R_L(n)=\sum_{d\mid n}\log(n/d)=\frac{\tau(n)}2\log n.
\tag{3}
\]

Past `2L`, the moving face

\[
E_L(n)=\sum_{\substack{d\mid n\\L<d<n}}\log(n/d),\qquad
R_L(n)=\frac{\tau(n)}2\log n-E_L(n)
\tag{4}
\]

must remain.  Deleting it changes the finite operator.

## Explicit sparse preimages

On rows `1≤d≤L`, define

\[
(A_La)_d=\sum_{\substack{e\mid2d\\e\le d}}a_e\log(2d/e).
\]

Its diagonal is `log 2`.  Let `q` be odd with `1≤q≤L` and set

\[
a_e^{(q)}=1_{q\mid e}\mu(e/q).
\]

Every proper divisor of `2d` is at most `d`; the missing divisor `2d`
again carries `log 1=0`.  Möbius inversion therefore gives

\[
(A_La^{(q)})_d=1_{q\mid d}\Lambda(2d/q).
\tag{5}
\]

Oddness of `q` implies that (5) is nonzero precisely for `d=q2^j`, where
it equals `log 2`.  Consequently

\[
\|a^{(q)}\|_2^2=\sum_{m\le L/q}\mu(m)^2,
\qquad
\|A_La^{(q)}\|_2^2=(\log2)^2
  \left(1+\lfloor\log_2(L/q)\rfloor\right).
\tag{6}
\]

Using the elementary squarefree count in the first expression yields, for
fixed positive odd `q`,

\[
\|A_L^{-1}\|_{2\to2}\gg
\sqrt{\frac{L/q}{\log(2L/q)}}.
\tag{7}
\]

The explicit condition `q≤L` is needed for the displayed logarithmic count;
the source draft left it implicit in the phrase “fixed `q`.”  Equation (7)
is a genuine strengthening of the earlier generic warning about unstable
multiplicative-history inversion: extending the observation horizon to
`2L` removes the finite nullspace but leaves a polynomial inverse loss.

## Why Goldbach positivity does not control the centered bridge

For a finite additive kernel `H`, pulling its quadratic form back through
`T` gives exactly

\[
\sum_{m,n}(Tx)_mH_{mn}(Tx)_n
=\sum_{d,e}x_d\left(\sum_{m,n}T_{md}H_{mn}T_{ne}\right)x_e.
\tag{8}
\]

This is the incidence kernel `T^*HT`, not a scalar additive Fourier
multiplier.  For the actual centered source, the observed row is
`Λ-c_LR_L`; the affine divisor-log square and its signed cross with `Λ`
remain.  A positive Goldbach or heat estimate for `Λ` alone cannot delete
those terms or the inverse loss (7).

The sparse vectors are adversarial operator inputs, not the actual centered
Möbius vector.  They disprove a uniform Loewner or bounded-inverse route.
They do not prove a new estimate for the centered consumer.  A target-scale
bound on that actual source remains the same RH-equivalent Mertens
mean-square obligation recorded in
[the centered-consumer audit](centered-consumer-successor-history-goldbach.md).
No RH progress follows from this obstruction.

## Lean scope

[DirichletFutureObservationFinite.lean](BuildingBlocks/DirichletFutureObservationFinite.lean)
formalizes the complete divisor-log/Mangoldt identity and proves directly
that the literal bounded matrix row
`∑_{e∣2d, e≤d} a_e log(2d/e)` for the supported Möbius dilation equals
`1_{q∣d} Λ(2d/q)` when `q,d>0` and `q` is odd.  It also formalizes finite
centering, the `T^*HT` quadratic pullback, and the abstract inverse
norm-ratio bound.
It does not formalize the analytic Dirichlet series, squarefree asymptotic,
or any coercivity estimate.
