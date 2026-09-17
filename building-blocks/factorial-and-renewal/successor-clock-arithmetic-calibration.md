# Local arithmetic calibration of the positive clock

This written proof refines the [complete seed's logarithmic memory](../successor-and-division/collective-successor-seed-long-memory.md) and the [positive clock's exact Laplace formula](../successor-and-division/positive-successor-seed-jump-process.md). It uses the classical Euler product and Laurent expansion at the pole $1$, with the full prime-power correction retained. There is no Lean or priority claim.

Retain the complete seed $B$ and its exponent $\Phi(s)=\int_0^\infty(1-e^{-sv})B(v)\,dv/v$ on $\Re s>0$. Put

$$
 \mathcal A(s)=(1/2-s)\Phi'(s)
 =\sum_p\frac{R_p(s)}p,\qquad
 R_p(s)=w\frac{w-r}{1-rw},\quad w=p^{-s},\quad r=p^{-1/2}.
$$

The original prime series and its equality with the Laplace derivative are asserted here on Re s>0, where they converge absolutely. The local continuation below does not enlarge that domain of absolute convergence.

## 1. Two normally convergent corrections

Exact algebra gives

$$
 R_p(s)-p^{-2s}
 =\frac{p^{-1/2-s}(p^{-2s}-1)}{1-p^{-1/2-s}}.
$$

Define

$$
 H(s)=\sum_p\sum_{k\ge2}\frac{p^{-k(1+2s)}}k,
 \qquad
 C(s)=\sum_p\frac{p^{-3/2-s}(p^{-2s}-1)}{1-p^{-1/2-s}}.
$$

The first series converges normally on Re s>-1/4. On a compact subset with Re s>=sigma_0>-1/4, sum over k is bounded by a constant times p^{-2-4 sigma_0}; its exponent exceeds 1. Derivatives only insert powers of log p and preserve convergence on smaller compact sets.

The second series converges normally on Re s>-1/6. Its denominator is bounded away from zero on every compact subset of this half-plane. A majorant is a constant times

$$
 p^{-3/2-3\sigma_0}+p^{-3/2-\sigma_0},
 \qquad \sigma_0>-1/6,
$$

and both exponents exceed 1. These bounds retain every proper-power factor, including p=2.

On Re s>0 the absolutely convergent Euler logarithm gives

$$
 \mathcal A(s)=\log\zeta(1+2s)-H(s)+C(s).
 \tag{1}
$$

Here log zeta is the branch given by its Euler series in Re(1+2s)>1. No global logarithm across zeta zeros is assumed.

## 2. The local logarithm and real analytic remainder

The [classical Laurent expansion, DLMF §25.2(i)](https://dlmf.nist.gov/25.2#i), at the simple pole gives

$$
 Z_0(s):=2s\zeta(1+2s)=1+2\gamma s+O(s^2).
$$

Choose epsilon<1/6 so that Z_0 is holomorphic and |Z_0(s)-1|<1/2 on |s|<epsilon. There is then a unique holomorphic logarithm ell(s)=log Z_0(s) on this disk with ell(0)=0. It can be defined by the convergent power series for log(1+(Z_0-1)). Its Taylor coefficients are real, and ell'(0)=2 gamma.

On the right half of this disk, use the principal log s. Agreement on the positive real interval and holomorphy give

$$
 \log\zeta(1+2s)=-\log s-\log2+\ell(s).
$$

Therefore

$$
 \boxed{a(s):=\mathcal A(s)+\log s
 =-\log2+\ell(s)-H(s)+C(s)}
 \tag{2}
$$

extends holomorphically to the whole disk and has real Taylor coefficients. The formula -log s+a(s) specifies a local continuation of A to the disk cut along the nonpositive real axis. It makes no assertion of a global zeta logarithm or of prime-series convergence on Re s<=0.

Let

$$
 R_0=H(0)=\sum_p\sum_{k\ge2}\frac1{kp^k}=\gamma-B_1.
$$

Since C(0)=0, equation (2) gives a(0)=-log2-R_0. Consequently the exact clock identity is

$$
 \boxed{\Phi'(s)=\frac{-2\log s+2a(s)}{1-2s}.}
 \tag{3}
$$

It holds for the original transform on the right half-disk and for its local continuation on the slit disk. In particular,

$$
 \boxed{C_B=2a(0)=-2\log2-2R_0
 =2B_1-2\gamma-2\log2.}
 \tag{4}
$$

This calibrates the full-seed constant derived previously by convergent real integrals. An equivalent exact sum rule is

$$
 \int_0^\infty\left(B(v)-\frac2{1+v}\right)dv
 =2(B_1-\log2).
$$

## 3. The first regular derivative

Differentiate only the normally convergent correction series at zero. One has

$$
 H'(0)=-2\sum_p\frac{\log p}{p(p-1)}.
$$

At w=1, differentiation of w(w-r)/(1-rw) gives derivative 2/(1-r) with respect to w. Since w'(0)=-log p,

$$
 R_p'(0)=-\frac{2\log p}{1-p^{-1/2}},\qquad
 C'(0)=-2\sum_p\frac{\log p}{p(\sqrt p-1)}.
$$

Thus

$$
 \begin{aligned}
 a'(0)&=2\gamma-H'(0)+C'(0)\\
 &=\boxed{2\gamma-2\sum_p\frac{\log p}{\sqrt p(p-1)}.}
 \end{aligned}
 \tag{5}
$$

All sums in this computation converge absolutely. The derivative of the original A at zero is singular; (5) is the derivative of the regular part, not a termwise derivative of that singular prime series.

If D_B denotes the coefficient of s after removal of -2 log s and -4s log s in Phi', then (3) also gives

$$
 D_B=4a(0)+2a'(0)
 =4\left[B_1-\log2-\sum_p\frac{\log p}{\sqrt p(p-1)}\right].
$$

This gives the regular linear coefficient while retaining the singular logarithmic terms separately.

## 4. Exact cancellation in the original boundary response

Equation (3) fixes every logarithmic term, not just the first two:

$$
 \Phi'(s)=-\frac{2\log s}{1-2s}+\frac{2a(s)}{1-2s}.
$$

Hence the logarithmic Taylor coefficients are exactly -2^{n+1}s^n log s, for n>=0, while the second term is holomorphic near zero.

The original centered boundary response remains

$$
 G_{\rm boundary}(t)=-\operatorname{Re}[(1+2it)\Phi'(-it)]
 =-2\operatorname{Re}\mathcal A(-it).
$$

The [proved imaginary-axis boundary identity](../successor-and-division/positive-successor-seed-jump-process.md), equation (9), agrees with this local continuation. For 0<|t|<epsilon,

$$
 \boxed{G_{\rm boundary}(t)=2\log|t|-2\operatorname{Re}a(-it).}
 \tag{6}
$$

Because a has real Taylor coefficients, the remainder after 2 log|t| is real analytic and even in t. If a(s)=sum a_n s^n, its series is

$$
 -2a_0+2a_2t^2-2a_4t^4+\cdots.
$$

Thus all additional logarithmic and absolute-value terms cancel in the actual response, to every order. The constant is -C_B, as in the lower-order expansion. This is an exact local arithmetic calibration; it does not identify the bounded positive convolution semigroup with the original heat or assert anything across nontrivial zeta zeros.
