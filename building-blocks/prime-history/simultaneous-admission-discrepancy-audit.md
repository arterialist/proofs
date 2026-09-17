# Audit of the claimed simultaneous admission discrepancy expansion

This note audits a proposed uniform simultaneous-limit expansion and separates its exact finite algebra from its still-unproved analytic remainder estimate.

## Definition match and normalization

The exact sequence energy identity is correct:

\[
 (1-q)\sum_{j\ge1}\left|q^{-j/2}\sum_{n\ge j}a(n)q^n\right|^2
 =\sum_{m,n\ge1}a(m)\bar a(n)(q^{\max(m,n)}-q^{m+n}).
\]

With `c_X(n)=mu(n) 1_{(n,X#)=1}` and the dilation convention in the note, expansion of
`c_{X,P}=sum_{d|P#} mu(d) D_d c_X` gives an induced divisor kernel

\[
 K_X(d,e)=\frac{\log^2X}{X^2}
 \langle D_dc_X,D_ec_X\rangle_{V_q}.
\]

Then its finite energy is exactly the complete actual Möbius packet sum. The limiting kernel for the note's `E_P` is **`2 K_G`**, not `K_G`, because the note defines `E_P=2||F_P||^2`. This factor is stated explicitly in [FixedProfileGreenTwoParameter.lean](../../formalization/BuildingBlocks/FixedProfileGreenTwoParameter.lean). The admission-increment module uses unscaled `K_G` because its outer doubled-energy convention already supplies the factor two; the two uses must not be conflated.

The new Lean module proves, with no omitted faces,

\[
 B(X,P)=\sum_{d,e\mid P#}\mu(d)\mu(e)[K_X(d,e)-2K_G(d,e)],
\]

once the analytic induced kernel above is supplied. It also proves that the admission discrepancy is the complete `kernelIncrement` of the kernel error, retains strict lower and upper old rows, and telescopes exactly in either parameter.

## Internal checks on the proposed asymptotic

The leading density correction has the stated sign and factor. For `L=log X`,

\[
 \frac{L}{L+\log v}=1-\frac{\log v}{L}
 +\frac{(\log v)^2}{L(L+\log v)},
\]

and

\[
 e^y\int_{\max(1,y/d)}^\infty e^{-2dv}\,dv=G_d(y).
\]

Thus the normalized non-endpoint row is `-F_P+J_P/L+R`, and the sampled norm tends to `2||.||²`; its cross term is consequently
`-4 <F_P,J_P>/L`. That constant is consistent.

The endpoint threshold is also arithmetically consistent. The absolute estimate gives

\[
 \eta_{X,P}\ll L X^{-3/2}
 \exp\{(\vartheta(P)+\pi(P)\log4)/2\}.
\]

Using `theta(P)=P+o(P)` and `pi(P)=o(P)`, `P<=(3-eta)L` makes this at most `X^{-c_eta}` for some `c_eta>0` (one may take any sufficiently small constant below `eta/2` after increasing `X`). The constant `3` comes from the `X^{-3/2}` normalization and is not a sign theorem beyond that range.

## Unproved analytic step

The displayed uniform remainder estimate (20) is not derived from any previously available fixed-divisor convergence theorem. It combines four new uniform assertions:

1. PNT partial summation uniformly after every dilation and moving ceiling;
2. an absolutely summable second-log-moment envelope after summing all divisor faces;
3. a uniform sampled-to-continuous Green norm error, including every derivative jump;
4. an exponentially small bound for the complete `X`-rough composite tail after all dilations.

The note sketches why each should be plausible, but supplies no detailed inequalities with common constants and no cited theorem that implies their combination. In particular, the earlier fixed-`d` limit cannot justify (20), even for `P<=c log X`. Therefore formula (27) and the uniform conclusion (29) should currently be treated as a proposed analytic theorem, not as an established consequence of the repository's prior convergence results.

There is no algebraic counterexample to the formula: its exact kernel normalization, `1/log X` correction, endpoint norm, and threshold below `3 log X` are mutually consistent. The missing obligation is a proof of the uniform remainder and sampling bounds. Until that is supplied, the only unconditional simultaneous statement is the complete finite kernel-error/telescoping decomposition formalized here. No conclusion for natural `P` comparable to `X` follows.
