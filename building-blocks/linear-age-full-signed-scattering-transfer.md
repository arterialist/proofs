# Full signed scattering transfer uniformly through linear observation age

Developed in the RH Agent3 branch, with independent mathematical review by RH Proof. The full analytic conclusions remain written proofs; compiled finite algebra is linked separately. No novelty or RH claim is made.

This written, independently audited extension of the full-zero transport proof separates the
transport prime-block scale from the observation scale. It proves no
positivity or RH assertion and is not yet formalized in Lean.

Fix (a,b>0) and fixed smooth compact pole-null packets (h,k).
Let (mathcal B_P=\{p:P<p\le2P\}). Use the actual local scattering
factor and its finite compact history approximation
\[
u_p(z)=\frac{1-p^{z-1/2}}{1-p^{-z-1/2}},\qquad
v_{p,M}(z)=-p^{z-1/2}
 +(1-p^{-1})\sum_{j=0}^{M-1}p^{-j(z+1/2)}.
\]
Here (M_zf=\int f(v)e^{zv}dv), so these are the Mellin
multipliers of the actual and compact translation operators in the
previous notes. Define (V_B=\prod_{p\in\mathcal B_P}V_{p,M}) and
\[
M=\left\lceil\frac{KP^2}{\log P}\right\rceil,
\qquad Kc_0/2>a/2+b+1.
\tag{1}
\]
The unconditional zero-free constant (c_0>0), compact explicit formula,
and zero count are precisely those specified in
`dyadic-full-weil-large-history-repair.md`; no RH premise is added.

For (0\le U\le aP), (|w|\le1), set
\(f_{U,w}=h+w\tau_Uk\). The conclusion is
\[
\boxed{\sup_{0\le U\le aP,\;|w|\le1}
 |Q(V_Bf_{U,w})-Q(f_{U,w})|\le C_{h,k,a,b,K}e^{-bP}.}
\tag{2}
\]
All packet and history supports remain literally compact. The larger
history depth in (1) pays for the growing off-critical translation
factors; critical-line operator fidelity alone would not prove (2).

## Full zero sum with uniform moving-packet bounds

For every actual nontrivial zero, with its multiplicity, write
\(z_\rho=\rho-1/2\) and
\(\delta_\rho=\min(\Re\rho,1-\Re\rho)\).
The exact paired weight and multiplier are
\[
\Phi_f(z)=M_zf\,\overline{M_{-\bar z}f},\qquad
\Phi_{V_Bf}(z)=A_P(z)\Phi_f(z),
\]
\[
A_P(z)=\prod_{p\in\mathcal B_P}(1-d_p(z))(1-d_p(-z)),\qquad
d_p(z)=\frac{(1-p^{-1})p^{-M(z+1/2)}}{1-p^{z-1/2}}.
\tag{3}
\]
This follows from the exact identity (u_p(z)u_p(-z)=1), not from
assuming that zeros are critical. The two moving cross weights contain
(e^{zU}) and (e^{-zU}). Their moduli are at most (e^{U/2})
on the closed strip, while both diagonal weights are translation
invariant. Integration by parts in the fixed packets therefore gives,
for every fixed integer (q>0),
\[
|\Phi_{f_{U,w}}(\sigma+i\gamma)|
 \le C_{h,k,q}e^{U/2}(1+|\gamma|)^{-q},
 \qquad |\sigma|\le1/2.
\tag{4}
\]
The constants in (4) do not depend on (U,w,P). In particular the
absolute sum over all actual zeros is bounded by (Ce^{U/2}).

Split the complete sum at height (e^P). Below this height the classical
region gives (delta_\rho\ge c_0/(2P)), for large (P). The
denominator estimate (1-p^{-\delta}\ge\delta\log p/(1+\delta\log p))
and the dyadic Chebyshev count give
\[
\sup_{|\Im\rho|\le e^P}
 \sum_{p\in\mathcal B_P}(|d_p(z_\rho)|+|d_p(-z_\rho)|)
 \le C\frac{P^2}{\log^2P}e^{-Kc_0P/2}.
\tag{5}
\]
Indeed (M\delta_\rho\log p\ge Kc_0P/2) by (1). The elementary
finite-product bound (|A_P-1|\le\exp(\sum|d_p(\pm z)|)-1)
and (4) thus bound the low-zero error by
\[
C\frac{P^2}{\log^2P}e^{-(Kc_0/2-a/2)P}=O(e^{-bP}).
\tag{6}
\]
This multiplies a weighted absolutely convergent zero sum, rather than
the exponentially large low-zero count.

Globally on the closed strip every term of (v_{p,M}) has modulus at
most one. Since (log(M+1)\le3\log P) eventually for fixed (K),
\[
|A_P(z)|\le(M+1)^{2\#\mathcal B_P}\le e^{C_*P}.
\tag{7}
\]
Here (C_*) can be chosen independent of the fixed (K); the threshold
for (7) may depend on (K). Using the unconditional zero count, (4)
and (7) bound the high-zero error by
\[
C_{h,k,q}P e^{(C_*+1-q+a/2)P}.
\tag{8}
Choose a fixed integer (q>C_*+1+a/2+b+1). Equations (6) and (8)
prove (2) by the complete compact explicit formula. All zero
multiplicities, including potential off-critical zeros, remain present.

## Signed arithmetic comparison and physical support cost

Use the full complex cross convention
\[
Q(h+w g)=Q(h)+|w|^2Q(g)+2\Re[w C(h,g)].
\]
Four-phase polarization of (2), with (g=\tau_Uk), yields
\[
\sup_{0\le U\le aP}
 |C(V_Bh,V_B\tau_Uk)-C(h,\tau_Uk)|=O(e^{-bP}).
\tag{9}
\]
The exact arithmetic cross row is
\[
\mathcal L(h,g)=\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 [R_{g,h}(\log n)+\overline{R_{h,g}(\log n)}],
 \quad R_{g,h}(v)=\int g(u+v)\overline{h(u)}du.
\]
On the real Fourier axis the actual factors are unitary, and their
compact tail errors have sum
\(O((P/\log P)P^{-M/2})\). Telescoping therefore bounds
\(\sup_t||v_B(it)|^2-1|\) by a quantity decaying faster than
(e^{-dP}) for each fixed (d>0). The complete archimedean
bilinear multiplier has integrable fixed-packet weight
\(|\mathfrak a(t)F_k(t)\overline{F_h(t)}|\), independent of (U)
because the translation phase has modulus one. The archimedean
comparison is consequently uniform and smaller than the error in (9).
Both literal pole terms vanish. Hence
\[
\boxed{\sup_{0\le U\le aP}
 |\mathcal L(V_Bh,V_B\tau_Uk)-\mathcal L(h,\tau_Uk)|
 =O(e^{-bP}).}
\tag{10}
\]
Both arithmetic orientations after filtering are retained. Every
observing prime power and every joint history coefficient occurs in
these finite sums. Their support diameter is at most
\[
d+U+M\sum_{p\in\mathcal B_P}\log p
 =O_{h,k,a,K}(P^3/\log P),
\]
where (d) encloses the two fixed supports before translation. A common
translation can place all supports in nonnegative physical age without
changing any scalar, cross row, or pole-null condition.

For the separated packets with (Z=R_{k,h}\in C_c^\infty((0,\log2)))
and (U>\log2), the original row is exactly
\[
\mathcal L(h,\tau_Uk)=\sum_{m\ge1}\sum_p
 (\log p)p^{-m/2}Z(\log(p^m/e^U)).
\]
Thus the observing scale is (X=e^U\le e^{aP}), whereas the transport
factors belong to (P<p\le2P). These are different prime ranges and
are not identified. Equation (10) recovers the complete original
signed readout at that observing scale with an exponentially small
transport error. It supplies no upper bound or sign for that readout,
no Hermitian positivity, and no elimination of off-critical zeros.
Those remain necessary unresolved parts of full RH and its Lean proof.
