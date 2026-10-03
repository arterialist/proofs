# An explicit bound for low Möbius cofactor energy

The actual Möbius cofactor coordinates admit an explicit low-coordinate bound that vanishes when the cutoff is the square root of the ambient scale. This is a direct corollary of [Ramaré–Zuniga-Alterman, *On a Möbius double sum*, arXiv2603.25961v3](https://arxiv.org/pdf/2603.25961v3), Lemmas 2.6, 4.5(iii) and 4.13. Their arithmetic inputs are retained with their variable-modulus factors; finite Minkowski supplies the comparison.

For real \(X\ge1\) and positive integers \(q\), define

$$
 a_q(X)=\sum_{\substack{1\le d\le X\\q\mid d}}\frac{\mu(d)}d,
 \qquad
 m_q(Y)=\sum_{\substack{1\le n\le Y\\(n,q)=1}}\frac{\mu(n)}n,
 \qquad
 E(X,D)=\sum_{1\le q\le D}\varphi(q)a_q(X)^2.
$$

Every cutoff uses its literal integer floor. Multiplicativity gives

$$a_q(X)=\frac{\mu(q)}q m_q(X/q).$$

For nonsquarefree \(q\), both sides vanish; for squarefree \(q\), noncoprime cofactors have zero Möbius coefficient. The unit is included.

Put \(\varphi_s(q)=q^s\prod_{p\mid q}(1-p^{-s})\), \(\xi=1-1/\log(10^{12})\), and

$$
 A_q=\frac{g_0(q)\sqrt q}{\varphi_{1/2}(q)},\qquad
 B_q=\frac{g_2(q)q^\xi}{\varphi_\xi(q)}.
$$

Both \(g\) factors equal one for odd \(q\). For even \(q\), they are respectively \(\sqrt3(\sqrt2-1)/2\) and \(2.9506(1-2^{-\xi})\). These Euler factors are not replaced by uniform constants.

## Explicit estimate

For every real pair \(1\le D\le X/10^{12}\),

$$
 E(X,D)\le H(X,D):=
 \left[
 \sqrt{\frac{4.2412D}{X}}
 +\frac{0.010032\sqrt{1.6385\log D+1.2943}}{\log(X/D)}
 \right]^2.
 \tag{1}
$$

The source's printed Lemma 5.1 gives

$$B_{\rm old}(X,D)=4.2411D/X+0.004\sqrt{D/X}+0.0001$$

for \(X\ge D>0\). Consequently \(E\le\min\{B_{\rm old},H\}\) throughout the range of (1). The minimum preserves the better estimate where neither formula dominates globally.

## Proof

Write \(c_0=0.010032\). The \(Y\ge10^{12}\) branch of Lemma 2.6 gives

$$
 |m_q(Y)|\le A_q\sqrt{2/Y}
 +\frac{c_0B_q}{\log Y}.
 \tag{2}
$$

Here \(q\le D\le X/10^{12}\), so every argument \(Y=X/q\) is at least \(10^{12}\). Its logarithmic denominator is positive, including the boundary equality. Define nonnegative finite vectors

$$
 u_q=\frac{|\mu(q)|\sqrt{\varphi(q)}}q A_q\sqrt{2q/X},
 \qquad
 v_q=\frac{c_0|\mu(q)|\sqrt{\varphi(q)}B_q}{q\log(X/q)}.
$$

Equation (2) and the exact coordinate identity imply \(\sqrt E\le\|u\|_2+\|v\|_2\). Lemma 4.5(iii) supplies

$$
 \|u\|_2^2
 =\frac2X\sum_{q\le D}
 \frac{\mu(q)^2g_0(q)^2\varphi(q)}{\varphi_{1/2}(q)^2}
 \le\frac{4.2412D}{X}.
$$

The coefficient is exactly \(2\cdot2.1206\). For the other vector, \(\log(X/q)\ge\log(X/D)>0\). Lemma 4.13 states

$$
 K_2(D)=\sum_{q\le D}\frac{\mu(q)^2\varphi(q)B_q^2}{q^2}
 \le c_2\log D+1.2943,\qquad c_2<1.6385.
$$

Since \(D\ge1\),

$$
 \|v\|_2^2\le
 \frac{c_0^2(1.6385\log D+1.2943)}{\log^2(X/D)}.
$$

Squaring the nonnegative Minkowski bound proves (1). No fixed-\(q\) limit, discarded Euler factor or square-root-only extrapolation is used.

## Square-root cutoff

For every real \(X\ge10^{24}\), \(D=\sqrt X\) is admissible and

$$
 E(X,\sqrt X)\le
 \left[\sqrt{4.2412}X^{-1/4}
 +\frac{0.020064\sqrt{0.81925\log X+1.2943}}{\log X}\right]^2
 <6.3\cdot10^{-6}.
 \tag{3}
$$

Here is a conservative numerical proof valid on the entire range. The positive atanh series, retaining three terms for \(\log2\) and six for \(\log5\), gives \(\log10>52313986/22733865>2.3\); hence \(L=\log X>55.2\). The function \(\sqrt{0.81925L+1.2943}/L\) decreases for \(L>0\), since its square is \(0.81925/L+1.2943/L^2\). Also \(\sqrt{4.2412}<2.06\) and \(\sqrt{46.5169}<6.83\). Thus the bracket in (3) is less than

$$2.06\cdot10^{-6}+0.020064\frac{6.83}{55.2}<0.002485,$$

whose square is \(6.175225\cdot10^{-6}<6.3\cdot10^{-6}\). Printed \(B_{\rm old}(X,\sqrt X)\ge0.0001\), so (3) strictly improves that printed bound for every \(X\ge10^{24}\). The new allowance tends to zero as \(O(1/\log X)\); this is an upper rate, not an asymptotic equality for \(E\).

## Verification scope

The [Lean 4.24 companion](../../formalization/BuildingBlocks/ActualMobiusCoprimeHarmonic.lean) proves `multipleHarmonic_eq_coprime` for every natural cutoff and positive label, including nonsquarefree labels and the zero cutoff. `multipleHarmonicReal_eq_coprime` proves the exact dictionary for every real cutoff. These identities use Mathlib's actual Möbius function.

`lowCofactorEnergy_le_of_source_estimates` checks (1) for the full real range under three explicit propositions: `SourcePointwiseEstimate`, `SourceRootMeanEstimate D` and `SourceLogMeanEstimate D`. Their definitions retain the actual coprime sum, Euler factors and numerical constants. The source arithmetic estimates are not proved in this Lean module. The unconditional inequality above uses the cited literature inputs and the written proof; it is not claimed as an unconditional kernel-checked analytic theorem. The logarithm-series proof and the continuous square-root-cutoff estimate (3) also remain written analysis.

The [verification record](../../formalization/verification/actual-mobius-coprime-harmonic/README.md) identifies the source, toolchain, audit declarations and acceptance evidence. Upstream computational verifications were not reproduced in this work.

This explicit corollary can be used for truncated coprime Möbius or mollifier-coordinate energy. All arithmetic inputs belong to the cited authors. No novelty claim is made. The estimate supplies no full signed prime-error or RH bound.
