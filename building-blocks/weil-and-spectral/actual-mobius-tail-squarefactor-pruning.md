# Square-factor pruning in the balanced Möbius shell

**Status:** unconditional written component-shell reduction, 20 September
2026.
The local prime-power values used below are formalized in
[`ActualMobiusConvolution.lean`](../../formalization/BuildingBlocks/ActualMobiusConvolution.lean).
The square-factor decomposition and shell estimate are written mathematics,
not Lean. The coefficient \(\mu*\mu\) is obtained only after the exact
free-factor cancellation in the corrected balanced-shell audit; it is not
obtained by discarding the cross term on each slice. The shell belongs to a
new partition of the globally rewritten sum. This note does not control all
complementary regions, prove the remaining signed estimate, enlarge the
complete Möbius cutoff, or prove the Riemann hypothesis.

## Exact coefficient decomposition

Let

\[
 c=\mu*\mu.
\]

Its local values are

\[
 c(p)=-2,
 \qquad c(p^2)=1,
 \qquad c(p^j)=0\quad(j\geq3).
\tag{1}
\]

Consequently, every \(q\) in the support of \(c\) is cube-free and has a
unique representation

\[
 q=g^2n,
 \qquad \mu^2(g)=\mu^2(n)=1,
 \qquad (g,n)=1,
\tag{2}
\]

where \(g\) is the product of the primes occurring in \(q\) to exponent
two and \(n\) is the product of those occurring to exponent one. From (1),

\[
 c(g^2n)=\mu(n)2^{\omega(n)}=\mu(n)\tau(n).
\tag{3}
\]

The last equality uses the squarefreeness of \(n\). In particular,

\[
 |c(g^2n)|=\tau(n).
\tag{4}
\]

## Removing large square factors

Consider the physical shell obtained after the global recombination in the
[balanced audit](actual-mobius-tail-balanced-hard-shell.md):

\[
 \mathcal H_{t,J,Q}=
 \frac1{L\sqrt N}
 \sum_{k\asymp J}\gamma_k
 \sum_{q\asymp Q}c(q)W_k(q/Q)
 e\!\left(-\frac{kN}{tq}\right),
\tag{5}
\]

where \(t\asymp1\), \(J\asymp L\), \(|\gamma_k|\leq1\), and the normalized
shell weights are bounded up to the established \(T^\varepsilon\) losses.
Let \(\mathcal H_{>G}\) denote the portion with the square factor in (2)
satisfying \(g>G\). Taking absolute values only on this portion and dropping
the squarefree and coprimality restrictions gives

\[
\begin{aligned}
 |\mathcal H_{>G}|
 &\ll_\varepsilon
 \frac{T^\varepsilon J}{L\sqrt N}
 \sum_{G<g\ll\sqrt Q}
 \sum_{n\asymp Q/g^2}\tau(n)\\
 &\ll_\varepsilon
 \frac{T^\varepsilon J}{L\sqrt N}
 \sum_{g>G}\frac{Q\log(2Q)}{g^2}\\
 &\ll_\varepsilon
 \frac{T^\varepsilon Q}{G\sqrt N}.
\end{aligned}
\tag{6}
\]

This estimate is uniform in the reciprocal phase, all modulus-one Mellin
and Fourier characters, hard or smooth \(q\)-shell cutoffs, and bounded
\(t\). Off the physical shell, the first line retains the factor \(J/L\);
the existing packet multiplier handles its shell sum.

The normalization in (6) can be checked directly from (5). With
\(|W_k|\ll T^\varepsilon\) and \(|\gamma_k|\leq1\),

\[
\begin{aligned}
 |\mathcal H_{>G}|
 &\leq \frac{T^\varepsilon}{L\sqrt N}
       \#\{k:k\asymp J\}
       \sum_{g>G}\sum_{n\asymp Q/g^2}\tau(n)\\
 &\ll \frac{T^\varepsilon J}{L\sqrt N}
       \sum_{g>G}\frac{Q\log(2Q)}{g^2}\\
 &\ll \frac{T^\varepsilon JQ}{L\sqrt N\,G}.
\end{aligned}
\tag{6a}
\]

On the physical shell \(J\asymp L\), this is (6). Triangle inequality
removes cancellation but does not remove the external Poisson normalization
\((L\sqrt N)^{-1}\); counting the \(k\)-terms replaces only \(1/L\) by
\(J/L\). Thus the alternative bound \(Q/G\) would omit a factor already
present in the normalized shell definition.

## Endpoint threshold

Write

\[
 Q=T^d,
 \qquad G=T^\gamma.
\]

The exponent in (6) is

\[
 d-\gamma-\frac\lambda2.
\tag{7}
\]

At the current endpoint

\[
 d_*=\frac{2(\lambda+1)}5,
\]

the threshold is

\[
 \gamma_0=d_*-\frac\lambda2=\frac{4-\lambda}{10}.
\tag{8}
\]

Fix \(\kappa>0\) and take

\[
 G=T^{\gamma_0+\kappa}.
\tag{9}
\]

After choosing the harmless \(\varepsilon<\kappa/2\), equation (6) gives

\[
 \boxed{|\mathcal H_{>G}|\ll T^{-\kappa/2}.}
\tag{10}
\]

Thus this component shell may be restricted, with a fixed power error, to

\[
 g\leq T^{(4-\lambda)/10+\kappa}.
\tag{11}
\]

On this surviving range, \(q\asymp Q\) forces

\[
 n\gg\frac{Q}{G^2}
 =T^{\lambda-d_*-2\kappa}
 =Q^{\frac{3\lambda-2}{2\lambda+2}-\frac{2\kappa}{d_*}}.
\tag{12}
\]

Equivalently, for every sufficiently small fixed \(\epsilon_0>0\), one may
choose a fixed \(\kappa>0\) so that the discarded part saves a fixed
\(\epsilon_0\)-dependent power and the remaining squarefree variable obeys

\[
 n\gg Q^{\frac{3\lambda-2}{2\lambda+2}-\epsilon_0}.
\tag{13}
\]

One cannot replace the fixed loss in (12) by \(o(1)\) while retaining the
fixed power in (10): taking \(\kappa=o(1)\) yields only a subpower cutoff
gain.

## Remaining signed core

Up to the power-saving error (10), the shell (5) is exactly

\[
 \frac1{L\sqrt N}
 \sum_{k\asymp J}\gamma_k
 \sum_{\substack{g\leq G\\\mu^2(g)=1}}
 \sum_{\substack{n\asymp Q/g^2\\\mu^2(n)=1\\(g,n)=1}}
 \mu(n)\tau(n)W_k(g^2n/Q)
 e\!\left(-\frac{kN}{tg^2n}\right).
\tag{14}
\]

The variable \(g\) is the common square-divisor component exposed only after
the two Möbius factors are recombined. Therefore (6) is not the existing
Type-I removal in different notation. The surviving sum is also not covered
verbatim by the current Type-I theorem: \(g\) enters the phase as \(g^2\),
the long signed coefficient is \(\mu(n)\tau(n)\), and the coprimality
condition remains. Equation (14) is a narrower exact target, not an endpoint
extension.

## Exact one-factor decomposition

Put

\[
 A(n)=\mu(n)\tau(n),
 \qquad h=\mu*A.
\tag{15}
\]

Since \(\mu\) vanishes off the squarefree integers, the Euler factor of
\(A\) at a prime is \(1-2z\). Hence

\[
 A=\mathbf 1*h,
 \qquad
 h(p)=-3,
 \quad h(p^2)=2,
 \quad h(p^j)=0\quad(j\geq3).
\tag{16}
\]

where \(\mathbf 1(n)=1\). In particular, \(h\) is multiplicative and
\(|h(d)|\leq\tau_3(d)\). The convolution identity and all three local
values in (16) are proved in Lean in
`formalization/BuildingBlocks/ActualMobiusConvolution.lean`. The analytic
estimates below are written proofs.

Substitute \(n=dq\) in (14), retain \(d\leq V\), and preserve both
coprimality conditions. The remaining long condition is removed exactly by

\[
 1_{(q,g)=1}=\sum_{\substack{r\mid g\\r\mid q}}\mu(r).
\tag{17}
\]

Writing \(q=r\ell\) leaves the long variable \(\ell\) unweighted and puts
the product \(g^2dr\) in the short coefficient. Bourgain's exponent-pair
estimate therefore applies to the actual smooth bounded-variation packet
weights. The resulting coefficient sum is bounded by

\[
 Q^{1/2}F^{13/84}
 \sum_{g\leq G}\frac1g
 \sum_{r\mid g}\frac1{\sqrt r}
 \sum_{\substack{d\leq V\\(d,g)=1}}
       \frac{|h(d)|}{\sqrt d}.
\tag{18}
\]

The elementary estimates

\[
 \sum_{d\leq V}\frac{|h(d)|}{\sqrt d}
 \ll V^{1/2}(\log(2V))^C,
 \qquad
 \sum_{g\leq G}\frac1g\sum_{r\mid g}\frac1{\sqrt r}
 \ll\log(2G)
\tag{19}
\]

then give, on the physical shell \(J\asymp L\) and \(F\asymp T\),

\[
 \boxed{
 \mathcal H_{d\leq V}
 \ll_\varepsilon
 \frac{T^\varepsilon}{\sqrt N}
 \left(T^{13/84}Q^{1/2}V^{1/2}+\frac QT\right).}
\tag{20}
\]

The Kusmin--Landau coefficient sum is only polylogarithmic because

\[
 \sum_g\frac1{g^2}\sum_{r\mid g}\frac1r
 \sum_{d\leq V}\frac{|h(d)|}{d}\ll(\log T)^C.
\tag{21}
\]

The off-shell factors are also retained: the exponent-pair term carries
\((J/L)F^{13/84}\), while the Kusmin--Landau term has
\((J/L)/F=1/T\). Thus the existing packet decomposition sums (20)
uniformly without discarding the nonphysical shells.

If \(V=T^v\), the first term in (20) has exponent

\[
 \frac{d+v-\lambda}{2}+\frac{13}{84}.
\tag{22}
\]

At \(d=d_*\), it saves a fixed power whenever

\[
 v<\lambda-d_*-\frac{13}{42}
   =\frac{3\lambda-2}{5}-\frac{13}{42}.
\tag{23}
\]

This proves cancellation for a nonempty fixed initial divisor range. It does
not move the endpoint.

## Long-divisor remainder and mean-square target

Absolute values do not make the complementary range \(d>V\) small. Indeed,

\[
 \sum_{n\asymp M}
 \left|\sum_{\substack{d\mid n\\d>V}}h(d)\right|
 \leq
 M\sum_{V<d\leq2M}\frac{|h(d)|}{d},
\tag{24}
\]

which has no negative power of \(V\). Reversing the convolution leaves the
long signed coefficient \(h(d)\) outside the Bourgain estimate. Expanding
\(\mu*\mu\) directly has the same defect with a long Möbius coefficient.

Even a generic reciprocal second moment of the favorable shape

\[
 \sum_{k\asymp L}
 \left|\sum_{n\asymp M}A(n)e(-kC/n)\right|^2
 \ll_\varepsilon T^\varepsilon(LM+M^2)
\tag{25}
\]

would give only

\[
 T^\varepsilon\left(\sqrt{Q/N}\log(2G)+\sqrt{Q/T}\right)
\tag{26}
\]

after normalization. At the endpoint the second term is
\(T^{(2\lambda-3)/10}\), so it grows. A sufficient genuinely signed target
would instead be

\[
 \sum_{k\asymp L}
 \left|\sum_{n\asymp M}A(n)e(-kC/n)\right|^2
 \ll_\varepsilon T^\varepsilon
 \left(LM+M^2T^{-\rho}\right),
 \qquad \rho>d-1.
\tag{27}
\]

For a final margin \(T^{-\eta}\), one needs
\(\rho\geq d-1+2\eta\); at \(d=d_*\), the strict threshold is
\(\rho>(2\lambda-3)/5\). This is a two-point reciprocal correlation estimate
for the actual coefficient \(\mu(n)\tau(n)\), not an ordinary coefficient
mean square. No such estimate is proved here.
