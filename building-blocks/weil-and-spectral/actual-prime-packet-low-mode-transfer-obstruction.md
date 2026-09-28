# Two missing low modes in the prime-packet to coarse-energy transfer

**Status:** exact functional obstruction and dependency audit, 28 September
2026. The moment and Hilbert-space calculations below are written
mathematics, not Lean-formalized. They do not refute a future argument
using additional facts about the actual von Mangoldt function. No RH
claim is made.

The [double-\(Q\) Gram source](actual-mobius-double-q-full-rank-gram.md)
has the Cauchy step
\[
|\mathcal S_{\rm crit}|^2\ll_\varepsilon
T^\varepsilon\frac{Q^2}{P}J_{\rm all}.
\tag{1}
\]
Even granting a full compatible fixed-center estimate
\(J_{\rm all}\ll_\varepsilon T^\varepsilon
P^3Q^3T^{-2\rho}\), equation (1) yields only
\(\mathcal S_{\rm crit}\ll_\varepsilon
T^\varepsilon P Q^{5/2}T^{-\rho}\) for the selected critical
response. Other histories, incompatible Poisson charts, and endpoint
terms require their own estimates.

There is a further independent transfer gap. The exact physical
packet \(g_{N,T}\) in
[the Möbius-tail source](actual-mobius-tail-three-dimensional-saving.md),
Eq. (13), has
\[
\int_0^\infty g_{N,T}(x)\,dx=0,\qquad
\int_0^\infty g_{N,T}(x)\log x\,dx=0.
\tag{2}
\]
Fix a finite collection of neighboring dyadic \(N\)-scales. All
packets in that collection have support in a common compact interval
\([cX,CX]\), and the two moment functionals in (2) are continuous on
\(L^2([cX,CX])\). Consequently the closed linear span of **all**
these packets has codimension at least two. Varying the center and
allowed \(T\) cannot synthesize a test with a nonzero ordinary or
logarithmic moment by an \(L^2\)-convergent linear combination of
the packets alone.

This excludes the actual low boundary-sine tests from such a
packet-only synthesis. Write
\[
w_{j,X}(x)=1_{[X,2X]}(x)
\sin\!\left(\pi j\frac{x-X}{X}\right).
\]
For odd \(j\), \(\int w_{j,X}=2X/(\pi j)\ne0\). For even \(j=2m\),
the ordinary integral vanishes but
\(\int w_{j,X}(x)\log x\,dx<0\): after \(x=X(1+u)\), pair each
positive half-period of \(\sin(2\pi m u)\) with its following negative
half-period; the sine magnitudes agree while \(\log(1+u)\) strictly
increases. Thus every \(w_{j,X}\) lies outside the packet span.
The constant terminal test lies outside it as well.

The obstruction can be seen without primes. Replace the actual source
by the continuous density \(d\nu_A=(1+A)\,dx\), so its error is
\(E_A(x)=Ax\). Every packet pairing vanishes by (2), yet the coarse
primitive energy is
\[
\int_X^{2X}\left[
\left(\int_X^t E_A(x)\,dx\right)^2+
\left(\int_t^{2X} E_A(x)\,dx\right)^2
\right]dt
=\frac{91}{60}A^2X^5.
\tag{3}
\]
This is a counterexample to a **packet-only functional implication**;
it is not a counterexample for the actual \(\Lambda\), whose additional
arithmetic structure a future proof could use.

The precise missing arithmetic consumer is visible in
[the coarse boundary-sine reduction](../prime-distribution/coarse-primitive-boundary-sine-reduction.md):
for every dyadic \(X\), one needs a terminal estimate
\(M_X^2\ll_\varepsilon X^{3+\varepsilon}\) and a weighted
low-sine estimate
\(\sum_{1\le j\le X^{1/4}}|T_j(X)|^2/j^4
\ll_\varepsilon X^{1+\varepsilon}\), with the exact endpoint
and every prime power retained. Together with its unconditional
high-mode tail, these imply the Lean premise
\(\mathrm{CoarsePrimitiveBound}\). Neither estimate
follows from (1) or from (2).

The obstruction is therefore narrow and exact: a fixed-power
\(J_{\rm all}\) theorem would be valuable for its critical packet,
but a route to the coarse-energy premise must separately recover the
terminal and low-sine directions, or use a new source-specific
arithmetic estimate for them.
