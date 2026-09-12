# The mandatory exterior ground-state pole and its visible return residue

This written proof uses the classical positivity-improving ground-state argument, with the actual positive continuous-kernel minorization proved below. No theorem here is formalized in Lean.

Fix a finite core $C=[-R,R]$, $R>0$, and $O=\mathbb R\setminus C$. We use the actual killed operator and bounded crossing operator from [theta-killed-core-return-comparison](theta-killed-core-return-comparison.md). The [exterior-index construction](theta-exterior-threshold-index-transport.md) and the [threshold Weyl sequence](theta-killed-return-compact-infinite-rank.md#6-the-exterior-threshold-inverse-is-impossible-for-every-fixed-core) prove
$$
0<\alpha_R:=\inf\sigma(L_O)<\lambda=\tfrac12,
\qquad\inf\sigma_{\rm ess}(L_O)=\lambda,
$$
and makes $\alpha_R$ an isolated eigenvalue of finite multiplicity. We prove its simplicity and strict positivity, then separate its pole in the full return. None of this assumes RH or rules out further exterior eigenvalues below $\lambda$.

Write $b(u)=2\cosh(u/2)$, $d\nu=b\Phi\,du$. All exterior operators below act on $\mathcal H_O=L^2(O,\nu)$, and core operators act on $\mathcal H_C=L^2(C,\nu)$.

## 1. A positive rank-one component inside the actual continuous kernel

Relative to $\nu(dv)$, the continuous internal exterior jump rate has density
$$
\frac{r(|u-v|)}{b(u)b(v)},\qquad
r(t)=\frac{e^{-t/2}}{1-e^{-2t}},\qquad u,v\in O.
$$
Since $r(t)\ge e^{-t/2}$ and $|u-v|\le|u|+|v|$,
$$
\frac{r(|u-v|)}{b(u)b(v)}\ge\rho(u)\rho(v),
\qquad \rho(u)=\frac{e^{-|u|/2}}{b(u)}>0.
\tag{1}
$$
This lower kernel connects both components of $O$. Also $0<\rho\le1/2$, and $\nu(O)<\infty$.

Remove only the bounded internal jump form
$$
E_\rho(h)=\tfrac12\iint_{O\times O}\rho(u)\rho(v)
                   |h(v)-h(u)|^2d\nu(u)d\nu(v)
\tag{2}
$$
from the killed form. The remaining jump measure is nonnegative by (1); every prime-power jump and every killing contribution remains unchanged. This gives a closed nonnegative Dirichlet form on the same domain: (2) is a bounded form, and the two form norms are equivalent after adding a sufficiently large multiple of the $L^2$ norm.

Let $L_{\rm rem}$ be its generator, let $a_\rho=\int_O\rho\,d\nu$, and set
$$
D_\rho h=a_\rho\rho h,\qquad J_\rho h=\langle h,\rho\rangle\rho,
\qquad A_0=L_{\rm rem}+D_\rho.
$$
The exact operator decomposition is
$$
L_O=A_0-J_\rho.
\tag{3}
$$
Here $A_0\ge0$ is a Dirichlet generator with additional nonnegative killing, and $J_\rho$ is a bounded positive rank-one operator. Choose a real $t_0>\|J_\rho\|$, and put $R_0=(A_0+t_0)^{-1}$. The positive resolvent Neumann expansion is norm convergent:
$$
(L_O+t_0)^{-1}
=R_0+R_0J_\rho R_0+R_0J_\rho R_0J_\rho R_0+\cdots.
\tag{4}
$$
Every term preserves nonnegative functions.

The second term is positivity improving. Indeed $R_0$ is injective and positivity preserving. If $f\ge0$ is nonzero, then $R_0f\ge0$ is nonzero and $\langle R_0f,\rho\rangle>0$. Also $R_0\rho>0$ almost everywhere: if it vanished on a set $Z$ of positive measure, self-adjointness would give
$0=\langle1_Z,R_0\rho\rangle=\langle R_01_Z,\rho\rangle$, impossible because $R_01_Z$ is nonnegative and nonzero. Thus
$$
R_0J_\rho R_0f=\langle R_0f,\rho\rangle R_0\rho>0
\quad\nu\text{-almost everywhere}.
$$
Equation (4) proves that $(L_O+t_0)^{-1}$ is positivity improving. This is an actual-kernel argument, not an irreducibility assumption about the two exterior components.

## 2. The lowest eigenvalue is simple and its eigenfunction is strictly positive

The jump contraction $h\mapsto|h|$ does not increase the killed form and preserves the norm. Applying it to a lowest eigenvector gives a nonnegative minimizer, hence a lowest eigenvector. Normalize it as
$$
L_O\psi_R=\alpha_R\psi_R,\qquad \|\psi_R\|_O=1,\qquad\psi_R\ge0.
$$
Since
$\psi_R=(\alpha_R+t_0)(L_O+t_0)^{-1}\psi_R$, the positivity-improving property gives
$$
\psi_R>0\qquad\nu\text{-almost everywhere on all of }O.
\tag{5}
$$
Strict positivity is asserted in this Hilbert-space sense; no boundary trace regularity is needed.

Every real lowest eigenvector has one sign. Otherwise its positive and negative sets both have positive measure, and the strictly positive continuous kernel between those sets would make $E_O(|h|)<E_O(h)$, contradicting the lowest Rayleigh value. An independent real lowest eigenvector could be chosen orthogonal to the strictly positive $\psi_R$; it would have to change sign, a contradiction. The operator is real, so applying this conclusion to real and imaginary parts gives complex simplicity as well. Therefore
$$
\boxed{\quad \alpha_R\text{ is simple, with the unique normalized positive eigenfunction }\psi_R.\quad}
\tag{6}
$$

## 3. The crossing sees the ground state

Let
$$
v_R=B^*\psi_R\in\mathcal H_C,\qquad
\mu_R=\langle1_O,\psi_R\rangle_O>0.
\tag{7}
$$
The mass is finite because $\nu(O)<\infty$, and $0<\mu_R\le\sqrt{\nu(O)}$. The archimedean part of $v_R$ at an interior core point $v$ is
$$
\frac1{b(v)}\int_O\Phi(u)\psi_R(u)r(|u-v|)\,du>0.
\tag{8}
$$
This integral is finite: the distance from that fixed point to $O$ is positive, and $\int_O\Phi|\psi_R|\,du<\infty$ by Cauchy–Schwarz with weight $\nu$. Every prime-power contribution to $B^*\psi_R$ is also nonnegative. Boundedness of $B^*$ identifies their sum in $L^2(C,\nu)$. Hence
$$
\boxed{\quad v_R>0\quad\nu\text{-almost everywhere on }C,\qquad v_R\ne0.\quad}
\tag{9}
$$
No finite selection of prime crossings is used in this residue.

The constant-mode equation from the exact hard split is $L_O1_O=B1_C$. It supplies the additional normalization
$$
\langle v_R,1_C\rangle_C
=\langle\psi_R,B1_C\rangle_O
=\alpha_R\mu_R>0.
\tag{10}
$$
Thus the residue is visible even to the constant core input.

For domain clarity, $1_O\in D(L_O)$ follows from $1\in D(L)$ and the hard-split operator domain. The other pole column $\tau_O$, $\tau=\tanh(u/2)$, also belongs to $D(L_O)$. Globally $\tau$ is in the form domain, and $|\tau'|\le1/2$, $\Phi(u+a)/b(u)\le\Phi_*/2$ give
$$
|L_{\rm arch}\tau(u)|
\le\frac{\Phi_*}{2}\int_0^\infty a r(a)\,da<\infty,
\qquad
|L_{\rm prime}\tau(u)|\le2\|b_{\rm prime}\|_\infty.
\tag{11}
$$
The actual weak generator is therefore in $L^2(\nu)$, placing $\tau$ in $D(L)$; the same hard split gives its exterior restriction. This uses the full prime departure bound and the compensated continuous difference integral, not a finite total archimedean rate.

## 4. A legitimate local resolvent disk and all remaining spectrum

Write $\alpha=\alpha_R$, $\psi=\psi_R$, $v=v_R$, $\mu=\mu_R$, and let $P_\alpha f=\langle f,\psi\rangle\psi$. Define
$$
g=\operatorname{dist}(\alpha,\sigma(L_O)\setminus\{\alpha\})>0.
$$
The set in this definition is nonempty, since $\lambda\in\sigma_{\rm ess}(L_O)$; in particular $g\le\lambda-\alpha$. Fix
$$
0<r<\min\{\alpha,g/2\}.
\tag{12}
$$
Then the real interval $(\alpha-r,\alpha+r)$ is positive, lies below $\lambda$, and contains no exterior spectral point other than $\alpha$. No claim about higher eigenvalues beyond this interval is made.

On the full exterior space, the reduced resolvent
$$
R^{\rm reg}(z)=(L_O|_{\psi^\perp}-z)^{-1}(I-P_\alpha)
$$
is operator-norm analytic for $|z-\alpha|<g$. On $|z-\alpha|\le r$,
$$
\|R^{\rm reg}(z)\|\le\frac1{g-r},
\qquad
(L_O-z)^{-1}=\frac{P_\alpha}{\alpha-z}+R^{\rm reg}(z)
\quad(z\ne\alpha).
\tag{13}
$$
The regular part retains every other spectral component. For real $z$ in (12) it is positive as a quadratic-form operator, because all its spectral values have denominator $t-z>0$. Its subtraction of the ground-state projection is not an order-preserving-kernel assertion.

One exact semigroup expression, valid for $\Re z<\alpha+g$, is
$$
R^{\rm reg}(z)=\int_0^\infty e^{zt}e^{-tL_O}(I-P_\alpha)\,dt.
\tag{14}
$$
The integral converges in operator norm, using the spectral decay $e^{-(\alpha+g)t}$ on $\psi^\perp$. All actual continuous and prime-power histories in the semigroup remain present. The full positive-return Laplace integral without the subtraction only converges for $\Re z<\alpha$; it cannot be continued past this pole by retaining that integral unchanged.

## 5. Pole-separated return, mean vector, and Schur operator

Define
$$
\Sigma^{\rm reg}(z)=B^*R^{\rm reg}(z)B,
\qquad g^{\rm reg}(z)=1_C+B^*R^{\rm reg}(z)1_O.
$$
They are analytic on the disk in (12), with bounds
$$
\|\Sigma^{\rm reg}(z)\|\le\frac{\|B\|^2}{g-r},\qquad
\|g^{\rm reg}(z)\|
\le\|1_C\|+\frac{\|B\|\|1_O\|}{g-r}.
\tag{15}
$$
The exact meromorphic identities are
$$
\boxed{\quad
\Sigma_z=\frac{|v\rangle\langle v|}{\alpha-z}+\Sigma^{\rm reg}(z),
\qquad
 g_z=\frac{\mu v}{\alpha-z}+g^{\rm reg}(z).
\quad}
\tag{16}
$$
Here $|v\rangle\langle v|$ means $x\mapsto\langle x,v\rangle v$, with the inner product linear in its first slot. Both pole coefficients are nonzero and positive: $v>0$, $\mu>0$. In the usual complex-analytic convention the residues at $z=\alpha$ are $-|v\rangle\langle v|$ and $-\mu v$; (16) displays the positive coefficients of $(\alpha-z)^{-1}$.

In particular the return pole does not disappear under observation through $B$. For real $z\uparrow\alpha$,
$$
\|\Sigma_z\|\ge\frac{\|v\|^2}{\alpha-z}\longrightarrow\infty,
\qquad
\langle\Sigma_z1_C,1_C\rangle
=\frac{\alpha^2\mu^2}{\alpha-z}+O(1).
\tag{17}
$$
This is divergence at the isolated ground-state pole. It makes no assertion about the observed return as $z\to\lambda$, where the exterior threshold inverse is unavailable.

Finally the pole-separated Schur operator is
$$
\boxed{\quad
S_z=L_C-z+\frac{|v\rangle\langle v|}{z-\alpha}
                     -\Sigma^{\rm reg}(z),\qquad
D(S_z)=D(L_C).
\quad}
\tag{18}
$$
Its form domain is $D(E_C)$, independent of $z$ in the punctured disk. The bounded corrections are analytic apart from the displayed simple pole. For real $z$ on either side it is self-adjoint; the pole term is negative below $\alpha$ and positive above it.

Algebraic Schur elimination remains valid for $z$ in this punctured interval, because the exterior inverse exists there. Above $\alpha$, however, that inverse has one negative spectral direction and is not a positive return resolvent. A completion using a positive square $\|(L_O-z)^{1/2}\cdot\|^2$ is then invalid; the exterior quadratic term must retain its sign. The regular part (14), the explicit ground-state channel in (16), and the actual two moment columns provide the legitimate local accounting across the pole.

The pole is forced for every finite core, even if RH holds. It is an exterior killed-mode pole, not a claim that $\alpha_R$ is a full-space eigenvalue or a zeta zero. No inverse at $\lambda$, no absence of further exterior modes, and no sign of the complete corrected Schur operator has been assumed.
