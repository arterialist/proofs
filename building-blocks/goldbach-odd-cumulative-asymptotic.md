# The cumulative odd Goldbach channel

This is a refinement of the finite odd-total power-of-two identity in
[GoldbachOddPowerBoundFinite.lean](BuildingBlocks/GoldbachOddPowerBoundFinite.lean).
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
[the actual heat-response audit](actual-heat-renewal-cell-trace-audit.md),
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

Equation (4) is lower order than the \(X^{3/2+\varepsilon}\) error in
the [one-sided cumulative Goldbach criterion](goldbach-one-sided-cumulative-rh-criterion.md).
It sharpens the parity accounting but does not supply that criterion's
unproved one-sided estimate.

[GoldbachOddCumulativeFinite.lean](BuildingBlocks/GoldbachOddCumulativeFinite.lean)
formalizes (1) with the exact finite source cutoff and proves that its
coefficients agree with the complete ordered Goldbach coefficients
through the cumulative horizon. Its public theorems use only Lean's
standard logical axioms. Equations (2)--(6), including the PNT
application, remain written proofs and are not yet Lean theorems.
