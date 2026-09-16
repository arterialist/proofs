# Exact signed arrival pairing in the original metric

This note isolates the arrival-defect pairing in the actual Suzuki half-history representation. The defect has an exact signed compensation by the identity channel of the same arithmetic map. No estimate and no positivity assumption is needed for that cancellation. What remains is the gamma pairing in the original metric. The existing theta response has no proved map into this interval consumer, so the result is not asserted as a theta-form identity.

This is a written calculation. No Lean claim or RH conclusion is made.

## The exact bilinear cancellation

Fix a>1, L=log a, I=[-L,L], and use the actual causal shifts and coefficients

\[
\mathcal C_\omega(B)=\sum_{d\le a^2}\frac{c_\omega(d)}{\sqrt d}
S_{\log d/2}B S_{\log d/2}^*,
\qquad H_\omega=\mathcal C_\omega(G_\omega).
\tag{1}
\]

The identity image is the arrival-count multiplier

\[
T_\omega=\mathcal C_\omega(I),\qquad
T_\omega(t)=\sum_{d\le\min(a^2,e^{2(t+L)})}
\frac{c_\omega(d)}{\sqrt d}.
\tag{2}
\]

Put D_\omega=T_\omega-I. For arbitrary x,y in L²(I), not only for diagonal tests,

\[
\boxed{\quad
\langle\mathcal C_\omega(I)x,y\rangle
-\langle D_\omega x,y\rangle=\langle x,y\rangle.
\quad}
\tag{3}
\]

Therefore the complete paid pairing is

\[
\boxed{\quad
\langle\mathcal C_\omega(I+\sigma G_\omega)x,y\rangle
-\langle D_\omega x,y\rangle
=\langle x,y\rangle+\sigma\langle H_\omega x,y\rangle,
\quad \sigma=\pm1.
\quad}
\tag{4}
\]

Equation (4) is the bilinear form of the original-metric identity

\[
I+\sigma H_\omega=\mathcal C_\omega(I+\sigma G_\omega)-D_\omega.
\]

It proves exact signed arrival compensation. In particular, the mixed defect pairing does not need its own sign when the full identity channel is retained. Splitting the two terms and bounding each by absolute value destroys the cancellation in (3).

On the diagonal, the remaining determinant-cone question is precisely

\[
\|x\|_2^2+\sigma\langle H_\omega x,x\rangle\ge0.
\tag{5}
\]

Thus the arrival defect has been paid in the original metric, but (3) does not sign the gamma response. The positive-map estimate

\[
|\langle H_\omega x,x\rangle|
\le\|G_\omega\|\langle T_\omega x,x\rangle
\tag{6}
\]

is too weak for (5), because its right side restores the arrival loading that canceled in (3). A useful estimate must compare the signed transported gamma pairing directly with the original norm, or exploit cancellation internal to H.

## A finite signed response inequality

For any two actual interval responses x_c,x_p, define
x_\Sigma=x_c+x_p and x_\Delta=x_c-x_p. Polarizing (4) gives

\[
-2\operatorname{Re}\left(
\langle\mathcal C_\omega(I+\sigma G_\omega)x_c,x_p\rangle
-\langle D_\omega x_c,x_p\rangle\right)
\]
\[
=\tfrac12\left(
\|x_\Delta\|_2^2+\sigma\langle H_\omega x_\Delta,x_\Delta\rangle
-\|x_\Sigma\|_2^2-\sigma\langle H_\omega x_\Sigma,x_\Sigma\rangle
\right).
\tag{7}
\]

If I+σH is nonnegative on these two vectors, then (7) yields the one-sided compensation bound

\[
-2\operatorname{Re}\left(
\langle\mathcal C_\omega(I+\sigma G_\omega)x_c,x_p\rangle
-\langle D_\omega x_c,x_p\rangle\right)
\le\tfrac12\langle(I+\sigma H_\omega)x_\Delta,x_\Delta\rangle.
\tag{8}
\]

Equation (8) has the same sum/difference geometry as the finite theta-response bound, but it is stated only conditionally on the local cone needed for its right side to be nonnegative. Assuming this cone globally would assume the Suzuki determinant target. Equation (7), not (8), is the unconditional identity.

An unconditional absolute majorant follows directly from weighted Cauchy-Schwarz for the defect,

\[
2|\langle D_\omega x_c,x_p\rangle|
\le \eta\langle D_\omega x_c,x_c\rangle
+\eta^{-1}\langle D_\omega x_p,x_p\rangle,
\qquad\eta>0.
\tag{9}
\]

This is finite and exact in the original metric, but unlike (3) it loses the signed cancellation and is unlikely to be sharp enough.

## What an affine source constraint can and cannot sign

Suppose a proposed interval source condition is one linear constraint

\[
W_s=\{x:\langle x,s\rangle=0\}.
\]

The defect form is nonnegative on W_s, but its mixed pairing on W_s has no fixed sign whenever D_ω is nonzero on a subspace of dimension at least two. Indeed choose D_ω-orthogonal nonzero e_1,e_2 in W_s and put

\[
x=e_1+e_2,\qquad y=e_1-e_2.
\]

Then

\[
\langle D_\omega x,y\rangle=D_\omega[e_1]-D_\omega[e_2].
\tag{10}
\]

Rescaling either e_i gives either sign. This mechanism occurs for the actual multiplication operator. Above the first arithmetic arrival, D_ω is positive on an interval of positive measure. Inside any such interval, the functions supported there and orthogonal to s form an infinite-dimensional space, unless the interval itself is null. Two disjointly supported constrained functions give the required e_i.

This is a narrow obstruction. It says that a single ordinary affine constraint does not sign the mixed defect pairing. It does not exclude a special source cone, an additional arithmetic relation between x_c and x_p, or the exact cancellation (3).

There is one useful exact constrained formula. If φ is an allowed interval direction with D_ω[φ]>0, then the minimum arrival cost after subtracting that common source is

\[
\inf_{r\in\mathbb R}D_\omega[x-r\varphi]
=D_\omega[x]-\frac{|\langle D_\omega x,\varphi\rangle|^2}
{D_\omega[\varphi]}.
\tag{11}
\]

The mixed version uses the same D_ω-orthogonal projection in both components. Separate minimization would alter their pairing and cannot replace a common-source constraint. Formula (11) is the exact arrival analogue of the common-score subtraction in the theta conditional forms.

## Relation to the hard-clock reserve

The matched-dilation note proves that a bounded innovation does not reconstruct the actual terminal Mertens prefix. Its N=4 test has a nonzero coherent response while the matched innovation tends to zero. The interval identity (3) exhibits the analogous bookkeeping rule: the arrival defect is paid by the coherent identity channel, not by a standalone innovation estimate. Removing that channel leaves a terminal loading which a bounded innovation need not see.

This is an analogy between two exact source calculations, not an operator intertwiner. The hard-clock vectors live on the Euclidean horizon 1,...,X, while (1) acts on L²([-log a,log a]). No map between them is supplied by either proof.

## Consequence for the theta alternating response

The earlier note defined the exact theta alternating source

\[
\ell_\Delta(z)=R_c(Pv,Pz)-R_p(Pv,Pz)
\]

and its h_{ε,ε} dual energy Q_Δ. Equations (3) and (4) can consume that response only after proving a map U from its constrained theta form domain to L²(I) such that

\[
\ell_\Delta(z)=
\langle\mathcal C_\omega(I+\sigma G_\omega)U v,U z\rangle
-\langle D_\omega Uv,Uz\rangle
\tag{12}
\]

with the actual source normalization and full edge form preserved. No such identity is currently proved. Literal translation is especially unavailable at the first half-history displacement, where the theta quotient reaches its L² boundary.

Accordingly, the established conclusion is exact but limited. The Suzuki arrival defect has a complete signed original-metric compensator, namely its own arithmetic identity channel. The remaining interval quantity is the gamma pairing in (5) or (7). The remaining theta quantity is Q_Δ. Connecting those quantities requires the explicit form identity (12); positivity of the arithmetic map, the matched innovation bound, and the common affine constraint do not provide it.
