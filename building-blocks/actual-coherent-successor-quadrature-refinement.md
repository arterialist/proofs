# Coherent mean removal in the actual successor quadrature

This written proof improves the signed quadrature error after its coherent mean is removed. It uses the [exact lattice identity](actual-coherent-division-lattice-remainder.md), Chebyshev bounds and the actual integer cusp strips. The geometric parameter is $t=-\log r$, not the prime-process time. The constant-scale arithmetic comparison remains unproved.

For integers n>=2 write q_n(u)=q^0(u,n), with

$$
q_n(u)=u^{-1/2}\arcsin\sqrt{u/n}\quad(0<u<n),\qquad
q_n(u)=\frac\pi{2\sqrt u}\quad(u\ge n),\qquad q_n(0)=n^{-1/2}.
$$

Put U_n=q_n-n^{-1/2}, and use the actual complete von Mangoldt coefficients. The existing absolutely convergent readout and endpoint are

$$
Q(t)=t\sum_{n\ge2}\Lambda(n)\int_0^\infty e^{-tu}U_n(u)du,
\qquad
C(t)=(e^t-1)\sum_{j\ge2}e^{-tj}\frac{\arctan(j^{-1/2})}{\sqrt j}\psi(j).
\tag{1}
$$

Thus C is the literal initial-boundary return correction, not a density approximation. All prime powers stay in both sums.

## Exact unit-cell identity

The previously proved weighted variation bound is

$$
\sum_n\Lambda(n)\int_0^\infty e^{-tu}|q_n'(u)|du\le C t^{-1/2},
\quad 0<t\le1.
\tag{2}
$$

It uses only Chebyshev's bound. Also the summed absolute size of U_n(u) is O(sqrt u), and U_n(0)=0. Integration by parts therefore identifies Q with the absolutely convergent sum of integrals of e^(-tu)q_n'. Discrete summation by parts gives, exactly,

$$
(e^t-1)\sum_{j\ge0}e^{-tj}U_n(j)
=\sum_{j\ge0}e^{-tj}\int_j^{j+1}q_n'(u)du.
\tag{3}
$$

Here no origin term survives: it vanishes because U_n(0)=0. The cusp at u=n is integrable, and q_n is locally absolutely continuous. Subtract the integral version of (3), and sum using (2). The original signed remainder satisfies

$$
R(t)=\sum_n\Lambda(n)\int_0^\infty e^{-tu}
\big(e^{t\{u\}}-1\big)q_n'(u)du.
\tag{4}
$$

The endpoints of the unit cells have measure zero. This identity retains their cusp contributions and does not require assigning a derivative value at an integer.

Define

$$
m_t=\frac{e^t-1}{t}-1,\qquad
p_t(v)=e^{tv}-1-m_t\quad(0\le v\le1).
\tag{5}
$$

The function p_t has zero integral on [0,1]. Its periodic primitive

$$
P_t(u)=\int_0^{\{u\}}p_t(v)dv
$$

is continuous, locally absolutely continuous, and vanishes at every integer. For 0<t<=1, both its supremum and the supremum of p_t are at most C t. Consequently

$$
\boxed{R(t)=m_tQ(t)+\epsilon(t),\qquad
\epsilon(t)=\sum_n\Lambda(n)\int_0^\infty
 e^{-tu}p_t(\{u\})q_n'(u)du.}
\tag{6}
$$

## The complete cusp estimate

Keep the actual strip I_n=(n-1,n) without differentiating its singular endpoint. On this strip q_n' is nonnegative and

$$
\int_{n-1}^{n}|q_n'(u)|du=q_n(n)-q_n(n-1)\le C/n.
\tag{7}
$$

For example, expand the difference using arcsin sqrt(1-1/n)=pi/2-arcsin(1/sqrt n); each remaining term is bounded directly by C/n. Thus all cusp strips together contribute at most

$$
Ct\sum_{n\ge2}\frac{\Lambda(n)}n e^{-t(n-1)}
\le Ct\log(2/t).
\tag{8}
$$

The last estimate is ordinary partial summation with psi(x)<=C x, treating n<=1/t and the exponentially weighted tail separately.

On the complement of I_n, integrate by parts with P_t. All finite boundary terms vanish, since 0,n-1,n are integers and P_t vanishes there; on the left component the upper endpoint is n-1, where q_n' is finite, and on the right component q_n'(n+) is finite. There is no integration through the singular n- endpoint. The exponential boundary at infinity is zero. This gives the bound

$$
\left|\int_{[0,\infty)\setminus I_n}
 e^{-tu}p_t(\{u\})q_n'(u)du\right|
\le Ct\int_{[0,\infty)\setminus I_n}e^{-tu}
\big(|q_n''(u)|+t|q_n'(u)|\big)du.
\tag{9}
$$

We spell out the derivative summation. On 0<=u<=n/2 the analytic arcsine expansion gives |q_n''(u)|<=C n^(-5/2). On n/2<=u<n, direct differentiation gives

$$
q_n''(u)=\frac{3\arcsin\sqrt{u/n}}{4u^{5/2}}
-\frac{3}{4u^2\sqrt{n-u}}
+\frac{1}{4u(n-u)^{3/2}}.
\tag{10}
$$

Therefore its integral over [n/2,n-1], when nonempty, is at most C/n, with exponential weight at most e^(-tn/2). On u>n, q_n''=3pi/(8u^(5/2)), whose unweighted integral is O(n^(-3/2)). These bounds show

$$
\sum_n\Lambda(n)\int_{[0,\infty)\setminus I_n}
 e^{-tu}|q_n''(u)|du
\le C\sum_n\frac{\Lambda(n)}{n^{3/2}}
 +C\sum_n\frac{\Lambda(n)}n e^{-tn/2}
\le C\log(2/t).
\tag{11}
$$

The first series converges by Chebyshev. Formula (2) bounds the remaining q_n' contribution in (9), after its additional t factor, by O(sqrt t). Equations (8)--(11) justify all integration and summation operations absolutely, and prove

$$
\boxed{|\epsilon(t)|\le C_1 t\log(2/t)\quad(0<t\le1).}
\tag{12}
$$

The constant is absolute given an explicit Chebyshev constant; no numerical optimization is claimed.

## Actual combined readout

Use the exact identity E(e^(-t))+C(t)=Q(t)+R(t). Then

$$
\boxed{E(e^{-t})+C(t)=\frac{e^t-1}{t}\,Q(t)+\epsilon(t),
\qquad |\epsilon(t)|\le C_1t\log(2/t).}
\tag{13}
$$

This keeps the coherent Q term before taking absolute values. Q is the same complete log-weighted inverse-lattice readout and the same first-cell/contact/B2 expression as in [actual division lattice dual cosine](actual-division-lattice-dual-cosine.md). In particular it is not replaced by its unsigned source norm.

A sufficient unproved arithmetic comparison is now

$$
\frac{e^t-1}{t}Q(t)\ge C(t)+C_1t\log(2/t)
$$

on an entire interval 0<t<t0. The exact sufficient comparison retains epsilon with its sign. The theorem reduces the required error margin; it does not furnish the main constant-scale lower bound on Q. No universal sign of R, epsilon, or their individual birth contributions is asserted.

This chapter contains written analysis, with no Lean claim for the quadrature, dual series or arithmetic comparison. No priority claim is made.

The [integer-birth interpolation refinement](actual-integer-birth-positive-quadrature.md) changes the exact normalization to $b_t=t/(1-e^{-t})$ and proves a strictly positive defect of order $t\log(1/t)$. This does not give a sign to the error with the earlier normalization.

The [complete cusp asymptotic](successor-quadrature-cusp-asymptotic.md) sharpens the correction to $D(t)=\zeta(3/2)t\log(1/t)/(4\pi)+O(t)$ and gives the same leading term for the mean-removed error $\epsilon(t)$. The proof controls every distance cell behind each integer birth uniformly before summing all prime powers. Chebyshev and the factorial identity suffice; the finite-core sign remains open.
