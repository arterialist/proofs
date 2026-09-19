# First Formalization: Exact Prime Block Continuous Chebyshev Equivalence and Bilinear Source Representation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeBlockSource.lean`](../../formalization/BuildingBlocks/PrimeBlockSource.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization marks **Milestone 200** of machine-verified Lean 4 formalizations in this repository. It establishes the exact equivalence between continuous prime renewal blocks and the classical Chebyshev function $\psi(\lfloor e^v \rfloor)$, proves the age-floor activation bijection, and expands the bilinear arithmetic source product in Lean 4:

1. **Chebyshev Double Prime-Power Sum:**
   Formal proof that $\psi(N)$ equals the double sum over primes and prime powers (`psi_eq_prime_power_sum`).
2. **Age-Floor Equivalence:**
   Formal proof of the exact criterion $j \log p \le v \iff p^j \le \lfloor e^v \rfloor$ (`birth_activation_iff`).
3. **Continuous Prime Block Representation:**
   Formal representation of $\text{primeBlock}_p(v)$ as an explicit power sum and vanishing above cutoff (`primeBlock_eq_power_sum`, `primeBlock_eq_zero_above_cutoff`).
4. **The Fundamental Bridge Theorem:**
   Formal proof that $\sum_{p \le \lfloor e^v \rfloor} \text{primeBlock}_p(v) = e^{-v/2} \psi(\lfloor e^v \rfloor)$ (`primeBlockSum_eq_psi`).
5. **Centered Bilinear Arithmetic Source:**
   Formal proof that $\text{source}(v) = \text{primeBlockSum}(v) - e^{v/2}$ and bilinear product decomposition (`source_eq_primeBlocks`, `source_product`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Chebyshev prime-power double sum
theorem psi_eq_prime_power_sum (N : ℕ) :
    psi N = ∑ p ∈ Finset.Icc 2 N, if p.Prime then
      ∑ j ∈ Finset.Icc 1 N, if p ^ j ≤ N then Real.log p else 0 else 0

-- Age-floor activation equivalence
theorem birth_activation_iff {p : ℕ} (hp : p.Prime) (j : ℕ) (v : ℝ) :
    (j : ℝ) * Real.log p ≤ v ↔ p ^ j ≤ ⌊Real.exp v⌋₊

-- Single prime block power sum
theorem primeBlock_eq_power_sum {p : ℕ} (hp : p.Prime) (v : ℝ) :
    primeBlock p v = Real.exp (-v / 2) *
      ∑ j ∈ Finset.Icc 1 ⌊Real.exp v⌋₊, if p ^ j ≤ ⌊Real.exp v⌋₊ then Real.log p else 0

-- Primes above cutoff vanish
theorem primeBlock_eq_zero_above_cutoff {p : ℕ} (hp : p.Prime) {v : ℝ}
    (hpN : ⌊Real.exp v⌋₊ < p) : primeBlock p v = 0

-- Fundamental bridge to Chebyshev function
theorem primeBlockSum_eq_psi (v : ℝ) :
    primeBlockSum v = Real.exp (-v / 2) * psi ⌊Real.exp v⌋₊

-- Centered source representation
theorem source_eq_primeBlocks {v : ℝ} (hv : 0 ≤ v) :
    source v = primeBlockSum v - Real.exp (v / 2)

-- Bilinear source product expansion
theorem source_product {u v : ℝ} (hu : 0 ≤ u) (hv : 0 ≤ v) :
    source u * source v = primeBlockSum u * primeBlockSum v -
      primeBlockSum u * Real.exp (v / 2) - Real.exp (u / 2) * primeBlockSum v +
      Real.exp ((u + v) / 2)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified bridge in Lean 4 directly equating continuous renewal prime blocks to the discrete von Mangoldt / Chebyshev arithmetic function without approximation, proving $\text{primeBlockSum}(v) = e^{-v/2}\psi(\lfloor e^v \rfloor)$ and establishing the foundation for continuous prime semigroups.
