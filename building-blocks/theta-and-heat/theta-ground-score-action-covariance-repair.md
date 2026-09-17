# Matching the actual score action in the covariance comparison

The actual score equation imposes a relation among the core-crossing source, the exterior score, and the odd pole column. A further positive rank can make the covariance upper bound satisfy this relation exactly. The resulting covariance of this particular source combination tends to zero as the core grows, and is less than $2\cdot10^{-37}$ at $R=2$ using the existing elementary bounds. This statement controls a coherent combination of sources; it does not bound their separate covariances or settle the full affine sign.

Every operator is the actual full theta operator unless an explicit positive lower comparison is named. All prime powers, the continuous conductance, and the original score constraint remain.

## The score quotient is a legitimate full operator test

Fix $R>0$, and write
$$
 D\psi=\alpha\psi,\quad \lambda=\tfrac12,\quad
 \delta=\lambda-\alpha,\quad
 x=\sigma_C,\quad y=\sigma_O,\quad q=\tau_O,
 \quad f=Bx.
$$
The ground state is normalized, even, positive almost everywhere, and bounded. Use the actual clock measure
$d\gamma=\rho\psi\,d\nu$, $a=\gamma(O)$,
and weighted sources $S_g=g/\rho$. The proved hard split and full score equation give
$$
 y\in D(D),\qquad (D-\alpha)y=f+\delta y-\frac\lambda2q.
\tag{1}
$$
Define $\varphi=y/\psi$. The full proof in [cross profile weak score tests](theta-cross-profile-weak-score-tests.md) places $\varphi$ in the common ground potential form domain, hence in $L^2(\gamma)$. It uses the exact form-domain bridge and $y\in D(D)$, without a pointwise lower bound for $\psi$. Parity gives $\gamma\varphi=0$.

All sources in (1) are weighted-admissible. Testing the ground form against a common-domain potential $F$ gives
$$
 \mathsf E_\psi(\varphi,F)
 =\langle(D-\alpha)y,\psi F\rangle_\nu
 =\left\langle S_f+\delta S_y-\frac\lambda2S_q,F\right\rangle_\gamma.
$$
Therefore, by the operator representation theorem,
$$
 \boxed{\quad
 \varphi\in D(K),\qquad
 K\varphi=S_f+\delta S_y-\frac\lambda2S_q.
 \quad}
\tag{2}
$$

## A positive rank that preserves both exact operator actions

Let $M=K_{\rm cp}$ be the bounded positive two-component comparison in [prime component cross profile bound](theta-prime-component-cross-profile-bound.md). It satisfies
$$
 K\ge M\ge aI,\qquad M\varepsilon=K\varepsilon,
 \qquad \varepsilon=\operatorname{sgn}.
\tag{3}
$$
All comparisons are in closed-form order. The nonnegative operator associated to the difference form is
$A=K-M$, with $D(A)=D(K)$, since $M$ is bounded. Put
$$
 v=A\varphi\in L^2(\gamma),\qquad
 d_y=\langle A\varphi,\varphi\rangle_\gamma\ge0.
\tag{4}
$$
If $d_y=0$, nonnegative-form Cauchy--Schwarz shows $v=0$. In that case set $\widehat M=M$. If $d_y>0$, the same inequality proves
$$
 \boxed{\quad
 K\ge\widehat M:=M+\frac{v\otimes v}{d_y}\ge M,
 \qquad \widehat M\varphi=K\varphi,
 \qquad \widehat M\varepsilon=K\varepsilon.
 \quad}
\tag{5}
$$
The second action follows from $\langle\varphi,v\rangle=d_y$. For the sign action, $A\varepsilon=0$ by (3), so
$\langle v,\varepsilon\rangle=\langle\varphi,A\varepsilon\rangle=0$.
All added vectors are odd. Thus constants and centered sources remain separated.

Define the joint covariance upper form
$$
 \widehat U(g,h)=
 \langle\widehat M^{-1}S_g,S_h\rangle_\gamma.
$$
It is finite and strictly positive on nonzero sources, and
$$
 \mathcal C\le\widehat U\le U_{\rm cp}
\tag{6}
$$
as positive forms. When $d_y>0$, its explicit rank formula is
$$
 \widehat U(g,h)=U_{\rm cp}(g,h)
 -\frac{j_y(g)\overline{j_y(h)}}{D_y},
$$
$$
 j_y(g)=\langle M^{-1}S_g,v\rangle_\gamma,
 \qquad D_y=d_y+\langle M^{-1}v,v\rangle_\gamma>0.
\tag{7}
$$
Thus (5) is a bounded rank update with an exact inverse, not a continuation of the singular original ground resolvent.

## An exact dependence between both affine columns and the crossing source

Let
$$
 r=f+\delta y-\frac\lambda2q,
 \qquad \mathcal E_y=\langle(D-\alpha)y,y\rangle_\nu.
\tag{8}
$$
Equation (2) says $S_r=K\varphi$. Since $\widehat M$ matches that action, every centered weighted source $g$ satisfies
$$
 \boxed{\quad
 \widehat U(r,g)=\mathcal C(r,g)
 =\langle\varphi,S_g\rangle_\gamma
 =\langle y,g\rangle_\nu,
 \qquad \widehat U(r,r)=\mathcal E_y.
 \quad}
\tag{9}
$$
In particular, with $D_U=\widehat U-\mathcal C\ge0$,
$$
 D_U(r,g)=0
$$
for every such source. Expanding this identity gives the exact coupled error relation
$$
 \boxed{\quad
 \delta^2D_U(y,y)-\delta\lambda\operatorname{Re}D_U(y,q)
       +\frac{\lambda^2}{4}D_U(q,q)=D_U(f,f).
 \quad}
\tag{10}
$$
More generally, for any scalar $t$,
$$
 D_U(\delta y-tq,\delta y-tq)
 =D_U\left(f-(\lambda/2-t)q,
           f-(\lambda/2-t)q\right).
\tag{11}
$$
The small spectral factor $\delta$ has not been used to discard a large Green term. Equations (9)--(11) force the scaled score errors to remain coupled to the actual crossing source in this comparison.

## A quantitative growing-core bound on the coherent combination

The exact energy in (8) is, by (1),
$$
 \mathcal E_y=
 \delta\|y\|_\nu^2+
 \langle Bx,y\rangle_\nu-
 \frac\lambda2\langle q,y\rangle_\nu\ge0.
\tag{12}
$$
Let $b_R$ be the proved full hard-crossing operator-norm upper bound, and $\delta_R$ the proved exterior threshold-error bound. Then $\delta\le\delta_R$, and both mixed terms in (12) give
$$
 \boxed{\quad
 0\le\mathcal E_y\le
 \delta_R\|y\|_\nu^2+
 b_R\|x\|_\nu\|y\|_\nu+
 \frac\lambda2\|q\|_\nu\|y\|_\nu
 =:\epsilon_R\longrightarrow0
 \quad(R\longrightarrow\infty).
 \quad}
\tag{13}
$$
Here $\|x\|\le\|\sigma\|<\infty$, the two exterior source norms tend to zero by theta decay, and the previously proved $b_R,\delta_R$ tend to zero. This conclusion is uniform in the actual normalized ground-state choice because no $\psi$-dependent upper constant occurs on the right.

At $R=2$, [two halfline failure at radius two](theta-two-halfline-failure-at-radius-two.md) supplies
$$
 b_2,\delta_2<10^{-20},\qquad
 \|\sigma\|<10^3,\quad\|y\|<10^{-20},\quad\|q\|<10^{-23}.
$$
The last bound also follows directly from $\|q\|^2\le\nu(O_2)<10^{-47}$. Therefore
$$
 \boxed{\quad
 \widehat U\left(f+\delta y-\tfrac14q,
                 f+\delta y-\tfrac14q\right)
 =\mathcal E_y
 <10^{-60}+10^{-37}+\tfrac14\,10^{-43}
 <2\cdot10^{-37}.
 \quad}
\tag{14}
$$
Neither $\widehat U(y,y)$ nor $\widehat U(q,q)$ is asserted small. Their joint combination in (14) is small by the actual score equation and the matched operator action.

## The full affine consumer and its exact compatibility

As in the existing true-score identity, the joint bound gives
$$
 F_\alpha[x]\ge
 \delta\|\sigma\|^2-\frac18
 -\delta^2\widehat U(y,y)
 +\frac{|1/2+\delta\widehat U(y,q)|^2}{\widehat U(q,q)}.
\tag{15}
$$
No denominator is dropped. For $d_y>0$, let
$$
 t_{\rm cp}=
 \frac{\delta U_{\rm cp}(y,q)+1/2}{U_{\rm cp}(q,q)}.
$$
The exact extra gain of (15) over the preceding two-component affine lower bound is
$$
 \boxed{\quad
 \frac{U_{\rm cp}(q,q)}{D_y\widehat U(q,q)}
       |j_y(\delta y-t_{\rm cp}q)|^2\ge0.
 \quad}
\tag{16}
$$
This includes the change of affine optimizer. In the case $d_y=0$, the two comparisons coincide and the gain is zero.

There is also an exact reformulation using the actual core-crossing source. Work with real data and set
$m_C=\langle x,\tau_C\rangle$, so
$m_C+\langle y,q\rangle=-1/2$. For a positive covariance form $U$, write
$$
 \operatorname{Cost}_U(g,m)
 =\min_t\{U(g-tq,g-tq)-2tm\}.
$$
Using (9), then the change of variable $s=\lambda/2-t$, proves
$$
 \operatorname{Cost}_{\widehat U}(\delta y,1/2)
 =\mathcal E_y-2\langle y,f\rangle-\frac\lambda2
      +\operatorname{Cost}_{\widehat U}(f,m_C).
\tag{17}
$$
Indeed $\delta y-tq=r-[f-sq]$, and every pairing with $r$ is the known original pairing in (9). Combining (17) with the exact full score energy yields
$$
 \boxed{\quad
 \delta\|\sigma\|^2-\frac\lambda4
      -\operatorname{Cost}_{\widehat U}(\delta y,1/2)
 =E_C[x]-\alpha\|x\|^2
      -\operatorname{Cost}_{\widehat U}(Bx,m_C).
 \quad}
\tag{18}
$$
Thus this strengthened covariance comparison preserves both the score representation and the core-crossing representation of the full constrained problem exactly. It does not impose a homogeneous score constraint in place of $m_C$.

The growing-core estimate (13) and its explicit value (14) provide an actual correlated source bound that earlier independent estimates could lose. They do not bound the remaining conditional variance in (15), prove that the gain (16) pays the signed deficit, or establish the sharp theta gap. The Riemann hypothesis remains unproved.

## Attribution and formal scope

The closed-form representation theorem, ground-state transform, Carleman bound, nonnegative-form Cauchy–Schwarz and affine variational identities used here are classical. The proofs retain the actual ground state and every continuous and prime-power edge. These are written mathematical results, with no Lean claim for the full-form comparison or the remaining arithmetic smallness.
