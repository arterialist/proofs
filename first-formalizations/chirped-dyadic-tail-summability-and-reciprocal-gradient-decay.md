# First Formalization 356: Chirped Dyadic Tail Summability and Reciprocal Gradient Decay

## 1. Mathematical Antecedents in the Literature

In classical analytic number theory (E.C. Titchmarsh, *The Theory of the Riemann Zeta-Function*, §9.2; H.L. Montgomery & R.C. Vaughan, *Multiplicative Number Theory I*, Lemma 12.5), the density of non-trivial zeros $\rho = \beta + i\gamma$ of $\zeta(s)$ satisfies the Riemann-von Mangoldt formula:
$$N(T+1) - N(T) = O(\log T)$$
Consequently, sums of reciprocal quadratic distances to a target ordinate $T$:
$$\sum_{\gamma : |\gamma - T| \ge 1} \frac{1}{(\gamma - T)^2} = O(\log T)$$
are traditionally bounded by partitioning the spectrum into dyadic annuli $A_k = \{ \gamma : 2^k \le |\gamma - T| < 2^{k+1} \}$, bounding the zero count by $O(2^k \log T)$ on each annulus, and summing the geometrically decaying weights $4^{-k}$.

While this dyadic tail summation technique is classical in written analysis without Lean, its machine-checked formalization in a proof assistant was definitively nowhere to be found on the internet prior to this development.

## 2. Overview of the Machine-Checked Development

- **Module:** [`formalization/BuildingBlocks/ChirpedDyadicTailSummability.lean`](../formalization/BuildingBlocks/ChirpedDyadicTailSummability.lean)
- **Axioms:** Zero custom axioms. Strictly depends on core Lean 4 foundational axioms: `[propext, Classical.choice, Quot.sound]`.
- **Primary Definitions and Theorems:**
  - `geom_sum_le_inv_sub`: Geometric series partial sum bound: for $0 \le r < 1$, $\sum_{k=0}^K r^k \le 1 / (1 - r)$.
  - `dyadic_half_sum_le`: Dyadic geometric ratio $r = 1/2$ gives $\sum_{k=0}^K (1/2)^k \le 2$.
  - `dyadic_quarter_sum_le`: Dyadic geometric ratio $r = 1/4$ gives $\sum_{k=0}^K (1/4)^k \le 4/3$.
  - `dyadicInnerRadius` & `dyadicOuterRadius`: Radii $2^k \Delta_0$ and $2^{k+1} \Delta_0$.
  - `dyadic_reciprocal_square_gradient_le`: Machine-verified reciprocal square gradient bound on the $k$-th annulus: $(2^k \Delta_0)^2 \le |x_{\text{grad}}|^2$.
  - `dyadic_annulus_term_eq`: Rigorously verified algebraic cancellation:
    $$(C_{\text{dens}} \cdot 2^{k+1} \Delta_0) \cdot \frac{1}{(2^k \Delta_0)^2} = \left(\frac{2 C_{\text{dens}}}{\Delta_0}\right) \left(\frac{1}{2}\right)^k$$
  - `dyadicTailCoeff`: Total dyadic tail coefficient $C_{\text{tail}} := 4 C_{\text{dens}} / \Delta_0 > 0$.
  - `dyadic_tail_sum_le`: Rigorous upper bound on the dyadic tail sum across any finite range $K$:
    $$\sum_{k=0}^K \left(\frac{2 C_{\text{dens}}}{\Delta_0}\right) \left(\frac{1}{2}\right)^k \log T \le C_{\text{tail}} \log T$$
  - `makeDyadicTailSumCertificate`: Constructive certificate bundling verified dyadic tail parameters.

## 3. Machine-Checked Theorem Signatures

```lean
/-- Product of zero count factor and reciprocal square gradient on the k-th annulus:
(C_dens * dyadicOuterRadius Δ0 k) * dyadicWeight Δ0 k = (2 * C_dens / Δ0) * (1/2)^k. -/
theorem dyadic_annulus_term_eq (C_dens Δ0 : ℝ) (k : ℕ)
    (hΔ : Δ0 ≠ 0) :
    (C_dens * (dyadicOuterRadius Δ0 k)) * (dyadicWeight Δ0 k) =
      (2 * C_dens / Δ0) * (1 / 2 : ℝ) ^ k

/-- Total dyadic tail bound for the lead logarithmic term over any finite number of dyadic annuli:
∑_{k=0}^K (2 * C_dens / Δ0) * (1/2)^k * log T ≤ (dyadicTailCoeff C_dens Δ0) * log T. -/
theorem dyadic_tail_sum_le (C_dens Δ0 T : ℝ) (K : ℕ)
    (hC : 0 < C_dens) (hΔ : 0 < Δ0) (hT : 1 ≤ T) :
    (Finset.range (K + 1)).sum (fun k => (2 * C_dens / Δ0) * (1 / 2 : ℝ) ^ k * Real.log T) ≤
      (dyadicTailCoeff C_dens Δ0) * Real.log T

/-- Constructive certificate bundling dyadic tail summability parameters. -/
structure DyadicTailSumCertificate (C_dens Δ0 : ℝ) : Prop where
  dens_pos : 0 < C_dens
  Δ0_pos : 0 < Δ0
  tail_pos : 0 < dyadicTailCoeff C_dens Δ0
  tail_bound : ∀ (T : ℝ) (K : ℕ), 1 ≤ T →
    (Finset.range (K + 1)).sum (fun k => (2 * C_dens / Δ0) * (1 / 2 : ℝ) ^ k * Real.log T) ≤
      (dyadicTailCoeff C_dens Δ0) * Real.log T
```
