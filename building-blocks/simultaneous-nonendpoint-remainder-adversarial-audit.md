# Simultaneous non-endpoint remainder: adversarial assembly audit

## Verdict

The four newly supplied component arguments—second-log envelope, sampled Green comparison, moving-ceiling endpoint, and zero-free-region prime error—are mutually consistent and use the literal actual row. The only component still named but not bounded in those notes is the `X`-rough composite row. A direct endpoint-vector Minkowski estimate gives it norm `O((log X)e^{-X})`, uniformly in every divisor packet.

With that addition, equation (20) is justified as a written analytic estimate, uniformly for every `P≤X`:

\[
\left\|\sum_{d\mid P^\#}\mu(d)R_{d,\bullet;X}\right\|_{G,X}
\ll
L^{-2}+e^{-c\sqrt L}+L/X+Le^{-X},
\qquad L=\log X.
\]

This is stronger than the stated

\[
O(L^{-2}+e^{-c\sqrt L}+L^3/X).
\]

Consequently the non-endpoint expansion does combine with the signed friable endpoint estimate to give the full simultaneous expansion for every fixed `ε>0` and `P≤X^{1/2-ε}`. This conclusion concerns the written analytic proof. Only the finite Hilbert-space assembly is newly formalized in Lean here; the real-analysis and PNT inputs remain written theorems.

## Literal row and normalization

For integer `X≥2`, put

\[
q=e^{-2/X},\quad L=\log X,\quad y=j/X,
\]

and

\[
c_X(n)=\mu(n)1_{(n,X^\#)=1}.
\]

For each divisor dilation,

\[
T_{d,j}=q^{-j/2}
\sum_{n\ge \lceil j/d\rceil}c_X(n)q^{dn}.
\]

The exact source decomposition is

\[
c_X=\delta_1-1_{\{p>X:p\text{ prime}\}}+r_X,
\]

where `r_X(n)=c_X(n)` on composite `X`-rough integers and zero elsewhere. Every integer in its support exceeds `X²`.

The first term gives the separately audited endpoint vector. The normalized non-endpoint row is

\[
Z_{X,P}(j)=\frac{L}{X}
\sum_{d\mid P^\#}\mu(d){T_{d,j}-E_{d,j}\}.
\]

Its sampled Hilbert norm is

\[
\|z\|_{G,X}^2=(1-e^{-2/X})\sum_{j\ge1}|z_j|^2.
\]

No factor of `2` is missing: this measure converges to `2dy`, so the fixed profile energy is `2||F_P||²` and the first density cross term is `-4⟨F_P,J_P⟩/L`.

## 1. Prime main term and second-log remainder

After separating the possible closed lower atom, Stieltjes PNT and `u=Xv` give the literal continuous prime row

\[
-e^y\int_{a_d(y)}^\infty e^{-2dv}
\frac{L}{L+\log v}\,dv,
\qquad a_d(y)=\max(1,y/d).
\]

The exact identity

\[
\frac{L}{L+\log v}
=1-\frac{\log v}{L}
+\frac{(\log v)^2}{L(L+\log v)}
\]

therefore yields

\[
-G_d(y)+\frac1LJ_d(y)+R_d^{(2)}(y),
\]

with

\[
|R_d^{(2)}(y)|\le L^{-2}Q_d(y),\quad
Q_d(y)=e^y\int_{a_d(y)}^\infty e^{-2dv}(\log v)^2dv.
\]

The bounds in [the second-log proof](simultaneous-second-log-divisor-envelope.md) check out:

\[
\|Q_d\|_2\le3e^{-d}/d,
\qquad
\sum_{d\ge1}Q_d(y)\le2(1+y^2)e^{-y}.
\]

Thus both continuous and sampled norms may be enlarged from `d∣P#` to all positive integers, giving a uniform `O(L^{-2})` remainder. Every moving lower cutoff remains present.

## 2. Moving ceiling and lower atom

For `j>0`,

\[
\lceil j/d\rceil=1+\lfloor(j-1)/d\rfloor,
\]

so the ceiling scan is exactly equivalent to `dn≥j`; it introduces no approximation error.

The only convention change is the possible prime atom at the closed lower endpoint. The split at `d<y` in [the ceiling proof](integer-moving-ceiling-discrepancy.md) gives

\[
|C_X(y)|\le \frac{L}{X}
\left(y+\frac1{1-e^{-2}}\right)e^{-y}.
\]

Its sampled norm is `O(L/X)`. This includes the case where `X` itself is prime; the actual rough-prime condition is open at `X`.

## 3. Zero-free-region PNT error

Assume the classical estimate

\[
|\pi(u)-\operatorname{li}(u)|
\le C_\pi u e^{-c_\pi\sqrt{\log u}}
\quad(u\ge X_0).
\]

For one face, partial summation at

\[
t=X\max(1,y/d),\qquad \lambda=2d/X
\]

gives

\[
\left|\int_{[t,\infty)}e^{-\lambda u}\,d(\pi-\operatorname{li})(u)\right|
\le C_\pi e^{-c_\pi\sqrt L}e^{-\lambda t}(2t+\lambda^{-1}).
\]

The split `d<y` versus `d≥y` in [the PNT proof](uniform-rough-prime-pnt-partial-summation.md) is correct. The small-`d` side pays only a harmonic sum, and the large-`d` side is geometric. Its aggregate sampled norm is

\[
O\!\left(Le^{-c_\pi\sqrt L}\right)
=O(e^{-(c_\pi/2)\sqrt L}),
\]

with the displayed symbolic constant in that note. No divisor count occurs.

## 4. Rough composites

This was the remaining unassembled row. Each pair `(d,n)` with `n` in the support of `r_X` contributes the endpoint-shaped vector at index `dn`. Its exact Green norm is

\[
\sqrt{q^{dn}-q^{2dn}}\le e^{-dn/X}.
\]

Minkowski, `|r_X(n)|≤1`, and enlargement to all positive `d` and all `n>X²` give

\[
\|R_{\rm comp}\|_{G,X}
\le\frac{L}{X}
\sum_{d\ge1}\sum_{n>X^2}e^{-dn/X}.
\]

For integer `X`,

\[
\sum_{n>X^2}e^{-dn/X}
\le e^{-dX}\left(1+\frac Xd\right),
\]

using `(1-e^{-a})^{-1}≤1+a^{-1}`. Hence

\[
\boxed{
\|R_{\rm comp}\|_{G,X}
\le
\frac{L}{X}
\left\{
\frac{e^{-X}}{1-e^{-X}}
-X\log(1-e^{-X})
\right\}
\le \frac{2L e^{-X}}{1-e^{-1}}.}
\]

This retains the actual coefficient of every rough composite; nonsquarefree prime powers remain present with their exact Möbius coefficient zero. It is uniform in `P`.

## 5. Sampling and all cross terms

The variation budgets in [the sampling proof](sampled-green-norm-uniform-proof.md) are consistent:

\[
\|F_P\|_\infty\le A/2,\quad \operatorname{Var}(F_P)\le A,
\]

\[
\|J_P\|_\infty\le3A/4,\quad
\|J_P\|_1\le2A,\quad \operatorname{Var}(J_P)\le4A,
\]

where `A=Σe^{-d}/d`. The derivative boundary term in `J_d` vanishes at `y=d`, so no atom is omitted. The bounded-variation rectangle estimate gives uniform `O(1/X)` sampling errors for `F_P²`, `F_PJ_P`, and `J_P²`.

Let the total row remainder after all four components be `R_X`. Then

\[
Z_{X,P}=-F_P+L^{-1}J_P+R_X,
\]

and

\[
\|R_X\|_{G,X}
\ll L^{-2}+e^{-c\sqrt L}+L/X+Le^{-X}.
\]

The exact Hilbert expansion is

\[
\begin{aligned}
\|Z_{X,P}\|^2
={}&\|F_P\|^2-\frac{2}{L}\langle F_P,J_P\rangle
+\frac1{L^2}\|J_P\|^2\\
&+2\langle-F_P+L^{-1}J_P,R_X\rangle+\|R_X\|^2.
\end{aligned}
\]

Uniform bounds for `F_P,J_P` and Cauchy–Schwarz show that the omitted correction square and all error cross terms are

\[
O(L^{-2}+e^{-c\sqrt L}+L/X).
\]

After the sampled measure's factor `2`, this yields

\[
\boxed{
\|Z_{X,P}\|_{G,X}^2
=E_P-\frac4L\langle F_P,J_P\rangle
+O(L^{-2}+e^{-c\sqrt L}+L/X),}
\]

uniformly in `P≤X`. The original `L³/X` allowance is safe but unnecessarily large.

## Combination with the signed friable endpoint

The signed friable audit proves

\[
\eta_{X,P}:=\frac L X\|E_{X,P}\|_{G,X}\to0
\]

for every fixed `ε>0` and `P≤X^{1/2-ε}`, after union with the sign-free range. The non-endpoint norm is uniformly bounded by the expansion above. Therefore

\[
\left|\|Z_{X,P}+E_{X,P}^{\rm norm}\|^2-\|Z_{X,P}\|^2\right|
\le2\|Z_{X,P}\|\eta_{X,P}+\eta_{X,P}^2=o(1).
\]

Thus the corrected assembled theorem is

\[
\boxed{
\mathcal E_X(P)
=E_P-\frac4{\log X}\langle F_P,J_P\rangle+o(1)}
\]

uniformly along every sequence `P=P(X)≤X^{1/2-ε}`. Since the profile norms are uniformly bounded, the explicit density correction is itself `O(1/\log X)`.

This proves the full simultaneous approximation on that range. It does not address `P>X^{1/2}` and makes no RH claim.

## Lean artifact

`NonendpointRemainderAssemblyFinite.lean` proves the exact corrected-profile square with the `J²/L²` term and both remainder terms, followed by the sharp Cauchy propagation bound

\[
|\Delta E|\le
\ell^2\|J\|^2
+2(\|F\|+|\ell|\|J\|)\|R\|+\|R\|^2.
\]

It compiles in Lean 4.24. Both printed theorems depend only on

```text
[propext, Classical.choice, Quot.sound]
```

There is no `sorry`, `admit`, or new axiom.
