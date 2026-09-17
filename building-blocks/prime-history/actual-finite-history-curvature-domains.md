# Actual finite-history curvature: domains and a nonmeasure obstruction

This written proof supplies the domains for the [two-port curvature identity](../dynamics-and-feedback/positive-primitive-two-port-drift-curvature.md) and a counterexample to its proposed nonnegative-curvature-measure hypothesis. The counterexample uses the actual source cutoff $N=2$, prime $2$, every power of $2$, and the true successor compensation. It does not determine the sign of the complete energy change.

## 1. The separate terms are Sobolev dual pairings

Write $D=\partial_v$, $Q_\varepsilon=D^2+\varepsilon D/2$ for $\varepsilon\in\{-1,1\}$, and $\widehat L=4I-G$. The bounded symmetric operators in the two-port construction obey

$$
[D,\widehat L]=J,\qquad [D,J]=J_2=-G+2T_1.
$$

These identities, first on smooth compact tests and then by smoothing, give continuous maps $\widehat L:H^2\to H^2$ and $J:H^1\to H^1$. For example,

$$
D^2\widehat Lr=\widehat LD^2r+2JDr+J_2r.
$$

For every actual potential $r\in H^2(\mathbb R)$ and force $z\in L^2(\mathbb R)$, each term in

$$
\langle r,Q_\varepsilon\widehat Lz\rangle
=\langle r,\widehat LQ_\varepsilon z\rangle
 +2\langle r,JDz\rangle+\langle r,J_2z\rangle
 +\frac\varepsilon2\langle r,Jz\rangle
\tag{1}
$$

has a separate definition. The first two mean

$$
\langle r,\widehat LQ_\varepsilon z\rangle
 =\langle Q_{-\varepsilon}\widehat Lr,z\rangle,
\qquad
\langle r,JDz\rangle=-\langle D(Jr),z\rangle.
\tag{2}
$$

The other two are ordinary $L^2$ pairings. Since $D(Jr)=JDr+J_2r$, their full sum is

$$
\begin{aligned}
\langle r,Q_\varepsilon\widehat Lz\rangle
 &=\langle Q_{-\varepsilon}\widehat Lr-2JDr-J_2r
                   +\tfrac\varepsilon2Jr,z\rangle\\
 &=\langle\widehat LQ_{-\varepsilon}r,z\rangle.
\end{aligned}
\tag{3}
$$

Thus the absolute value of the pairing, and the sum of the absolute values of the four pairings in (1), are bounded by $C\|r\|_{H^2}\|z\|_2$. No pointwise second derivative of the actual force is required. The predecessor Jacobian in $T_1$ is handled by its $L^2$ change of variables, including the physical endpoint $x=1$. Negative-age columns remain present.

## 2. A derivative of an atom in the actual prime-2 history

Let $\ell=\log2$ and $A=2-\ell>0$. The physical source and its compensated successor are

$$
g_2(x)=\begin{cases}0&x<1,\\-1&1\le x<2,\\-A/x&x\ge2,
\end{cases}
\qquad
Cg_2(x)=\mathbf1_{x\ge1}\left[-\frac A{x+1}-\frac\kappa x\right],
\tag{4}
$$

where the actual charge is

$$
\kappa=2\sqrt2-1-\frac\ell{\sqrt2}-\frac{\pi(2-\ell)}4>0.
\tag{5}
$$

Indeed, for $Q(f)=\int_1^\infty f(x)/(2\sqrt x)\,dx$, direct integration gives
$Q(g_2)=1+\ell/\sqrt2-2\sqrt2$ and $Q(Sg_2)=-\pi A/4$. Strict positivity also follows from the [natural-cutoff charge certificate](../successor-and-division/natural-cutoff-successor-primitive.md).

The complete one-prime anticausal response is

$$
Y_f(x)=-A_2^*f(x)=\frac12f(2x)-\frac12\sum_{k\ge2}f(2^kx).
\tag{6}
$$

Set $Z=Y_{g_2}+Y_{Cg_2}$. The input $g_2+Cg_2$ has precisely the jumps
$j_1=-1-A/2-\kappa$ at $1$ and $j_2=\ell/2$ at $2$. At $x_j=2^{-j}$, $j\ge2$, the terms $k=j$ and $k=j+1$ in (6) collide, while the first-power term has no jump there. Hence

$$
\Delta Z(x_j)=-\frac{j_1+j_2}2=\frac{A+\kappa}2>0.
\tag{7}
$$

Under the unitary map $(Uf)(v)=e^{v/2}f(e^v)$, the actual midpoint force $z=UZ=y_-^C+y_-$ therefore has jumps

$$
b_j=\Delta z(v_j)=2^{-j/2}\frac{A+\kappa}2>0,
\qquad v_j=-j\log2.
\tag{8}
$$

On any compact age interval there are finitely many activation thresholds. Away from them, (4)–(6) and all fixed-order derivatives of their tails converge geometrically. Thus $z$ is piecewise smooth there. The physical convolution kernel $K(x)=\min(1,|x|^{-2})$ has $K'\in L^1$ and distributional $K''$ a finite signed measure. Since the zero extension of $Z$ is in $L^2$, Young's inequality gives $K*Z\in H^2$. Consequently $Gz\in H^2_{\rm loc}$ after the unitary change of coordinates, and $Q_-Gz$ has no derivatives of atoms.

Near each $v_j$, the actual curvature is therefore

$$
Q_-\widehat Lz
 =4b_j\delta'_{v_j}
  +4\left([z']_{v_j}-\frac{b_j}2\right)\delta_{v_j}
  +\text{a locally integrable remainder},
\qquad Q_-=D^2-D/2.
\tag{9}
$$

In particular it is not a locally finite signed measure. To see this directly, choose a smooth compact bump $\eta=1$ near zero and test with
$\varphi_\epsilon(v)=(v-v_j)\eta((v-v_j)/\epsilon)$, supported away from the other thresholds. Its supremum tends to zero, while the $\delta'$ pairing is $-4b_j$. All measure and locally integrable terms tend to zero.

## 3. The remaining signed pairing

The complete anticausal square change remains

$$
\mathcal E(y_-^C)-\mathcal E(y_-)
 =-\langle r_-,Q_-\widehat Lz\rangle.
\tag{10}
$$

The positive potential $r_-\in H^2$ has continuous value and first derivative. After a local cutoff, the singular terms at $v_j$ contribute

$$
4b_jr_-'(v_j)
-4\left([z']_{v_j}-\frac{b_j}2\right)r_-(v_j),
\tag{11}
$$

with the cutoff and remainder terms retained. Positivity of $r_-$ fixes neither (11) nor (10). No sum of the isolated contributions over all negative ages is separated without a convergence proof; (1)–(3) already define the full pairing.

The bounded contact terms $2T_1z$, $-Gz$ and $Jz$ are in $L^2$ and cannot cancel the derivatives of atoms in (9). This refutes the nonnegative-curvature-measure hypothesis for this actual finite history. The full signed Sobolev pairing, the complete two-port comparison and the RH sign question remain distinct.

The argument uses classical distributional differentiation, Young's inequality and one-dimensional Sobolev embedding. It claims no literature priority. These domain and counterexample statements are written proofs; the [formal energy and contact estimates](../prime-distribution/all-prime-fixed-source-drift-curvature.md#formalized-energy-and-contact-forms) cover a separate part of the construction.


The subsequent [complete prime-two energy calculation](../prime-distribution/prime-two-anticausal-energy.md) proves that this same actual example nevertheless has energy change strictly less than $-1/10$. It sums every negative-age interval and bounds the entire positive physical tail. Thus the failed measure hypothesis does not obstruct the integrated sign in this example, and the example gives no sign for larger prime sets or the complete W readout.
