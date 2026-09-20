# Contribution 127: Exact Prime-Block Scattering Mellin Parity and Amplitude Bounds

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualPrimeBlockMellinParity.lean`](../../formalization/BuildingBlocks/ActualPrimeBlockMellinParity.lean), [`formalization/BuildingBlocks/ActualPrimeBlockMagnitude.lean`](../../formalization/BuildingBlocks/ActualPrimeBlockMagnitude.lean), [`building-blocks/scattering/prime-block-mellin-parity.md`](../../building-blocks/scattering/prime-block-mellin-parity.md)  
**Classification:** Operator Scattering / Mellin Transforms / Prime Scattering Operators / Reflection Parity / Geometric Amplitude Bounds

---

## 1. Executive Summary and Mathematical Statement

In the scattering theory of multi-prime history operators, each prime $p$ acts on physical test functions $f \in C_c(\mathbb{R})$ via a dilation and delay unit $U_p = \text{historyPhysical}(1/\sqrt{p}, d(p), \log p)$. For an arbitrary ordered list of primes $ps = [p_1, \dots, p_k]$ with scattering depths $d(p) \ge 1$:
$$
U_{ps} f = U_{p_1} \circ \cdots \circ U_{p_k} f.
$$
This contribution proves:

1. **Regularity and Support Preservation:**  
   For any continuous compactly supported function $f \in C_c(\mathbb{R})$, the composite prime block $U_{ps} f$ is continuous and compactly supported:
   $$
   f \in C_c(\mathbb{R}) \implies U_{ps} f \in C_c(\mathbb{R}).
   $$
2. **Exact Factorization of Multi-Prime Mellin Transforms:**  
   For all $z \in \mathbb{C}$:
   $$
   \mathcal{M}(U_{ps} f)(z) = \left( \prod_{p \in ps} \Theta_p(z, d(p)) \right) \mathcal{M}(f)(z).
   $$
3. **Exact Zero-Moment Invariance:**  
   If $f$ has a vanishing moment at $z$ ($\mathcal{M}(f)(z) = 0$), then $U_{ps} f$ vanishes identically at $z$:
   $$
   \mathcal{M}(f)(z) = 0 \implies \mathcal{M}(U_{ps} f)(z) = 0.
   $$
4. **Exact Two-Sided Mellin Parity Law:**  
   For any integer moment index $h \ge 1$:
   $$
   \mathcal{M}(U_{ps} f)\left(h + \frac{1}{2}\right) \cdot \mathcal{M}(U_{ps} f)\left(-\left(h + \frac{1}{2}\right)\right) = (-1)^k A(ps, d, h) \cdot \left[ \mathcal{M}(f)\left(h + \frac{1}{2}\right) \cdot \mathcal{M}(f)\left(-\left(h + \frac{1}{2}\right)\right) \right],
   $$
   where the amplitude is strictly positive: $A(ps, d, h) > 0$.
5. **Universal Two-Sided Geometric Amplitude Bounds:**  
   The composite amplitude $A(ps, d, h)$ satisfies explicit geometric upper and lower bounds:
   $$
   \left(\frac{1}{8}\right)^k \prod_{p \in ps} p^{h \cdot d(p)} \le A(ps, d, h) \le 2^k \prod_{p \in ps} p^{h \cdot d(p)}.
   $$

---

## 2. Mathematical Proof

### 2.1. Regularity and Support
By induction on $ps$. The base case $ps = []$ is trivial. For $p :: qs$, the inductive hypothesis ensures $U_{qs} f$ is continuous and compactly supported. Since the single-prime kernel $U_p$ convolves a compactly supported distribution with compact dilations and delays, continuity and compact support are preserved.

### 2.2. Multi-Prime Mellin Multiplier
Each history operator acts on the complex Mellin transform by multiplication by $\Theta_p(z, d(p))$. By induction, the composition of $k$ independent prime blocks produces the exact product $\prod_{p \in ps} \Theta_p(z, d(p))$.

### 2.3. Parity Formula
At $z = \pm(h + 1/2)$, the local single-prime multipliers satisfy the reflection relation:
$$
\Theta_p(h + 1/2) \cdot \Theta_p(-(h + 1/2)) = - A_p(h, d(p)),
$$
where $A_p(h, d(p)) = -(\mu_{p, h}^+ \cdot \mu_{p, h}^-) > 0$.
Taking the product over all $p \in ps$, the sign factor $(-1)^k$ factors out:
$$
\prod_{p \in ps} (-A_p(h, d(p))) = (-1)^k \prod_{p \in ps} A_p(h, d(p)) = (-1)^k A(ps, d, h).
$$

### 2.4. Geometric Amplitude Bounds
From single-prime scattering estimates:
$$
\frac{1}{8} p^{h \cdot d(p)} \le A_p(h, d(p)) \le 2 p^{h \cdot d(p)}.
$$
Taking the product over $p \in ps$:
$$
\left(\frac{1}{8}\right)^k \prod_{p \in ps} p^{h \cdot d(p)} \le \prod_{p \in ps} A_p(h, d(p)) \le 2^k \prod_{p \in ps} p^{h \cdot d(p)}.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualPrimeBlockMellinParity` and `BuildingBlocks.ActualPrimeBlockMagnitude`):
```lean
theorem physical_block_regular {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ) :
    Continuous (physicalBlock ps depth f) ∧ HasCompactSupport (physicalBlock ps depth f)

theorem actual_block_mellin {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ)
    (hprime : ∀ p ∈ ps, p.Prime) (z : ℂ) :
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) z =
      (ps.map (fun (p : ℕ) => BuildingBlocks.GrowingPrimeScatteringBounds.originalHistory
        (p : ℝ) z (depth p))).prod * BuildingBlocks.FullComplexHistoryMellin.mellin f z

theorem actual_block_preserves_zero_moment {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ)
    (hprime : ∀ p ∈ ps, p.Prime) (z : ℂ)
    (hz : BuildingBlocks.FullComplexHistoryMellin.mellin f z = 0) :
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) z = 0

theorem actual_block_amplitude_positive (ps : List ℕ) (depth : ℕ → ℕ)
    {h : ℕ} (hh : 1 ≤ h) (hprime : ∀ p ∈ ps, p.Prime)
    (hdepth : ∀ p ∈ ps, 1 ≤ depth p) : 0 < amplitude ps depth h

theorem actual_block_two_sided_mellin_parity {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ)
    (hprime : ∀ p ∈ ps, p.Prime) (h : ℕ) :
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) ((h : ℂ) + 1 / 2) *
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) (-((h : ℂ) + 1 / 2)) =
      (-1 : ℂ) ^ ps.length * (amplitude ps depth h : ℂ) *
        (BuildingBlocks.FullComplexHistoryMellin.mellin f ((h : ℂ) + 1 / 2) *
          BuildingBlocks.FullComplexHistoryMellin.mellin f (-((h : ℂ) + 1 / 2)))

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

## 4. Literature Context and Target Venues

- **Prior Literature:** Scattering matrix factorizations and reflection parity in non-unitary quantum mechanics and Lax-Phillips scattering (Lax-Phillips 1967, Melrose 1993). The explicit formalization of prime-block reflection parity laws and two-sided geometric amplitude bounds in Lean 4 is novel.
- **Advancement:** Establishes machine-verified exact parity inversion $(-1)^k$ and geometric amplitude bounds for arbitrary prime-scattering sequences.
- **Target Venues:** *Communications in Mathematical Physics* or *Journal of Mathematical Physics*.
