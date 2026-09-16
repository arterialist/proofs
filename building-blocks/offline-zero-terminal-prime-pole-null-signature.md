# A hypothetical off-line zero in a terminal-prime odd Weil packet

RH Agent3, 2026-09-17; independently audited. This isolates the exact terminal-prime functional and the *formal isolated-zero contribution* of a hypothetical zero \(\rho=\tfrac12+\sigma+i\gamma\), \(0<\sigma<1/2\), \(\gamma\ne0\). The complete explicit formula contains every zero, archimedean term, and pole; a single isolated-zero component is not the value or sign of the actual Weil form. No contradiction with an off-line zero or proof of RH is obtained.

Fix \(B>0\) and a real \(g_a\in C_c^\infty(0,B)\) with bounded smooth norms, and let \(a>2B\). Define an odd two-boundary-shell test by
\[
 F_a(x)=g_a(a-x)\quad(a-B<x<a),\qquad F_a(-x)=-F_a(x),
\tag{1}
\]
and zero elsewhere. Put \(N=e^{2a}\), \(k_a=g_a*g_a\), and
\(M_a(z)=\int_0^B e^{-zy}g_a(y)dy\). Then \(\|F_a\|_2^2=2\|g_a\|_2^2\), and the odd archimedean logarithmic form is \(O_g(1)\): translation of a fixed smooth shell only changes Fourier phases, while its Fourier envelope decays rapidly.

The odd pole moment vanishes **exactly** iff
\[
 \boxed{M_a(1/2)=e^{-a}M_a(-1/2).}
\tag{2}
\]
Indeed \(\int_0^a\sinh(x/2)F_a(x)dx
=\tfrac12[e^{a/2}M_a(1/2)-e^{-a/2}M_a(-1/2)]\). This kills the Laplace evaluation at \(z=1/2\), up to the exact reflected endpoint term; it does not kill an evaluation at \(z=\sigma+i\gamma\).

For \(0<s<2B\), direct overlap of the two opposite boundary shells gives
\[
 \boxed{C_{F_a}(2a-s)
 :=\int_{\mathbb R}F_a(x)F_a(x+2a-s)dx
 =-k_a(s).}
\tag{3}
\]
The only other nonzero shift correlations have \(0\le\ell<B\), from same-side shell overlap. Consequently the *actual* prime pairing splits exactly into a bounded low-shift part and a terminal-prime part:
\[
 \langle F_a,P_aF_a\rangle
 =P_{\rm low}(g_a)
 -2\sum_{Ne^{-2B}<n<N}\frac{\Lambda(n)}{\sqrt n}
       k_a\!\left(\log\frac Nn\right),
 \qquad P_{\rm low}(g_a)=O_g(1).
\tag{4}
\]
All admitted proper powers are retained. Here \(P_{\rm low}\) uses only \(n<e^B\), a finite set independent of \(a\).

Within this fixed terminal band, proper prime powers contribute only \(O_g(1)\) to the pairing. The square weights sum to
\(\sum_{e^{a-B}<p<e^a}(\log p)/p=B+o(1)\) by prime-number-theorem partial summation; the weights of powers \(p^r\), \(r\ge3\), have a globally convergent sum. Thus an \(e^{2\sigma a}\) isolated-zero signature would belong to ordinary terminal primes, while the exact identity still retains every proper power.

Replacing \(d\psi(x)\) by \(dx\), the **complete** terminal continuum pairing factors:
\[
 \begin{aligned}
 P_{\rm terminal,cont}(g_a)
 &=-2e^a\int_0^{2B}e^{-s/2}k_a(s)ds\\
 &=-2e^aM_a(1/2)^2
 =-2e^{-a}M_a(-1/2)^2=O_g(e^{-a}).
 \end{aligned}
\tag{5}
\]
The second equality is exactly the Laplace-convolution product. Thus a pole-null boundary packet cancels the order-\(e^a\) *complete* terminal continuous-prime pairing. It does not force each sub-band to be small. For fixed \(0<R<2B\), the band \(Ne^{-R}<n<N\) has continuous pairing
\[
 P_{R,\rm cont}(g_a)
 =-2e^a\int_0^R e^{-s/2}k_a(s)ds,
\tag{6}
\]
which can be positive and of order \(e^a\) for a signed two-bump \(g_a\). The complementary band has the opposite leading term by (5). Ordinary PNT transfers (6) to the actual prime band with an \(o(e^a)\) error for fixed smooth profiles, but that error is vastly larger than the \(O_g(1)\) archimedean form.

One concrete pole-null family uses two disjoint translates of a narrow nonnegative bump \(b\): \(g_a(y)=b(y-y_0)-c_ab(y-y_1)\), \(0<y_0<y_1<B\), where \(c_a\) is the ratio of their integrals against \(e^{-y/2}-e^{-a}e^{y/2}\). Then (2) holds and \(c_a\to e^{(y_1-y_0)/2}\). For any specified \(z=\sigma+i\gamma\) with \(\sigma<1/2\), choose the bump narrow enough that its Laplace transform at \(z\) is nonzero. The limiting \(M_0(z)\) is then nonzero: up to that bump transform,
\[
 M_0(z)=e^{-zy_0}
 \left[1-e^{(1/2-z)(y_1-y_0)}\right],
\tag{7}
\]
whose bracket cannot vanish because its second term has modulus greater than one. For an \(R\) after the negative cross-convolution peak but before the second positive self-convolution peak, the integral in (6) is negative, hence the band pairing is positive. The complete leading pairing still cancels.

Now suppose, only to identify its signature, that a hypothetical zero \(\rho\) contributes the standard explicit-formula component \(E_\rho(x)=-x^\rho/\rho\) to \(E(x)=\psi(x)-(x-1)\). The contribution of this component to the exact terminal signed prime-minus-continuum pairing is
\[
 \begin{aligned}
 \mathcal R_{\rho,a}(g_a)
 &=2\int x^{-1/2}C_{F_a}(\log x)\,dE_\rho(x)\\
 &=2e^{2a(\rho-1/2)}
       \int_0^{2B}e^{-(\rho-1/2)s}k_a(s)ds\\
 &=\boxed{2e^{2a(\sigma+i\gamma)}M_a(\sigma+i\gamma)^2.}
 \end{aligned}
\tag{8}
\]
The upper and lower integration limits in the first line are the terminal interval \((Ne^{-2B},N)\). A conjugate zero adds the complex conjugate; the reflected zeros at \(1-\rho\) and \(1-\overline\rho\) contribute only \(O(e^{-2\sigma a})\) for this fixed shell. Thus the isolated quartet has leading signature
\[
 4e^{2\sigma a}
 \operatorname{Re}\!\left[e^{2i\gamma a}M_0(\sigma+i\gamma)^2\right]
 +o(e^{2\sigma a}),
\tag{9}
\]
with an oscillating sign as \(a\) varies, provided \(M_0(\sigma+i\gamma)\ne0\). The exponential tilt is the complex Laplace weight \(e^{-(\sigma+i\gamma)s}\) across the **remaining terminal gap** \(s=2a-\log n\); the physical packet itself can have a fixed smooth profile translated to the boundary. Fixed \(\gamma\) alone is not an order-\(e^a\) all-prime resonance.
The prime contribution to the Weil form is the **negative** of this pairing, so a positive value of (9) would push the form downward before all other zero, archimedean, and pole contributions are included.

Equations (2), (5), and (8) answer the pole question. Pole-nullity suppresses the continuous-prime mode at \(z=1/2\), whereas an off-line zero probes \(z=\sigma+i\gamma\); the two evaluations are independent for signed shell profiles. The multiplicative Laplace factorization in (5) is a cancellation identity, not a new sign constraint from additive succession. To contradict a hypothetical zero, one would need an *actual-arithmetic* bound or sign for the complete signed discrepancy in (4) at the \(e^{2\sigma a}\) scale, with other zeros controlled. No such bound follows from the factorization or the PNT error \(o(e^a)\). This is precisely the unproved RH-scale input, rather than a consequence of the \(+1\) geometry alone.

There is also an exact check against the [positive factorial ground](factorial-f-ground-actual-covariance-sign-obstruction.md). Let
\(\mathfrak F(x)=\log x-\sum_{n\le x}\Lambda(n)/n+\psi(x)/x>0\), for which
\(\mathfrak F'(x)=-(E(x)-1)/x^2\) almost everywhere and
\(d(x^2\mathfrak F')=-dE\). Set
\(f_a(x)=x^{-1/2}k_a(\log(N/x))\), supported in the terminal interval. Two Stieltjes integrations by parts, with vanishing smooth endpoints, give the **exact** signed terminal discrepancy
\[
 \begin{aligned}
 P_{\rm terminal,actual}-P_{\rm terminal,cont}
 &=-2\int f_a(x)\,dE(x)\\
 &=2\int\mathfrak F(x)x^{-1/2}
 \left[k_a''\!\left(\log\frac Nx\right)
       -\frac14k_a\!\left(\log\frac Nx\right)\right]dx.
 \end{aligned}
\tag{10}
\]
The bracket is necessarily signed for nonzero compact smooth \(k_a\): its integral against \(e^{-s/2}ds\) is zero because \(e^{-s/2}\) solves the adjoint homogeneous equation, while an everywhere nonnegative or nonpositive nonzero bracket would have nonzero weighted integral. Thus positivity of \(\mathfrak F\), although forced by the complete divisor/successor history, cannot sign (10). A hypothetical zero contributes a decaying \(x^{\rho-1}\) oscillation to \(\mathfrak F\) and an amplified \(e^{2\sigma a}\) oscillation after the terminal rescaling in (10); the baseline positivity does not exclude it.
