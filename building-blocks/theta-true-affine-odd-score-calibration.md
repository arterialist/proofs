# The true affine form on the actual odd score

This is a written proof for the actual theta form, with no Lean claim. It uses the [complete ground covariance clock](theta-complete-ground-covariance-clock.md), its [weighted source domain](theta-groundstate-bounded-weighted-crossing.md), and the original [theta Weil form and score identities](theta-weil-jump-form.md). The method uses classical closed-form comparison, scalar optimization and the indicated exact theta/arithmetic identities; no priority claim is made.

At radius $R=2$, the [two-halfline failure proof](theta-two-halfline-failure-at-radius-two.md) proves that the two-halfline covariance lower comparison is less than $-1/10$ on the actual core score. That result concerns the lower comparison, not the true affine form. The following exact identity identifies the complete exterior covariance scalars that determine the true form on this same test.

All prime powers and the full continuous exterior dynamics remain in the reduced Green operator below.

## Actual score identities and domains

Write
$$
 \lambda=\tfrac12,\qquad
 \sigma=\Phi'/\Phi,\qquad \tau(u)=\tanh(u/2).
$$
The public theta identities and their operator-domain extension give
$$
 L\sigma=\lambda\sigma-\frac{\lambda}{2}\tau,\qquad
 \langle\sigma,1\rangle_\nu=0,\qquad
 \langle\sigma,\tau\rangle_\nu=-\frac12,
$$
$$
 E(\sigma)-\lambda\|\sigma\|_\nu^2=\frac{\lambda}{4}.
 \tag{1}
$$
Both $\sigma$ and $\tau$ are in $D(L)$. The actual hard-projection theorem therefore permits
$$
 x=\sigma_C,\qquad y=\sigma_O,\qquad q=\tau_O
$$
in their respective killed operator domains. For every finite $R$, the exterior ground state is even, while $y,q,Bx$ are odd.

Let
$$
 D=L_O,\qquad D\psi=\alpha\psi,\qquad
 \delta=\lambda-\alpha>0,\qquad
 G=(D-\alpha)^{-1}\text{ on the odd subspace}.
 \tag{2}
$$
This inverse exists: the simple ground eigenspace is even, and the rest of the spectrum is separated from $\alpha$ by a positive distance. Equivalently $G$ is the full reduced resolvent restricted to odd inputs. It is a positive self-adjoint bounded operator, with range in $D(D)$. Positivity preservation of an odd-sector spatial kernel is not assumed.

The exact constrained affine form $F_\alpha[x]$ minimizes
$E(h)-\alpha\|h\|^2$ over extensions $h_C=x$ satisfying
$\langle h,1\rangle=\langle h,\tau\rangle=0$.
It suffices to minimize over odd extensions. Indeed the odd part keeps the core value and score constraint, while the even part has zero core, zero mean, and nonnegative shifted exterior energy. The exterior mean-zero coercivity above $\alpha$ makes the minimizer of that even part zero.

Every odd admissible extension can now be written uniquely as
$$
 h=\sigma+w,\qquad \operatorname{supp}w\subset O,\qquad
 w\text{ odd},\qquad \langle w,q\rangle=\frac12.
 \tag{3}
$$
Its mean vanishes automatically. The value $1/2$ in (3) is the full score correction from (1), not the score moment of $x$ alone.

## Completing the exact exterior energy

Put $A=D-\alpha$ on the odd subspace and
$S=\|\sigma\|_\nu^2$. Polarization using (1) yields
$$
 \begin{split}
 E(\sigma+w)-\alpha\|\sigma+w\|^2
 ={}&\delta S+\frac{\lambda}{4}
       +\langle Aw,w\rangle
       +2\delta\operatorname{Re}\langle y,w\rangle
       -\lambda\operatorname{Re}\langle q,w\rangle\\
 ={}&\delta S-\frac{\lambda}{4}
       +\langle Aw,w\rangle
       +2\delta\operatorname{Re}\langle y,w\rangle.
 \end{split}
 \tag{4}
$$
The last equality uses (3). This explains the negative constant
$-\lambda/4$: it is the combined effect of the actual score energy and the restored exterior score constraint.

Define the complete covariance scalars
$$
 Y=\langle Gy,y\rangle,\qquad
 b=\langle Gy,q\rangle,\qquad
 c=\langle Gq,q\rangle>0.
 \tag{5}
$$
All are finite. The actual data are real, so $b$ is real, although the formulas below remain valid with $\operatorname{Re}b$ and $|b|^2$ for complex notation. The positive $G$ Gram matrix gives $Yc\ge|b|^2$.

Complete the square in (4):
$$
 \langle Aw,w\rangle+2\delta\operatorname{Re}\langle y,w\rangle
 =\|A^{1/2}(w+\delta Gy)\|^2-\delta^2Y.
$$
The vector in parentheses has score pairing $1/2+\delta b$. Its minimum squared $A^{1/2}$-norm is
$|1/2+\delta b|^2/c$, attained by a multiple of $Gq$. Hence the exact optimizer is
$$
 \boxed{\quad
 w_*=-\delta Gy+\frac{1/2+\delta b}{c}Gq,
 \qquad h_*=\sigma+w_*.
 \quad}
 \tag{6}
$$
It belongs to the full operator domain after the hard split, and satisfies both full moment constraints. The exact value is
$$
 \boxed{\quad
 F_\alpha[\sigma_C]
 =\delta\|\sigma\|^2-\frac{\lambda}{4}
       -\delta^2\mathcal C(y,y)
       +\frac{|1/2+\delta\mathcal C(y,q)|^2}
              {\mathcal C(q,q)}.
 \quad}
 \tag{7}
$$
For any admissible $w$, the difference from (7) is
$\|A^{1/2}(w-w_*)\|^2$. Thus (7) is a full minimization identity and not an estimate from a selected trial extension.

There is an independent compatibility check with the crossing-source formula. Restricting (1) to the exterior gives
$$
 B\sigma_C=(D-\alpha)y-\delta y+\frac{\lambda}{2}q.
 \tag{8}
$$
Using (8) in the complete affine covariance formula recovers (6)--(7), including the exterior contribution to the original score moment. The mean correction vanishes here by oddness, not by changing the affine constraint.

## The exact determinant inequality for this test

Multiplication of (7) by $c>0$ gives
$$
 cF_\alpha[\sigma_C]
 =\left(\delta S-\frac{\lambda}{4}\right)c
  +\frac14+\delta\operatorname{Re}b
  -\delta^2\bigl(Yc-|b|^2\bigr).
 \tag{9}
$$
Consequently the following condition is necessary and sufficient for nonnegativity on this one actual score test:
$$
 \boxed{\quad
 \delta^2
 \det\begin{pmatrix}Y&b\\\overline b&c\end{pmatrix}
 \le
 \frac14+\delta\operatorname{Re}b+
       \left(\delta S-\frac{\lambda}{4}\right)c.
 \quad}
 \tag{10}
$$
For $\lambda=1/2$, the coefficient $\lambda/4$ is $1/8$. The determinant is nonnegative, but the right side need not have an established sign.

An equivalent form separates the conditional score variance:
$$
 \boxed{\quad
 F_\alpha[\sigma_C]
 =\delta S-\frac{\lambda}{4}
   +\frac1{4c}+\frac{\delta\operatorname{Re}b}{c}
   -\delta^2\left(Y-\frac{|b|^2}{c}\right).
 \quad}
 \tag{11}
$$
This makes explicit which term a bound on $c$ alone would miss. No estimate $c\le2$ is being assumed.

## A correlation-free sufficient inequality that retains the scaled covariance

For a rigorous simplification, define
$$
 t=\delta\sqrt{Yc}\ge0.
$$
If $Y=0$, then $b=0$, and the following bound holds with $t=0$. Otherwise write $b=\sqrt{Yc}\,r$ with $|r|\le1$. The covariance part of (9), after its constant term, is
$$
 \frac14+t\operatorname{Re}r-t^2(1-|r|^2).
$$
For fixed $\operatorname{Re}r$, a nonzero imaginary part can only increase this expression. Minimizing the resulting real quadratic on $[-1,1]$ therefore gives
$$
 \frac14+t\operatorname{Re}r-t^2(1-|r|^2)\ge
 \begin{cases}
 \frac14-t,&0\le t\le\frac12,\\
 -t^2,&t\ge\frac12.
 \end{cases}
 \tag{12}
$$
The interior critical point is $-1/(2t)$; it lies in the interval exactly when $t\ge1/2$. Thus the first case of (12) yields the explicit sufficient condition
$$
 \boxed{\quad
 t\le\frac12,\qquad
 \left(\frac{\lambda}{4}-\delta S\right)c+t\le\frac14
 \quad\Longrightarrow\quad F_\alpha[\sigma_C]\ge0.
 \quad}
 \tag{13}
$$
The criterion controls $\delta\sqrt{Yc}$, not $\delta$ alone. It is weaker than the exact test (10) because it discards the measured sign and size of $b$, but it retains the potentially large exterior Green amplification.

For comparison, if $d_{\rm odd}=\inf\sigma(D|_{\rm odd})-\alpha>0$, the elementary valid estimates are
$$
 Y\le\frac{\|y\|^2}{d_{\rm odd}},\qquad
 c\le\frac{\|q\|^2}{d_{\rm odd}},\qquad
 t\le\frac{\delta\|y\|\|q\|}{d_{\rm odd}}.
 \tag{14}
$$
There is no lower bound on $d_{\rm odd}$ relative to $\delta$ supplied here. In particular the small value of $\delta$, or small unweighted exterior score norm, does not by itself justify neglecting the $\delta$-dependent covariance terms.

At $R=2$, the proved failure of the two-halfline majorant leaves (7), (10), and (13) as tests for the true form. None has been evaluated here. A sign for this one core score would also remain distinct from nonnegativity of the full core form on all inputs.
