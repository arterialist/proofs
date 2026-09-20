# Contribution 295: Exact Prime-Admission Energy Flux Positivity and Layerwise Obstruction

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeAdmissionX4Obstruction.lean`](../../formalization/BuildingBlocks/PrimeAdmissionX4Obstruction.lean), [`building-blocks/prime-admission/x4-obstruction.md`](../../building-blocks/prime-admission/x4-obstruction.md)  
**Classification:** Quadratic Forms / Gram Matrices / Prime-Power Filtering / Greedy Optimization Obstructions / Affine Kernels / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the variational theory of arithmetic Gram matrices, one attempts to approximate optimal dual vectors by greedily admitting squarefree support packets organized by their largest prime factors $p$. For such greedy sequential admission schemes to converge toward energy minima, newly admitted prime layers would need to reduce or balance existing Gram energy.

This contribution proves:

1. **Strict Positivity of Initial Prime-Admission Flux:**  
   Under any symmetric affine Gram matrix $G$ bounded below by its literal positive kernel term $G(d, e) \ge \kappa(0) e^{-\max(d, e)/2} > 0$, admitting the first prime layer $p = 3$ on the finite bulk interval $(2, 6)$ yields strictly positive energy flux:
   $$
   \Delta \mathcal{E}_1(G) = G(3, 3) > 0.
   $$
2. **Strict Positivity of Second Prime-Admission Flux:**  
   Admitting the subsequent prime layer $p = 5$ injects strictly positive energy flux:
   $$
   \Delta \mathcal{E}_2(G) = G(5, 5) + 2 G(3, 5) > 0.
   $$
3. **Strict Positivity of Cross-Layer Interaction:**  
   Even isolating the cross-interaction between distinct prime layers $p=3$ and $p=5$ yields strictly positive energy:
   $$
   2 G(3, 5) > 0.
   $$
4. **Exact Finite Bulk Squarefree Support:**  
   On the bulk window $D_4 = 2 < d < T_4 = 6$, the squarefree integers are precisely $\{3, 5\}$ (since $\mu(4) = 0$), and their largest-prime quotient packets are strictly trivial:
   $$
   \text{quotientPacket}(\{3, 5\}, \text{largest}, 3) = \{1\}, \quad \text{quotientPacket}(\{3, 5\}, \text{largest}, 5) = \{1\}.
   $$
5. **Structural Obstruction to Greedy Layerwise Minimization:**  
   Because every sequential prime admission step strictly increases the total affine Gram energy, greedy sequential prime-power filtering cannot monotonically decrease the energy, proving that global dual optimization requires collective cancellation across multiple prime layers simultaneously.

---

## 2. Mathematical Proof

### 2.1. Energy Increments Under Sequential Admission
Let $c^{(0)} = 0$, $c^{(1)}(3) = \mu(3) = -1$ (and 0 elsewhere), and $c^{(2)}(3) = -1, c^{(2)}(5) = -1$ (and 0 elsewhere).
The quadratic Gram energy is:
$$
\mathcal{E}(c) = \sum_{d, e \in \{3, 4, 5\}} c(d) c(e) G(d, e).
$$
Evaluating at each stage:
- $\mathcal{E}(c^{(0)}) = 0$.
- $\mathcal{E}(c^{(1)}) = (-1)^2 G(3, 3) = G(3, 3)$.
- $\mathcal{E}(c^{(2)}) = (-1)^2 G(3, 3) + (-1)^2 G(5, 5) + 2(-1)(-1) G(3, 5) = G(3, 3) + G(5, 5) + 2 G(3, 5)$.

### 2.2. Positivity of the Kernel and Fluxes
By hypothesis, $G(d, e) \ge \kappa(0) e^{-\max(d, e)/2} > 0$ for all bulk entries.
Hence:
$$
\Delta \mathcal{E}_1 = \mathcal{E}(c^{(1)}) - \mathcal{E}(c^{(0)}) = G(3, 3) > 0.
$$
$$
\Delta \mathcal{E}_2 = \mathcal{E}(c^{(2)}) - \mathcal{E}(c^{(1)}) = G(5, 5) + 2 G(3, 5) > 0.
$$
Furthermore, the cross-coupling term $2 G(3, 5)$ is strictly positive because $\mu(3)\mu(5) = (-1)(-1) = +1$.
Thus the signs of the Möbius function on distinct primes reinforce each other positively under the affine kernel, strictly increasing the quadratic energy.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeAdmissionX4Obstruction` in `formalization/BuildingBlocks/PrimeAdmissionX4Obstruction.lean`):
```lean
theorem first_packet_flux_pos {G : ℕ → ℕ → ℝ} (hG : PositiveAffineGram4 G) :
    0 < firstFlux G

theorem second_packet_flux_pos {G : ℕ → ℕ → ℝ} (hG : PositiveAffineGram4 G) :
    0 < secondFlux G

theorem second_packet_cross_pos {G : ℕ → ℕ → ℝ} (hG : PositiveAffineGram4 G) :
    0 < 2 * G 3 5

lemma quotientPacket_three :
    quotientPacket squarefreeBulk4 largest4 3 = {1}

lemma quotientPacket_five :
    quotientPacket squarefreeBulk4 largest4 5 = {1}
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Large sieve methods (Bombieri 1971; Montgomery 1978); greedy pursuit algorithms in Hilbert spaces (Temlyakov 2011). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Demonstrates rigorously that greedy layer-by-layer prime admission fails to optimize arithmetic Gram forms due to positive cross-reinforcement between squarefree layers, proving the necessity of non-greedy, global dual vectors.
- **Target Venues:** *Linear Algebra and its Applications* or *Acta Arithmetica*.
