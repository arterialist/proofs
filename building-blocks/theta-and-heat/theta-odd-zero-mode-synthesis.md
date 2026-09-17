# Odd regular synthesis, the beta constraint, and the exact rank-one term

This is a written mathematical proof for the complete theta kernel and its actual weighted Hilbert space. It is not a Lean theorem or a positivity proof. The cited entire-function and functional-analysis tools are classical; no priority claim is made.

Use the actual theta Hilbert space, transform, and closed jump form:
$$
d\nu=M^{-1}\cosh(u/2)\Phi(u)du,\quad M=\tfrac12,
\qquad Uh(z)=\int\Phi(u)h(u)e^{izu}du,
$$
$$
G(z)=(z^2+\tfrac14)\Xi(z),\qquad \lambda=\tfrac12.
$$
The inner product is linear in its first argument. Set
$$
t(u)=\tanh(u/2),\quad \beta(h)=\langle h,t\rangle_H,
\quad \tau=\|t\|_H^2>0,\quad q_1=\Phi'/\Phi.
\tag{1}
$$
All orthogonality below is in the original Hilbert norm. Let
$$
S_o=\overline{\operatorname{span}\{e_j^o:j\ge1\}}^H,
\qquad e_j^o=q_{2j+1}-4^{-j}q_1.
\tag{2}
$$
These are the known odd equality eigenvectors at $\lambda$. Integration by parts gives
$$
\beta(q_{2j+1})=-2^{-(2j+1)},\qquad
\beta(q_1)=-\tfrac12,\qquad \beta(e_j^o)=0.
\tag{3}
$$
In particular $t\perp S_o$. Oddness makes the original mean zero, but it does not make $\beta$ zero.

## 1. The raw modes and their exact annihilator

Let $B_{\rm raw}$ be the closed span in $H_{\rm odd}$ of
$$
b_\zeta^o(u)=\frac{\sin(\zeta u)}{\cosh(u/2)},
\tag{4}
$$
for all xi zeros $\zeta$, together with their parameter derivatives of orders less than the relevant multiplicity. Every zero, including every off-real zero, is retained. For odd $h$,
$$
(Uh)(\zeta)=iM\langle h,b_{\bar\zeta}^o\rangle_H.
\tag{5}
$$
The differentiated versions impose exactly the corresponding zero multiplicities. Also
$$
(Uh)(i/2)=-M\beta(h),\qquad
(Uh)(-i/2)=M\beta(h).
\tag{6}
$$
The two conditions in (6) are pole-factor conditions; they cannot be omitted.

Define
$$
T_{\rm aug}=B_{\rm raw}+\operatorname{span}\{t\}.
\tag{7}
$$
This is a closed direct sum, although not in general an orthogonal sum. Indeed $Uq_1=-iz\Xi(z)$, so (5) and its derivatives give
$$
q_1\perp B_{\rm raw},\qquad
\langle t,q_1\rangle_H=-\tfrac12.
\tag{8}
$$
If $b_n+a_nt$ converges, then
$a_n=-2\langle b_n+a_nt,q_1\rangle$ converges, and consequently so does $b_n$ in the closed space $B_{\rm raw}$. This proves both closedness and uniqueness of the decomposition in (7).

Equations (5)–(6) yield the exact odd annihilator
$$
Z_o:=T_{\rm aug}^{\perp}
=\left\{k\in H_{\rm odd}:\beta(k)=0,
\quad\frac{Uk}{zG}\text{ is entire and even}\right\}.
\tag{9}
$$
Here the displayed beta condition is redundant once entire division is stated, but records its source. Oddness supplies the zero at the origin; beta supplies the zeros at $\pm i/2$; the raw modes supply all xi zeros with multiplicities.

The exact transformed equality span is
$$
US_o=\overline{zG\,\mathbb C[z^2]}^{\mathcal H}.
\tag{10}
$$
To see the triangular polynomial factors explicitly,
$$
Ue_j^o=-iz\Xi(z)\bigl[(-1)^jz^{2j}-4^{-j}\bigr],
$$
and the bracket is divisible by $z^2+1/4$. Thus $S_o\subset Z_o$.

## 2. Dual-weight synthesis in the odd space

For $0<\epsilon<1$, use the same auxiliary norms as in the even theorem:
$$
\theta(u)=\pi e^{2|u|},\qquad
H_{\pm\epsilon}=L^2(e^{\pm\epsilon\theta}d\nu).
$$
The original beta functional is continuous on $H_{-\epsilon}$, since $t$ is bounded and $\int e^{\epsilon\theta}d\nu<\infty$. The entire evaluation bounds and injectivity of $U$ on that weaker space are exactly those proved in [theta regular zero mode synthesis](theta-regular-zero-mode-synthesis.md).

For $k\in Z_o$, the quotient $E=(Uk)/(zG)$ is entire even. The actual quotient-growth proof applies unchanged: the extra factor $z$ changes logarithmic estimates by only $O(\log R)$. Thus $E$ has finite exponential type and diagram contained in the original closed lens $\overline K$.

The correct odd physical generator is a derivative:
$$
\Psi=-\Phi''+\Phi/4,\qquad
\Omega=\Psi',\qquad \widehat\Omega=-izG.
$$
On the enlarged weak-norm lens $K_{-\epsilon}$ define
$$
T_o(w)(u)=\frac{\Omega(u+iw)+\Omega(u-iw)}{2\Phi(u)}.
\tag{11}
$$
This vector is odd in $u$, even in $w$, and Hilbert-holomorphic in the weaker norm. Differentiating the full theta kernel changes only polynomial-exponential prefactors, so its exact integrability margin remains
$$
2e^{-2|\operatorname{Im}w|}\cos(2\operatorname{Re}w)
-(1-\epsilon)>0.
\tag{12}
$$
The original closed lens has margin at least $\epsilon$. Real translation followed by holomorphic uniqueness gives
$$
UT_o(w)(z)=-izG(z)\cosh(wz).
\tag{13}
$$
In particular $\beta(T_o(w))=0$, by evaluation at $i/2$. Its Taylor coefficients are finite odd equality combinations, since
$$
\frac{\Omega^{(2n)}}\Phi=-e_{n+1}^o+\tfrac14e_n^o,
\qquad e_0^o=0.
\tag{14}
$$
The same Hilbert-valued analytic continuation and Borel-contour construction therefore applies, now using $iT_o$ so that its transform is $zG\cosh(wz)$. It proves that every $k\in Z_o$ is a limit of finite original odd equality combinations in $H_{-\epsilon}$.

If $h\in H_{\rm odd}\cap S_o^\perp\cap H_\epsilon$, pair those approximants with $h$ using
$$
|\langle h,k-k_n\rangle_H|
\le\|h\|_\epsilon\|k-k_n\|_{-\epsilon}.
$$
Thus $h\perp Z_o$. The result is the whole-odd theorem
$$
\boxed{H_{\rm odd}\cap S_o^\perp\cap H_\epsilon
\ \subseteq\ B_{\rm raw}+\operatorname{span}\{t\}.}
\tag{15}
$$
It does not assume $\beta(h)=0$.

## 3. Equivalent constrained formulation

The natural beta-zero ambient space is
$$
K_o=H_{\rm odd}\cap\ker\beta,\qquad
P_o h=h-\frac{\beta(h)}\tau t.
$$
Let $B_o$ be the closed span of the projected representers $P_ob_\zeta^o$ and their multiplicity derivatives. Then
$$
B_o^\perp\text{ in }K_o=Z_o,
\qquad K_o\cap S_o^\perp\cap H_\epsilon\subset B_o.
\tag{16}
$$
For a regular unconstrained odd vector, $P_oh$ remains regular because $t$ is bounded and belongs to every $H_\epsilon$, $\epsilon<1$. It remains orthogonal to $S_o$ by (3). Consequently (16) also gives
$h\in B_o\oplus\operatorname{span}\{t\}$, where this last sum is orthogonal.

There is no mismatch between the two descriptions. In fact $P_oB_{\rm raw}$ is closed and equals $B_o$. The explicit inverse on that image is
$$
r\longmapsto r+2\langle r,q_1\rangle_Ht.
\tag{17}
$$
This follows from (8), and also proves closedness of the image. In particular raw and projected modes must not be identified without the correction in (17).

## 4. The actual eigenvector identity fixes the rank-one component

Use the exact polarized form and the score radical identity proved in the [ground-state chapter](theta-weil-jump-form.md):
$$
Q(\Phi f,\Phi g)=\mathcal E(f,g)
-\lambda\bigl(\langle f,g\rangle+
\beta(f)\overline{\beta(g)}\bigr),
\qquad Q(\Phi q_1,\Phi g)=0.
\tag{18}
$$
Thus, in the weak operator sense,
$$
Aq_1=\lambda q_1-\frac\lambda2t.
\tag{19}
$$
The right side is in $H$; the closed-form representation therefore also puts $q_1$ in the operator domain. If $Ah=\kappa h$, then
$$
(\kappa-\lambda)\langle h,q_1\rangle
=-\frac\lambda2\beta(h).
\tag{20}
$$
For a regular odd eigenvector with $0<\kappa<\lambda$, orthogonality to the equality eigenspace permits (15). Write its unique raw-mode decomposition as
$$
h=b+a t,\qquad b\in B_{\rm raw}.
$$
Equation (8) gives $a=-2\langle h,q_1\rangle$, and (20) gives
$$
(\kappa-\lambda)a=\lambda\beta(h),\qquad
\beta(h)=\beta(b)+a\tau.
$$
Consequently the precise eigenvector graph is
$$
\boxed{\quad
h=b+\frac{\lambda\beta(b)}{\kappa-\lambda(1+\tau)}\,t,
\qquad b\in B_{\rm raw},\quad 0<\kappa<\lambda.
\quad}
\tag{21}
$$
The denominator is strictly negative, so no exceptional subthreshold value was divided out. Equivalently,
$$
\beta(h)=\frac{\lambda-\kappa}{\lambda-\kappa+\lambda\tau}\,
\beta(b).
\tag{22}
$$
In particular a nonzero subthreshold eigenvector cannot be a pure multiple of $t$. But (20)–(22) do not force beta to vanish unless its raw-mode input vanishes.

For comparison, if $h=r+\beta(h)t/\tau$ is its orthogonal projected-mode decomposition, let $q_1^0=q_1+t/(2\tau)\in K_o$. Then the equivalent relation is
$$
h=r+\frac{2(\lambda-\kappa)}{\lambda\tau+\lambda-\kappa}
\langle r,q_1^0\rangle_Ht,
\qquad r\in B_o.
\tag{23}
$$

The established odd conclusion is therefore regular synthesis into all raw xi modes plus one explicitly controlled rank-one term. It is not synthesis into raw zero modes alone, and the beta contribution has not been discarded. These are Hilbert-space statements. The [stronger-weight](theta-stronger-weight-synthesis.md) and [smoothing](theta-zero-mode-form-smoothing.md) chapters prove the later form-norm refinement with the same augmented odd span. Positivity of the remaining zero pairing and exclusion of subthreshold eigenvalues are not conclusions of these synthesis theorems.
