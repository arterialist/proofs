# Evidence-backed first formalizations

This directory retains only formalization records that identify the theorem,
link to the Lean artifact, build without `sorry`, and record a bounded search
of named public libraries or repositories. “First” is always provisional and
means no matching public formalization was found in that stated search scope;
it is not a worldwide priority guarantee. Routine identities, conditional
interfaces, finite arithmetic checks, duplicate records, and entries without
defensible search evidence are preserved as [formalization
records](../formalization/records/) or subject [building blocks](../building-blocks/).

Before the September 2026 cleanup this catalog contained 355 report pages.
It now contains **5 retained records**. The count is generated from the
Markdown files in this directory, excluding this README.

## Retained records

1. [Actual critical sign criterion: Mellin continuation and pole obstruction](actual-critical-sign-criterion.md)
   - Lean formalization of the exact eventual-sign implication to RH. The sign premise remains unproved.
2. [Actual local zero-circle residues and compact Mellin analyticity](actual-zero-circle-residues.md)
   - A specific Lean package for zero-circle residue extraction, compact Mellin analyticity, and finite scattering histories. Li and Paulson formalized the general weighted argument principle in Isabelle in 2016, so this is not a worldwide first for weighted residues.
3. [Literal physical theta kernel: parity, positivity, and moments](literal-physical-theta-kernel.md)
   - Lean formalization of the literal differentiated theta-kernel package. Classical theta and zeta formalizations already exist.
4. [Prime-seed compound Poisson semigroup and uniform Bernstein exponent](prime-seed-compound-poisson-semigroup-and-bernstein-exponent.md)
   - Lean formalization of the specialized all-prime jump profile. The abstract compound-Poisson theory is classical.
5. [Explicit zeta zero-free region through height 7.465](explicit-zeta-zero-free-region-to-7-465.md)
   - An unconditional Lean theorem for $\operatorname{Re}(s)>1/2$ and $0<\operatorname{Im}(s)\le 7.465$. The mathematical zero-free range is classical and vastly weaker than published computations; the provisional claim concerns this exact Lean theorem only.
