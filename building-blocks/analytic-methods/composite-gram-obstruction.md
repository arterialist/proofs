# The prime-power Gram comparison does not extend to all divisor indices

This is a written mathematical proof for the full finite cutoff law. Its conclusions concern the stated auxiliary comparison or generator, not a sign of the full Weil form.


This is one exact obstruction at the actual cutoff $x=27$. It concerns the extension of the auxiliary matrix comparison in [prime-power square theorem](../prime-distribution/prime-power-gram-correction.md); it says nothing against the proved prime-power restriction or the full RH target.

Define

$$
\Gamma_x(d,e)=\sum_{1\le n<x}\frac{x-n}{\sqrt n}
\mathbf1_{[d,e]\mid n},\qquad
\mathcal K_x(d,e)=\Gamma_x(d,e)-\Gamma_x(de,de).
$$

The prior note's matrix is the positive diagonal congruence
$K_x(d,e)=\sqrt{de}\,\mathcal K_x(d,e)$. Therefore these two matrices have the same positivity question on any given index set. On prime powers they are positive semidefinite, by the complete one-prime-chain square decomposition. On **all** integers they need not be.

At $x=27$, take the following integer coefficients, with all unlisted coefficients zero:

$$
\begin{array}{c|rrrrrrrrrr}
d&2&3&4&5&6&7&8&9&10&11\\\hline
c_d&-180&-221&-24&-172&254&-121&110&157&300&-40\\[2pt]
d&12&14&15&16&18&20&21&22&24&25\\\hline
c_d&146&301&393&94&-10&76&342&220&-85&10
\end{array}
$$

Then

$$
\boxed{-643.485<c^{\mathsf T}\mathcal K_{27}c<-643.4849<0.}
\tag{1}
$$

Thus matrix domination for arbitrary composite divisor vectors is false. The endpoint index $1$ has an identically zero correction row, so its omission causes no loss. No indices at or above $27$ can contribute.

## Exact finite verification

Set

$$
f(n)=\sum_{d\mid n}c_d,\qquad
g(n)=\sum_{de\mid n}c_dc_e.
$$

Expanding both divisor indicators gives the exact quadratic identity

$$
c^{\mathsf T}\mathcal K_{27}c
=\sum_{n=1}^{26}\frac{27-n}{\sqrt n}
\left[f(n)^2-g(n)\right].
\tag{2}
$$

All coefficients in (2) are integers. The following short rational calculation proves (1), using only integer square roots and exact fractions. Each root interval is certified by integer squaring; signed terms use the correct endpoint for division. This is a finite mathematical certificate, not an eigenvalue approximation or a parameter scan.

The executable [rational certificate](../../certificates/composite_gram_obstruction.py) uses integer square roots at scale $10^{12}$, chooses the correct reciprocal-root endpoint for each signed coefficient, and verifies both strict rational bounds in (1).

The proof is the displayed fixed integer vector and its rational bounds; no approximate eigenvalue is used.

The actual Jordan density vector and the full Möbius--log Selberg vector contain composite entries, so they require a comparison specific to those vectors or an additional correction. This arbitrary-vector counterexample does **not** determine the sign of the correction on either of those particular arithmetic vectors.
