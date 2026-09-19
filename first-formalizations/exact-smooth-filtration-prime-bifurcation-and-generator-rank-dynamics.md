# First Formalization: Exact Smooth Filtration Prime Bifurcation and Generator Rank Dynamics

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/Model.lean`](../../formalization/BuildingBlocks/Model.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the discrete dynamical filtration model of smooth numbers, prime state transitions, and generator rank evolution in Lean 4:

1. **Filtration Definitions and Elementary Properties:**
   Formal proof of `mem_before_iff`, `before_mono`, `before_one`, `before_mul`, `before_divisor`, and `earlier_available`.
2. **Prime Bifurcation of States:**
   Formal proof of `prime_not_before`, `prime_available_after`, `nonprime_no_change`, `new_generator_iff_prime` ($n \notin \text{before}(n) \leftrightarrow n.\text{Prime}$), and `state_changes_iff_prime` ($\text{before}(n+1) \ne \text{before}(n) \leftrightarrow n.\text{Prime}$).
3. **Information Retention:**
   Formal definition of `retain` and proof of `retain_injective`.
4. **Canonical Monoid Isomorphism:**
   Formal definition of `prime_step_equiv`: $\mathbb{N} \times \text{before}(p) \simeq \text{before}(p+1)$ and evaluation `prime_step_equiv_apply`.
5. **Generator Rank Step Dynamics:**
   Formal definition of `generatorRank` and proof of `generatorRank_succ`:
   $$
   \text{generatorRank}(n+1) = \text{generatorRank}(n) + \text{if } n.\text{Prime} \text{ then } 1 \text{ else } 0.
   $$

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Prime characterization via membership exclusion
theorem new_generator_iff_prime {n : ℕ} (hn : 0 < n) :
    n ∉ before n ↔ n.Prime

-- Exact prime bifurcation of state transitions
theorem state_changes_iff_prime (n : ℕ) :
    before (n + 1) ≠ before n ↔ n.Prime

-- Retention injectivity (no information loss)
theorem retain_injective {n k : ℕ} (h : n ≤ k) :
    Function.Injective (retain h)

-- Canonical prime step equivalence
def prime_step_equiv {p : ℕ} (hp : p.Prime) :
    ℕ × before p ≃ before (p + 1)

-- Exact step equation for generator rank
theorem generatorRank_succ (n : ℕ) :
    generatorRank (n + 1) = generatorRank n + if n.Prime then 1 else 0
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 establishing the discrete dynamical filtration model of smooth numbers, where state bifurcations and generator rank updates occur if and only if the discrete time step encounters a prime number.
