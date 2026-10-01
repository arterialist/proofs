# Integer endpoint collars have no arithmetic self-correlation

For every integer endpoint step \(k\to k+1\), \(k\ge1\), the open physical logarithmic collar contains no two points separated by \(\log q\) for any integer \(q\ge2\). Consequently every prime-power translation has zero compression to this collar. This is a support statement, not a positivity estimate or a proof of RH.

The scalar geometry, pointwise mixed-product identity and integral-zero corollary are kernel-checked in [`IntegerWeilCollarCompression.lean`](../../formalization/BuildingBlocks/IntegerWeilCollarCompression.lean). Identifying the resulting form compression with the arithmetic block of the analytic Weil operator remains outside Lean. The old/new cross blocks remain, so its harmonic Schur complement is not made prime-free by this result.

## Exact support statement

Use physical coordinates \(y\), before rescaling the support interval, and put

\[
 a_k=\frac12\log k,\qquad
 K_k=(-a_{k+1},-a_k)\cup(a_k,a_{k+1}).
\]

For every \(x,y\in K_k\) and every integer \(q\ge2\),

\[
 \boxed{y-x\ne\log q.}
\]

On either side, the interval width is

\[
 h_k=a_{k+1}-a_k=\frac12\log\left(1+\frac1k\right)
 \le\frac12\log2<\log2.
\]

A positive difference between opposite sides instead belongs to
\((\log k,\log(k+1))\). That interval contains no logarithm of an integer, because there is no integer strictly between \(k\) and \(k+1\). Negative differences cannot equal \(\log q>0\). These cases exhaust the possibilities. The assertion includes \(k=1\), when the old interval has zero length.

For any two complex functions \(f,g\) supported pointwise in \(K_k\), the stronger mixed identity holds at every real \(x\):

\[
 \boxed{\overline{f(x)}\,g(x+\log q)=0.}
\]

If both factors were nonzero, their two arguments would contradict the support statement. Therefore its integral vanishes for any measure; no additional integrability assumption is needed for this identically zero integrand. For Lebesgue \(L^2\) classes supported almost everywhere on the collar, choose representatives zero outside it. Translation preserves null sets, so the same correlation identity holds for those classes. This last representative/measure identification is written analysis, not a new Lean construction of an \(L^2\) operator.

The open-endpoint convention is exact. An equality such as \(q=k\) or \(q=k+1\) can touch only interval endpoints. Those endpoints have zero Lebesgue measure and cannot create an \(L^2\) correlation or a boundary atom.

## Raw collar block of the localized Weil form

To state the analytic consequence on the odd logarithmic channel, write the localized form in the physical coordinate as

\[
 A_a=\Gamma_a-2|s_a\rangle\langle s_a|
 -\sum_{2\le q<e^{2a}}\frac{\Lambda(q)}{\sqrt q}
    (T_{\log q}+T_{\log q}^{*}),
 \qquad s_a(y)=\sinh(y/2)\mathbf1_{(-a,a)}(y).
\]

Here \(T_h\) is translation followed by zero-extension compression to the support interval. \(\Gamma_a\) denotes the **complete archimedean block**, including its scalar normalization, logarithmic difference form, endpoint potential and regular gamma kernel; it does not denote only an off-diagonal gamma kernel. The coefficient \(\Lambda(p^j)=\log p\) retains every proper prime power. This is the physical normalization used in equations 9–15 and 61 of [Desogus, version 2](https://arxiv.org/html/2609.20367v2); the present support proof does not assume that paper's positivity conclusions.

At \(a=a_{k+1}\), every admitted integer satisfies \(2\le q<k+1\). The support theorem annihilates every term of this finite arithmetic sum, in both translation directions and for mixed test functions. Thus, as a raw quadratic-form compression,

\[
 \boxed{P_{K_k}A_{a_{k+1}}P_{K_k}
 =P_{K_k}\Gamma_{a_{k+1}}P_{K_k}
   -2|\mathbf1_{K_k}\sinh(y/2)\rangle
      \langle\mathbf1_{K_k}\sinh(y/2)|.}
\]

This expression is understood on the compressed form domain. Its identification with the analytic localized Weil form and the bounded translation operators is a written operator argument; the Lean file checks the underlying support and integral identities only. No sign is asserted for the displayed archimedean-plus-polar block.

Arithmetic still enters the old/new coupling. For example, at \(k=7\), translating the positive collar by \(-\log2\) places it inside the old interval. A prime shift can therefore connect collar data to old data while having no collar-to-collar correlation.

In the old/collar decomposition write

\[
 A_{a_{k+1}}=
 \begin{pmatrix}A_{a_k}&B_k\\ B_k^*&D_k\end{pmatrix}.
\]

The result identifies the raw block \(D_k\); it does not remove arithmetic from \(B_k\). When the old block is coercive and the coupling admits the usual Schur formula, its harmonic short is

\[
 D_k-B_k^*A_{a_k}^{-1}B_k.
\]

That correction retains the actual arithmetic, gamma and polar cross terms. In variational language, the same short is an infimum over admissible old-space extensions. Choosing the zero extension gives an upper bound by the raw collar energy, rather than a positivity conclusion.

## Physical collar versus an arithmetic cell

At the endpoint \(Y=k+1\), the Mellin chart is

\[
 t=e^{y+a_{k+1}},\qquad \tau_k=\sqrt{k(k+1)}.
\]

Its exact images are

| Physical region | Mellin interval |
| --- | --- |
| New right collar \((a_k,a_{k+1})\) | \((\tau_k,k+1)\) |
| New left collar \((-a_{k+1},-a_k)\) | \((1,\sqrt{(k+1)/k})\) |
| Old support \((-a_k,a_k)\) | \((\sqrt{(k+1)/k},\tau_k)\) |

For \(k\ge2\), the arithmetic cell \((k,k+1)\) has a nonempty old portion \((k,\tau_k)\) and a new right-collar portion \((\tau_k,k+1)\). At \(k=1\), the old support is empty and both sides of \(\tau_1\) belong to new collars. Replacing a physical collar by the whole arithmetic cell changes the support problem. These chart identities follow by evaluating the exponential at the physical endpoints; they are written calculations outside this Lean module.

The support result does not select a ground profile in the collar, identify a routed ground coordinate with a physical test vector, or compare a trial with a claimed ground coercivity constant. Such statements require their own normalization and embedding equations.

## Verification and limits

The Lean declarations `no_integer_log_difference`, `collar_disjoint_shift_preimage`, `conjugate_shift_mul_eq_zero` and `integral_conjugate_shift_mul_eq_zero` include the full ranges \(k\ge1\), \(q\ge2\). They use the literal radius and collar above. The module contains no `sorry` or custom axiom. Its printed dependencies are only `propext`, `Classical.choice` and `Quot.sound`.

This geometry also applies to arbitrary coefficients placed on integer logarithmic translations. It locates the arithmetic contribution in the block decomposition; it does not distinguish zeta through a new prime-error estimate. No RH implication, positivity of the harmonic short, or coercivity counterexample is claimed.
