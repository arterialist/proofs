# Gaussian seed differential identity for literal theta parity

Use the actual literal term \(\Phi_n(u)\) from [the literal theta foundation](physical-theta-series-lean-foundation.md). Define
\[
x_n(u)=\pi n^2e^{2u},\qquad a_n(u)=e^{u/2}e^{-x_n(u)}.
\]
[PhysicalThetaSeed.lean](../../formalization/BuildingBlocks/PhysicalThetaSeed.lean) proves the actual real derivatives
\[
x_n'=2x_n,\qquad
a_n'=(1/2-2x_n)a_n,\qquad
a_n''=(1/4-6x_n+4x_n^2)a_n.
\]
The exponential product identities then give, without a series interchange,
\[
\boxed{a_n''-a_n/4=\Phi_n.}
\]
The identity includes \(n=0\): the Gaussian argument is zero, and the quarter-shifted differential expression annihilates \(e^{u/2}\).

At every fixed real \(u\), the seed has the summable majorant
\[
|a_n(u)|\le e^{u/2}e^{-c n},\qquad c=\pi e^{2u}>0.
\]
Seed summability and the already proved literal \(\Phi_n\) summability imply summability of the actual curvature coefficients. The module therefore also proves the exact scalar sum identity
\[
\sum_{n\ge0}a_n''(u)-\frac14\sum_{n\ge0}a_n(u)=\Phi(u).
\]
Here \(a_n''\) refers to each individual seed's proved derivative. The formula does not identify the sum of derivatives with the derivative of the sum.

The proposed parity mechanism uses the full integer Gaussian theta series
\(A(u)=e^{u/2}\sum_{n\in\mathbb Z}e^{-\pi n^2e^{2u}}\). Once its actual Poisson modular dictionary and twice-differentiated series are proved, the duplicated nonzero integer terms give \((D^2-1/4)A=2\Phi\), with the zero term killed exactly. Parity of \(A\) would then give true parity of the literal \(\Phi\), rather than an absolute-value surrogate.

This batch formalizes per-summand derivatives, actual pointwise seed/curvature summability, and scalar sum reconstruction. Local uniform derivative bounds, twice differentiating the infinite series, the integer/Jacobi dictionary, true parity, exponential moments and the killed-ground construction remain outstanding. No arithmetic covariance smallness or RH conclusion follows.

Agent2 supplied these proofs. RH Proof independently reviewed the exact normalization, derivative coefficients, zero-index cancellation and scalar sum hypotheses. The eleven printed declarations compile with only `propext`, `Classical.choice`, and `Quot.sound`.

The separate [local-interchange sequel](physical-theta-local-derivative-interchange.md) now proves the needed summable neighborhood bounds, both actual infinite-series differentiations and full theta continuity. It upgrades the scalar reconstruction above to a genuine derivative identity. Poisson modular identification, parity and moment integrability remain unfinished.
