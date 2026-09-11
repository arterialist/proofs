# Useful building blocks

Verified mathematics with a specific use in the ongoing proof investigation. This category permits known theorems, existing formalizations and results whose priority remains unresolved, with accurate attribution and a documented reason to retain them.

## Local poles at zeta zeros

[ZetaPole.lean](BuildingBlocks/ZetaPole.lean) proves the following local fact. If `ρ ≠ 0, 1` is a zero of the actual Riemann zeta function, then there are a positive integer `m` and a function `a` analytic at `ρ` such that, on a punctured neighborhood,

\[
-\frac{\zeta'(s)}{s\zeta(s)}-\frac1{s-1}+\frac{2\gamma}{s}
=\frac{-m/\rho}{s-\rho}+a(s).
\]

It also proves that multiplying the left side by `s − ρ` gives a limit of `−m/ρ`, and that this limit is nonzero. Positive multiplicity is obtained from analytic factorization; simplicity of zeros is not assumed. A general analytic logarithmic-derivative lemma and two zeta helpers supply the proof.

**Research use.** The arithmetic investigation produced two expressions with a common reciprocal-zeta term. Cancelling that common term leaves the expression above. This block verifies that the remaining singularity persists at a zero, including a multiple zero. It rules out treating cancellation of the shared term as sufficient to remove the singularity. A bound or other argument controlling the remaining arithmetic error is still needed.

**Scope.** These are local complex-analytic statements about the displayed expression. This package does not prove its identification with a convergent Mellin integral near a zero, exclude off-line zeros, improve a prime-error bound, or prove RH. It does not contain the preceding arithmetic derivation.

**Attribution.** The mathematics is classical: analytic zero factorization gives the logarithmic-derivative pole. Its relevance to prime counting is reflected in the zero terms of [the classical explicit formula, DLMF 25.16.2](https://dlmf.nist.gov/25.16.E2), whose reference is T. M. Apostol (2000). No mathematical novelty or first-formalization priority is claimed here.

The Lean proofs were drafted by Codex in the **RH Proof** task, under the repository owner's research direction. The coordinating Codex task extracted the four declarations, replaced project imports with direct mathlib imports, and changed the namespace to `BuildingBlocks`. The theorem statements and proof bodies were retained. Original module hashes and the task identifier are recorded in [the provenance and verification record](verification/zeta-pole.json).

The proofs rely on the work of mathlib contributors, particularly [analytic isolated-zero factorization](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/Analytic/IsolatedZeros.lean), [logarithmic derivative rules](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/Calculus/LogDeriv.lean), and the zeta-function library. Those are existing formalized dependencies under mathlib's Apache 2.0 license; they are imported, not relicensed as this repository's work.

Run the commands in the root README to reproduce the build and [axiom audit](verification/Audit.lean). The dated verification record identifies what was checked and which dependency artifacts were reused.

## Explicit floor correction

[FloorCorrection.lean](BuildingBlocks/FloorCorrection.lean) proves, for every real \(x\ge1\),

\[
\left|H(\lfloor x\rfloor)+\Delta(x)
-\left(\tfrac12\log(2\pi)-\gamma\right)
+\left(\{x\}-\tfrac12\right)(\log x+2\gamma)\right|
\le \frac2x.
\]

Here \(D(q)=\sum_{1\le k\le q}\lfloor q/k\rfloor\),
\(H(q)=\log(q!)-D(q)+2\gamma q\), and
\(\Delta(x)=D(\lfloor x\rfloor)-x\log x-(2\gamma-1)x\).
The finite sums and these functions are defined in the module; a supporting lemma identifies the sum of logarithms with \(\log(q!)\).
The fractional part is the ordinary one, so the statement includes integers, where \(\{x\}-1/2=-1/2\).

**Research use.** A coarse absolute bound on this floor correction discarded its oscillation. The theorem separates a constant term from a weighted sawtooth, making finite Fourier approximation and reciprocal-phase estimates applicable to the latter. On an integer divisor block \(D<n\le2D\), with \(2D\le N\), the remaining errors sum absolutely to at most \(4D^2/N\). That block consequence is a written deduction here; the formal theorem is the pointwise bound above. This does not bound the resulting Mertens increment, the signed Voronoï remainder, or the full prime error.

**Attribution and verification.** The mathematics follows from the classical [Stirling expansion and its remainder estimates](https://dlmf.nist.gov/5.11). No mathematical novelty or first-formalization priority is claimed. Codex drafted the proofs in the RH Proof task under the repository owner's research direction. The coordinator retained the five declarations in its floor-correction module, six supporting definitions and one logarithm-of-factorial lemma, replacing project imports and changing the namespace to BuildingBlocks.FloorCorrection.

The imported [mathlib Stirling module](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/SpecialFunctions/Stirling.lean) credits Moritz Firsching, Fabian Kruse and Nikolas Kuhn. The [Euler–Mascheroni module](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/NumberTheory/Harmonic/EulerMascheroni.lean) credits David Loeffler. Those modules and other mathlib contributions remain Apache 2.0 dependencies; they are imported, not copied or relicensed.

The [verification record](verification/floor-correction.json) records the source hashes, exact extracted scope, independent build and complete axiom-dependency checks, including the supporting definitions. Use the root README commands to reproduce the package build and audit. The reciprocal exponential-sum estimates motivating this block are written mathematics in the research task and are not formal theorems in this package.
