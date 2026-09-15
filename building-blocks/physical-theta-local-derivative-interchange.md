# Local envelopes justify the actual twice-differentiated seed sum

Use the literal Gaussian seeds and derivatives of [the seed differential foundation](physical-theta-seed-differential-foundation.md). For real endpoints \(A\le u\le B\), put \(c_A=\pi e^{2A}>0\) and \(x_{n,B}=\pi n^2e^{2B}\). The actual bounds are
\[
|a_n(u)|\le e^{B/2}e^{-c_A n},
\]
\[
|a_n'(u)|\le(1/2+2x_{n,B})e^{B/2}e^{-c_A n},
\]
\[
|a_n''(u)|\le(1/4+6x_{n,B}+4x_{n,B}^2)e^{B/2}e^{-c_A n}.
\]
They follow from monotonicity of \(x_n\), the exact derivative polynomials, \(n^2\ge n\), and nonnegativity of the Gaussian argument. These are fixed-interval bounds on the actual derivatives. The exponential decay is weakened only to apply polynomial–exponential summability; the kernel is unchanged.

[PhysicalThetaUniform.lean](BuildingBlocks/PhysicalThetaUniform.lean) proves all three bounds and summability of their envelopes. It also supplies the previously missing pointwise slope summability. On the open interval \((u-1,u+1)\), mathlib's `hasDerivAt_tsum_of_isPreconnected` applies first to the seed series and then to the slope series. Their one-point convergence comes from the actual seed and slope summability theorems. Thus, writing
\[
A_+(u)=\sum_{n\ge0}a_n(u),
\]
the module proves the genuine derivatives
\[
A_+'(u)=\sum_{n\ge0}a_n'(u),\qquad
A_+''(u)=\sum_{n\ge0}a_n''(u).
\]
Combining the second derivative interchange with the exact scalar reconstruction proves
\[
\boxed{A_+''(u)-A_+(u)/4=\Phi(u)}
\]
for every real \(u\). This is now an infinite-series differential identity, not merely a sum of individual derivatives.

The remaining parity step must identify the full integer Gaussian series with \(2A_+-e^{u/2}\), use the actual Gaussian Poisson modular identity, and transport parity through the second derivative. Mathlib already has a real `tsum_exp_neg_mul_int_sq` Poisson theorem, so a complex Jacobi dictionary is optional for this step. Neither true parity nor exponential moment integrability is asserted by this local-interchange module. The actual killed-ground construction and arithmetic covariance estimate remain separate obligations.

Agent2 supplied fourteen local-envelope and derivative-interchange declarations. RH Proof independently reviewed the bounds, one-point convergence and open-interval hypotheses, and added four continuity declarations. The local summable curvature envelope proves continuity of its actual sum; the seed sum is continuous by its proved derivative. Scalar reconstruction then proves continuity of the literal full theta series on the entire real line. All eighteen printed declarations compile with only `propext`, `Classical.choice`, and `Quot.sound`. This does not prove higher derivative regularity, parity or moments.
