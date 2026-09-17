# Complete mixed-ramp Weil cross for one very short ramp

**Status:** independently audited written analytic proof (18 September
2026), developed by RH Agent 3 and checked by RH Agents 1 and 2. The
analytic theorem is not Lean formalized; the [Arb certificate](../../certificates/mixed_ramp_small_length_certificate.py)
checks its scalar margins. Let
\(f_L(x)=e^{-x/2}{\bf1}_{[0,L]}(x)\), and let \(Q\) be the
[complete actual-\(\Lambda\) Weil form](complete-weil-causal-exponential-signed-cone.md),
including every prime power, both poles, and the gamma factor. Then,
for arbitrary \(L,M>0\),

\[
  0<\min(L,M)\le 2/25\quad\Longrightarrow\quad
  Q(f_L,f_M)>0.02647\min(L,M).                         \tag{1}
\]

This is a restricted cross sign, not an RH criterion. It complements
the independently audited [long-ramp theorem](uniform-full-weil-cross-sign-for-long-causal-ramps.md)
\(Q(f_L,f_M)>0.0086\) for \(\min(L,M)\ge10\); it makes no assertion
about the middle range. No literature-priority claim is made.

By symmetry put \(0<L\le M\). Let
\(H(y)=\log y-\sum_{n\le y}\Lambda(n)/n\). The exact pole-minus-prime
cross, derived by differentiating the ramp autocorrelation as a
Stieltjes measure, is

\[
 R(L,M)=e^{-L}\int_0^L e^uH(e^u)\,du
      +e^{-M}\int_{M-L}^M e^uH(e^u)\,du.                \tag{2}
\]

There are no endpoint atoms: the correlation vanishes at either
support boundary. For \(0<u<\log2\), \(H(e^u)=u>0\). The established
actual-Mangoldt [gap](sharp-mangoldt-harmonic-gap-and-weil-residual.md)
\(H(y)\ge(\log2)/2\) for \(y\ge2\) (commit `6f85b03`) therefore gives
\(R(L,M)\ge0\), including any prime-power endpoint.

Put \(\gamma=\) Euler's constant, \(C=1-\gamma-\log(2\pi)<0\),
\(d_n=((2n+2)(2n+3))^{-1}>0\), and \(\lambda_n=2n+5/2\).
The Poisson-smoothed gamma kernel has the absolutely convergent series

\[
 g(u)=Ce^{-|u|/2}+\sum_{n=0}^{\infty}d_ne^{-\lambda_n|u|}.
                                                               \tag{3}
\]

This follows termwise from the partial fractions of
\(\operatorname{Re}\psi(5/4+it/2)-\log\pi\), after multiplication by
\((t^2+1/4)^{-1}\); the [long-ramp note](uniform-full-weil-cross-sign-for-long-causal-ramps.md)
derives the expansion and the exact pole-density cancellation.
Taking the Fourier transforms of both ramps gives

\[
 G(L,M)=g(0)-e^{-L/2}g(L)-e^{-M/2}g(M)
               +e^{-(L+M)/2}g(M-L).                         \tag{4}
\]

The \(C\) contribution in (4) is \(C(1-e^{-L})\), independent of
\(M\). On inserting (3), the \(n\)-th positive contribution is at
least \(d_n(1-e^{-(2n+3)L})\); the exact excess over that value is
\(d_ne^{-(\lambda_n+1/2)M}(e^{(\lambda_n-1/2)L}-1)>0\).
Consequently

\[
 G(L,M)>G_\infty(L)
  :=C(1-e^{-L})+\sum_{n=0}^{\infty}d_n(1-e^{-(2n+3)L}).       \tag{5}
\]

Here \(G_\infty(0)=0\) by dominated convergence, since
\(\sum_nd_n<\infty\). For \(L>0\), differentiating twice is legitimate
by exponentially fast convergence:

\[
 G_\infty''(L)=(-C)e^{-L}
       -\sum_{n=0}^{\infty}d_n(2n+3)^2e^{-(2n+3)L}.          \tag{6}
\]

For \(0<L\le2/25\), discard all but \(n=0,1\) on the negative side,
use \(e^{-L}\le1\), and bound their exponentials at \(L=2/25\):

\[
 -G_\infty''(L)\ge
 {3\over2}e^{-6/25}+{5\over4}e^{-2/5}+C
 >0.6027.                                                     \tag{7}
\]

Thus \(G_\infty\) is strictly concave on \((0,2/25]\). Arb at 192-bit
precision certifies that its first 1000 positive series terms yield
\(G_\infty(2/25)>0.00211825787310514\); in particular the chord
slope exceeds \(0.02647\). Concavity and \(G_\infty(0)=0\) give
\(G_\infty(L)\ge[L/(2/25)]G_\infty(2/25)>0.02647L\).
Combining this with (2) and (5) proves (1).

Run `python3 certificates/mixed_ramp_small_length_certificate.py` from
the repository root with `python-flint` installed to check the
one-sided series truncation, the concavity margin, and the chord slope.
The computation certifies only these scalar bounds; the inequalities
(2)--(7) are the written analytic proof.

The prime input \(H\ge0\) is much weaker than RH. In a formal
zero-multiset perturbation, replacing two line pairs at ordinates
at least \(R\) by one off-line quartet with horizontal displacement at
most \(1/4\) changes a mixed-ramp value by at most \(16L/R\): each
short-ramp spectral factor is at most \(L\), each long-ramp factor at
most \(2/R\), and there are eight old/new occurrences. For \(R\ge1000\),
this is less than \(0.016L\), so the sign in (1) persists. Thus (1)
supplies no sign for signed combinations or arbitrary compact tests.
