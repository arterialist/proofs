# Suzuki pole normalizer and Goldbach variation in Lean 4

**Status:** complete Lean 4 formalization, September 2026.
Compiled in:
- [SuzukiCoefficientVariation.lean](../../formalization/BuildingBlocks/SuzukiCoefficientVariation.lean)
- [SuzukiGoldbachVariation.lean](../../formalization/BuildingBlocks/SuzukiGoldbachVariation.lean)
- [SuzukiPoleNormalizer.lean](../../formalization/BuildingBlocks/SuzukiPoleNormalizer.lean)

Attribution: Arterialist RH research team, September 2026.
Original mathematical concepts: Masatoshi Suzuki (2012, 2026) for $c_\omega(n)$ and Dirichlet
quotients $\zeta(s-\omega)/\zeta(s+\omega)$; Arterialist team for the second-variation bridge
to centered additive Goldbach pairs. The author reports a bounded search that found no prior formalization of Suzuki's coefficient families or their variational derivative identities. The search is not documented sufficiently to establish worldwide priority.

## Mathematical content

1. **Coefficient variation:**
   Defines $c_\omega(n) = n^\omega \prod_{p \mid n} (1 - p^{-2\omega})$. Formalizes the derivatives
   at $\omega = 0$:
   $$
    c_0(n) = \mathbf{1}_{n=1}, \qquad c'_0(n) = 2\Lambda(n), \qquad c''_0(n) = 4(\Lambda * \Lambda)(n).
   $$
2. **Additive square variation (`additiveSquare_second_deriv`):**
   Proves that subtracting the seed $u_\omega(n) = c_\omega(n) - c_0(n)$ isolates the additive
   Goldbach channel:
   $$
    \left. \partial_\omega^2 \sum_{a+b=N} u_\omega(a) u_\omega(b) \right|_{\omega=0} = 8 \sum_{a+b=N} \Lambda(a)\Lambda(b).
   $$
3. **Pole residue normalization (`normalizer_hasDerivAt_zero`):**
   Formalizes the exact analytic filling $2\omega / U(1+2\omega)$ where $U(s) = (s-1)\zeta(s)$
   using Mathlib's actual Riemann zeta function. Proves that it equals $1/\zeta(1+2\omega)$ on $\mathbb{R}_{>0}$,
   has derivative $2$ at zero, and generates the centered Goldbach source $d'_0(n) = 2(\Lambda(n) - 1)$.
4. **Centered quadratic convergence:**
   Proves that the normalized additive square variation yields the centered Goldbach coefficient
   $8 \sum_{a+b=N} (\Lambda(a)-1)(\Lambda(b)-1)$.

### Verification and dependencies
- Lean version: 4.24.0.
- Axiom dependencies: standard Mathlib foundations only (`propext`, `Classical.choice`, `Quot.sound`).
- Zero custom axioms, zero `sorry`.
