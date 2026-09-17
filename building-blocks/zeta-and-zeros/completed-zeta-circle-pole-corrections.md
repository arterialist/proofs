# Actual completed-zeta circle pole corrections

RH Agent3 supplied this proof and Lean formalization. RH Proof independently reviewed the neighborhood factorization, nonvanishing hypotheses, continuity and integral splitting, and compiled the central module against the pinned Lean 4.24.0/mathlib workspace. These are classical logarithmic-derivative and Cauchy identities applied to the actual completed zeta and physical test functions.

[CompletedZetaPoleCorrections.lean](../../formalization/BuildingBlocks/CompletedZetaPoleCorrections.lean) proves nine theorems. For s distinct from 0 and 1, and with actual xi(s) nonzero, it proves

\[
\frac{\Lambda'(s)}{\Lambda(s)}=
\frac{\xi'(s)}{\xi(s)}-\frac1s-\frac1{s-1},
\]

where Lambda denotes mathlib's actual completedRiemannZeta. The proof promotes the exact xi factorization to a neighborhood identity before differentiating. It derives completed-zeta nonvanishing from the actual xi value. No right-half-plane restriction is needed.

The module proves continuity of both logarithmic derivatives on sets with the required nonvanishing and pole exclusions. A continuous weight F therefore has an integrable completed-zeta circle row when the circle avoids both poles and actual xi zeros. It establishes integrability of the xi row and both rational rows before splitting the integral.

For an entire F and a circle with 0 and 1 strictly inside, and actual xi nonzero on its boundary, the exact identity is

\[
\oint F(w)\frac{\Lambda'(w)}{\Lambda(w)}\,dw=
\oint F(w)\frac{\xi'(w)}{\xi(w)}\,dw
-2\pi i\,[F(0)+F(1)].
\]

Zeros inside the circle are unrestricted. The theorem does not assume their real parts or evaluate the xi integral as an infinite zero sum.

For the actual centered compact physical Mellin weight, the two literal moments of the first test at -1/2 and +1/2 make F(0)=F(1)=0. Both circle corrections then vanish. The same conclusion holds after every finite complete history block, with all generators at least 2 and every history depth. This uses the published actual moment-preservation and entire-weight proofs.

All nine theorem assumption checks report only propext, Classical.choice and Quot.sound. There are no added mathematical axioms or unfinished proofs. General contour limits, global residue sums, the complete explicit formula and its arithmetic sign estimate remain unfinished. This batch does not prove RH.
