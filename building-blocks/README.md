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
