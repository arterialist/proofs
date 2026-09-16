# First-order gap-or-collar proof of an actual theta sign-channel excess

*Joint development by RH Proof and RH Agent2; independently cross-audited, 2026-09-16. Written analysis, not Lean.*

The critical-scale favorable-radius theorem already contains enough information for a sign-channel dichotomy. This argument uses its fixed-shape complete-prime trial, the established global physical-mass lower bound, and the actual ground identity. It does **not** need the Brun–Titchmarsh near-prime bound or the second-order box constant. The claimed outcome is only for the actual theta sign channel at selected radii, not for the mixed covariance, full affine cone, or RH.

Fix `c>1` and `d>2c`. The [critical-subsequence theorem](theta-ground-critical-subsequence-prime-average.md) selects one `R∈[r,r+1/r]` for every sufficiently large `r` such that, with `h=cR e^(−R)`, `x=e^(2R)`, `g=G_R1_{u>R}`, `q_+=||g||₂²`, `q=||G_R||₂²=2q_+`, `m=∫g`, and `ℓ=m²/q_+`,

`δ_R≥a_c R ω(R+h)²`, `ℓ≤(d+o(1))R e^(−R)`.  (1)

The global complete-prime logarithmic-energy argument in [physical-mass concentration](theta-ground-physical-mass-concentration.md) also gives, uniformly in `R`,

`m≥c_0 exp(−C_0e^R)√q`.                        (2)

The cited statement writes the mass of the even `G_R`; its mass is `2m`, and that factor is absorbed into `c_0` here.

Weighted physical mass beyond `R+dR e^(−R)` is negligible relative to `m`; hence the pole column and sharp nonnegative Fourier cap give

`H_R²=4e^Rℓ q_+(1+o(1))`,

`A[g]/q_+≥log(1/ℓ)−1−log2+o(1)`.             (3)

The exact complete ground identity and previously established corrections are

`P_R=A[g]+δ_R/2−S_same(R)−C_R`,

`S_same/H_R²=o(1)`, `C_R/H_R²=O(e^(−2R))`.   (4)

All prime powers and the continuous cross remain in (4). Put `K_R=2R` and split the selected radii into two cases.

**Large gap: `δ_R/q≥2R`.** From (1)–(4),

`A[g]/H_R²≥1/(4d)−o(1)`,

`δ_R/(2H_R²)=(δ_R/q)/(4e^Rℓ)(1+o(1))≥1/(2d)−o(1)`,

so `P_R/H_R²≥3/(4d)−o(1)`.

**Smaller gap: `δ_R/q<2R`.** Equations (1) and (2) force `q>(a_c/2)ω(R+h)²`, and therefore `m≥c_1 exp(−C_0e^R)ω(R+h)`. For any fixed `ε>0` put `T=R+(1+ε)h`. Theta normalization and Cauchy–Schwarz give

`m_tail(T):=∫_T^∞g ≤ (∫_T^∞ω(u)²du)^(1/2) ≤ exp(O(R))ω(T)`.

The two-sided theta envelope `ω(u)²≍e^(4u)exp(−πe^(2u))` yields

`log[ω(T)/ω(R+h)]=−πε cR e^R+o(R e^R)`.

This dominates the `C_0e^R` physical-mass cost, so `m_tail(T)/m→0`. Cauchy–Schwarz on `(R,T)` then gives

`ℓ≤(1+ε+o(1))cR e^(−R)`.                     (5)

Equations (3)–(4) imply `P_R/H_R²≥1/[4c(1+ε)]−o(1)` in this case. Consequently, for each fixed `c>1`, `d>2c`, and `ε>0`, the selected radii satisfy

`liminf P_R/H_R² ≥ min{3/(4d), 1/[4c(1+ε)]}`. (6)

For example, `c=1.1`, `d=2.4`, `ε=0.1` makes the right side greater than `0.20`, so `P_R>H_R²/8` for every sufficiently large selected radius. Diagonalize over `c↓1`, `d↓2` with `d>2c`, and `ε↓0`. The constants and starting radii may depend on these fixed parameters; choosing each next radius after its corresponding estimates take effect gives an unbounded selected sequence with

`liminf P_R/H_R²≥1/4`.                         (7)

The first-order critical trial and the original `exp(−C_0e^R)` physical-mass lower bound suffice: the theta ratio between `R+h` and `R+(1+ε)h` falls on the faster scale `R e^R`. The theorem does not transfer selected-radius positivity to all large radii or pay the mixed covariance residual.
