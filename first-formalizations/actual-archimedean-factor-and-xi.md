# Actual completed zeta xi and Archimedean factor in Lean 4

**Status:** complete Lean 4 formalization, September 2026. This is a formalization record, not a priority claim for the whole xi package.
Compiled in:
- [ActualArchimedeanFactor.lean](../formalization/BuildingBlocks/ActualArchimedeanFactor.lean)

Attribution: Arterialist RH research team, September 2026.
Classical mathematics: Riemann (1859), Hadamard (1893).
The public search for this audit found prior Lean xi packages in KeyAI's
[`ecdlp-lean-verification`](https://github.com/KeyAIGit/ecdlp-lean-verification), including
[`Xi.lean`](https://github.com/KeyAIGit/ecdlp-lean-verification/blob/main/ResearchOS/AnalyticNumberTheory/RiemannHypothesis/Xi.lean)
and [`Mult.lean`](https://github.com/KeyAIGit/ecdlp-lean-verification/blob/main/ResearchOS/AnalyticNumberTheory/RiemannHypothesis/Mult.lean),
as well as the public
[`li-criterion-rh-equivalence-lean`](https://github.com/nicholasbulka/li-criterion-rh-equivalence-lean)
repository. Those packages cover the entire xi normalization, elementary symmetries,
endpoint values, zeta-zero correspondence, and local order material represented here.
Accordingly, this page makes no first-formalization claim for the entire xi or
zero-multiplicity package. The narrower Archimedean logarithmic-derivative and completed-zeta
boundary statements remain useful formalization records; any firstness claim for that
narrower scope is provisional pending a separate theorem-level search, including the
`PrimeNumberTheoremAnd` public index.

## Mathematical content

Using Mathlib's actual `Complex.Gamma`, `Complex.Gammaℝ`, and `riemannZeta`:

1. **Archimedean factor and logarithmic derivative:**
   Proves the exact representation $\Gamma_\mathbb{R}(s) = \pi^{-s/2}\Gamma(s/2)$ and derives:
   \[
    \logDeriv \Gamma_\mathbb{R}(s) = -\frac{\log\pi}{2} + \frac{1}{2} \logDeriv \Gamma(s/2) \quad (\operatorname{Re} s > 0).
   \]
   At the critical line $s = 1/2 + it$, evaluates the multiplier:
   \[
    2 \operatorname{Re} \logDeriv \Gamma_\mathbb{R}(1/2 + it) = -\log\pi + \operatorname{Re} \logDeriv \Gamma(1/4 + it/2).
   \]
2. **Completed zeta boundary formula:**
   Proves that on $\operatorname{Re} s > 1$:
   \[
    \logDeriv \widehat\zeta(s) = -\frac{\log\pi}{2} + \frac{1}{2}\logDeriv \Gamma(s/2) - \sum_{n \ge 0} \frac{\Lambda(n)}{n^s},
   \]
   reconciled with Mathlib's actual arithmetic Dirichlet series.
3. **Entire $\xi(s)$ and zero equivalence:**
   Constructs $\xi(s) = \frac{1 + s(s-1)\widehat\zeta_0(s)}{2}$ and proves:
   - Complex differentiability everywhere on $\mathbb{C}$ (`xi_entire`).
   - Pole values $\xi(0) = \xi(1) = 1/2$ (`xi_pole_values`).
   - Functional equation $\xi(1-s) = \xi(s)$ (`xi_functional_equation`).
   - Exact zero equivalence: for $\operatorname{Re} s > 0$ and $s \ne 1$, $\xi(s) = 0 \iff \zeta(s) = 0$.
4. **Finite order and local logarithmic derivative limit:**
   Proves that for any complex analytic function with finite order $m$ at $s$:
   \[
    \lim_{w \to s, w \ne s} (w-s) \frac{f'(w)}{f(w)} = m.
   \]
   Applies this to prove that $\xi(s)$ has isolated zeros of finite multiplicity, and identifies
   the local residue of $\xi'/\xi$ with `analyticOrderNatAt xi s`.

### Verification and dependencies
- Lean version: 4.24.0.
- Mathlib commit: `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`.
- Axiom dependencies: standard Mathlib foundations only (`propext`, `Classical.choice`, `Quot.sound`).
- Zero custom axioms, zero `sorry`.
