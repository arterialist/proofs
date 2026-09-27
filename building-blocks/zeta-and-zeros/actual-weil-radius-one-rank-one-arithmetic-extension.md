# One arithmetic low mode adjoined to the radius-one high-moment positive space

This is a strict enlargement of a fixed-window positive space, not positivity on the complete pole-null test class or an RH implication. The key arithmetic input is a checked inequality for the **actual** complete five-power prime comb on one finite band. The argument does not replace the prime row by a generic constant there.

## Exact form and explicit smooth low mode

Use the radius-one high-moment space `V` from [the proved high-moment inequality](actual-weil-radius-one-high-moment-positive-space.md): real even `v∈C_c^∞((-1,1))`, zero even moments through degree 2600, and `∫v cosh(x/2)=0`. Its normalized Fourier mass below `T=2500` is at most `θ=10^-6` (in fact much smaller), and its complete Weil form is positive.

Let `a=19/80`, `K=1058`, and `χ_a=(2a)^(-1) 1_{[-a,a]}`. Put `η=χ_a^{*4}`, the even cubic B-spline on `[-4a,4a]=[-.95,.95]`. Choose the explicit even nonnegative unit-mass bump `ρ(x)=c exp[-1/(1−x²)] 1_{|x|<1}`, and `ρ_ε(x)=ε^(-1)ρ(x/ε)` with `ε=10^-6`. Define

`h=[η(x)cos(Kx)]*ρ_ε`, `g=(∂_x²−1/4)h`.

Then `g` is real even and smooth with support inside `[-.950001,.950001]⊂(-1,1)`. Integration by parts gives **both** pole moments `F_g(±1/2)=0`. With `S(y)=sin y/y`, its exact Fourier transform is

`ĝ(t)=−(t²+1/4)/2 [S(a(t−K))^4+S(a(t+K))^4] ρ̂_ε(t)`.       (1)

The two sinc-fourth powers are nonnegative. Since `ρ_ε` is an even probability density, `|ρ̂_ε(t)|≤1` everywhere and `ρ̂_ε(t)≥1−ε²t²/2` for real `t`. The self-correlation of `g` at `log 7` is zero because its diameter is `<1.901<log7`; this does **not** remove `7` from the mixed `g–v` row.

For either `f=g`, `v`, or their sum, the exact pole-null form has multiplier

`Ψ(t)=H(t)−P(t)`, `H(t)=Re ψ(1/4+it/2)−logπ`,

`P(t)=2Σ_{n∈{2,3,4,5,7}} Λ(n)n^(−1/2)cos(t log n)`.       (2)

Here `Λ(4)=log2`; `n=2,3,4,5,7` are all prime powers below `e²`. The pole terms vanish individually for both inputs. In real bilinear normalization,

`B(g,v)=Γ(g,v)−Σ_n (Λ(n)/√n)[C_{gv}(log n)+C_{vg}(log n)]`,       (3)

where `C_{gv}(s)=∫g(x)v(x+s)dx`. Evenness gives `C_{gv}=C_{vg}`, but (3) displays both orientations. For `n=7`, `C_{gg}=0` whereas `C_{gv}` is supported on a physical overlap of length at most `1+.950001−log7≈.00409`. Thus dropping the `7` cross term would be an algebraic error. Formula (2), rather than an omitted-row approximation, is used for every bound below.

More explicitly, with `r=.950001` and `a_n=Λ(n)/√n`, the **entire arithmetic mixed row** is

`B_prime(g,v)=−2 Σ_{n∈{2,3,4,5,7}} a_n ∫_{−r}^{1−log n} g(x)v(x+log n)dx`.       (3a)

The five upper endpoints are respectively `1−log2≈.30685`, `1−log3≈−.09861`, `1−log4≈−.38629`, `1−log5≈−.60944`, and `1−log7≈−.94591`; every integral has a nonempty interval. Formula (3a) also shows that the prime-square coefficient is `a_4=log2/2` and that `7` enters only through a thin boundary overlap. No bound below discards that thin interval or presumes a sign for its pairing with arbitrary `v`.

## Source-specific band and exact leakage bound

Let `B=[K−10,K+10]∪[−K−10,−K+10]`. An interval evaluation of the **five** explicit cosines in (2) on 400 rational cells of width `1/20` gives

`P(t)<2.60<3` for `1048≤t≤1068`; evenness gives the same on the negative band. The independent [Arb certificate](../../certificates/actual_weil_radius_one_carrier1058_band.py) checks 400 exact-rational cells and returns a largest outward upper endpoint below `2.599315`. [Zhu's Lemma 3.1](https://arxiv.org/html/2608.24827v2) gives `H(t)≥log(t/(2π))−1/t>5` on this band. Therefore `Ψ(t)>2` throughout `B`. By contrast, the universal comb bound `P≤A<5.86` does not give positive `Ψ` at `t≈1058`; the actual arithmetic phases are essential here.

The following elementary bound quantifies the mass outside `B`. Write `N=||g||²_2`, `b=10`, and `E=(1−a²/6)^8`. On `|t∓K|≤1`, `S(a(t∓K))≥1−a²/6`, and `ρ̂_ε(t)≥1−ε²(K+1)²/2=:r_ε>0`. Parseval yields

`N ≥ r_ε² (K−1)^4 E/(2π) > 1.84×10^11`.       (4)

On `B^c`, use `(u+v)²≤2(u²+v²)`, `|S(aξ)|≤1/(a|ξ|)`, and pair the `ξ` and `−ξ` integrals. The odd powers cancel exactly, giving

`(1/2π)∫_{B^c}|ĝ(t)|²dt ≤ (1/(πa^8))[(K²+1/4)²/(7b^7)+(6K²+1/2)/(5b^5)+1/(3b^3)] < 5.64×10^8`.       (5)

The ratio of (5) to (4) is `<.0031<.004`. Globally, the digamma series gives `H(t)≥H(0)>−6`, and `|P(t)|≤A<5.86`; thus `Ψ(t)>−12`. Splitting the exact form over `B` and `B^c` proves

`Q(g)>[2(1−.004)−12(.004)]N=1.944N`.       (6)

No gamma quadrature or finite matrix sign assertion is needed. The inequality `P<3` is the only finite certificate, and it is a direct scalar bound on the literal five-power source.

## Schur absorption against every high-moment profile

The digamma series makes `H(t)` increasing in `|t|`. For completeness, set `w=1/4+it/2` and `z=w+1=5/4+it/2`. Binet's formula and the recurrence give `ψ(w)=log z−1/(2z)−2∫₀∞u/((u²+z²)(e^(2πu)−1))du−1/w`. Both `Re[−1/(2z)]` and `Re[−1/w]` are negative. Also `log|z|≤log(t/2)+25/(8t²)`, `|u²+z²|≥|Im z²|=5t/4`, and `∫₀∞u/(e^(2πu)−1)du=1/24`. Thus the explicit upper bound is actually

`H(t) ≤ log(t/(2π)) + 1/(15t) + 25/(8t²)` for `t>0`.       (7a)

At `T=2500`, `π>25/8` gives `T/(2π)<400`. The degree-16 positive Taylor sum for `e^6` exceeds `403`, so `log400<6−log(403/400)<6−3/403`. The two error terms in (7a) at `T` sum to less than `1/30000`, far below `3/403`. Thus `H(T)<6`, and monotonicity gives `−6<H(t)<6` throughout `|t|≤T`. Since `|P(t)|≤A<5.86`, the claimed `|Ψ(t)|<12` is rigorous. For `|t|≥T`, (7a) is less than `log(|t|/(2π))+1/|t|`, so `0<Ψ(t)<log|t|+6≤|t|/100`. The final inequality holds at `T` because `log2500<8`, and its right-minus-left difference increases thereafter. The looser bound `46/(15t)+25/(8t²)` results if the two favorable recurrence terms are bounded by their complex magnitudes `1/t` and `2/t` instead of dropped by sign; the earlier `53/(8t²)` bound is also valid but unnecessary.

Let `G=(1/2π)∫_{|t|≥T}Ψ(t)|ĝ(t)|²dt`. From (1), for `t≥T` and `δ=1−K/T=.5768`,

`|ĝ(t)| ≤ C/t²`, `C=(1+1/(4T²))/(a^4 δ^4)<2840`.

Thus `G≤C²/(200πT²)<.0021`, and (4) gives the much stronger relative bound `G/N<1.2×10^-14`. This includes every prime-power contribution through `Ψ`.

Split `B(g,v)` at `T`. On the low band, Cauchy and the `V` leakage estimate give

`|B_low(g,v)| ≤ 12√θ √N ||v||_2 ≤ .012√N ||v||_2`.       (7)

On the high band, `Ψ>0` and Cauchy give `|B_high|≤√(G Q_high(v))`. Young's inequality yields `2|B_high|≤(1/2)Q_high(v)+2G`. Also `Q_high(v)≥.12(1−θ)||v||²` and `Q_low(v)>−12θ||v||²`. Combining (6) and (7), for every real scalar `c` and every `v∈V`, gives

`Q(cg+v) > (1.944−2.4×10^-14)c²N + (.06−.00001206)||v||² − .024|c|√N||v||`.

To make the Young allocation unambiguous, put `a=|c|√N` and `b=||v||_2`. Then `2√(.020·.0072)=.024`, so `.024ab≤.020a²+.0072b²`. The `.020` loss is subtracted from the **low-mode** coefficient `1.944−2.4×10^-14`, leaving more than `1.9239`. The `.0072` loss is subtracted from the **tail** coefficient `.06−.00001206`, leaving more than `.0527`. Hence the fully quantified enlarged-space bound is

`Q(cg+v) ≥ 1.9 c²||g||² + .05||v||²`, with strict inequality unless `c=0` and `v=0`.       (8)

This is a genuine uniform positive inequality on `span_R{g}+V`. Since `||cg+v||²≤2(c²||g||²+||v||²)`, it also gives `Q(cg+v)≥.025||cg+v||²`. It is not a finite-matrix equivalence: the arbitrary infinite-dimensional `v` enters through a proven band-leakage estimate and the complete signed symbol. The mixed `7` row is retained. The direct sum is strict because `g` has more than 99.6% of its mass below `2500`, whereas every nonzero `v∈V` has less than `10^-6` there. The full off-axis bilateral zero product remains `F_f(z)overline(F_f(−bar z))`, and (8) supplies no RH or `CoarsePrimitiveBound` implication.

## Formal and computational scope

The [Arb certificate](../../certificates/actual_weil_radius_one_carrier1058_band.py)
encloses every logarithm, square root, and cosine in the complete five-power
comb on `[1048,1068]` and checks the displayed numerical margins. The exact
`log n<2` prime-power list and its weighted von Mangoldt row are kernel checked
in [ActualWeilPrimeList.lean](../../formalization/BuildingBlocks/ActualWeilPrimeList.lean).
The conditional scalar Schur and Cauchy reduction is kernel checked in
[ActualWeilRankOneSchur.lean](../../formalization/BuildingBlocks/ActualWeilRankOneSchur.lean).
Lean includes a fifth slot for the `n=7` mixed term, but assumes its
identification with the actual arithmetic row. The named analytic hypotheses
include (4)–(7); the Weil formula, Binet estimate, smooth carrier construction,
spectral leakage, and identification of the finite row with the Weil multiplier
remain written arguments. Those
steps were checked independently. The theorem applies only to the displayed
restricted subspace; it does not imply positivity on all compact supports or RH.
