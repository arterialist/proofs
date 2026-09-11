# Coprime forcing and finite interaction bounds

This building block proves four finite arithmetic and algebraic statements in [Lean](BuildingBlocks/TwoHistoryForcing.lean), in the namespace `BuildingBlocks.TwoHistory`.

For a positive integer $n$, let $\tau(n)$ count its positive divisors and let $\gamma$ be the Euler–Mascheroni constant. Define

$$
h(n)=\log n-\tau(n)+2\gamma.
$$

For positive coprime integers $a,b$, the theorems `forcing_coprime_mixed` and `forcing_coprime_mixed_nonpos` give

$$
h(ab)-h(a)-h(b)+h(1)
=-(\tau(a)-1)(\tau(b)-1)\le 0.
$$

The proof uses $\log(ab)=\log a+\log b$ and the classical coprime multiplicativity of $\tau$. The constant cancels exactly, with $h(1)=-1+2\gamma$. No squarefreeness assumption is needed, so arbitrary prime-power exponents are included. See [NIST DLMF §27.3](https://dlmf.nist.gov/27.3).

For a finite set $S$ and real coefficients $0\le c_p\le1$, define

$$
D_S=\prod_{p\in S}(1-c_p)-1+\sum_{p\in S}c_p,
\qquad
P_S=\frac{(\sum_{p\in S}c_p)^2-\sum_{p\in S}c_p^2}{2}.
$$

The theorem `higherDefect_bounds` proves $0\le D_S\le P_S$, including the empty set. Here $P_S$ is the sum of $c_pc_q$ over unordered pairs of distinct elements. This is the first/second Bonferroni bound for a finite product. The proof is algebraic and assumes no probability model. Its induction uses, for $p\notin S$,

$$
D_{S\cup\{p\}}=(1-c_p)D_S+c_p\sum_{q\in S}c_q,
\qquad
P_{S\cup\{p\}}=P_S+c_p\sum_{q\in S}c_q.
$$

For the classical inclusion–exclusion setting, see J. Galambos, [“Bonferroni Inequalities,” *Annals of Probability* 5 (1977), 577–581](https://doi.org/10.1214/aop/1176995765). Finally, `exponentCoefficient_bounds` proves

$$
0\le\frac1{(a+1)(b+1)}\le1\qquad(a,b\in\mathbb N),
$$

which supplies admissible coefficients when $a,b$ are actual prime exponents, including zero.

The forcing is related to prime counting by the classical identity

$$
\sum_{d\mid n}\mu(d)h(n/d)
=\Lambda(n)-1+2\gamma\,\mathbf1_{n=1}\qquad(n\ge1).
$$

Indeed, $\mu*\log=\Lambda$, $\tau=\mathbf1*\mathbf1$, and $\mu*\mathbf1=\mathbf1_{n=1}$; see [NIST DLMF §27.5](https://dlmf.nist.gov/27.5). This identity explains the application but is not a theorem of this module. The formalized results control a coprime mixed response and a finite product remainder. They do not formalize the full interaction energy among shared primes or prove the global signed cancellation needed for a prime-error bound or RH. In particular, multiplying a local inequality by signed arithmetic weights does not preserve its direction.

The proofs import mathlib's [ArithmeticFunction](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/NumberTheory/ArithmeticFunction.lean) module, including `Nat.Coprime.card_divisors_mul`, and [EulerMascheroni](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/NumberTheory/Harmonic/EulerMascheroni.lean), together with finite-sum algebra and tactics. Those modules credit Aaron Anderson and David Loeffler, respectively, and retain mathlib's Apache 2.0 license. This module uses the repository's MIT license. These are applications of classical mathematics; no originality or first-formalization claim is made.
