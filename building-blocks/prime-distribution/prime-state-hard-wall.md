# A uniform hard wall for the divisor state

Define the complete prime-power divisor state

$$
S(n)=\sum_{d\mid n}\sqrt d\,\Lambda(d)
=\sum_{p^k\parallel n}(\log p)\sum_{j=1}^k p^{j/2},
\qquad n\ge2.
\tag{1}
$$

This is the state variable occurring in the two-history allocation
identity.  It gives an exact primality separator with a uniform gap.

## Theorem

Put

$$
c_*:=\frac{1+2^{-1/2}}2=\frac{2+\sqrt2}{4}<1.
\tag{2}
$$

Then

$$
\boxed{
n\text{ is prime}\quad\Longleftrightarrow\quad
S(n)=\sqrt n\log n.
}
\tag{3}
$$

More sharply, every composite $n$ satisfies

$$
\boxed{S(n)\le c_*\sqrt n\log n,}
\tag{4}
$$

and the constant is optimal, with equality at $n=4$.

### Proof

Write

$$
n=\prod_p p^{k_p}.
$$

For a prime coordinate with $k=k_p\ge1$, put $m=n/p^k$.
Its contribution to (1), divided by its contribution
$k\sqrt n\log p$ to $\sqrt n\log n$, is

$$
r_{p,k,m}
=\frac1{k\sqrt m}\sum_{h=0}^{k-1}p^{-h/2}.
\tag{5}
$$

If $m>1$, then $m\ge2$ and every summand in (5) is at most one, so

$$
r_{p,k,m}\le\frac1{\sqrt2}<c_*.
\tag{6}
$$

If $m=1$, then $n=p^k$.  For composite $n$ one has $k\ge2$.  The
averages of the decreasing positive sequence $p^{-h/2}$ decrease with
$k$, and they decrease when $p$ increases.  Hence

$$
r_{p,k,1}\le\frac{1+2^{-1/2}}2=c_*,
\tag{7}
$$

with equality only for $(p,k)=(2,2)$.

For a composite having at least two distinct prime factors, (6) applies
to every coordinate.  For a prime power, (7) applies to its only
coordinate.  Multiplying the coordinate inequalities by the positive
weights $k_p\sqrt n\log p$ and summing proves (4).  If $n=p$ is prime,
(1) gives $S(n)=\sqrt n\log n$.  Conversely, (4) excludes equality for
every composite, proving (3).  The value $n=4$ proves sharpness.

## Defect coordinate

The normalized defect

$$
\Delta(n)=1-\frac{S(n)}{\sqrt n\log n}
\tag{8}
$$

therefore satisfies

$$
\Delta(p)=0\quad(p\text{ prime}),\qquad
\Delta(n)\ge\frac{1-2^{-1/2}}2
\quad(n\text{ composite}).
\tag{9}
$$

This is stronger than a merely nonzero certificate: prime states and
composite states are separated by a fixed gap independent of size.  It
does not by itself make primality testing faster, because evaluating
(1) from scratch requires factor information.  In a construction that
already evolves the complete divisor state, however, (3) is a constant-
threshold readout and needs no trial division at the observation stage.

For the RH program, (9) supplies a hard boundary coordinate for the
cutoff law.  Any spectral-gap or Stein comparison can split its test
function into the zero-defect prime boundary and the uniformly separated
composite interior without a size-dependent classification error.

## Exponentially convergent prime projector

Set

$$
r(n)=\frac{S(n)}{\sqrt n\log n}\qquad(n\ge2).
\tag{10}
$$

For every integer $k\ge1$ and real $X\ge2$, (3)--(4) give

$$
\boxed{
0\le \sum_{2\le n\le X}r(n)^k-\pi(X)
\le Xc_*^k.
}
\tag{11}
$$

Indeed every prime contributes exactly one, while every composite
contributes a number in $[0,c_*^k]$.  Consequently, if

$$
k>\frac{\log(2X)}{-\log c_*},
\tag{12}
$$

then the right side of (11) is below $1/2$, and prime counting is recovered
exactly by nearest-integer projection:

$$
\boxed{
\pi(X)=\left\lfloor
\sum_{2\le n\le X}r(n)^k+\frac12
\right\rfloor .
}
\tag{13}
$$

There is also a Dirichlet-series form.  For $\Re s=\sigma>1$,

$$
\boxed{
\sum_{n\ge2}\frac{r(n)^k}{n^s}
=\sum_p\frac1{p^s}+\mathcal R_k(s),
\qquad
|\mathcal R_k(s)|\le c_*^k[\zeta(\sigma)-1].
}
\tag{14}
$$

Thus the ordinary prime zeta function is the locally uniform limit on
$\Re s>1$ of Dirichlet series formed solely from powers of the normalized
division state.  The convergence is exponentially fast in the projector
degree and does not deteriorate with the integer being classified.

Equations (11)--(14) make precise what “extracting the state from a prime”
can mean: once the divisor-state stream is present, primality is its
isolated top spectral value and can be recovered through a polynomial
filter.  Extending the locally uniform convergence in (14) toward the
critical strip would require cancellation between the composite-state
coefficients rather than their positive bound; that is the point at which
the RH-scale distribution problem re-enters.
