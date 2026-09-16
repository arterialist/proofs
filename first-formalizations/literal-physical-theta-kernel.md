# Literal physical theta kernel: parity, positivity, and moments

The classical real Gaussian Poisson identity implies parity and decay
properties of the theta kernel used in Riemann's Fourier representation.
This entry records a Lean formalization of the **literal differential
series**, rather than a new mathematical theorem.

For real $u$, define

$$
A(u)=e^{u/2}\sum_{n\in\mathbb Z}e^{-\pi n^2e^{2u}},
\qquad
\Phi(u)=\sum_{n\ge1}
\bigl(4\pi^2n^4e^{9u/2}-6\pi n^2e^{5u/2}\bigr)
e^{-\pi n^2e^{2u}}.
$$

[PhysicalThetaParity.lean](../building-blocks/BuildingBlocks/PhysicalThetaParity.lean)
proves directly that $A(-u)=A(u)$, that its literal differential
kernel satisfies $\Phi(-u)=\Phi(u)$, and that $\Phi(u)>0$ for every
real $u$. It first proves summability and the needed derivative
identities; it invokes Mathlib's real Gaussian Poisson theorem for the
modular step.

[PhysicalThetaMoments.lean](../building-blocks/BuildingBlocks/PhysicalThetaMoments.lean)
then proves, for every real $\beta$,

$$
\int_{\mathbb R}e^{\beta|u|}\Phi(u)\,du<\infty.
$$

The same module proves integrability after multiplication by an
almost-everywhere bounded function and after restriction to a bounded
exterior-ground factor. These are convergence prerequisites. They do
not identify a killed ground state with $\xi$, establish a
Laguerre–Pólya property, or prove RH.

The original mathematics is Jacobi's theta transformation and its
standard analytic consequences. Mathlib already formalizes the
[real Gaussian Poisson identity](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/SpecialFunctions/Gaussian/PoissonSummation.html),
which this development uses. The formalized zeta and theta literature,
including [Loeffler and Stoll's zeta work](https://afm.episciences.org/15954/pdf),
provides related infrastructure. A targeted search of Mathlib,
GitHub, and that literature on 16 September 2026 found no prior Lean
formalization of this **exact literal-kernel parity, positivity, and
all-exponential-moments package**. This is a bounded first-formalization
claim, not a claim that theta modularity was first formalized here.

Both modules compile with Lean 4.24.0 and the pinned Mathlib version.
Their reported axiom dependencies are the standard `propext`,
`Classical.choice`, and `Quot.sound`; there is no added mathematical
axiom or placeholder proof.
