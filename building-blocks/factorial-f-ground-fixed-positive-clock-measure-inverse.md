# Fixed-positive-clock factorization of the actual dyadic Chebyshev score

RH Agent3, 2026-09-16. Independently audited by RH Agent1. **Status:** written linearized criterion and exact full-ground clock-to-clock transfer, without an arithmetic RH-scale estimate; not Lean formalized. The [subsequent prime-atomic inverse](factorial-f-ground-full-score-rh-criterion.md) proves that the full original-ground score itself is an RH-equivalent criterion for the actual source. This closes the fixed-small-positive-clock half-line inversion left open in the [moving-score note](factorial-f-ground-dyadic-score-inversion.md). The arithmetic input is the actual
\[
D(x)=2\psi(x)-\psi(2x),\qquad
f(u)=e^{-u}D(e^u)\quad(u\ge0), \tag{1}
\]
which is bounded and tends to zero by PNT, with every \(\Lambda(p^k)\) present. The complete age law \(\mathsf P_s\) retains every prime and proper-power interval. No bound for the actual score is asserted here: the result is an RH-equivalent **criterion** and an exact form-preserving inversion.

## A finite causal measure hidden in the squared profile

Put \(h(t)=te^{-t/2}{\bf1}_{t\ge0}\), \(j_s=h*\mathsf P_s\), \(H_s=j_s^2\), and
\[
K_s=H_s-D_tH_s=j_s^2-2j_sj_s',\qquad
g_s(u)=\mathcal D_{e^u,s}=\int_0^\infty K_s(t)f(u+t)\,dt. \tag{2}
\]
All derivatives below are causal distributional derivatives on \(\mathbb R\), so endpoint atoms are retained. At \(s=0\), \(H_0=t^2e^{-t}{\bf1}_{t\ge0}\), and direct differentiation (or its Laplace transform) gives
\[
(D_t+1)^3H_0=2\delta_0. \tag{3}
\]
Define the causal signed distribution
\[
\boxed{\quad \mu_s=\tfrac12(D_t+1)^3H_s.\quad} \tag{4}
\]
It is in fact a **finite signed measure** for every bounded \(s\). To see this quantitatively near zero, write \(p_s=e^{-\lambda s}\), \(\mathsf P_s=p_s\delta_0+v_s(t)dt\), and \(k_s=h*v_s\). The actual Lévy density
\[
v(t)=\sum_p\frac{e^{t/2}p^{-\lfloor t/\log p\rfloor-1}{\bf1}_{t\ge\log p}}{t}
\]
lies in \(BV\cap L^1\): each prime's \(k\)-th interval and endpoint have variation \(O(p^{-(k+1)/2}/(k\log p))\), whose sum is \(O((p\log p)^{-1})\); Chebyshev gives \(\sum_p(p\log p)^{-1}<\infty\). The compound-Poisson expansion gives, for \(0\le s\le1\),
\[
\|v_s\|_1=1-p_s\le\lambda s,\qquad
\|Dv_s\|_{\rm TV}\le s\|Dv\|_{\rm TV}. \tag{5}
\]
Now \(H_s=p_s^2H_0+Q_s\), \(Q_s=2p_s h k_s+k_s^2\). Causal differentiation yields
\[
k_s'=h'*v_s,\quad
k_s''=h''_{\rm reg}*v_s+v_s,\quad
k_s'''=h'''_{\rm reg}*v_s-v_s+Dv_s. \tag{6}
\]
The regular derivatives of \(h\) are exponentially integrable and bounded. Equations (5)--(6), Young's inequality, and \(v_s\in BV\) give \(k_s,k_s',k_s''\in L^1\cap L^\infty\) with norms \(O(s)\), and \(D^3k_s\) a finite measure of total variation \(O(s)\). Since \(k_s\) vanishes on \([0,\log2)\), multiplying by \(h\) kills the \(\delta_0,\delta_0'\) terms in \(D^3h\). The product rule therefore proves
\[
\sum_{\ell=0}^2\|D^\ell Q_s\|_1+\|D^3Q_s\|_{\rm TV}\le C_3s \quad(0\le s\le1), \tag{7}
\]
for a finite \(C_3\) depending only on the explicit complete density and \(h\)-norms. Combining (3)--(4) and (7),
\[
\boxed{\quad
\mu_s=p_s^2\delta_0+\tfrac12(D_t+1)^3Q_s,\qquad
\|\mu_s-\delta_0\|_{\rm TV}
\le C_\mu s,\quad C_\mu=2\lambda+4C_3.
\quad} \tag{8}
\]
The coefficient \(4C_3\) is the sum of the binomial coefficients divided by two. No threshold is dropped: \(Q_s(t)=p_s^2s(t-\log2)_+^2/4+O_s((t-\log2)_+^3)\) near the first prime-two onset, so \(\mu_s\) has an atom of mass \(p_s^2s/4\) at \(t=\log2\), in addition to its atom \(p_s^2\) at zero. All later prime and prime-power threshold channels are contained in the finite measure \(\mu_s\).

The measure is genuinely **signed**. At \(t=2L\), \(L=\log2\), the prime-two density drops from \(1/(4L)\) to \(1/(8L)\), a jump \(-1/(8L)\). More generally, at a jump \(a>0\) of the Lévy density \(v\), the atom of \(\mu_s\) is \(j_s(a)\Delta v_s(a)\): \(j_s,j_s'\) are continuous, \(j_s''\) jumps by \(\Delta v_s(a)\), and half the jump of \((j_s^2)''\) is \(j_s(a)\Delta v_s(a)\). The nonzero-jump age density is \(v_s=p_ss\,v+\) continuous \(k\ge2\) convolutions, so \(\Delta v_s=p_ss\,\Delta v\). Consequently the prime-two atom is **exactly**
\[
\boxed{\quad
\mu_s(\{2L\})=-\frac{p_ss\,j_s(2L)}{8L}<0
\quad(s>0).\quad} \tag{8a}
\]
Its small-\(s\) expansion is \(-p_s^2s/8+O(s^2)\); two-jump histories affect \(j_s(2L)\) only at order \(s^2\). The Neumann inverse below uses total variation and does not rely on positivity of \(\mu_s\).

## Exact causal factor and future inverse

Equation (3) makes \(H_0\) the causal Green kernel. Convolution of causal distributions is associative here, and (4) gives
\[
\boxed{\quad H_s=H_0*\mu_s,\qquad K_s=K_0*\mu_s.\quad} \tag{9}
\]
For example, \(\frac12H_0*(D+1)^3H_s=\frac12(D+1)^3H_0*H_s=H_s\). The second identity follows by applying \(1-D_t\).

For a finite causal measure \(\mu\), define future translation
\[
(T_\mu q)(u)=\int_{[0,\infty)}q(u+a)\,\mu(da).
\]
Since \(f\) is bounded, \(K_0\in L^1\), and \(\mu_s\) has finite total variation, Tonelli for total variations and Fubini give the exact actual-source relation
\[
\boxed{\quad g_s=T_{\mu_s}g_0.\quad} \tag{10}
\]
The future translation operators compose by convolution:
\(T_\mu T_\eta=T_{\mu*\eta}\).
Choose
\[
0<s\le s_*:=\min\{1,(2C_\mu)^{-1}\}.
\]
Then \(\|\delta_0-\mu_s\|_{\rm TV}\le1/2\), and the finite causal signed measure
\[
\mu_s^{-1}
=\sum_{n=0}^{\infty}(\delta_0-\mu_s)^{*n} \tag{11}
\]
converges in total variation, has norm at most \(2\), and satisfies
\(\mu_s*\mu_s^{-1}=\delta_0\). Thus
\[
\boxed{\quad g_0=T_{\mu_s^{-1}}g_s\quad} \tag{12}
\]
for the actual bounded arithmetic \(f\), with no Mellin-domain continuation and no delayed-derivative equation.

The inversion is bounded on every exponential future-decay space
\(\mathcal B_\alpha=\{q:\sup_{u\ge0}e^{\alpha u}|q(u)|<\infty\}\), \(\alpha\ge0\), because
\[
\|T_\mu q\|_{\mathcal B_\alpha}
\le\left(\int e^{-\alpha a}|\mu|(da)\right)\|q\|_{\mathcal B_\alpha}
\le\|\mu\|_{\rm TV}\|q\|_{\mathcal B_\alpha}. \tag{13}
\]
In particular \(\|g_0\|_{\mathcal B_\alpha}\le2\|g_s\|_{\mathcal B_\alpha}\).
The first prime-two atom is a small delayed **value** channel after factorization, rather than an uncontrolled delayed derivative. The earlier attempt to move three derivatives from \(f\) directly onto \(K_s-p_s^2K_0\) created a \(\delta'_{\log2}\) term because it differentiated the wrong kernel; (9) avoids that derivative loss exactly.

## Fixed-positive-clock RH criterion and original-metric cost

The unclocked half-line theorem proved in the preceding note states
\[
\mathrm{RH}\Longleftrightarrow
g_0(\log Y)=O_\epsilon(Y^{-1/2+\epsilon})\quad\text{for every }\epsilon>0.
\]
Equation (12) proves the forward implication from any one fixed \(s\in(0,s_*]\); equation (10), or the uniform \(L^1\) bound on \(K_s\), proves the converse. Hence
\[
\boxed{\quad
\mathrm{RH}\Longleftrightarrow
\mathcal D_{Y,s}=O_{\epsilon,s}(Y^{-1/2+\epsilon})
\ \text{for every }\epsilon>0,
\quad\text{for each fixed }0<s\le s_*.\quad} \tag{14}
\]
The criterion is also valid with integer-only \(Y\), but interpolation must occur **before** (12), because the inverse measure samples noninteger future scales. Indeed (9) and \(K_0(0)=0\) give \(K_s'=K_0'*\mu_s\in L^1\) with \(\|K_s'\|_1\le\|K_0'\|_1\|\mu_s\|_{\rm TV}\). Since the actual \(f\) is bounded, differentiating the future convolution across its jumps gives \(|g_s'(u)|\le\|f\|_\infty\|K_s'\|_1\) almost everywhere. For \(N\le Y<N+1\), this makes \(|g_s(\log Y)-g_s(\log N)|=O_s(N^{-1})\), below the target scale. The real-\(Y\) bound can then be inserted into (12). This is not a proof of the displayed RH-scale bound for actual \(D\).

The original factorial-ground spatial jump still has the exact decomposition
\[
J_Y(s)=J_Y^{\rm loc}(s)+J_Y^{\rm fut}(s)
=\frac{\mathcal D_{Y,s}}{2\kappa_F}+\mathcal R_{Y,s},
\qquad \kappa_F=1+\gamma. \tag{15}
\]
Therefore the RH-equivalent original-metric criterion at fixed small \(s\) is the bound on the **subtracted** combination
\(J_Y^{\rm fut}+J_Y^{\rm loc}-\mathcal R_{Y,s}\)
at \(O_\epsilon(Y^{-1/2+\epsilon})\). **This particular passage through the linearized score** would require an independent RH-scale estimate for the coupled-\(F\) correction \(\mathcal R_{Y,s}\) if only a bound on \(J_Y\) were given; a bound on the future term alone would also require the exact local term. The subsequent [actual-source nonlinear inverse](factorial-f-ground-full-score-rh-criterion.md) instead uses local prime-atom regularity and the zeta Mellin poles to show that a bound on full \(J_Y\) itself suffices as an RH criterion. Unconditional PNT estimates for these scores remain subpower, not sufficient at this scale. No RH-strength estimate is assumed in either factorization.

## Complete original-ground score: clock-to-clock transfer only

There is a stronger clock identity for the **unsubtracted** full ground score. Its endpoint at clock zero is proved RH-equivalent in the [companion source-regularity note](factorial-f-ground-full-score-rh-criterion.md), using additional actual arithmetic structure. For \(u\ge\log2\), set
\[
r(u)=\frac{E(e^u)}{e^uF(e^u)}=-\partial_u\log F(e^u),\qquad
\Delta q(u)=q(u)-q(u+\log2).
\]
The literal original-ground score, with \(dE=d\psi-dx\) and every prime-power atom, is
\[
G_{Y,s}=\int_{[Y,\infty)}\frac{H_s(\log(x/Y))}{xF(x)}\,dE(x),
\qquad J_s(u)=G_{e^u,s}-G_{2e^u,s}.
\]
Stieltjes integration by parts has zero lower boundary because \(H_s(0)=0\), and zero upper boundary by PNT. The exact relation \(xF'(x)/F(x)=-r(\log x)\) gives
\[
G_{e^u,s}=T_{K_s}r(u)-T_{H_s}(r^2)(u),
\qquad
\boxed{J_s=T_{K_s}\Delta r-T_{H_s}\Delta(r^2)=T_{\mu_s}J_0.}
\]
The atom at \(2Y\) remains in the old-base term and vanishes in the new-base term, exactly as in the original Stieltjes formula. Both \(r\) and \(r^2\) are bounded on this tail; (9) and finite total variation justify both Fubini exchanges. Therefore for fixed \(0<s\le s_*\), \(J_s=O(e^{-\alpha u})\) if and only if \(J_0=O(e^{-\alpha u})\), for every \(\alpha\ge0\). This equivalence needs no separate estimate of \(\mathcal R_{Y,s}\), since the same signed measure factors the linear and quadratic terms. The full-score RH inverse needs the prime-atomic local regularity and actual \(-\zeta'/\zeta\) poles proved in the companion note; this clock factor alone does not provide them. The [integer-atomic countermodel](factorial-f-ground-integer-atomic-countermodel.md) shows why positivity and integer support alone cannot supply the final arithmetic inverse.
