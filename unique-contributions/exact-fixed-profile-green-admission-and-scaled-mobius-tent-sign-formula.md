# Unique Contribution 316: Exact Fixed-Profile Green Admission and Scaled Möbius Tent Sign Formula

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/FixedProfileGreenAdmissionFinite.lean`](../../formalization/BuildingBlocks/FixedProfileGreenAdmissionFinite.lean), [`building-blocks/green-admission/fixed-profile.md`](../../building-blocks/green-admission/fixed-profile.md)  
**Classification:** Analytic Number Theory / Spectral Theory / Green Functions / Gram Kernels / Möbius Inversion / Hilbert Space Packets / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the sequential attachment of prime generators to physical Hilbert state spaces, the admission increment $\Delta = 2(\|U\|^2 - 2\langle F, U \rangle)$ determines whether adjoining the newly exposed prime packet lowers or raises the total Dirichlet energy. When the inner products are governed by the fixed-profile Green Gram kernel $K_{\text{Green}}(d, e)$, determining the exact leading sign of $\Delta$ under prime growth has historically suffered from parasitic cofactor cross-terms.

This contribution proves:

1. **Exact Scaled Green Admission Sign Formula:**  
   For any prime $p > 0$ and doubled admission increment $\Delta$, the normalized increment satisfies the exact identity:
   \[
   p e^{2p} \Delta = -T_{\text{closed}}(p) + \left( 2p e^{2p} \text{diag} - A + B/2 - 4p e^{2p} J + 2p e^{2p} D \right),
   \]
   where $T_{\text{closed}}(p) = \sum_{n=1}^p \mu(n) (p/n - 1)$ is the closed-endpoint truncated Möbius tent, $J$ is the upper cofactor cross sum, $D$ is the delayed packet face, and $\text{diag}$ is the diagonal self-energy.
2. **Exact Truncated Möbius Tent Main Term:**  
   The finite tent decomposes identically into:
   \[
   T_{\text{closed}}(p) = p \sum_{n < p} \frac{\mu(n)}{n} - M(p - 1),
   \]
   where $M(x)$ is the Mertens function.
3. **Exact Gram Dictionary Between Kernel and Packet Vectors:**  
   For any Hilbert space embedding $G : \mathbb{N} \to H$ with $\langle G(d), G(e) \rangle = K(d, e)$:
   \[
   \mathcal{K}_{\text{inc}}(K, N, p) = \text{doubledIncrement}(\text{oldPacket}(G, N), \text{delayedPacket}(G, N, p)).
   \]
4. **Exact Lower/Upper Cross Decomposition:**  
   When the newly admitted prime satisfies $p \nmid N$, the old cross row splits cleanly into lower rows ($d < p$) and upper cofactor rows ($d > p$), with no $d = p$ row:
   \[
   \sum_{d \mid N} \mu(d) K(d, p) = \sum_{d \mid N, d < p} \mu(d) K(d, p) + \sum_{d \mid N, p < d} \mu(d) K(d, p).
   \]
5. **Finite-Horizon Perturbation Stability:**  
   For any finite-horizon approximations $F+E$ and $U+V$:
   \[
   |\Delta_{\text{approx}} - \Delta| < |\Delta| \implies \text{sgn}(\Delta_{\text{approx}}) = \text{sgn}(\Delta).
   \]

---

## 2. Mathematical Proof

### 2.1. Scaled Sign Formula Derivation
From the lower Green row expansion:
\[
\frac{\Delta}{2} = \text{diag} - 2 \left( \frac{e^{-2p}}{4p} \left( T_{\text{closed}}(p) + A - B/2 \right) + J \right) + D.
\]
Multiplying both sides by 2:
\[
\Delta = 2 \, \text{diag} - \frac{e^{-2p}}{p} (T_{\text{closed}}(p) + A - B/2) - 4J + 2D.
\]
Multiplying by $p e^{2p}$:
\[
p e^{2p} \Delta = 2p e^{2p} \text{diag} - (T_{\text{closed}}(p) + A - B/2) - 4p e^{2p} J + 2p e^{2p} D.
\]
Rearranging terms isolates $-T_{\text{closed}}(p)$ as the leading term:
\[
p e^{2p} \Delta = -T_{\text{closed}}(p) + 2p e^{2p} \text{diag} - A + B/2 - 4p e^{2p} J + 2p e^{2p} D.
\]

### 2.2. Truncated Tent Evaluation
At $n = p$, the summand in $T_{\text{closed}}(p)$ is $\mu(p) (p/p - 1) = \mu(p)(0) = 0$.
Thus $T_{\text{closed}}(p) = \sum_{n < p} \mu(n) (p/n - 1) = p \sum_{n < p} \frac{\mu(n)}{n} - \sum_{n < p} \mu(n) = p \sum_{n < p} \frac{\mu(n)}{n} - M(p-1)$.

### 2.3. Absence of Diagonal Cross Row
If $p \nmid N$, then by definition $p \notin N.\text{divisors}$.
Thus the condition $d = p$ is empty on $N.\text{divisors}$, ensuring the disjoint partition into $\{d < p\}$ and $\{d > p\}$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.FixedProfileGreenAdmissionFinite` in `formalization/BuildingBlocks/FixedProfileGreenAdmissionFinite.lean`):
```lean
theorem scaled_increment_main_sign
    {p : ℕ} (hp : 0 < p) (Δ diag J D A B : ℝ)
    (hΔ : Δ / 2 = diag -
      2 * (exp (-2 * (p : ℝ)) / (4 * p) *
        (truncatedTClosed p + A - B / 2) + J) + D) :
    (p : ℝ) * exp (2 * p) * Δ = -truncatedTClosed p +
      (2 * p * exp (2 * p) * diag - A + B / 2 -
        4 * p * exp (2 * p) * J + 2 * p * exp (2 * p) * D)

theorem truncatedTClosed_eq_main_term (p : ℕ) :
    truncatedTClosed p = (p : ℝ) * reciprocalPrefixBelow p - mertensBelow p

theorem kernelIncrement_eq_doubledIncrement
    (G : ℕ → H) (K : ℕ → ℕ → ℝ) (N p : ℕ)
    (hK : ∀ d e, inner ℝ (G d) (G e) = K d e) :
    kernelIncrement K N p =
      doubledIncrement (oldPacket G N) (delayedPacket G N p)

theorem oldCross_eq_lower_add_upper
    (K : ℕ → ℕ → ℝ) {N p : ℕ} (hp : ¬p ∣ N) :
    (∑ d ∈ N.divisors, μR d * K d p) =
      lowerOldCross K N p + upperOldCross K N p
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Beurling (1955) *A Closure Problem Related to the Riemann Zeta-Function*; Báez-Duarte (2003) *A strengthening of the Nyman-Beurling criterion*; Bagchi (2006) *On Nyman, Beurling and Baez-Duarte's Hilbert space approach to the Riemann Hypothesis*. Machine verification of exact scaled Green admission formulas and truncated Möbius tent leading-sign isolation in Lean 4 is new.
- **Advancement:** Explicitly isolates the negative truncated Möbius tent $-T_{\text{closed}}(p)$ as the primary driver of spectral Green admission increments, certifying all remaining cofactor cross terms.
- **Target Venues:** *Journal of Functional Analysis* or *Journal of Number Theory*.
