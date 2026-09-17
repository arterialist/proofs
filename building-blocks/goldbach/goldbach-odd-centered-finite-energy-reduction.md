# Odd centered Goldbach source and the power-of-two correction

The coefficient decomposition, n=1 centering, arbitrary finite
weighted heat sums, and exact even Mangoldt power-of-two support are
compiled in `BuildingBlocks/GoldbachOddCentering.lean`,
independently parent-compiled without warnings using only standard
Lean axioms. Infinite heat identities, correction integrability and
criterion transfer below remain written mathematics. This is a parity reduction
of the existing centered heat and positive-norm RH criteria. It
supplies no unconditional critical-scale estimate or Goldbach proof.

For t>0 use the discrete centered heat source

\[
D(t)=\sum_{n\ge1}(\Lambda(n)-1)e^{-nt},\qquad
O(t)=\sum_{n\ge1,\ n\text{ odd}}(\Lambda(n)-2)e^{-nt}.
\]

The odd centering is 2, because the odd lattice has density one half.
Every odd prime power stays in O, including n=1 with coefficient -2.
The only even integers with nonzero Mangoldt weight are 2^k, k>=1.
Absolute convergence and the exact geometric series therefore give

\[
D(t)=O(t)+Q(t),\qquad
Q(t)=(\log2)\sum_{k\ge1}e^{-2^k t}+\frac1{e^t+1}.             \tag{1}
\]

In particular Q is positive. The last term comes from twice the odd
unit density minus the full unit density; it is not an omitted parity
endpoint. Splitting the power sum where 2^k t crosses one gives
Q(t)=O(1+log(1/t)) for 0<t<=1. Above that crossing its tail is
bounded by a fixed convergent sum of exp(-2^j). For t>=1, Q(t)
decays exponentially, by 2^k>=k+1 and the geometric majorant.

Let b_D(v)=e^(-v/2)D(e^(-v)) and define b_O,b_Q likewise for v>=0.
The actual critical age metric satisfies

\[
\int_0^\infty|b_Q(v)|^2dv=\int_0^1|Q(t)|^2dt<\infty.        \tag{2}
\]

Hence the L2 norms of b_D and b_O on [0,T] differ by at most one
fixed constant for every T. Their augmented energies have the same
logarithmic growth exponent. The existing zero-Lyapunov and
polynomial-doubling RH criteria transfer exactly to the odd-centered
source. For doubling, mutual bounds A_D<=2A_O+C and A_O<=2A_D+C,
with both augmented energies at least one, transfer its constants.
The existing discrete-to-mixed density comparison then transfers
the result to the objective's mixed heat convention as well.

There is a positive-norm version at each real sigma>0:

\[
\int_0^\infty t^{\sigma-1}|Q(t)|^2dt<\infty.
\]

Thus finiteness of the corresponding positive integral for D is
equivalent to finiteness for O, by the Hilbert triangle inequality.
In the unconditional absolutely convergent range sigma>2,

\[
\frac1{\Gamma(\sigma)}\int_0^\infty t^{\sigma-1}|O(t)|^2dt
=\sum_{a,b\text{ odd}}\frac{(\Lambda(a)-2)(\Lambda(b)-2)}{(a+b)^\sigma}.
\]

The additive coefficient on the right is supported only on even
totals. All pairs are ordered; odd proper powers and the n=1
centering remain. Absolute convergence follows from the logarithmic
coefficient bound and the usual sum over total a+b. Beyond that
range this statement concerns the positive heat integral's finiteness,
not an unproved signed-series convergence or analytic continuation.

Consequently the existing requirement of finite positive centered
norms for every 1<sigma<2 can be tested solely on these odd centered
pairs. Powers of two and the parity density port have been evaluated
as a finite-energy correction, not discarded. Ordinary Goldbach
existence does not bound this signed centered pair norm. Its
unconditional finiteness and critical doubling remain open.
