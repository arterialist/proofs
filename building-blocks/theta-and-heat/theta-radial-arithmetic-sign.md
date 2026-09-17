# Positive radial weights do not make the arithmetic coefficient positive

The positive Bessel-square energy representation of the actual theta correlation retains a signed divisor coefficient. That coefficient takes negative values at arbitrarily large radial cutoffs. The conclusion concerns the integrand coefficient; it does not decide the sign of the full correlation transform.

Fix $0<y<1/2$, put $f(a)=a\sinh(ya)$, and for $r\ge1$ define

```math
J_y(r)=\int_{1/r}^1
\frac{v^{1/2}\big(\tfrac32f(\log(rv))+f'(\log(rv))\big)}
{\sqrt{1-v^2}}\,dv.
```

For a real cutoff $Q>1$ set

```math
A_k(Q;y)=8Q^{3/2}k^{-1/2}J_y(Q/k)\quad(1\le k\le Q),
```

```math
D_k(x)=\sum_{d\mid k}e^{ix\log(d^2/k)},
\qquad M_y(Q,x)=\sum_{k\le Q}A_k(Q;y)D_k(x).
```

Thus $A_k>0$ for $k<Q$ and $A_Q=0$ at an integer endpoint. These are the actual smooth Abel coefficients: if $c=\pi Q$ and

```math
\mu_k(c)=\frac c\pi\int_{\pi k}^c
\frac{(\pi k)^{-5/2}t^{1/2}
[\tfrac32 f(\log(t/(\pi k)))+f'(\log(t/(\pi k)))]}
{\sqrt{c^2-t^2}}\,dt,
```

then $A_k=8\pi^2k^2\mu_k(c)$ by substitution $t=\pi Qv$. The associated radial positivity proof uses the classical product formula [DLMF 10.32.17](https://dlmf.nist.gov/10.32.E17); positivity of its individual radial integrals does not establish positivity of $M_y$.

**Theorem.** For every fixed $0<y<1/2$, and every sufficiently large real $Q$, there exists a real $x$ such that $M_y(Q,x)<0$.

Give each prime $p\le Q$ an independent circle coordinate $z_p$ and extend $z$ multiplicatively to integers. Define

```math
D_k(z)=\sum_{d\mid k}\frac{z(d)}{z(k/d)},
\qquad P_Q(z)=\sum_{k\le Q}A_kD_k(z).
```

Fix $z_p=-1$ when $Q/2<p\le Q$ and average all other prime coordinates uniformly. A divisor summand survives this average precisely when every averaged prime has equal exponents in $d$ and $k/d$. If $k$ contains a fixed prime, the cutoff forces $k=p$ and $D_p=-2$. Otherwise $k$ must be a square, whose constant term is one. Hence the exact conditional average is

```math
\int P_Q(z)\,dz_{\rm remaining}
=\sum_{n^2\le Q}A_{n^2}-2\sum_{Q/2<p\le Q}A_p.
```

All prime powers are included in this calculation. For $a\ge0$, the numerator defining $J_y$ is at most $C_y(1+a)e^{ya}$. The integrable factor $v^{1/2+y}/\sqrt{1-v^2}$ therefore gives

```math
J_y(r)\le C_y r^y(1+\log r),
\qquad
\sum_{n^2\le Q}A_{n^2}
\le C_yQ^{3/2+y}(1+\log Q),
```

where convergence of $\sum n^{-1-2y}$ uses $y>0$. On the compact interval $4/3\le r\le2$, $J_y(r)$ has a positive lower bound. Every prime $Q/2<p<3Q/4$ consequently contributes $A_p\ge c_yQ$. The prime number theorem gives at least $cQ/\log Q$ such primes for sufficiently large $Q$. Thus

```math
\sum_{Q/2<p\le Q}A_p\ge c_y\frac{Q^2}{\log Q}.
```

Since $3/2+y<2$, the conditional average is negative for all sufficiently large $Q$. The prime-counting input is the classical prime number theorem; a primary proof is [Erdős, PNAS 35 (1949), 374–384](https://doi.org/10.1073/pnas.35.7.374).

Some point of the finite prime torus therefore has $P_Q<0$. The actual orbit $z_p=p^{ix}$ is dense there. To see this without any discrete-time assumption, unique factorization gives $\sum m_p\log p\ne0$ for every nonzero integer vector $(m_p)$. The average over $x\in[-T,T]$ of each nonconstant torus character thus tends to zero. Trigonometric approximation gives the Haar limit for every continuous function. Applying this to a nonnegative continuous function supported in an open negative region proves that the actual orbit enters that region. At that real frequency, $P_Q(z)=M_y(Q,x)<0$.

The exponent restriction is essential to this proof. It establishes neither sign at $y=1/2$. It also does not apply to the frequency-dependent radial weights $W_y(k,x)$ by pretending their coefficients are fixed during the torus argument. The final Bessel-energy integral must retain the coupling between its radial variable and $x$; the theorem rules out only the pointwise-positive-coefficient shortcut. The torus averaging and prime-counting methods are classical, and no priority claim is made.

## A surviving positive mixture of actual Dirichlet prefixes

A different positive representation is valid. It keeps the frequency in the mixing law. For any $y>0$ define

```math
h_y(a)=\tfrac32a\sinh(ya)+\sinh(ya)+ya\cosh(ya),\qquad a\ge0,
```

and extend it by zero to $a<0$. With $v=ya$,

```math
e^v(h_y'(a)-yh_y(a))
=2y+3v+(3/4+y/2)(e^{2v}-1-2v)>0.
```

It follows, including the support boundary, that
$h_y(a-b)<e^{-yb}h_y(a)$ for $a,b>0$. Applying this inside the integral defining $J_y$ gives

```math
J_y(r/q)<q^{-y}J_y(r)\quad(r>1,\ q>1),
```

with both sides zero for $r\le1$. If $\sigma=1/2+y$, then

```math
A_l(c/\pi;y)<(k/l)^\sigma A_k(c/\pi;y)
\quad(l>k,\ c>\pi k),
```

where $A_l=0$ until its actual birth $c=\pi l$.

To connect this to the radial weights, let $D=c\,d/dc$, $v_x(c)=K_{ix/2}(c)$, and

```math
E(c,x)=2(Dv_x+3v_x)^2+(2c^2+x^2/2-9)v_x^2.
```

For $c\ge\pi$, this is strictly positive: the coefficient of $v_x^2$ is positive, and the modified Bessel equation forbids simultaneous vanishing of $v_x$ and its derivative. The exact Abel/Bessel representation is

```math
W_y(k,x)=\int_{\pi k}^\infty E(c,x)A_k(c/\pi;y)\,dc.
```

Integration of the preceding comparison gives
$0<W_y(l,x)<(k/l)^\sigma W_y(k,x)$ for every $y>0$, real $x$, and $l>k\ge1$. The weights decay exponentially in $k$ for fixed $x,y$, as follows either from their original radial integral or the exponential Bessel decay. Hence

```math
b_k=k^\sigma W_y(k,x)\downarrow0,\qquad
p_j=\frac{b_j-b_{j+1}}{W_y(1,x)}>0,\qquad \sum_{j\ge1}p_j=1.
```

If $J$ has probabilities $p_j$, its survival is exactly
$\mathbb P(J\ge k)=k^\sigma W_y(k,x)/W_y(1,x)$, and

```math
\frac{\sum_{k\ge1}D_k(x)W_y(k,x)}{W_y(1,x)}
=\mathbb E\sum_{k\le J}D_k(x)k^{-\sigma}.
```

Tonelli applied to absolute values justifies the rearrangement, since $|D_k|\le\tau(k)$ and the radial weights decay exponentially. This is a positive mixture of frequency-dependent arithmetic prefixes, whose signs remain unproved. It neither asserts that each prefix is nonnegative nor permits replacing the $x$-dependent random cutoff by an independent law.
