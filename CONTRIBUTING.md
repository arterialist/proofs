# Adding work

Put each research note in the closest [subject folder](building-blocks/). Add its title to that folder's `index.md` and link any Lean file or certificate that supports it. Keep the claim, assumptions, and proof status near the start of the note. Say explicitly when an RH implication depends on an unproved estimate.

Lean modules belong in [formalization/BuildingBlocks](formalization/BuildingBlocks/). Add a new import to [BuildingBlocks.lean](formalization/BuildingBlocks.lean) and run `lake build`. Scripts for finite checks belong in [certificates](certificates/); paper audits belong in [reviews/papers](reviews/papers/).

Use [unique contributions](unique-contributions/) or [first formalizations](first-formalizations/) only when the entry gives a specific comparison with earlier work. A bounded search supports a provisional priority judgment, not certainty that no earlier version exists.

Use descriptive names such as "conditional RH implication", "zero-free criterion equivalences", or "scalar trace comparison". Names must distinguish a constructed mathematical object from an interface that assumes its properties. A real function named `log_det` is not an operator determinant without a proved identification.

State every parameter range and quantifier. A property at a hypothetical zero, a property eventually true for each fixed parameter, and a uniform statement for all parameters are different results. Numerical samples and an asymptotic leading term do not prove a uniform sign or a specific threshold without remainder estimates.

Link claims of Lean verification to declarations whose statements include the claimed objects and bounds. Separate an algebraic lemma from the analytic estimate it could support. When simplifying a proof, preserve its statement and check affected consumers. Record a stronger theorem as a separate mathematical change, not as housekeeping.

Priority comparisons must identify the original mathematics, the formal libraries and publications searched, the search date, and the exact new contribution if one is claimed. Avoid unsupported completion percentages, worldwide novelty guarantees, publication recommendations, and module counts presented as research progress.
