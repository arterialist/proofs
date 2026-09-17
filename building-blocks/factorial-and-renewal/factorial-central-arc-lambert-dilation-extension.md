# Lambert dilation extends the paid central clock with a logarithmic loss

This independently reviewed written proof uses the exact Lambert expansion and angular dilation to extend the central-arc payment from

T_H=1/[sqrt(H) log(4X)]

to t≤H^(-1/2), at the cost of log²(4H). Thus the complete actual successor series has central mass

O[(X/H)log²(4H)]

on this larger physical clock. This is O_ε(X^(1+ε)/H), but it is not the constant-times-X/H estimate. The remaining clock t>H^(-1/2) still requires short-interval Möbius cancellation.

Fix X≥2, sqrt(X)≤H≤X, r=exp(-1/X), q=exp(-t), and u=1-q. The exact Lambert expansion is

H_t(re^(iθ))
 =u Σ_(a≥1) q^(a-1) S_(X/a)(aθ),                       (1)

where

S_Y(φ)=Σ_(d≥1) μ(d) exp(-d/Y) exp(idφ).

The parameter notation is exact because r^(ad)=exp[-d/(X/a)]. Every coefficient and endpoint from the successor formula remains in (1).

For a≤H, change variables φ=aθ. Full-circle Parseval gives

J_a:=(2π)^-1∫_(|θ|≤1/H)|S_(X/a)(aθ)|²dθ
 ≤ a^-1 Σ_(d≥1)exp(-2ad/X)
 ≤ C X/a².                                                 (2)

The factor a^-1 from angular dilation is essential. Equivalently, apply the Gallagher inequality at ambient scale

Y=X/a

and interval length

L=H/a.                                                         (3)

The elementary short-interval estimate G_Y(L)≪YL² gives

J_a ≤ C a^-1 L^-2 G_Y(L)
     ≤ C X/a²,                                              (4)

which agrees with (2). Formula (3) quantifies the actual short-Möbius interval demanded by each cofactor fiber.

Minkowski's inequality in angular L², applied to (1) and (2), yields for the fibers a≤H

[(2π)^-1∫_(|θ|≤1/H)|H_t(re^(iθ))|²dθ]^(1/2)
 ≤ C sqrt(X) u Σ_(a≤H)q^(a-1)/a.                       (5)

The complete positive sum has the exact value

u Σ_(a≥1)q^(a-1)/a
 =(e^t-1)[-log(1-e^(-t))].                                    (6)

For 0<t≤1 this is O[t log(2/t)]. Hence the square of (5) is

O[X t² log²(2/t)].                                          (7)

The omitted fibers a>H are harmless on the clock considered below. Full-circle Parseval without angular dilation gives

[(2π)^-1∫_(|θ|≤1/H)|S_(X/a)(aθ)|²dθ]^(1/2)
 ≤ C sqrt(X/a).

Their total contribution to the norm in (5) is at most

C sqrt(X/H) q^H,                                               (8)

up to an absolute factor when t≤1. On the interval

T_H≤t≤H^(-1/2),

one has tH≥sqrt(H)/log(4X), so (8) is exponentially smaller than (5), apart from finitely bounded X which can be absorbed into the constant.

Now retain the full original physical weight. Since w(t)≤1/(2t), equations (7)-(8) give

(2π)^-1∫_(|θ|≤1/H)∫_(T_H)^(H^(-1/2))
 |H_t(re^(iθ))|²w(t)dt dθ
 ≤ C X ∫_0^(H^(-1/2)) t log²(2/t)dt
 ≤ C (X/H)log²(4H).                                      (9)

The tail-fiber contribution from (8) is smaller than the same right side, since its clock integral is bounded by

(X/H)∫_(T_H)^∞ exp(-2Ht)dt/t,

and HT_H=sqrt(H)/log(4X). The lower part 0<t<T_H cannot be estimated by (8), whose crude tail bound loses the cancellation among a>H. It was already bounded by CX/H in `factorial-central-arc-low-clock-short-block-bound.md`. Combining that result with (9) pays the immediate complement

T_H<t≤H^(-1/2)                                                (10)

with the displayed logarithmic loss. All angular and physical endpoints are common before integration.

The exact short-interval condition needed to remove this loss is also visible. Suppose, uniformly for the active dilations a≤H, that

G_(X/a)(H/a) ≪_ε (X/a)^(1+ε)(H/a).                     (11)

Then Gallagher in (4) gives

J_a ≪_ε X^(1+ε)/H

up to harmless powers of a that only improve the geometrically weighted sum. Since the Lambert weights p_a=u q^(a-1) are positive and sum to one, Minkowski would give the same scale for the whole field at each t. Integrating w(t) from a lower cutoff contributes only a logarithm, absorbable into X^ε. Thus the short-interval square-root estimate (11) would pay a much larger part of the complement.

For the fibers carrying most Lambert weight, a is of order 1/t. Their required parameters are

Y≈Xt,
L≈Ht,
L/Y=H/X.                                                       (12)

At the new boundary t=H^(-1/2), the missing intervals have length L≈sqrt(H) inside ambient scale Y≈X/sqrt(H). As t increases, both scales grow proportionally. The unresolved correlation is therefore not confined to one fixed interval length; it follows the dilation ray L/Y=H/X.

With only the elementary estimate G_Y(L)≪YL², (4) is sharp enough to give (9) but no farther local-density payment. For t>H^(-1/2), integrating (7) already exceeds X/H by more than logarithms if the endpoint grows by a power of H. Advancing on that clock requires an improvement over the elementary short-Möbius mean square along (12), or cancellation between different dilations not supplied by Minkowski. No RH, Chowla, Mertens, or generic-independence assumption is made, and no full central-arc bound follows.

## Contribution to the divided central consumer

Take dyadic angular shells |θ| comparable with 1/H, from H=X down to H=sqrt(X), and use the inner arc for H=X. With the fixed original radius r=exp(−1/X), the reciprocal denominator is pointwise O(H²) on such a shell and O(X²) on the inner arc.

Multiplying (9) and its paid lower-clock companion by this pointwise cost gives O[XH log²(4H)] per shell. The H values form a decreasing geometric sequence, so the curved region

|θ|≤X^(−1/2),
0<t≤sqrt(max(|θ|,X^(−1)))

contributes at most O(X²log²X) to the exact divided central Poisson consumer. This is O_epsilon(X^(2+epsilon)), the permitted scale. The region above this curved boundary is the remaining central-clock problem.

An earlier draft incorrectly multiplied the numerator mass by an integrated denominator weight and claimed O(X log³X). The corrected argument above uses the required pointwise O(H²) shell bound. No Lean formalization or full central-arc/RH conclusion is asserted.
