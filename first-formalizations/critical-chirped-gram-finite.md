# Critical chirped Gram matrix finite algebra in Lean 4

**Status:** complete Lean 4 formalization, September 2026.
Compiled in:
- [CriticalChirpedGramFinite.lean](../formalization/BuildingBlocks/CriticalChirpedGramFinite.lean)
- [CriticalChirpedEndpointFinite.lean](../formalization/BuildingBlocks/CriticalChirpedEndpointFinite.lean)
- [CriticalChirpedLaplaceFinite.lean](../formalization/BuildingBlocks/CriticalChirpedLaplaceFinite.lean)

Attribution: Arterialist RH research team, September 2026.
To the best of our knowledge, this is the first formalization in any proof assistant
of the finite Hermitian row-bound and diagonal dominance algebra for chirped Weil packets.

## Mathematical content

Formalizes the finite matrix algebra required to deduce strict coercivity for
the chirped Brun–Titchmarsh constellation:
\[
 Q\left( \sum_{j=1}^M c_j \tau_{x_j} q_T \right) \ge (1 - \epsilon) \log T \sum_{j=1}^M |c_j|^2.
\]

### Formalized theorems
1. **Row bound implication (`gramLower_ge_margin`):**
   Proves that for any complex matrix $G \in M_M(\mathbb{C})$, if each diagonal entry
   $\operatorname{Re} G_{jj} \ge \mu$ and the off-diagonal absolute row sums satisfy
   $\sum_{k \ne j} |G_{jk}| \le r$, then the quadratic form obeys:
   \[
    \operatorname{Re} \langle c, G c \rangle \ge (\mu - r) \|c\|_2^2.
   \]
2. **Hermitian version (`gramLower_ge_margin_of_hermitian`):**
   Specializes the result to exact Hermitian forms where $G = G^*$.
3. **Endpoint and Laplace finite bounds:**
   Proves the discrete algebra for the boundary-mode contributions and the truncated
   Laplace integral estimates.

### Verification and dependencies
- Lean version: 4.24.0.
- Axiom dependencies: standard Mathlib foundations only (`propext`, `Classical.choice`, `Quot.sound`).
- Zero custom axioms, zero `sorry`.
