# Exact cutoff-clock net work and the cost of a contractivity bound

Developed in the RH Agent3 branch, with independent mathematical review by RH Proof. The full analytic conclusions remain written proofs; compiled finite algebra is linked separately. No novelty or RH claim is made.

This written, independently audited calculation concerns the established actual process acting
on the literal finite cutoff window. It identifies a net upper-work
estimate available from dissipation, and its limitation. The resulting
numerical bound is weaker than the previously available PNT envelope;
it is not an improvement toward an RH-size estimate or a Lean theorem.

Use the real fixed universal window (Z) from the two-packet construction,
with (L=\log2), and write (z=Z^\vee). Its Fourier transform is
Schwartz and satisfies (widehat z(\xi)=O(\xi^2)) near zero: the
paired universal packet multiplier has a zero of order two at zero.
Equivalently (int Z=\int uZ(u)du=0). The established actual process
has multiplier (e^{-s\Phi(i\xi)}), with
(
ho(\xi)=\Re\Phi(i\xi)\asymp|\xi|) near zero and a positive gap
outside every neighborhood of zero. It retains its finite-activity atom
and every complete prime history.

Fix (c>0). Define, for integers (n\ge2),
\[
s_n=c\log n,\quad H_n=T_{s_n}\tau_Lj_n,\quad E_n=\|H_n\|_2^2,
\quad j_n=\sum_{\substack{m\le n\\m\text{ odd}}}
 \frac{\Lambda(m)-2}{\sqrt m}\tau_{\log m}z.
\]
Thus the seed coefficient at (m=1) is (-2), and all finite terminal
window terms are retained before evolution. For (n\ge3), put
\[
\Delta_n=c\log(n/(n-1)),\quad
f_n=\mathbf1_{n\text{ odd}}\frac{\Lambda(n)-2}{\sqrt n}
 \tau_{\log n+L}z,\quad b_n=T_{s_n}f_n.
\]
The exact identity is
\[
H_n=T_{\Delta_n}H_{n-1}+b_n.
\tag{1}
\]
In particular the new source increment in (1) is evolved for the entire
clock (s_n), not just the clock difference (Delta_n). This is an
identity for the established cutoff process, not a replacement by an
ordinary sequential injection model.

## Exact signed work and clock dissipation

Set (q_n=T_{\Delta_n}H_{n-1}) and
\[
W_n=2\Re\langle q_n,b_n\rangle,\quad
B_n=\|b_n\|_2^2,\quad
D_n=\|H_{n-1}\|_2^2-\|q_n\|_2^2\ge0.
\]
Then
\[
E_n-E_{n-1}=W_n+B_n-D_n.
\tag{2}
\]
This preserves both signed source work and favorable dissipation.
The nonnegative loading alone cannot bound (W_n).

For (t=e^{-\Delta_n\Phi(i\xi)}), (u=\widehat H_{n-1}(\xi)),
and (v=\widehat b_n(\xi)), completing the scalar square gives
\[
|tu+v|^2-|u|^2
 \le\frac{|v|^2}{1-|t|^2}\quad(\xi\ne0).
\tag{3}
\]
The omitted single frequency has Lebesgue measure zero. The right side
is integrable for these sources because (widehat z=O(\xi^2)).
Plancherel yields the exact upper control cost
\[
E_n-E_{n-1}\le\mathcal C_n
 :=\frac1{2\pi}\int
 \frac{|\widehat b_n(\xi)|^2}{1-e^{-2\Delta_n\rho(\xi)}}d\xi.
\tag{4}
\]
Equivalently the controlled cumulative signed quantity is
\[
\sum_{n=3}^N(W_n-D_n)
 \le\sum_{n=3}^N(\mathcal C_n-B_n).
\]
This does not separately bound (sum W_n) without dissipation.
The best constant in (3) for arbitrary complex (u), fixed (t,v),
is precisely the displayed cost; equality is attained at
(u=\bar t v/(1-|t|^2)). This pointwise sharpness does not assert that
the maximizer is an actual arithmetic or causal source. Improving (4)
for the actual source would require using additional structure in it.

## Quantitative cost and its limitation

The established cusp, off-zero gap and Schwartz decay give
\[
\frac1{2\pi}\int e^{-2s\rho}|\widehat z|^2d\xi=O((1+s)^{-5}),
\qquad
\frac1{2\pi}\int e^{-2s\rho}\frac{|\widehat z|^2}{\rho}d\xi
 =O((1+s)^{-4}).
\tag{5}
\]
Indeed the small-frequency integrands are bounded by constants times
(e^{-as|\xi|}|\xi|^4) and (e^{-as|\xi|}|\xi|^3);
the remaining integrals decay exponentially. No moment of a complete
process age is used. Since (1/(1-e^{-x})\le1+1/x), (4) and (5),
with (Delta_n\asymp c/n), imply
\[
\mathcal C_n\le C_{Z,c}\mathbf1_{n\text{ odd}}
 \frac{(\Lambda(n)-2)^2}{(\log n)^4}.
\tag{6}
\]
The bound (Lambda(n)^2\le(\log n)\Lambda(n)) and Chebyshev give
\(\sum_{X<n\le2X}(\Lambda(n)-2)^2\le CX\log X\).
Summing (6) over dyadic intervals, splitting once at (sqrt N),
therefore gives
\[
E_N\le E_2+\sum_{n=3}^N\mathcal C_n
 \le C_{Z,c}\left(1+\frac{N}{(\log N)^3}\right).
\tag{7}
\]
Equation (7) is an actual net upper-work bound. It falls far short of
subpower growth and is weaker than the existing unconditional PNT
cutoff envelope. Thus the sharp unrestricted scalar control estimate
in (3) does not supply the missing RH-size arithmetic work bound.
The unresolved term is the favorable signed interaction of the actual
source with dissipation, beyond that unrestricted completion of squares.

No assertion here identifies the process norm with a signed Weil row,
commutes observation with evolution, omits the seed or terminal window,
or proves the original frozen-source norm estimate. Full RH and its
complete Lean formalization remain unresolved.
