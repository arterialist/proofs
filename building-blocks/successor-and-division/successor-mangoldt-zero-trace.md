# The successor prime-power source has a sparse zero trace

**Status:** unconditional written analytic consequence of Gonek's
uniform Landau formula, 18 September 2026. The exact adjacent
prime-power support is compiled in
[SuccessorMangoldtParity.lean](../../formalization/BuildingBlocks/SuccessorMangoldtParity.lean);
the analytic zero sum is not Lean-formalized. This is a linear average
over actual zeta zeros, not a bound at each zero or a proof of RH. No
literature-priority claim is made for the application of Gonek's
classical theorem.

Fix `0<w<log 2` and a real nonnegative
`phi in C_c^infinity((0,w))` with `||phi||_2=1`. Write

\[
C_\phi(y)=\int_{\mathbb R}\phi(x+y)\phi(x)\,dx,
\qquad A_\phi=\int C_\phi(y)\,dy
                =\left(\int\phi(x)\,dx\right)^2>0.
\]

Thus `C_phi` is even, nonnegative, smooth, and supported in
`[-w,w]`; its endpoint values are zero. Every occurrence of
`Lambda(p^j)` below equals `log p`, including the proper powers.

Let `X` be large, `H=log X`, fix `0<epsilon<1`, and take
`3<=L<=(1-epsilon)H-w`. The finite inner sum in

\[
\begin{split}
\mathcal T^+_X(L)&=
 \sum_{\substack{\rho=\beta+i\gamma\\X<\gamma\le2X}}
 \sum_{n\ge2}\frac{\Lambda(n+1)}{n}
       C_\phi(\log n-L)n^\rho,\\
\mathcal T^0_X(L)&=
 \sum_{\substack{\rho=\beta+i\gamma\\X<\gamma\le2X}}
 \sum_{n\ge2}\frac{\Lambda(n)}{n}
       C_\phi(\log n-L)n^\rho
\end{split}                                                   \tag{1}
\]

is supported on the inclusive annulus
`e^(L-w)<=n<=e^(L+w)`. Zeros are counted with multiplicity;
`n^rho=exp(rho log n)` uses the real logarithm.

**Theorem.** Uniformly throughout this range,

\[
\boxed{\quad
\mathcal T^+_X(L)=-\frac{X}{2\pi}D^+_\phi(L)
       +O_{\phi,\epsilon}(e^L H\log H),\qquad
0\le D^+_\phi(L)\ll_{\phi,w}(1+L)e^{-L},
\quad}                                                       \tag{2}
\]

where the *exact* successor diagonal is

\[
D^+_\phi(L)=\sum_{n\ge2}
 \frac{\Lambda(n)\Lambda(n+1)}n C_\phi(\log n-L).
\]

In particular,

\[
|\mathcal T^+_X(L)|
 \ll_{\phi,\epsilon}X(1+L)e^{-L}+e^L H\log H.       \tag{3}
\]

For `L=H/2` and any fixed `epsilon<1/2`, this is
`O_phi,epsilon(X^(1/2) log X loglog X)`.
By contrast, uniformly whenever `L->infinity` in the same range,

\[
\boxed{\quad
\mathcal T^0_X(L)
 =-\frac{X}{2\pi}\bigl(A_\phi L+o_\phi(L)\bigr)
    +O_{\phi,\epsilon}(e^L H\log H)
 \sim-\frac{X}{2\pi}A_\phi L.
\quad}                                                       \tag{4}
\]

Whenever `L->infinity` in the stated range, the `+1` clock gives a
vanishing normalized zero trace:
`T_X^+(L)=o(XL)`, while `T_X^0(L)` has a strictly negative main
term of order `XL`. This comparison holds without RH.

## Complete zero formula and its uniform error

The integer case of [Gonek's uniform Landau formula, Theorem 1](https://www.sas.rochester.edu/mth/people/faculty/gonek-steve/assets/pdf/8-landau-form.pdf)
states, unconditionally and uniformly for integers `2<=n<=T`,

\[
\sum_{0<\gamma\le T}n^\rho
 =-\frac{T}{2\pi}\Lambda(n)
  +O\bigl(n\log(2T)\log\log(3T)\bigr).             \tag{5}
\]

Subtract (5) at `T=X` from its value at `T=2X`; this keeps the
half-open zero-height endpoint in (1). The annulus condition gives
`n<=e^(L+w)<=X^(1-epsilon)<X`, so (5) applies to every integer
in the inner sum. Finite interchange yields both exact diagonals
in (2) and (4). For the successor trace, the absolute error is

\[
\ll H\log H
 \sum_{e^{L-w}\le n\le e^{L+w}}
       \Lambda(n+1)|C_\phi(\log n-L)|
 \ll_\phi e^L H\log H,                                \tag{6}
\]

using Chebyshev's unconditional `psi(y)<<y`. The unshifted trace
has the same error. No prime-power term is deleted from (5) or
the finite sums; the contour's pole and gamma contributions are
already part of Gonek's complete formula and its stated error.
This linear zero trace is distinct from the quadratic Weil form,
so it makes no claim that the latter has no poles or gamma term.

## The exact successor parity filter

If `Lambda(n)Lambda(n+1)` is nonzero, both neighbors are prime
powers. One is even, and an even prime power is a power of two.
The compiled theorem `adjacent_vonMangoldt_support` proves exactly
this implication for mathlib's actual von Mangoldt function,
including `n=2^k-1` and `n=2^k` endpoints. In the fixed-ratio
annulus there are only `O_w(1)` powers `2^k` that can be either
neighbor. The compiled `vonMangoldt_two_pow` theorem verifies that in
each surviving product one factor is exactly `log 2`,
the other is at most `L+w+O(1)`, and `1/n=O_w(e^(-L))`.
This proves the second inequality in (2). The parity filter does
not assume that either neighboring odd integer is prime: all odd
proper prime powers remain eligible. For example, the adjacent proper
powers `8=2^3` and `9=3^2` contribute `log 2 log 3` to the diagonal.

For the unshifted diagonal, the prime part is
`sum_p (log p)^2 C_phi(log p-L)/p`. Partial summation with the
ordinary prime number theorem `theta(y)~y`, over this fixed-ratio
annulus, gives

\[
\sum_p\frac{(\log p)^2}{p}C_\phi(\log p-L)
 =\int_{-w}^w(L+y)C_\phi(y)\,dy+o(L)
 =A_\phi L+o(L).                                      \tag{7}
\]

The second equality uses evenness of `C_phi`. Prime-square terms
are `O_phi(L^2e^(-L/2))`; all higher proper powers tend to zero
by absolute summability of `sum_p sum_{j>=3}(log p)^2/p^j`.
This proves (4). Its Gonek error is `o(XL)` uniformly because
`e^L<=X^(1-epsilon)`.

The smallness in (3) is a **dyadic average over zeros**. The
error term need not be smaller than the sparse main term, so (2)
does not assert a sign for `T_X^+` itself. A single off-line zero can
coexist with it, and no positivity or negativity is asserted at any
selected ordinate. The gain over the
unshifted trace comes from the actual successor parity and exact
division-to-prime-power support, not from a stronger zero formula.
