# The theta prime-profile square is a weighted Goldbach pair row

The prime profile in the actual ground-clock comparison is a one-prime arrival. Squaring it introduces a second Mangoldt label. Regrouping those two labels by their ordinary sum gives a literal, positive Goldbach-type row, with a three-ground overlap as its weight. This identifies an additive statistic inside the theta covariance calculation. It does not bound that statistic or the affine residual.

Fix \(R>0\), let \(g_R(u)=\Phi(u)\psi_R(u)1_{u>R}\) be the positive-half physical ground, and choose \(U>R\). Put \(g_c=g_R1_{u<U}\) and \(a_n=\Lambda(n)/\sqrt n\), for every integer \(n\ge2\). On \(R<u<U\), the compact-collar cross-prime arrival is
\[
 T_{p,c}(u)
 =2e^{u/2}\sum_{n\ge2}a_n g_c(\log n-u).
\tag{1}
\]
This is the exact [prime cross profile](theta-cross-arrival-density-calibration.md) with both physical endpoints restricted to the collar. The full ground clock has \(d\gamma(u)=e^{-u/2}g_R(u)du\) on the positive half. Write \(d\gamma_c=e^{-u/2}g_c(u)du\) there and reflect it evenly.

Define the nonnegative three-ground kernel
\[
 H_c(n,m)=\int_R^U e^{u/2}g_c(u)
       g_c(\log n-u)g_c(\log m-u)\,du.
\tag{2}
\]
The sum in (1) is finite on this compact collar. Tonelli's theorem and evenness give the exact full-collar second moment
\[
 \boxed{\quad
 \int_{O_R}T_{p,c}(u)^2\,d\gamma_c(u)
 =8\sum_{n,m\ge2}
   \frac{\Lambda(n)\Lambda(m)}{\sqrt{nm}}H_c(n,m).
 \quad}
\tag{3}
\]
The left integral uses the even extension of \(T_{p,c}\), and \(\gamma_c\) vanishes outside the two collars. Every prime power and both ordered label pairs remain. The corresponding first moment is
\[
 \int T_{p,c}\,d\gamma_c
 =4\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
            (g_c*g_c)(\log n)=4P_c.
\tag{4}
\]
Thus the first moment is the familiar opposite-half convolution; the second moment is a genuinely two-label statistic.

## Regroup by the additive sum

Let \(N=n+m\). Equation (3) becomes
\[
 \boxed{\quad
 \int T_{p,c}^2\,d\gamma_c
 =8\sum_{N\ge4}\ \sum_{2\le n\le N-2}
 \frac{\Lambda(n)\Lambda(N-n)}{\sqrt{n(N-n)}}
 H_c(n,N-n).
 \quad}
\tag{5}
\]
This is an additive convolution, unlike the distinct-prime coefficient in the multiplicative \(V/W\) source. The ordinary weighted Goldbach count
\(R_\Lambda(N)=\sum_{n+m=N}\Lambda(n)\Lambda(m)\)
appears with the extra reciprocal-square-root and ground-overlap factors. Positivity or existence of one representation of an even \(N\) supplies no upper bound for (5).

The support is precise. If \(H_c(n,m)>0\), then
\[
 e^{2R}<n,m<e^{2U},
 \qquad |\log(n/m)|<U-R.
\tag{6}
\]
For the proved endpoint collar take \(X=e^{2R}\),
\(w=8X^{-19/40}\), and \(U=R+16w\). Both labels then lie in
\((X,X+Y)\), where \(Y=X(e^{32w}-1)=O(X^{21/40})\), and their additive difference is \(O(X^{21/40})\). The contributing Goldbach sums lie in \((2X,2X+2Y)\). The row probes near-diagonal representations of these moving sums, weighted by the actual ground.

Parity cannot be suppressed. For odd \(N\), exactly one of \(n,N-n\) is even, so a nonzero Mangoldt term requires that label to be a power of two. For even \(N\), the row includes odd-prime-power pairs and pairs of powers of two. At the endpoint collar there is at most one power of two in \((X,X+Y)\) for all sufficiently large \(R\), since \(Y=o(X)\). Its contribution to the square (5) still cannot be discarded using a label count alone: \(H_c(n,m)\) may concentrate on that label. This is the distinction between Goldbach existence, complete prime-power weights, and an upper second-moment estimate.

## The exact profile-error consumer

Let \(c_{\rm dens}=\mu_R-a_R=\int e^{|u|}d\gamma\), the density coefficient in the [actual profile calibration](theta-cross-arrival-density-calibration.md). For the compact row set
\(\mathcal P_c=T_{p,c}-c_{\rm dens}e^{|u|}\) on the two collars. Then
\[
 \|\mathcal P_c\|_{L^2(\gamma_c)}^2
 =\int T_{p,c}^2d\gamma_c
  -2c_{\rm dens}\int e^{|u|}T_{p,c}\,d\gamma_c
  +c_{\rm dens}^2\int e^{2|u|}d\gamma_c.
\tag{7}
\]
The first term is exactly (5). The middle term is another complete one-prime sum:
\[
 \int e^{|u|}T_{p,c}\,d\gamma_c
 =4\sum_{n\ge2}a_n\int_R^U
           e^u g_c(u)g_c(\log n-u)\,du.
\tag{8}
\]
Equations (5), (7), and (8) keep the cancellation required for the profile error. Bounding (5) alone cannot establish smallness of (7).

The endpoint ground theorem controls the normalized tail of \(\psi_R\) and the first prime moment outside the collar. It does not yet control the weighted square \(T_p^2d\gamma\) there uniformly in \(R\); the available \(L^\infty\) bound for \(\psi_R\) has no useful moving-radius constant. Nor do present short-interval prime counts control the ground-dependent weights \(H_c(n,m)\). A valid additive route to the affine residual needs a cancellation-aware upper bound for (7), its tail, and the score-coupled entries of the [conditional edge form](theta-affine-comparison-conditional-edge-energy.md). The identity alone proves neither Goldbach's conjecture nor RH.

This is written algebra and analysis on a compact collar, with no Lean formalization claimed. The parity and support statements use the complete von Mangoldt sequence, not a prime-only replacement.
