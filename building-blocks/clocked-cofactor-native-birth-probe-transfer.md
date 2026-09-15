# Exact clocked cofactor-row transfer to the native integer birth history

Attribution: RH Agent3 and its mathematical auditor; independent review by RH Proof.

Written mathematics, independently audited by the Sol medium math worker.
This connects the established actual clocked odd
source row to the actual history field in the compiled local module
BuildingBlocks/IntegerBirthHistory.lean. It does not identify the
two operators or prove a signed upper-work bound, RH, or a new Lean
theorem.

Fix the long-clock regime of
actual-clocked-cofactor-row-positive-average.md:
\(s=c\log n\), \(c>1/x_*\), \(b=n-1\), and
\[
w(x)=x^{-1/2}K_s(\log(n/x)),\qquad 1\le x\le n.
\]
For sufficiently large \(n\), this is positive and decreasing.
Its actual predecessor source row is
\[
R_n=\sum_{\substack{m<n\\m\text{ odd}}}(\Lambda(m)-2)w(m).
\]
Every odd prime power and the coefficient \(-2\) at one are retained.

## Exact actual-history reconstruction

Use the native history field, for integers \(k\ge1\),
\[
F_k=\log k-\sum_{m\le k}\frac{\Lambda(m)}m+\frac{\psi(k)}k.
\]
The zero-index term in the Lean definition contributes zero.
The source module proves
\[
F_{k+1}-F_k=\log(1+1/k)-\frac{\psi(k)}{k(k+1)}.
\]
Rearranging gives exactly
\[
E(k):=\psi(k)-k
=k(k+1)(F_k-F_{k+1})+r_k,\qquad
r_k=k(k+1)\log(1+1/k)-k.
\tag{1}
\]
The inequalities \(t/(1+t)<\log(1+t)<t\), \(t>0\), give
\(0<r_k<1\). This is not a prime-error estimate.
The actual odd cumulative source is
\[
A_o(k)=E(k)+q_k,\quad
q_k=k-2\lfloor(k+1)/2\rfloor
-(\log2)\lfloor\log k/\log2\rfloor.
\tag{2}
\]
The full even prime-power correction is kept in \(q_k\).

## The exact nonnegative probe and both birth endpoints

Define
\[
\theta_k=w(k)-w(k+1)>0\quad(1\le k<b),\qquad
\theta_b=w(b)>0.
\]
Discrete Abel summation gives
\(R_n=\sum_{k=1}^b A_o(k)\theta_k\).
Define a finite native probe by
\[
H_0=0,\qquad H_k=k(k+1)\theta_k\quad(1\le k\le b),
\qquad H_k=0\quad(k>b).
\tag{3}
\]
This probe is nonnegative. Substitution of (1)-(2) yields
\[
R_n=\sum_{k=1}^b H_k(F_k-F_{k+1})+\mathcal C_n^{\rm det},
\qquad
\mathcal C_n^{\rm det}=\sum_{k=1}^b\theta_k(r_k+q_k).
\tag{4}
\]
The finite native birth identity in IntegerBirthHistory applies to
this probe and gives
\[
\boxed{R_n=
\sum_{k=0}^b(H_{k+1}-H_k)F_{k+1}
+\mathcal C_n^{\rm det}.}
\tag{5}
\]
There is no omitted endpoint: the final birth coefficient is
\(H_{b+1}-H_b=-H_b\). The coefficients telescope to zero because
\(H_0=H_{b+1}=0\); this retains rather than deletes the last coefficient.
Although \(F_1=0\), the original odd seed is still present in (1)-(4)
and in the exact odd-count correction. For example at \(k=1\),
\(r_1=2\log2-1\), \(q_1=-1\), and \(F_2-F_1=\log2\), so
(1)-(2) recover \(A_o(1)=-2\) exactly.

## Paid deterministic correction and the terminal spike

The established bounds \(K_s=O(s^{-5})\), \(K_s'=O(s^{-6})\)
give \(\theta_k\le Cs^{-5}k^{-3/2}\) for \(k<b\), and
\(\theta_b\le Cs^{-5}b^{-1/2}\).
Since \(|q_k|\le1+\log k\) and \(0<r_k<1\),
\[
|\mathcal C_n^{\rm det}|
\le Cs^{-5}\left[
\sum_{k\ge1}(2+\log k)k^{-3/2}
+(2+\log b)b^{-1/2}\right]
\le C's^{-5}.
\tag{6}
\]
The seed and parity/power corrections have been bounded, not dropped.

With \(G_0=G(0)=3\beta^2/(4\pi^6)>0\), the uniform kernel profile
and its derivative imply
\[
H_b=[G_0+o(1)]\,b^{3/2}s^{-5},\qquad
H_{b-1}=[G_0/2+o(1)]\,b^{1/2}s^{-5},
\qquad H_b/H_{b-1}\sim2b.
\tag{7}
\]
For the second asymptotic integrate \(-w'\) on \([b-1,b]\);
there \(\log(n/x)=O(1/n)\), \(s^5K_s\to G_0\), and
\(s^5K_s'\to0\). Thus the exact native probe has a terminal spike.
It cannot be replaced by a uniformly smooth or bounded-tail probe
without estimating the resulting boundary error.
The exact combined terminal identity is
\[
H_b(F_b-F_{b+1})+\theta_b(r_b+q_b)=A_o(b)w(b).
\tag{8}
\]
Thus the large adjacent native birth terms must remain paired to
recover the original frozen terminal source. Bounding their
absolute values separately loses this cancellation.

The established successor work remains
\(W_n=2a_nR_n/\sqrt n\) for odd \(n\); at even \(n\) its source
increment is zero. Positivity of \(H\) does not sign the birth
pairing in (5), since the actual history differences in (1)
have no asserted sign. The transferred native probe is not
automatically a compact pole-null Weil test: coefficient sum zero
alone does not prove both physical pole moments or a metric bound.
The original physical packets and complete process histories remain
those of the row kernel.

Equation (5) is an exact source-interface bridge with its actual
terminal shape and correction paid. It leaves the linked signed
arithmetic pairing, its required cumulative upper bound, and all
additional analytic/physical-test admissibility steps open.
Full RH and its complete Lean formalization remain unproved.

## The original native physical probe and its nonzero pole moments

The independent metric consequence in
g-2/outputs/clocked-native-probe-terminal-metric.md evaluates the
literal original-\(dv\) birth synthesis, not a charge-atom lift.
Write \(\lambda_k=H_{k+1}-H_k\), \(0\le k\le b\), and
\[
P_n(v)=\sum_{k=0}^b\lambda_k
e^{-v/2}\mathbf1_{v\ge\log(k+1)}.
\]
On \(\log k\le v<\log(k+1)\), \(1\le k\le b\), this is exactly
\(e^{-v/2}H_k\). It vanishes outside \([0,\log n]\), up to
irrelevant endpoint values. Thus it is nonnegative and nonzero.
Its original metric is
\[
\|P_n\|_{L^2(dv)}^2=\sum_{k=1}^b\frac{H_k^2}{k(k+1)}
=[G_0^2+o(1)]\,b/s^{10}.
\]
Agent3 independently checked the cell identity and the terminal
dominance in that metric note. This is a written calculation, not
a new Lean certification of the asymptotic.

For the physical moments \(M_a(P)=\int e^{av}P(v)dv\), exact cell
integration gives
\[
\boxed{M_{-1/2}(P_n)=\sum_{k=1}^b\frac{H_k}{k(k+1)}
=\sum_{k=1}^b\theta_k=w(1)>0,}
\tag{9}
\]
\[
\boxed{M_{1/2}(P_n)=\sum_{k=1}^bH_k\log(1+1/k)
=-\sum_{k=0}^b\lambda_k\log(k+1)>0.}
\tag{10}
\]
The second equality in (10) is finite Abel summation. For its
integral formula one must combine the births before integrating:
the individual birth's positive pole moment diverges, although
the compact combined probe has a finite moment.
In particular \(\sum\lambda_k=0\) cancels the physical tail,
not either physical pole moment.

The established full kernel profile yields
\[
M_{-1/2}(P_n)=[G(1/c)+o(1)]s^{-5},\qquad
M_{1/2}(P_n)=[2G_0+o(1)]\,\sqrt b\,s^{-5}.
\tag{11}
\]
For the positive moment the terminal cell alone contributes
\([G_0+o(1)]\sqrt b\,s^{-5}\).
For the interior, integrate the exact formula for \(-w'\):
for \(k/b\) bounded away from zero,
\(H_k=[G_0/2+o(1)]\sqrt k\,s^{-5}\).
The global bound \(H_k\le C\sqrt k\,s^{-5}\), and
\(\log(1+1/k)\le1/k\), allow the small-\(k/b\) part to be
bounded by \(C\sqrt{\varepsilon b}\,s^{-5}\).
Riemann summation on the remaining interval then gives the
other \([G_0+o(1)]\sqrt b\,s^{-5}\) contribution.

Both pole moments are strictly positive for any nonzero
nonnegative finite probe of this form, not just asymptotically.
Convolving it with a fixed nonnegative nonzero smooth compact
bump preserves this obstruction: each moment is multiplied
by the bump's strictly positive corresponding moment.
Translation multiplies moments by nonzero exponential factors.
Neither operation produces a pole-null test.

This concerns the canonical native physical probe. It does
not invalidate the original pole-null packets used to construct
the row kernel, or exclude a different pole-killing observation.
Such an observation changes the probe/pairing and still needs
its own exact source and metric transfer. In the native history
pairing, the deterministic logarithmic part is exactly
\(\sum\lambda_k\log(k+1)=-M_{1/2}(P_n)<0\);
the remaining Mangoldt-prefix compensation is retained and
has no asserted sign. This definite partial contribution
does not bound the complete signed arithmetic work.
The unmodified native probe therefore cannot be treated as
a compact pole-null Weil test, and its positive Gram norm
does not supply the missing RH argument.
