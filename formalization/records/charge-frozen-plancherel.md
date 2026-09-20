# Exact arithmetic frozen-source Plancherel identity and logarithmic moment: Lean 4 formalization

**Status:** machine-checked in Lean 4.24.0.
Lean modules:
- [formalization/BuildingBlocks/ChargeFrozenPlancherel.lean](../../formalization/BuildingBlocks/ChargeFrozenPlancherel.lean)
- [formalization/BuildingBlocks/AngularFourierConvolution.lean](../../building-blocks/BuildingBlocks/AngularFourierConvolution.lean)
- [formalization/BuildingBlocks/ChargeFrozenFourierNorm.lean](../../formalization/BuildingBlocks/ChargeFrozenFourierNorm.lean)
- [formalization/BuildingBlocks/ChargeFrozenLogMoment.lean](../../formalization/BuildingBlocks/ChargeFrozenLogMoment.lean)
- [formalization/BuildingBlocks/LogarithmicLayercake.lean](../../building-blocks/BuildingBlocks/LogarithmicLayercake.lean)
Companion note:
- [building-blocks/dynamics-and-feedback/frozen-source-exact-plancherel.md](../../building-blocks/dynamics-and-feedback/frozen-source-exact-plancherel.md)

Attribution: Arterialist RH research team, September 2026.
Foundational axioms: standard Lean 4 foundations only (`[propext, Classical.choice, Quot.sound]`), zero custom axioms.

## Statement

Let $N \ge 2$ be a natural number and let $a_N: \mathbb{R} \to \mathbb{R}$ be the literal arithmetic charge source with von Mangoldt density $\Lambda(n)$.
Define its Fourier transform $\widehat{a}_N(\xi) = \int_{\mathbb{R}} e^{-i \xi v} a_N(v) \, dv$ and autocorrelation $C_N(h) = \int_{\mathbb{R}} a_N(v+h) a_N(v) \, dv$.

**Theorem (Frozen Source Plancherel and Layercake Log-Moment).**
1. **Autocorrelation Transform Equality:**
   \[
    \widehat{C}_N(\xi) = \widehat{a}_N(-\xi) \widehat{a}_N(\xi) = |\widehat{a}_N(\xi)|^2.
   \]
2. **Exact Real-Line Plancherel Identity:**
   \[
    \boxed{\quad H_N := \int_{\mathbb{R}} |\widehat{a}_N(\xi)|^2 \, d\xi = 2\pi \int_{\mathbb{R}} a_N(v)^2 \, dv. \quad}
   \]
3. **Prefix and Terminal Separation:**
   \[
    H_N = 2\pi \left[ \int_{(0, \log N]} a_N(v)^2 \, dv + \frac{|\psi(N) - N|^2}{N} \right].
   \]
4. **Logarithmic Layercake Moment Bound:**
   Under the logarithmic layercake decomposition $\log(2+|\xi|) = \log 2 + \int_0^{|\xi|} \frac{dt}{2+t}$, for $A_N = 4(8\log 2 + 2)^2 N$:
   \[
    \int_{\mathbb{R}} |\widehat{a}_N(\xi)|^2 \log(2 + |\xi|) \, d\xi \le H_N \Big[ \log 2 + \log(1 + A_N / H_N) + 1 \Big] \quad (H_N > 0).
   \]

## Formalization notes

- Modules: `BuildingBlocks.ChargeFrozenPlancherel`, `BuildingBlocks.AngularFourierConvolution`, `BuildingBlocks.ChargeFrozenFourierNorm`, `BuildingBlocks.ChargeFrozenLogMoment`, `BuildingBlocks.LogarithmicLayercake`.
- Formally audited: all 5 modules compile cleanly with zero `sorry` placeholders and standard foundational axioms `[propext, Classical.choice, Quot.sound]`.
- Uses Mathlib's Fourier inversion at zero combined with exact reflected convolution and Lebesgue integral scaling.
