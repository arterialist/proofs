# The raw prolate vector and the Weil residual-to-gap test

This analytic result gives no lower bound proving Weil positivity. It instead obstructs the particular residual-to-gap estimate proposed for Connes's unsmoothed two-mode vector. The distinction from actual eigenvector approximation matters: a small high-energy boundary error can have a large operator residual.

## Statement and normalization

Use the compact Weil operator and its full gamma, pole and prime-power terms from [the actual-residual note](connes-weil-prolate-actual-residual.md), equation (2). Put $a=\log\lambda$, $c=2\pi\lambda^2$. Let $p_{j,\lambda}$ be the real, physical $L^2[-\lambda,\lambda]$-normalized prolate function of full order $j$, and put
\[
\psi_{j,c}(t)=\sqrt\lambda\,p_{j,\lambda}(\lambda t),\qquad
\mu_j^2=\nu_j.
\]
Here $\mu_j$ is the compressed Fourier eigenvalue in the physical Fourier convention $e^{2\pi iqv}$. In particular $\mu_0,\mu_4>0$. Connes indexes the even modes by half their order and calls these $\chi_0,\chi_2$; they must not be confused with full-order indices.

Fix the scalar normalization
\[
I_j=\int_{-\lambda}^{\lambda}p_{j,\lambda},\qquad
h=I_0p_{4,\lambda}-I_4p_{0,\lambda},\qquad
k(x)=e^{x/2}\sum_{n\ge1}h(ne^x),\quad -a<x<a,
\tag{1}
\]
with $h,k$ zero extended. Values at the finitely many jump sites do not matter. Set
\[
\kappa=\|k\|_2,\quad R=Q(k)/\kappa^2,\quad
r=\|(A_a-R)k\|_2/\kappa.
\]
These last two quantities do not depend on the nonzero scalar choice for $h$.

There are constants $C,K,c_0>0$ such that, for $c\ge c_0$,
\[
|R|\le Cc^Ke^{-2c},\qquad E_1(a)\le Cc^Ke^{-2c}.
\tag{2}
\]
The second inequality is the already proved two-vector weighted-tail min--max bound. On the cofinal sequence
\[
\lambda^2=N+\tfrac12,\qquad N\in\mathbb N,
\tag{3}
\]
there are possibly different positive constants with
\[
r\ge C^{-1}c^{-K}e^{-3c/2}.
\tag{4}
\]
Consequently at every sufficiently large member of (3), either $R\ge E_1$, or
\[
\boxed{\quad \frac{r}{E_1-R}\ge C^{-1}c^{-K}e^{c/2}.\quad}
\tag{5}
\]
Thus the raw vector cannot satisfy the residual-to-gap transfer in [the gap note](connes-weil-gap-residual-transfer.md), equations (3)--(6), at all large scales. The required ratio does not even tend to zero along (3). Nothing here proves that the actual angle to the ground eigenspace is large. The form-angle alternative and a smoother trial vector are not excluded. Nor does (4) exclude the weaker Temple condition $r^2/(E_1-R)\to0$.

The [companion operator estimate](connes-raw-prolate-squared-residual-scale.md)
sharpens (4) to $r\ge C^{-1}c^{-K}e^{-c}$ on (3) and gives
$r\le Cc^Ke^{-c}$ for all large $c$. In the second case of (5),
the lower bound for the ratio accordingly strengthens to
$C^{-1}c^{-K}e^c$. This still does not decide Temple's quotient.

In the proof below, $\operatorname{poly}(c)$ always means $Cc^K$ with fixed constants independent of $\lambda$. Constants may change between estimates. No differentiated asymptotic of a concentration eigenvalue is used.

## 1. Exterior energy also gives an endpoint lower bound

The exterior ODE and monotonicity already proved in [the weighted-tail note](connes-prolate-weighted-fourier-tail-ode.md), equations (6)--(8), apply to
\[
F_j(y)=\int_{-1}^1\psi_{j,c}(t)e^{icty}\,dt,
\quad q=y^2-1,\quad V=c^2y^2-\kappa_j(c).
\]
For fixed $j$, take $c\ge1$ so large that $0\le\kappa_j<c^2$. They give
\[
(qF_j')'+VF_j=0,\qquad
|F_j(y)|\le |F_j(1)|,\qquad
q|F_j'|^2\le V|F_j(1)|^2\quad(y>1).
\tag{6}
\]
Set $u(y)=\sqrt q\,F_j(y)$ for $y\ge2$. Direct differentiation gives
\[
u''+\Omega^2u=0,\qquad
\Omega^2=c^2+\frac{c^2-\kappa_j}{y^2-1}
+\frac1{(y^2-1)^2}.
\tag{7}
\]
Here $\Omega^2\ge c^2$ and $(\Omega^2)'<0$. Therefore
\[
\frac d{dy}\bigl(|u'|^2+\Omega^2|u|^2\bigr)
=(\Omega^2)'|u|^2\le0.
\]
At $y=2$, (6) gives $|F_j'|\le2c|F_j(1)|/\sqrt3$, $|u|\le\sqrt3|F_j(1)|$ and $|u'|\le4c|F_j(1)|$. Also $\Omega(2)^2\le(13/9)c^2$. Hence the energy there is at most $24c^2|F_j(1)|^2$. It follows that
\[
|F_j(y)|^2\le\frac{24|F_j(1)|^2}{y^2-1}\quad(y\ge2).
\]
Use (6) on $[1,2]$ and $\int_2^\infty (y^2-1)^{-1}dy=\frac12\log3$. This proves
\[
\int_1^\infty|F_j(y)|^2dy\le16|F_j(1)|^2.
\tag{8}
\]
The normalization is important. Plancherel and the compressed Fourier relation give
\[
\int_1^\infty|F_j|^2=\frac{1-\mu_j^2}{2\lambda^2},
\qquad F_j(1)=\frac{\mu_j}{\lambda}\psi_{j,c}(1).
\]
Consequently, together with the previously proved upper bound,
\[
\frac{\sqrt{1-\nu_j}}{\sqrt{32}\,|\mu_j|}
\le |\psi_{j,c}(1)|
\le\frac{\sqrt{20}\,c}{|\mu_j|}\sqrt{1-\nu_j}.
\tag{9}
\]
This endpoint lower bound is obtained from a positive exterior ODE energy, not from the Weil form.

## 2. The two-mode endpoint cannot cancel

The classical fixed-full-index Fuchs asymptotic, with the bandwidth convention used here, is
\[
1-\nu_j(c)\sim C_jc^{j+1/2}e^{-2c},\qquad C_j>0.
\tag{10}
\]
Only the cases $j=0,4$ and their powers are needed. It follows from (9)--(10) that
\[
|\psi_{4,c}(1)|\ge C^{-1}c^{9/4}e^{-c},\qquad
|\psi_{0,c}(1)|\le Cc^{5/4}e^{-c}.
\tag{11}
\]
The fixed-mode oscillator convergence established in the two-vector note implies that the physical values $p_{j,\lambda}(0)$ converge, up to harmless choices of sign, to the nonzero corresponding Hermite values. To pass from its local $L^2$ convergence to point evaluation, use its uniform local $H^1$ bound and one-dimensional compactness. Thus $I_j=\mu_jp_{j,\lambda}(0)$ is bounded for $j=0,4$, and $|I_0|$ is bounded below.

The actual upper-endpoint value of (1) is exactly
\[
B_+=k(a-)=\sqrt\lambda\,h(\lambda)
=I_0\psi_{4,c}(1)-I_4\psi_{0,c}(1).
\tag{12}
\]
Triangle inequality, (11) and the preceding bounds prove, for all sufficiently large $c$,
\[
|B_+|\ge C^{-1}c^{9/4}e^{-c}.
\tag{13}
\]
This argument does not presume the signs of the endpoint values; the order-four contribution dominates in magnitude.

The origin defect is much smaller. The exact identities $I_j=\mu_jp_j(0)$ give
\[
h(0)=(\mu_0-\mu_4)p_0(0)p_4(0),\qquad
|h(0)|\le\operatorname{poly}(c)e^{-2c}.
\tag{14}
\]
There is no replacement of the full-order $\mu_4$ by the negative-sign full-order $\mu_2$.

## 3. Full-form control of the actual Rayleigh quotient

Use the specified Gevrey cutoff from the weighted-tail note, with scaled collar width $\eta=(100c^2)^{-1}$. In physical coordinates write it as $\rho(q/\lambda)$. Choose fixed even compactly supported smooth Gevrey functions $b,d$ near the origin such that
\[
b(0)=0,\quad\int b=1,\qquad d(0)=1,\quad\int d=0.
\]
Define
\[
m=\int\rho(q/\lambda)h(q)dq,
\qquad h^\sharp=\rho(q/\lambda)h-mb-h(0)d.
\tag{15}
\]
Then $h^\sharp$ is even Schwartz, supported strictly inside the window, with $h^\sharp(0)=\int h^\sharp=0$ exactly.

The exterior-ODE endpoint and collar estimates in the weighted-tail proof hold for every bounded coefficient combination of the two modes, regardless of its value at zero. They give $|m|\le\operatorname{poly}(c)e^{-c}$. The same low/high-frequency proof therefore gives, for any fixed $M>1$,
\[
D_M(h^\sharp)\le\operatorname{poly}(c)e^{-c}.
\tag{16}
\]
The extra term $h(0)d$ is legitimate here: its coefficient is bounded by (14), and for fixed Schwartz $d$, $D_M(d)$ is bounded by a polynomial in $\lambda$ on $v\ge\lambda$. Its integral is zero and it exactly removes the origin defect. No unproved Fourier eigenrelation outside the compressed window is used.

Put $F^\sharp=\mathcal E(h^\sharp)$ in logarithmic coordinates and split it as $F^\sharp=k^\sharp+t$, with $k^\sharp$ on $[-a,a]$ and $t$ on $(-\infty,-a)$. Let $e=k-k^\sharp$. The source-exact global radical identity from the two-vector note gives
\[
Q(k)=Q(t)-2\Re q(t,e)+Q(e).
\tag{17}
\]
Every term here belongs to the full Weil form.

Here are sufficient bounds to justify the claimed scale without using positivity. For a function $f$ of bounded variation on the line, including its jumps, define
\[
\mathcal V(f)=\|f\|_1+\operatorname{Var}(f).
\]
The elementary Fourier bound $|\widehat f(\tau)|\le C\mathcal V(f)\min(1,|\tau|^{-1})$ gives
\[
\int(1+\log(1+\tau^2))|\widehat f(\tau)|^2d\tau
\le C\mathcal V(f)^2.
\tag{18}
\]

The physical difference $h-h^\sharp$ has piecewise value and first derivative bounded by $\operatorname{poly}(c)e^{-c}$. On the terminal collars this is the endpoint ODE estimate; elsewhere it consists of the two small fixed smooth corrections in (15). It has only the two terminal jumps. The restricted arithmetic sum has at most $\lambda^2$ terms. Differentiating each smooth piece of $\mathcal E(h-h^\sharp)$, and summing its at most $\lambda^2$ jumps, therefore gives
\[
\|e\|_\infty+\mathcal V(e)\le\operatorname{poly}(c)e^{-c}.
\tag{19}
\]
All dilation factors are at most powers of $\lambda$ on the compact window. In particular (19) includes the actual discontinuities rather than treating the vector as smooth.

Choose $M=2$ in (16). The proved Poisson tail estimate gives, with $B=3/2$,
\[
|t(x)|+|t'(x)|\le\epsilon e^{B(x+a)}\quad(x<-a),
\qquad \epsilon\le\operatorname{poly}(c)e^{-c}.
\tag{20}
\]
Including its jump at $-a$, $\mathcal V(t)\le C\epsilon$, and the full tail estimate gives $|Q(t)|\le C\epsilon^2$.

The gamma multiplier is bounded in absolute value by $C(1+\log(1+\tau^2))$. Hence (18)--(20) bound both gamma terms in (17) by $\operatorname{poly}(c)e^{-2c}$. For the pole terms, $|M_\pm(e)|\le\lambda^{1/2}\|e\|_1$, whereas (20) gives $|M_\pm(t)|\le C\epsilon\lambda^{\mp1/2}$. Their products have the same required scale.

For $Q(e)$, only prime powers $n<\lambda^2$ occur. Their shifts have norm at most one, and
\[
\sum_{n<\lambda^2}\frac{\Lambda(n)}{\sqrt n}
\le\sum_{n<\lambda^2}\frac{\log n}{\sqrt n}
\le\operatorname{poly}(c).
\]
For the cross term no prime-power truncation is assumed. If $d=\log n>0$, the only possible orientation pairs $t(x)$ with $e(x+d)$. Changing variables to the compact-window argument and using (20) gives
\[
\left|\int t(x)\overline{e(x+d)}dx\right|
\le\epsilon\lambda^{2B}n^{-B}\|e\|_1.
\tag{21}
\]
Multiplying by $\Lambda(n)/\sqrt n$ and summing is absolutely convergent because $B+1/2=2>1$. This retains every prime power and proves
\[
|q(t,e)|+|Q(e)|+|Q(t)|\le\operatorname{poly}(c)e^{-2c}.
\tag{22}
\]

Finally $\kappa$ is bounded below independently of large $c$. The two-vector note's uniform lower bound for $\mathcal E$ on the fixed six-mode span, restricted to $[1,2]$, applies in particular to $h$ in its two-mode subspace, without requiring the zero-value constraint. The coefficient norm of $h$ is $(I_0^2+I_4^2)^{1/2}$, bounded below. The same arithmetic-sum estimates give the sufficient upper bound $\kappa\le\operatorname{poly}(c)$. Divide (17), (22) by $\kappa^2$ to obtain the first part of (2).

## 4. An actual cofinal collar and residual lower bound

Take (3) and write $L=\lambda^2=N+1/2$. On the upper logarithmic collar
\[
x=a-s,\qquad 0<s<\delta_0:=\frac1{10L},
\tag{23}
\]
the function $k(x)$ itself has only its $n=1$ summand. For every prime-power shift $m<L$, the translated argument $x-\log m$ is immediately to the left of the jump $a-\log m$. It encounters no next arithmetic jump, because
\[
\log((m+1)/m)\ge\frac1{2m}>\delta_0.
\]
It also stays above the lower window endpoint: the worst case is $m=N$, and
\[
\log(L/N)=\log(1+1/(2N))\ge\frac1{2N+1}>\delta_0.
\]
All $x+\log m$ lie beyond the upper endpoint. Thus the finite prime-shift terms have a single smooth branch throughout (23). Coincident translated jumps at $s=0$ are allowed and do not spoil this one-sided statement.

Values and any fixed finite number of physical derivatives of the two fixed prolate modes are polynomially bounded in $c$, directly from their compressed Fourier relation and $L^1$ bounds. Consequently $k$ and its first two derivatives on smooth pieces, its supremum, and all finite prime and pole contributions and their collar derivatives are polynomially bounded. The first original interior jump is at distance $\log2$ from the upper endpoint, so the nonlocal archimedean integral has no approaching interior jump on this collar.

Apply the exact boundary decomposition of the actual-residual note. For $g=(A_a-R)k$ it gives
\[
g(a-s)=\frac{B_+}{2}\log(1/s)+G(s),
\qquad
\sup_{0<s<\delta}|G(s)-G(0)|
\le Cc^K\delta(1+|\log\delta|)
\tag{24}
\]
for $0<\delta<\delta_0$. Here the constants are uniform along (3). To check the only singular integral in this assertion, split it at a fixed distance less than $\log2$ from the upper endpoint. In the local part, expand $k$ to first order with a second-derivative remainder and use $r(s)=1/(2s)+O(1)$. The linear integral has modulus $O(\delta(1+|\log\delta|))$ and the remainder is better. In the distant part the kernel and its derivative are bounded and integrable against the polynomially bounded compact $k$. The term $[k(a-s)-B_+]\log(1/s)$ has the same modulus. The other boundary factor is smooth, and the prime branches were checked in (23). The term $Rk$ has polynomially bounded derivative by (2). These observations give (24) with no exponentially large regularity constant.

For completeness, use the mean-zero test function
\[
\rho_\delta(s)=\log(\delta/s)-1,\quad0<s<\delta.
\]
Its squared norm is $\delta$, its $L^1$ norm is $2\delta/e$, and $\int\log(1/s)\rho_\delta(s)ds=\delta$. Pairing (24) with $\rho_\delta/\sqrt\delta$ proves
\[
r\ge\frac{\sqrt\delta}{\kappa}
\left(\frac{|B_+|}{2}-\frac2e
\sup_{0<s<\delta}|G(s)-G(0)|\right)_+.
\tag{25}
\]
Choose a fixed sufficiently large exponent $L_0$ and set $\delta=e^{-c}c^{-L_0}$. Equations (13), (24) imply that the second term in parentheses is at most $|B_+|/4$ for all large $c$. Also $\delta<\delta_0$, and $\kappa\le\operatorname{poly}(c)$. This proves (4). Combining (2) and (4) proves (5).

## Dependencies and scope

The prior mathematical inputs are precisely these:

* The full operator, operator-domain membership of the raw piecewise smooth vector, boundary coefficient $B_+/2$, and logarithmic collar test are in `connes-weil-prolate-actual-residual.md`. All pole and prime-power terms are kept above.
* The global radical identity, fixed-span oscillator convergence, uniform arithmetic-image lower bound, full tail form bound, and two-vector min--max principle are in [the two-vector note](connes-weil-two-vector-tail-minmax.md).
* The exterior ODE monotonicity, collar estimate, and specified Gevrey weighted-tail proof are in `connes-prolate-weighted-fourier-tail-ode.md`. The extension in (15)--(16) explicitly repairs the actual two-mode origin defect.
* The classical fixed-index asymptotic (10) is due to W. H. J. Fuchs, [*On the eigenvalues of an integral equation arising in the theory of band-limited signals*](https://doi.org/10.1016/0022-247X(64)90017-4), J. Math. Anal. Appl. 9 (1964), 317–330. No derivative asymptotic is inferred from it. The source normalization and Connes's half-order indexing are also discussed in [Connes §6.3–6.6](https://arxiv.org/html/2602.04022).

The result is an asymptotic obstruction to the raw-vector **operator-residual transfer**, using the cited established prolate asymptotics and previously proved analytic inputs. It does not exclude a smoother vector, a direct form-angle bound, or an actual eigenvector comparison established by a sharper method. In particular, a large residual divided by a tiny spectral gap is not a lower bound on the true eigenvector angle. No simplicity, parity, positive spectral gap, RH, or novelty claim is made.
