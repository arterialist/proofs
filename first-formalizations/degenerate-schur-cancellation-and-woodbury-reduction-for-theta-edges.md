# First Formalization: Degenerate Schur Complement Cancellation and Woodbury Reduction for Theta Edges

**Date:** 19 September 2026  
**Lean 4 Modules:** [`formalization/BuildingBlocks/ThetaDirectEdgeFiniteAlgebra.lean`](../../formalization/BuildingBlocks/ThetaDirectEdgeFiniteAlgebra.lean), [`formalization/BuildingBlocks/ThetaSignedCoreFiniteBlock.lean`](../../formalization/BuildingBlocks/ThetaSignedCoreFiniteBlock.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the certified matrix algebra governing the multi-column elimination of edge profiles in the discrete theta jump operator:

1. **One-Dimensional Schur Residual Identity:**
   Formal equivalence showing that the rational residual $\operatorname{edgeTheta} = (A_{zz} - b_c^2/d_c - b_p^2/d_p) - m^2/d_y$ expands into the projected quadratic form along $z - s\varphi$ (`schur_residual_identity`, `edgeTheta_eq_projectedEnergy`).
2. **Degenerate Cauchy–Schwarz Numerator Cancellation:**
   Formal algebraic proof that in any positive semidefinite $2 \times 2$ block with zero diagonal entry $d = 0$, the off-diagonal mixed coupling must vanish: $b = 0$ (`psd_mixed_eq_zero_of_diagonal_eq_zero`). Applied to the residual edge block, this rigorously proves that when $d_y = 0$, the numerator $m$ vanishes identically (`degenerate_residualMixed_eq_zero`), establishing the safety of the convention $\operatorname{schurQuotient}(m, 0) = 0$ (`schurQuotient_eq_zero`).
3. **Three-Column Woodbury Quadratic Expansion:**
   Formal matrix-vector multiplication verifying the exact algebraic expansion of $c^T G c$ for the 4-dimensional vector $c = (1, -r^T)^T$ against an arbitrary $4 \times 4$ matrix $G$ (`woodbury_quadratic_expansion`).
4. **Five-Component Signed Core Decomposition and Coercivity:**
   Formal proof of entrywise and quadratic decomposition of the signed core matrix into spectral, mean correction, covariance, odd-affine, and prime observation components (`signedCore_quadratic_decomposition`), and verification that the minimum margin certificate $c^* > 0$ forces global block coercivity (`cStar_pos_implies_finiteBlock_coercive`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Schur residual identity
theorem schur_residual_identity
    {Azz Ayy b0 bc bp gc gp dc dp : ℝ}
    (hdy : residualDiagonal Ayy gc gp dc dp ≠ 0) :
    let dy := residualDiagonal Ayy gc gp dc dp
    let m := residualMixed b0 bc bp gc gp dc dp
    let s := m / dy
    edgeTheta Azz Ayy b0 bc bp gc gp dc dp =
      (Azz - bc ^ 2 / dc - bp ^ 2 / dp) - 2 * s * m + s ^ 2 * dy

-- Degenerate Cauchy-Schwarz cancellation
theorem psd_mixed_eq_zero_of_diagonal_eq_zero
    {a b d : ℝ} (hpsd : 0 ≤ a ∧ 0 ≤ d ∧ b ^ 2 ≤ a * d)
    (hd0 : d = 0) : b = 0

theorem degenerate_residualMixed_eq_zero
    {Azz Ayy b0 bc bp gc gp dc dp : ℝ}
    (hdiag : 0 ≤ Azz - bc ^ 2 / dc - bp ^ 2 / dp)
    (hdy : 0 ≤ residualDiagonal Ayy gc gp dc dp)
    (hdet : residualMixed b0 bc bp gc gp dc dp ^ 2 ≤
      (Azz - bc ^ 2 / dc - bp ^ 2 / dp) *
        residualDiagonal Ayy gc gp dc dp)
    (hdy0 : residualDiagonal Ayy gc gp dc dp = 0) :
    residualMixed b0 bc bp gc gp dc dp = 0

-- Three-column Woodbury quadratic expansion
theorem woodbury_quadratic_expansion (G : Matrix (Fin 4) (Fin 4) ℝ)
    (r : Fin 3 → ℝ) :
    dotProduct (woodburyCoefficients r) (G.mulVec (woodburyCoefficients r)) =
      G 0 0 - (∑ j : Fin 3, G 0 j.succ * r j) -
        (∑ j : Fin 3, r j * G j.succ 0) +
          ∑ j : Fin 3, ∑ k : Fin 3, r j * G j.succ k.succ * r k

-- Five-component signed core decomposition
theorem signedCore_quadratic_decomposition
    (lambda : Fin N → ℝ) (alpha a dQ : ℝ) (m ac k c : Fin N → ℝ)
    (covarianceGram primeGram : Matrix (Fin N) (Fin N) ℝ) :
    quadratic (signedCoreMatrix lambda alpha a dQ m ac k
      covarianceGram primeGram) c =
      quadratic (spectralTerm lambda alpha) c +
      quadratic (meanTerm m ac) c +
      quadratic (covarianceTerm a covarianceGram) c +
      quadratic (oddAffineTerm dQ k) c +
      quadratic (primeObservationTerm primeGram) c

-- Coercivity from scalar certificate
theorem cStar_pos_implies_finiteBlock_coercive
    {F H normSq lowNormSq highNormSq low next CV epsilon : ℝ}
    (hnorm : normSq = lowNormSq + highNormSq)
    (hF : H ≤ F)
    (hH : (low - epsilon) * lowNormSq +
      (next - CV - CV ^ 2 / epsilon) * highNormSq ≤ H)
    (hlow : 0 ≤ lowNormSq) (hhigh : 0 ≤ highNormSq)
    (_hc : 0 < cStar low next CV epsilon) :
    cStar low next CV epsilon * normSq ≤ F
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This formalization establishes the exact algebraic stability of the edge-elimination Schur complement by proving that indeterminate zero denominators automatically force vanishing numerators under PSD conditions, eliminating numerical singularities in machine-checked operator certificates.
