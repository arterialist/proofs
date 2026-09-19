# Unique Contribution 184: Exact Finite-Prime Memory L2 Regularity and Successor Commutator Integral Representation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSeedMemory.lean`](../../formalization/BuildingBlocks/PrimeSeedMemory.lean), [`building-blocks/primes/prime-seed-memory.md`](../../building-blocks/primes/prime-seed-memory.md)  
**Classification:** Operator Theory / Lie-Volterra Commutators / Semigroup Perturbation / Prime Successor Seeds / $L^2$ Hilbert Spaces

---

## 1. Executive Summary and Mathematical Statement

In the algebraic analysis of discrete-to-continuous renewal operators, the shift or successor operator $\mathcal{S}$ and the causal memory convolution operator $\mathcal{K}_K f(v) = \int_0^v K(v - u) f(u) \, du$ do not commute in general. Understanding the exact structure of their commutator $[\mathcal{S}, \mathcal{K}_K] = \mathcal{S} \mathcal{K}_K - \mathcal{K}_K \mathcal{S}$ is essential for analyzing the spectrum of prime generation semigroups.

This contribution proves:

1. **Individual Prime Seed $L^2(\mathbb{R})$ Membership:**  
   For any clock $L > 0$, the causal prime successor seed $\text{seed}_L(v)$ belongs to $L^2(\mathbb{R}, \text{volume})$:
   \[
   \text{seed}_L \in L^2(\mathbb{R}).
   \]
2. **Finite Prime Family $L^2(\mathbb{R})$ Stability:**  
   For any finite subset of primes $S \subset \mathcal{P}$, the aggregated multi-prime seed:
   \[
   \text{finitePrimeSeed}_S(v) = \sum_{p \in S} \text{seed}_{\log p}(v)
   \]
   is Borel measurable and belongs to $L^2(\mathbb{R})$.
   Crucially, this retains every prime power $p^m$ for each admitted prime $p \in S$ without any power cutoff.
3. **Exact Commutator Integral Operator Representation:**  
   For any state trajectory $f \in L^2((0, \infty))$ and every evaluation time $v \in \mathbb{R}$, the Lie-Volterra commutator of the successor operator $\mathcal{S}$ with the finite-prime causal memory operator $\mathcal{K}_S$ is an exact integral operator:
   \[
   \left( \mathcal{S}(\mathcal{K}_S f) - \mathcal{K}_S(\mathcal{S} f) \right)(v) = \int_0^\infty M_S(v, u) f(u) \, du,
   \]
   where $M_S(v, u) = \text{memoryKernel}(\text{finitePrimeSeed}_S, v, u)$ is the explicit kernel induced by the finite prime seed.

---

## 2. Mathematical Proof

### 2.1. $L^2$ Regularity of the Prime Seed
By `integrable_seed_square_and_integral`, $\int_{\mathbb{R}} (\text{seed}_L(v))^2 \, dv = e^{-2L} < \infty$.
Since $\text{seed}_L$ is measurable, $\|\text{seed}_L\|_{L^2}^2 < \infty$, which by standard characterization implies `MemLp (seed L) 2 volume`.
For any finite set $S \subset \mathcal{P}$, since finite sums of $L^2$ functions are $L^2$:
\[
\text{finitePrimeSeed}_S = \sum_{p \in S} \text{seed}_{\log p} \in L^2(\mathbb{R}).
\]

### 2.2. Commutator Derivation
Let $\mathcal{K}_K f(v) = \int_0^\infty K(v - u) f(u) \, du$ (with $K(w) = 0$ for $w < 0$).
Let $\mathcal{S}$ denote the generator/successor action.
By the fundamental theorem of calculus and Leibniz rule for parameter integrals, the commutator acting on $f \in L^2((0, \infty))$ satisfies:
\[
[\mathcal{S}, \mathcal{K}_K] f (v) = \int_0^\infty M_K(v, u) f(u) \, du,
\]
where $M_K(v, u)$ accounts for the boundary evaluations at $u=0$ and the cross-derivatives of the kernel.
Since $\text{finitePrimeSeed}_S \in L^2(\mathbb{R})$ and $f \in L^2((0, \infty))$, the general kernel commutator theorem applies unconditionally.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSeedMass` in `formalization/BuildingBlocks/PrimeSeedMemory.lean`):
```lean
theorem seed_memLp_two {L : ℝ} (hL : 0 < L) : MemLp (seed L) 2 volume

theorem measurable_finitePrimeSeed (S : Finset Nat.Primes) :
    Measurable (finitePrimeSeed S)

theorem finitePrimeSeed_memLp_two (S : Finset Nat.Primes) :
    MemLp (finitePrimeSeed S) 2 volume

theorem finitePrimeSeed_memory_commutator (S : Finset Nat.Primes) {f : ℝ → ℝ}
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    SuccessorCharge.successor (SuccessorCharge.causalMemory (finitePrimeSeed S) f) v -
      SuccessorCharge.causalMemory (finitePrimeSeed S) (SuccessorCharge.successor f) v =
    ∫ u in Ioi (0 : ℝ), SuccessorCharge.memoryKernel (finitePrimeSeed S) v u * f u
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Volterra operator commutators and Lie brackets in semigroups (Gohberg-Krein 1970, Pazy 1983). Explicit operator-theoretic commutator representations for full infinite prime-power causal convolution kernels in Lean 4 are new.
- **Advancement:** Establishes the exact integral operator identity $[\mathcal{S}, \mathcal{K}_S] f(v) = \int_0^\infty M_S(v, u) f(u) du$ for multi-prime seeds in Lean 4.
- **Target Venues:** *Journal of Operator Theory* or *Integral Equations and Operator Theory*.
