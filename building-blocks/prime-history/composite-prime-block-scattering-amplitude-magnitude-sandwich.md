# Composite Prime-Block Scattering Amplitude Magnitude Sandwich

**Date:** 19 September 2026
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualPrimeBlockMagnitude.lean`](../../formalization/BuildingBlocks/ActualPrimeBlockMagnitude.lean), [`formalization/BuildingBlocks/ActualScatteringMomentMagnitude.lean`](../../formalization/BuildingBlocks/ActualScatteringMomentMagnitude.lean)
**Classification:** Analytic Number Theory / Operator Theory / Scattering Theory / Exponential Bounds
**Taxonomy:** Building block; theorem content is retained for reuse. No priority claim is made.

---

## 1. Executive Summary and Mathematical Statement

In the spectral analysis of composite prime scattering operators $\mathcal{B}_{ps}$ on test functions, the aggregate scattering amplitude $\mathcal{A}(ps, \text{depth}, h)$ governs the amplification of two-sided Mellin moments at half-integers $h + 1/2$.

This note records:

1. **Two-Sided Geometric Sandwich on Composite Amplitudes:**
   For any finite list of primes $ps = [p_1, \dots, p_k]$, any depth assignment $\text{depth} : \mathbb{N} \to \mathbb{N}$ with $\text{depth}(p) \ge 1$, and any integer $h \ge 1$:
   $$
   \left(\frac{1}{8}\right)^{|ps|} \prod_{p \in ps} p^{h \cdot \text{depth}(p)} \le \mathcal{A}(ps, \text{depth}, h) \le 2^{|ps|} \prod_{p \in ps} p^{h \cdot \text{depth}(p)}.
   $$
2. **Logarithmic Energy Equivalence:**
   Writing the prime power product as an exponential of the weighted logarithmic divisor energy $\mathcal{E}(ps) = \sum_{p \in ps} h \cdot \text{depth}(p) \log p$, the scattering amplitude satisfies:
   $$
   e^{-|ps|\log 8} e^{\mathcal{E}(ps)} \le \mathcal{A}(ps, \text{depth}, h) \le e^{|ps|\log 2} e^{\mathcal{E}(ps)}.
   $$
3. **Exact Asymptotic Stability:**
   The growth of the scattering amplitude is asymptotically governed by the arithmetic exponent $\sum_p h \cdot \text{depth}(p) \log p$, with the geometric prefactors $(1/8)^{|ps|}$ and $2^{|ps|}$ depending only on the prime cardinality $|ps|$ and completely independent of the size of the primes themselves.

---

## 2. Mathematical Proof

### 2.1. Single-Prime Multiplier Magnitude
For an individual prime $p$, the local magnitude $W(p) = -M_+(p) M_-(p)$ satisfies the base inequality:
$$
\frac{1}{8} p^{h \cdot \text{depth}(p)} \le W(p) \le 2 p^{h \cdot \text{depth}(p)}.
$$

### 2.2. Inductive Multiplicativity
By definition, $\mathcal{A}(ps, \text{depth}, h) = \prod_{p \in ps} W(p)$.
Proceeding by list induction:
- For $ps = []$, the empty product is 1, matching $(1/8)^0 \cdot 1 = 1 \le 1 \le 2^0 \cdot 1 = 1$.
- For $p :: qs$, multiplying the base step for $p$ by the inductive hypothesis for $qs$ preserves non-negativity:
  $$
  \frac{1}{8} p^{h \cdot \text{depth}(p)} \cdot \left(\frac{1}{8}\right)^{|qs|} \prod_{q \in qs} q^{h \cdot \text{depth}(q)} \le W(p) \cdot \mathcal{A}(qs) \le 2 p^{h \cdot \text{depth}(p)} \cdot 2^{|qs|} \prod_{q \in qs} q^{h \cdot \text{depth}(q)}.
  $$
  Combining the prefactors $(1/8) \cdot (1/8)^{|qs|} = (1/8)^{|ps|}$ and $2 \cdot 2^{|qs|} = 2^{|ps|}$ completes the induction.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualPrimeBlockMagnitude`):
```lean
theorem actual_block_amplitude_bounds (ps : List ℕ) (depth : ℕ → ℕ)
    {h : ℕ} (hh : 1 ≤ h) (hprime : ∀ p ∈ ps, p.Prime)
    (hdepth : ∀ p ∈ ps, 1 ≤ depth p) :
    (1 / 8 : ℝ) ^ ps.length *
        (ps.map (fun p : ℕ => (p : ℝ) ^ (h * depth p))).prod ≤
      amplitude ps depth h ∧
    amplitude ps depth h ≤
      (2 : ℝ) ^ ps.length *
        (ps.map (fun p : ℕ => (p : ℝ) ^ (h * depth p))).prod
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Scope and status

- **Literature context:** The displayed statements use standard identities or project-specific definitions; no priority claim is made.
