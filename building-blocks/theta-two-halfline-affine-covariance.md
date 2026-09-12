# An explicit two-halfline affine covariance comparison

This is a written proof for the actual theta form, with no Lean claim. It uses the [complete ground covariance clock](theta-complete-ground-covariance-clock.md), its [weighted source domain](theta-groundstate-bounded-weighted-crossing.md), and the original [theta Weil form and score identities](theta-weil-jump-form.md). The method uses classical closed-form comparison, scalar optimization and the indicated exact theta/arithmetic identities; no priority claim is made.

This comparison consumes the exact complete ground-state clock in [theta-complete-ground-covariance-clock.md](theta-complete-ground-covariance-clock.md). It retains the actual affine odd constraint. The continuous remainder alone contracts every direction except the difference between the two halfline means; the odd column partially controls that remaining direction, with an explicit residual.

Fix $R>0$, $O=(-\infty,-R)\cup(R,\infty)$, and use
$$
\mu=\psi^2\nu,\quad\gamma=\rho\psi\nu,\quad
 a=\gamma(O),\quad\rho=e^{-|u|/2}/[2\cosh(u/2)].
$$
The normalized positive ground state $\psi$ is even, so $\gamma$ is even and each halfline has mass $A=a/2$. For centered weighted sources set
$$
S_f=f/\rho,\quad \langle f,\psi\rangle_\nu=\gamma S_f=0,
\quad Q(f,g)=a^{-1}\langle S_f,S_g\rangle_\gamma,
$$
$$
s(u)=\operatorname{sgn}(u),\qquad
\ell(f)=a^{-1}\langle S_f,s\rangle_\gamma
       =a^{-1}\langle f,\psi s\rangle_\nu.
\tag{1}
$$
Inner products are linear in the first variable. Actual centered crossing sources from every core $L^2$ input, and the column $q=\tau_O$, satisfy the weighted condition by the bounded weighted crossing theorem.

## 1. Exact continuous minorant and resolvent factors

The continuous density of $J_{\rm rem}=J_\psi-\gamma\otimes\gamma$, relative to $\gamma\otimes\gamma$, is
$$
e^{(|u|+|v|)/2}\frac{e^{-|u-v|/2}}{1-e^{-2|u-v|}}-1.
$$
For endpoints on the same halfline, this is
$$
\frac{e^{\min(|u|,|v|)}}{1-e^{-2|u-v|}}-1
 \ge e^R-1=:h>0.
\tag{2}
$$
Thus the actual complete residual form dominates
$$
E_h(F)=\frac h2\sum_{\pm}\int_{O_\pm^2}|\Delta F|^2
                    d\gamma(u)d\gamma(v)
 =hA\sum_{\pm}\|F-\overline F_{\gamma,\pm}\|_{L^2(\gamma|_{O_\pm})}^2.
\tag{3}
$$
The generator is the bounded nonnegative operator
$A_h=hA(I-P_{\{1,s\}})$. It is zero on $1,s$ and has eigenvalue $hA$ on the subspace with mean zero on each halfline. No prime atom or cross-halfline continuous edge has been assigned a negative weight: these are nonnegative parts omitted only in this lower form.

On centered sources, the exact covariance and resolvent order give the quadratic-form inequality
$$
\mathcal C\le U_h,
\qquad
\boxed{\quad
U_h(f,g)=\kappa Q(f,g)+(1-\kappa)\ell(f)\overline{\ell(g)},
\quad \kappa=\frac a{a+hA}=\frac2{e^R+1}.
\quad}
\tag{4}
$$
Indeed the sign projection of $S_f$ is $\ell(f)s$. The inverse of $a+A_h$ equals $1/a$ on that projection and $1/(a+hA)$ on its orthogonal complement, giving (4). In unnormalized source notation the second term is
$(1-\kappa)\langle f,\psi s\rangle\overline{\langle g,\psi s\rangle}/a^2$.
The order means $\mathcal C(f,f)\le U_h(f,f)$ for every source and its polarized operator order; individual complex mixed entries are not ordered.

For an even source, $\ell(f)=0$, so
$$
\boxed{\mathcal C(f,f)\le\kappa Q(f,f).}
\tag{5}
$$
The uncontracted sign channel is odd. The complete residual process itself also has cross-halfline edges; (4) does not assert that its actual sign mode is invariant.

## 2. The actual odd column and its moment ratio

Let $q=\tau_O$, and define
$$
d_q=Q(q,q)>0,\qquad b_q=\ell(q)>0,\qquad
\vartheta=1-\kappa,\qquad D_q=\kappa d_q+\vartheta b_q^2.
\tag{6}
$$
All are finite. Their literal arithmetic/theta-coordinate normalization is especially simple. Under $\pi=\gamma/a$, put $r(u)=e^{|u|}-1$. The identity
$$
q(u)/\rho(u)=s(u)(e^{|u|}-1)
$$
gives
$$
b_q=\mathbb E_\pi r,\qquad d_q=\mathbb E_\pi r^2,
\qquad b_q>e^R-1,
\qquad 0<b_q^2<d_q.
\tag{7}
$$
The strict final inequality follows because $r$ is not constant under the measure $\gamma$, which is equivalent to Lebesgue measure on the exterior. Thus the actual odd column has a nonzero sign component but is not a pure sign mode.

## 3. Exact full affine optimization

For a centered source $f$ and the actual complex score value $m$, write
$$
z=Q(f,q),\qquad l=\ell(f).
$$
The affine covariance cost has the rigorous upper bound
$$
\min_c\{\mathcal C(f-cq,f-cq)-2\operatorname{Re}(c\overline m)\}
\le\operatorname{Cost}_{U_h}(f,m),
$$
where the exact optimized expression and coefficient are
$$
\boxed{\quad
\operatorname{Cost}_{U_h}(f,m)
=\kappa Q(f,f)+\vartheta|l|^2
 -\frac{|m+\kappa z+\vartheta b_q l|^2}{D_q},
\qquad
c_h=\frac{m+\kappa z+\vartheta b_q l}{D_q}.
\quad}
\tag{8}
$$
In particular this retains $m$; it cannot be replaced by the homogeneous regression coefficient unless $m=0$.

There is an exact reduction displaying what remains of the sign channel. Let
$$
f_\perp=f-(z/d_q)q,\qquad
Q_\perp=Q(f,f)-|z|^2/d_q,\qquad
l_\perp=l-b_qz/d_q.
$$
Writing $c=z/d_q+t$ and completing the scalar square gives
$$
\boxed{\begin{split}
\operatorname{Cost}_{U_h}(f,m)
={}&\kappa Q_\perp
 -\frac{2\operatorname{Re}(z\overline m)}{d_q}
 -\frac{|m|^2}{\kappa d_q}\\
&+\frac{\kappa d_q\vartheta}{D_q}
 \left|l_\perp-\frac{b_qm}{\kappa d_q}\right|^2.
\end{split}}
\tag{9}
$$
The residual square generally does not vanish. One can deliberately cancel the sign component by choosing $c=l/b_q$, but this leaves the exact cost
$\kappa Q(f-(l/b_q)q)-2\operatorname{Re}((l/b_q)\overline m)$, and that choice need not minimize the affine expression.

## 4. A strict fractional conditional bound when the affine score is zero

For $m=0$, (9) becomes
$$
\operatorname{Cost}_{U_h}(f,0)
=\kappa Q_\perp+\frac{\kappa d_q\vartheta}{D_q}|l_\perp|^2.
\tag{10}
$$
In the $Q$-Hilbert space, the sign functional is represented by $e=\rho s$, which is centered and has $Q(e,e)=1$, while $Q(q,e)=b_q$. Since $Q(f_\perp,q)=0$, Cauchy--Schwarz after projecting $e$ off $q$ gives
$$
|l_\perp|^2\le Q_\perp(1-b_q^2/d_q).
$$
Substitution into (10) proves the explicit conditional comparison
$$
\boxed{\quad
\mathcal C(f,f)-\frac{|\mathcal C(f,q)|^2}{\mathcal C(q,q)}
\le\operatorname{Cost}_{U_h}(f,0)
\le\kappa_{\rm cond}
 \left[Q(f,f)-\frac{|Q(f,q)|^2}{Q(q,q)}\right],
\quad}
\tag{11}
$$
$$
\boxed{\quad
\kappa_{\rm cond}=
\frac{\kappa d_q}{\kappa d_q+(1-\kappa)b_q^2}
=\left[1+\frac{e^R-1}{2}
             \frac{(\mathbb E_\pi r)^2}{\mathbb E_\pi r^2}\right]^{-1},
\qquad \kappa<\kappa_{\rm cond}<1.
\quad}
\tag{12}
$$
This fraction holds for every centered weighted source, not just a compact set of core inputs. Its ground-state moment ratio is specified exactly, not replaced by an unproved uniform lower bound. It is a conditional comparison, not a centered spectral gap for the prime-only generator.

## 5. Exact gain relative to the old affine bound and the core readout

Let the old rank-one affine optimizer be $c_Q=(z+m)/d_q$. Completing the $U_h$-affine square at this coefficient yields
$$
\boxed{\begin{split}
&\left[Q(f,f)-\frac{|z+m|^2}{d_q}\right]
 -\operatorname{Cost}_{U_h}(f,m)\\
&\qquad=\vartheta\left[
 Q(f-c_Qq,f-c_Qq)-|\ell(f-c_Qq)|^2\right]
 +D_q|c_Q-c_h|^2\ge0.
\end{split}}
\tag{13}
$$
The first bracket is nonnegative by the sign-functional Cauchy inequality. This identity preserves the actual affine optimizer rather than discarding its score-dependent residual.

For the actual core source, retain
$$
f=Bx-\frac{\langle Bx,\psi\rangle}{\mu_1}1_O,
\quad\mu_1=\langle1_O,\psi\rangle,
\quad m=\langle x,\tau_C\rangle,
$$
and the full baseline
$$
\mathcal B(x)=E_C[x]-\alpha\|x\|^2
 +\frac{2\operatorname{Re}(\langle Bx,\psi\rangle
                    \overline{\langle x,1_C\rangle})}{\mu_1}.
$$
Equations (8) and the exact complete covariance formula imply
$$
\boxed{F_\alpha[x]\ge\mathcal B(x)-\operatorname{Cost}_{U_h}(f,m).}
\tag{14}
$$
For an even core input, $f$ is even and $m=z=l=0$, so this reduces to $F_\alpha[x]\ge\mathcal B(x)-\kappa Q(f,f)$. For an odd core input, both core mean and ground overlap vanish, but the actual score $m$ need not vanish; (8) or (9) must then be used with that score. On the additional score-zero class, (11) applies.

The full residual process and all prime powers enter the exact covariance preceding this lower comparison. The two-halfline minorant gives an explicit contraction and an exact one-channel affine residual. It does not prove that (14) is nonnegative, does not omit the original pole columns, and does not establish the theta sharp gap or RH.

