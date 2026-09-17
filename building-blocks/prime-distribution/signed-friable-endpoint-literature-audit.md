# Signed friable endpoint extension: source audit

## Result

The cited de la Bretèche–Tenenbaum bound does control the **endpoint packet** throughout every fixed-power range

\[
P\le X^{1/2-\varepsilon}.
\]

Together with the corrected sign-free range, it covers every smaller `P`. It does **not** currently prove the corresponding full-energy statement, because the separate uniform non-endpoint expansion used in the repository remains unproved.

The source is de la Bretèche and Tenenbaum, [*Friable averages of oscillating multiplicative functions*, arXiv:2207.04777v14](https://arxiv.org/abs/2207.04777), especially [Theorem 1.2 and Corollary 1.3, pp. 3–4](https://arxiv.org/pdf/2207.04777#page=4). The arXiv record shows that v14 is dated 20 July 2024, later than the cited 2023 proceedings version, so this audit uses the current statement.

## Exact object and source notation

The paper defines

\[
M(x,y;f)=\sum_{\substack{n\le x\\P^+(n)\le y}}f(n).
\]

For `f=μ`, the repository's quantity is therefore exactly

\[
M(t,P)=M(t,P;\mu)
=\sum_{\substack{n\le t\\P^+(n)\le P}}\mu(n).
\]

Because `μ(n)=0` unless `n` is squarefree, the surviving integers are precisely the divisors of the product of all primes at most `P`. Thus this is the same divisor convention as `d∣P#`; `P` is the friability cutoff, not the primorial itself.

The endpoint is also exactly the packet audited earlier:

\[
v_d(j)=1_{j\le d}q^{d-j/2},\qquad
E_{X,P}(j)=\sum_{d\mid P^\#}\mu(d)v_d(j),
\qquad q=e^{-2/X}.
\]

Its energy normalization is unchanged:

\[
\frac{\log^2X}{X^2}(1-q)\sum_{j\ge1}|E_{X,P}(j)|^2.
\]

## What Corollary 1.3 actually says

The source's uniformity region is

\[
G_\beta:\quad x\ge3,
\qquad \exp\{(\log x)^{1-\beta}\}\le y\le x,
\]

with fixed positive parameters satisfying `β+δ<3/5`. For the Möbius function, `κ=1`. If

\[
y^\ell<x\le y^{\ell+1},
\]

Corollary 1.3 states, **in all cases**, the bound

\[
\boxed{
|M(x,y;\mu)|\le C_{\beta,\delta,c}\,
\frac{x}{(\log y)^{\min(2,\ell)}}.}
\]

The phrase “in all cases” follows the source's description of the correction terms near shrinking neighborhoods of integer `u=log x/log y`. Hence the bound retains the transition terms. Away from those neighborhoods the leading Möbius term is proportional to

\[
\frac{x}{(\log y)^2}\omega'(u).
\]

Near the first integer layers, Theorem 1.2 adds the explicit `U_J` or `X_ℓ` terms. They cannot be discarded in an asymptotic expansion, but they are already absorbed by the displayed all-cases upper bound.

For the two layers needed here this gives

\[
|M(t,P)|\le C_1\frac{t}{L}\qquad(P<t\le P^2),
\qquad
|M(t,P)|\le C_2\frac{t}{L^2}\quad(t>P^2),
\qquad L=\log P,
\]

provided `(t,P)∈G_β`. For `t≤P`, friability is void and `M(t,P)` is the ordinary Mertens prefix.

## Uniformity up to the Abel cutoff

Take

\[
T=X\log X,qquad R=\log X.
\]

The worst source-range condition over `P≤t≤T` is

\[
L\ge(\log T)^{1-\beta}.
\]

Since `β+δ<3/5` is strict, one may choose any fixed `η>0` and parameters with `1-β<2/5+η`. Therefore the source applies whenever, for example,

\[
L\ge R^{2/5+\eta}.
\]

The repository's condition `L/√R→∞` is valid but stronger than needed. All implicit constants are uniform in `t` and `P` after `β,δ,c` and the fixed function `μ` have been chosen.

## Exact Stieltjes formula and bounds

Put `λ=2/X`. The signed weighted tail is

\[
S(j)=\sum_{\substack{d\mid P^\#\\d\ge j}}\mu(d)e^{-\lambda d}.
\]

Right-continuous Stieltjes summation, with the left prefix `M(j-1,P)`, gives

\[
\boxed{
S(j)=-e^{-\lambda j}M(j-1,P)
+\lambda\int_j^\infty e^{-\lambda t}M(t,P)\,dt.}
\]

The sign and endpoint are correct. The upper boundary vanishes because the finite total Möbius sum over all divisors of a nontrivial primorial is zero. The companion Lean module proves the exact finite discrete identity, including both boundary terms before imposing total sum zero.

Let

\[
U=P^2,qquad \alpha=UL/X=P^2\log P/X.
\]

Assume `α→0`. The first-layer boundary obeys

\[
\frac{U}{L}=\frac{\alpha X}{L^2}.
\]

Its integral contributes at most

\[
\frac{2C_1}{XL}\int_P^U t\,dt
\le \frac{C_1U^2}{XL}
=\frac{C_1\alpha^2X}{L^3}.
\]

The second and later layers contribute, using the full integral as a majorant,

\[
\frac{2C_2}{XL^2}\int_0^\infty te^{-2t/X}\,dt
=\frac{C_2X}{2L^2}.
\]

The ordinary range `t≤P` is smaller under the same condition; the classical zero-free-region estimate gives still more decay. The absolute tail beyond `T` is

\[
\frac2X\int_T^\infty te^{-2t/X}\,dt
=e^{-2T/X}(T+X/2)
=e^{-2R}(XR+X/2).
\]

Consequently, with a constant depending only on the fixed source parameters,

\[
|S(j)|\le C\frac{X}{L^2}\qquad(j<U),
\]

and

\[
|S(j)|\le
C e^{-2j/X}\frac{j+X}{L^2}
+O(XR e^{-2R})qquad(U\le j\le T).
\]

Since `E(j)=e^{j/X}S(j)` and `1-e^{-2/X}≤2/X`, splitting the square sum at `U` gives

\[
\boxed{
\frac{R^2}{X^2}V_{\rm end}(X,P)
\le C'
\left{
\frac{R^2}{L^4}
+\frac{P^2R^2}{XL^4}
+R^2e^{-2R}
\right}.}
\]

The constants are absolute after the paper's parameters are fixed. The first term is the Abel-effective range, the second is the number of early indices, and the third is the geometric tail.

## The claimed square-root range

If `P≤X^{1/2-ε}` with fixed `ε>0`, then

\[
\frac{P^2L}{X}\le X^{-2\varepsilon}R\to0.
\]

If `L` also lies above `R^{2/5+η}`, the cited theorem proves endpoint decay directly. If it does not, then it lies far inside the already proved sign-free range

\[
L\le \rho R\frac{W(2s)}{2s}
\]

for any fixed `ρ<1` once `X` is large. More precisely, choose one fixed `ρ`; values above that sign-free threshold automatically satisfy `L/R^{2/5+η}→∞`, while values below it are sign-free. Thus the two endpoint estimates overlap and cover every `P≤X^{1/2-ε}`.

This confirms the endpoint-only extension.

## Why the full-energy conclusion does not follow

The vectors, normalization, and `P` convention exactly match the simultaneous-expansion note. The first unmatched term is its asserted uniform non-endpoint estimate

\[
\left\|\sum_{d\mid P^\#}\mu(d)R_{d,\bullet;X}\right\|_{G,X}
\ll
R^{-2}+e^{-c\sqrt R}+R^3/X.
\]

No proof is supplied for the packet-independent second-log envelope after every dilation and moving ceiling. The claimed uniform sampled-Green comparison, derivative-jump control, and rough-composite tail are downstream parts of the same gap. The friable endpoint theorem does not estimate this non-endpoint remainder.

Accordingly:

- **Yes:** the endpoint is negligible for every `P≤X^{1/2-ε}` by the union of sign-free and signed-friable bounds.
- **No:** the currently written arguments do not prove the complete energy expansion on that range.
- The earlier complete-range statement `P≤(3-η)log X` also relies on the same unproved non-endpoint estimate; only its endpoint component was established there.

## Lean artifact

`FriableEndpointStieltjesFinite.lean` proves the finite summation-by-parts identity with the literal left endpoint, its total-zero specialization, and a two-region weighted-square propagation theorem. The analytic friable estimates remain named external inputs rather than hidden Lean axioms.

Lean 4.24 reports exactly

```text
[propext, Classical.choice, Quot.sound]
```

for every printed theorem. There is no `sorry`, `admit`, or new axiom.
