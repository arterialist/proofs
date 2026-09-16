# Fixed-profile Green admission: finite-horizon approximation audit

The available source result is convergence for each fixed divisor profile. It does not state a rate uniform in the new prime `p`, in the old prime set, or in the largest old/delayed divisor. This distinction is decisive because the natural packet at stage `p` changes with `p`.

For a fixed prime $p$ and its fixed finite old packet, let $F_X,U_X$ be the actual finite-horizon old and delayed vectors and $F,U$ their limiting Green vectors. Write $E_X=F_X-F$ and $V_X=U_X-U$. The exact identity formalized in [FixedProfileGreenAdmissionFinite.lean](BuildingBlocks/FixedProfileGreenAdmissionFinite.lean) is

\[
\begin{split}
 \Delta(F+E_X,U+V_X)-\Delta(F,U)=2(&2\langle U,V_X\rangle+\|V_X\|^2
 -2\langle F,V_X\rangle\\
 &-2\langle E_X,U\rangle-2\langle E_X,V_X\rangle).
\end{split}
\]

Thus ordinary norm convergence $E_X\to0$, $V_X\to0$ suffices for $\Delta_X\to\Delta$ at each fixed packet. If the limiting increment is strictly nonzero, its sign transfers once

\[
 |\Delta_X-\Delta|<|\Delta|.
\]

This is a useful but pointwise statement: every fixed admission can eventually be represented at sufficiently large horizon.

It does not produce an eventual statement along the natural growing stages. The audited limiting scale is

\[
 \Delta_p\asymp e^{-2p}/p
\]

up to the oscillatory Möbius factor, while delayed faces can have scales $e^{-2pd}$. A joint transfer along $p\to\infty$ therefore requires a complete-packet error smaller than the actual margin, in particular exponentially small in $p$ on admissions whose normalized limiting value is bounded away from zero. The existing fixed-divisor convergence gives no function $X_0(p)$ and no bound after the divisor complex grows.

The enlarged paid-region estimates only improve physical ray lengths polynomially. Their remaining quotient range still permits dilation indices growing with `X`, and exponential Green margins at those indices are much smaller than this polynomial improvement. Consequently they do not yield a weaker uniform scale adequate for the prime oscillation theorem.

A diagonal choice of a separate, unspecified horizon $X_p$ for each fixed $p$ follows abstractly from pointwise convergence whenever $\Delta_p\ne0$. It does not control natural horizons such as $p$ comparable to $X$, does not give a single tail valid for all later primes, and cannot establish finite-horizon eventual nonmonotonicity. No stronger finite-$X$ transfer is currently justified.
