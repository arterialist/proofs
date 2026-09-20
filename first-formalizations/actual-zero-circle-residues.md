# Actual local zero-circle residues and compact Mellin analyticity: Lean 4 formalization

**Status:** machine-checked in Lean 4.24.0. This is a provisional first-Lean record for the combined xi/zeta, compact-Mellin, and finite-history package. It is not the first formalization of the weighted argument principle.
Lean modules:
- [formalization/BuildingBlocks/ActualZeroCircleResidues.lean](../formalization/BuildingBlocks/ActualZeroCircleResidues.lean)
- [formalization/BuildingBlocks/CompactPhysicalMellinAnalytic.lean](../formalization/BuildingBlocks/CompactPhysicalMellinAnalytic.lean)
- [formalization/BuildingBlocks/ActualPhysicalResidues.lean](../formalization/BuildingBlocks/ActualPhysicalResidues.lean)
- [formalization/BuildingBlocks/FullComplexHistoryMellin.lean](../formalization/BuildingBlocks/FullComplexHistoryMellin.lean)
Companion note:
- [building-blocks/zeta-and-zeros/actual-zero-circle-residues.md](../building-blocks/zeta-and-zeros/actual-zero-circle-residues.md)

Attribution: Arterialist RH research team, September 2026.
Foundational axioms: standard Lean 4 foundations only (`[propext, Classical.choice, Quot.sound]`), zero custom axioms.

Li and Paulson formalized the weighted argument principle in Isabelle in 2016. Their theorem `argument_principle` covers analytic weights, winding numbers, zeros, and poles, and therefore subsumes the general weighted residue mechanism used here. See [Li and Paulson, Section 4, pages 9-13](https://www.cl.cam.ac.uk/~lp15/papers/Formath/Residue-theorem.pdf).

A bounded search found no matching Lean package that combines the actual xi/zeta instantiations, compact physical Mellin weights, and finite prime-history comparison. The provisional claim concerns that Lean API and combination only. It is not a claim of worldwide priority for zero-circle residues or the argument principle.

## Statement

Let $f: \mathbb{C} \to \mathbb{C}$ be an analytic function with a zero of order $m \ge 0$ at $s \in \mathbb{C}$.
Then on a sufficiently small punctured neighborhood:
\[
 \frac{f'(w)}{f(w)} = \frac{m}{w-s} + H(w),
\]
where $H(w)$ is analytic at $s$.

**Theorem (Local Zero-Circle Residues and Scattering History Comparison).**
1. **Analytic Zero Circle Residue:**
   There exists $\varepsilon > 0$ such that for every radius $0 < R < \varepsilon$ and every entire test function $F: \mathbb{C} \to \mathbb{C}$:
   \[
    \boxed{\quad \oint_{|w-s|=R} F(w) \frac{f'(w)}{f(w)} \, dw = 2\pi i \, m \, F(s). \quad}
   \]
2. **Actual Zeta and Xi Circle Coefficients:**
   For the Riemann Xi function $\xi(s)$ at any $s \in \mathbb{C}$, and for $\zeta(s)$ on $\Re s > 0, s \ne 1$, the circle integral evaluates to $2\pi i \, m(s) \, F(s)$, where $m(s)$ is the actual zero multiplicity.
3. **Compact Physical Mellin Analyticity:**
   For any compactly supported continuous physical test functions $f, g$, the centered Mellin weight $F(s) = W(f, g)(s-1/2)$ is entire on $\mathbb{C}$.
4. **Scattering History Comparison:**
   For any finite prime set $P$ and depth $M$, inserting the paired history factors yields:
   \[
    \oint_{|w-s|=R} \prod_{p \in P} V(p, w-1/2, M) V(p, 1/2-w, M) F(w) \frac{\xi'(w)}{\xi(w)} \, dw = 2\pi i \, m(s) \prod_{p \in P} V(p, s-1/2, M) V(p, 1/2-s, M) F(s).
   \]
   The norm of the difference from the bare zero coefficient is bounded on $|\Re(s-1/2)| \le 1/2-\delta$ by:
   \[
    |2\pi i \, m(s)| \, |F(s)| \left( \exp \sum_{p \in P} (2B_p + B_p^2) - 1 \right), \qquad B_p = \frac{p^{-M\delta}}{1 - p^{-\delta}}.
   \]

## Formalization notes

- Modules: `BuildingBlocks.ActualZeroCircleResidues`, `BuildingBlocks.CompactPhysicalMellinAnalytic`, `BuildingBlocks.ActualPhysicalResidues`.
- Formally audited: all 21 declarations compile cleanly with zero `sorry` placeholders and standard foundational axioms `[propext, Classical.choice, Quot.sound]`.
- Establishes Cauchy-Goursat cancellation of the regular part $H(w)$ and exact circle residue extraction without assuming RH or summing over all zeros.
