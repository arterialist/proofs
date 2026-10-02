# Gaussian recovery of the complete critical numerator

The literal complete numerator can be recovered from a logarithmic Gaussian
average with an error proportional to \(\tau\) and a separate integer-seam
term proportional to \(\sqrt\tau\).
The estimate uses the actual von Mangoldt divisor identity. It retains all
prime powers, integer cofactors and the unit origin. The estimate does not
provide the stronger signed upper bound needed for RH.
For recovery of an upper bound, the error needs only one logarithm.

## Object and full range

Let \(\Lambda\) be the actual von Mangoldt function and let
\(b=\Lambda*\Lambda\), with Dirichlet convolution. For \(t>1\), put
\[
 U(t)=\sum_{a\le t}(t-a)b(a)
 -\sum_{a\le t}\Lambda(a)\frac{t^2-a^2}{a}
 +\frac{t^2}{2}\log t+\frac{t^2}{4}-\frac14,
 \qquad U(t)=0\quad(t\le1).
\]
The complete row in the
[actual Eq. 22 Mellin formula](actual-eq22-zero-cluster-bound.md) is
\[
 F(x)=N_{\rm full}(x)=\sum_{d\le x}\sqrt d\,U(x/d)
 \quad(x>1),\qquad F(x)=0\quad(x\le1).
 \tag{1}
\]
Every equality-cutoff contribution vanishes in the value. The convolution
\(b\) includes same-prime pairs and every proper prime power.

Define the logarithmic Gaussian average
\[
 T_\tau F(x)=\frac1{\sqrt{4\pi\tau}}
 \int_{\mathbb R}e^{-u^2/(4\tau)}F(xe^u)\,du.
 \tag{2}
\]
Here \(\tau\) is a regularization parameter; (2) averages both earlier
and later cutoffs.

**Theorem.** There is an absolute constant \(C>0\) such that, for every
real \(x\ge2\) and every \(0<\tau\le1\),
\[
 \boxed{
 |T_\tau F(x)-F(x)|\le
 C\bigl(\tau x^2+\sqrt\tau\,x\bigr)\log^2(2x).}
 \tag{3}
\]
No cutoff, integer center or small positive \(\tau\) is excluded. The
constant is independent of both parameters; no explicit numerical value
is supplied.

The direct first-derivative estimate gives
\(O(\sqrt\tau\,x^2\log(2x))\). Equation (3) improves its order in the
polynomially shrinking windows relevant to recovering a prime-error power
bound. Taking the minimum of these two valid estimates preserves the
first-derivative estimate over the rest of the stated range.

On the same full range, there is also the stronger **one-sided** estimate
\[
 \boxed{F(x)\le T_\tau F(x)+
 C(\tau x^2+\sqrt\tau\,x)\log(2x).}
 \tag{3a}
\]
The constant is absolute. Equation (3a) improves recovery of signed upper
bounds; it does not replace the absolute value bound (3).

## Arithmetic birth bound

The seed is continuous, \(U'(1+)=1\), and its derivative jump at an integer
\(a\ge2\) is \(b(a)-2\Lambda(a)\). On open integer cells,
\[
 U''(t)=\log t+2-2\sum_{a<t}\frac{\Lambda(a)}a.
\]
Consequently the complete derivative jump, including the newly admitted
cofactor at every \(n\ge1\), is
\[
 J_n=F'(n+)-F'(n-)
 =\frac{1+\sum_{a\mid n}\sqrt a\,[b(a)-2\Lambda(a)]}{\sqrt n}.
 \tag{4}
\]
The origin gives \(J_1=1\); it has not been removed by centering.

For the actual arithmetic function,
\(\sum_{d\mid n}\Lambda(d)=\log n\). Nonnegativity and Dirichlet
convolution therefore give
\[
 \sum_{a\mid n}b(a)
 =\sum_{d\mid n}\Lambda(d)\log(n/d)
 \le\log^2 n.
\]
Since \(\sqrt{a/n}\le1\) on every divisor,
\[
 \boxed{|J_n|\le\frac1{\sqrt n}+\log^2n+2\log n
 \ll\log^2(2n),\qquad n\ge1.}
 \tag{5}
\]
Thus no divisor-count loss or short-interval prime estimate is needed.
The logarithmic identity ties the generator weights to the ordinary
integer's numerical size. Positivity of arbitrary generator weights alone
does not supply this bound.

For the negative part, nonnegativity of \(b\) gives the sharper bound
\[
 J_n\ge n^{-1/2}-2\log n,\qquad n\ge1.
 \tag{5a}
\]
The complete [jump sign classification](complete-prime-history-jump-sign.md)
identifies every negative coefficient, including the prime-power exceptions.
Equation (3a) needs only (5a).

Chebyshev's elementary bound \(\psi(t)\ll t\) and partial summation give
\(\sum_{a\le t}\Lambda(a)/a\ll\log(2t)\) and
\(\sum_{a\le t}b(a)=\sum_u\Lambda(u)\psi(t/u)\ll t\log(2t)\).
The seed and the convergent cofactor sum \(\sum d^{-3/2}\) then imply
\[
 |F'(x\pm)|\ll x\log(2x),\qquad
 |F''(x)|\ll\log(2x)
 \quad\text{off integer seams},\qquad
 |F(x)|\ll x^2\log(2x).
 \tag{6}
\]
These are unconditional elementary estimates. They also justify (2).

## Gaussian recovery, including every seam

Set \(f(v)=F(e^v)\), with its zero extension for \(v\le0\).
Its distributional second derivative is
\[
 f''=r(v)\,dv+\sum_{n\ge1}nJ_n\,\delta_{\log n},
 \quad r(v)=e^{2v}F''(e^v)+e^vF'(e^v)
 \quad(v>0\text{ off seams}).
 \tag{7}
\]
Below zero, \(r=0\). The regular bound is
\(|r(v)|\ll e^{2v}\log(2e^v)\) for \(v>0\). The second term in \(r\)
is the multiplicative Taylor bias and remains in the calculation.

For a centered Gaussian \(G\) of variance \(2\tau\), define
\[
 L_\tau(v)=\mathbb E(G-|v|)_+.
\]
This nonnegative even kernel satisfies
\[
 L_\tau(0)=\sqrt{\tau/\pi},\quad
 L_\tau(v)\le\sqrt{\tau/\pi}\,e^{-v^2/(4\tau)},\quad
 \int_{\mathbb R}L_\tau(v)\,dv=\tau.
\]
Averaging the central-second-difference formula against \(|G|\) gives
the exact identity
\[
 T_\tau F(x)-F(x)
 =\int_{\mathbb R}L_\tau(v)r(\log x+v)\,dv
  +\sum_{n\ge1}nJ_nL_\tau(\log(n/x)).
 \tag{8}
\]
One may first truncate the derivative measure and then pass to the limit.
Gaussian decay dominates (5)--(6), so all integrals and sums converge
absolutely. The atom exactly at \(x=n\) remains in (8); no two-sided
derivative at that center is assumed.

Gaussian exponential moments bound the regular part by
\(O(\tau x^2\log(2x))\), uniformly for \(0<\tau\le1\).
For the atomic part, put
\[
 g(t)=t\log^2(2t)
       e^{-\log^2(t/x)/(4\tau)},\qquad t\ge1.
\]
Its logarithmic derivative is
\(1+2/\log(2t)-\log(t/x)/(2\tau)\), which strictly decreases in
\(\log t\). Thus \(g\) is unimodal. Its maximum lies between
\(x\) and \(xe^{5\tau}\), and is \(O(x\log^2(2x))\).
The sum-integral comparison yields
\[
 \sum_{n\ge1}g(n)
 \le\int_1^\infty g(t)\,dt+2\sup_{t\ge1}g(t).
\]
Substitute \(t=xe^v\) and complete the square to get
\[
 \int_1^\infty g(t)\,dt
 \le x^2\int_{\mathbb R}e^{2v}
       [\log(2x)+v]^2e^{-v^2/(4\tau)}\,dv
 \ll\sqrt\tau\,x^2\log^2(2x).
\]
Equations (5) and (8) now bound the atomic part by
\(O((\tau x^2+\sqrt\tau\,x)\log^2(2x))\), proving (3).
Both infinite Gaussian tails and the unit-origin atom have been included.

For (3a), keep the regular contribution in (8) with its bound
\(O(\tau x^2\log(2x))\), and discard the nonnegative atoms when bounding
\(F-T_\tau F\) from above. Equation (5a) bounds each remaining atom by
\(2n\log n\). Replace \(g\) by
\(g_1(t)=t\log(2t)e^{-\log^2(t/x)/(4\tau)}\).
Its logarithmic derivative is
\(1+1/\log(2t)-\log(t/x)/(2\tau)\), so the same unimodal
sum-integral argument gives
\[
 \sum_{n\ge1}g_1(n)\ll
 (\sqrt\tau\,x^2+x)\log(2x).
\]
For its integral, use \(\log(2xe^v)\le\log(2x)+|v|\) on
\(v\ge-\log x\), and then the whole-line Gaussian moments.
Multiplying by the kernel factor \(\sqrt\tau\) proves (3a), uniformly
over its stated full range. No prime-count estimate in a short interval
or omission of a Gaussian tail is used.

## Why the seam term remains

For every fixed integer \(n\ge2\), the exact kernel identity gives
\[
 T_\tau F(n)-F(n)
 =nJ_n\sqrt{\tau/\pi}+O_n(\tau),\qquad \tau\downarrow0.
\]
Hence an error of order \(O(\tau)\) alone cannot hold at a seam with
\(J_n\ne0\).
For distinct large primes of comparable size, \(n=pq\) has
\[
 J_{pq}=2\log p\log q
 -\frac{2\log p}{\sqrt q}-\frac{2\log q}{\sqrt p}
 +\frac1{\sqrt{pq}}
 =(\tfrac12+o(1))\log^2(pq).
\]
The seam contribution can therefore have the order retained in (3).
At a prime, \(J_p=p^{-1/2}-2\log p\), so the negative seam has
logarithmic size and the \(\sqrt\tau\) term also remains in (3a).

## Connection and limits

The [long tilted Gaussian average](long-gaussian-complete-critical-numerator.md)
has an unconditional pole-and-saddle asymptotic at
\(\tau=3\log x/2\). Recovering the original numerator from that different
average requires an additional estimate that remains unproved.

The estimate quantifies recovery of the original source. For example,
\(\tau_x=x^{-1/4}\) makes its error
\(O(x^{7/4}\log^2(2x))\). A uniform signed upper bound of that order
for \(T_{\tau_x}F(x)\) would give the corresponding upper for \(F(x)\).
That smoothed-source bound has not been proved.

For the existing RH-scale target, fix \(1\le\alpha<2\) and \(\eta>0\),
and take
\[
 \tau_x=x^{-1/2}\log^{\alpha-1-\eta}(2x).
\]
This lies in \((0,1]\) eventually. Equation (3a) gives the one-sided
recovery
\(F(x)\le T_{\tau_x}F(x)+o(x^{3/2}\log^\alpha(2x))\).
If a uniform signed upper of that scale were proved for the smoothed
source, the same bound would hold for \(N_{\rm full}\). The known diagonal
asymptotic would then imply eventual nonpositivity of
\(W=N_{\rm full}-Z\mathcal D\), which is consumed by the
[kernel-checked critical-sign theorem](../zeta-and-zeros/actual-critical-sign-criterion.md).
The additional signed input is unproved; this conditional deduction is not
an RH result. A varying \(\tau_x\) is used here through (3a), not through
an assumed fixed Mellin multiplier.

The [Lean coefficient module](../../formalization/BuildingBlocks/FullPrimeHistoryJumpBound.lean)
checks the finite arithmetic declarations, including (5), (5a) and the
exact prime coefficient, with every divisor and prime power and \(J_1=1\).
The connection of that literal
coefficient to the continuum derivative, the Chebyshev estimates, the
distributional Gaussian identity, moment and sum-integral estimates,
and the asymptotic recovery deduction remain written analysis. The full
inequalities (3) and (3a) have not been formalized in Lean.

All audited declarations use only `propext`, `Classical.choice` and
`Quot.sound`, with no placeholders or custom axioms. Check the module from
the repository root with `lake build BuildingBlocks.FullPrimeHistoryJumpBound`.

The identities and Gaussian argument use established methods. This note
applies them to the complete actual critical numerator; it makes no
originality claim for those methods or a stronger prime-error power bound.
