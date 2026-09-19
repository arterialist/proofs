# First Formalization: Exact All-Prime Lévy Tail Measure and Explicit Logarithmic Activity Bound

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedActivityTail.lean`](../../formalization/BuildingBlocks/PrimeSeedActivityTail.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact omitted prime tail measure $\nu_{\ge P}$ and derives the explicit logarithmic activity bound $\frac{32}{\log P}$ for all cutoffs $P \ge 8$ in Lean 4:

1. **Reciprocal Square Telescoping:**
   Formal proof of $\sum_{j=0}^\infty (j+K)^{-2} \le (K-1)^{-1}$ (`reciprocal_square_tail_le`).
2. **Dyadic Logarithmic Shell Tail Sum:**
   Formal proof of the dyadic shell tail estimate $\le \frac{8/\log 2}{K-1}$ (`dyadic_prime_activity_tail_le`).
3. **Constructive Fiber Equivalence:**
   Formal construction of the bijection `primeTailEquiv` identifying the dependent sigma type over fibers with primes $p \ge 2^K$.
4. **Prime Activity Tail Bound:**
   Formal proof of $\sum_{p \ge 2^K} \frac{1}{p \log p} \le \frac{8/\log 2}{K-1}$ (`prime_activity_tail_le`).
5. **Exact Prime Tail Lévy Measure:**
   Formal definition of `primeTailLevyMeasure`, proof of `IsFiniteMeasure`, and exact partition of unity $\nu_{< P} + \nu_{\ge P} = \nu_{\mathcal{P}}$ (`allPrimeLevyMeasure_cutoff_split`).
6. **Explicit Logarithmic Tail Bound:**
   Formal proof of $\nu_{\ge P}(\mathbb{R}) \le \frac{32}{\log P}$ for all $P \ge 8$ (`primeTailLevyMeasure_mass_le_log`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Reciprocal square tail bound
theorem reciprocal_square_tail_le (K : ℕ) (hK : 2 ≤ K) :
    (∑' j : ℕ, 1 / ((j : ℝ) + K) ^ 2) ≤ 1 / ((K : ℝ) - 1)

-- Dyadic shell tail bound
theorem dyadic_prime_activity_tail_le (K : ℕ) (hK : 2 ≤ K) :
    (∑' j : ℕ, ∑' p : logFiber (j + K), 1 / ((p.val : ℝ) * log p.val)) ≤
      (8 / log 2) / ((K : ℝ) - 1)

-- Prime activity tail series bound
theorem prime_activity_tail_le (K : ℕ) (hK : 2 ≤ K) :
    (∑' p : {p : Nat.Primes // 2 ^ K ≤ (p : ℕ)},
      1 / ((p.val : ℝ) * log p.val)) ≤ (8 / log 2) / ((K : ℝ) - 1)

-- Omitted prime tail Lévy measure is finite
instance primeTailLevyMeasure_isFiniteMeasure (P : ℕ) :
    IsFiniteMeasure (primeTailLevyMeasure P)

-- Exact measure splitting
theorem allPrimeLevyMeasure_cutoff_split (P : ℕ) :
    (Measure.sum (fun p : {p : Nat.Primes // (p : ℕ) < P} => levyMeasure {p.val})) +
      primeTailLevyMeasure P = allPrimeLevyMeasure

-- Monotonicity of tail mass
theorem primeTailLevyMeasure_mass_antitone {P Q : ℕ} (hPQ : P ≤ Q) :
    primeTailLevyMeasure Q Set.univ ≤ primeTailLevyMeasure P Set.univ

-- Explicit logarithmic tail bound with constant 32
theorem primeTailLevyMeasure_mass_le_log (P : ℕ) (hP : 8 ≤ P) :
    primeTailLevyMeasure P Set.univ ≤ ENNReal.ofReal (32 / log (P : ℝ))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 constructing the exact omitted prime tail measure and proving the universal non-asymptotic logarithmic bound $\frac{32}{\log P}$ unconditionally without PNT or RH.
