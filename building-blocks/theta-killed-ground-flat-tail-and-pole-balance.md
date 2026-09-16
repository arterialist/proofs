# The fixed-core killed theta ground has a flat far tail

Fix $R>0$, $C=[-R,R]$, and $O=\mathbb R\setminus C$. Let

\[
 L_O\psi_R=\alpha_R\psi_R,\qquad
 0<\alpha_R<\lambda=\tfrac12,\qquad
 \psi_R>0\ \nu\text{-a.e. on }O,\qquad
 \|\psi_R\|_{L^2(\nu)}=1,
\]

be the actual even killed ground. Extend it by zero on $C$, and write

\[
 b_\theta(u)=2\cosh(u/2),\quad d\nu=b_\theta\Phi\,du,\quad
 \delta_R=\lambda-\alpha_R,\quad
 \mu_R=\int_O\psi_R\,d\nu,\quad
 c_R=\frac{\lambda\mu_R}{\delta_R}.
\tag{1}
\]

The ground is bounded by the [weighted crossing theorem](theta-groundstate-bounded-weighted-crossing.md). Its zero extension has a continuous representative by the argument in [normalized cross arrival](theta-ground-normalized-cross-arrival.md#actual-continuity-before-applying-pointwise-pnt). The complete prime return law in [the jump form](theta-weil-jump-form.md#7-the-actual-prime-return-law) is therefore applicable to this fixed bounded continuous test. We prove the stronger far-tail conclusion

\[
 \boxed{\displaystyle
 \lim_{u\to+\infty}\psi_R(u)
 =\lim_{u\to-\infty}\psi_R(u)
 =c_R=\frac{\mu_R}{2\delta_R}>0.}
\tag{2}
\]

The limit concerns each fixed core. It supplies no convergence rate uniform in $R$, no near-core quadrature estimate, and no Weil sign.

## Prime forcing and the exact exterior equation

Distinguish the prime departure rate $p(u)=K_u(1)$ from $b_\theta$. With every prime power and both displacement directions retained, set

\[
 f_R(u)=K_u(\psi_R)
 =\frac1{b_\theta(u)}\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
  \left[\Phi(u-\log n)\psi_R(u-\log n)
       +\Phi(u+\log n)\psi_R(u+\log n)\right].
\tag{3}
\]

The full killed generator splits into its continuous and prime parts. Its ground equation on $O$ is

\[
 D_{a,O}\psi_R+(p-\alpha_R)\psi_R=f_R,
\qquad
 D_{a,O}h(u)=\frac1{b_\theta(u)}
 \int_{\mathbb R}r(|u-v|)\Phi(v)[h(u)-h(v)]\,dv,
\tag{4}
\]

Here $r(s)=e^{-s/2}/(1-e^{-2s})$, $h=0$ on $C$, and the difference makes the singular integral meaningful in the form/operator sense. The prime departure includes jumps into $C$, while $f_R$ vanishes at those destinations; no crossing term has been dropped.

The return law gives $p(u)\to\lambda$ at both ends. It also gives

\[
 f_R(u)\longrightarrow\lambda\mu_R\qquad(|u|\to\infty).
\tag{5}
\]

Indeed the positive translated prime destination measures converge weakly to the density $e^{-v/2}\Phi(v)dv$ as $u\to+\infty$, and to its reflection at the other end. The zero-extended $\psi_R$ is bounded and continuous. The measures are tight by the theta envelope and the Chebyshev bound, as checked for the same actual ground history in the normalized-cross-arrival proof. Thus weak convergence applies to $\psi_R$, without a derivative or bounded-variation claim. Evenness gives

\[
 \int e^{-v/2}\Phi(v)\psi_R(v)\,dv
 =\int e^{v/2}\Phi(v)\psi_R(v)\,dv=\mu_R/2.
\]

The positive-shift arrivals and all prime powers remain in (3) and (5).

## A comparison lemma for the fading continuous jumps

Define the continuous core-killing rate

\[
 \kappa_R(u)=D_{a,O}1_O(u)
 =\frac1{b_\theta(u)}\int_Cr(|u-v|)\Phi(v)\,dv\ge0.
\tag{6}
\]

The exponential tail of $r$ and $b_\theta(u)\asymp e^{|u|/2}$ show $\kappa_R(u)=O_R(e^{-|u|})$. For $U>R+2$, choose an even cutoff $\theta_U$ on $O$ with $0\le\theta_U\le1$, equal to one for $R<|u|\le U+1$, zero for $|u|\ge U+2$, and with a Lipschitz constant independent of $U$. Extend it by zero on $C$. The established hard-indicator domain and a smooth outer transition place $\theta_U$ in the killed form domain. Put

\[
 d_U=\sup_{|u|>U+1}|D_{a,O}\theta_U(u)|.
\tag{7}
\]

Then $d_U\to0$. To see this directly, split the integral in (4) into $|u-v|<1$ and its complement. On the first part the Lipschitz difference cancels $r(s)=O(1/s)$, while $\Phi(v)/b_\theta(u)$ is uniformly theta-small for $|u|>U+1$. On the complement, destinations with $|v|>U$ are again theta-small. For $|v|\le U$, the separated kernel is bounded by $Ce^{-|u|/2}e^{|v|/2}$, and division by $b_\theta(u)$ leaves $Ce^{-|u|}\int e^{|v|/2}\Phi(v)dv$. Consequently

\[
 d_U\le C e^{-U}+C e^{-U/2}\sup_{|v|>U}\Phi(v)\longrightarrow0.
\tag{8}
\]

Only the limit in (8) is needed; constants may be enlarged for a particular cutoff.

For clarity, here is the comparison principle used below. Let $F_U=\{u\in O:|u|>U+1\}$, and let $q(u)\ge q_0>0$ on $F_U$. If bounded form-domain functions $w,\psi$ satisfy $w\ge\psi$ on $O\setminus F_U$ and

\[
 (D_{a,O}+q)(w-\psi)\ge0\quad\text{weakly on }F_U,
\]

then $w\ge\psi$ throughout $O$. Test with the negative part of $w-\psi$, which is supported in $F_U$. The symmetric jump form pairs this negative part nonpositively with $w-\psi$; the potential contributes at most $-q_0\|(w-\psi)_-\|^2$. Both must vanish. Reversing signs gives the lower comparison. This uses the full nonlocal continuous jump form, including its hard-core killing.

## Barriers and the limit

Let $P_R=\|\psi_R\|_\infty<\infty$ and choose a fixed $B_R>P_R+c_R+1$. For all sufficiently large $U$, $p-\alpha_R\ge\delta_R/2$ on $F_U$. Define

\[
 E_U=\sup_{F_U}|f_R-\lambda\mu_R|
 +c_R\sup_{F_U}|p-\lambda+\kappa_R|
 +B_R d_U.
\tag{9}
\]

Equations (5)–(8) imply $E_U\to0$. For large $U$, also
$p-\lambda+\kappa_R\ge-\delta_R/2$. Put $\varepsilon_U=2E_U/\delta_R$ and form the upper and lower barriers

\[
 w_+=c_R+\varepsilon_U+B_R\theta_U,
 \qquad w_-=c_R-\varepsilon_U-B_R\theta_U.
\tag{10}
\]

On $O\setminus F_U$, $w_+\ge\psi_R\ge w_-$. On $F_U$, use $D_{a,O}1_O=\kappa_R$ and $\delta_Rc_R=\lambda\mu_R$. The common constant residual is

\[
 (D_{a,O}+p-\alpha_R)c_R-f_R
 =c_R(\kappa_R+p-\lambda)-(f_R-\lambda\mu_R).
\tag{11}
\]

The $\varepsilon_U$ term in the upper barrier contributes at least
$\delta_R\varepsilon_U/2=E_U$, while $B_R(p-\alpha_R)\theta_U\ge0$ and the possible negative part of $B_RD_{a,O}\theta_U$ is at most $B_Rd_U$. Thus $(D_{a,O}+p-\alpha_R)w_+\ge f_R$ on $F_U$. The reversed bounds give $(D_{a,O}+p-\alpha_R)w_-\le f_R$. Comparison with (4) yields

\[
 \boxed{\displaystyle
 \sup_{|u|\ge U+2}|\psi_R(u)-c_R|
 \le\frac{2E_U}{\delta_R}\longrightarrow0.}
\tag{12}
\]

The comparison first gives almost-everywhere bounds; continuity of the actual representative gives the displayed pointwise bounds. This proves (2). Formula (12) is a fixed-core modulus in terms of the complete actual prime-return discrepancy. It is not an effective $R$-uniform rate, since no quantitative modulus for the fixed ground profile was inserted into (5).

## The far-tail cross rate matches the spectral defect

Put $g_R(u)=\Phi(u)\psi_R(u)1_{u>R}$ and

\[
 G_- =\int_R^\infty e^{u/2}g_R(u)du,\qquad
 G_+ =\int_R^\infty e^{-u/2}g_R(u)du.
\]

Evenness gives $\mu_R=2(G_-+G_+)$. The [complete cross-arrival theorem](theta-ground-normalized-cross-arrival.md#a-proved-relative-tail-limit-for-the-actual-profile) gives $K_\times\psi_R(u)\to G_-$ at either end, including its continuous crossing and all prime powers. Dividing by the positive limit (2) yields the exact far-tail rate

\[
 \boxed{\displaystyle
 \lim_{|u|\to\infty}\frac{K_\times\psi_R(u)}{\psi_R(u)}
 =\delta_R\frac{G_-}{G_-+G_+},\qquad
 \frac{\delta_R}{1+e^{-R}}
 \le\delta_R\frac{G_-}{G_-+G_+}<\delta_R.}
\tag{13}
\]

The inequalities use $0<G_+<e^{-R}G_-$, directly from $u>R$. Thus the ground-transformed far-tail cross rate is within a relative $e^{-R}$ of the actual spectral defect. This does not estimate the cross profile near the hard core, where the covariance mass can concentrate.

## Exact far-tail pole balance in the weak mixed row

The [exponential weak ground row](theta-ground-exponential-weak-cross-row.md#the-full-mixed-weil-row-and-its-exact-pole-compensation) has signed density

\[
 \widetilde\eta_R
 =\left[\delta_R1_O b_\theta\psi_R
       +1_C\mathcal B_R-\lambda\mu_Rb_\theta\right]du.
\]

On the exterior, (2) says precisely

\[
 \boxed{\displaystyle
 \frac{d\widetilde\eta_R}{b_\theta\,du}(u)
 =\delta_R\psi_R(u)-\lambda\mu_R\longrightarrow0
 \qquad(|u|\to\infty).}
\tag{14}
\]

Thus the actual ground source and both pole products cancel at leading density order in either far tail. The signed density itself is only $o(b_\theta(u))$; (14) does not assert finite total variation or a sign. The core term, near-core profile, complete prime discrepancy and moving-$R$ constants remain present. In particular this theorem does not establish the required constrained covariance estimate or RH.

For the actual coherent scaling test $h_t(v)=H(te^{|v|})$, the checked bound $|H(z)|\le C\min(1,z^{-1})$ makes $|H(z)|z^{-1/2}$ integrable. The core part of $\sqrt t\int h_t\,d\widetilde\eta_R$ tends to zero by boundedness. On either exterior half, substitute $z=te^{|v|}$, use $b_\theta(v)\le2e^{|v|/2}$, and apply dominated convergence to (14). This proves the qualitative consequence

\[
 \sqrt t\,Q_{\rm W}(G_R,h_t)\longrightarrow0
 \qquad(t\downarrow0).
\tag{15}
\]

The separate [PNT-scale weak-row theorem](theta-weak-ground-pnt-density-cancellation.md) gives a stronger stretched-exponential bound for this particular test. Neither result supplies a sign for the remaining arithmetic row.

All statements here are written analysis. No Lean formalization of the far-tail comparison is claimed.
