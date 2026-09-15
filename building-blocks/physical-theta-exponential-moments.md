# Actual theta exponential moments and bounded exterior multiplication

Use the literal real-line \(\Phi\), with true parity and positivity already proved. Define the finite nonnegative constant
\[
C=4\pi^2\sum_{n\ge0}n^4e^{-\pi n/2}.
\]
For \(u\ge0\), \(n\ge1\), write \(E=e^{2u}\ge1\). The inequalities \(n^2\ge n\) and \((n-1)(E-1)\ge0\) give
\[
n^2E\ge(n+E)/2.
\]
Drop only the nonnegative subtracted coefficient inside a positive theta term, and split its actual Gaussian decay. This gives
\[
\Phi_n(u)\le4\pi^2e^{9u/2}e^{-\pi E/2}n^4e^{-\pi n/2}.
\]
Index zero is treated by its exact vanishing. Summability of the actual coefficient series proves
\[
\boxed{\Phi(u)\le C e^{9u/2}e^{-\pi e^{2u}/2}\quad(u\ge0).}
\]
No theta term or infinite tail is approximated by a prime density.

For \(r\ge0\), \(e^{2r}\ge r^2\) follows from \(e^r\ge1+r\). Completing the square gives, for every real \(a\),
\[
ar-\pi e^{2r}/2\le (a+1)^2/(2\pi)-r.
\]
Apply this at \(r=|u|\), \(a=\beta+9/2\), using the proved literal parity. For every real \(\beta\),
\[
e^{\beta|u|}\Phi(u)
\le C\exp((\beta+11/2)^2/(2\pi))e^{-|u|}.
\]
The right side is integrable on the entire real line. Actual continuity supplies measurability. Thus [PhysicalThetaMoments.lean](BuildingBlocks/PhysicalThetaMoments.lean) proves
\[
e^{\beta|u|}\Phi(u)\in L^1(du)
\]
for every fixed real \(\beta\), without a moment assumption or Fourier–xi identity.

The module also proves integrability after multiplication by any almost-everywhere strongly measurable real \(\psi\) with an almost-everywhere finite bound \(|\psi|\le P\). Its exterior version is the literal source
\[
e^{\beta|u|}1_{|u|>R}\Phi(u)\psi(u).
\]
The exterior set is measurable, and its indicator is retained. These declarations need only the stated multiplier measurability and a.e. bound; they do not assume the multiplier is a ground state or give it an eigenfunction property.

For the actual killed ground, the written boundedness theorem and ground representative identification can now supply those two multiplier hypotheses. The actual killed operator, its ground construction and boundedness, logarithmic physical form domain, archimedean cutoff limit, core arrival identity and full weak ground equation still require formalization. These moment results prove analytic convergence prerequisites, not a signed covariance estimate or RH.

The theta covariance research branch supplied this proof, independently reviewed against the literal series and Poisson parity. The argument uses classical Gaussian domination and completing the square; no novelty claim is made.

Independent central target compilation checks all twelve printed declarations using only `propext`, `Classical.choice` and `Quot.sound`, without new-module warnings. The exterior theorem supplies precisely the exponential integrability premise used by [the complete prime-tail convergence theorem](theta-exponential-weak-prime-tail-lean-prerequisites.md), when the actual ground representative is identified with a measurable bounded multiplier. Its ground and arithmetic hypotheses remain separate.
