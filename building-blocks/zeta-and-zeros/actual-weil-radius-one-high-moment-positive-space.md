# A uniform positive high-moment space at root radius one

This is a positive subspace theorem for the actual compact Weil quadratic form, not full-window positivity or a route to RH. The high-frequency mechanism is already implicit in the tail reduction of [Zhu, Lemma 3.1 and Section 4](https://arxiv.org/html/2608.24827v2); the explicit moment index and elementary Chebyshev leakage bound below are the contribution here.

Let `f` be real, even, and in `C_c^∞((-1,1))`. Define `F_f(z)=∫f(x)e^{zx}dx`. Impose

* `∫_{-1}^1 x^{2j}f(x)dx=0` for every integer `0≤j≤1300`;
* `∫_{-1}^1 cosh(x/2)f(x)dx=0`.

The last equation is exactly both pole moments `F_f(1/2)=F_f(-1/2)=0` for even `f`. These conditions define an infinite-dimensional real linear space. Explicitly, every nonzero even `φ∈C_c^∞((-1,1))` gives an example

`f=(∂_x²−1/4)∂_x^2602 φ`.

Integration by parts proves both sets of vanishing moments; the differential operator is injective on compactly supported smooth functions.

**Claim.** Every such `f` satisfies the uniform strict bound

`Q(f) ≥ (1/10) ||f||²_2`.

## Exact source and prime list

For this pole-null class the complete actual form is

`Q(f)=(1/2π)∫_{R} Ψ(t)|f̂(t)|²dt`,

`Ψ(t)=H(t)−P(t)`, `H(t)=Re ψ(1/4+it/2)−log π`,

`P(t)=2 Σ_{n∈{2,3,4,5,7}} Λ(n)n^(−1/2) cos(t log n)`.

The diameter is strictly less than two. These are **all** `p^k` with `log(p^k)<2`; the next, `8`, has `log 8>2`. Correlations at a hypothetical equality endpoint vanish for open compact support. There is no pole residue after the imposed two moment equalities. In particular the `4=2²` coefficient is `Λ(4)=log 2`, not `log 4`.

Put `A=2Σ_{n∈{2,3,4,5,7}}Λ(n)/√n=5.8524683643...<5.86`. Pointwise `P(t)≤A`. This is the sharp universal pointwise prime-comb upper bound (Zhu, Lemma 3.2), so no stronger bound is silently assumed. The elementary digamma series makes `H(t)≥H(0)>−6` for every real `t`; indeed `H(0)=−γ−π/2−3log2−logπ`. Thus `Ψ(t)>−11.86` at all frequencies.

Zhu's Lemma 3.1, proved there by Binet's formula without RH, gives for `|t|≥15/4`

`H(t)≥log(|t|/(2π))−1/|t|`.

At `T=2500`, this implies `H(t)>5.98` and therefore `Ψ(t)>0.12` for `|t|≥T`. These deliberately rounded checks are elementary: `A<5.86`, `π<3.142`, and `log(2500/(2π))−1/2500>5.98`. One may certify `A<5.86` using `log2<.694`, `log3<1.099`, `log5<1.610`, `log7<1.946` and `√2>1.414`, `√3>1.732`, `√5>2.236`, `√7>2.645`, all with rational decimal endpoints. The logarithm lower bound follows, for example, by a rational exponential-series check.

## Uniform low-frequency leakage without a sampled matrix

Because `f` is even and its even polynomial moments through degree `2600` vanish, it is orthogonal to **every** polynomial of degree at most `M=2601`. The odd moments vanish automatically.

For real `|t|≤T`, approximate `x↦e^(−itx)` on `[-1,1]` by its Chebyshev series through degree `M`. On the Bernstein ellipse with parameter `ρ=3/2`, the imaginary semiaxis is `(ρ−ρ^(−1))/2=5/12`, so the modulus of the analytic function is at most `exp(5T/12)`. Cauchy's Laurent-coefficient estimate gives `|a_n|≤2exp(5T/12)ρ^(−n)` for each `n≥1`. Therefore the uniform polynomial-approximation error is bounded by

`E=2 exp(5T/12) ρ^(−M)/(ρ−1)=4 exp(5T/12)(2/3)^M`.

Orthogonality and Cauchy–Schwarz now give `|f̂(t)|≤√2 E ||f||_2`. Parseval yields the normalized low-frequency mass

`θ=(2π||f||²_2)^(−1)∫_{|t|≤T}|f̂(t)|²dt ≤ (2T/π) E² < 10^(−6)`.

The final inequality follows from `log(3/2)>0.4054`, itself the ten-term even partial sum of the alternating series for `log(1+1/2)`, and the displayed `T=2500`, `M=2601`. The actual value of this upper bound is about `1.45×10^(−7)`.

Split the exact Fourier integral at `T`. The full prime row and signed gamma obey

For every nonzero `f` in the space,

`Q(f)/||f||²_2 > 0.12(1−θ)−11.86θ > 0.1`.

No frequency support, finite sampling, derivative cap, or omission of prime powers is asserted. The subspace is infinite-dimensional but high codimension; it is compatible with any off-critical zeros because the full compact test class is not covered. For nonreal zeros the bilateral spectral term remains `F_f(z) overline(F_f(−bar z))`, not an absolute square. This theorem alone has no implication to RH or `CoarsePrimitiveBound`.

The exact finite Schur algebra used to adjoin one arithmetic low mode is
kernel checked in [ActualWeilRankOneSchur.lean](../../formalization/BuildingBlocks/ActualWeilRankOneSchur.lean).
The digamma envelope, Chebyshev approximation, and analytic identification of
the complete Weil form in this note remain written arguments, not Lean proofs.
