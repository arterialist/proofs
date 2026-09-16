# Angular Poisson reduction for the factorial energy

## Status and attribution

This is an independently reviewed written reduction for the actual factorial response. The coordinator derived the Hilbert-valued Parseval, outer-arc, and Poisson-variance identities; a bounded worker independently checked every constant, radius, and domain. The linear birth-variation input is compiled elsewhere. The central-arc upper estimate remains unproved, so this is neither an RH proof nor a Lean formalization of the analytic passage. Parseval, Poisson variance, and Green's identity are classical tools; no novelty certificate is claimed.

## Exact full-clock circle representation

Use the original Hilbert space

    H = L²((0,∞), w(t)dt),

with actual responses g_N, complete births h_n=g_n−g_(n−1), and energies Q_N=||g_N||². The written and partially compiled birth analysis gives

    V(Y)=Σ_(n≤Y)||h_n||² ≤ C₀Y,    C₀=27/4.

Every Möbius divisor history and the compensated clock weight remain in these vectors. Define, for |z|<1,

    H(z)=Σ_(n≥1)h_n z^n,
    G(z)=H(z)/(1−z)=Σ_(N≥1)g_Nz^N.

For an integer X≥1 put r=exp(−1/X), ρ=r², and

    E_X=Σ_(N≥1)ρ^NQ_N.

Hilbert-valued Parseval gives exactly

    E_X=(1/2π)∫_(-π)^π ||H(re^(iθ))||² / |1−re^(iθ)|² dθ.       (1)

Positive Abel summation of the birth squares gives

    (1/2π)∫_(-π)^π ||H(re^(iθ))||²dθ
      =Σ_(n≥1)ρ^n||h_n||²
      =(1−ρ)Σ_(k≥1)ρ^kV(k)
      ≤C₀ρ/(1−ρ)≤27X/8.                                      (2)

No sign or absolute bound is imposed on individual escaped LCM pairs.

## The outer arc is paid unconditionally

For |θ|≤π,

    |1−re^(iθ)|²≥4rθ²/π².

Consequently the contribution to (1) from |θ|≥Δ is at most

    27π²X/(32rΔ²).

Taking Δ=X^(−1/2) and r≥e^(−1) proves the audited bound

    E_X−A_X≤(27π²e/32)X²,                                  (3)

where

    A_X=(1/2π)∫_(|θ|<X^(-1/2))
          ||H(re^(iθ))||²/|1−re^(iθ)|²dθ.                   (4)

Also ρ^N≥e^(−4) for X≤N<2X, so

    Σ_(X≤N<2X)Q_N≤e^4E_X.                                  (5)

Thus the precise remaining sufficient target is

    A_X=O_epsilon(X^(2+epsilon))

for every epsilon>0. Equations (3) and (5) would then give the required dyadic energy scale. The companion terminal-obstruction and Abel–Mertens notes prove conversely that this central target already implies RH. It has not been proved here.

## Exact mean and missing variance

Let

    P_r(θ)=(1−r²)/|1−re^(iθ)|².

Its nth Fourier moment is r^n. Since the boundary coefficient of H(re^(iθ)) is h_nr^n, its Poisson mean is exactly H(r²), not H(r). Hilbert-space variance therefore gives

    E_X=||H(r²)||²/(1−r²)
      +(1/2π)∫_(-π)^π
        ||H(re^(iθ))−H(r²)||²/|1−re^(iθ)|²dθ.              (6)

There is no cross term and both terms are nonnegative. The positive-real Lambert–Mellin estimate controls a radial mean; it does not bound the second term in (6).

The variance also has the exact Green representation. In the disk |z|<r, with a=r², set

    G_r(a,z)=log |(r²−conj(a)z)/(r(z−a))|.

Then the variance in (6), multiplied by 1−r², equals

    (2/π)∫_(|z|<r)G_r(r²,z)||H'(z)||²dArea(z).              (7)

The factor 2/π is for ordinary Euclidean area, and a=r² lies inside the radius-r disk. Any geometric argument must estimate this Green-weighted actual derivative rather than an unweighted substitute.

## Why a full derivative estimate cannot close the target

The linear birth budget implies the full-circle upper estimate

    (1/2π)∫||∂_θH(re^(iθ))||²dθ
      =Σn²r^(2n)||h_n||²≤(27/e²)X³.                        (8)

The X³ scale is not an artifact. For each prime p,

    h_p(t)=(1−e^(−t))(e^(−(p−1)t)−1),

so on a fixed hard-clock tail its original weighted norm is bounded below by a positive constant. Classical prime counting on [X,2X] then makes the sum in (8) at least a constant times X³/log X. Hence a generic O(X²) full-derivative strategy fails even under RH. Only the central angular mass, a Green-weighted variance, or another source-specific signed correlation can supply the missing gain.

The exact finite sinc module formalizes the algebra obtained by expanding a finite version of (4), including the paid prime diagonal. Its analytic limit and signed off-diagonal bound remain open. The terminal obstruction identifies an independent hard-clock Mertens reserve inside the same central arc. Together these results locate the remaining arithmetic problem without replacing it by radial positivity or a truncated composition expansion.
