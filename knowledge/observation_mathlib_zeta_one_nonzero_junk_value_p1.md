# Mathlib Riemann Zeta Junk Value Non-Zero at Pole s = 1

Type: observation
Confidence: high
Source: Candidate 5 (Level 0), explore_falser_L00_N05
Relevant to: Any Lean 4 formalization involving $\zeta(s)$ at or near the pole $s = 1$, or definitions separating nontrivial zeros from $s = 1$.

## Statement
In Lean 4 Mathlib (`Mathlib.NumberTheory.Harmonic.ZetaAsymp:444`), the value of the Riemann zeta function at the simple pole $s = 1$ is assigned a non-zero junk value:
$$\text{theorem } \texttt{riemannZeta\_one\_ne\_zero} : \zeta(1) \ne 0.$$
Consequently, in formal Lean 4 statements, $\zeta(1)$ is strictly non-zero, contradicting informal prose assertions that $\zeta(1) = 0$ by convention.

## Evidence
Mathlib 4 formal theorem declaration:
`theorem riemannZeta_one_ne_zero : riemannZeta 1 ≠ 0` in `Mathlib.NumberTheory.Harmonic.ZetaAsymp`.
This theorem is verified in Mathlib 4 core and can be queried directly via `#check riemannZeta_one_ne_zero`.

## Implications
1. Any formal proof or tactic in Lean 4 that attempts to rewrite $\zeta(1) = 0$ will immediately fail or introduce a logical contradiction with Mathlib's library.
2. Formal definitions of nontrivial zero sets such as `SpectralZeroSupport := {s : ℂ | riemannZeta s = 0 ∧ (¬ ∃ n, s = -2(n+1)) ∧ s ≠ 1}` include $s \ne 1$ primarily for mathematical clarity; but even without $s \ne 1$, $s = 1$ is already excluded from `{s | riemannZeta s = 0}` because $\zeta(1) \ne 0$ in Mathlib.
3. However, when deducing $s \ne 1$ from $\zeta(s) = 0$, one can use `riemannZeta_one_ne_zero` directly: $\zeta(s) = 0 \implies s \ne 1$.

## Caveats
Analytically in complex analysis, $\zeta(s)$ has a simple pole at $s = 1$ with residue 1, so $\zeta(1)$ is undefined. The non-zero value in Mathlib is purely an artifact of total function definitions in Lean 4. Formal proofs must not rely on any specific numerical value of $\zeta(1)$ beyond $\zeta(1) \ne 0$.
