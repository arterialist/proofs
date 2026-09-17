# The fixed-clock pairing domain already carries a zero-free-region cost

**Status:** Written analytic result by RH Agent3; no RH proof or Lean formalization.

RH Agent3 analytic audit, 2026-09-16. This note classifies a sufficient weighted domain condition for an improper fixed-clock F-ground pairing. It proves an implication, not an equivalence or RH.

Let \(E(x)=\psi(x)-x\), with every prime-power term in \(\psi\). Suppose for one \(N\ge2\) that
\[
 \mathcal J_N=\int_N^\infty
 \frac{E(x)^2}{x^{5/2}(1+\log x)^2}\,dx<\infty. \tag{1}
\]
Then \(\zeta(s)\) has no zeros in \(\Re s>3/4\). Indeed, extending the integral to \([1,\infty)\) changes it only by a finite amount. For every compact subset of \(\Re s>3/4\), Cauchy–Schwarz gives locally uniformly
\[
\begin{aligned}
\int_1^\infty |E(x)|x^{-\Re s-1}dx
&\le \left(\int_1^\infty
 \frac{E(x)^2}{x^{5/2}(1+\log x)^2}dx\right)^{1/2}
 \left(\int_1^\infty x^{1/2-2\Re s}(1+\log x)^2dx\right)^{1/2}<\infty.
\end{aligned} \tag{2}
\]
Thus \(M_E(s)=\int_1^\infty E(x)x^{-s-1}dx\) is holomorphic in this half-plane. In \(\Re s>1\), Stieltjes integration of the literal Chebyshev function gives
\[
 M_E(s)=\frac{-\zeta'(s)/\zeta(s)}s-\frac1{s-1}. \tag{3}
\]
The right side has a removable singularity at \(s=1\). A zero of \(\zeta\) anywhere else in \(\Re s>3/4\) would force a pole in (3), contradicting holomorphic continuation by (2). This uses the meromorphic continuation and ordinary known pole of \(\zeta\), but no RH input.

More generally, the same proof with \(x^{-1-2\sigma}(1+\log x)^{-2}\) in (1) forces zero-freeness in \(\Re s>\sigma\), for \(1/2\le\sigma<1\). The result at \(3/4\) says that the sufficient square-integrable domain used to pass the fixed-clock frozen terminal pairing already demands a strong, presently unproved zero-free half-plane. Consequently that domain cannot be silently inferred from the unconditional PNT error \(E(x)=O(xe^{-a\sqrt{\log x}})\). It does not say that the *actual* pairing diverges; cancellation could define a weaker conditional pairing. The endpoint frozen-terminal condition remains separate.
