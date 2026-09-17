# Parity rank-one split and the reflected prime obstruction for Suzuki's localized Weil operator

This note uses the actual von Mangoldt weights in [Suzuki's localized Weil form](https://arxiv.org/html/2606.09096v1), especially equations (1.1), (1.7), (2.5), and (2.7), with the normalization of [the full theta Weil form](../theta-and-heat/theta-weil-jump-form.md). It is an unconditional operator reduction and a countertest to an odd-halfline positivity argument. The reflection-atom obstruction was already established in the [theta jump metric](../theta-and-heat/theta-odd-prime-atom-obstruction.md); this calculation gives its unweighted Suzuki counterpart. It establishes neither positivity of the odd operator nor RH.

## The two rank-one parity channels

On $I_a=(-a,a)$, let $L_a$ be the Friedrichs operator for the pole-free form

$$
 \mathcal L_a(f)=\frac1{2\pi}\int_{\mathbb R}
 \bigl[\Re\psi(1/4+it/2)-\log\pi\bigr]|\widehat f(t)|^2dt
 \;-\;2\sum_{n\le e^{2a}}\frac{\Lambda(n)}{\sqrt n}
       \Re\int_{\mathbb R}f(x+\log n)\overline{f(x)}\,dx.
\tag{1}
$$

Every prime power is retained. At fixed $a$, the shift sum is a bounded perturbation of the closed lower-bounded archimedean form, so $L_a$ is self-adjoint on its form domain. The missing pole term of the full Weil form is

$$
 B(f)=2\Re\left(M_+(f)\overline{M_-(f)}\right),\qquad
 M_\pm(f)=\int_{-a}^a e^{\pm x/2}f(x)\,dx.
\tag{2}
$$

The form and its Friedrichs operator commute with reflection. Put $c_a(x)=\cosh(x/2)$, $s_a(x)=\sinh(x/2)$. On even and odd subspaces respectively, (2) gives the **exact** rank-one split

$$
 \boxed{A_a^{\rm even}=L_a^{\rm even}+2|c_a\rangle\langle c_a|,\qquad
        A_a^{\rm odd}=L_a^{\rm odd}-2|s_a\rangle\langle s_a|.}
\tag{3}
$$

Indeed $M_+=M_-=\langle f,c_a\rangle$ for even $f$, whereas $M_+=-M_-=\langle f,s_a\rangle$ for odd $f$. Thus the pole is repulsive in the even sector and attractive in the odd sector. An actual negative test for $L_a^{\rm odd}$ would also be negative for $A_a^{\rm odd}$, and hence would be an RH counterexample by Weil's criterion; none is asserted here.

If $L_a^{\rm odd}>0$, its inverse is bounded and the rank-one criterion is

$$
 A_a^{\rm odd}\ge0
 \quad\Longleftrightarrow\quad
 \tau_a:=2\langle s_a,(L_a^{\rm odd})^{-1}s_a\rangle\le1.
\tag{4}
$$

Equivalently,
$$
 \tau_a=2\sup_{\substack{f\ne0\\ f\ {\rm odd},\ \operatorname{supp}f\subset I_a}}
 \frac{|\langle s_a,f\rangle|^2}{\mathcal L_a(f)}.
\tag{5}
$$

Thus $\tau_a$ is nondecreasing as $a$ increases on any interval where $L_a^{\rm odd}>0$: zero extension embeds the smaller test class into the larger one without changing the full-space form. This monotonicity supplies no upper bound by $1$. The next section shows that global positivity of the pole-free odd form **alone** would imply the full odd Weil positivity condition, so it is already RH-strength.

The theta derivative suggests a route to $L^{\rm odd}\ge0$, but also exposes its obstruction. For the positive even theta radical $\Phi$ normalized by $\int\cosh(x/2)\Phi(x)\,dx=1/2$, the unconditional full-line radical identity gives
$$
 L_\infty(-\Phi')=\tfrac12\sinh(x/2)
\tag{6}
$$
distributionally. The profile $-\Phi'$ is positive on $x>0$, as recorded in [the theta-derivative study](../theta-and-heat/theta-derivative-kernel-logconcavity.md). A positive supersolution argument would require an order-preserving odd-halfline kernel; the next calculation shows that the actual prime term prevents this.

## Why pole-free odd positivity is already RH-strength

Put $h_0=-\Phi'$. It is odd and decays superexponentially. Integration by parts and evenness give
$$
 \langle s,h_0\rangle
 =\int_{\mathbb R}\sinh(x/2)(-\Phi'(x))\,dx
 =\tfrac12\int_{\mathbb R}\cosh(x/2)\Phi(x)\,dx
 =\tfrac14.
\tag{7}
$$
The full theta radical identity $A_\infty h_0=0$ and the odd sign in (3) imply the exact distributional/form identities
$$
 L_\infty h_0=\tfrac12s,\qquad
 \mathcal L_\infty(h_0)=\tfrac18,\qquad
 \mathcal L_\infty(h_0,f)=\tfrac12\langle s,f\rangle
\tag{8}
$$
for compact smooth odd $f$. The first identity does not assert that $s$ is in $L^2(\mathbb R)$.

Suppose $\mathcal L_a(f)\ge0$ for every compact smooth odd $f$ and every $a$. Let $\chi_R$ be smooth even cutoffs and $h_R=\chi_Rh_0$. Theta decay makes $h_R\to h_0$ in every Schwartz seminorm, controlling the logarithmic archimedean form. For the complete prime form, choose any $B>1/2$. Both $|h_0(x)|\le C_Be^{-B|x|}$ and $|h_R(x)-h_0(x)|\le\epsilon_Re^{-B|x|}$ hold with $\epsilon_R\to0$. Their mixed correlations at $\log n$ are $O(\epsilon_R(1+\log n)n^{-B})$, and the error self-correlations are $O(\epsilon_R^2(1+\log n)n^{-B})$. The sum $\sum_{n\ge2}\Lambda(n)(1+\log n)n^{-B-1/2}$ converges. Thus the prime form also converges, with every prime power included. Cauchy–Schwarz for the nonnegative compact form passes to $h_0$, and (8) gives
$$
 \tfrac14|\langle s,f\rangle|^2
 =|\mathcal L_\infty(h_0,f)|^2
 \le\tfrac18\,\mathcal L_a(f).
$$
Consequently
$$
 \boxed{Q_W(f)=\mathcal L_a(f)-2|\langle s,f\rangle|^2\ge0
 \quad\text{for every compact smooth odd }f.}
\tag{9}
$$

Conversely, RH gives $Q_W(f)\ge0$, so $\mathcal L_a(f)=Q_W(f)+2|\langle s,f\rangle|^2\ge0$. Yoshida's odd criterion is stated with **strict** positivity. If (9) had a nonzero compact null $f$, Cauchy–Schwarz polarization against every odd compact test would make the odd distribution $W*f$ vanish. Here is a direct nondegeneracy check. For $x>a$, only the prime translates $f(x-\log n)$ survive. Set $F(z)=\int f(u)e^{-zu}\,du$ and Laplace-transform the identity $W*f=0$ over $x>a$, initially for $\Re z>1/2$. Prime powers $n>e^{2a}$ contribute
$$
 F(z)\sum_{n>e^{2a}}\frac{\Lambda(n)}{n^{z+1/2}}
 =F(z)\left(-\frac{\zeta'}{\zeta}(z+1/2)
            -\sum_{n\le e^{2a}}\frac{\Lambda(n)}{n^{z+1/2}}\right).
$$
The omitted finite-prime corrections have entire transforms. The archimedean tail is analytic for $\Re z>-1/2$, and the pole term has there only the pole at $z=1/2$. Meromorphic continuation therefore forces $F(\rho-1/2)=0$ at every nontrivial zeta zero $\rho$. Jensen's bound gives only $O(T)$ zeros for a nonzero entire function $F$ of exponential type in disks of radius $T$, while [Conrey's unconditional simple-zero theorem](https://doi.org/10.1515/crll.1989.399.1) supplies $\gg T\log T$ **distinct** zeta zeros. Hence $f=0$, so (9) meets Yoshida's strict criterion. This shows that pole-free odd positivity at every scale is equivalent to RH; it does not prove that positivity. The same score projection appears in theta-weighted coordinates in [the theta jump-form reduction](../theta-and-heat/theta-weil-jump-form.md), Section 4.

The same cutoff sequence fixes the large-window value of the scalar return. Whenever $L_a^{\rm odd}>0$ for all $a$, (5) gives, for $a$ containing the support of $h_R$,
$$
 \tau_a\ge
 \frac{2|\langle s,h_R\rangle|^2}{\mathcal L_\infty(h_R)}
 \longrightarrow
 \frac{2(1/4)^2}{1/8}=1
 \qquad(R\to\infty).
$$
The preceding equivalence then gives RH, and (4) bounds every $\tau_a\le1$. Thus $\tau_a\uparrow1$. This explains why a uniform Birman–Schwinger margin below $1$ is impossible; it is a conditional saturation law, not a no-crossing estimate.

## A quantitative lower bound on the return

The saturation test gives a rate without assuming positivity at every scale. There are absolute constants $a_*,c,C>0$ such that, for each $a\ge a_*$ with $L_a^{\rm odd}>0$,
$$
 \boxed{\tau_a\ge 1-C\exp(-c e^{2a}).}
$$
In particular, whenever $\tau_a\le1$ as well, its margin obeys $0\le1-\tau_a\le C\exp(-c e^{2a})$. This is a lower bound on the return, not the missing upper bound.

To prove it, choose a fixed smooth cutoff profile and, for $a>2$, let $\chi_a$ be even, equal to $1$ on $[-a+1,a-1]$, supported in $(-a,a)$, and have first derivative bounded independently of $a$. Put $h_a=\chi_a h_0$. The theta series for $\Phi$ and its derivatives gives, for each fixed $j$ and $B>0$,
$$
 \sup_{x\in\mathbb R}e^{B|x|}
 \left|\partial_x^j(h_a-h_0)(x)\right|
 +\|h_a-h_0\|_{H^1(\mathbb R)}
 \le C_{j,B}\exp(-c_{j,B}e^{2a})
$$
for large $a$. Indeed the error is supported where $|x|\ge a-1$, while each theta derivative there is bounded by a fixed exponential polynomial in $|x|$ times $\exp(-\pi e^{2|x|})$. Decrease $c>0$ once to use the same rate in the following estimates.

Take $B>1/2$. The score moment satisfies $\langle s,h_a\rangle=1/4+O(e^{-c e^{2a}})$ by the weighted bound. The archimedean multiplier in (1) has absolute value at most $C(1+t^2)$, so the $H^1$ bound gives an archimedean form error $O(e^{-c e^{2a}})$. For the complete prime form, the mixed correlation of $h_a-h_0$ with $h_0$ at $u=\log n$ is at most
$$
 C e^{-c e^{2a}}(1+u)e^{-Bu};
$$
the error self-correlation has the same bound after enlarging $C$. The resulting series converges because $\sum_{n\ge2}\Lambda(n)(1+\log n)n^{-B-1/2}<\infty$. Thus (8) yields
$$
 \mathcal L_a(h_a)=\mathcal L_\infty(h_a)
     =\tfrac18+O(e^{-c e^{2a}})>0.
$$
Finally (5) permits $h_a$ as a test and gives
$$
 \tau_a\ge
 \frac{2|\langle s,h_a\rangle|^2}{\mathcal L_a(h_a)}
     =1+O(e^{-c e^{2a}}),
$$
where the equality is an estimate for this one test quotient, not for $\tau_a$. Its lower side is the displayed bound.

## A positive offdiagonal form value from the first prime

Take $a=3/4$, $t_2=\log2$, and positive centers
$$
 x_0=1/5,\qquad y_0=t_2-1/5.
$$
They are distinct and lie in $(0,a)$; their difference $t_2-2/5$ is strictly between $0$ and $t_2$, whereas their sum is exactly $t_2$. Choose a nonnegative even $\eta\in C_c^\infty(-1,1)$ with $\|\eta\|_2=1$. For sufficiently small $\varepsilon>0$, set
$$
 f_\varepsilon(x)=\varepsilon^{-1/2}\eta((x-x_0)/\varepsilon),\qquad
 g_\varepsilon(x)=\varepsilon^{-1/2}\eta((x-y_0)/\varepsilon)
 \quad(x>0),
$$
and extend them oddly to $F_\varepsilon,G_\varepsilon\in C_c^\infty(I_a)$. The explicit choice $0<\varepsilon<1/100$ makes the four supports pairwise disjoint, keeps them inside $I_a$, and excludes every prime-power cross separation except the reflected $\log2$ edge.

The archimedean offdiagonal kernel is $-r(|x-y|)$, where
$r(t)=e^{-t/2}/(1-e^{-2t})$. The minimum cross separation is $\log2-2/5-2\varepsilon>1/4$, using $\log2>2/3+2/81>67/100$. As $r$ decreases and $r(1/4)<3$, while $\|F_\varepsilon\|_1=\|G_\varepsilon\|_1=2\sqrt\varepsilon\|\eta\|_1\le2\sqrt{2\varepsilon}$, the archimedean cross form has absolute value below $24\varepsilon$. The diagonal multiplier contributes zero because the supports are disjoint.

For the prime part, direct positive-halfline separations stay below $\log2$, and the only reflected separation meeting a prime-power logarithm is $x_0+y_0=\log2$. The two reflected overlaps have the same sign after odd extension. Their contribution is exactly
$$
 \mathcal L_{\rm prime}(F_\varepsilon,G_\varepsilon)
 =2\frac{\log2}{\sqrt2}
   \int_{\mathbb R}\eta(z)\eta(-z)\,dz
 =2\frac{\log2}{\sqrt2}>0
\tag{10}
$$
for all sufficiently small $\varepsilon$. No larger prime power can enter these cross supports. Combining the terms,
$$
\boxed{\mathcal L_a(F_\varepsilon,G_\varepsilon)
 =2\frac{\log2}{\sqrt2}+O(\varepsilon)
 >\frac89-\frac6{25}>0\qquad(0<\varepsilon<1/100).}
\tag{11}
$$

On the positive halfline, $f_\varepsilon,g_\varepsilon$ are nonnegative and disjoint. The effective odd archimedean kernel is
$-r(|x-y|)+r(x+y)<0$, but odd reflection turns the actual $n=2$ shift into a **positive** offdiagonal edge $+2(\log2)/\sqrt2\,\delta(x+y-\log2)$ in the unnormalized halfline form. Equation (11) shows that this edge beats the archimedean cross interaction for narrow bumps. In particular, $e^{-tL_a^{\rm odd}}$ cannot preserve the positive cone on the halfline: for small $t>0$, its pairing between these disjoint positive bumps is $-t\mathcal L_a(F_\varepsilon,G_\varepsilon)+o(t)<0$.

Thus the positive theta-derivative forcing (6) is not, by itself, a Picone or maximum-principle proof of $L_a^{\rm odd}\ge0$. The scalar return in (4) remains the exact odd-sector target; its observed numerical closeness to $1$ is not used as evidence for an inequality.

## Exact onset of the odd-halfline positivity obstruction

The first prime gives a sharp threshold for positivity preservation by the odd-halfline semigroup. Put $a_0=(\log2)/2$ and identify an odd function on $(-a,a)$ with its restriction $f$ to $(0,a)$. Then
$$
 \boxed{\{e^{-tL_a^{\rm odd}}:t\ge0\}\text{ is a positivity-preserving semigroup on }(0,a)
 \quad\Longleftrightarrow\quad a\le a_0.}
\tag{12}
$$
The assertion concerns order preservation, not the sign of the spectrum.

For $a\le a_0$, no prime-power shift has a nonzero overlap with $(-a,a)$. Let $F$ be the zero extension of the odd function corresponding to $f$. The archimedean part of (1) has the full-line jump representation
$$
 \mathcal A(F)=m_0\|F\|_2^2+
 \frac12\iint_{\mathbb R^2}r(|x-y|)|F(x)-F(y)|^2\,dx\,dy,
 \qquad m_0=\psi(1/4)-\log\pi.
\tag{13}
$$
On the positive halfline its interior interaction is
$$
 \iint_{(0,a)^2}\left[r(|x-y|)|f(x)-f(y)|^2
       +r(x+y)|f(x)+f(y)|^2\right]dx\,dy.
$$
Rewrite this as
$$
 \iint_{(0,a)^2}\bigl[r(|x-y|)-r(x+y)\bigr]
              |f(x)-f(y)|^2dx\,dy
 +2\iint_{(0,a)^2}r(x+y)(|f(x)|^2+|f(y)|^2)dx\,dy.
\tag{14}
$$
The interaction outside $(-a,a)$ is another nonnegative diagonal term. Since $r$ strictly decreases and $|x-y|<x+y$ for $x,y>0$, the jump weight in (14) is positive. The remaining terms are multiplication potentials, with the constant $m_0$ merely shifting the generator. The standard absolute-value contraction for this jump form, first on smooth tests and then on its form closure, proves that its semigroup preserves positivity. At $a=a_0$, the $n=2$ overlap consists only of endpoints and is still zero in the form.

For each $a>a_0$, set $t_2=\log2$ and choose
$$
 0<d<\min(a-t_2/2,t_2/4),\qquad
 x_d=t_2/2-d,\quad y_d=t_2/2+d.
$$
Both centers lie in $(0,a)$, with $x_d+y_d=t_2$ and $0<y_d-x_d=2d<t_2$. Take the even nonnegative normalized bump $\eta$ used above, place $L^2$-normalized $\varepsilon$-bumps at these centers, and extend them oddly to $F_\varepsilon,G_\varepsilon$. Once $\varepsilon$ is smaller than the distances to the endpoints and the other prime-power logarithms, their only prime cross edge is the reflected $n=2$ edge. Exactly as in (10),
$$
 \mathcal L_{a,\mathrm{prime}}(F_\varepsilon,G_\varepsilon)
     =2\frac{\log2}{\sqrt2},\qquad
 \mathcal L_{a,\mathrm{arch}}(F_\varepsilon,G_\varepsilon)=O_d(\varepsilon).
\tag{15}
$$
The second bound holds because all cross supports are separated by at least $d$ for small $\varepsilon$, so the archimedean offdiagonal kernel is bounded there. Consequently $\mathcal L_a(F_\varepsilon,G_\varepsilon)>0$ for sufficiently small $\varepsilon$. Their positive-halfline restrictions are nonnegative with disjoint support. A positivity-preserving semigroup would require their cross form to be nonpositive, either by the form criterion or by differentiating their initially zero semigroup pairing at time zero. This proves the reverse implication in (12). The failure starts immediately when the first prime is admitted; it supplies no negative quadratic test for $L_a^{\rm odd}$.

## The truncated theta derivative is not a supersolution

The prime obstruction also affects the actual positive theta profile, not just specially chosen bumps. Let \(h=-\Phi'>0\) on \((0,\infty)\), fix \(a=1/2\), and put \(H=h\mathbf1_{(-a,a)}\), with the odd definition of \(h\) on the negative halfline. For every
\[
 x\in J:=\left[\frac16-\frac1{200},\frac16+\frac1{200}\right]
      =\left[\frac{97}{600},\frac{103}{600}\right],
\]
the pointwise convolution representative of the pole-free operator satisfies the explicit strict bound
\[
 \boxed{(L_{1/2}^{\rm odd}H)(x)<-\frac{23}{1875}<0.}
\tag{16}
\]
Thus restricting the positive full-line solution \(L_\infty h=s/2>0\) does not give a nonnegative supersolution on this window. Equation (16) does not give a negative quadratic test for \(L_{1/2}^{\rm odd}\).

Here is a bound retaining every prime power. Write \(t_n=\log n\), \(w_n=\Lambda(n)/\sqrt n\), and \(D=-r'\). For \(0<x<a\), the omitted exterior action is exactly
\[
 E_a(x):=(L_\infty h)(x)-(L_aH)(x)
 =-\int_a^\infty [r(y-x)-r(y+x)]h(y)\,dy
 +\sum_{n\ge2}w_n
  \left[\mathbf1_{t_n-x>a}h(t_n-x)
       -\mathbf1_{t_n+x>a}h(t_n+x)\right].
\tag{17}
\]
On \(J\), \(t_2-x>a\), so both indicators equal one for every prime power. The theta expansion gives
\[
 h(u)=\sum_{m\ge1}e^{u/2-y_m}y_mP(y_m),\qquad
 y_m=\pi m^2e^{2u},\quad P(y)=8y^2-30y+15.
\]
For \(u\ge t_2-103/600\), one has \(y_m>8\). Each summand is positive and decreasing there: \(P(y)\ge(17/4)y^2\), and its logarithmic derivative is at most
\[
 \frac52-2y+\frac{2yP'(y)}{P(y)}
 \le\frac52-2y+\frac{128}{17}<0\qquad(y\ge8).
\]
Consequently every summand in the prime series of (17) is nonnegative, and the \(n=2\) term alone gives
\[
 E_a(x)\ge w_2[h(t_2-x)-h(t_2+x)]
                -2xD(a-x)\Phi(a).
\tag{18}
\]
Indeed \(r(t)=\sum_{k\ge0}e^{-(2k+1/2)t}\) makes \(D\) positive and decreasing, so \(r(y-x)-r(y+x)\le2xD(a-x)\) for \(y\ge a\); also \(\int_a^\infty h(y)dy=\Phi(a)\).

For clarity, the elementary enclosures used in (18) are
\[
 \begin{array}{c|c}
 \text{quantity}&\text{strict bound}\h(t_2-97/600)&>1/2\\
 h(t_2+97/600)&<1/50\\
 \Phi(1/2)&<2/25\\
 D(197/600)&<11/2\\
 \tfrac12\sinh(103/1200)&<1/20
 \end{array}
\tag{19}
\]
These bounds can be checked with rational arithmetic. Use \(223/71<\pi<22/7\), \(56/81<\log2<7/10\), and, for \(0\le z\le1\), the lower and upper Taylor bounds
\[
 S_N(z):=\sum_{k=0}^N\frac{z^k}{k!}
 \le e^z\le S_N(z)+\frac{z^{N+1}}{(N+1)!}
                 \frac1{1-z/(N+2)},
\]
with the alternating partial sums for \(e^{-z}\). At \(z=97/300\), use the degree-five lower and degree-four upper alternating sums to get
\(909/100<4\pi e^{-z}<91/10\) and
\(173/10<4\pi e^z<18\). For the first row of (19), the \(m=1\) theta term is greater than \(3660e^{-177/20}>3660/7100>1/2\); all other terms are positive. For the second row, \(P(y)\le8y^2\), \(e^{9/20}<8/5\), and
\(\sum_{m\ge1}m^6e^{-(173/10)m^2}<2e^{-173/10}\), while \(e^{173/10}>2\cdot10^7\), giving a bound below \(1/50\). The sum bound follows from \(m^6\le e^{6(m-1)}\) and \(m^2-1\ge3(m-1)\) for \(m\ge2\). The exponential inequalities here follow, for example, from \(e<2.72\), \(e^{3/20}>23/20\), and \(e>2.7\). For the third row, \(17/2<\pi e<9\); the first theta term is below \((13/10)238e^{-17/2}<.074\), since \(e^{17/2}>4200\). The tail over \(m\ge2\) is below \(10^{-6}\): its terms are bounded by \(4(13/10)9^2m^4e^{-(17/2)m^2}\), and the ratio of successive terms is below \(1/2\) for \(m\ge2\), so the sum is below \(4(13/10)9^2\cdot32e^{-34}<10^{-6}\). For the fourth row, at \(t=197/600\), \(e^{-2t}<53/100\) and \(e^{-t/2}<43/50\), whence
\[
 D(t)=\frac{e^{-t/2}}{1-e^{-2t}}
       \left(\frac12+\frac{2e^{-2t}}{1-e^{-2t}}\right)
 <\frac{11137}{2209}<\frac{11}{2}.
\]
The final row follows by the same Taylor bounds. These estimates leave a rational margin, so endpoint rounding plays no role.

Since \(h\) decreases on the relevant range, (19) applies uniformly on \(J\). Also \(2x\le103/300\), \(a-x\ge197/600\), and \(w_2=(\log2)/\sqrt2>4/9\). Combining (6), (18), and (19) gives
\[
 (L_aH)(x)=\tfrac12\sinh(x/2)-E_a(x)
 <\frac1{20}+\frac{103}{300}\frac{11}{2}\frac2{25}
       -\frac49\left(\frac12-\frac1{50}\right)
 =-\frac{23}{1875},
\]
which proves (16). The jump signs of the exterior defect are also fixed by (17): as \(a\) passes \(t_n-x\) within \(a>x\), its reflected contribution drops by \(w_nh(t_n-x)>0\); as \(a\) passes \(t_n+x\), its direct contribution rises by \(w_nh(t_n+x)>0\), provided no other threshold coincides. Thus this boundary defect has no general monotonicity in the window size.
