# Growing-prime scattering defect factorization: Lean 4 formalization

**Status:** machine-checked in Lean 4.24.0.
Lean module:
- [formalization/BuildingBlocks/GrowingPrimeScatteringBounds.lean](../../formalization/BuildingBlocks/GrowingPrimeScatteringBounds.lean)
Companion notes:
- [building-blocks/weil-and-spectral/growing-prime-scattering-lean-bounds.md](../../building-blocks/weil-and-spectral/growing-prime-scattering-lean-bounds.md)
- [building-blocks/weil-and-spectral/paired-scattering-finite-formalization.md](../../building-blocks/weil-and-spectral/paired-scattering-finite-formalization.md)

Attribution: Arterialist RH research team, September 2026.
Foundational axioms: standard Lean 4 foundations only (`[propext, Classical.choice, Quot.sound]`), zero custom axioms.

## Statement

Let $p \ge 2$ be a prime, $z \in \mathbb{C}$, and $M \ge 1$ a finite history depth.
Define the discrete finite-history scattering multiplier:
\[
 v(p, z, M) := -p^{z - 1/2} + (1 - p^{-1}) \sum_{j=0}^{M-1} p^{-j(z + 1/2)},
\]
the paired multiplier $a_p(z) := v(p, z, M) v(p, -z, M)$, and the rational defect:
\[
 d(p, z, M) := \frac{(1 - p^{-1}) p^{-M(z + 1/2)}}{1 - p^{z - 1/2}}.
\]

**Theorem (Scattering Defect Factorization and Block Comparison).**
1. **Paired Multiplier Bound:**
   For all $p \ge 2$ and $|\Re z| \le 1/2$:
   \[
    |a_p(z)| \le 3, \qquad |A_s(z)| \le 3^{|s|},
   \]
   where $A_s(z) = \prod_{p \in s} a_p(z)$ for any finite block of primes $s$.
2. **Defect Factorization:**
   For any interior gap $\delta > 0$ with $|\Re z| \le 1/2 - \delta$:
   \[
    a_p(z) = (1 - d(p, z, M))(1 - d(p, -z, M)).
   \]
3. **Exponential Product Bound:**
   \[
    |A_s(z) - 1| \le \exp\left(\sum_{p \in s} (2 B_p + B_p^2)\right) - 1,
   \]
   where $B_p = \frac{\exp(-M\delta\log p)}{1 - \exp(-\delta\log p)}$.
4. **Weighted Sequence Splitting:**
   For any absolutely summable sequence of complex weights $(w_i)_{i \in I}$ and any subset $L \subseteq I$:
   \[
    \left|\sum_{i \in I} A_s(z_i) w_i - \sum_{i \in I} w_i\right| \le E \sum_{i \in L} |w_i| + (3^{|s|} + 1) \sum_{i \notin L} |w_i|,
   \]
   where $E$ bounds the low-subset defect $|A_s(z_i) - 1|$.

## Formalization notes

- Module: `BuildingBlocks.GrowingPrimeScatteringBounds` (31 printed declarations).
- Formally audited: compiles cleanly with zero `sorry` placeholders and standard foundational axioms `[propext, Classical.choice, Quot.sound]`.
