# Same-half theta prime energy of the complete square-root sieve packet

*Research and initial proof: RH Agent3. Independent mathematical audit and publication: RH Proof.*

This follows the full prime-power **same-half** part of the actual ground-transformed theta form on one finite embedding of the complete sieve and its large-prime Möbius future cone. The lower-prime dyadic channel has polynomial mass even though the tagged large-prime arrival is exponentially attenuated. The linked compact ground theorem supplies the lower bound on the ground profile. No RH claim or full-form transfer follows.

## Exact finite embedding and natural metric

Fix a theta core \(C=[-R,R]\), \(R>0\), and \(N\to\infty\). Let \(z=\lfloor\sqrt N\rfloor\), \(B_N=\lfloor Ne^{-R}\rfloor\), \(u_n=\log(n/N)\), and \(\delta_N=1/(4N)\). Choose one real \(\eta_N\in C_c^\infty((-\delta_N,0))\) with \(\|\eta_N\|_{L^2(du)}=1\), and put
\[
I_n=(u_n-\delta_N,u_n),\quad f_n(u)=\eta_N(u-u_n),\quad
F_c=\sum_{n\le B_N}c_nf_n.
\tag{1}
\]
The intervals are disjoint because \(\delta_N<\log((n+1)/n)\) for \(n\le N\). Crucially, translation is exact:
\[
f_n(u-\log q)=f_{qn}(u)\quad(qn\le B_N),
\qquad I_n+\log q=I_{qn}.
\tag{2}
\]
This avoids point masses and their invalid theta \(L^2\) domain. The finite smooth sum lies in the actual maximal form domain: the continuous singularity is killed by smooth differences, and the full prime-power energy is finite by the bounded prime departure and theta tails.

Two **fixed actual arithmetic** coefficient vectors will be used, without free tangent variation:
\[
c^{\rm surv}_n=r_z(n)1_{n\le B_N},
\qquad
c^{\rm cone}_n=\mu(n)1_{\{\exists p>z:p\mid n\}}1_{n\le B_N}
=-\sum_{\substack{p>z,\ m\le B_N/p}}\mu(m)1_{n=pm}.
\tag{3}
\]
The sieve \(r_z\) is the complete divisor product \(\prod_{p\le z}(1-1_{p\mid n})\); on \(2\le n\le N\), it is exactly the indicator of primes \(>z\). The cone identity retains every signed cofactor \(m\), including its squarefree zero cases and the strict terminal floor. Both vectors include every eligible integer coordinate, not selected variations.

Use the actual normalized killed ground \(\psi>0\) a.e. and
\[
\Phi=\Phi_{\rm theta},\quad A(u)=2\cosh(u/2),\quad
\rho(u)=\frac1{e^{|u|}+1},\quad d\gamma=\rho\psi A\Phi\,du.
\tag{4}
\]
The natural theta Hilbert mass of (1) is exactly
\[
\|F_c\|_\gamma^2
=\sum_{n\le B_N}|c_n|^2M_n,
\quad M_n=\int_{I_n}\rho(u)\psi(u)A(u)\Phi(u)|f_n(u)|^2du.
\tag{5}
\]
The factors \(M_n\) vary drastically from \(n\asymp\sqrt N\) to \(n\asymp Ne^{-R}\). They cannot be replaced by the original Abel weights \(e^{-2n/N}\).

## Full same-half prime bilinear form and the ghost boundary

For a prime power \(q=p^k\ge2\), set \(a_q=\Lambda(q)/\sqrt q=(\log p)/p^{k/2}\). On \(O_-=(-\infty,-R)\), the actual same-half prime form, with both directed orientations already paired, is
\[
\boxed{\displaystyle
\operatorname{Same}_p(F_c,F_d)
=\sum_{q=p^k\ge2}a_q
\int_{\substack{u,u+\log q\in O_-}}
\psi(u)\psi(u+\log q)\Phi(u)\Phi(u+\log q)
\bigl(F_c(u+\log q)-F_c(u)\bigr)
\overline{\bigl(F_d(u+\log q)-F_d(u)\bigr)}\,du.}
\tag{6}
\]
The positive-half contribution is zero for these negative-supported packets; the symmetric directed definition has a \(1/2\), canceled by the two orientations in (6). Equation (6) includes **all** proper prime powers and all endpoints; edges with one endpoint outside the finite packet remain.

For an explicit matrix expansion, define
\[
\begin{aligned}
G^+_{q,n}&=\int_{I_n}1_{\{u+\log q<-R\}}
\psi(u)\psi(u+\log q)\Phi(u)\Phi(u+\log q)|f_n(u)|^2du,\\
G^-_{q,n}&=\int_{I_n}1_{\{u-\log q<-R\}}
\psi(u-\log q)\psi(u)\Phi(u-\log q)\Phi(u)|f_n(u)|^2du.
\end{aligned}
\tag{7}
\]
All terms are nonnegative and finite. Because of (2), the only off-diagonal overlap is the literal divisor edge \(n\leftrightarrow qn\) with \(qn\le B_N\). Consequently (6) equals
\[
\boxed{\displaystyle
\sum_{q=p^k\ge2}a_q\left[
\sum_{n\le B_N}c_n\bar d_n(G^+_{q,n}+G^-_{q,n})
-\sum_{n\le B_N/q}(c_{qn}\bar d_n+c_n\bar d_{qn})G^+_{q,n}
\right].}
\tag{8}
\]
This expansion exposes a genuine **ghost boundary**: for \(q\nmid n\), the backward translated cell \(I_n-\log q\) is not an integer cell, but its positive diagonal contribution \(G^-_{q,n}\) remains. Strict arithmetic division would kill that state; the continuous theta translation does not. Likewise \(G^+_{q,n}\) remains when \(qn>B_N\) but the translated interval is still exterior. Formula (8), not a divisor-only graph Laplacian, is the exact finite theta bilinear form. No off-diagonal sign has been estimated.

## What is and is not polynomially visible

First, the complete survivor sieve cancels a tempting high-prime same-half edge. For every large prime \(p>z\) with \(p\le B_N\), its pair \(1\leftrightarrow p\) has
\[
c^{\rm surv}_1=c^{\rm surv}_p=1,
\quad F_{c^{\rm surv}}(u+\log p)-F_{c^{\rm surv}}(u)=0
\quad(u\in I_1),
\tag{9}
\]
including the entire common bump, not merely a sampled point. For the cone, \(c^{\rm cone}_1=0\), \(c^{\rm cone}_p=-1\), so the same edge has increment \(-1\), but its conductance includes \(\Phi(u)\) at \(u\in I_1\sim-\log N\) and is exponentially small. More generally every *large-prime* \(p>z\) same-half edge meeting either finite packet has at least one endpoint \(\le-\log(N/z)+O(\delta_N)\). The theta tail \(\Phi(-\log x)\ll x^{9/2}e^{-\pi x^2}\), the bounded ground, and a split of the finite outgoing and exponentially summable incoming prime-power tails give the conservative whole-packet upper bound
\[
\operatorname{Same}_{p>z}(F_{c^{\rm surv}}),\quad
\operatorname{Same}_{p>z}(F_{c^{\rm cone}})
\ll_R N^6(\log N)^2e^{-\pi z^2}.
\tag{10}
\]
The notation \(p>z\) here includes every \(p^k\), \(k\ge1\), whose base prime exceeds \(z\). The precise polynomial is deliberately loose; (10) is an **absolute** theta-form estimate for the specified normalized bump embedding, not a relative bound after dividing by (5). No small-prime or continuous edge is omitted from the full theta form.

The lower-prime same-half sector is different. Fix \(0<c<C<e^{-R}/2\), so that for all large \(N\) every prime \(p\in[cN,CN]\) and its composite \(2p\) lie in \(O_-\) and below \(B_N\). Such \(p\) exceed \(z\). On the complete cone packet, \(c^{\rm cone}_p=-1\), \(c^{\rm cone}_{2p}=+1\); equation (2) makes their \(q=2\) increment exactly \(2f_p\). Their disjoint positive contribution to (6) is
\[
\boxed{\displaystyle
\mathcal D_{2,N}
=\frac{4\log2}{\sqrt2}
\sum_{\substack{cN\le p\le CN\\p\ \mathrm{prime}}}G^+_{2,p},
\qquad 0<\mathcal D_{2,N}\le\operatorname{Same}_p(F_{c^{\rm cone}}).}
\tag{11}
\]
Each term is strictly positive because \(\psi>0\) a.e. and the fixed cells have positive measure. Since all endpoints in (11) stay in a fixed compact exterior strip, boundedness of \(\psi\) and continuity of \(\Phi\) give \(\mathcal D_{2,N}\ll_R N/\log N\) by the prime number theorem. At the time of this note, a matching polynomial lower bound was isolated under the ground-profile condition
\[
\operatorname*{ess\,inf}_{u\in[\log c-1,\log(2C)]}\psi(u)>0
\quad\text{in the essential sense on the negative exterior strip.}
\tag{12}
\]
Then \(G^+_{2,p}\ge g_{R,c,C}>0\) uniformly, so \(\mathcal D_{2,N}\gg_{R,c,C}N/\log N\). The [compact lower-barrier theorem](theta-killed-ground-compact-lower-barrier-dyadic-cone.md) proves (12) from the actual killed-ground rank-one resolvent, so this dyadic lower bound is unconditional for fixed \(R,c,C\). It is a ground-state regularity result, not an assumption about Möbius cancellation or RH.

Thus the **full** same-half prime form may indeed have polynomial absolute mass through the small-prime \(2\) edge of the composite future cone. It does not recover the original arithmetic covariance: (11) is a positive square in the theta metric, whereas the original one-clock Fejér form has the signed \(\mu(pm)\mu(q\ell)\) cross and Abel weights. The natural theta norm (5) is also a different, location-dependent weight; no uniform comparison with \(\int_1^2w(t)\|Q_HA_t\|^2dt\) has been proved. In particular, (10) does not extend to all prime powers, and (11) cannot be used as a signed upper reserve for the full response.

## Suzuki defect and full-response scope

The original Suzuki interval form retains its arrival multiplier \(T_\omega\) and defect \(D_\omega=T_\omega-I\). For all interval tests \(x,y\), including any future image of this sieve packet, the exact bilinear payment is
\[
\langle\mathcal C_\omega(I+\sigma G_\omega)x,y\rangle
-\langle D_\omega x,y\rangle
=\langle x,y\rangle+\sigma\langle H_\omega x,y\rangle,
\qquad\sigma=\pm1.
\tag{13}
\]
This keeps all arithmetic coefficients in \(\mathcal C_\omega\), so the defect cannot be dropped or treated as a favorable stand-alone sign. There is no established map from the natural theta packet \(F_c\), with the exact same-half form (8), to a Suzuki interval test \(x\) preserving the original Abel/clock Gram and both sides of (13). The small-prime polynomial channel in (11) neither supplies that map nor signs the gamma term in (13).

The complete signed theta response also contains same-half continuous energy, cross-half prime covariance, the core crossing source, reduced Green optimization, common-score projection, pole rows and observation constraints. Equations (8)--(11) settle only the exact same-half prime component on the stated whole finite packets. Any proposed complete transfer must preserve the positive dyadic term *and* its cross with those other components, as well as the original arithmetic signed cofactor pairs. The missing premise is an explicit form-domain-valid original-metric intertwiner plus a one-sided estimate for the resulting full mixed response; no such premise is adopted here.
