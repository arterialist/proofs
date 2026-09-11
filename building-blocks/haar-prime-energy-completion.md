# Haar prime energy: boundary completion and Fourier costs

This note records exact decompositions and limitations of a Haar approach to the actual prime-counting error. It uses all von Mangoldt weights, including prime powers. The results are written proofs based on classical Haar, Fourier and positive-kernel methods; no first-publication claim is made.

Let $X\ge4$ be dyadic and $e(x)=\psi(x)-x$. For a dyadic interval $I=[a,a+h)\subset[X,2X)$, let $\eta_I=h^{-1/2}(\mathbf1_{I_L}-\mathbf1_{I_R})$ and $\tau_I(t)=\min(t-a,a+h-t)$ on $I$, zero elsewhere. Integration by parts gives

```math
c_I:=\langle e,\eta_I\rangle
=\frac{h^{3/2}}4-\frac1{\sqrt h}\sum_{a<n<a+h}\Lambda(n)\tau_I(n).
```

Writing $A_h=\sum_{|I|=h}c_I^2$ and $m=X^{-1}\int_X^{2X}e$, Haar orthogonality yields the complete identity

```math
\int_X^{2X}e(x)^2dx=Xm^2+\sum_{h=X,X/2,\ldots,2}A_h+X/12.
```

The last term is the variance of the slope $-1$ within each unit interval. Orthogonality does not imply decreasing detail energy: a direct four-cell computation gives

```math
A_2-A_4=\frac14\sum_{a=X,X+4,\ldots,2X-4}
(\Lambda(a+1)-\Lambda(a+3))^2+
\psi(2X)-\psi(X)-\log2-\frac{3X}{4}.
```

The prime number theorem makes this at least $X/4+o(X)>0$ eventually along dyadic $X$.

## Translation averaging with the correct endpoints

For $f\in L^2(\mathbb R)$, put

```math
V_h(f)=h^{-2}\int\left|\int_a^{a+h}f(x)dx\right|^2da,
\qquad B_h(f)=h^{-1}\int|\langle f,\eta_{a,h}\rangle|^2da.
```

The parallelogram identity gives $B_h=V_{h/2}-V_h$. Plancherel gives

```math
V_h(f)=\frac1{2\pi}\int
\left|\frac{\sin(th/2)}{th/2}\right|^2|\widehat f(t)|^2dt.
```

Dominated convergence proves $V_h\to\|f\|^2$ as $h\downarrow0$ and $V_h\to0$ as $h\to\infty$. Hence $\|f\|^2=\sum_{j\in\mathbb Z}B_{2^jh_0}(f)$ for every $h_0>0$.

Let $r$ be the even tent autocorrelation

```math
r(u)=\begin{cases}
1/12-u^2/2+|u|^3/2,&|u|\le1/2,\\
(1-|u|)^3/6,&1/2\le|u|\le1,\\
0,&|u|\ge1.
\end{cases}
```

For a compactly supported real BV function with distributional derivative $\widetilde\nu$, integration against the tent gives

```math
B_h(f)=\mathcal B_h(\widetilde\nu):=
h\iint r((s-t)/h)\,d\widetilde\nu(s)d\widetilde\nu(t).
```

In the prime application set

```math
\nu=\sum_{X<n\le2X}\Lambda(n)\delta_n-\mathbf1_{[X,2X]}dt,
\qquad \widetilde\nu=\nu+e(X)\delta_X-e(2X)\delta_{2X}.
```

This is exactly the derivative of $e\mathbf1_{[X,2X)}$. In particular, the atom already present at $2X$ combines with $-e(2X)$ to give the correct jump $-e(2X-)$. Therefore

```math
\int_X^{2X}e(x)^2dx=\sum_{j\in\mathbb Z}\mathcal B_{2^jX}(\widetilde\nu).
```

The endpoint coefficients are actual unknown errors. The identity does not remove them. For example, if $h\ge2X$ and $M_1=\int(t-X)d\widetilde\nu(t)=-\int_X^{2X}e$, the total-mass-zero property gives

```math
\mathcal B_h(\widetilde\nu)=\frac{M_1^2}{h}
+\frac1{2h^2}\iint|s-t|^3d\widetilde\nu(s)d\widetilde\nu(t).
```

The squared mean remains in the large-scale terms.

## A quantitative obstruction to a single positive-Fourier minorant

Define $K_h(d)=h r(d/h)$ and

```math
R_h(d)=\tfrac12K_h(d)-K_{h/2}(d)\ge0.
```

Then $R_h(0)=0$, its support is $[-h,h]$, and $\int R_h=h^2/64$. With Fourier convention $e^{-i\omega d}$,

```math
\widehat r(\omega)=\frac{16\sin^4(\omega/4)}{\omega^4},\qquad
\widehat R_h(\omega)=\frac{h^2}{2}\widehat r(h\omega)
-\frac{h^2}{4}\widehat r(h\omega/2).
```

Let $h\ge4$ be divisible by 4, and periodize the integer kernel on a cyclic group of order $q\ge2h$ divisible by $h$. Absolute Fourier aliasing gives its discrete eigenvalues. At zero the eigenvalue is $I_h=h^2/64$; at $m_*=2q/h$ it is $-D_h$, where

```math
D_h=\frac{4h^2}{\pi^4}\sum_{a\in\mathbb Z}(2+ha)^{-4}
\ge\frac{h^2}{4\pi^4}.
```

Indeed the first Fourier term vanishes at every alias of $4\pi/h$, while the second has sine fourth power 1.

Suppose a real even kernel $g$ on this group has nonnegative discrete Fourier transform $G$ and satisfies $g(j)\le R_h^{(q)}(j)$ for $j\ne0$. Write $\Delta=I_h-G(0)$, the lost total mass. Testing with the nonnegative function $1+\cos(2\pi m_*j/q)$ gives

```math
G(0)\le G(0)+G(m_*)\le I_h-D_h+2g(0),
```

so

```math
\boxed{\Delta+2g(0)\ge h^2/(4\pi^4).}
```

Preserving the bulk mass up to $o(h^2)$ requires a diagonal charge at least $h^2/(8\pi^4)+o(h^2)$. On actual prime-power weights the diagonal mass is $\sum_{X<n\le2X}\Lambda(n)^2\sim X\log X$, explaining why this charge can overwhelm a bulk term of order $Xh^2$.

## An exact multiscale repair and the direction it controls

For dyadic $h=2^k$, telescoping gives

```math
\sum_{j=0}^{k-1}2^jR_{h/2^j}(d)=\tfrac12K_h(d)-\tfrac h2K_1(d).
```

On integer differences $K_1(n)=\mathbf1_{n=0}/12$. Thus the changed aggregate kernel has a positive-Fourier completion $K_h/2$ with diagonal charge only $h/24$. This does not contradict the single-kernel obstruction: the off-diagonal kernel has changed.

For the uncorrected prime measure define $\mathcal F_h=-\iint R_h\,d\nu\,d\nu$. The same real-variable identity gives

```math
\mathcal A_h:=\sum_{j=0}^{k-1}2^j\mathcal F_{h/2^j}
=\frac h2\mathcal B_1(\nu)-\frac12\mathcal B_h(\nu).
```

Put $P=\psi(2X)-\psi(X)$, $S_2=\sum_{X<n\le2X}\Lambda(n)^2$, and $\ell=\log2$. Since distinct integer atoms do not interact under $K_1$, elementary cubic integration yields

```math
\mathcal B_1(\nu)=S_2/12-P/8+\ell/16+X/16-7/480.
```

Here the endpoint atom sees half the density integral; $\int r=1/16$ and $\int|u|r(u)du=7/480$. Consequently $\mathcal A_h\le h\mathcal B_1/2=O(Xh\log X)$.

This is an upper bound for a signed aggregate. Rearranging gives $\mathcal B_h=h\mathcal B_1-2\mathcal A_h$, so bounding the coarse energy above requires a **lower** bound for $\mathcal A_h$. The positive completion has not supplied it. Applying the identity to $\widetilde\nu$ also retains its signed endpoint interactions and squared error atoms.

The underlying method is classical Fourier positive-kernel comparison, of the kind used in [Cohn–Elkies](https://arxiv.org/abs/math/0110009), together with Haar/Plancherel identities. The exact spline potential and prime-error substitutions above give reusable limitations on this particular proposal, not an RH estimate.
