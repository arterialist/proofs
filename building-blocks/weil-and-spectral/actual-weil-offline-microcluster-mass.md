# A pointwise off-line microcluster bound from the complete Weil form

**Status:** unconditional written analytic consequence of the
[fixed-bump complete Weil theorem](actual-signed-annulus-bump-gram.md),
18 September 2026. RH Agent 3 proposed the zero-side cluster
calculation; RH Agent 1 independently checked its reflected-pair
sign, uniform zero sums, and use of the fixed-bump margin.
The underlying finite Hermitian inequality is compiled in
[ActualAnnulusGramAlgebra.lean](../../formalization/BuildingBlocks/ActualAnnulusGramAlgebra.lean).
The reciprocal Fourier factor, reflected-pair identity, and finite
central sign bound are compiled in
[ActualWeilZeroPairAlgebra.lean](../../formalization/BuildingBlocks/ActualWeilZeroPairAlgebra.lean).
The explicit-formula identification, uniform positivity of the bump
transform, zero sums, and resulting analytic theorem are not
formalized in Lean. No RH or
literature-priority claim is made.

Fix `0<w<log 2` and a real nonnegative nonzero
`phi in C_c^infinity((0,w))` with `||phi||_2=1`. Put
`H=log T`, `h=log H`, `R=2h`, and, for real `t in [T,2T]`,

\[
u_t(x)=e^{-itx}\phi(x),\qquad
v_{t,R}(x)=e^{-itx}\phi(x-R),\qquad f_t=u_t-v_{t,R}.
\tag{1}
\]

Let `Q` denote the **complete actual-zeta Weil form**, including
every `Lambda(p^j)=log p`, both poles, and the exact digamma
multiplier, with the normalization in the linked fixed-bump theorem.
Because `R<=2loglog t` and its fixed separation offset is `c=0`,
that theorem gives a constant `a_phi>0` such that

\[
Q(f_t)\ge a_\phi H
\quad\text{for all sufficiently large }T
\text{ and every }t\in[T,2T].
\tag{2}
\]

No assumption about zeros enters this positive complete-form bound.

**Theorem.** There are constants `epsilon_phi>0`, `C_phi>0`
and a fixed `D>0` such that, for all sufficiently large `T` and
every `t in [T,2T]`, the following implication holds. If there is
no right-half nontrivial zeta zero `rho=beta+i gamma` with

\[
\beta>\tfrac12,\qquad
\frac{\epsilon_\phi}{R}<|\gamma-t|\le H^D,
\tag{3}
\]

then the central off-line zero mass obeys the **pointwise** bound

\[
\boxed{\quad
\sum_{\substack{\rho=\beta+i\gamma\\
                  \beta>1/2,\ |\gamma-t|\le\epsilon_\phi/R}}
 m_\rho e^{(\beta-1/2)R}
\le C_\phi H.\quad}
\tag{4}
\]

The sum runs over distinct right-half zeros with their
multiplicities `m_rho`. In particular, for each fixed
`0<delta<1/2`, the number of zeros in the central window with
`beta>=1/2+delta`, counted with multiplicity, is

\[
O_\phi(H^{1-2\delta}).                                  \tag{5}
\]

Equivalently, if the left side of (4) exceeds `C_phi H`, an
off-line zero must occur in the outer ordinate annulus (3).
The conclusion has **no exceptional set of carrier ordinates**.

## Reflected zero sign

Use `hat f(z)=int f(x)e^(izx)dx`, and let
`Phi(z)=int phi(x)e^(izx)dx`. At frequency offset `z` from `t`,

\[
\widehat f_t(t+z)=F_R(z):=\Phi(z)(1-e^{izR}).
\tag{6}
\]

For `tilde f(x)=conjugate(f(-x))`, the identity
`hat(f*tilde f)(z)=hat f(z) conjugate(hat f(conjugate(z)))`
fixes the orientation. The unconditional zero side of the
complete explicit formula samples this at `z=gamma-id` for
each nontrivial zero `1/2+d+i gamma`. Pairing each right-half
zero with its left-half reflection gives, at
`omega=gamma-t` and `d=beta-1/2 in (0,1/2)`, exactly

\[
2m_\rho\operatorname{Re}\!\left\{
 W_d(\omega)
 \bigl[2-e^{i\omega R+dR}-e^{-i\omega R-dR}\bigr]
\right\},\qquad
W_d(\omega)=\Phi(\omega-id)
                  \overline{\Phi(\omega+id)}.
\tag{7}
\]

Critical-line zeros instead contribute
`m_rho |F_R(gamma-t)|^2>=0`. The zero-side series is absolutely
convergent for each smooth compact test.
The reciprocal factor and its reflected pairing in (7) are checked
in the linked Lean zero-pair module; that module does not assert a
Weil explicit formula for actual zeta.

Because `phi>=0`, both `Phi(-id)` and `Phi(id)` are strictly
positive real numbers, uniformly for `0<=d<=1/2`.
The functions `W_d(omega)` have uniformly bounded first
`omega` derivatives on that closed `d` interval. Choose
`epsilon_phi>0` sufficiently small that

\[
\operatorname{Re}\bigl(e^{i\omega R}W_d(\omega)\bigr)
\ge b_\phi>0
\quad\text{if }|\omega|\le\epsilon_\phi/R,
\quad0\le d\le1/2,
\tag{8}
\]

for every `R>=1`. Thus **each** central right-half zero has a
nonpositive growing term in (7), bounded above by
`-2b_phi m_rho e^(dR)`. Near-coincident off-line zeros reinforce
this sign regardless of their order in the ordinates.
The linked Lean module also bounds the paired factor by
`4||W_d(omega)||+2||W_d(omega)||e^(-dR)-2b_phi e^(dR)`
from the unit phase and (8). The uniform analytic lower bound in
(8) is a separate written step.

## The rest of the zero ensemble

For every fixed `A`, repeated integration by parts gives
`|Phi(omega±id)|<<_(phi,A)(1+|omega|)^(-A)` uniformly for
`|d|<=1/2`. The Riemann--von Mangoldt bound supplies `O(H)`
zeros, **with multiplicity**, in each unit ordinate interval near
`t`; summing the Schwartz tails gives

\[
\sum_{\rho\text{ distinct}}m_\rho
       (1+|\operatorname{Im}\rho-t|)^{-A}\ll_{\phi,A}H,
\tag{9}
\]

and, for `1<=Y<=T/2` and `A>2`,

\[
\sum_{|\operatorname{Im}\rho-t|>Y}m_\rho
       (1+|\operatorname{Im}\rho-t|)^{-A}
\ll_{\phi,A}H Y^{1-A}.
\tag{10}
\]

The remote part follows also from `N(U)=O(U log U)`.
Consequently all non-growing terms in (7), together with every
critical-line-zero contribution, have total absolute value
`O_phi(H)`. For the growing terms at `|omega|>Y=H^D`, use
`d<1/2` and `e^(dR)<=e^(R/2)=H`; (10) bounds their total by
`O_phi(H^2Y^(1-A))`. Fix `A,D` with `D(A-1)>1`, so this is
`o(H)`. All estimates are uniform in `t in [T,2T]`.

Under (3), there is no off-line zero in the intermediate band.
The growing terms from the central window obey (8), while those
outside `Y` are `o(H)`. The exact zero-side equality therefore gives

\[
Q(f_t)\le C_0H
 -2b_\phi\!
   \sum_{\substack{\rho=\beta+i\gamma\\
                   \beta>1/2,\ |\gamma-t|\le\epsilon_\phi/R}}
       m_\rho e^{(\beta-1/2)R}
 +o(H).                                                  \tag{11}
\]

Combine (11) with the unconditional positive lower bound (2)
and absorb the `o(H)` term. This proves (4), and
`e^(delta R)=H^(2delta)` gives (5).

The new condition concerns local **off-line** mass. It is distinct
from a global zero-density theorem: a single off-line zero has
weight `H^(2delta)=o(H)` for fixed `delta<1/2`, so it can satisfy
(4), and an annular companion may contribute with either sign.
The theorem does not exclude any off-line zero or prove RH.
[Maynard--Pratt](https://arxiv.org/pdf/2206.11729) give a
`T^(2(1-sigma)+o(1))` count for half-isolated zeros; their
global count and this conditional pointwise microcluster bound
have different hypotheses and conclusions. No comparison of
literature priority is asserted.
