# Unique Contribution 285: Exact Paired Scattering Defect and Uniform Critical-Strip Bound

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PairedScatteringDefect.lean`](../../formalization/BuildingBlocks/PairedScatteringDefect.lean), [`building-blocks/scattering/paired-defect.md`](../../building-blocks/scattering/paired-defect.md)  
**Classification:** Scattering Theory / Spectral Theory / S-Matrix / Paired Multipliers / Critical Strip Bounds / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the scattering formulation of the Riemann hypothesis, the local scattering multiplier at depth $M$ is defined by:
\[
\mathcal{M}(r, x, y, M) = -rx + (1-r^2) \sum_{j=0}^{M-1} (ry)^j.
\]
A central obstruction in verifying the unitarity and boundedness of multi-prime scattering transfers is whether the product of forward and backward paired multipliers $\mathcal{M}(r, x, y, M) \mathcal{M}(r, y, x, M)$ remains bounded throughout the critical strip as $M \to \infty$.

This contribution proves:

1. **Exact Paired Multiplier Identity:**  
   For any complex $r, x, y \in \mathbb{C}$ with $xy = 1$ and any depth $M \in \mathbb{N}$:
   \[
   \mathcal{M}(r, x, y, M) \mathcal{M}(r, y, x, M) = 1 - (1-r^2)r^{2M} - (1-r^2) \sum_{j=0}^{M-1} r^{2M-(j+1)} (x^{j+1} + y^{j+1}).
   \]
2. **Uniform Bound on Critical Strip for All Integers $p \ge 2$:**  
   Setting $r = 1/\sqrt{p}$ and $L = \log p$, for any history depth $M \in \mathbb{N}$ and any complex frequency $z \in \mathbb{C}$ with $|\text{Re}(z)| \le 1/2$:
   \[
   \left\| \mathcal{M}(r, e^{z \log p}, e^{-z \log p}, M) \mathcal{M}(r, e^{-z \log p}, e^{z \log p}, M) \right\| \le 3,
   \]
   UNCONDITIONALLY and UNIFORMLY in $p \ge 2$, $M \in \mathbb{N}$, and $\text{Im}(z) \in \mathbb{R}$!
3. **Exact Half-Strip Moment Evaluation:**  
   Under the substitution $q = r^2$, the symmetric defect moment:
   \[
   H(q, M) = (1-q)q^M + (1-q) \sum_{j=0}^{M-1} (q^M + q^j)
   \]
   evaluates in exact closed form to:
   \[
   H(q, M) = 1 + ((M+1)(1-q) - 1) q^M.
   \]
4. **Universal Moment Bound:**  
   For all $q \in [0, 1]$ and all $M \in \mathbb{N}$:
   \[
   0 \le H(q, M) \le 2.
   \]
5. **Hyperbolic Cosine Majorization:**  
   For all $w \in \mathbb{C}$ with $|\text{Re}(w)| \le L/2$:
   \[
   \|e^{(j+1)w} + e^{-(j+1)w}\| \le 2 \cosh((j+1)L/2) = e^{(j+1)L/2} + e^{-(j+1)L/2}.
   \]

---

## 2. Mathematical Proof

### 2.1. Paired Algebraic Invariant
Let $h(M) = \mathcal{M}(r, x, y, M) \mathcal{M}(r, y, x, M)$.
The recursive step satisfies:
\[
\mathcal{M}(r, x, y, M+1) = ry \mathcal{M}(r, x, y, M) + (1-rx),
\]
and the geometric identity $(1-ry)\mathcal{M}(r, x, y, M) = 1 - rx - (1-r^2)(ry)^M$.
Multiplying the two recursive relations and using $xy = 1$ yields:
\[
h(M+1) = r^2 h(M) + (1-r^2) - (1-r^2) r^{M+1} (x^{M+1} + y^{M+1}).
\]
Induction on $M$ produces the explicit telescoping sum:
\[
h(M) = 1 - (1-r^2)r^{2M} - (1-r^2) \sum_{j=0}^{M-1} r^{2M-(j+1)} (x^{j+1} + y^{j+1}).
\]

### 2.2. Half-Strip Moment Evaluation
Setting $x = e^{w}, y = e^{-w}$ where $|\text{Re}(w)| \le L/2$ and $e^{L/2} = 1/r$, the exponential terms are bounded by $e^{(j+1)L/2} + e^{-(j+1)L/2} = r^{-(j+1)} + r^{j+1}$.
Multiplying by $r^{2M-(j+1)}$ gives:
\[
r^{2M-2(j+1)} + r^{2M}.
\]
Setting $q = r^2$:
\[
\sum_{j=0}^{M-1} (q^M + q^{M-1-j}) = \sum_{j=0}^{M-1} (q^M + q^j).
\]
Using $(1-q)\sum_{j=0}^{M-1} q^j = 1 - q^M$:
\[
H(q, M) = (1-q) q^M + M(1-q) q^M + (1-q^M) = 1 + ((M+1)(1-q) - 1) q^M.
\]

### 2.3. Universal Bound $H(q, M) \le 2$
Since $(M+1)q^M \le \sum_{j=0}^M q^j = \frac{1-q^{M+1}}{1-q}$ for $q \in [0, 1]$:
\[
(M+1)(1-q)q^M \le 1 - q^{M+1} \le 1.
\]
Thus $((M+1)(1-q) - 1)q^M \le 1 - q^M \le 1$, which proves $H(q, M) \le 1 + 1 = 2$.
Applying the triangle inequality to $h(M)$:
\[
\|h(M)\| \le 1 + (1-r^2)r^{2M} + H(r^2, M) - (1-r^2)r^{2M} = 1 + H(r^2, M) \le 1 + 2 = 3.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PairedScatteringDefect` in `formalization/BuildingBlocks/PairedScatteringDefect.lean`):
```lean
theorem paired_identity (r x y : ℂ) (h : x*y=1) (M : ℕ) :
    multiplier r x y M * multiplier r y x M =
      1-(1-r^2)*r^(2*M) - (1-r^2)*
        ∑ j ∈ Finset.range M, r^(2*M-(j+1))*(x^(j+1)+y^(j+1))

theorem halfStripMoment_eq (q : ℝ) (M : ℕ) :
    halfStripMoment q M = 1+(((M+1 : ℕ) : ℝ)*(1-q)-1)*q^M

theorem halfStripMoment_le_two (q : ℝ) (hq0 : 0 ≤ q) (hq1 : q ≤ 1) (M : ℕ) :
    halfStripMoment q M ≤ 2

theorem norm_paired_exp_le_three (r L : ℝ) (w : ℂ) (hr : 0 < r)
    (hr1 : r ≤ 1) (hL0 : 0 ≤ L) (hL : Real.exp (L/2)=r⁻¹)
    (hw : |w.re| ≤ L/2) (M : ℕ) :
    ‖multiplier (r : ℂ) (Complex.exp w) (Complex.exp (-w)) M *
      multiplier (r : ℂ) (Complex.exp (-w)) (Complex.exp w) M‖ ≤ 3

theorem norm_paired_actual_prime_le_three (p : ℕ) (hp : 2 ≤ p) (z : ℂ)
    (hz : |z.re| ≤ 1/2) (M : ℕ) :
    ‖multiplier ((1/Real.sqrt (p : ℝ) : ℝ) : ℂ)
        (Complex.exp (z*Real.log (p : ℝ))) (Complex.exp (-(z*Real.log (p : ℝ)))) M *
      multiplier ((1/Real.sqrt (p : ℝ) : ℝ) : ℂ)
        (Complex.exp (-(z*Real.log (p : ℝ)))) (Complex.exp (z*Real.log (p : ℝ))) M‖ ≤ 3
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Lax–Phillips scattering theory (1967), Pavlov & Faddeev (1975), and de Branges Hilbert spaces of entire functions (1968). Machine-verified uniform bounds on paired multi-channel arithmetic scattering multipliers across the entire critical strip in Lean 4 are new.
- **Advancement:** Guarantees that the paired scattering matrix cannot develop wild exponential growth in the critical strip as history depth $M \to \infty$, establishing a uniform $O(1)$ barrier.
- **Target Venues:** *Journal of Spectral Theory* or *Letters in Mathematical Physics*.
