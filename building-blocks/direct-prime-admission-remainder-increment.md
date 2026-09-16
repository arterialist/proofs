# Direct prime-admission remainder increment

## Conclusion

Differencing two uniform level bounds loses the localization of the newly
admitted faces.  Direct differencing restores it.  Every non-endpoint divisor
row added at the prime `p` has index `d=pe`, with `e` composed of older primes
and

\[
 \mu(pe)=-\mu(e).                                                      \tag{1}
\]

The analytic profiles at index `pe` live near `y=pe`.  Their product with an
old aggregate profile supplies a second exponential factor.  After retaining
the common row remainder through polarization, the bare
`O((log X)^(-2))` level error disappears from the admission increment.

Put `L=log X`.  For every fixed `1/20<delta<1/2`, on either prime subsequence
where

\[
 p^{1-\delta}e^{2p}|\Delta_p|\longrightarrow\infty,                   \tag{2}
\]

the finite-horizon admission has the same sign whenever

\[
 \boxed{p^{2-\delta}=o(L).}                                           \tag{3}
\]

A convenient uniform range is

\[
 p\le L^{1/(2-\delta)-\eta}                                          \tag{4}
\]

for any fixed `eta>0`.  The first prime-density correction is the limiting
term in this argument.  The current inputs give no sign relation between that
correction and the Mertens-derived fixed-profile admission.

Since `delta` may be chosen arbitrarily close to `1/2`, the strongest simple
power statement is: for every fixed `eta>0`, both oscillatory signs transfer
along suitable prime subsequences in the range

\[
 p\le (\log X)^{2/3-\eta}.                                            \tag{4a}
\]

The exponent `2/3` is a supremum of the fixed-`delta` conclusions, not an
endpoint claim at `delta=1/2`.

The separately audited second-Abel endpoint theorem enlarges levelwise
endpoint decay to every fixed `P<=X^(1-epsilon)`.  It does not enlarge (3): an
individual fixed-profile admission is exponentially smaller than a level
energy, and sign transfer needs the local estimates proved here.

## Exact face increment

Let `D_-` be the squarefree divisors of the product of primes below `p`.  If a
row packet has the form

\[
 H_P=\sum_{d\mid P^\#}\mu(d)H_d,
\]

then unique factorization gives the exact Boolean-face identity

\[
 H_p-H_{p^-}=-\sum_{e\in D_-}\mu(e)H_{pe}.                             \tag{5}
\]

There is no divisor-count approximation in (5).  Old and new orientations
are both present.  Since `p` does not divide `e`, (1) is literal.  This also
retains prime powers in the source decomposition: nonsquarefree source
integers have actual Möbius coefficient zero, while squarefree rough
composites remain in their separate row.

For the main profiles, write

\[
 U_p^G=\sum_{e\in D_-}\mu(e)G_{pe},\qquad
 U_p^J=\sum_{e\in D_-}\mu(e)J_{pe}.
\]

Then

\[
 F_p=F_{p^-}-U_p^G,\qquad J_p=J_{p^-}-U_p^J.                          \tag{6}
\]

## The localization envelopes

The complete integer envelopes from the component proofs imply

\[
 |F_{p^-}(y)|\ll \log(2+y)e^{-y},\qquad
 |J_{p^-}(y)|\ll (1+y)e^{-y}.                                        \tag{7}
\]

Enlarging the old squarefree cofactors to all positive integers gives

\[
 |U_p^G(y)|\ll
 \begin{cases}
 p^{-1}e^{y-2p},&y\le p,\\
 p^{-1}\{1+\log(y/p)\}e^{-y},&y>p,
 \end{cases}                                                         \tag{8}
\]

and

\[
 |U_p^J(y)|\ll
 \begin{cases}
 p^{-1}e^{y-2p},&y\le p,\\
 p^{-2}(1+y)e^{-y},&y>p.
 \end{cases}                                                         \tag{9}
\]

These are absolute bounds.  They do not use cancellation among the
`mu(e)`.  Integrating (7)-(9) gives

\[
 \langle U_p^G,J_{p^-}\rangle\ll pe^{-2p},\qquad
 \langle F_{p^-},U_p^J\rangle\ll e^{-2p}\log(2p),                    \tag{10}
\]

and the new-new product is smaller.  Hence the exact first-correction
increment

\[
 C_p-C_{p^-}
 =4\{\langle U_p^G,J_{p^-}\rangle
 +\langle F_{p^-},U_p^J\rangle
 -\langle U_p^G,U_p^J\rangle\}
\]

satisfies

\[
 \boxed{|C_p-C_{p^-}|\ll pe^{-2p}.}                                  \tag{11}
\]

This improves the global-norm estimate `O(e^(-p)/p)` by using where the two
profiles overlap.

## Polarization keeps the common remainder

Let `B` be the corrected model row, `R` its old remainder, `U` the admitted
model face, and `V` the admitted remainder face.  The new row is
`(B-U)+(R-V)`.  Direct expansion gives

\[
\begin{aligned}
&\{\|(B-U)+(R-V)\|^2-\|B+R\|^2\}
 -\{\|B-U\|^2-\|B\|^2\}\\
&\quad=-2\langle U,R\rangle-2\langle B-U,V\rangle
       -2\langle R,V\rangle+\|V\|^2.                                \tag{12}
\end{aligned}
\]

The common remainder `R` is multiplied by the local face `U`.  Subtracting
two levelwise inequalities replaces this structure by `2||R||` and loses the
gain.

The pointwise remainder envelopes have the same `e^(-y)` tail as (7).  For
example, the common second-log row is bounded by

\[
 L^{-2}(1+y^2)e^{-y},                                                  \tag{13}
\]

whereas its admitted face is the sum of `Q_(pe)/L^2`.  Equations (8),
(12), and (13) yield an energy-increment error

\[
 O\!\left(p^2e^{-2p}/L^2\right)                                      \tag{14}
\]

instead of `O(L^(-2))`.

## Component ledger

All entries below use the common normalization

\[
 \|z\|_{G,X}^2=(1-e^{-2/X})\sum_{j\ge1}|z_j|^2.
\]

### Second logarithm

The exact new row is

\[
 -\sum_{e\in D_-}\mu(e)R_{pe}^{(2)}.
\]

Its norm obeys

\[
 \left\|\sum_e\mu(e)R_{pe}^{(2)}\right\|
 \le \frac3{L^2}\sum_{e\ge1}\frac{e^{-pe}}{pe}
 \ll \frac{e^{-p}}{pL^2}.                                            \tag{15}
\]

The energy cross term must use the spatial envelopes, not Cauchy with a
uniform model norm.  This gives (14).

### Sampling

The sampled-minus-continuous increment of `F^2` is the rectangle error for

\[
 (F-U_p^G)^2-F^2=-2FU_p^G+(U_p^G)^2,                                 \tag{16}
\]

and similarly for `FJ` and `J^2`.  Product variation and (8)-(9) give

\[
 O\!\left(e^{-p}/(pX)\right).                                        \tag{17}
\]

This term has only one exponential, but the extra `X^(-1)` makes it
negligible throughout (3).

### Moving ceiling and lower prime atom

The ceiling identity `ceil(j/d)=1+floor((j-1)/d)` is exact, so it has no
increment error.  A possible lower prime atom on a new face `d=pe` has norm

\[
 O\!\left((L/X)e^{-pe}\right).
\]

Summing the cofactors gives

\[
 O\!\left((L/X)e^{-p}\right).                                        \tag{18}
\]

The atom is kept whether `X` itself is prime.  No open or closed endpoint is
silently changed.

### PNT remainder

The one-face Stieltjes error retains the lower point
`X max(1,y/d)`.  Restricting the complete divisor estimate to `d=pe` and
splitting at `pe<y` gives a new-face envelope with the same two regions as
(8), multiplied by

\[
 L e^{-c\sqrt L}
\]

and a fixed polynomial in `y`.  Polarization with the old profile yields

\[
 O\!\left(p^2L e^{-c\sqrt L}e^{-2p}\right).                           \tag{19}
\]

Every moving lower endpoint is retained.  The exponential in `sqrt L`
beats the polynomial range (3).

### Rough composites

The exact source is

\[
 c_X=\delta_1-1_{\{q>X:q\text{ prime}\}}+r_X,
\]

where nonzero `r_X(n)` is squarefree and `n>X^2`.  On the new faces,

\[
 \frac LX\sum_{e\ge1}\sum_{n>X^2}e^{-pen/X}
 \ll Le^{-pX}.                                                        \tag{20}
\]

This retains every rough composite and is negligible.

### Growing-divisor endpoint

Let `W_(X,p)` be the endpoint packet added at `p`.  The literal face norm
`||v_d||^2=q^d-q^(2d)<=1/4` gives

\[
 \frac LX\|W_{X,p}\|_{G,X}
 \le\frac{L}{2X}2^{\pi(p^-)}.                                       \tag{21}
\]

Polarizing the full endpoint energy keeps its cross terms with the old
endpoint and the non-endpoint row.  In the polynomial range (3),
`2^(pi(p))=exp(o(L))`, so (21), even after division by the margin in (2), is
`exp(-L+o(L))`.  It is negligible.  The second-Abel estimate is needed for
large level cutoffs, but not for these local stages.

The endpoint does expose a real obstruction to a purely geometric
improvement.  Projection onto the degree-zero Hodge mode leaves the scalar
Abel-Mertens tail.  The moving Abel cutoff does not commute with that
projection, and `P=2` already changes sign as the endpoint index moves.

## Assembled increment

Combining (11), (14), and (17)-(21) gives the conservative uniform estimate

\[
\begin{aligned}
 |\Delta_{X,p}-\Delta_p|\ll{}&
 e^{-2p}\left\{\frac pL+\frac{p^2}{L^2}
      +p^2Le^{-c\sqrt L}\right\}\\
 &+\frac{e^{-p}}{pX}+\frac{Le^{-p}}X
   +\frac L X2^{\pi(p)}+Le^{-pX}.                                    \tag{22}
\end{aligned}
\]

The `p/L` term is the first density correction.  Divide (22) by the
oscillatory fixed-profile scale `e^(-2p)p^(delta-1)`.  Condition (3) kills
the first term.  It also implies `p=o(L)`, so every other displayed ratio
tends to zero.  This proves the sign transfer stated at the start.

## Three cancellation mechanisms and their adversarial tests

### Boolean face pairing

Equation (5) pairs every old divisor `e` with the unique new divisor `pe`.
It preserves the Möbius orientation and localizes all analytic rows.

The pairing does not make the endpoint faces orthogonal.  On the interval
`e<j<=pe`, only the new face is present.  Replacing the endpoint Gram by a
diagonal form would discard this interval and is false.

### Hilbert polarization

Equation (12) cancels the common level error before norms are taken.  It is
the source of the improvement from a bare `L^(-2)` to (14).

Polarization alone is not enough.  Applying global Cauchy to
`<U,R>` gives only one `e^(-p)`.  The second exponential comes from the
literal moving profiles (7)-(9).  Any proof that omits their spatial overlap
falls back to the old range.

### Mellin or Abel zero-mode cancellation

For the growing endpoint, a second Abel summation kills the complete constant
Mertens moment and extends levelwise endpoint decay almost to `P=X`.  The
separate audit verifies that result after its floor and PNT terms are restored.

For one prime admission, the consumer is different.  The density correction
(11) is a signed mixed Green inner product, not the complete Mertens zero
moment.  Current inputs give its size but no correlation with `T(p)`.  Using
the endpoint zero-mode identity to assign it a favorable sign would conflate
two different rows.

Sampling gives a fourth useful check.  Lattice differencing localizes the
variation to (16), but it keeps only one exponential.  Its `X^(-1)` factor is
what makes it harmless.  There is no hidden sampling orthogonality.

## Remaining obstruction and RH scope

The direct increment analysis improves sign transfer from almost
`log log X` to the polynomial-logarithmic range (3).  Extending it further
requires one of two new inputs:

1. a sharper bound for the mixed correction increment in (11), or
2. a theorem relating its sign to the fixed-profile source `T(p)`.

Neither follows from the present absolute envelopes.  The result concerns
partial prime admission with `p=o(log X)`.  It does not estimate complete
admission `P=X`, the remaining weighted Mertens endpoint, or an RH-equivalent
central energy.  It therefore makes no RH advance.

## Lean formalization

[AdmissionIncrementCancellationFinite.lean](BuildingBlocks/AdmissionIncrementCancellationFinite.lean) proves:

1. the exact fixed-profile admission square;
2. identity (12), retaining all four mixed and square terms;
3. its Cauchy bound with the common remainder multiplied by the local face;
4. the full bilinear correction increment with both orientations; and
5. abstract finite Boolean-face pairing.

The module compiles under Lean 4.24 without `sorry`, `admit`, or new axioms.
Printed theorem dependencies are only `propext`, `Classical.choice`, and
`Quot.sound`; the face-pairing theorem does not need `Classical.choice`.
