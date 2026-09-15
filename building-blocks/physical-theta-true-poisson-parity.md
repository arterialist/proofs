# True parity of the literal physical theta kernel

Use the literal \(\Phi\), Gaussian seed \(a_n\), and twice-differentiated natural seed sum \(A_+\) from the preceding actual foundations. Define the full integer Gaussian seed sum
\[
A(u)=\sum_{n\in\mathbb Z}e^{u/2}e^{-\pi n^2e^{2u}},
\qquad \theta(t)=\sum_{n\in\mathbb Z}e^{-\pi t n^2}.
\]
The actual positive and negative natural subsequences are summable by the seed theorem. Integer reindexing therefore gives the exact identities
\[
A(u)=2A_+(u)-e^{u/2}=e^{u/2}\theta(e^{2u}).
\]
The zero integer term is subtracted once in the first formula. It is not dropped from the Gaussian series.

Mathlib's real Gaussian Poisson theorem, `Real.tsum_exp_neg_mul_int_sq`, gives
\[
\theta(e^{2u})=e^{-u}\theta(e^{-2u}).
\]
Its hypothesis is simply \(e^{2u}>0\). Multiplying by \(e^{u/2}\) proves \(A(-u)=A(u)\). The proof uses the actual integer Gaussian coefficients; no complex Jacobi dictionary or absolute-value kernel surrogate is needed.

The natural seed-sum derivative interchanges already proved give
\[
A'(u)=2\sum_{n\ge0}a_n'(u)-e^{u/2}/2,
\]
\[
A''(u)=2\sum_{n\ge0}a_n''(u)-e^{u/2}/4,
\qquad A''(u)-A(u)/4=2\Phi(u).
\]
The zero term is annihilated by the shifted differential expression exactly. The factor two comes from the two nonzero integer orientations.

Differentiate the proved equality \(A(-u)=A(u)\) by the chain rule and derivative uniqueness. It gives \(A'(-u)=-A'(u)\). Differentiate that equality once more to obtain \(A''(-u)=A''(u)\). Applying both parity identities to the shifted differential equation proves the literal kernel's true parity
\[
\boxed{\Phi(-u)=\Phi(u).}
\]
Its previously proved positivity on \(u\ge0\) now gives \(\Phi(u)>0\) for every real \(u\).

[PhysicalThetaParity.lean](BuildingBlocks/PhysicalThetaParity.lean) proves the actual integer/natural dictionary, integer summability, real Poisson modularity, evenness of the full seed sum, its two derivative statements and shifted differential identity, derivative parity, true \(\Phi\) parity and full-line positivity. It imports the unchanged actual series, seed and local-interchange foundations.

This establishes parity and positivity of the literal kernel as analytic formalization. It does not prove its Fourier–xi identity, exponential moment integrability, killed-ground construction or equation, or the arithmetic covariance residual estimate. The Riemann hypothesis remains unproved.

The construction and Lean proof were supplied by the theta covariance research branch and independently reviewed against the literal series and its compiled derivatives. The analytic input is mathlib’s real Gaussian Poisson summation theorem. No novelty claim is made for theta modularity or parity.
