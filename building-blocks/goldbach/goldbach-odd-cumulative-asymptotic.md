# The cumulative odd Goldbach channel

This is a refinement of the finite odd-total power-of-two identity in
[GoldbachOddPowerBoundFinite.lean](../../formalization/BuildingBlocks/GoldbachOddPowerBoundFinite.lean).
All pairs are ordered and weighted by the complete von Mangoldt function;
in particular, the odd partner may be a proper prime power. The result
uses no Goldbach existence hypothesis.

For an integer \(N\ge4\), put

\[
R(n)=\sum_{a+b=n}\Lambda(a)\Lambda(b),\qquad
S_{\rm odd}(N)=\sum_{\substack{n\le N\\n\text{ odd}}}R(n),
\qquad K=\lfloor\log_2N\rfloor.
\]

Set \(\Psi_{\rm odd}(y)=\sum_{m\le y,\ m\text{ odd}}\Lambda(m)\),
including \(\Psi_{\rm odd}(0)=0\). Since the only even indices with
nonzero von Mangoldt weight are \(2^k\), exchanging the two ordered
indices gives the **exact** cumulative identity

\[
\boxed{S_{\rm odd}(N)=2\log2\sum_{k=1}^{K}
              \Psi_{\rm odd}(N-2^k).} \tag{1}
\]

The term with \(2^K=N\), when it occurs, has zero partner sum. Thus
(1) includes the endpoint without an exceptional convention for
ordered pairs. Define \(J(y)=\lfloor\log_2y\rfloor\) for \(y\ge1\)
and \(J(0)=0\). The complete prime-power identity is

\[
\Psi_{\rm odd}(y)=\psi(y)-(\log2)J(y),\qquad y\ge0. \tag{2}
\]

Indeed, \(2,4,8,\ldots\) are precisely the even prime powers. With
\(E(y)=\psi(y)-y\), equations (1)--(2) give a second **exact** formula:

\[
\boxed{\begin{aligned}
S_{\rm odd}(N)=2\log2\bigg[&KN-2^{K+1}+2
 +\sum_{k=1}^{K}E(N-2^k)\\
 &-(\log2)\sum_{k=1}^{K}J(N-2^k)\bigg].
\end{aligned}} \tag{3}
\]

No prime-only replacement is made in (3): \(E\) retains every
prime power, while the last term removes exactly the even ones from
the odd partner.

The classical zero-free-region prime number theorem, also used in
[the actual heat-response audit](../theta-and-heat/actual-heat-renewal-cell-trace-audit.md),
supplies, for
some \(c>0\),
\(E(y)=O(y\exp(-c\sqrt{\log y}))\) for \(y\ge2\).
For \(k\le K-1\), \(N-2^k\ge N/2\), so their total error is
\(O(N\log N\exp(-c'\sqrt{\log N}))\). The remaining \(k=K\)
term obeys the same bound when its argument is at least \(\sqrt N\);
otherwise Chebyshev's bound \(\psi(y)=O(y)\) makes it \(O(\sqrt N)\).
The \(J\)-sum is \(O(\log^2N)\). Absorbing these terms by reducing
the positive constant \(c'\) proves

\[
\boxed{S_{\rm odd}(N)
 =2\log2\bigl(KN-2^{K+1}+2\bigr)
  +O\!\left(N e^{-c'\sqrt{\log N}}\right).} \tag{4}
\]

In particular \(S_{\rm odd}(N)\sim2N\log N\), improving the
\(O(N\log^2N)\) bound obtained by summing the pointwise odd-total
estimate. The order-\(N\) term in (4) records the ordinary binary
clock rather than a smooth constant. If
\(\theta=\{\log_2N\}\), then (4) is equivalently

\[
S_{\rm odd}(N)=2N\log N+N\Phi(\theta)
 +O\!\left(N e^{-c'\sqrt{\log N}}\right),
\quad
\Phi(\theta)=-2(\log2)\theta-4(\log2)2^{-\theta}. \tag{5}
\]

The endpoint values of \(\Phi\) at \(0\) and \(1\) agree, so it extends
continuously and periodically. For real \(X\ge4\), the exact formulas
apply to \(N=\lfloor X\rfloor\), matching the right-continuous
\(n\le X\) convention.

Dyadic scaling preserves \(\{\log_2N\}\), so the periodic term cancels
from a two-scale difference. More precisely, the explicit main term
in (4) satisfies

\[
2\log2\bigl((K+1)2N-2^{K+2}+2\bigr)
-2\cdot2\log2\bigl(KN-2^{K+1}+2\bigr)
=4(N-1)\log2.
\]

Consequently

\[
\boxed{S_{\rm odd}(2N)-2S_{\rm odd}(N)
 =4N\log2+O\!\left(N e^{-c'\sqrt{\log N}}\right).} \tag{6}
\]

This is an unconditional signed dyadic constraint on the actual
odd-total prime-power channel: the left side is positive for all
sufficiently large \(N\). Its linear size is still below the
critical \(N^{3/2}\) Goldbach error.

## The centered odd channel detects RH

The elementary term removed in (2) matters for an exact spectral
transfer. For \(N\ge2\), define

\[
B_{\rm odd}(N)=2\log2\left[
 KN-2^{K+1}+2-(\log2)\sum_{k=1}^{K}J(N-2^k)\right],
\qquad
\Delta_{\rm odd}(N)=S_{\rm odd}(N)-B_{\rm odd}(N).
\tag{7}
\]

Set \(\Delta_{\rm odd}(0)=\Delta_{\rm odd}(1)=0\). Equation (3) says
exactly

\[
\boxed{\Delta_{\rm odd}(N)
 =2\log2\sum_{2^k\le N,\ k\ge1}E(N-2^k).} \tag{8}
\]

The ordinary integer clock also gives an exact local law. Since
\(E(m+1)-E(m)=\Lambda(m+1)-1\), and a newly admitted power
\(2^k=N+1\) contributes \(E(0)=0\), equation (8) implies, for every
integer \(N\ge0\),
\[
\boxed{\Delta_{\rm odd}(N+1)-\Delta_{\rm odd}(N)
=2\log2\sum_{2^k\le N,\ k\ge1}
  \bigl(\Lambda(N+1-2^k)-1\bigr).} \tag{8a}
\]
In particular, nonnegativity of every von Mangoldt weight yields the
unconditional one-sided step bound
\[
\Delta_{\rm odd}(N+1)-\Delta_{\rm odd}(N)
\ge-2(\log2)J(N). \tag{8b}
\]
If \(N\) is odd, then every \(N+1-2^k\) in (8a) is even. Define
\(C_2(M)\) as the number of **ordered** pairs
\((k,j)\in\mathbb N_{\ge1}^2\) satisfying \(2^k+2^j=M\).
The complete even-prime-power support gives the stronger exact identity
\[
\boxed{\Delta_{\rm odd}(N+1)-\Delta_{\rm odd}(N)
=2\log2\left[(\log2)C_2(N+1)
-J(N)\right],\qquad N\text{ odd}.} \tag{8c}
\]
Binary expansion gives \(C_2(M)\in\{0,1,2\}\): it is one when
\(M=2^r\) with \(r\ge2\), two when \(M\) has exactly two nonzero
binary digits (both at positions at least one), and zero otherwise.
Thus the odd-to-even residual step is completely determined by binary
arithmetic; the odd prime-power information enters at even-to-odd
steps. This local constraint alone gives no RH-scale estimate.

For \(0<z<1\), all following series converge absolutely. Put
\(A(z)=\sum_{k\ge1}z^{2^k}>0\),
\(P(z)=\sum_{n\ge1}\Lambda(n)z^n\), and
\(U(z)=z/(1-z)\). Summing (8) and using
\(\sum_{n\ge0}\psi(n)z^n=P(z)/(1-z)\) gives the exact identity

\[
\boxed{
P(z)-U(z)=
\frac{1-z}{2(\log2)A(z)}
 \sum_{N\ge0}\Delta_{\rm odd}(N)z^N.} \tag{9}
\]

This is a signed, source-faithful transfer from the **odd** Goldbach
channel to the complete prime heat. It is valid only on the positive
real heat axis as used below; no assertion about zero-free complex
values of the lacunary multiplier \(A(z)\) is needed.

Either one of the following one-sided assertions is equivalent to RH:

\[
\begin{array}{ll}
\text{lower:}&\Delta_{\rm odd}(N)\ge
   -C_\varepsilon N^{1/2+\varepsilon},\\
\text{upper:}&\Delta_{\rm odd}(N)\le
    C_\varepsilon N^{1/2+\varepsilon},
\end{array}
\quad
\text{for every }\varepsilon>0\text{ and all sufficiently large }N.
\tag{10}
\]

The two lines are separate criteria. To prove the converse for either,
fix \(0<\varepsilon<1/2\) and put \(z=e^{-t}\). The lower line of
(10) gives
\(\sum_N\Delta_{\rm odd}(N)e^{-Nt}
 \ge-C't^{-3/2-\varepsilon}\), after absorbing the finite head;
the upper line gives the reversed inequality with \(+C't^{-3/2-\varepsilon}\).
Since \(A(e^{-t})\ge e^{-2t}\ge e^{-2}\) for \(0<t\le1\), equation (9)
gives the corresponding lower or upper bound
\(\pm(P(e^{-t})-U(e^{-t}))\le C''t^{-1/2-\varepsilon}\),
with the sign chosen to match the line of (10).
The difference between \(U(e^{-t})=1/(e^t-1)\) and the centered heat
baseline \((1+t^{-1})e^{-t}\) is bounded near zero. Therefore the
actual normalized heat response has the corresponding one-sided
bound \(b(v)=O_\pm(e^{\varepsilon v})\).
The [one-sided heat/Landau argument](goldbach-one-sided-cumulative-rh-criterion.md)
then excludes every zero with real part greater than
\(1/2+\varepsilon\); allowing every \(\varepsilon>0\) proves RH.
Conversely, RH gives \(E(n)=O(n^{1/2}\log^2(2n))\), and the at most
\(\log_2N\) terms in (8) give
\(\Delta_{\rm odd}(N)=O(N^{1/2}\log^3(2N))\). Thus RH gives both lines
of (10). No one-sided bound in (10) is proved unconditionally here.

There is, however, an unconditional two-sided oscillation at the exact
square-root logarithmic scale. For any known critical-line zero
\(\rho=1/2+i\gamma\), let
\(A_\rho=m_\rho|\Gamma(\rho)|>0\). The
[heat residue argument](goldbach-one-sided-cumulative-rh-criterion.md#oscillation-at-the-critical-endpoint)
proves \(\limsup b(v)\ge A_\rho\) and
\(\liminf b(v)\le-A_\rho\) without assuming RH. Elementary dyadic
counting gives
\[
A(e^{-t})=\frac{\log(1/t)}{\log2}+O(1),
\]
because the deficit from \(1\) over
\(k\le\lfloor\log_2(1/t)\rfloor\) is at most
\(t\sum 2^k<2\), while the remaining tail is bounded by
\(\sum_{j\ge1}e^{-2^{j-1}}\). An integral comparison also gives
\[
\sum_{N\ge2}N^{1/2}\log N\,e^{-Nt}
 \sim\Gamma(3/2)t^{-3/2}\log(1/t).
\]
If eventually
\(\Delta_{\rm odd}(N)\le c\sqrt N\log N\), equation (9) therefore
gives \(\limsup b(v)\le c\Gamma(3/2)/2\). The lower-bound case is
identical. Letting \(c\) approach the respective limit superior or
inferior proves
\[
\boxed{
\limsup_{N\to\infty}
\frac{\Delta_{\rm odd}(N)}{\sqrt N\log N}
\ge\frac{4A_\rho}{\sqrt\pi}>0,\qquad
\liminf_{N\to\infty}
\frac{\Delta_{\rm odd}(N)}{\sqrt N\log N}
\le-\frac{4A_\rho}{\sqrt\pi}<0.} \tag{11}
\]
Thus the precisely centered odd cumulative channel changes sign
arbitrarily far out. The constant is a heat-residue transfer bound;
no priority or optimality claim is made.

The local bound (8b) makes those sign changes persist over
square-root-length intervals. Let
\(D_\rho=4A_\rho/\sqrt\pi\). Equation (11) supplies arbitrarily
large \(N\) with
\(\Delta_{\rm odd}(N)\ge(D_\rho/2)\sqrt N\log N\).
For \(0\le h\le(D_\rho/16)\sqrt N\), summing (8b) over the
following \(h\) steps loses at most
\(2h\log(2N)\le(D_\rho/4)\sqrt N\log N\) for large \(N\).
Hence \(\Delta_{\rm odd}\) remains positive throughout that interval.
Applying the same bound backward from the arbitrarily deep negative
values in (11) gives negative intervals
\([N-(D_\rho/16)\sqrt N,N]\). In particular, both signs occupy
arbitrarily distant blocks of length proportional to \(\sqrt N\).
This is an unconditional mesoscopic constraint on the actual odd
Goldbach channel, not a bound on its global amplitude.

The odd channel in (8) consists of a power of two paired with an odd
prime power. Ordinary binary Goldbach existence concerns even totals
represented by two primes and supplies none of the one-sided
estimates in (10).

Equation (4) is lower order than the \(X^{3/2+\varepsilon}\) error in
the [one-sided cumulative Goldbach criterion](goldbach-one-sided-cumulative-rh-criterion.md).
It sharpens the parity accounting but does not supply that criterion's
unproved one-sided estimate.

[GoldbachOddCumulativeFinite.lean](../../formalization/BuildingBlocks/GoldbachOddCumulativeFinite.lean)
formalizes (1) with the exact finite source cutoff and proves that its
coefficients agree with the complete ordered Goldbach coefficients
through the cumulative horizon. It also proves (2), using the
[finite even-power sum](../../formalization/BuildingBlocks/GoldbachOddPowerBoundFinite.lean),
and the finite convolution (8), with the elementary baseline expressed
as a finite sum. It also formalizes (8a)--(8c), including the binary
pair count and the one-sided step bound (8b). These public theorems use
only Lean's standard logical axioms. The closed form for the baseline
in (7), the elementary classification \(C_2(M)\in\{0,1,2\}\), the
quantitative PNT, generating-series identity, Landau criterion,
residue argument, and square-root-length sign blocks remain written
proofs and are not yet Lean theorems.
