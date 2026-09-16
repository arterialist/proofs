# Rational-scale screw matrices for the actual factorial ground

The Matsumoto–Suzuki screw criterion can be tested on a countable set of
matrices whose entries use the actual factorial ground. This is an exact
reformulation of RH, not an unconditional positivity theorem. Its zero-sum
input is [Matsumoto and Suzuki, Theorem 1.3 and Proposition 6.1](https://arxiv.org/html/2409.00888v2).

Use the right-continuous complete Chebyshev function
\(\psi(x)=\sum_{n\le x}\Lambda(n)\), including every prime power, and put
\[
 F(x)=\log x-\sum_{n\le x}\frac{\Lambda(n)}n+\frac{\psi(x)}x,
 \qquad \kappa=1+\gamma_{\rm E}.
\]
The two atomic jumps in \(F\) cancel, so \(F\) is continuous, with
\(F(1)=0\). For \(x>1\), define the explicit archimedean term
\[
 A(x)=\log(2\pi)+\tfrac12\log(1-x^{-2})
       +\tfrac{x}{2}\log\frac{x+1}{x-1}-1,
 \qquad A(1):=\log(4\pi)-1.
\]
The value at one is the continuous right limit: the two logarithmic
singularities cancel. Define, for \(x\ge1\),
\[
 S_F(x)=\sqrt{x}\,\bigl(\kappa-F(x)\bigr)-x^{-1/2}A(x),
 \qquad S_F(1)=\gamma_{\rm E}+2-\log(4\pi).
 \tag{1}
\]
The unconditional finite explicit formula already recorded in
[the literal successor transport](goldbach-literal-successor-counting-transport.md)
gives \(S_F(x)=H_1(x)\) for \(x>1\), where
\(H_1(x)=\sum_\rho x^{\rho-1/2}/[\rho(1-\rho)]\). The zero series
converges absolutely and uniformly on compact logarithmic intervals.
The symmetry \(\rho\mapsto1-\rho\) gives
\(H_1(e^{-t})=H_1(e^t)\), so the values in (1) determine the whole even
logarithmic function.

For rational \(q,r\ge1\), let
\[
 \mathcal K_F(q,r)
 =S_F\!\left(\max\{q/r,r/q\}\right)-S_F(q)-S_F(r)+S_F(1).
 \tag{2}
\]
Then the following countable collection of purely arithmetic matrix
inequalities is **equivalent to RH**:
\[
 \sum_{i,j=1}^{k}z_i\overline{z_j}\,
      \mathcal K_F(q_i,q_j)\ge0
 \quad\text{for every }k\ge1,\ q_i\in\mathbb Q_{\ge1},\ z_i\in\mathbb C.
 \tag{3}
\]
Indeed, setting \(t_i=\log q_i\) turns (2) into the screw kernel
\(H_1(e^{t_i-t_j})-H_1(e^{t_i})-H_1(e^{-t_j})+H_1(1)\).
RH implies (3) by the cited Theorem 1.3. Conversely, the logarithms
of positive rationals at least one are dense in \([0,\infty)\), and the
kernel is continuous; hence (3) holds for every finite set of
nonnegative \(t_i\). To obtain an arbitrary real configuration, shift
all its points by their common minimum into \([0,\infty)\). For
coefficients whose sum is zero, the quadratic form of the even function
\(H_1(e^t)-H_1(1)\) depends only on pairwise differences and is
unchanged by this shift. Expanding the zero-sum coefficient at an
anchor point shows that positivity of the nonnegative-time matrices is
exactly positivity of the full screw kernel. Theorem 1.3 then gives RH.

The one-point case of (3) reads \(S_F(q)\le S_F(1)\). It is only one
necessary row of the full criterion here; no one-point converse is
claimed. The two-point integer minor and its finite \(H_1\) arithmetic
rows are discussed in [the lowest-minors audit](goldbach-screw-lowest-minors-audit.md),
and [FactorialHOneFinite.lean](BuildingBlocks/FactorialHOneFinite.lean)
formalizes the integer finite-row identity. Neither the rational-grid
extension nor the global matrix positivity is formalized in Lean.

The useful feature of (3) is its exact source dictionary: every matrix
entry is a value of the original complete-prime-power \(F\) plus the
explicit archimedean correction. Goldbach representation existence and
positivity of its uncentered coefficients do not establish (3).
