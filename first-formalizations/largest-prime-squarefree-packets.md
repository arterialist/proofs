# Largest-prime squarefree packet decomposition: Lean 4 formalization

**Status:** machine-checked in Lean 4.24.0.
Lean modules:
- [formalization/BuildingBlocks/LargestPrimeSquarefreePackets.lean](../building-blocks/BuildingBlocks/LargestPrimeSquarefreePackets.lean)
- [formalization/BuildingBlocks/PrimeAdmissionEnergyFlux.lean](../building-blocks/BuildingBlocks/PrimeAdmissionEnergyFlux.lean)
- [formalization/BuildingBlocks/PrimeAdmissionX4Obstruction.lean](../building-blocks/BuildingBlocks/PrimeAdmissionX4Obstruction.lean)
- [formalization/BuildingBlocks/KappaCoefficientPositivity.lean](../building-blocks/BuildingBlocks/KappaCoefficientPositivity.lean)
Companion note:
- [building-blocks/prime-history/prime-admission-x4-obstruction-formalization.md](../building-blocks/prime-history/prime-admission-x4-obstruction-formalization.md)

Attribution: Arterialist RH research team, September 2026.
Foundational axioms: standard Lean 4 foundations only (`[propext, Classical.choice, Quot.sound]`), zero custom axioms.

## Statement

Let $(D, T]$ be an arithmetic window and let $\operatorname{SqFree}(D, T) = \{n \in (D, T] : \mu^2(n) = 1\}$.
For each prime $p$, define the quotient fiber packet:
\[
 Q_p(D, T) = \{q \in \mathbb{N} : p \cdot q \in (D, T], \mu^2(p q) = 1, \text{ and } p = \operatorname{maxPrime}(p q)\}.
\]

**Theorem (Largest-Prime Squarefree Partition and Flux Reconstruction).**
1. **Möbius Parity Flip:**
   For any prime $p$ and $q$ coprime to $p$:
   \[
    \mu(p q) = -\mu(q).
   \]
2. **Disjoint Fiber Partition:**
   The squarefree integers on $(D, T]$ partition into disjoint fibers indexed by their largest prime factor:
   \[
    \operatorname{SqFree}(D, T) = \bigsqcup_{p \le T} p \cdot Q_p(D, T).
   \]
3. **Möbius Packet Reconstruction:**
   For any family of vectors $(v_d)$ in an inner product space:
   \[
    \sum_{d \in \operatorname{SqFree}(D, T)} \mu(d) v_d = - \sum_p \sum_{q \in Q_p(D, T)} \mu(q) v_{p q}.
   \]
4. **Finite Admission Flux Positivity ($X=4$ Obstruction):**
   In the minimal post-branch bulk $\{3, 4, 5\}$ with $D=2, T=6$, the packets are $Q_3=\{1\}, Q_5=\{1\}$.
   Under any symmetric positive-affine Gram operator $G$, the successive admission fluxes satisfy:
   \[
    \Delta E_1 = G(3, 3) > 0, \qquad \Delta E_2 = G(5, 5) + 2 G(3, 5) > 0, \qquad 2 G(3, 5) > 0.
   \]

## Formalization notes

- Modules: `BuildingBlocks.LargestPrimeSquarefreePackets`, `BuildingBlocks.PrimeAdmissionEnergyFlux`, `BuildingBlocks.PrimeAdmissionX4Obstruction`, `BuildingBlocks.KappaCoefficientPositivity`.
- Formally audited: all 4 modules compile cleanly with zero `sorry` placeholders and standard foundational axioms `[propext, Classical.choice, Quot.sound]`.
