# Complete prime histories as causal delay overflow

This construction realizes the exact finite-prime coefficient law as a physical projection-compression observable. It uses a Fourier-band regularization and retains the interference terms before passing to the mean. The positive overflow density is not identified with the unaveraged signed Weil or clipping form.

## 1. The actual causal cascade and its integer histories

For a nonempty finite prime set $S$, set
$$
\Theta=\sum_{p\in S}\log p,\qquad P_S=\prod_{p\in S}p,\qquad
r_p=p^{-1/2}.
$$
Use the unitary Fourier transform from the physical variable $x$ to $t$, with exponent $e^{-itx}$. Removing the explicit phase advance from the complete Euler unitary gives
$$
C_S(t)=e^{-i\Theta t}U_S(t)
=\prod_{p\in S}
\frac{e^{-it\log p}-r_p}{1-r_pe^{-it\log p}}.
\tag{1}
$$
The corresponding operator $\mathcal C_S$ is unitary and causal:
$$
\mathcal C_S=\sum_{K\ge0}a_KT_K,\qquad
T_Kf(x)=f(x-K).
$$
At a single prime the coefficients are
$$
a_{p,0}=-r_p,\qquad
a_{p,k}=(1-r_p^2)r_p^{k-1}\quad(k\ge1).
$$
Every geometric depth is included. The finite product satisfies
$\sum_K|a_K|(1+K)^j<\infty$ for each fixed $j$.
Unique factorization identifies the delays with $K=\log n$, for all actual $S$-smooth positive integers $n$. In particular,
$$
\boxed{|a_{\log n}|^2=
\frac{\varphi(\operatorname{rad}n)^2}{nP_S}.}
\tag{2}
$$
The empty radical at $n=1$ has totient one. Summing (2) gives one: its local factor before division by $P_S$ is
$1+(p-1)^2\sum_{k\ge1}p^{-k}=p$.

Thus the squared coefficients define independent stored depths $K_p$:
$$
\Pr(K_p=0)=p^{-1},\qquad
\Pr(K_p=k)=(1-p^{-1})^2p^{-(k-1)},\quad k\ge1.
$$
If $Y_S=\sum_{p\in S}(\log p)\nu_p$ is the complete coefficient law already proved for $U_S$, then
$$
\boxed{K=\sum_pK_p\log p=\Theta-Y_S,\qquad
\mathbb EK=\Theta.}
\tag{3}
$$
The equality is a coordinatewise coupling $K_p=1-\nu_p$, not just equality of limiting distributions.

## 2. An exact physical-port formula at finite bandwidth

Let $\Pi_\Omega$ be the Fourier projection onto $[-\Omega,\Omega]$, and put
$$
A_b=\mathbf1_{(b,\infty)}\mathcal C_S
\mathbf1_{(-\infty,0]},\qquad b\ge0.
$$
Then $A_b\Pi_\Omega$ is Hilbert--Schmidt for every finite $\Omega>0$, and
$$
\boxed{
\frac{\pi}{\Omega}\|A_b\Pi_\Omega\|_2^2
=\sum_{K,J}a_K\overline{a_J}\,
\operatorname{sinc}(\Omega(K-J))(\min(K,J)-b)_+.}
\tag{4}
$$
Here $\operatorname{sinc}(u)=\sin u/u$, with value one at zero. Equation (4) contains all off-diagonal history interference.

The band projection has kernel
$k_\Omega(x-y)=\sin(\Omega(x-y))/[\pi(x-y)]$.
The $K$-term in $A_b\Pi_\Omega$ has kernel
$$
a_K\mathbf1_{\{b<x\le K\}}k_\Omega(x-K-y).
$$
The reproducing identity for $\Pi_\Omega$ gives
$$
\int k_\Omega(x-K-y)\overline{k_\Omega(x-J-y)}\,dy
=k_\Omega(J-K).
$$
The remaining $x$-interval has length $(\min(K,J)-b)_+$, proving (4) first for a finite delay sum. The $K$-term has Hilbert--Schmidt norm
$|a_K|\sqrt{\Omega(K-b)_+/\pi}$. Summability of these norms proves convergence of the operator series in that norm and justifies the absolutely convergent double sum. No square of a delta distribution is used.

The same expression is the average over $|t|\le\Omega$ of the coherent output energy for the cut-off input plane wave
$\mathbf1_{\{x\le0\}}e^{itx}$. Though that input is not globally square integrable, its transmitted output beyond $b$ is square integrable by the weighted coefficient bound. The kernel argument above supplies a rigorous operator definition without relying on that formal input alone.

Distinct delays have $K-J\ne0$, so dominated convergence yields
$$
\boxed{
\lim_{\Omega\to\infty}\frac{\pi}{\Omega}
\|A_{\Theta+c}\Pi_\Omega\|_2^2
=\mathbb E(K-\Theta-c)_+
=\mathbb E(-Y_S-c)_+,\qquad c\ge0.}
\tag{5}
$$
The exact Bohr-mean clipping boundary is $1/\pi$ times this limit. In integer-history coordinates its value before that $1/\pi$ factor is
$$
\sum_{\substack{n>P_Se^c\\n\ \text{$S$-smooth}}}
\frac{\varphi(\operatorname{rad}n)^2}{nP_S}
\log\frac{n}{P_Se^c}.
\tag{6}
$$
This includes generated integer states beyond the prime-admission cutoff.

For every finite $c$, the limit in (5) is strictly positive: any one admitted prime has arbitrarily deep positive-probability histories. Hence the squared Hilbert--Schmidt norm in (5) grows linearly with $\Omega$. In particular $A_{\Theta+c}$ itself is not Hilbert--Schmidt. The normalization cannot be dropped.

## 3. The exact advance-length port and its omitted histories

Partition the past into its natural delay-length blocks
$$
I_j=[-(j+1)\Theta,-j\Theta],\qquad j\ge0.
$$
Repeating the kernel argument with this finite input interval gives
$$
\boxed{
\lim_{\Omega\to\infty}\frac{\pi}{\Omega}
\|\mathbf1_{(\Theta+c,\infty)}
\mathcal C_S\mathbf1_{I_j}\Pi_\Omega\|_2^2
=\mathbb E\min\{\Theta,(-Y_S-c-j\Theta)_+\}.}
\tag{7}
$$
For each delay $K$, the diagonal output length is the intersection of
$(\Theta+c,\infty)$ with $K+I_j$, exactly the capped length on the right. Off-diagonal intersections are retained at finite $\Omega$ and disappear only in the stated limit.

Write $\mathcal L_S(c)=\mathbb E(-Y_S-c)_+$. The $j$-th port density is exactly
$$
\mathcal L_S(c+j\Theta)-\mathcal L_S(c+(j+1)\Theta).
\tag{8}
$$
All these nonnegative limiting densities sum to $\mathcal L_S(c)$. The first port therefore omits precisely $\mathcal L_S(c+\Theta)$. This is an identity of the limiting densities; cross-block interference at finite bandwidth is not set to zero.

For $S=\{2\}$ and $c=0$, $\Theta=\log2$ and the actual geometric law gives
$$
\mathcal L_{\{2\}}(0)=\frac{\log2}{2},\qquad
\mathbb E\min(\Theta,(-Y_{\{2\}})_+)=\frac{\log2}{4}.
$$
Thus one advance-length input interval captures only half of this finite-generator overflow. The remaining proper powers cannot be removed merely because the delay has been restored.

## 4. What the critical history entropy implies for the ports

Take all primes through $X$, write
$\Theta_X=\sum_{p\le X}\log p$, $L=\log X$, and retain the same exact $\mathcal L_X$.
The [complete geometric-history entropy theorem](complete-prime-history-entropy.md) proves, locally uniformly for $\kappa>0$,
$$
\log\mathcal L_X(\kappa X)
=-\kappa X+\frac X L h(\kappa)+o(X/L),
\quad
h(\kappa)=(\kappa+1)\log(\kappa+1)-\kappa\log\kappa.
\tag{9}
$$
The proof uses the actual finite geometric law, exact exponential tilting and PNT, not relative convergence of the Dickman limit.

For a fixed $\kappa>0$, let $R_X(\kappa)$ be the fraction of total overflow omitted by the first $\Theta_X$-length port at $c=\kappa X$. Equations (8)--(9) give
$$
\boxed{
\log R_X(\kappa)=
-\Theta_X+\frac X L
\left[h\!\left(\kappa+\frac{\Theta_X}{X}\right)-h(\kappa)\right]
+o(X/L).}
\tag{10}
$$
This uses uniformity of (9) on compact positive parameter intervals. The prime-number theorem gives $\Theta_X/X\to1$, so
$$
\log R_X(\kappa)=
-\Theta_X+\frac X L[h(\kappa+1)-h(\kappa)]+o(X/L).
$$
If desired, the classical unconditional PNT remainder permits replacing
$\Theta_X$ by $X$ with error $o(X/L)$; [DLMF 27.12.5](https://dlmf.nist.gov/27.12.E5), followed by partial summation, supplies that stronger error. In particular
$$
\boxed{R_X(\kappa)=e^{-X+o(X)},\qquad
\text{first-port density}=\mathcal L_X(\kappa X)[1-e^{-X+o(X)}].}
\tag{11}
$$
The omitted histories have been quantified, not discarded.

At $c=0$, the exact independent local variances give $\mathbb EY_S^2=2\sum_{p\le X}(\log p)^2/(p-1)\ll\log^2X$. Hence $\mathcal L_X(0)\ll\log X$. Conditioning on the $p=2$ channel and using convexity of $x\mapsto(-x)_+$ for the independent mean-zero remainder gives $\mathcal L_X(0)\ge\mathcal L_{\{2\}}(0)=\log2/2$. These direct bounds suffice for the logarithmic denominator below. Apply (9) to the numerator
$\mathcal L_X(\Theta_X)$, whose parameter tends to one. Since
$\log\mathcal L_X(0)=o(X/L)$,
$$
\log\frac{\mathcal L_X(\Theta_X)}{\mathcal L_X(0)}
=-\Theta_X+\frac{2\log2\,X}{L}+o(X/L).
\tag{12}
$$
Thus the large-generator first port captures almost all of the averaged overflow even though the single-generator example captures only half.

For each fixed $j\ge0$ and $\kappa>0$, the $j$-th port has logarithmic density
$$
-(\kappa X+j\Theta_X)
+\frac X L h\!\left(\kappa+j\frac{\Theta_X}{X}\right)
+o(X/L).
$$
Indeed the next-port tail divided by its uncapped predecessor is $e^{-X+o(X)}$, by the same argument. These are consequences for the precisely regularized physical port densities. They neither bound the unaveraged signed clipping boundary nor supply the bilinear two-history sign in the arithmetic $W$ criterion.

## 5. The unaveraged signed boundary retains complementary-input interference

The positive port has an exact coherent correction before any averaging.
For fixed $t$, write
$$
C=C_S(t),\qquad R_x(t)=\sum_{K>x}a_Ke^{-itK},\qquad
E_b(t)=\int_b^\infty|R_x(t)|^2dx,
\quad b=\Theta+c,\ c\ge0.
$$
The complete negative-frequency clipping boundary of $U_S$ is
$$
\pi\mathcal B_S(t,c)
=\Re\left[\overline C
\sum_Ka_K(K-b)_+e^{-itK}\right].
$$
In particular the dephasing by $\Theta$ has not changed the coherent product. Symmetrizing the sum and setting $w_K=(K-b)_+$ gives
$$
\boxed{
\pi\mathcal B_S(t,c)=E_b(t)
+\frac12\sum_{K,J}a_K\overline{a_J}
e^{-it(K-J)}|w_K-w_J|.}
\tag{13}
$$
Indeed $E_b$ has coefficient kernel $\min(w_K,w_J)$, while
$(w_K+w_J)/2-\min(w_K,w_J)=|w_K-w_J|/2$.
The double sum is real by exchanging its indices. Weighted absolute convergence justifies every rearrangement.

The correction has the physical expression
$$
\mathcal J_b(t):=\pi\mathcal B_S(t,c)-E_b(t)
=\Re\int_b^\infty
R_x(t)\overline{C-R_x(t)}\,dx.
\tag{14}
$$
The outputs of the two complementary incident half-waves are precisely
$$
\mathcal C_S(\mathbf1_{(-\infty,0]}e^{it\cdot})(x)
=e^{itx}R_x(t),\qquad
\mathcal C_S(\mathbf1_{(0,\infty)}e^{it\cdot})(x)
=e^{itx}[C-R_x(t)].
$$
Finite truncation justifies these generalized inputs. The pairing in (14) is absolutely integrable, because $C-R_x$ is bounded and
$\int_b^\infty|R_x|dx\le\sum_K|a_K|(K-b)_+<\infty$.
No square-integrability assertion for the unrestricted plane wave is made.

At the unshifted physical boundary $b=0$, the correction vanishes identically:
$$
\mathcal J_0(t)=
\frac12\sum_{K,J}a_K\overline{a_J}
e^{-it(K-J)}|K-J|
=\frac12|D_t|(|C_S(t)|^2)=0.
$$
This follows from the full unitarity autocorrelation and its weighted absolutely convergent Fourier series. It does not assume that the two infinite-energy incident half-waves are orthogonal after restriction to a port. Subtracting (14) from its value at zero proves
$$
\boxed{
\pi\mathcal B_S(t,c)=E_b(t)
-\Re\int_0^b
R_x(t)\overline{C_S(t)-R_x(t)}\,dx,\qquad b=\Theta+c.}
\tag{15}
$$
The missing term is therefore a coherent bilinear pairing on the bounded output interval $(0,\Theta+c)$. For each finite $x$, its complementary head $C-R_x$ contains exactly the finitely many $S$-smooth integers $n\le e^x$; the tail $R_x$ still retains all remaining histories.

At $b=0$, the same identity gives the causal group delay
$$
E_0(t)=-\partial_t\arg C_S(t)
=\sum_{p\in S}(\log p)
\frac{1-r_p^2}{1-2r_p\cos(t\log p)+r_p^2}.
\tag{16}
$$
At $b=\Theta+c$, the clipped coefficient in (13) is no longer a function of $K-J$ alone. The autocorrelation cancellation that gave $\mathcal J_0=0$ therefore does not remove $\mathcal J_b$.

The actual one-prime case exhibits both signs. For $S=\{2\}$,
$L=\log2$, $r=2^{-1/2}$, $b=L$, $\theta=tL$, and
$D_\theta=1-2r\cos\theta+r^2$, summing all proper powers gives
$$
E_L(t)=\frac{Lr^2(1-r^2)}{D_\theta},\quad
\pi\mathcal B_{\{2\}}(t,0)
=\frac{Lr(1-r^2)\cos\theta}{D_\theta},
$$
$$
\mathcal J_L(t)=
\frac{L(1-r^2)(r\cos\theta-r^2)}{D_\theta}.
$$
In particular $\mathcal J_L(0)=Lr(1+r)>0$ and
$\mathcal J_L(\pi/L)=-Lr(1-r)<0$. At the latter point the signed boundary is negative while its overflow energy remains positive.
The Bohr mean of $\mathcal J_b$ is zero, since only $K=J$ survives in (13) and its correction weight is zero. This is exactly why the positive overflow law recovers the mean but not the signed pointwise boundary.

## 6. The squared Hardy density is an exact two-port energy

There is a complementary positive identity for the entire squared defect. Here $D=-i\partial_t$,

$$
d_w^{(2)}(t)=\frac1{4\pi^2}\int_{\mathbb R}\frac{|w(t)-w(t+h)|^2}{h^2}\,dh,\qquad d_w^{(1)}(t)=\frac1{2\pi}\Re(\overline wDw)(t).
$$

The archimedean multiplier is $u_\infty(t)=\pi^{-it}\Gamma(1/4+it/2)/\Gamma(1/4-it/2)$ and $c_t=\Re\psi_0(1/4+it/2)-\log\pi$, where $\psi_0$ is the digamma function.
Define
$$
D_b(t)=\int_0^b|C_S(t)-R_x(t)|^2dx,\qquad b=\Theta+c.
$$
Then
$$
\boxed{
d^{(2)}_{e^{ict}U_S}(t)=\frac{E_b(t)+D_b(t)}{2\pi},
\qquad
d^{(1)}_{e^{ict}U_S}(t)=\frac{b-E_0(t)}{2\pi}.}
\tag{17}
$$
For the first identity, expand the exact squared divided-difference kernel using frequencies $\lambda_K=b-K$. Its integrated coefficient kernel is
$$
\frac1{4\pi}
\left[|\lambda_K|+|\lambda_J|-|\lambda_K-\lambda_J|\right].
$$
For real $u,v$,
$$
\frac{|u|+|v|-|u-v|}{2}
=\min(u_+,v_+)+\min((-u)_+,(-v)_+).
$$
The two terms are exactly the coefficient kernels of $D_b$ and $E_b$, respectively. The absolute first-moment coefficient bound justifies termwise integration. The second identity in (17) follows by differentiating
$e^{ict}U_S=e^{ibt}C_S$ and using (16).

On $(0,b)$ the two output amplitudes sum to $C_S(t)$, which has modulus one. Hence
$$
b=[E_0(t)-E_b(t)]+D_b(t)
+2\Re\int_0^b R_x(t)\overline{C_S(t)-R_x(t)}dx.
$$
Together with (17), this recovers (15) and
$\mathcal B_S=d^{(2)}_{e^{ict}U_S}-d^{(1)}_{e^{ict}U_S}$, with the normalizations fixed.
The difference $D_b-E_b$ is not substituted for the signed phase term.

Finally, the [uniform gamma-freezing theorem](uniform-full-product-arch-freezing.md) gives an actual moving-threshold consumer. Whenever $|t|\ge2$ and the exact gamma slope $c_t\ge0$, evaluate $b_t=\Theta+c_t$ in the formulas above:
$$
\boxed{
\begin{aligned}
d^{(2)}_{u_\infty U_S}(t)-d^{(2)}_{u_\infty}(t)
={}&d^{(1)}_{U_S}(t)+\frac{E_{b_t}(t)}\pi\\
&-\frac1\pi\Re\int_0^{b_t}
R_x(t)\overline{C_S(t)-R_x(t)}dx+\mathcal R_S(t),
\end{aligned}
\qquad
|\mathcal R_S(t)|<2/\sqrt{|t|}.}
\tag{18}
$$
The error is uniform over every finite prime set. This evaluates the already proved constant-threshold formula at the exact local gamma slope; it does not differentiate a multiplier with variable carrier parameter.

Equations (15), (17), and (18) preserve all admitted-prime powers and both complementary input contributions. They identify the coherent boundary term that must be matched in a signed two-history construction. Positivity of the separate port energies does not settle its sign or the fixed-observation RH norm estimate. These are written operator and arithmetic identities, not Lean theorems.

## 7. An exact direct-integral bridge to the arithmetic age cell

There is an actual source map to the age-cell construction, not just a resemblance between its formulas and the cascade. Use the exact advance and finite initial-age terms in the [age-resolved lift](age-resolved-prime-history-lift.md), equations (4)--(6).
Fix a cell length $L>0$, put $\omega_0=2\pi/L$, and distinguish line translations $T_h a(x)=a(x-h)$ from cell translations
$\mathsf T_hF(u)=F(u+h\bmod L)$.
For compactly supported $a$ on the line define
$$
(\mathscr Z_\tau a)(u)=
\sum_{j\in\mathbb Z}e^{i\tau(u+jL)}a(u+jL),
\qquad 0\le u<L,\quad 0\le\tau<\omega_0.
\tag{19}
$$
The sum is finite almost everywhere. It extends by density to a unitary map from $L^2(\mathbb R,dx)$ to the direct integral of
$L^2([0,L),du)$, with measure $d\tau/\omega_0$:
$$
\boxed{\int_0^{\omega_0}\|\mathscr Z_\tau a\|_{L^2(du)}^2
\frac{d\tau}{\omega_0}=\|a\|_2^2.}
\tag{20}
$$
For fixed $u$, this is simply Parseval in the Fourier series indexed by $j$. Surjectivity follows from its inverse coefficients
$$
a(u+jL)=\int_0^{\omega_0}
e^{-i\tau(u+jL)}F_\tau(u)\,\frac{d\tau}{\omega_0}.
$$
No pointwise convergence of an infinite arithmetic history is needed.

For a compact causal history $f$, put $a(x)=e^{x/2}f(x)$ and
$q=1/2+i\tau$. The actual age lift satisfies exactly
$$
F_q(u)=e^{qu}\sum_{j\ge0}e^{qjL}f(u+jL)
=\mathscr Z_\tau a(u).
\tag{21}
$$
With the unitary line Fourier transform and cell coefficients normalized by $1/L$,
$$
\boxed{(F_q)_k=\frac{\sqrt{2\pi}}L
\widehat a(\omega_k-\tau),\qquad \omega_k=2\pi k/L.}
\tag{22}
$$
This follows by joining the cell integrals into the line integral; the factors $e^{i\omega_kjL}$ are one. Equation (20) therefore retains the exact arithmetic source norm
$$
\int_0^{\omega_0}\|F_{1/2+i\tau}\|_2^2\,\frac{d\tau}{\omega_0}
=\int_0^\infty e^x|f(x)|^2dx.
\tag{23}
$$
For $f=\chi_T\beta$, with the actual $\beta(x)=e^{-x}\psi(e^x)-1$, this is the finite-history weighted source energy. No bounded limit of that energy as $T\to\infty$ is presumed.

The exact translation dictionary is
$$
\mathscr Z_\tau T_h=e^{i\tau h}\mathsf T_{-h}\mathscr Z_\tau.
$$
On the line define
$$
D_a=\prod_{p\in S}(I-r_pT_{\log p}),\qquad
A_a=\prod_{p\in S}(I-r_pT_{-\log p}),\qquad
U_a=A_aD_a^{-1}.
$$
Both inverses exist in operator norm; $A_a=D_a^*$, so $U_a$ is unitary. The direct-integral images are exactly the cell operators
$$
D(q)=\prod_{p\in S}(I-p^{q-1}\mathsf T_{-\log p}),\qquad
A(q)=\prod_{p\in S}(I-p^{-q}\mathsf T_{\log p}).
$$
Thus
$$
\boxed{\mathscr Z_\tau U_a=U(q)\mathscr Z_\tau,\qquad
U(q)=A(q)D(q)^{-1}.}
\tag{24}
$$
On cell mode $k$ this is the literal Euler symbol
$U_S(\omega_k-\tau)$. The delayed causal operator of (1) is
$\mathcal C_S=T_\Theta U_a$; its cell image is
$$
e^{i\tau\Theta}\mathsf T_{-\Theta}U(q).
\tag{25}
$$
All admitted-prime geometric powers enter the operator-norm inverses, so the correspondence does not stop at the first-prime polynomial.

The gauge also identifies the actual finite-history outputs. On the original history $f$, write
$$
D_\beta=\prod_{p\in S}(I-p^{-1}T_{\log p}),\qquad
A_\beta=\prod_{p\in S}(I-T_{-\log p}).
$$
Multiplication by $e^{x/2}$ conjugates these to $D_a,A_a$ on the histories in question. The causal inverse series and the compact-future advance series justify the same identities for the inverses. Therefore the history outputs after this gauge are precisely
$$
P_+=\mathbf1_+U_a a,\qquad
Q_+=\mathbf1_+U_a^{-1}a.
\tag{26}
$$
Their omitted negative-time outputs
$P_-=\mathbf1_-U_a a$ and $Q_-=\mathbf1_-U_a^{-1}a$
are separate ports.

Since $a$ is causal and $\mathcal C_S$ is causal, the forward port has the exact advance-strip form
$$
\boxed{P_-=T_{-\Theta}\mathbf1_{[0,\Theta)}\mathcal C_Sa.}
\tag{27}
$$
It depends only on $a|_{[0,\Theta)}$. The second port remains
$$
Q_-=\mathbf1_-\mathcal C_S^*T_\Theta a,
$$
and is not replaced by the first one. Both have genuine $L^2$ meanings for the compact source.

For the actual two-prime cell construction, let
$Z_f=D_\beta^{-1}f$, let $q_+$ denote its original inverse output, and retain its explicit port combination
$C_q[h]=J_{\log2}[h]+J_{\log3}[h]-J_{\log6}[h]$.
Here $J_h$ is the finite initial-age term (5) of the age lift, applied to the indicated history. Expand the two advance factors before applying (26); this gives
$$
\boxed{
C_q[Z_f]=-\mathscr Z_\tau P_-,
\qquad
C_q[q_+]=A(q)\mathscr Z_\tau Q_-.}
\tag{28}
$$
For the first identity,
$\mathscr Z_\tau P_+=U(q)F_q-\mathscr Z_\tau P_-$.
For the second, apply $A(q)$ to
$\mathscr Z_\tau Q_+=U(q)^{-1}F_q-\mathscr Z_\tau Q_-$.
These are exactly the two signs and the mixed advance port in the original age-cell equations. In particular the finite initial-age terms are mapped to actual discarded line outputs, rather than chosen independently.

This establishes a direct-integral and boundary dictionary for the compact actual arithmetic source. It does not turn the positive plane-wave overflow density into the complex bilinear age convolution: that convolution still pairs the correct reflected fibers and retains both terms in the complete signed boundary identity. Nor does the unitary dictionary provide a cutoff-uniform bound for the weighted source in (23), or permit an infinite-history critical continuation without its required analytic control.
