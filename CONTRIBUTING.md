# Adding work

Put each research note in the closest [subject folder](building-blocks/). Add its title to that folder's `index.md` and link any Lean file or certificate that supports it. Keep the claim, assumptions, and proof status near the start of the note. Say explicitly when an RH implication depends on an unproved estimate.

Lean modules belong in [formalization/BuildingBlocks](formalization/BuildingBlocks/). Add a new import to [BuildingBlocks.lean](formalization/BuildingBlocks.lean) and run `lake build`. Scripts for finite checks belong in [certificates](certificates/); paper audits belong in [reviews/papers](reviews/papers/).

Use [unique contributions](unique-contributions/) or [first formalizations](first-formalizations/) only when the entry gives a specific comparison with earlier work. A bounded search supports a provisional priority judgment, not certainty that no earlier version exists.
