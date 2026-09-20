# Smooth determinant-shift estimate in the one-\(Q\) Gram kernel

**Status:** unconditional written estimate, 20 September 2026. The Lean
companion checks only the scale and exponent algebra. The history
provenance, determinant count, Cauchy reduction, and second-derivative
estimate remain written mathematics. For every fixed
\[
 0<\kappa<\frac{q_0}{3}=\frac{\lambda}{15},
\]
this note proves a fixed power saving for
\[
 |h|\le P Q^{4/3}T^{-\kappa}
\]
in the Gram kernel arising from the actual one-\(Q\) Poisson endpoint. It
does not estimate the remaining large determinant range, extend the Möbius
prefix by itself, or imply the Riemann hypothesis.

## Endpoint sum and the only coefficient input

Put
\[
 q_0=\frac{\lambda}{5},\qquad p=1-\frac{2\lambda}{5},\qquad
 Q=T^{q_0},\qquad P=T^p,\qquad N=Q^5,
 \qquad 2<\lambda<\frac{29}{14}.
\tag{1}
\]
Then
\[
 PQ^2=T,\qquad P^3<PQ.
\tag{2}
\]

The leading contribution in the
[one-\(Q\) Poisson endpoint](actual-mobius-critical-one-q-poisson-endpoint.md)
is
\[
 \mathcal S_{\mathrm{lead}}
 =P^{-1/2}
 \sum_{\substack{k\asymp P,\ m\asymp PQ\\n,r\asymp Q}}
 a_kb_m\beta(n)\delta(r)V_{k,m,n,r}
 e\!\left(-2\sqrt{\frac{kNm}{nr}}\right).
\tag{3}
\]
The coefficients are divisor bounded, \(V\) is jointly inert, and
\[
 \sum_{n\asymp Q}|\beta(n)|^2\ll_\varepsilon T^\varepsilon Q.
\tag{4}
\]

The bound (4) is part of the exact endpoint theorem. Its arithmetic
provenance is the positive ordered all-unit residual of two successive
\(K=3\) expansions. After factorwise dyadic rectangularization, a fixed
history is a one- or two-atom restricted divisor convolution, with the
common product cutoff separated before it becomes an autonomous
one-variable coefficient. No Möbius sign is discarded in obtaining (4).
The full history derivation is in the
[\(K=3\) bottom-slice note](actual-mobius-k3-bottom-slice-saving.md).

No pointwise or Fourier information about \(\beta\) is needed below.

## Weighted Cauchy and exact Gram normalization

Write
\[
 \mathcal D=P^{1/2}\mathcal S_{\mathrm{lead}}
 =\sum_{n\asymp Q}\beta(n)A_n.
\]
Use (4) directly in Cauchy's inequality:
\[
 |\mathcal D|^2
 \le \left(\sum_{n\asymp Q}|\beta(n)|^2\right)
      \left(\sum_{n\asymp Q}|A_n|^2\right)
 \ll_\varepsilon T^\varepsilon Q\,\mathcal G.
\tag{5}
\]
The Gram kernel is now smooth in \(n\):
\[
\begin{aligned}
 \mathcal G={}&
 \sum_{n\asymp Q}
 \sum_{\substack{k,k'\asymp P\\m,m'\asymp PQ\\r,r'\asymp Q}}
 a_k\overline{a_{k'}}b_m\overline{b_{m'}}
 \delta(r)\overline{\delta(r')}\\
 &\quad\times
 V_{k,m,n,r}\overline{V_{k',m',n,r'}}
 e\!\left(-2\sqrt N\,n^{-1/2}
 \left[\sqrt{km/r}-\sqrt{k'm'/r'}\right]\right).
\end{aligned}
\tag{6}
\]
In particular, \(|\beta(n)|^2\) does not occur in (6).

Since \(\mathcal S_{\mathrm{lead}}=P^{-1/2}\mathcal D\),
\[
 |\mathcal S_{\mathrm{lead}}|^2
 \ll_\varepsilon T^\varepsilon\frac QP\,\mathcal G.
\tag{7}
\]
The endpoint target
\[
 |\mathcal S_{\mathrm{lead}}|\ll_\varepsilon
 T^\varepsilon P Q^{5/2}
\tag{8}
\]
has square \(P^2Q^5\). Its exact Gram target is therefore
\[
 \mathcal G\ll_\varepsilon T^\varepsilon
 \frac PQ\,P^2Q^5
 =T^\varepsilon P^3Q^4.
\tag{9}
\]

## Determinant representations

Put
\[
 u=km\asymp U:=P^2Q,\qquad u'=k'm'\asymp U,\qquad
 h=ur'-u'r.
\tag{10}
\]
For fixed \(h\ne0\) and fixed \(r,r'\asymp Q\), let \(d=(r,r')\).
Equation (10) has no solution unless \(d\mid h\). If \(d\mid h\), the
possible \(u\)'s lie in one residue class modulo \(r/d\), giving
\[
 O(Ud/Q+1)=O(P^2d+1)
\tag{11}
\]
choices. Writing \(r=da,\ r'=da'\), and discarding \((a,a')=1\) for an
upper bound, gives
\[
 \begin{aligned}
 R(h)&:=\#\{(u,u',r,r'):ur'-u'r=h\}\\
 &\ll \sum_{d\mid h}(Q/d)^2(P^2d+1)
 \ll_\varepsilon T^\varepsilon P^2Q^2.
 \end{aligned}
\tag{12}
\]
The restricted representations \(u=km,\ u'=k'm'\), divisor-bounded
coefficients, and inert weights cost fixed divisor moments, already
absorbed into \(T^\varepsilon\).

For \(h=0\), write \(r=da,\ r'=da'\), with \((a,a')=1\). The relation
\(ur'=u'r\) forces \(u=av,\ u'=a'v\). Summing the
\(O(P^2d+1)\) possible \(v\)'s gives
\[
 R(0)\ll_\varepsilon T^\varepsilon P^2Q^2.
\tag{13}
\]

## The smooth \(n\)-sum

For a fixed outer tuple in (6), put
\[
 \beta_0=2\sqrt N
 \left(\sqrt{\frac{km}{r}}-\sqrt{\frac{k'm'}{r'}}\right).
\tag{14}
\]
Rationalizing the difference in (14) with (10) gives, on
\(|h|\asymp H\),
\[
 |\beta_0|\asymp \frac{Q^{1/2}H}{P}.
\tag{15}
\]
The jointly inert amplitude in (6), as a function of \(n/Q\), has uniform
derivative bounds. For
\[
 f(x)=-\beta_0x^{-1/2}
\]
and \(x\asymp Q\),
\[
 |f''(x)|\asymp\frac{H}{PQ^2}.
\tag{16}
\]
The classical van der Corput second-derivative estimate, together with the
trivial bound, therefore gives
\[
 K(H):=
 \left|\sum_{n\asymp Q}W_{\mathrm{out}}(n/Q)e(-\beta_0n^{-1/2})\right|
 \ll_\varepsilon T^\varepsilon
 \min\!\left(
 Q,\sqrt{\frac HP}+\sqrt{\frac{T}{H}}
 \right).
\tag{17}
\]
A reference for the two-term estimate, uniform in interval endpoints, is
O. Robert, [*On van der Corput's \(k\)-th derivative test for exponential
sums*, §3.1](https://perso.univ-st-etienne.fr/rool6510/robert-2015-indag.pdf).

Let \(\mathcal G_H\) be the part of (6) with \(1\le|h|\asymp H\).
Equations (12) and (17) give
\[
 |\mathcal G_H|
 \ll_\varepsilon T^\varepsilon H P^2Q^2K(H).
\tag{18}
\]

## Three shift ranges

For \(1\le H\le P\), use \(K(H)\ll Q\). Then
\[
 |\mathcal G_H|
 \ll_\varepsilon T^\varepsilon H P^2Q^3
 \le T^\varepsilon P^3Q^3,
\tag{19}
\]
which is below the target (9) by \(Q^{-1}\).

For \(P\le H\le PQ\), the second term in (17) dominates:
\[
 |\mathcal G_H|
 \ll_\varepsilon T^\varepsilon
 P^2Q^2(TH)^{1/2}.
\tag{20}
\]
Relative to (9), its ratio is
\[
 \frac{(TH)^{1/2}}{PQ^2}
 =\frac{H^{1/2}}{P^{1/2}Q}
 \le Q^{-1/2}.
\tag{21}
\]

For \(PQ\le H\), the first term in (17) dominates:
\[
 |\mathcal G_H|
 \ll_\varepsilon T^\varepsilon
 P^{3/2}Q^2H^{3/2}.
\tag{22}
\]
Its ratio to (9) is exactly
\[
 \left(\frac{H}{P Q^{4/3}}\right)^{3/2}.
\tag{23}
\]
Fix
\[
 0<\kappa<\frac{q_0}{3}.
\tag{24}
\]
For
\[
 H\le P Q^{4/3}T^{-\kappa},
\tag{25}
\]
equation (23) is at most \(T^{-3\kappa/2}\). The bound in (21) is
\(T^{-q_0/2}\), which is stronger because \(3\kappa/2<q_0/2\).
Consequently all nonzero dyadic shifts in (25) satisfy
\[
 |\mathcal G_H|
 \ll_\varepsilon
 T^\varepsilon P^3Q^4T^{-3\kappa/2}.
\tag{26}
\]
Summing the logarithmically many blocks in (26) gives
\[
 \sum_{\substack{H\ \mathrm{dyadic}\\
 H\le P Q^{4/3}T^{-\kappa}}}
 |\mathcal G_H|
 \ll_\varepsilon
 T^\varepsilon P^3Q^4T^{-3\kappa/2}.
\tag{27}
\]
After multiplication by \(Q/P\) in (7) and a square root, this part of
the absolute Gram upper bound has scale
\[
 T^\varepsilon P Q^{5/2}T^{-3\kappa/4}.
\tag{28}
\]
This is not a separately defined subsum of \(\mathcal S_{\mathrm{lead}}\).
It does not bound the full sum until the remaining Gram blocks are
controlled.

The upper range in (25) lies strictly above \(PQ\), since
\[
 \frac{P Q^{4/3}T^{-\kappa}}{PQ}
 =T^{q_0/3-\kappa}>1.
\tag{29}
\]
It therefore also lies above \(P^3\) by (2). The canonical choice
\(\kappa=q_0/6\) gives upper shift \(P Q^{7/6}\), Gram saving
\(Q^{-1/4}\), and square-root scale saving \(Q^{-1/8}\).

No cancellation between different determinant shifts is used. Each
dyadic block is bounded by (18), and the logarithmic number of blocks is
absorbed into \(T^\varepsilon\).

## Diagonal and endpoint terms

Using (13) and the trivial smooth \(n\)-sum,
\[
 |\mathcal G_0|
 \ll_\varepsilon T^\varepsilon P^2Q^3
 =T^\varepsilon P^3Q^4(PQ)^{-1}.
\tag{30}
\]
After multiplication by \(Q/P\) in (7) and a square root, the diagonal
has scale
\[
 T^\varepsilon P^{1/2}Q^2
 =T^\varepsilon P Q^{5/2}(PQ)^{-1/2}
\tag{31}
\]
in the absolute Gram upper bound.

The number of coefficient histories and separator pieces is
\(T^\varepsilon\). The public one-\(Q\) endpoint assigns hard endpoints
before smoothing; its endpoint errors save \(Q^{-1/2}=T^{-q_0/2}\)
relative to (8). This is stronger than the square-root scale in (28), since
\(3\kappa/4<q_0/4<q_0/2\). Lower stationary terms have smaller inert
amplitudes. These losses do not change (27)--(28).

The estimate stops at \(H=P Q^{4/3}T^{-\kappa}\). The margin in (23)
vanishes at \(H\asymp P Q^{4/3}\). Completing the endpoint power saving
requires a separate estimate for the remaining large determinant range.

[ActualMobiusLowShiftGramSaving.lean](../../formalization/BuildingBlocks/ActualMobiusLowShiftGramSaving.lean)
checks the three range exponents, the parameterized saving in (26)--(28),
the strict extension above \(PQ\) and \(P^3\), and the canonical choice
\(\kappa=q_0/6\). Its
[axiom audit](../../formalization/verification/ActualMobiusLowShiftGramSavingAudit.lean)
checks every declaration in the module. Lean does not formalize the
history expansion, determinant counts, weighted Cauchy reduction, or
second-derivative estimate.
