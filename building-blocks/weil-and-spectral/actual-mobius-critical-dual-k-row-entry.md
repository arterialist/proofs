# A dual row bound on the critical prime fiber

**Status.** This note proves an unconditional row-entry estimate for the
dual matrix after its complementary coefficient has been removed:
\[
  |\mathcal G(k,k')|\ll_\varepsilon
  T^\varepsilon Q^3\sqrt P.
\]
It improves the displayed \(Q^{7/2+\varepsilon}\) Robert--Sargos
comparison benchmark because \(P<Q\). It still loses \(\sqrt P\) against
row orthogonality.
Schur's test therefore gives \(P^{3/2}Q^3\), which does not produce a
positive \(\rho\) or extend the complete Möbius prefix.

The exponent and determinant-line ledgers are checked in
[`ActualMobiusCriticalDualKRow.lean`](../../formalization/BuildingBlocks/ActualMobiusCriticalDualKRow.lean).
The second derivative estimate, Poisson summation, and stationary phase are
written mathematics.

## 1. Parameters and the coefficient loss in the dual matrix

Fix
\[
 2<\lambda<\frac{29}{14},\qquad
 P=T^{1-2\lambda/5},\qquad Q=T^{\lambda/5},
 \qquad M=Q^2,\qquad N=Q^5.
\tag{1}
\]
Then \(1<P<Q\), and \(Q/P\) tends to infinity. All variables below may
occupy fixed dyadic dilates of the displayed scales. Fix
\(0<a<b<\infty\). Let \(w\in C_c^\infty((0,\infty))\) be nonnegative,
supported in \([a,b]\), and at least \(1\) on the normalized support of the
actual coefficient \(R_\theta(r)\). Its support and derivative bounds are
fixed. Let \(|d_q|\ll T^\varepsilon\) on primes \(q\asymp Q\). Define
\[
 A_{k,r}=\sum_{q\asymp Q\atop q\ {\rm prime}}
 d_q e\!\left(-\frac{kN}{qr}\right),
 \qquad k\asymp P,\qquad r\asymp M,
\tag{2}
\]
and its row Gram matrix
\[
 \mathcal G(k,k')=
 \sum_{r}w(r/M)A_{k,r}\overline{A_{k',r}}.
\tag{3}
\]
Thus
\[
 \mathcal G(k,k')=
 \sum_{q,q'\asymp Q\atop q,q'\ {\rm prime}}
 d_q\overline{d_{q'}}
 \sum_r w(r/M)
 e\!\left(-\frac Nr
   \left(\frac{k}{q}-\frac{k'}{q'}\right)\right).
\tag{4}
\]

Put \(B_{k,r}=w(r/M)^{1/2}A_{k,r}\). Then (3) is \(BB^*\). The established
collapsed coefficient is
\[
 R_\theta(r)=
 \sum_{cp=r\atop c\asymp C,\ p\asymp P}
 a_c(\theta)b_p(\theta),
 \qquad
 \|R_\theta\|_2^2\ll_\varepsilon T^\varepsilon Q^2.
\tag{5}
\]
This formula allows the outer coefficient inherited from the parent
decomposition to be \(1\); no pointwise Möbius factorization of
\(R_\theta\) is assumed. Define
\(X_r=R_\theta(r)/w(r/M)^{1/2}\) on its support and \(X_r=0\) elsewhere.
Our choice of \(w\) gives
\[
 BX=AR_\theta,
 \qquad \|X\|_2\leq\|R_\theta\|_2.
\tag{6}
\]
Passing to the coefficient-uniform norm of \(BB^*\) therefore removes all
arithmetic signs carried by \(R_\theta\) without increasing its norm. The
surviving semiprime local coefficient is \(+1\), and the exact K=3 history
does not provide an independent \(q\)-sign for the dual Gram to exploit.
Bounded separated packet weights may remain in \(d_q\). The dual matrix has
no complementary Möbius sign to exploit.

## 2. The determinant line

Put
\[
 h=kq'-k'q,
 \qquad g=(k,k').
\tag{7}
\]
For a fixed integer \(h\), any two integer solutions of
\(kq'-k'q=h\) differ by
\[
 (\Delta q,\Delta q')=
 t\left(\frac{k}{g},\frac{k'}{g}\right),
 \qquad t\in\mathbb Z.
\tag{8}
\]
Consequently the number \(\nu_{k,k'}(h)\) of solutions in the two dyadic
\(Q\)-intervals satisfies
\[
 \nu_{k,k'}(h)\ll 1+\frac{Qg}{P}.
\tag{9}
\]
Also \(g\mid h\) and \(|h|\ll PQ\).

The zero determinant is harmless. For all sufficiently large \(T\), every
prime \(q\asymp Q\) exceeds every \(k\asymp P\). Hence \(k/q\) is reduced.
The equality \(k/q=k'/q'\) forces \((k,q)=(k',q')\). Its contribution to
(4) is
\[
 \ll T^\varepsilon QM=T^\varepsilon Q^3.
\tag{10}
\]

## 3. The reciprocal sum in \(r\)

Assume \(h\ne0\), and set
\[
 A=\frac{N|h|}{qq'}\asymp Q^3|h|.
\tag{11}
\]
On \(r\asymp M\), the second derivative of \(A/r\) has size
\(A/M^3\). The van der Corput second derivative estimate gives
\[
 \begin{aligned}
 \left|\sum_r w(r/M)e(\pm A/r)\right|
 &\ll_\varepsilon T^\varepsilon
 \left(M\sqrt{\frac{A}{M^3}}
       +\sqrt{\frac{M^3}{A}}\right)\\
 &\ll_\varepsilon T^\varepsilon
 \left(\sqrt{Q|h|}
       +\frac{Q^2}{\sqrt{Q|h|}}\right).
 \end{aligned}
\tag{12}
\]
The same estimate holds after bounded-variation endpoint separation.

We now sum (12) on the determinant lines. Write \(h=g\ell\). Equations
(9) and \(|\ell|\ll PQ/g\) imply
\[
 \begin{aligned}
 \sum_{h\ne0}\nu_{k,k'}(h)\sqrt{Q|h|}
 &\ll T^\varepsilon Q^3\sqrt P,\\
 \sum_{h\ne0}\nu_{k,k'}(h)
       \frac{Q^2}{\sqrt{Q|h|}}
 &\ll T^\varepsilon \frac{Q^3}{\sqrt P}.
 \end{aligned}
\tag{13}
\]
For completeness, the main pieces in these two sums are
\[
 \frac{Qg}{P}\sqrt{Qg}
   \left(\frac{PQ}{g}\right)^{3/2}
 =Q^3\sqrt P
\tag{14}
\]
and
\[
 \frac{Qg}{P}\frac{Q^{3/2}}{\sqrt g}
   \left(\frac{PQ}{g}\right)^{1/2}
 =\frac{Q^3}{\sqrt P}.
\tag{15}
\]
The terms arising from the \(1\) in (9) are smaller because \(P<Q\).
Combining (10), (12), and (13) proves
\[
 \boxed{
 |\mathcal G(k,k')|
 \ll_\varepsilon T^\varepsilon Q^3\sqrt P.}
\tag{16}
\]
The constants are uniform for fixed dyadic supports, fixed derivative
bounds on \(w\), and the full range in (1). For comparison, the displayed
Robert--Sargos substitution has total length \(Q^4\) and normalized factor
\(Q^{-1/2}\), hence the benchmark \(Q^{7/2+\varepsilon}\). This comparison
is not used in the proof of (16).

## 4. Poisson summation and the transition modes

Poisson summation makes the \(\sqrt P\) loss visible. For one sign of the
phase, write
\[
 \sum_r w(r/M)e(-A/r)=\sum_{m\in\mathbb Z}I_m(A),
 \qquad
 I_m(A)=\int_0^\infty w(x/M)e(-A/x-mx)\,dx.
\tag{17}
\]
Changing the sign only changes the relevant sign of \(m\). A stationary
point satisfies \(m=A/x^2\). The stationary frequencies therefore have
length
\[
 R_A=\frac{A}{M^2}\asymp\frac{|h|}{Q},
 \qquad 0<R_A\ll P.
\tag{18}
\]

When \(R_A\gg1\), stationary phase gives
\[
 I_m(A)=
 A^{1/4}m^{-3/4}W_A(m)
 e\!\left(-2\sqrt{Am}-\frac18\right)
 +O_J(T^{-J})
\tag{19}
\]
on the stationary range, after the usual inert partition. The exact
constant phase depends on the Fourier convention and is irrelevant here.
The weights \(W_A\) have uniform inert bounds. Summing their absolute
values gives
\[
 \sum_{m\asymp R_A}|I_m(A)|
 \ll Q\sqrt{R_A}=\sqrt{Q|h|}.
\tag{20}
\]
Together with the uniform estimate (12), this identifies the two relevant
scales as \(Q\sqrt{R_A}\) and \(Q/\sqrt{R_A}\). No cancellation between
the stationary modes is used.

Because \(x/M\in[a,b]\), the stationary integers lie in
\[
 \frac{R_A}{b^2}\leq m\leq\frac{R_A}{a^2}.
\tag{21}
\]
The fixed transition band \(R_A\asymp_w1\), equivalently
\(|h|\asymp_w Q\), contains \(O_w(1)\) stationary frequencies, each of
size \(O_w(Q)\). If \(R_A\leq a^2/2\), there is no nonzero stationary
integer. Integration by parts bounds the zero mode and the remaining
nonstationary modes; in particular the zero mode is
\(O_w(R_A^{-1})=O_w(Q/|h|)\). These low and transition ranges fit inside
(12) and contribute less than (13).

For the typical determinants \(|h|\asymp PQ\), equation (18) gives
\(R_A\asymp P\). Formula (19) then has \(P\) terms of size
\(Q/\sqrt P\). Absolute summation costs \(Q\sqrt P\). Closing the row
orthogonality estimate would require square-root cancellation among these
stationary frequencies after the prime-pair condition
\(h=kq'-k'q\) is retained. The published monomial and Kloosterman-fraction
estimates used elsewhere in this project do not give that cancellation.

## 5. What the lemma does not prove

Schur's test applied to (16) sums over \(k'\asymp P\) and gives
\[
 \|BB^*\|_{2\to2}
 \ll_\varepsilon T^\varepsilon P^{3/2}Q^3.
\tag{22}
\]
Since the actual collapsed coefficient satisfies
\(\|R_\theta\|_2^2\ll T^\varepsilon Q^2\), equation (6) yields
\[
 \sum_{k\asymp P}|(AR_\theta)_k|^2
 =\sum_{k\asymp P}|(BX)_k|^2
 \ll_\varepsilon T^\varepsilon P^{3/2}Q^5.
\tag{23}
\]
The unsaved target is \(PQ^5\). Equation (23) is worse by \(\sqrt P\).
Thus (16) is a row-entry improvement, not a positive-power estimate for
the full critical shell.

Any use of the complementary Möbius signs must return to the primal
\(q\ne q'\) energy before the \(r\)-Cauchy or operator-norm step. The
required object is a curved correlation of
\(R_\theta(r)\overline{R_\theta(r')}\) across the reciprocal Poisson
aliases. No fixed-power bound for that correlation is proved here.
