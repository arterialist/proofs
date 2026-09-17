# An unconditional signed Weil Gram on separated high-frequency bumps

**Status:** written analytic proof for the complete actual-zeta Weil form,
18 September 2026. RH Agent 2 proposed the signed annulus and its prime
polynomial; RH Agent 3 identified the uniform separation range; RH Agent 1
independently checked the normalization, corrected the Hermitian matrix
orientation, and audited the fixed-bump positive bound below. This is a
two-dimensional signed result with support diameter allowed to grow like
`2 log log T`. It is not positivity on arbitrary tests
of that support or RH. The finite Hermitian inequality is Lean-checked;
the analytic theorem is written mathematics. No literature-priority
claim is made.

Fix `0<w<log 2` and a real nonnegative
`phi in C_c^infinity((0,w))` with `||phi||_2=1`. Fix real `c`. For
sufficiently large `T`, take any `L` with
`2w<L<=2 log log T+c`, and put

\[
u_T(x)=e^{-iTx}\phi(x),
\quad v_{T,L}(x)=e^{-iTx}\phi(x-L),
\quad C_\phi(y)=\int_\mathbb R\phi(x+y)\phi(x)\,dx.
\]

The supports of `u_T` and `v_{T,L}` are disjoint, so
`||a u_T+b v_{T,L}||_2^2=|a|^2+|b|^2`.
Define the *complete* annular prime-power polynomial

\[
P_{L,\phi}(T)=
\sum_{\substack{n\ge2\\|\log n-L|\le w}}
  \frac{\Lambda(n)}{\sqrt n}
  C_\phi(\log n-L)e^{-iT\log n}.                 \tag{1}
\]

The inclusive convention retains every boundary prime power; its
coefficient is zero there because `C_phi(±w)=0`. Let `Q` be the
complete Hermitian Weil form in the physical convention below. Set

\[
A_\phi=
\left(\int e^{x/2}\phi(x)\,dx\right)
\left(\int e^{-x/2}\phi(x)\,dx\right),
\qquad \lambda_w=\frac w2+\sinh\frac w2.       \tag{2}
\]

**Theorem.** For this fixed `phi` and `c`, uniformly over all the
stated separations `L`, the Gram matrix acting on the coefficient
column `(a,b)^t` obeys

\[
G_{T,L}=
\begin{pmatrix}
 \log(T/2\pi)&-P_{L,\phi}(T)\\
 -\overline{P_{L,\phi}(T)}&\log(T/2\pi)
\end{pmatrix}+o_{\phi,c}(1),                    \tag{3}
\]

entrywise. Moreover,

\[
\liminf_{T\to\infty}\ \inf_{2w<L\le2\log\log T+c}
 \frac{\lambda_{\min}(G_{T,L})}{\log T}
 \ge 1-e^{c/2}A_\phi
 \ge 1-e^{c/2}\lambda_w.                       \tag{4}
\]

Hence if `e^(c/2) A_phi<1`, every complex signed combination
`a u_T+b v_{T,L}` has strictly positive complete Weil value for all
sufficiently large `T`, uniformly for `2w<L<=2loglog T+c`. In
particular, since

\[
\lambda_w<\lambda_*:=\frac{\log2}{2}+\frac1{2\sqrt2}
=0.700126980873\ldots,
\qquad c_*=-2\log\lambda_*=0.712987118284\ldots,    \tag{5}
\]

every fixed admissible `phi` has a positive signed Gram throughout
that separation range for each `c<c_*`. More precisely, if
`epsilon_c=(1-e^(c/2)lambda_*)/2>0`, then for large enough `T`

\[
Q(a u_T+b v_{T,L})\ge
\epsilon_c\log T\,(|a|^2+|b|^2).            \tag{6}
\]

The numerical threshold and `epsilon_c` are independent of the fixed
bump, but the onset `T_0` in (6) may depend on `phi` and `w`. No
uniform-in-varying-bumps claim is made.
The [Lean Gram algebra](../../formalization/BuildingBlocks/ActualAnnulusGramAlgebra.lean)
checks the exact complex cross orientation and lower inequality
`Q >= (d-|P|)(|a|^2+|b|^2)` for the ideal matrix in (3), including
strict positivity when `d>|P|` and `(a,b)` is nonzero. It does not
formalize the asymptotic entries, PNT, or gamma and pole estimates.

## Exact prime orientation and analytic remainder

Use the Fourier convention `hat f(t)=int f(x)e^(itx) dx`. The complete
geometric-side formula, with *both* poles, all prime powers, and the
gamma factor, is

\[
\begin{split}
Q(f)&=2\operatorname{Re}\bigl(E_+(f)\overline{E_-(f)}\bigr)
 +\frac1{2\pi}\int_\mathbb R
   h(t)|\widehat f(t)|^2\,dt\\
&\quad-2\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 \operatorname{Re}C_f(\log n),\\
E_\pm(f)&=\int f(x)e^{\pm x/2}\,dx,
\quad C_f(s)=\int f(x+s)\overline{f(x)}\,dx,\\
h(t)&=\operatorname{Re}\psi\bigl(\tfrac14+\tfrac{it}{2}\bigr)-\log\pi.
\end{split}                                                   \tag{7}
\]

This is the normalization used in the [complete compact Weil form](compact-weil-boundary-packet-growing-positive-space.md)
and the geometric assembly of [Zhu's window theorem](https://arxiv.org/html/2608.24827v2).
For positive shifts `s>=log 2`, the two self-correlations vanish
because `w<log 2`; so does the orientation from the later bump to the
earlier one. The remaining oriented cross is exactly

\[
C_{a u_T+b v_{T,L}}(s)
 =b\overline a\,e^{-iTs}C_\phi(s-L).
\]

Thus the prime part is exactly
`-2 Re(b conj(a) P_{L,phi}(T))`, which gives the off-diagonal
entries in (3) under the standard column convention
`Q(a u+b v)=(a,b)^*G(a,b)`. All `Lambda(p^k)=log p` are present;
the compact support of `C_phi` makes the sum finite.

The classical digamma asymptotic gives
`h(t)=log(|t|/(2pi))+O(1/|t|)` as `|t|` grows, while
`|h(t)|<=C log(2+|t|)` globally. Since
`hat u_T(t)=hat phi(t-T)` and
`hat v_{T,L}(t)=e^{i(t-T)L}hat phi(t-T)`, Schwartz decay yields
for fixed `phi`

\[
\Gamma(u_T,u_T)=\Gamma(v_{T,L},v_{T,L})
  =\log(T/2\pi)+O_\phi(T^{-1}),\qquad
\Gamma(u_T,v_{T,L})=O_\phi(T^{-1}).           \tag{8}
\]

Here the constant-multiplier part of the cross is zero **exactly** by
disjoint support; the error bound is independent of `L` because the
translation Fourier factor has modulus one. To justify the `O(T^-1)`
error, split the Fourier integral at `|t-T|=T/2`: within that interval
the symbol differs from `log(T/2pi)` by
`O((1+|t-T|)/T)`, and outside it Schwartz decay pays the logarithmic
growth of `h`.

For every `A>0`, integration by parts gives
`E_\pm(u_T)=O_{\phi,A}(T^{-A})`, and translation gives exactly
`E_\pm(v_{T,L})=e^{\pm L/2-iTL}E_\pm(u_T)`. Consequently every
entry of the polar Gram is
`O_{\phi,A}((1+e^{L/2})T^{-A})=o(1)` uniformly for
`L<=2loglog T+c`. This proves (3), without dropping either pole.

## Full prime-power mass and the sharp fixed-width constant

Positivity of `phi` makes `C_phi>=0`; hence `|P|` is at most the
unsigned mass. With `X=e^L` and
`g(z)=z^{-1/2}C_phi(log z)`, the prime number theorem in the form
`psi(Xz)/X -> z`, uniformly for `z` in the fixed compact interval
`[e^-w,e^w]`, gives by Stieltjes integration

\[
\begin{split}
\sum_{|\log n-L|\le w}
 \frac{\Lambda(n)}{\sqrt n}C_\phi(\log n-L)
 &=X^{1/2}\left(\int_{e^{-w}}^{e^w}g(z)\,dz+o_\phi(1)\right)\\
 &=e^{L/2}\bigl(A_\phi+o_\phi(1)\bigr).       \tag{9}
\end{split}
\]

The Stieltjes measure uses the actual `psi`, so (9) includes every
prime power and its endpoint. Equation (9) is an asymptotic as
`L` tends to infinity for fixed `phi`; its tail is uniform for all
`L>=L_0` once `L_0` is chosen. For `2w<L<L_0`, the same unsigned mass
is bounded by a fixed finite sum, hence is `O_{phi,L_0}(1)`.
Consequently the supremum of the unsigned mass over
`2w<L<=2loglog T+c`, divided by `log T`, has limsup at most
`e^(c/2) A_phi`. This justifies the uniformity in (4) and (6).
The change `z=e^y` gives
`int e^(y/2)C_phi(y)dy`; Fubini gives the product in (2).

For the universal fixed-width bound, symmetrize that product as
`<phi,K phi>` on `L^2(0,w)`, where
`K(x,y)=cosh((x-y)/2)`. Write
`U(x)=e^(x/2)` and `V(x)=e^(-x/2)`, so
`K=(U tensor V+V tensor U)/2`. Its two nonzero eigenvalues are

\[
\frac{\langle U,V\rangle\pm\|U\|_2\|V\|_2}{2}
=\frac w2\pm\sinh\frac w2.
\]

The top one is `lambda_w`, so `A_phi<=lambda_w`. Formula (5)
uses the strict assumption `w<log2`. Finally, (3), `|P|` bounded by
(9), and `e^(L/2)<=e^(c/2)log T` prove (4)--(6).

## Scope of the signed advance

The growing-support sign comes from the unsigned PNT mass; it proves
no cancellation in `P`. At the upper separation edge, the first range
that requires an actual prime-phase saving is beyond the bump-dependent boundary
`c=-2log A_phi`. A bound
`|P|<=(1-epsilon)log(T/2pi)` would suffice for a fixed relative
margin there, but is stronger than the pairwise positivity condition
`log(T/2pi)-|P|+o(1)>=0` and may fail even if RH holds. Neither is
proved here in that range. Classical mean-square/large-values bounds
permit exceptional ordinates and do not supply the required uniform
bound.

[Zhu's unconditional certificate](https://arxiv.org/html/2608.24827v2)
handles *all* complex tests in a fixed window of length `1.6`; this
result instead has unbounded support diameter but only a specified
two-dimensional modulated subspace. The
[growing divisor-packet space](compact-weil-boundary-packet-growing-positive-space.md)
is another distinct structured signed family. None of these signs
proves RH or controls all compact tests.
