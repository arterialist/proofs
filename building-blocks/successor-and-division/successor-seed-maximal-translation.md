# Global maximal translation bounds for the complete successor seed

This written proof uses the complete [successor seed](collective-successor-seed-long-memory.md) and its exact prime-power jumps. It supplies uniform maximal-shift estimates for the [compensated memory kernel](charge-compensated-successor-memory.md). The arithmetic input is the classical quantitative PNT, for example Trudgian, [*Updating the error term in the prime number theorem*, Theorem 1](https://arxiv.org/pdf/1401.2689). No theorem in this chapter is formalized in Lean.

Extend every function by zero to negative age and use the actual right-continuous representatives

$$
 B_p(v)=e^{v/2}p^{-\lfloor v/\log p\rfloor-1}\mathbf1_{v\ge\log p},\quad
 B_P=\sum_{p\le P}B_p,\quad B=\sum_pB_p,\quad R_P=B-B_P.
$$

Let tau_L f(v)=f(v-L). For h>0 define the one-sided and two-sided maximal moduli

$$
 M_h(f)=\int_{\mathbb R}\sup_{0\le r\le h}|f(v+r)-f(v)|dv,
 \qquad M_h^{\pm}(f)=\int_{\mathbb R}\sup_{|r|\le h}|f(v+r)-f(v)|dv.
$$

Local finite sums make these seeds right-continuous and locally of bounded variation. The suprema are measurable: they can be taken over rational interior shifts together with the endpoints, using right continuity. Thus their definition retains the actual jump values, including births and exact prime-power endpoints.

**Theorem.** There is an absolute constant C such that, for 0<h<=1,

$$
 \boxed{M_h(f)+M_h^{\pm}(f)
 \le Ch[1+\log\log(e/h)]}
 \tag{1}
$$

for f=B, for every B_P, and for every R_P, uniformly in P>=2. For 0<h<=e^{-1} this is the requested O(h[1+log log(1/h)]) bound. Furthermore, uniformly P and L>=0,

$$
 \boxed{\|\tau_LB_P-B_P\|_1+\|\tau_LB-B\|_1
 +\|\tau_LR_P-R_P\|_1\le C\log(2+L).}
 \tag{2}
$$

The completed B, unlike its finite cutoffs, has the sharper large-shift asymptotic

$$
 \|\tau_LB-B\|_1=4\log(1+L)+O(1).
 \tag{3}
$$

For A=log P sufficiently large,

$$
 \boxed{M_1^{\pm}(R_P)\le C/A.}
 \tag{4}
$$

The proof uses the classical quantitative PNT plus exact jump formulas. It does not assert that the distributional derivative of B is globally in L1 or has finite total variation.

## 1. Exact finite-age variation

Between consecutive jumps, B_p'=B_p/2. Its integral is exactly 2/p, so this continuous part has variation 1/p. At v=log p the upward birth has mass p^{-3/2}. At v=k log p, k>=2, the left and right values are respectively p^{-k/2} and p^{-k/2-1}; hence the jump is

$$
 -(1-p^{-1})p^{-k/2}.
$$

There is no jump at zero. Summing all the negative jumps gives 1/p+1/p^{3/2}. Consequently the exact total variation of one full prime history is

$$
 \boxed{\operatorname{TV}(B_p)=2/p+2/p^{3/2}.}
 \tag{5}
$$

On any age interval ending at V, only primes p<=e^V can contribute. Thus, by the elementary Mertens upper bound from Chebyshev,

$$
 |Df|(( -\infty,V])\le C[1+\log(2+V)]
 \tag{6}
$$

for all three families f in the theorem, uniformly in P. This is a bound on the variation measure of the untruncated function, not an added artificial jump at V. Possible cancellation between different prime derivatives only lowers the variation.

For v<=V, right continuity gives

$$
 \sup_{0\le r\le h}|f(v+r)-f(v)|\le |Df|((v,v+h]).
$$

Tonelli therefore bounds its integral over this region by h times the variation through V+h. For the two-sided supremum use |Df|((v-h,v+h]), with interval length 2h. These bounds retain every jump endpoint.

## 2. A smooth main term uniform in the prime cutoff

Fix a smooth cutoff chi that vanishes for v<=1 and equals one for v>=3, with 0<=chi<=1. Define

$$
 b(v)=\chi(v)e^{v/2}\int_{e^{v/2}}^{e^v}\frac{dx}{x^2\log x},
$$

and

$$
 b_P(v)=\chi(v)e^{v/2}
 \int_{e^{v/2}}^{\min(e^v,P)}\frac{dx}{x^2\log x},
 \tag{7}
$$

where the second integral is zero if its upper endpoint is no larger than its lower endpoint. Both functions are zero for negative v. They satisfy 0<=b_P<=b and are bounded uniformly on compact ages.

Uniformly in P, the exact floor-equals-one part of B_P is

$$
 e^{v/2}\sum_{e^{v/2}<p\le\min(e^v,P)}p^{-2}.
$$

Its open lower endpoint is essential: a prime equal to e^{v/2} belongs to the next floor sector. Stieltjes partial summation against theta(x)-x, using theta(x)=x+O(x exp(-c sqrt(log x))), bounds its difference from (7) by C exp(-c_1 sqrt v) for v>=3. Indeed both endpoints lie at least at e^{v/2}; after multiplication by e^{v/2}, each endpoint and the integrated error are bounded by a constant times v^{-1}exp(-c sqrt(v/2)). This is uniform even when the upper endpoint is P. If the interval is empty, both contributions are zero.

All higher floor sectors are bounded by their positive full-prime sum, which the [exact sector estimate](collective-successor-seed-long-memory.md), equation (5), bounds by

$$
 Cv e^{-v/2}+C(1+\log v)e^{-v/6}.
$$

It follows that

$$
 |B(v)-b(v)|+|B_P(v)-b_P(v)|\le Ce^{-c_2\sqrt v},\qquad v\ge3,
 \tag{8}
$$

uniformly in P. The same estimate holds for the difference of these two errors. On [0,3] all errors have uniformly bounded L1 norm.

The smooth main terms have uniform late-age variation. Without chi, write

$$
 b(v)=\int_0^{v/2}\frac{e^{-w}}{v/2+w}dw\le\frac2v.
$$

For v>=3,

$$
 b'(v)=\frac{e^{-v/2}}{2v}
 -\frac12\int_0^{v/2}\frac{e^{-w}}{(v/2+w)^2}dw\le0,
$$

since (v+1)e^{-v/2}<=1 there. Put A=log P. On v<A, b_P=b. On A<v<2A, wherever v>=3,

$$
 b_P'(v)=\frac12b_P(v)-\frac1v\le0,
$$

and b_P=0 on v>=2A. The joins at A and 2A are continuous. Thus b_P is nonnegative and nonincreasing for v>=3, and

$$
 \operatorname{TV}(b;[V,\infty))+
 \operatorname{TV}(b_P;[V,\infty))\le C/V,\qquad V\ge3.
 \tag{9}
$$

The difference b-b_P satisfies the same variation bound by the triangle inequality. This estimate retains the changing finite-P endpoint; simply replacing b_P by b would not prove uniform cutoff control.

## 3. The global supremum over small shifts

Split the modulus at a large V. The part v<=V is bounded by

$$
 Ch[1+\log(2+V+h)]
$$

from (6). On v>V, apply (9) to the smooth part and the pointwise estimate (8) to the error and to every shifted error. This gives

$$
 M_h(f)\le Ch[1+\log(2+V+h)]+Ch/V
 +C(1+\sqrt V)e^{-c_3\sqrt V}.
 \tag{10}
$$

For the two-sided modulus, take V>=4 and h<=1; shifts to the left change only absolute constants in (8)-(10). Choose

$$
 V=\max\{V_0,[4c_3^{-1}\log(e/h)]^2\}.
$$

The exponential tail is O(h), while log(2+V+h)<=C[1+log log(e/h)]. This proves (1), globally in v and uniformly for the finite cutoffs and their remainders. A fixed-shift L1 estimate alone would not justify this supremum; the variation and pointwise estimates are what do so.

## 4. Uniform large shifts and the sharper cutoff tail

Replace b_P on [0,3] by the constant b_P(3), leaving it unchanged above 3 and zero below zero. Call the resulting nonnegative decreasing function tilde b_P. It is bounded by C/(1+v) on v>=0, and

$$
 \sup_P\|B_P-\widetilde b_P\|_1<\infty
$$

by (8) and the bounded initial interval. A nonnegative decreasing causal function d tending to zero satisfies

$$
 \|\tau_Ld-d\|_1=2\int_0^L d(v)dv,
$$

even if d is not integrable. This follows by its signs on [0,L] and [L,infinity), taking a finite upper limit and then passing to infinity. Hence the B_P bound in (2) follows. The same argument gives the bound for B; their difference gives it for R_P.

For the sharper assertion about B alone, use beta(v)=2/(1+v) on v>=0 and zero otherwise. The [proved two-term seed tail](collective-successor-seed-long-memory.md) gives B-beta in L1. Since ||tau_L beta-beta||_1=4 log(1+L), the difference between this norm and ||tau_L B-B||_1 is at most 2||B-beta||_1. This proves (3).

Now assume A=log P>=3. The tail R_P and its smooth part c_P=b-b_P vanish identically for v<=A. There is no endpoint atom in c_P at A. Equation (9) gives

$$
 \operatorname{TV}(c_P;\mathbb R)\le C/A.
$$

The error e_P=R_P-c_P also vanishes below A and, by (8), is bounded by C exp(-c sqrt v) above it. Thus

$$
 \|e_P\|_1\le C(1+\sqrt A)e^{-c\sqrt A}.
$$

The same pointwise estimate handles its maximal unit shifts: only v>=A-1 can contribute, and every nonzero shifted error is bounded by the exponential envelope. Therefore

$$
 M_1^{\pm}(R_P)\le C/A+C(1+\sqrt A)e^{-c'\sqrt A}\le C/A,
$$

after increasing the constant. This proves (4). Also, for every L>=0,

$$
 \|\tau_LR_P-R_P\|_1\le CL/A+C(1+\sqrt A)e^{-c\sqrt A}.
 \tag{11}
$$

Equation (11) is useful in exponentially weighted averages; equation (2) remains the stronger uniform logarithmic bound for very large L.

## 5. The exponential boundary seed and its mass cancellation

Use the causal definitions of the [compensated-kernel construction](charge-compensated-successor-memory.md):

$$
 a_0(v)=e^{-v/2}\mathbf1_{v\ge0},\qquad Kf=B*f,
 \qquad q=Ka_0,\qquad q_P=B_P*a_0.
$$

Since a_0/2 has integral one, pointwise convolution gives

$$
 \frac q2-B=\frac12\int_0^\infty e^{-w/2}(\tau_wB-B)dw.
 \tag{12}
$$

The right side is a Bochner L1 integral by (2). Thus q/2-B belongs to L1 despite B itself not belonging to L1. The same bounds give uniformly bounded L1 norms for q_P/2-B_P. Applying (11) in (12) to R_P proves

$$
 \boxed{\left\|\frac{q-q_P}{2}-(B-B_P)\right\|_1\le C/\log P.}
 \tag{13}
$$

For each fixed w, the signed integral of tau_w B-B is zero. To see this, integrate up to R>w: the result is -integral_{R-w}^R B, which tends to zero by the bound B(v)<=C/(1+v). The L1 convergence already proved justifies this limit. Fubini in (12) then gives the exact mass cancellation

$$
 \boxed{\int_{\mathbb R}(q/2-B)=0.}
$$

As a check retaining the next tail coefficient, exponential averaging of B(v)=2/v-4/v^2+O(v^{-3}) gives q(v)/2=2/v+O(v^{-3}), hence q(v)/2-B(v)=4/v^2+O(v^{-3}). Split the average at w=v/2 to justify this uniformly; the complementary part is exponentially small because B is bounded.

These are maximal seed-modulus and L1 difference theorems. They supply the variable-shift and endpoint cancellation inputs for the compensated operator, without asserting an L1 bound for the full distributional derivative readout.
