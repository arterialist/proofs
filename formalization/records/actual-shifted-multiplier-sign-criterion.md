# Formalization record: an actual shifted-multiplier sign criterion for RH

**Status:** substantive Lean formalization of a conditional RH criterion. The eventual sign premise is unproved, and this page makes no mathematical-priority claim. A targeted search of Mathlib, KeyAIGit's `ecdlp-lean-verification`, the public Li-criterion Lean repository, and the `PrimeNumberTheoremAnd` index found no matching formalization of this exact shifted coefficient chain as of September 2026; that firstness assessment is provisional.

Define the arithmetic coefficient

$$
c(n)=\sum_{ab=n}\Lambda(a)\Lambda(b)
 -\Lambda(n)(\log n-\Lambda(n)),
$$

with every prime power retained. The exact finite-cutoff definitions
of $V(x)$ and $W(x)=\sum_{d\le x}\sqrt d\,V(x/d)$ are in
[the mathematical statement](../../building-blocks/zeta-and-zeros/actual-critical-sign-criterion.md)
and [the Lean source](../../formalization/BuildingBlocks/ActualCriticalMellin.lean).
The completed Lean theorem is

$$
\bigl(\operatorname{Re}W(x)\le0\text{ for all sufficiently large }x\bigr)
\quad\Longrightarrow\quad\mathrm{RH}.
$$

The theorem
`BuildingBlocks.ActualCriticalSignCriterion.RiemannHypothesis_of_eventually_nonpos`
in [ActualCriticalSignCriterion.lean](../../formalization/BuildingBlocks/ActualCriticalSignCriterion.lean)
has that eventual sign as its only premise. The full imported Lean chain
proves the Mellin identity, positive-measure Landau continuation, and
exclusion of an off-line zero of any multiplicity. It compiles under
Lean 4.24.0 with the pinned Mathlib version and only the standard
axioms `propext`, `Classical.choice`, and `Quot.sound`.

The eventual sign itself is **unproved**. This result is a formalized
conditional RH criterion, not a proof of RH. Its distinct construction
is the square-root-multiple $W$ with same-prime subtraction and both
centering terms. The analytic tools, including Landau's positivity
principle, are classical; a general public Lean treatment of the
positive-measure continuation step appears in
[Robin1984's `MGFAnalyticContinuation.lean`](https://github.com/kimihiro64/Robin1984/blob/7fbbe0821e33ddb73f953ee2981dc52813f5568a/Robin1984/Mathlib/Probability/Moments/MGFAnalyticContinuation.lean).
The exact arithmetic bridge remains the scope of this provisional
formalization record. Nearby prior work includes
[Suzuki's weighted von Mangoldt sign criteria](https://arxiv.org/pdf/2411.07436)
and [Alkan's variants of Pólya and Turán criteria](https://doi.org/10.1016/j.jnt.2021.01.004).
A targeted search of Mathlib, GitHub, arXiv, and the related formal
zeta literature on 16 September 2026 found no publication of this
exact shifted-multiplier criterion. That is a best-knowledge comparison,
not a proof of absolute priority.
