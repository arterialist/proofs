# Finite cross-horizon Möbius clock: Lean formalization report

The companion module [CrossHorizonMobiusClockFinite.lean](BuildingBlocks/CrossHorizonMobiusClockFinite.lean) formalizes the finite algebraic core of the cross-horizon clock. It uses Mathlib's actual `ArithmeticFunction.moebius`, real clock parameter `q`, and the literal open divisor window `D < d < T`. It contains no limit, asymptotic, or RH assertion.

## Definitions and endpoint convention

The reached divisor window is

```lean
horizonWindow D T N = (Finset.Ioo D T).filter (fun d => d ≤ N)
```

and the future prefix at slope `a` is

```lean
∑ d ∈ horizonWindow D T N,
  if a * d ≤ N then (ArithmeticFunction.moebius d : ℝ) else 0.
```

Thus both endpoint conventions are explicit: `D < d < T`, and a divisor is admitted at the horizon exactly when `d ≤ N`.

## Proved identities

For `0 < D`, the theorem `future_prefix_reversal` proves the exact finite reversal

\[
(1-q)\sum_{0\le i<N}q^i
 \sum_{\substack{D<d<T\\ d\le N\\(i+1)d\le N}}\mu(d)
=
\sum_{\substack{D<d<T\\d\le N}}\mu(d)(1-q^{\lfloor N/d\rfloor}).
\]

The proof first establishes the finite geometric cutoff at every positive `d`, then commutes two finite sums.  No convergence hypothesis on `q` is required.

For `0 < N`, `floorStep_of_pos` proves unconditionally

\[
\lfloor N/d\rfloor=\lfloor(N-1)/d\rfloor+\mathbf 1_{d\mid N}
\qquad(d>0).
\]

Using that identity, `divisor_polynomial_increment` proves

\[
G_N(q)-G_{N-1}(q)
=(1-q)\sum_{D<d<T\atop d\mid N}
 \mu(d)q^{N/d-1}.
\]

The proof retains the horizon admission boundary.  In particular, the case `d=N`, where the term is absent from the `N-1` window, is handled separately rather than absorbed into a generic filtered-sum argument.

The scalar theorem `scalar_energy_coboundary` proves

\[
(G+\Delta)^2-G^2=2G\Delta+\Delta^2.
\]

For arbitrary real sequences `E` and `v`, `finite_energy_abel` proves the endpoint-complete identity

\[
\sum_{n=0}^{M}(v_n-v_{n+1})E_n
=v_0E_0+\sum_{n=0}^{M-1}v_{n+1}(E_{n+1}-E_n)-v_{M+1}E_M.
\]

Finally, `finite_abel_bound_by_positive_increments` proves that if `E₀=0`, `E_n≥0`, and `v_n≥0`, then

\[
\sum_{n=0}^{M}(v_n-v_{n+1})E_n
\le \sum_{n=0}^{M-1}v_{n+1}\max(E_{n+1}-E_n,0).
\]

This bound does not require monotonicity of `v`; it is the direct finite consequence of the Abel identity, positivity of the terminal energy, and replacement of each increment by its positive part.

## Compilation and axioms

The module compiles with Lean 4.24 in the repository environment.  `#print axioms` reports, for every public theorem above, exactly:

```text
[propext, Classical.choice, Quot.sound]
```

These are Mathlib's standard logical/quotient axioms.  The module introduces no `axiom`, uses no `sorry`, and leaves no arithmetic premise beyond the displayed positivity assumptions.
