# The remaining affine gap after both exact action constraints

Let $U$ be either of the score-matched covariance upper forms already constructed, and let $\mathcal C$ be the true covariance. Put
$$
D=U-\mathcal C\ge0,\qquad
f=B\sigma_C,\quad y=\sigma_O,\quad q=\tau_O,\quad
r=f+\delta y-\tfrac14q,\quad m=\langle\sigma_C,\tau_C\rangle_\nu.
$$
Inner products and covariance forms are linear in the first argument. The actual columns are real, but the formulas below allow complex test combinations. The two exact action constraints are retained throughout.

## Exact affine gap and optimizer displacement

For a positive covariance form $T$, write
$$
\operatorname{Cost}_T(f,m)
=T(f,f)-\frac{|T(f,q)+m|^2}{T(q,q)}.
$$
The full true affine form minus the lower bound built from $U$ is
$\mathcal G=\operatorname{Cost}_U(f,m)-\operatorname{Cost}_{\mathcal C}(f,m)$.
Set
$$
u=U(q,q),\quad d=D(q,q),\quad b=D(f,q),\quad A=D(f,f),
\quad c=\mathcal C(q,q)=u-d>0,\quad
t=\frac{U(f,q)+m}{u}.
$$
The actual optimizer is $t_{\mathcal C}=(ut-b)/c$. Thus
$$
t_{\mathcal C}-t=\frac{dt-b}{c},
$$
and completing the actual affine quadratic at $t$ gives
$$
\boxed{\quad
\mathcal G
=A-2\operatorname{Re}(\overline t b)+|t|^2d
+\frac{|b-dt|^2}{u-d}
=D(f-tq,f-tq)+c|t_{\mathcal C}-t|^2.
\quad}
\tag{1}
$$
Both terms are nonnegative. The second term includes the entire optimizer error. In particular, bounding only the covariance error at the chosen optimizer is insufficient without controlling its denominator.

For $d>0$, an equivalent exact expression is
$$
\boxed{\quad
\mathcal G=
A-\frac{|b|^2}{d}
+\frac{ud}{u-d}\left|t-\frac bd\right|^2.
\quad}
\tag{2}
$$
For $d=0$, positivity of $D$ forces $b=0$, and $\mathcal G=A$.
Formula (2) separates the conditional covariance error from the difference between its preferred coefficient and the actual affine coefficient. It retains the signed scalar $m$.

Use score matching before estimating either term. Since $D(r,\cdot)=0$,
$$
b=-\delta D(y,q)+\tfrac14d,\qquad
A=\delta^2D(y,y)-\tfrac{\delta}{2}\operatorname{Re}D(y,q)+\tfrac1{16}d.
$$
Moreover $U(r,q)=\langle y,q\rangle_\nu$, and
$m+\langle y,q\rangle_\nu=-1/2$. Hence
$$
t=\tfrac14-t_{\rm score},\qquad
t_{\rm score}=\frac{1/2+\delta U(y,q)}u,
$$
$$
D(f-tq,f-tq)=
D(\delta y-t_{\rm score}q,\delta y-t_{\rm score}q).
\tag{3}
$$
The coherent norm $\mathcal E_y=U(r,r)$ does not appear as a small multiplier in (1) or (2). It cancels exactly in this passage to the remaining affine direction.

## Subtract both known columns before Cauchy--Schwarz

Define the physical sign-action source
$$
k_\varepsilon=\rho K\varepsilon,\qquad
\varepsilon=\operatorname{sgn},\qquad
E_s=\langle K\varepsilon,\varepsilon\rangle_\gamma.
$$
Both $U$ and $\mathcal C$ match the sources $k_\varepsilon,r$:
$$
U(k_\varepsilon,g)=\mathcal C(k_\varepsilon,g)
 =\langle\varepsilon,S_g\rangle_\gamma,\qquad
U(r,g)=\mathcal C(r,g)=\langle y,g\rangle_\nu.
$$
Their common real Gram matrix is
$$
G=\begin{pmatrix}E_s&k\\k&\mathcal E_y\end{pmatrix},
\qquad
k=\langle K\varphi,\varepsilon\rangle_\gamma
=H_f+\delta H_y-\tfrac14H,\qquad
\varphi=y/\psi.
\tag{4}
$$
Here $H_g=\langle S_g,\varepsilon\rangle_\gamma$ and $H=H_q>0$.
The matrix is strictly positive. Indeed it is the $K$-energy Gram matrix of $\varepsilon,\varphi$. These functions are independent: $\psi$ is bounded, whereas $|\sigma(u)|$ tends to infinity, so $\varphi=\sigma/\psi$ cannot be a constant multiple of the sign. Coercivity $K\ge aI>0$ then proves the assertion.

For a weighted source $x$, let
$$
v_x=\binom{H_x}{\langle x,y\rangle_\nu},\qquad
L(x,z)=v_z^*G^{-1}v_x,\qquad
U_\perp=U-L.
$$
The order of the two vectors makes $L$ linear in $x$. Schur complementation of the common two-column Gram matrix gives
$$
\boxed{\qquad
0\le D\le U_\perp,\qquad
U_\perp(x,x)=U(x,x)-v_x^*G^{-1}v_x.
\qquad}
\tag{5}
$$
This subtracts the known action data before any Cauchy--Schwarz estimate. Equivalently, with
$e=\mathcal E_y-k^2/E_s>0$,
$$
L(x,x)=\frac{|H_x|^2}{E_s}
+\frac{|\langle x,y\rangle_\nu-kH_x/E_s|^2}{e}.
\tag{6}
$$
The small value of $\mathcal E_y$ enforces this joint constraint, including the correlated numerator in (6). It does not bound the remaining $U_\perp(x,x)$ by itself.

In particular,
$$
c\ge c_L:=L(q,q)
=\frac{H^2}{E_s}
+\frac{|\langle q,y\rangle_\nu-kH/E_s|^2}{e}>0.
\tag{7}
$$
All quantities in this lower bound are actual known action pairings.

## Explicit remaining upper bounds

Apply Cauchy--Schwarz only to the residual error form $D$. For $x_t=f-tq$,
$$
|b-dt|^2=|D(x_t,q)|^2\le dD(x_t,x_t).
$$
Consequently (1), (5), and (7) imply
$$
\boxed{\quad
D(x_t,x_t)\le\mathcal G
\le\frac{u}{c}D(x_t,x_t)
\le\frac{u}{c_L}U_\perp(x_t,x_t)
\le\frac{uE_s}{H^2}U_\perp(x_t,x_t).
\quad}
\tag{8}
$$
Thus the concrete sufficient residual estimate for an upper gap $\epsilon$ is
$$
U_\perp(f-tq,f-tq)\le\epsilon\,c_L/u.
\tag{9}
$$
No independent estimates of $D(y,y)$ and $D(q,q)$ enter (8).

There is a stronger finite-expression upper bound if all entries of $U$ are available. Since $\mathcal C\ge L$ and affine cost is monotone in covariance-form order,
$$
\boxed{\quad
\mathcal G\le
\operatorname{Cost}_U(f,m)-\operatorname{Cost}_L(f,m)
=\operatorname{Cost}_U(f,m)-L(f,f)
+\frac{|m+L(f,q)|^2}{c_L}.
\quad}
\tag{10}
$$
Equivalently, putting $d_\perp=U_\perp(q,q)$ and
$b_\perp=U_\perp(f,q)$, the right side is
$$
U_\perp(x_t,x_t)+\frac{|b_\perp-d_\perp t|^2}{c_L}.
\tag{11}
$$
Formula (10) is the largest gap allowed by the covariance sandwich $L\le\mathcal C\le U$ with these two exact columns. It is attained by the lower covariance $L$ if degeneracy on the other directions is allowed. Strictly positive approximations give the same supremum. This describes the information in the comparison; it does not identify $L$ with the true covariance.

The exact source relation therefore reduces the task to an actual two-column orthogonal residual and its affine coefficient. The estimate $\mathcal E_y\to0$, even its very small bound at $R=2$, supplies no vanishing upper bound on (8) unless that residual is controlled. Equations (8)--(11) retain the signed core score constraint and specify the required estimate without discarding either matched action.

## An exact residual-energy identity at the actual constrained optimizer

Let $M$ be the positive operator whose inverse defines $U$, and let $k,m_M$ denote the forms of $K,M$. This covers the bounded component construction and the full-continuous-base form construction. Write
$$
 n[v]=k[v]-m_M[v]\ge0,\qquad v\in V_k.
$$
Only this difference on $V_k$ is needed; no additional closedness claim for the difference form is made. For the actual odd core score, the exact exterior variational problem is
$$
 F_{\rm true}=\mathcal B_C+
 \min_{\substack{v\in V_k\\\langle v,S_q\rangle=-m}}
       \{k[v]-2\operatorname{Re}\langle S_f,v\rangle\},
 \qquad \mathcal B_C=E_C[\sigma_C]-\alpha\|\sigma_C\|^2.
\tag{12}
$$
The physical exterior extension is $\psi v$. Thus its original score constraint is exactly $\langle v,S_q\rangle=-m$; its mean constraint vanishes by parity. The common form-domain theorem justifies this parametrization.

The true and comparison minimizers are
$$
 v_C=K^{-1}(S_f-t_C S_q)\in D(K),\qquad
 v_U=M^{-1}(S_f-t S_q)\in D(M),
\tag{13}
$$
with the full affine coefficients from (1). Both satisfy the same constraint. Since $V_k\subset V_{m_M}$, their difference belongs to $V_{m_M}$. Completing the $m_M$ energy at its constrained minimizer proves
$$
 \boxed{\quad
 \mathcal G=n[v_C]+m_M[v_C-v_U].
 \quad}
\tag{14}
$$
Indeed the linear cross term vanishes because $v_C-v_U$ has zero score pairing and $Mv_U=S_f-tS_q$. The two terms in (14) are finite and nonnegative. This is the energy version of the exact covariance-and-optimizer identity (1), with the actual constrained optimizer retained.

Both exact action matches imply
$$
 n(\varepsilon,v)=n(\varphi,v)=0\qquad(v\in V_k),
 \qquad\varphi=y/\psi.
\tag{15}
$$
In particular, subtracting the known score quotient from the actual optimizer does not change its residual energy. The small value $k[\varphi]=\mathcal E_y$ therefore supplies no factor multiplying $n[v_C]$. Its entire residual-form contribution is zero.

The [actual full-form theorem](theta-prime-profile-full-form-domain.md) proves $v_U\in V_k$ for the bounded component comparison followed by score matching. Under this membership, the comparison minimizer is an admissible trial in (12) and yields the useful upper bound
$$
 \boxed{\quad 0\le\mathcal G\le n[v_U].\quad}
\tag{16}
$$
That extra domain membership cannot be inferred from $v_U\in D(M)$ by form order. In particular the bounded component inverse involves the prime profile $w_p$; its $L^2(\gamma)$ estimate alone does not prove full-form membership. The linked theorem establishes that prerequisite using the full physical logarithmic form and theta tails. An approximation to $v_U$ in the full form domain would also need a controlled residual-energy cost before it could replace (16).

For the bounded two-component construction followed by score matching, the residual has a direct positive-form representation. Use the independently nonnegative forms $A_c,A_p$ after the subtractions in [prime component cross profile bound](theta-prime-component-cross-profile-bound.md). Their sign ranks produce $M_0=K_{\rm cp}$. For $v\in V_k$,
$$
 (k-m_{M_0})[v]
 =\inf_{c_c,c_p\in\mathbb R}
       \{A_c[v-c_c\varepsilon]+A_p[v-c_p\varepsilon]\}.
$$
The subsequent action match on $\varphi$ subtracts the corresponding scalar square. Hence
$$
 \boxed{\quad
 n[v]=\inf_{s,c_c,c_p\in\mathbb R}
 \{A_c[v-s\varphi-c_c\varepsilon]
       +A_p[v-s\varphi-c_p\varepsilon]\}.
 \quad}
\tag{17}
$$
All vectors in the displayed forms are admissible. If the score residual energy is zero, the infimum over $s$ has no effect; otherwise ordinary completion of its positive quadratic proves (17). Thus (14) retains the complete continuous and prime energy after projecting out the actually matched sign and score directions. It does not replace their remaining interaction by independent error estimates. The [conditional edge-energy formula](theta-affine-comparison-conditional-edge-energy.md) evaluates (17) at the now form-admissible comparison optimizer. Its finiteness is proved; a quantitatively small value remains unproved.

## Attribution and formal scope

The closed-form representation theorem, ground-state transform, Carleman bound, nonnegative-form Cauchy–Schwarz and affine variational identities used here are classical. The proofs retain the actual ground state and every continuous and prime-power edge. These are written mathematical results, with no Lean claim for the full-form comparison or the remaining arithmetic smallness.
