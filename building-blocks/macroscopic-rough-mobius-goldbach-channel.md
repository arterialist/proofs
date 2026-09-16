# Macroscopic rough Möbius packet in the additive Goldbach source

**Status:** written analytic proof by RH Agent2, independently audited by RH Proof. The macroscopic cancellation is unconditional; its RH-scale remainder is not bounded.

Fix `1/2≤α<1`, a large real horizon `X`, and `z=X^α`. Set `μ_sm(d)=μ(d)1_{P⁺(d)≤z}` and `μ_late(d)=μ(d)1_{P⁺(d)>z}`. Dirichlet convolution with `log` gives the exact complete-power identity

`Λ=μ*log=(μ_sm*log)+(μ_late*log)`.

For `n≤X`, at most one prime factor of `n` can exceed `z`; it occurs to the first power. Write `n=pm`, where `p>z` and `m≤X/p<z`. Every divisor with a prime factor above `z` is `pd`, `d|m`, and `μ(pd)=−μ(d)`. Hence

`(μ_late*log)(n)=−Σ_{d|m}μ(d)log(m/d)=−Λ(m)` when `n=pm`,

and `(μ_late*log)(n)=0` when no such `p` exists. In particular it vanishes at the large prime `p` itself because `Λ(1)=0`. There is no loss of prime powers: `m` may be any prime power, and its exact `Λ(m)` appears.

Define the nonnegative finite-horizon channel `B_z(n)=−(μ_late*log)(n)` and `A_z(n)=(μ_sm*log)(n)=Λ(n)+B_z(n)` for `n≤X`. Then

`B_z(n)=Σ_{p>z,\,pm=n}Λ(m)≥0`, `A_z(n)≥0`, and `Λ=A_z−B_z` on `[1,X]`.      (1)

This decomposition separates new large-prime arrivals from their
composite histories exactly. At a prime $n=p>z$, $B_z(p)=\Lambda(1)=0$
and $A_z(p)=\log p$. At a composite $n=pm\le X$ with $p>z$ and
$m>1$, one has $\Lambda(n)=0$, so $A_z(n)=B_z(n)=\Lambda(m)$:
the complete cofactor history cancels coefficientwise. This
classification alone does not control how often the large primes
arrive.

The total negative correction is

`B_z^Σ(X):=Σ_{n≤X}B_z(n)=Σ_{z<p≤X}ψ(X/p)`.

The PNT and prime harmonic sum give, for fixed `α`,

`B_z^Σ(X)=(log(1/α)+o(1))X`.                                      (2)

Indeed, for any `0<δ<1−α`, the range `z<p≤X^(1−δ)` has `ψ(X/p)=(1+o_δ(1))X/p` uniformly. Its prime reciprocal sum tends to `log((1−δ)/α)`. The remaining primes contribute at most `CXΣ_{p>X^(1−δ)}1/p=O(δX)` by `ψ(u)≤Cu`; let `δ↓0`. The same proof gives `Σ_{n≤xX}B_z(n)=(log(1/α)+o(1))xX` for each fixed `0<x≤1`. Consequently the positive channel has total `Σ_{n≤X}A_z(n)=(1+log(1/α)+o(1))X`.

Let `h=log(1/α)`. In the ordered additive Goldbach triangle `a+b≤X`, the distributional limits of these positive measures give

`Σ_{a+b≤X}A_z(a)A_z(b)=[(1+h)²/2+o(1)]X²`,

`Σ_{a+b≤X}A_z(a)B_z(b)=[h(1+h)/2+o(1)]X²`,

`Σ_{a+b≤X}B_z(a)B_z(b)=[h²/2+o(1)]X²`.                (3)

For a direct justification, rescale each coefficient measure by `1/X` onto `[0,1]`. The cumulative limits above and PNT imply weak convergence to `(1+h)du` and `hdu`; their product measures converge on the triangle because its boundary has zero limiting measure. Expanding `Λ=A_z−B_z` in the additive square, the three leading terms combine as

`(1+h)²/2 − h(1+h) + h²/2=1/2`.

Thus the macroscopic rough Möbius packet becomes a *negative* additive prime-power correction whose positive-channel Goldbach square, negative cross, and correction square cancel at order `X²`. This is an exact coupling constraint. It does not control their residual at `X^(3/2+ε)`, and it applies only at `z=X^α≥√X`; it does not establish the critical log-squared rough–smooth sign or RH.
