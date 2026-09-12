# A weighted flow bound for the actual ground-state return covariance

This is a written proof for the actual full theta jump form. No theorem in this chapter is formalized in Lean. The killed-ground-state and constrained-domain inputs are established in the [ground-pole theorem](theta-killed-return-ground-pole.md) and [constrained Schur construction](theta-constrained-schur-across-ground-pole.md).

Fix a finite core $C=[-R,R]$, exterior $O$, and the actual killed operator $D=L_O$. Its ground eigenvalue $0<\alpha<1/2$ is simple and isolated. Let $\psi>0$ be its even normalized eigenfunction, $\|\psi\|_{L^2(\nu_O)}=1$, and put

$$
\mu=\langle1_O,\psi\rangle>0,\quad
G=(D-\alpha)^{-1}\big|_{\psi^\perp},\quad
\mathcal C(f,g)=\langle Gf,g\rangle.
$$

The inverse is bounded on $\psi^\perp$ by isolation of the simple ground state. It is not an inverse of $D-\alpha$ on the full space. For a core input $x$, the actual centered source and odd column are

$$
f_x=Bx-\frac{\langle Bx,\psi\rangle}{\mu}1_O,
\qquad q=\tau_O.
\tag{1}
$$

Both are orthogonal to $\psi$. The exact constrained return cost under consideration is

$$
\mathcal R(x)=\mathcal C(f_x,f_x)
 -\frac{|\mathcal C(q,f_x)|^2}{\mathcal C(q,q)}
=\min_{c\in\mathbb C}\mathcal C(f_x-cq,f_x-cq).
\tag{2}
$$

The denominator is strictly positive because $q\ne0$ and $q\perp\psi$. The desired comparison with $E_C[x]-\alpha\|x\|^2$, on the two-moment-zero core subspace, is not assumed below.

## Primary theorem and its exact scope

Den Hollander–Jansen, [*Berman–Konsowa principle for reversible Markov jump processes*, (1.15) and Appendix A](https://arxiv.org/pdf/1309.1305), gives the Thomson flow variational principle. Its general-state path framework assumes finite pointwise total rates; Theorem 1.5 permits infinite total conductance but retains that setting and requires finite conductance incident to the prescribed boundary sets. These hypotheses do not directly cover the actual theta process's infinite small-jump activity.

The useful import is the energy-duality mechanism. We give its signed-source inequality directly below, so no finite-path construction, finite holding rate, or unproved limiting path principle is used for the actual process.

## Actual ground-state conductances and a positive minorant

Write $b(u)=2\cosh(u/2)$, $d\nu=b\Phi\,du$, and

$$
\rho(u)=\frac{e^{-|u|/2}}{b(u)},\qquad
\gamma(du)=\rho(u)\psi(u)\,d\nu(u),\qquad
a=\gamma(O)>0.
\tag{3}
$$

The transformed invariant probability measure is $d\pi=\psi^2d\nu$. Its exact conductance measure is the original internal exterior conductance multiplied by $\psi(u)\psi(v)$:

$$
\mathsf K_\psi(du,dv)=\psi(u)\psi(v)\Phi(u)\Phi(v)
\left[r(|u-v|)\,du\,dv
 +du\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
       (\delta_{u+\log n}+\delta_{u-\log n})(dv)\right]_{O\times O}.
\tag{4}
$$

Here $r(t)=e^{-t/2}/(1-e^{-2t})$. The transformed form is

$$
\mathcal E_\psi(H)=E_O(\psi H)-\alpha\|\psi H\|_\nu^2
=\frac12\iint|H(u)-H(v)|^2\mathsf K_\psi(du,dv).
\tag{5}
$$

Its closed-domain interpretation is the unitary ground-state transform. The full-domain proof is given in [the ground-state Green covariance construction](theta-groundstate-green-covariance.md). No lower bound or smoothness assumption on $\psi$ is substituted into that domain statement.

The actual continuous kernel satisfies

$$
\frac{r(|u-v|)}{b(u)b(v)}\ge\rho(u)\rho(v).
$$

Therefore

$$
\boxed{\mathsf K_\psi\ge\gamma\otimes\gamma.}
\tag{6}
$$

This is the rank-one minorant already established in the [mandatory ground-pole proof](theta-killed-return-ground-pole.md). It connects both exterior components. The comparison uses only a lower part of the continuous conductance; all remaining continuous and prime-power conductances stay in the left side of (6).

The small-jump rate of this transformed process is infinite almost everywhere. At a Lebesgue point with $\psi(u)>0$, the integral of $\psi(v)\Phi(v)/|u-v|$ diverges logarithmically near $u$. This follows from Lebesgue differentiation, since $\psi$ is locally integrable and $\Phi$ is continuous and positive. Thus the finite-rate qualification in the cited path theorem is substantive even after the ground-state transform.

## An explicit signed flow and a weighted covariance inequality

For $f\in\psi^\perp$, define its zero-total-mass charge by
$\sigma_f(du)=\psi(u)f(u)\,d\nu(u)$. Both $\gamma$ and $\sigma_f$ are finite measures, the latter possibly signed or complex. The concrete antisymmetric flow

$$
\boxed{
\mathsf J_f=\frac{\sigma_f\otimes\gamma-\gamma\otimes\sigma_f}{a}
}
\tag{7}
$$

has outgoing marginal $\sigma_f$, since $\sigma_f(O)=0$. It is absolutely continuous with respect to $\gamma\otimes\gamma$, with density
$a^{-1}[f(u)/\rho(u)-f(v)/\rho(v)]$, and hence with respect to the full conductance (4).

Put

$$
W(u)=\frac{\psi(u)}{\rho(u)},\qquad
J_W(f)=\int_O W|f|^2\,d\nu.
$$

If $J_W(f)<\infty$, its full Thomson energy obeys

$$
\frac12\int\left|\frac{d\mathsf J_f}{d\mathsf K_\psi}\right|^2
 d\mathsf K_\psi
\le\frac1{2a^2}\iint
 \left|\frac{f(u)}{\rho(u)}-\frac{f(v)}{\rho(v)}\right|^2
 \gamma(du)\gamma(dv)
=\frac{J_W(f)}a.
\tag{8}
$$

The equality uses $\int(f/\rho)\,d\gamma=0$. The domination step follows from (6), including on the singular prime part, where this particular auxiliary flow is zero.

For completeness, the relevant dual estimate does not need finite jump rates. For a potential $H$, the divergence identity gives

$$
\int H\,d\sigma_f
=\frac12\iint[H(u)-H(v)]\,d\mathsf J_f.
$$

Weighted Cauchy–Schwarz bounds its square by $\mathcal E_\psi(H)$ times the flow energy in (8). Equivalently, this follows directly from (6): the lower energy is
$a\int|H-\gamma(H)/a|^2d\gamma$, and $f\perp\psi$ permits subtracting that constant from the pairing. Finiteness of the lower difference energy ensures the required weighted variance is finite. This proves the inequality on the full transformed form domain by truncation, or by this weighted variance argument.

Taking the usual Hilbert-space variational supremum for the positive inverse on constants' orthogonal complement now gives

$$
\boxed{\mathcal C(f,f)\le\frac1a J_W(f).}
\tag{9}
$$

Apply this to $f_x-cq$ and minimize $c$. The actual two-column return cost has the explicit bound

$$
\boxed{
\mathcal R(x)\le\frac1a
\left[
 \int W|f_x|^2d\nu
 -\frac{\left|\int Wf_x\overline q\,d\nu\right|^2}
        {\int W|q|^2d\nu}
\right].
}
\tag{10}
$$

The optimizing coefficient on the right is a weighted source projection; it need not equal the optimizing Green-covariance coefficient in (2). The direction of (10) is justified by minimizing a valid upper bound for every coefficient. Evenness of $W$ means that only the odd part of $f_x$ enters the subtracted term. Its even part remains in full. Thus parity has not erased either sector.

## The domain includes actual bounded core inputs

Let $\kappa_O=B1_C=D1_O$ be the actual exterior-to-core killing rate. Positivity of the crossing operator gives
$|Bx|\le\|x\|_\infty\kappa_O$ for bounded $x$. The ground-state equation fixes the centering coefficient:

$$
\frac{|\langle Bx,\psi\rangle|}{\mu}
\le\|x\|_\infty\frac{\langle\kappa_O,\psi\rangle}{\mu}
=\alpha\|x\|_\infty.
$$

Consequently

$$
J_W(f_x)\le\|x\|_\infty^2
 \int\frac{\psi}{\rho}(\kappa_O+\alpha)^2d\nu
\le\|x\|_\infty^2
 \left[\int\frac{(\kappa_O+\alpha)^4}{\rho^2}d\nu\right]^{1/2}<\infty.
\tag{11}
$$

The last Cauchy–Schwarz estimate uses $\|\psi\|_2=1$. Its remaining integral is an actual theta/rate quantity. Near either boundary, $\kappa_O$ grows only logarithmically: the same continuous crossing calculation as for the core killing rate gives
$\kappa_O(R+y)=\Phi(R)[2b(R)]^{-1}\log(1/y)+O_R(1)$.
Away from the two finite boundary points it is bounded, by the full bounded prime departure rate and the integrable continuous crossing kernel. Meanwhile $\rho^{-2}$ grows at most exponentially and $\nu$ has two-sided theta tails. These facts prove the displayed integrability. They also prove $J_W(q)<\infty$, and its value is positive.

The precise source hypothesis for (10) is $J_W(f_x)<\infty$. The separate [bounded weighted crossing proof](theta-groundstate-bounded-weighted-crossing.md) establishes it for every core $L^2$ input. The bounded-input proof above and the following density argument give an independent route that does not use that stronger theorem. However bounded two-moment-zero inputs are form-dense in the constrained core form domain, using normal truncations followed by corrections in the two bounded core moment columns. Thus proving the desired comparison using (10) on that bounded class would extend the *actual* covariance inequality by continuity of $B$, $G$, and the form. No separate continuity of the weighted upper bound is needed for that implication.

## An actual calibration and the remaining loss

The constant input is a useful normalization test, although it is not in the two-moment-zero core subspace. For $x=1_C$,

$$
f_1=\kappa_O-\alpha=(D-\alpha)1_O,\qquad
Gf_1=1_O-\mu\psi.
$$

Hence

$$
C_1:=\mathcal C(f_1,f_1)
=\langle1_O,(D-\alpha)1_O\rangle
=\int_O\kappa_O\,d\nu-\alpha\nu(O)>0.
\tag{12}
$$

The exact transformed potential is $H_1=1/\psi-\mu$. It is nonconstant: otherwise $\psi$ would be constant, forcing $\kappa_O=\alpha$, contrary to its logarithmic boundary divergence. The continuous conductance strictly exceeds the rank-one density in (6) at every distinct pair. Therefore

$$
0<E_{\rm rank}(H_1)<\mathcal E_\psi(H_1)=C_1,
$$

The rank-one energy is finite because it is bounded above by the full energy. Its first moment is also finite:
$\int H_1\,d\gamma=\int\rho\,d\nu-\mu a$.
For a finite positive measure, finiteness of the complete-graph squared-difference integral implies square-integrability modulo a constant: by Fubini choose one finite-valued $H_1(v)$ for which $\int|H_1(u)-H_1(v)|^2d\gamma(u)<\infty$. Since $\gamma$ is finite, this gives $H_1\in L^2(\gamma)$, and hence $1/\psi=H_1+\mu\in L^2(\gamma)$. In particular $\int(\rho/\psi)d\nu<\infty$; no pointwise lower bound on $\psi$ has been assumed. The correctly normalized energy is therefore

$$
E_{\rm rank}(H_1)
=a\int\frac{\rho}{\psi}\,d\nu
 -\left(\int\rho\,d\nu\right)^2.
\tag{13}
$$

The weighted Cauchy step at this actual potential implies

$$
\frac{J_W(f_1)}a
\ge\frac{C_1^2}{E_{\rm rank}(H_1)}>C_1.
\tag{14}
$$

Here $f_1$ is even, so the odd correction in both (2) and (10) vanishes. Thus the weighted conditional bound is strictly nonsharp on this exact source calibration. This is not a counterexample to the desired inequality on the two-moment-zero subspace.

The rough consequence of (11), a constant times $\|x\|_\infty^2$, is also insufficient to pay a core energy uniformly: smooth bumps of height one and shrinking support strictly inside the core have $E_C[x]+\|x\|^2\to0$. Enforcing the two moments by bounded fixed corrections does not change that conclusion. This observation concerns the rough supremum-norm bound; it does not prove that the sharper weighted expression in (10) fails on that subspace.

The concrete remaining sufficient inequality is therefore the comparison of the right side of (10), with its actual centered source and odd subtraction, against $E_C[x]-\alpha\|x\|^2$ on bounded two-moment-zero core inputs. No such comparison is established here. The result supplied is a full-domain energy-duality mechanism, an explicit actual signed flow, a weighted conditional covariance bound with a stated source domain, and a strict normalization loss. It uses neither a positive curvature hypothesis nor a finite-rate approximation of the full jump process.
