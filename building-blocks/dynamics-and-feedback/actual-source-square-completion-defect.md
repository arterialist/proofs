# Actual finite-source mismatch from the unrestricted clock maximizer

Developed in the RH Agent3 branch, with independent mathematical review by RH Proof. The full analytic conclusions remain written proofs; compiled finite algebra is linked separately. No novelty or RH claim is made.

Written mathematics, independently audited by the Sol medium math
worker. This retains the nonnegative defect of the established cutoff
process and proves a forced mismatch for its actual arithmetic source.
It does not prove the required signed upper-work estimate, RH, or a
Lean theorem.

Use the conventions of clocked-cutoff-net-work-dissipation.md.
Fix \(c>0\), \(s=c\log n\), \(s_-=c\log(n-1)\), and
\(\Delta=s-s_-\). For the universal real window \(z=Z^\vee\),
\[
\widehat z(\xi)=\beta\xi^2+O(\xi^3),\qquad
\beta=B_0(-1)^2/16>0,\qquad \rho(\xi)\sim\pi|\xi|.
\]
The packet product proves the exact quadratic coefficient; reversal
and fixed translation preserve it. Define the actual finite polynomials
\[
F_{n-1}(\xi)=\sum_{\substack{m<n\\m\text{ odd}}}
\frac{a_m}{\sqrt m}e^{-i\xi\log m},\qquad
d_n(\xi)=\mathbf1_{n\text{ odd}}\frac{a_n}{\sqrt n}e^{-i\xi\log n},
\qquad a_m=\Lambda(m)-2.
\]
The seed \(a_1=-2\) and every odd proper prime power remain included.

## Exact retained defect

The actual previous-state transform and scalar maximizing transform are
\[
u=e^{-s_-\Phi(i\xi)}e^{-iL\xi}\widehat z(\xi)F_{n-1}(\xi),\qquad
u_*=e^{-s_-\Phi(i\xi)}e^{-iL\xi}\widehat z(\xi)
\frac{d_n(\xi)}{e^{2\Delta\rho(\xi)}-1}.
\tag{1}
\]
Indeed \(u_*=\bar t\,\widehat b_n/(1-|t|^2)\), where
\(t=e^{-\Delta\Phi(i\xi)}\) and the new increment receives the
full clock \(s\). Thus the imaginary process phase cancels exactly.
The nonnegative square-completion defect is
\[
\boxed{\mathcal R_n=\frac1{2\pi}\int
\frac{e^{-2s\rho}|\widehat z|^2}{e^{2\Delta\rho}-1}
\left|(e^{2\Delta\rho}-1)F_{n-1}-d_n\right|^2d\xi.}
\tag{2}
\]
The zero frequency is a null point and the neighboring integrand is
integrable. The exact identities are
\[
E_n-E_{n-1}=\mathcal C_n-\mathcal R_n,\qquad
\mathcal R_n=D_n-W_n+\mathcal C_n-B_n.
\tag{3}
\]

## Frozen source and exact cofactor correlations

Let \(A_{n-1}(x)=\sum_{m\le\min(x,n-1),\,m\text{ odd}}a_m\).
For \(w=1/2+i\xi\), finite layer-cake integration gives
\[
F_{n-1}(\xi)=w\int_1^\infty A_{n-1}(x)x^{-w-1}dx.
\tag{4}
\]
Here \(A_{n-1}=E_{n-1}+q_{n-1}\) is the literal frozen original
cumulative source plus its even-power and odd-count correction. The
explicit formulas, with \(u=\min(x,n-1)\), are
\(E_{n-1}(x)=\psi(u)-u\) and
\(q_{n-1}(x)=u-2\lfloor(u+1)/2\rfloor
-(\log2)\lfloor\log u/\log2\rfloor\).
All even Mangoldt powers occur in this exact correction. The
constant terminal tail is part of this integral. Truncating at \(n-1\)
requires adding \(A_{n-1}(n-1)(n-1)^{-w}\).

Define the complete relative-age kernel
\[
K_s(v)=\frac1{2\pi}\int e^{-2s\rho(\xi)}|\widehat z(\xi)|^2
e^{i\xi v}d\xi=\mathbb E C_Z(v+B_s-A_s),
\]
where \(A_s,B_s\) are independent full process histories. Their
no-jump atom and all continuous histories are retained. Then
\[
W_n=2\mathbf1_{n\text{ odd}}\frac{a_n}{\sqrt n}
\sum_{\substack{m<n\\m\text{ odd}}}\frac{a_m}{\sqrt m}
K_s(\log(n/m)),
\tag{5}
\]
\[
D_n=\sum_{\substack{m,l<n\\m,l\text{ odd}}}
\frac{a_ma_l}{\sqrt{ml}}[K_{s_-}-K_s](\log(m/l)),\qquad
B_n=\mathbf1_{n\text{ odd}}\frac{a_n^2}{n}K_s(0).
\tag{6}
\]
Although \(D_n\ge0\) as an operator quadratic form, individual signed
pairs cannot be dropped. These formulas retain the actual cutoff,
successor increment, frozen terminal source, arithmetic powers and
complete multiplicative-age histories.

## Forced gap on the dominant band

Chebyshev and partial summation give, for all real \(\xi\),
\[
|F_{n-1}(\xi)|\le
\sum_{m<n,\,m\text{ odd}}|a_m|m^{-1/2}\le C\sqrt n.
\tag{7}
\]
For fixed \(0<A<B<\infty\), on
\(A/\log n\le|\xi|\le B/\log n\), the cusp and
\(\Delta\asymp c/n\) imply, at odd \(n\),
\[
\left|\frac{(e^{2\Delta\rho}-1)F_{n-1}}{d_n}\right|
\le\frac{C_{A,B,c}}{|a_n|\log n}.
\tag{8}
\]
There is an absolute \(a_*>0\) with \(|a_n|\ge a_*\) for all odd
integers: off prime powers \(a_n=-2\), while at prime powers it is
\(\log p-2\). The elementary series bounds \(8/3<e<3\) put
\(7<e^2<9<11\); thus no odd prime equals \(e^2\), and a finite
small-prime check plus monotonicity gives a positive distance.
Consequently (8) tends to zero uniformly. The actual prefix cannot
approach the maximizing target in (1) on the dominant band.
This is a constraint on the actual finite arithmetic source, rather
than a conclusion about arbitrary causal inputs.

## Integrated cancellation and unresolved signed residual

Scaling \(\xi=y/s\) in the cost integral gives, at odd \(n\),
\[
\mathcal C_n\sim
\frac{3|\beta|^2}{16\pi^6c^5}\frac{a_n^2}{(\log n)^4}.
\tag{9}
\]
Use \(1/(1-e^{-x})\le1+1/x\), the cusp and the off-zero gap to
justify dominated scaling: near zero the scaled inverse-rho integrand
is bounded by \(Ce^{-a|y|}|y|^3\); away from zero it decays
exponentially in \(s\). Specifically,
\[
\frac1{2\pi}\int e^{-2s\rho}\frac{|\widehat z|^2}{\rho}d\xi
\sim\frac{3|\beta|^2}{8\pi^6s^4},\qquad n\Delta\longrightarrow c.
\]
The finite-activity atom does not spoil the off-zero Fourier gap.

Equations (5)-(7) imply
\[
|W_n|\le C|a_n|(\log n)^{-5},\qquad
B_n\le C\frac{a_n^2}{n(\log n)^5},\qquad
D_n\le C(\log n)^{-6}.
\tag{10}
\]
For the last inequality use \(1-e^{-2\Delta\rho}\le2\Delta\rho\),
\(|F_{n-1}|^2\le Cn\), and the integral with small-frequency factor
\(|\xi|^5\), which is \(O((1+s_-)^{-6})\). Divide (3) by (9)
and use the uniform lower bound on \(|a_n|\) to obtain
\[
\boxed{\mathcal R_n/\mathcal C_n=1+O(1/\log n)
\quad(n\to\infty,\ n\text{ odd}).}
\tag{11}
\]
At even \(n\), \(d_n=B_n=W_n=\mathcal C_n=0\) and
\(\mathcal R_n=D_n\); no ratio is asserted.

The actual defect cancels the leading unrestricted cost. However
(11) is not a sufficiently precise cumulative signed estimate:
\(W_n-D_n\) still has no RH-size upper bound. The summed absolute
bounds (10) are weaker than the existing PNT envelope. This does
not upgrade that envelope or prove subpower growth. It locates a
forced actual-source mismatch while retaining its exact signed
residual. The nonnegative defect supplies a lower mismatch constraint;
the required cumulative upper constraint remains unproved.
No signed Weil-form identification, archimedean deletion, or complete
RH/Lean claim is made.
