# Finite-codimension extensions cannot realize a local Weil kernel

For the short-support kernels specified below, no self-adjoint extension of the local translation operator, even on a Hilbert space containing the local space with finite codimension, reproduces the prescribed arithmetic kernel. The obstruction compares an upper spectral count of $O(T\sqrt{\log T})$ with the $\Omega(T\log T)$ poles required by classical simple critical-line zeros.

This is a written proof, not a Lean formalization. It excludes a particular construction; it neither proves nor disproves global Weil positivity or RH. Local positive-definite extension theory and the zero-counting input are classical. Priority for this specialization is not established.

## The kernel and its local Hilbert space

Use $\widehat f(t)=\int_{\mathbb R}f(u)e^{-itu}\,du$ and set

```math
h(t)=\Re\psi_{\rm digamma}(1/4+it/2)-\log\pi,
\qquad A(f)=\frac1{2\pi}\int_{\mathbb R}h(t)|\widehat f(t)|^2\,dt.
```

The digamma asymptotic gives $h(t)\sim\log(|t|/(2\pi))$. Choose $H\ge0$ and $T_0>0$ with $h\ge-H$ everywhere and $h\ge1$ for $|t|\ge T_0$. Fix

```math
0<w<\min\left\{\log2,\frac{\pi}{2T_0(1+H)}\right\}.
```

If $f$ has support in an interval of length at most $w$, then $|\widehat f|\le\sqrt w\|f\|_2$. Consequently

```math
A(f)\ge\|f\|_2^2-\frac{1+H}{2\pi}\int_{-T_0}^{T_0}|\widehat f(t)|^2dt
\ge\frac12\|f\|_2^2. \tag{1}
```

Take $\epsilon,r>0$ with $2\epsilon+r<w$, a nonzero nonnegative $b\in C_c^\infty(-\epsilon,\epsilon)$, and $\phi=b'''-b'/4$. Its exponential moments obey

```math
M_\phi(s):=\int\phi(u)e^{su}du
=-s(s^2-1/4)\int b(u)e^{su}du. \tag{2}
```

Thus the moments at $0,\pm1/2$ vanish, and those at $\pm1$ do not. Let $C_\phi(L)=\int\phi(u)\phi(u+L)du$ and define

```math
\begin{aligned}
a_\phi(L)&=\frac1{2\pi}\int h(t)|\widehat\phi(t)|^2e^{itL}dt,\\
k_\phi(L)&=a_\phi(L)-\sum_{m\ge2}\frac{\Lambda(m)}{\sqrt m}
\bigl[C_\phi(L-\log m)+C_\phi(L+\log m)\bigr].
\end{aligned} \tag{3}
```

The sum is locally finite. Both functions are smooth, real and even. For $|L|<r$ all prime terms vanish. On $\Omega=(-r/2,r/2)$ the kernel $F(x-y):=k_\phi(x-y)$ is positive definite by (1), since every finite combination of translates of $\phi$ with centers in $\Omega$ is supported in

```math
J=[-\epsilon-r/2,\epsilon+r/2].
```

Let $\mathcal H_F$ be its reproducing-kernel Hilbert space, with inner product linear in the first variable, $\gamma_x=F(\cdot-x)$ and

```math
\iota\psi=\int_\Omega\psi(x)\gamma_xdx,
\qquad S\iota\psi=-i\iota\psi',
\qquad \psi\in C_c^\infty(\Omega).
```

The core is dense and

```math
\|\iota\psi\|_{\mathcal H_F}^2=A(\phi*\psi)\ge\tfrac12\|\phi*\psi\|_2^2. \tag{4}
```

Convolution by $\phi$ is injective on these tests: their Fourier transforms are entire, and a vanishing product with the nonzero $\widehat\phi$ forces the other factor to vanish. Thus $S$ is well defined. Integration by parts proves symmetry.

For $s=\pm1$, (2), (4) and the convolution moment identity give

```math
\left|\int_\Omega e^{sx}\psi(x)dx\right|
\le\frac{\sqrt2\|e^{s\cdot}\|_{L^2(J)}}{|M_\phi(s)|}\|\iota\psi\|_{\mathcal H_F}.
```

Riesz representation, identified pointwise by approximations to $\gamma_x$, shows that $u_s(x)=e^{sx}$ belongs to $\mathcal H_F$. Direct testing gives $S^*u_s=-is u_s$. Each deficiency space has dimension at most one: its adjoint equation is a first-order distributional differential equation on the connected interval $\Omega$. The testing functional is a distribution because $\|\iota\psi\|\le C\|\psi\|_1$. Both spaces are therefore one-dimensional, and von Neumann's decomposition yields

```math
\dim\bigl(\mathcal D(S^*)/\mathcal D(\overline S)\bigr)=2. \tag{5}
```

In particular, self-adjoint extensions on $\mathcal H_F$ exist. This is the classical local-kernel construction; the preceding estimate checks its deficiency-vector hypothesis for (3).

## The upper spectral count

Put $q(t)=h(t)+H+1\ge1$ and $B(f)=(2\pi)^{-1}\int q(t)|\widehat f(t)|^2dt$. On core convolutions,

```math
A(f)\le B(f)=A(f)+(H+1)\|f\|_2^2\le(2H+3)A(f).
```

Hence $V\iota\psi=\phi*\psi$ extends to an isomorphism from $\mathcal H_F$ onto the closure of these convolutions in the $B$ norm. Its elements are $L^2$ functions supported in $J$, and $\|v\|^2=A(Vv)$. Graph-norm approximation proves that if $v\in\mathcal D(\overline S)$, then $f=Vv\in H_0^1(J)$ and

```math
f'=iV\overline S v,
\qquad \|f'\|_2^2\le2\|\overline S v\|^2. \tag{6}
```

Write $\ell=|J|$. If $f$ is orthogonal to the first $n$ Dirichlet sine functions on $J$, their expansion gives

```math
\|f\|_2^2\le\frac{\ell^2}{\pi^2(n+1)^2}\|f'\|_2^2.
```

Using $h(t)\le C\log(2+|t|)$, split the Fourier integral at $|t|=n$. Since $\log(2+t)/t^2$ decreases for $t>0$, Plancherel gives, for $n\ge1$,

```math
A(f)\le C\log(n+2)\|f\|_2^2+
 C\frac{\log(n+2)}{n^2}\|f'\|_2^2
\le C_J\frac{\log(n+2)}{n^2}\|f'\|_2^2. \tag{7}
```

Now let $\mathcal H_F$ be a closed subspace of $\mathcal K$ of finite codimension $d$, and let $T_{\mathcal K}$ be self-adjoint on $\mathcal K$, extending the action of $S$ on its core. It also extends $\overline S$. For $v\in\mathcal D(T_{\mathcal K})\cap\mathcal H_F$, testing against the core proves

```math
v\in\mathcal D(S^*),\qquad S^*v=P_{\mathcal H_F}T_{\mathcal K}v.
```

Within the spectral subspace $\operatorname{ran}\mathbf1_{[-T,T]}(T_{\mathcal K})$, membership in $\mathcal H_F$ imposes at most $d$ linear conditions; by (5), membership in $\mathcal D(\overline S)$ imposes at most two more. Impose also the $n$ sine conditions on $Vv$. If the subspace had dimension exceeding $n+d+2$, a nonzero such vector would exist. Equations (6)-(7) would force

```math
1\le 2C_JT^2\frac{\log(n+2)}{n^2}.
```

Choosing $n$ sufficiently large compared with $T\sqrt{\log(2+T)}$ proves

```math
\operatorname{rank}\mathbf1_{[-T,T]}(T_{\mathcal K})
=O_J\bigl(1+T\sqrt{\log(2+T)}\bigr)+d+2. \tag{8}
```

No discrete-spectrum assumption was used. Finiteness of every bounded spectral projection and their strong convergence to the identity imply discrete spectrum with finite multiplicities and no finite accumulation.

## The arithmetic kernel requires more poles

Define $\Phi(z)=\int\phi(u)e^{-zu}du$ and $E_\phi(z)=\Phi(z)\Phi(-z)$. The multiplier $h$ extends holomorphically to $|\Im t|<1/2$ as

```math
\frac12\bigl[\psi_{\rm digamma}(1/4+it/2)+\psi_{\rm digamma}(1/4-it/2)\bigr]-\log\pi.
```

It grows logarithmically on every smaller closed strip. Integration by parts shows that $\widehat\phi(t)\widehat\phi(-t)$ decreases faster than every inverse power of $|\Re t|$ there. A Fourier contour shift therefore gives $|a_\phi(L)|\le C_{\phi,\delta}e^{-\delta|L|}$ for each $0<\delta<1/2$. Thus $\mathcal A_\phi(z)=\int_0^\infty e^{-zL}a_\phi(L)dL$ is holomorphic for $\Re z>-\delta$.

Since $2\epsilon<\log2$, the support of $C_\phi(L-\log m)$ lies entirely in $L>0$, and $C_\phi(L+\log m)$ vanishes there. Absolute convergence of the prime-power series gives

```math
\mathcal L_\phi(z):=\int_0^\infty e^{-zL}k_\phi(L)dL
=\mathcal A_\phi(z)+E_\phi(z)\frac{\zeta'(z+1/2)}{\zeta(z+1/2)},
\qquad \Re z>1/2. \tag{9}
```

Its right side is meromorphic for $\Re z>-\delta$. At a simple critical-line zero $1/2+i\gamma$ with $\widehat\phi(\gamma)\ne0$, it has a pole at $i\gamma$ with residue

```math
E_\phi(i\gamma)=|\widehat\phi(\gamma)|^2>0. \tag{10}
```

Only $O_\phi(1+T)$ real ordinates with $|\gamma|\le T$ can be removed by $\widehat\phi$. Indeed

```math
|\widehat\phi(z)|\le\|\phi\|_1e^{\epsilon|\Im z|},
\qquad \widehat\phi(i)=M_\phi(1)\ne0.
```

Jensen's formula on disks centered at $i$ of radii $R=T+2$ and $2R$ bounds the number in the smaller disk, multiplied by $\log2$, by

```math
\log\frac{\|\phi\|_1}{|\widehat\phi(i)|}+\epsilon(1+2R).
```

Conrey's classical positive-proportion theorem supplies at least $cT\log T$ simple critical-line zeros up to height $T$, for some $c>0$. Consequently (9) has at least $cT\log T-O_\phi(T)$ distinct poles of the form (10).

If the actual $k_\phi$ equalled $\langle e^{-iLT_{\mathcal K}}\gamma_0,\gamma_0\rangle$ for all real $L$, its finite positive spectral measure would give

```math
\int_0^\infty e^{-zL}k_\phi(L)dL
=\sum_\lambda\frac{w_\lambda}{z+i\lambda},
\qquad w_\lambda\ge0,\quad \sum_\lambda w_\lambda=A(\phi).
```

By (8), eigenvalues have no finite accumulation; finite total mass makes this series meromorphic on the plane, with poles only at $-i\lambda$. Meromorphic continuation of (9) then requires an eigenvalue $\lambda=-\gamma$ for every surviving pole (10). This contradicts (8), since $T\log T$ grows faster than $T\sqrt{\log T}$.

Thus no finite-codimension extension of the specified local operator realizes the prescribed arithmetic kernel. If that kernel has a global positive realization, its canonical global kernel space contains $\mathcal H_F$ with infinite codimension: smooth local kernel sections are differentiable in Hilbert norm, and their translation generator acts as $-i\iota\psi'$ on the core, so finite codimension would fall under the contradiction above. This is a statement about Hilbert-space codimension, not physical dimension. Existence of such a global positive realization remains unproved.

## Sources

The local positive-kernel and deficiency-space framework is classical: P. Jorgensen, S. Pedersen and F. Tian, [*Extensions of Positive Definite Functions: Applications and Their Harmonic Analysis*](https://arxiv.org/abs/1507.02547), especially Lemma 2.7, Remark 2.3 and the Type I/II distinction. The elementary short-support estimate (1) supplies the positivity needed here without assuming global Weil positivity.

The sole zero-density input is J. B. Conrey, [*More than two fifths of the zeros of the Riemann zeta function are on the critical line*](https://aimath.org/~kaur/publications/24.pdf), J. reine angew. Math. 399 (1989), 1–26, Theorem 1 and its simple-zero counting conventions. Digamma poles and asymptotics are recorded in [DLMF §5.2](https://dlmf.nist.gov/5.2) and [§5.11](https://dlmf.nist.gov/5.11). These established inputs are attributed rather than claimed as new results.
