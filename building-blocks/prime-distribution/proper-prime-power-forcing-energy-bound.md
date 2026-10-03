# An absorbable forcing bound for all proper prime powers

For the actual von Mangoldt function, including every prime power, put

\[
\psi(t)=\sum_{n\le t}\Lambda(n),\qquad
z_c(t)=\frac{\psi(t)-t+c}{t},\qquad
E_{\sigma,c}(Y)=\int_1^Y z_c(t)^2t^{1-2\sigma}\,dt.
\]

The center \(c\) is fixed throughout each history. Define the entire proper-power forcing by the value **before** each birth:

\[
P_{\sigma,c}(Y)=
\sum_{\substack{p^k\le Y\\p\text{ prime},\ k\ge2}}
(\log p)(p^k)^{1-2\sigma}z_c((p^k)^-),
\qquad
z_c(n^-)=\frac{\psi(n-1)-n+c}{n}.
\]

For **every real \(c\), every real \(\sigma\ge1/2\), and every real \(Y\ge1\)**,

\[
\boxed{|P_{\sigma,c}(Y)|
\le24\log(2Y)\sqrt{E_{\sigma,c}(Y)}
+3000\log^2(2Y).}
\tag{1}
\]

Consequently, for **every real \(\eta>0\)** on the same full range,

\[
\boxed{|P_{\sigma,c}(Y)|\le
\eta E_{\sigma,c}(Y)
+(3000+144/\eta)\log^2(2Y).}
\tag{2}
\]

This is an unconditional written proof, using elementary integer counting and finite factorial/Chebyshev bounds. It assumes no PNT, zero-free estimate, RH, prime independence or supplied energy bound. The [Lean geometry companion](../../formalization/BuildingBlocks/ActualPrimePowerWindowGeometry.lean) checks window support, same-exponent disjointness, unique actual rows and the necessary distinction between different exponents. The integral trace and forcing inequalities remain written; their [verification record](../../formalization/verification/actual-prime-power-window-geometry/README.md) states that boundary explicitly.

Both displayed bounds also hold with the left side replaced by the sum of the absolute values of **all** its summands. The proof takes no cancellation between proper powers. Any additional coefficients of modulus at most one are therefore admissible without a new price.

The estimate prices all repeated-generator atoms by an arbitrarily small fraction of the **same complete error energy** and a logarithmic-square remainder. The ordinary-prime forcing and continuous density still require their own upper. No stronger complete signed RH bound or RH-frontier advance is claimed.

## Causal sampling from the actual integer clock

For \(n=p^k\ge4\), use the left window
\[
I_n=[n-\sqrt n,n].
\]
It lies inside \([1,Y]\) whenever \(n\le Y\). For every real \(t\in I_n\), \(t<n\), the integers strictly between \(t\) and \(n\) number at most \(n-t\), and each has \(\Lambda(m)\le\log n\). Thus, with \(e_c(t)=\psi(t)-t+c\),
\[
|e_c(n^-)-e_c(t)|\le\sqrt n(1+\log n).
\]
The center cancels before division. Averaging this inequality, applying interval Cauchy, and using \(t^{1+2\sigma}\le n^{1+2\sigma}\) give
\[
|z_c(n^-)|\le n^{\sigma-3/4}\sqrt{V_n}
+n^{-1/2}(1+\log n),\qquad
V_n=\int_{I_n}z_c(t)^2t^{1-2\sigma}dt.
\tag{3}
\]
The post-jump endpoint is a singleton of zero measure. It is not substituted for the pre-jump atom. There is no future window or uncharged point trace.

## Group by exponent before taking the energy norm

For integer bases \(2\le p<q\) and \(k\ge2\),
\[
p^k+q^{k-1}\le q^k,\qquad \sqrt{q^k}\le q^{k-1}.
\]
The first follows from \(p^k\le p q^{k-1}\) and \(p+1\le q\); the second follows from \(2(k-1)\ge k\). Hence windows for a fixed exponent have disjoint interiors. For positive bases the separation is strict, so the closed windows are also disjoint; this stronger fact is kernel checked.

Accordingly \(\sum_{p^k\le Y}V_{p^k}\le E_{\sigma,c}(Y)\) for each fixed \(k\). Write \(E=E_{\sigma,c}(Y)\). After multiplying (3) by the force coefficient and applying finite Cauchy at each exponent, its first term is at most
\[
\sqrt E\sum_{k\ge2}
\left(\sum_{p^k\le Y}(\log p)^2p^{k(1/2-2\sigma)}\right)^{1/2}.
\]
With \(M_Y=\sum_{p\le\sqrt Y}(\log p)^2/p\), every inner sum is at most \(2^{-(k-2)/2}M_Y\). Thus the whole term is at most
\[
\frac{\sqrt{M_Y}}{1-2^{-1/4}}\sqrt E.
\tag{4}
\]
This geometric allocation pays all exponents. Windows of different exponents can overlap: eight \(=2^3\) and nine \(=3^2\) both contain seven in their interiors. That actual overlap is also kernel checked.

## Native arithmetic masses and explicit constants

The existing [harmonic Mangoldt bounds](../../formalization/BuildingBlocks/PrimeSignedAverage.lean) and [finite Abel second-mass bound](../../formalization/BuildingBlocks/PrimeIncrementEnergyAbel.lean) give, for \(N\ge1\),
\[
\sum_{n\le N}\frac{\Lambda(n)}n\le\log N+4\log2,
\quad
\sum_{n\le N}\frac{\Lambda(n)\log n}n
\le\tfrac12\log^2N+(4\log2+\tfrac32)\log N.
\]
They use the actual factorial floor identity and Chebyshev bound; no prime-distribution hypothesis is present. Restricting their nonnegative sums to primes and taking \(N=\lfloor\sqrt Y\rfloor\) bounds \(M_Y\), for \(Y\ge4\), by
\[
\tfrac18\log^2Y+\tfrac12(4\log2+\tfrac32)\log Y.
\]
Let \(\ell=\log(2Y)\). Since \(1/2<\log2<1\), this is less than \(6\ell^2\), so \(\sqrt{M_Y}\le3\ell\). The rational inequality \((8/7)^4<2\) gives \((1-2^{-1/4})^{-1}<8\). Equation (4) is therefore at most \(24\ell\sqrt E\).

The second term of (3) has total allowance
\[
R_Y\le\sum_{k\ge2,p^k\le Y}
(\log p)p^{-k/2}(1+k\log p).
\]
At \(k=2\), the same masses bound it by \(29\ell^2\). For every higher exponent, \(r=p^{-1/2}<3/4\), so
\[
\sum_{k\ge3}r^k\le4p^{-3/2},\qquad
\sum_{k\ge3}kr^k\le24p^{-3/2}.
\]
For \(j=1,2\), comparison on each interval \([n-1,n]\) gives
\[
\sum_{n\ge2}\frac{(\log n)^j}{n^{3/2}}
\le\int_1^\infty\frac{(\log t+1)^j}{t^{3/2}}dt.
\]
These integrals equal six and twenty-six. All higher powers therefore cost at most \(4\cdot6+24\cdot26=648\le2592\ell^2\). Hence \(R_Y\le2621\ell^2\le3000\ell^2\). This proves (1), and Young's inequality supplies the exact coefficient \(144/\eta\) in (2). For \(Y<4\) the forcing is empty. The head \(Y=1\) and every fractional cutoff are included.

## Comparison and use in the complete work

For the canonical center \(c=1+\gamma\), grouping all windows into a single overlap density gives the coarser finite price \(O((1+\log Y)^{5/2}\sqrt E+(1+\log Y)^4)\), hence \(\eta E+O_\eta((1+\log Y)^5)\). Exponent-wise disjointness and the prime second mass lower that absorbed critical price to logarithmic-square size, with the explicit center-independent constants above. Both prices are subpower. For each fixed strict \(\sigma>1/2\), the same method also retains the stronger cutoff-independent allowance \(C_\sigma\sqrt E+C'_\sigma\), since the two prime-power coefficient series converge. No constant uniform at the strict infinite-tail endpoint is asserted. No priority claim is made.

For the actual center \(c=1+\gamma\), let
\[
U_\sigma(Y)=\sum_{p\le Y}(\log p)p^{1-2\sigma}z_c(p^-)
-\int_1^Y t^{1-2\sigma}z_c(t)dt.
\]
This ordinary-prime bracket retains the **full \(\psi\) history** and continuous density. It is distinct from replacing that history by \(\theta\). The complete predictable work splits exactly as \(A_\sigma=U_\sigma+P_{\sigma,c}\). Its full jump balance and (2) yield
\[
\tfrac12Y^{2-2\sigma}z_c(Y)^2+(\sigma-\eta)E_{\sigma,c}(Y)
\le\tfrac12\gamma^2+U_\sigma(Y)
+(3000+144/\eta)\log^2(2Y)
+\tfrac12\sum_{n\le Y}\Lambda(n)^2n^{-2\sigma}.
\tag{5}
\]
The initial head, inclusive terminal storage and every proper-power diagonal remain. Choosing \(\eta=1/4\) leaves an energy coefficient at least one quarter throughout the stated range.

A separately proved sufficient subpower upper on this complete ordinary-prime bracket would control the actual error energy and feed the existing continuation/coarse RH consumers. At every dyadic critical cutoff, finite diagonal bounds and shell summation give that route without an endpoint-uniform constant. Equation (5) does not supply the missing upper on \(U_\sigma\). It is supporting arithmetic, not a complete RH estimate.

## Verification and limits

Separate GPT-6.1 Sol/xhigh agent contexts independently reconstructed the sampling, exponent allocation, arithmetic inputs, all-real parameter range, constants and complete-work substitution. The coordinator reconstructed the proof. These are disclosed mathematical checks, not a human referee report.

The native companion covers finite integer/prime-power geometry only. Staircase sampling, interval Cauchy, integral summation, infinite exponent allocation, logarithmic tail integrals, the final forcing inequality and its energy substitution remain written and unformalized. The finite mass bounds cited above were already formalized. No full ordinary-prime upper, eventual \(W\) sign, coarse criterion premise or RH proof is claimed.
