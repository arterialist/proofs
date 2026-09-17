# Actual full-\(F\) dyadic score is an RH-equivalent criterion

RH Agent3, 2026-09-16. Independently audited by two mathematical workers and the supervising RH thread. **Status:** written RH-equivalent criterion, not an estimate of its arithmetic premise and not Lean formalized. The implication below uses the *actual* integer-supported \(\Lambda\) source and its Euler-product Mellin transform. It does not prove RH because no RH-scale bound for the score is established.

Write \(E(x)=\psi(x)-x\) with \(\psi(x)=\sum_{n\le x}\Lambda(n)\) right-continuous. Let \(F'(x)=-E(x)/x^2\), \(F(x)>0\) for \(x>1\), and \(F(x)\to\kappa_F>0\). Set \(u=\log Y\), \(H(t)=t^2e^{-t}\mathbf1_{t\ge0}\), and
\[
 G(u)=\int_{[e^u,\infty)}\frac{H(\log(x/e^u))}{xF(x)}\,dE(x),
 \qquad J(u)=G(u)-G(u+L),\quad L=\log2.                    \tag{1}
\]
This is the unclocked complete original-\(F\) ground profile and its literal fixed-clock dyadic jump. Every prime power has its \(\Lambda\) weight. The lower atom at \(x=Y\) has coefficient \(H(0)=0\); if \(2Y\) is a prime power, its atom remains in the old-base term of \(J\) and has zero coefficient in the new-base term.

**Claim.** For the actual \(\Lambda\) source,
\[
 \boxed{\mathrm{RH}\quad\Longleftrightarrow\quad
 J(\log Y)=O_\epsilon(Y^{-1/2+\epsilon})
 \quad\text{for every }\epsilon>0.}                         \tag{2}
\]
The implication from right to left is an inverse theorem, not a bound proving RH.

## Exact source distribution and third-order inverse

For \(u\ge U>\log2\), push the signed measure \(dE/(xF(x))\) to logarithmic coordinates:
\[
 dB(v)=\sum_{n\ge2}\frac{\Lambda(n)}{nF(n)}\,\delta_{\log n}(dv)
                  -\frac{dv}{F(e^v)}.                       \tag{3}
\]
The source has locally finite variation. On a compact \(v\)-interval this formula includes all prime powers; the density is exactly the pole subtraction \(-dx\), because \(dx/(xF(x))=dv/F(e^v)\). Then
\[
 G(u)=\int_{[u,\infty)}H(v-u)\,dB(v).                   \tag{4}
\]
The integral is absolutely convergent: \(\Lambda(n)\le\log n\), integer spacing bounds the variation on each unit log interval by \(O(1+v)\), and \(H(v-u)\) decays exponentially. Distributionally on \((U,\infty)\),
\[
 \boxed{(1-\partial_u)^3G=2B.}                           \tag{5}
\]
Indeed for one atom at \(v\), \(H(v-u)\mathbf1_{u\le v}\) is the advanced fundamental solution: successive applications of \(1-\partial_u\) give \(2(v-u)e^{-(v-u)}\), \(2e^{-(v-u)}\), then \(2\delta_v\). Fubini against compactly supported tests proves (5) for the locally finite full measure; no infinite-horizon boundary is introduced.

The PNT gives \(e(u):=E(e^u)/e^u=o(1)\) and \(r=e/F=o(1)\). Exact Stieltjes integration by parts in (1) gives \(G=T_Kr-T_H(r^2)\), where \(K=H-H'=2t(t-1)e^{-t}\). Since \(H,K\in L^1\), \(G(u)\to0\). Hence the telescoping identity
\[
 G(u)=\sum_{j=0}^\infty J(u+jL)                         \tag{6}
\]
is exact. If the right-hand side of (2) holds, then for any fixed \(0<\alpha<1/2\),
\[
 |G(u)|\le C_\alpha e^{-\alpha u}\qquad(u\ge U).        \tag{7}
\]

## Recovering a fixed source power from regularity

There is an elementary local total-variation bound. For \(0<h\le1\) and large \(u\), \(F\) and \(1/F\) are bounded on the tail, and the interval \([e^u,e^{u+h}]\) contains at most \(C(e^uh+1)\) integers. At each such integer \(\Lambda(n)/(nF(n))\le C(1+u)e^{-u}\). Therefore
\[
 |B|([u,u+h])\le C(1+u)(h+e^{-u}).                     \tag{8}
\]
The bound holds for closed, half-open, and open endpoint conventions, including an atom at either endpoint.

Fix \(v\in[u,u+1]\). Mollify \(\mathbf1_{[u,v]}\) by a nonnegative smooth approximate identity of width \(h\), writing \(\phi=\mathbf1_{[u,v]}*\eta_h\). Its support lies in \([u-h,v+h]\), \(0\le\phi\le1\), and \(\phi\) differs from the interval indicator only in two collars of width \(h\). Uniformly even when \(v-u<2h\),
\[
 \|(1+\partial)^3\phi\|_1\le C(1+h^{-2}).             \tag{9}
\]
For example, the third derivative is the difference of two translates of \(\eta_h''\), whose \(L^1\) norm is \(O(h^{-2})\). Testing (5) against \(\phi\), using (7) on its support, and paying both collars with (8), gives
\[
 \sup_{v\in[u,u+1]}|B([u,v])|
 \le C_\alpha e^{-\alpha u}h^{-2}
      +C(1+u)(h+e^{-u}).                                  \tag{10}
\]
Set \(h=[e^{-\alpha u}/(1+u)]^{1/3}\); for large \(u\), \(e^{-u}\ll h\le1\). Thus
\[
 M(u):=\sup_{v\in[u,u+1]}|B([u,v])|
 \le C_\alpha(1+u)^{2/3}e^{-\alpha u/3}+C(1+u)e^{-u}.   \tag{11}
\]
For every \(\beta<1/6\), choose \(\alpha<1/2\) with \(3\beta<\alpha\); then \(M(u)=O_\beta(e^{-\beta u})\). In particular, (11) controls the value of any endpoint atom by choosing an interval that includes it.

The source-to-error equation is **linear** once the exact ground is retained:
\[
 \boxed{de+e\,du=F(e^u)\,dB(u).}                       \tag{12}
\]
To check (12), \(e=E(e^u)e^{-u}\), so \(de+e\,du=e^{-u}dE(e^u)\), and (3) multiplied by \(F(e^u)\) is precisely the same measure. The equivalent Riccati equation for \(r=e/F\) is \(dr+(r-r^2)du=dB\), but (12) avoids a nonlinear Gronwall step.

Choose a fixed large \(U\) outside an atom. Variation of constants in (12), with right-continuous endpoints, gives
\[
 e(u)=e^{-(u-U)}e(U)
   +\int_{(U,u]}e^{-(u-v)}F(e^v)\,dB(v).                   \tag{13}
\]
On each unit block \((k,k+1]\), \(F(e^v)\) is bounded and absolutely continuous with \(dF(e^v)/dv=-e(v)=o(1)\) almost everywhere. The weight \(q_u(v)=e^{-(u-v)}F(e^v)\) and its derivative are bounded by \(Ce^{-(u-k-1)}\) for \(v\in(k,k+1]\). Stieltjes integration by parts against the cumulative signed measure \(B((k,t])\), bounded by \(2M(k)\) from (11), therefore gives
\[
 \left|\int_{(k,k+1]}q_u(v)dB(v)\right|
 \le C e^{-(u-k-1)}M(k).                                 \tag{14}
\]
The same bound holds on the last partial block. Summing the geometric convolution over \(k\le u\), with \(M(k)=O_\beta(e^{-\beta k})\) and \(\beta<1\), yields
\[
 e(u)=O_\beta(e^{-\beta u}),\qquad
 E(x)=O_\beta(x^{1-\beta})\quad\text{for every }\beta<1/6. \tag{15}
\]
No RH, zero-free strip, short-interval prime theorem, or sign assumption beyond the trivial \(\Lambda(n)\le\log n\) was used in (8)--(15). The score bound (7), of course, is hypothetical.

## Actual-zeta pole bootstrap and converse

Take one \(\beta>0\) from (15). The exact full-score decomposition is
\[
 J=(2\kappa_F)^{-1}g+N,\qquad
 g=T_K[D(e^u)e^{-u}],\quad N=O(e^{-2\beta u}).            \tag{16}
\]
Indeed, with \(e(u)=E(e^u)e^{-u}\), \(r=e/F\), and \(\Delta q(u)=q(u)-q(u+\log2)\), integration by parts in (1) gives
\[
J=T_K\Delta r-T_H\Delta(r^2),\qquad
N=T_K\Delta\!\left[e(F^{-1}-\kappa_F^{-1})\right]
       -T_H\Delta(r^2).
\]
The error follows from \(F(x)-\kappa_F=\int_x^\infty E(t)t^{-2}dt=O(x^{-\beta})\); both parts of \(N\) are quadratic in \(E/x\), and \(H,K\) have the needed exponential moments. The actual Mellin transform of \(D/x\) is
\[
 \int_0^\infty e^{-(z-1)u}\frac{D(e^u)}{e^u}du
   =\frac{2-2^z}{z}\left(-\frac{\zeta'(z)}{\zeta(z)}\right),
 \quad \Re z>1,                                           \tag{17}
\]
including the \(x=1\) endpoint, density subtraction, and all prime powers. The [unclocked unilateral resolvent calculation](factorial-f-ground-dyadic-score-inversion.md) continues the Laplace transform of \(D/x\) from a decay bound on \(g\), retaining its three finite boundary traces. Equation (16) makes \(g=O(e^{-qu})\) for every \(q<\min(1/2,2\beta)\); its multiplier \(2z/(2-z)^3\) is nonzero at every zero in that half-plane. The factor \(2-2^z\) also cannot vanish for \(1/2<\Re z<1\). Hence every such zero is excluded.

The standard truncated explicit formula now improves the power in (15) from \(\beta\) to any \(\beta'<\min(1/2,2\beta)\). To see the quantitative step, when \(\Re\rho\le1-q\) for every nontrivial zero, truncate the actual prime-power formula at a height \(T\asymp x^2\) chosen away from zero ordinates. The zero sum is \(O(x^{1-q}\log^2 T)\) by the usual zero count and \(\sum_{|\Im\rho|\le T}1/|\rho|=O(\log^2T)\); the truncation error is smaller than \(x^{1-q+\epsilon}\). Bracket a prime-power jump by nearby non-atomic points using monotonicity of \(\psi\), adding at most \(O(\log x)\). Thus \(E(x)=O_{q,\epsilon}(x^{1-q+\epsilon})\). Repeating finitely many times reaches \(\beta>1/4\), when (16) makes \(N\) RH-small. The unclocked criterion for \(g\), or (17) directly, then excludes all zeros with \(\Re z>1/2\), and the functional equation gives RH. This proves the nontrivial direction of (2) without assuming a rightmost zero; each step excludes a whole half-plane.

Conversely RH gives \(E(x)=O(x^{1/2}\log^2x)\). The exact score formula \(G=T_Kr-T_H(r^2)\), \(F\to\kappa_F>0\), and the exponentially decaying kernels show \(G(u)=O_\epsilon(e^{-(1/2-\epsilon)u})\), hence the same bound for \(J=G-G(\cdot+L)\). This completes the criterion (2).

The criterion also holds if its bound is given only for **integer** bases \(Y=N\), but not from a merely dyadic sequence by this interpolation. Indeed \(H(0)=H'(0)=0\), so differentiating (4) creates no boundary atom and gives \(G'(u)=-\int_{[u,\infty)}H'(v-u)dB(v)\). The trivial local variation estimate behind (8), summed against the exponentially decaying \(H'\), yields \(|G'(u)|+|J'(u)|\le C(1+u)\). For \(N\le Y<N+1\), \(|\log Y-\log N|\le N^{-1}\), so integer-to-real interpolation costs \(O(\log N/N)\), below the RH scale. The [fixed-small-clock causal measure factorization](factorial-f-ground-fixed-positive-clock-measure-inverse.md) \(J_s=T_{\mu_s}J_0\) and its total-variation inverse make (2) an RH-equivalent criterion at any one sufficiently small fixed positive \(s\), for real \(Y\). For integer \(Y\), interpolate the fixed-\(s\) score before applying the inverse: \(H_s(0)=K_s(0)=0\), \(H_s',K_s'\in L^1\), and \(r,r^2\) are bounded, so \(J_s\) is uniformly Lipschitz in \(u\) on a tail and costs \(O(1/Y)\) between adjacent bases. This is a transfer of the criterion, not a bound on that clocked score.

The result is specific to a source whose atoms obey a quantitative local variation bound and whose Mellin transform is the actual \(-\zeta'/\zeta\). The sparse pseudo-prime countermodel also obeys the local bound and therefore its score forces **some** power saving for its own \(E\), which it already has (\(E\asymp x^{0.7}\)); it lacks (17), so the pole bootstrap does not apply. Neither (2) nor its fixed-small-clock counterpart supplies the still-missing RH-scale bound for the actual score.

Primary reference for the \(\psi\) explicit formula and RH error criterion: [NIST DLMF §25.16](https://dlmf.nist.gov/25.16).
