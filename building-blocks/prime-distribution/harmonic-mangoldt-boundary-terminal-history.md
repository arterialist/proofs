# The terminal prime error as a harmonic-boundary history

## Status and scope

This note gives an unconditional exact representation of the actual integer
prime error and its dyadic terminal mass through the harmonic von Mangoldt
boundary. Every prime power and endpoint is retained. The finite identities,
the jump law, the continuous-to-discrete terminal identification, and the
implications from a stated Balazard cutoff hypothesis are formalized in Lean.
The published all-cutoff Balazard inequality itself remains an external
analytic input.

The representation exposes a zero-mean signed contrast of nonnegative
boundary values. It does not estimate that contrast at square-root scale and
does not prove RH.

## 1. The boundary and its arithmetic phase transitions

For an integer $N\ge0$, set

\[
 A(N)=\sum_{n\le N}\frac{\Lambda(n)}n,
 \qquad B(N)=\log N-A(N),                                           \tag{1}
\]

using the convention $\log0=0$. At every successor,

\[
 B(N+1)-B(N)
 =\log(N+1)-\log N-\frac{\Lambda(N+1)}{N+1}.                       \tag{2}
\]

Thus the boundary follows the smooth logarithmic clock between admissions
and has the complete downward von Mangoldt jump at every prime power. No
proper power is discarded.

Balazard's published inequality $A(N)\le\log N$ gives $B(N)\ge0$.
The elementary factorial estimate already formalized in the repository gives
$A(N)\ge\log N-1$ for $N\ge1$. Consequently

\[
 0\le B(N)\le1.                                                     \tag{3}
\]

In Lean, the lower bound is deliberately expressed as an implication from
`BalazardBoundAt N`; it is not silently installed as an axiom.

## 2. Exact Abel reconstruction of the prime error

Finite Abel summation gives

\[
 \psi(N)=N A(N)-\sum_{k=0}^{N-1}A(k).                              \tag{4}
\]

Define the deterministic factorial drift

\[
 D(N)=N\log N-\sum_{k=0}^{N-1}\log k-N.                            \tag{5}
\]

Substitution of $A=\log-B$ into (4) yields the exact history formula

\[
 \boxed{
 \psi(N)-N
 =D(N)-N B(N)+\sum_{k=0}^{N-1}B(k).}                               \tag{6}
\]

The negative current boundary value and the positive accumulated history
must remain together. Positivity of $B$ does not sign their difference.

## 3. The literal dyadic terminal mass

For a positive integer $X$, the continuous terminal channel is

\[
 T_X=\int_X^{2X}\bigl(\psi(\lfloor x\rfloor)-x\bigr)dx.
\]

The exact cell decomposition is

\[
 T_X=\sum_{k=X}^{2X-1}(\psi(k)-k)-\frac X2.                        \tag{7}
\]

This is the same quantity as the prime-power expression

\[
 T_X=X\psi(X)+\sum_{X<n\le2X}(2X-n)\Lambda(n)-\frac32X^2.          \tag{8}
\]

Substituting (6) into (7) gives the formally verified nested history

\[
 \boxed{
 T_X=\sum_{k=X}^{2X-1}
 \left(D(k)-kB(k)+\sum_{j=0}^{k-1}B(j)\right)-\frac X2.}           \tag{9}
\]

Reversing the finite triangular sum, with no estimate, gives the more
revealing written form

\[
\begin{aligned}
 T_X={}&\sum_{k=X}^{2X-1}D(k)-\frac X2\\
 &+X\sum_{j=0}^{X-1}B(j)
 -\sum_{j=X}^{2X-1}(2j-2X+1)B(j).                                 \tag{10}
\end{aligned}
\]

The early weights have total $X^2$ and the late odd weights
$1,3,\ldots,2X-1$ also have total $X^2$. Hence the complete boundary
functional in (10) annihilates a constant history on
$\{0,\ldots,2X-1\}$. The actual initial value $B(0)=0$ and every subsequent
prime-power jump remain present.

Equation (3) alone bounds the two sides of this contrast separately at order
$X^2$. The desired complete-dual terminal estimate is
$O_\varepsilon(X^{3/2+\varepsilon/2})$, so compactness and positivity of the
boundary still lose a square root. Any improvement must use correlation in
the exact successor law (2), rather than only the box constraint (3).

## 4. Formal verification

[HarmonicBoundaryHistory.lean](../../formalization/BuildingBlocks/HarmonicBoundaryHistory.lean)
verifies:

- `harmonicMangoldtBoundary_succ`, the exact jump law (2);
- `psi_eq_harmonicPrimeMass_abel`, the Abel identity (4);
- `integerError_eq_harmonicBoundary_history`, equation (6);
- `primePrimitiveArea_nat_eq_sum_integerError`, the exact half-cell formula;
- `coarseTerminalMassFinite_eq_discreteDyadicTerminalMass`, equality of
  (7) and the previously formalized continuous terminal channel;
- `coarseTerminalMassFinite_eq_harmonicBoundary_history`, equation (9);
- the implications from `BalazardBoundAt` to $B(N)\ge0$ and, with the
  elementary lower estimate for $A(N)$, $B(N)\in[0,1]$.

The axiom audit for the principal equalities reports only `propext`,
`Classical.choice`, and `Quot.sound`. There are no custom axioms and no
`sorry` declarations. Equation (10) is a written finite reindexing of (9);
it is not separately named as a Lean theorem.

## Verdict

The actual prime-error terminal mass is a balanced early-history versus
late-boundary contrast of the nonnegative harmonic Mangoldt boundary. This
is a stricter description than an arbitrary positive continuous boundary:
the exact prime-power jump law (2) fixes every transition. The available
pointwise constraints nevertheless recover only the quadratic scale. The
remaining useful target is a genuinely new correlation estimate for the
signed contrast in (10), derived from the actual jump sequence without
assuming a square-root bound for $\psi(x)-x$ or an equivalent form of RH.
