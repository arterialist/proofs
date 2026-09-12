# Actual delayed inverse pairs after clipping

The exact inverse factors do not force a nonpositive paired contribution after clipping, even after correcting for the changing Farey weights. This fails on the actual order-19 and order-31 roots that acquire a deficit at cutoff 33. Their deficits disappear at 34; their designated inverse factors arrive much later, when both full derivatives are already above one.

The useful result is an exact decomposition into a signed weight correction, a threshold-crossing remainder along the actual intervening trajectory, and a nonpositive scalar term. The positive remainder can be charged to an explicit local threshold potential, but overlapping pending pairs can charge the same intervening event. No bound for that overlap is inferred here.

There is also an important scope restriction. Every completed postbirth prime inverse pair by cutoff $X$ has conductor below $\sqrt X$. The [absolute boundary theorem](angular-height-boundary.md) already covers that range. Thus the sign failure below is a counterexample to the proposed pairing mechanism, not the main remaining estimate at large conductors.

## Full derivatives, actual times, and weights

Fix a prime $\ell$, $1\le a<\ell$, and $\zeta=e^{2\pi ia/\ell}$. For $N\ge\ell$, put

$$
L_N=\log|F_N'(\zeta)|
=\log\bigl(\ell L_{\lfloor N/\ell\rfloor}^{\rm lcm}\bigr)
+\log|U_{\ell,N}(\zeta)|,
\qquad b_N=[-L_N]_+.
$$

Here $L_r^{\rm lcm}=\operatorname{lcm}(1,\ldots,r)$; the distinct notation avoids confusing that scalar with the logarithm $L_N$. All intervening scalar contributions are retained.

Let $w_N$ be the actual Farey spacing weight at $a/\ell$. If $r\equiv a^{-1}\pmod\ell$, $1\le r<\ell$, its neighboring denominators at cutoff $N$ are

$$
b=r+\ell\left\lfloor\frac{N-r}{\ell}\right\rfloor,
\qquad
d=\ell-r+\ell\left\lfloor\frac{N-(\ell-r)}{\ell}\right\rfloor.
$$

They give the exact rational weight

$$
w_N=\frac1{2\ell}\left(\frac1b+\frac1d\right).
\tag{1}
$$

As the actual cutoff increases, the neighbors can only move closer, so $w_N$ is nonincreasing.

Take $k>\ell$ with $\ell\nmid k$. The root already exists before cutoff $k$, so both events are old-root updates. Set

$$
v=\log|\Phi_k(\zeta)|,
\qquad s=\Lambda(k)\ge0.
$$

The actual full-log increments at times $k$ and $\ell k$ are respectively $v$ and $-v+s$. The latter follows from

$$
\Phi_{\ell k}(\zeta)=\Phi_k(1)/\Phi_k(\zeta),
\qquad \Phi_k(1)=e^{\Lambda(k)}.
$$

Define the actual baseline and actual intervening sum by

$$
x=L_{k-1},\qquad
h=L_{\ell k-1}-L_k
=\sum_{j=k+1}^{\ell k-1}(L_j-L_{j-1}).
$$

In particular $L_k=x+v$, $L_{\ell k-1}=x+v+h$, and $L_{\ell k}=x+h+s$. The intervening quantity includes every update of the actual polynomial product; it is not a free parameter in the numerical or certified examples below.

## Exact paired contribution

Write $f(x)=[-x]_+$, $D_v(x)=f(x+v)-f(x)$, $w_1=w_k$, and $w_2=w_{\ell k}$. The two-event contribution to the old-root sum is

$$
P=w_1D_v(x)+w_2\bigl[f(x+h+s)-f(x+v+h)\bigr].
$$

Its exact decomposition is

$$
\boxed{P=(w_1-w_2)D_v(x)+w_2R_0+w_2S,}\tag{2}
$$

where

$$
R_0=D_v(x)-D_v(x+h),
\qquad
S=f(x+h+s)-f(x+h)\le0.
$$

The first term is the signed weight correction. If $v<0$, the first update increases the deficit and this correction is nonnegative. If $v>0$, it is nonpositive. It should not be assigned a sign independent of $v$.

The weight-corrected remainder is

$$
\mathcal R=P-(w_1-w_2)D_v(x)=w_2(R_0+S).
\tag{3}
$$

The scalar increment helps only through $S$. If both relevant arguments are already nonnegative, it contributes zero after clipping even when $s>0$.

For fixed $v>0$, $D_v(x)$ is increasing in $x$; for $v<0$, it is decreasing. Its range has width $|v|$ and it is one-Lipschitz. Therefore

$$
|R_0|\le\min(|v|,|h|),
\qquad vh\ge0\Longrightarrow R_0\le0.
$$

In particular the following conditional candidate is proved with all its assumptions:

$$
\boxed{k>\ell,\ \ell\nmid k,\ vh\ge0
\quad\Longrightarrow\quad\mathcal R\le0.}\tag{4}
$$

The unconditional version of (4), obtained by dropping the condition on the actual intervening drift, is false. In general one has only

$$
[\mathcal R]_+
\le w_2\min(|v|,|h|)\mathbf1_{vh<0}.
\tag{5}
$$

## A local threshold potential

The exact interleaving remainder can be expressed directly along the full-log trajectory. Define

$$
\Psi_v(L)=f(L)-f(L-v).
$$

Then

$$
R_0=\Psi_v(L_k)-\Psi_v(L_{\ell k-1})
=\sum_{j=k+1}^{\ell k-1}
\bigl[\Psi_v(L_{j-1})-\Psi_v(L_j)\bigr].
\tag{6}
$$

Away from its two corners, $\Psi_v'(L)=\operatorname{sgn}(v)$ on the interval between zero and $v$, and is zero outside that interval. Thus only crossings of this particular threshold interval contribute. Equation (6) gives the rigorous local charging bound

$$
[\mathcal R]_+
\le w_2\sum_{j=k+1}^{\ell k-1}
\bigl[\Psi_v(L_{j-1})-\Psi_v(L_j)\bigr]_+.
\tag{7}
$$

For $v<0$, this potential has a simple interpretation:

$$
\Psi_v(L)=\min(-v,[-L]_+).
$$

Hence the positive corrected pair remainder is bounded by the intervening loss of this capped actual deficit. In particular,

$$
[\mathcal R]_+
\le w_2\sum_{j=k+1}^{\ell k-1}[b_{j-1}-b_j]_+.
\tag{8}
$$

For $v>0$, the threshold interval lies above zero. It is possible for the local potential to change while the ordinary deficit remains zero. The full potential in (7), rather than only $b_N$, is therefore the uniform statement.

The exact Farey weights also give a modest contraction for the first-event part. At time $\ell k$, each neighboring denominator is at least $\ell(k-1)+1$, while the corresponding denominator at $k$ is at most $k$. Since $k>\ell$, the former is at least $(\ell-1)$ times the latter. Consequently

$$
w_2\le\frac{w_1}{\ell-1}.
$$

If $v<0$, the second full increment $-v+s$ is nonnegative, so its clipped change is nonpositive. Thus

$$
[\mathcal R]_+\le w_2D_v(x)
\le\frac{w_1}{\ell-1}D_v(x).
\tag{9}
$$

These are conditional or charged estimates, not a bound for a cumulative sum of positive remainders. Different pending pairs can charge the same recovery or threshold crossing in (7). The potential's bounded endpoint range does not bound its cumulative positive variation without further information. Conversely, negative remainders belonging to other pairs may cancel the positive ones. The counterexamples below do not exclude that further cancellation.

## Certified actual pairs

Every interval in the following table has rational decimal endpoints, rather than floating-point error bars. The checker derives them independently from the exact finite Mertens expression for the full derivative.

| Root | Time | Certified interval for $\log|F_N'|$ |
|---|---:|---|
| $8/19$ | 32 | $(0.549622459,0.549622460)$ |
| $8/19$ | 33 | $(-0.211423700,-0.211423699)$ |
| $8/19$ | 34 | $(1.064662189,1.064662190)$ |
| $8/19$ | 626 | $(36.936724728,36.936724729)$ |
| $8/19$ | 627 | $(37.697770887,37.697770888)$ |
| $13/31$ | 32 | $(0.366934284,0.366934285)$ |
| $13/31$ | 33 | $(-0.002354129,-0.002354128)$ |
| $13/31$ | 34 | $(1.296818439,1.296818440)$ |
| $13/31$ | 1022 | $(40.745390707,40.745390708)$ |
| $13/31$ | 1023 | $(41.114679120,41.114679121)$ |
| $11/29$ | 52 | $(0.976556290,0.976556291)$ |
| $11/29$ | 53 | $(-0.091391497,-0.091391496)$ |
| $11/29$ | 54 | $(0.906926809,0.906926810)$ |
| $11/29$ | 1536 | $(61.462519242,61.462519243)$ |
| $11/29$ | 1537 | $(66.500758942,66.500758943)$ |

For $\ell=19,a=8,k=33$, the first deficit increment is $-L_{33}>0.211423699$, while the second increment at 627 is zero. Here $s=\Lambda(33)=0$, and the exact weights are

$$
w_{33}=\frac3{1612},\qquad w_{627}=\frac{13}{152520}.
$$

Therefore the positive weight-corrected remainder is exactly

$$
\mathcal R=w_{627}(-L_{33})
>\frac{13}{152520}\frac{211423699}{10^9}>0.
$$

The full paired contribution is $w_{33}(-L_{33})$, approximately $0.0003934684234$. The deficit has already disappeared at 34. The inverse at 627 acts entirely above the clipping threshold and cannot remove it a second time.

For $\ell=31,a=13,k=33$, the same pattern gives a corrected remainder $w_{1023}(-L_{33})>0$, with

$$
w_{33}=\frac1{456},\qquad w_{1023}=\frac{65}{2030088}.
$$

The order-29 root $11/29$ is the prime-conductor old neighbor involved in the birth-50 certificate. Its pair $k=53$, $\ell k=1537$, has $s=\log53>0$, but both logs at the second event are positive, so the scalar still makes no clipped contribution. Again the corrected remainder is strictly positive. The weights are $w_{53}=3/3700$, $w_{1537}=105/4635928$.

The other old neighbor in the birth-50 certificate has conductor 21. The prime-sector inverse identity does not apply to it with $\ell=21$. Replacing the prime by a composite index would require a different multi-factor relation; this note does not treat its prime factors as substitutes for the actual order-21 root.

## Birth inventory and the large-conductor scope

If $2\le k<\ell$, the factor at $k$ predates the root's birth. It contributes to the joint initial value

$$
L_\ell=\log\ell+\sum_{k=2}^{\ell-1}\log|\Phi_k(\zeta)|,
$$

but it is not an old-root event with a weight $w_k$. Its later inverse is a boundary-inventory update. Because clipping is nonlinear, one cannot allocate the initial deficit independently among these prebirth factors and apply (2) to fictitious first events.

At a finite horizon $X$, the old updates partition into completed postbirth pairs, pending first events, inverses of prebirth factors, and indices divisible by $\ell^2$. The latter contribute only nonnegative full scalar increments: $\Phi_{\ell^2r}(\zeta)=\Phi_{\ell r}(1)=e^{\Lambda(\ell r)}$. Their deficit changes are therefore nonpositive. A pairing argument must retain the first three classes rather than discarding unfinished or prebirth contributions.

For every completed postbirth pair,

$$
\ell<k,\qquad \ell k\le X
\quad\Longrightarrow\quad \ell^2<X.
$$

Thus all such pairs lie in the low-conductor range. In particular, the established estimate

$$
T_X(Y)\le2Y\log X\,H_X(1+H_X)
$$

for the total absolute old-root contribution restricted to conductors $n\le Y$, proved in [the angular-height boundary theorem](angular-height-boundary.md), when taken at $Y=\lfloor\sqrt X\rfloor$, already controls their actual contributions at a square-root scale up to logarithms. This note does not reprove that separate estimate. The per-pair sign failure does not challenge it.

Conversely, if $\ell>\sqrt X$, every inverse event $\ell k\le X$ has $k<\ell$ and therefore comes from prebirth inventory. No postbirth inverse pair completes in that range. Every postbirth first event $k>\ell$ with $\ell\nmid k$ is still pending at $X$. This is the relevant scope for further large-conductor work; the completed-pair mechanism cannot by itself settle that range.

## Verification

The [standalone rational certificate](certificates/cyclotomic_old_inverse_pairs.py) verifies the three displayed actual pairs. It uses only the Python standard library and does not search for pairs.

The three displayed pairs are separately certified with rational interval arithmetic. The certificate uses

$$
\log|F_N'(\zeta)|
=\log\bigl(\ell L_{\lfloor N/\ell\rfloor}^{\rm lcm}\bigr)
+\sum_{\substack{d\le N\\\ell\nmid d}}
M(\lfloor N/d\rfloor)\log\bigl(2|\sin(\pi ad/\ell)|\bigr).
$$

The Möbius values, cutoff exponents, and scalar integers are exact. Bounds for $\pi$ follow from Machin's identity and alternating arctangent sums. Alternating sine bounds and a positive-series logarithm expansion with an explicit geometric remainder then enclose the finite sum. All arithmetic in the sign certificates is rational; no floating-point approximation is used to establish the displayed inequalities.

The polynomial identities and the value $\Phi_k(1)=e^{\Lambda(k)}$ are classical; see [Bzdęga, Herrera-Poyatos and Moree, Lemmas 2 and 4](https://archive.mpim-bonn.mpg.de/1705/1/preprint_2016_45.pdf). The threshold-potential argument is elementary and is proved here for the exact weighted histories. It is a written result with rational certificates, not a Lean theorem. The [adjacent-parent correction](cyclotomic-adjacent-history-correction.md) concerns a different pairing and retains its own counterexample.
