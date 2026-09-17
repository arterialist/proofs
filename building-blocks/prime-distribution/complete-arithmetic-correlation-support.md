# Complete arithmetic correlation from literal compact support

The module [CompleteArithmeticCorrelation.lean](../../formalization/BuildingBlocks/CompleteArithmeticCorrelation.lean) extends the actual correlation and finite arithmetic cutoff already formalized in `PhysicalScatteringCorrelation`. Define the complete row by
\[
A(f,g)=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 \left[R(f,g)(\log n)+\overline{R(g,f)(\log n)}\right].
\]
In Lean the sum is a genuine natural-index tsum, with the n below 2 terms explicitly zero. Every prime power and both observing orientations remain.

If both functions' nonzero values occur inside the same open interval (a,b), then R(f,g)(x)=0 whenever x is at least b-a. The proof is pointwise: a nonzero f(v) forces a<v<b, while a nonzero g(v+x) would force v+x<b, contradicting x at least b-a. Equality at the width endpoint is included. Compactness supplies a shared strict interval by bounding the union of the two supports and extending each bound by 1.

Consequently, if exp(b-a) is at most N+1, every arithmetic term outside Icc 2 N vanishes. The complete row equals the literal cutoff A_N. For compactly supported f and g the module derives a natural N0 for which this equality holds for every N at least N0, and proves absolute summability of the full row. These support and summability statements do not assume continuity or a supplied convergence premise. Their correlation integrals retain Lean's total integral convention. The finite joint-history expansion additionally requires the previously stated continuity hypotheses to justify splitting integrals.

The module then derives the full joint finite-translate arithmetic row, using an automatically obtained cutoff. A common cutoff is also obtained for any two compact source pairs. Two root consumers apply these conclusions to the literal `blockPhysical` history compositions: the transformed complete row is absolutely summable, and one cutoff simultaneously represents the original and transformed rows. Continuity and compact support are proved for these histories by `FullComplexHistoryMellin`; no operator-to-weight correspondence is assumed here.

The weighted prime-power reindexing theorem also proves, for arbitrary complex weights w, that the finite von Mangoldt sum equals the sum over primes p and positive exponents j with p^j at most N, weighted by log p. The proof uses the unique prime-power representation and retains every exponent; terms outside prime powers vanish by the actual von Mangoldt theorem.

This closes the compact-support arithmetic convergence and common-cutoff prerequisites. It does not bound the signed row, prove an all-scale arithmetic estimate, or establish the complete explicit formula with actual zero multiplicities, gamma and pole terms. The required cutoff depends on the actual support width and may grow very rapidly with history depth. Compactly supported source results do not directly apply to the unchanged exponential-tail coherent-core family. Its analytic limits and arrival consumers must still be proved separately. No RH conclusion follows.

The signed scattering research branch supplied nine declarations for support, convergence and the complete finite-translate row. Root independently reviewed the strict support bounds, width endpoint, logarithmic observing cutoff and absence of a supplied convergence assumption. Root supplied the two literal physical-history consumers. The methods are classical compact-support and finite-sum arguments; no novelty claim is made.

All eleven printed declarations compile with only `propext`, `Classical.choice` and `Quot.sound`, with no warnings in this module.
The combined `BuildingBlocks` library also builds successfully.

## Complete prime-power row export

The finite row now has an explicit prime-power export
\[
A_N(f,g)=\sum_{\substack{2\le p\le N\\p\ \mathrm{prime}}}
 \sum_{\substack{1\le j\le N\\p^j\le N}}
 \frac{\log p}{\sqrt{p^j}}
 \left[R(f,g)(\log(p^j))+\overline{R(g,f)(\log(p^j))}\right].
\]
The equality is proved for every natural N and arbitrary functions f,g using the weighted reindexing theorem. The n=1 term is zero because Lambda(1)=0, not because a source or boundary term was discarded. For compact sources, the complete row equals this prime-power cutoff for every N above the derived support cutoff. A further root consumer proves that one common cutoff works simultaneously for the original source pair and its literal complete physical history composition. No convergence or cutoff premise is supplied by the caller.

The signed scattering branch supplied the two export identities. Root independently reviewed the n=1 correction, real-to-complex weight conversion and all exponent filters, and supplied the common physical-history consumer. These three new declarations compile with only `propext`, `Classical.choice` and `Quot.sound`. They identify the arithmetic indexing and do not establish the full zero/Gamma/pole explicit formula or a signed estimate.

The updated module and combined `BuildingBlocks` library build successfully, with no warnings in the updated module.
