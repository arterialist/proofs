# Simultaneous-admission endpoint geometric identity: Lean 4 formalization

**Status:** machine-checked in Lean 4.24.0.
Lean module:
- [formalization/BuildingBlocks/SimultaneousAdmissionEndpointFinite.lean](../../building-blocks/BuildingBlocks/SimultaneousAdmissionEndpointFinite.lean)
Companion notes:
- [building-blocks/prime-history/simultaneous-admission-endpoint-finite-formalization.md](../../building-blocks/prime-history/simultaneous-admission-endpoint-finite-formalization.md)
- [building-blocks/prime-history/simultaneous-admission-discrepancy-audit.md](../../building-blocks/prime-history/simultaneous-admission-discrepancy-audit.md)

Attribution: Arterialist RH research team, September 2026.
Foundational axioms: standard Lean 4 foundations only (`[propext, Classical.choice, Quot.sound]`), zero custom axioms.

## Statement

Let $q \in [0, 1]$ and $d \in \mathbb{N}$. Define the one-divisor future endpoint energy:
\[
 E_d(q) := (1-q)\sum_{j=1}^d q^{2d-j}.
\]

**Theorem (Simultaneous-Admission Endpoint Geometric Bound).**
1. **Exact Geometric Polynomial Identity:**
   \[
    E_d(q) = q^d - q^{2d}.
   \]
2. **Quarter-Norm Bound:**
   \[
    \|v_d\|^2 = E_d(q) = q^d - q^{2d} \le \frac{1}{4} \qquad (\forall q \in [0, 1], d \ge 0).
   \]
3. **Signed and Möbius Finite Packet Bounds:**
   For any finite set $S$ and vectors with $\|v_i\|^2 \le 1/4$:
   \[
    \left\|\sum_{i \in S} \sigma_i v_i\right\|^2 \le \frac{|S|^2}{4} \qquad (|\sigma_i| \le 1),
   \]
   and in particular for Mathlib's literal `ArithmeticFunction.moebius`:
   \[
    \left\|\sum_{i \in S} \mu(i) v_i\right\|^2 \le \frac{|S|^2}{4}.
   \]
4. **Squarefree Prime Product Packet:**
   For any finite set of primes $Q$, the divisor count of $P = \prod_{p \in Q} p$ is exactly $2^{|Q|}$, and:
   \[
    \boxed{\quad \left\|\sum_{d \mid \prod Q} \mu(d) v_d\right\|^2 \le 4^{|Q|-1}. \quad}
   \]

## Formalization notes

- Module: `BuildingBlocks.SimultaneousAdmissionEndpointFinite`.
- Formally audited: compiles cleanly with zero `sorry` and standard foundational axioms `[propext, Classical.choice, Quot.sound]`.
- Directly connects divisor combinatorial products in Mathlib to Hilbertian packet norm inequalities.
