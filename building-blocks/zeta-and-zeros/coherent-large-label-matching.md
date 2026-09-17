# Actual label proximity and time-dependent matching costs

The original prime-to-two-primes graph cannot satisfy the proposed all-epsilon coarse-primitive cost bound. The obstruction already applies to its pointwise minimum over all partial matchings, so choosing a matching separately at every time does not fix it. For every fixed integer k at least 5, an actual family of squarefree labels gives a corrected squared cost at least a constant times X^(5-4/k)/(log X)^(2k). These are unconditional written consequences of the prime number theorem and the exact observable formulas. They do not lower-bound the signed error primitive or contradict RH.

A finite repair does work locally. At X=128, the three-edge path 210,222,185,211 replaces an unavoidable cost of at least 12 H(1) at label 210 by a uniform endpoint cost H(1). The certificate compares fixed matchings on this enlarged graph with the full original graph and with observable-distance thresholds. A bounded number of factor deletions, with the same endpoint ratio restriction, still has the asymptotic obstruction. Unbounded moves and unrestricted endpoint ratios remain outside the theorem.

## 1. Actual source, graph, and complete corrected cost

Use the actual source and integrated observables from the [integrated-divisor theorem](../prime-history/integrated-divisor-history.md). The graph below retains every permitted prime substitution.

Let X be a positive integer and N=2X-1. Put

$$
H(q)=\log(q!)-\sum_{d\le q}\lfloor q/d\rfloor+2\gamma q,
 \quad H(0)=0,\quad b(r)=\log r-\tau(r)+2\gamma,
$$
$$
A(y)=\int_0^y H(\lfloor u\rfloor)\,du
     =\sum_{r\le y}(y-r)b(r),
$$
$$
v_n(t)=n[A(t/n)-A(X/n)],\qquad
 u_n(t)=n[A(2X/n)-A(t/n)]. \tag{L1}
$$

Every vertex is an actual squarefree integer n between 1 and N. Its side is its actual Möbius sign. An original edge has endpoints apr and aq, where p,r,q are three distinct primes and a is squarefree and coprime to prq, with endpoint ratio in [1/2,2]. Equivalently, after division by the gcd, the endpoints are a prime and a product of two distinct primes. All cross-range edges remain available. Squareful labels have coefficient zero in the inverse and are omitted exactly. The source H retains all divisor and prime-power contributions.

For a partial matching M and a real observable vector f define

$$
c_M(f)=\sum_{n\text{ unmatched}}|f_n|
             +\sum_{\{n,m\}\in M}|f_n-f_m|,
 \qquad C(f)=\min_M c_M(f). \tag{L2}
$$

C0(f) is the same minimum on the complete opposite-sign bipartite graph and Gamma(f)=C(f)-C0(f). No cancellation between different matched pairs remains in these costs. In contrast, each pair's signed difference is formed before its absolute value.

Set

$$
d_X(t)=\int_X^t(2\gamma+\{x\})\,dx,\qquad
 D_X=(2\gamma+1/2)X.
$$

For e(x)=psi(x)-x and P_X(t)=integral from X to t of e(x), R_X(t)=integral from t to 2X of e(x), the exact inverse gives

$$
\sum_n\mu(n)v_n(t)=P_X(t)+d_X(t),\qquad
 \sum_n\mu(n)u_n(t)=R_X(t)+D_X-d_X(t). \tag{L3}
$$

Indeed the inverse equals psi(x)-floor(x)+2 gamma away from integer endpoints. At those endpoints, integration has the same value. The unused label 2X also contributes only on a set of measure zero and has zero primitive on this interval. Define

$$
\mathcal K_X=\int_X^{2X}\{[C(v(t))+d_X(t)]^2
                 +[C(u(t))+D_X-d_X(t)]^2\}\,dt. \tag{L4}
$$

The matching proposal asks for K_X much less than X^(4+epsilon) for every epsilon>0, possibly by producing one fixed M_X usable in both slots. L3 makes this sufficient for the signed coarse-primitive criterion. The converse is not asserted. Both correction terms in L4 are nonnegative. They will remain present in the lower bound and in the finite integration.

## 2. A genuine bound by additive label proximity

This construction supplies a quantitative edge test before testing whether enough cheap edges exist. Let

$$
B_Q=\sum_{r\le Q}r b(r)=QH(Q)-\sum_{q=0}^{Q-1}H(q),\qquad B_0=0.
$$

For fixed y, the function s A(y/s) is continuous and piecewise affine in s, and its derivative is -B_floor(y/s) except at its finitely many breakpoints on each compact positive s interval. Therefore

$$
v_n(t)-v_m(t)=-\int_m^n
 [B_{\lfloor t/s\rfloor}-B_{\lfloor X/s\rfloor}]\,ds, \tag{L5}
$$

and the suffix formula replaces t,X by 2X,t. These identities use the actual b(r); no probabilistic hypothesis is involved.

Define the uniform distance

$$
\mathscr D_X(n,m)=\sup_{X\le t\le2X}
       \max(|v_n(t)-v_m(t)|,|u_n(t)-u_m(t)|).
$$

Write q_-=floor(X/max(n,m)), q_+=floor(2X/min(n,m)), and let Omega be the range of B_q over all integers q between q_- and q_+. L5 proves

$$
\mathscr D_X(n,m)\le |n-m|\,\Omega.
 \tag{L6}
$$

The formal [elementary divisor bound](../../formalization/BuildingBlocks/DivisorForcingBound.lean), `centeredDivisorForcing_sqrt_bound`, gives |H(q)|<=13 sqrt(q) gives |B_Q|<=(65/3) Q^(3/2), since the sum of sqrt(q) for q=0,...,Q-1 is at most (2/3) Q^(3/2). In particular

$$
\mathscr D_X(n,m)\le\frac{130}{3}|n-m|
                 (2X/\min(n,m))^{3/2}. \tag{L7}
$$

This gives a concrete cheap graph by retaining exactly the original edges with D_X(n,m)<=eta. The exact distance is more informative than L7 and is easy to certify in a finite interval: v and u are affine on each unit time cell, so their absolute differences attain their maxima at integer cell endpoints. Small labels n<=floor(sqrt X) may still be left unmatched. The [integrated-divisor estimate](../prime-history/integrated-divisor-history.md) A(y)=a y+O(y^(3/4)) gives |v_n|+|u_n|=O(X), so their own squared integrated cost is O(X^4). None of these facts guarantees cheap neighbors for the other labels.

## 3. Many actual labels with no cheap permitted neighbor

Fix constants

$$
3/2<\alpha<\beta<t_0<2,
$$

and an integer k>=5. For definiteness one may take alpha=13/8, beta=7/4, t0=15/8. Let S_X consist of products of k distinct primes, all taken from

$$
[ (\alpha X)^{1/k},(\beta X)^{1/k}]. \tag{L8}
$$

Every such label is in [alpha X,beta X], is squarefree, and has Möbius sign (-1)^k. If M_X denotes the number of available primes, the unconditional prime number theorem gives

$$
M_X\sim k(\beta^{1/k}-\alpha^{1/k})\frac{X^{1/k}}{\log X},
 \qquad |S_X|=\binom{M_X}{k}\gg_{k,\alpha,\beta}\frac{X}{(\log X)^k}. \tag{L9}
$$

Unique factorization proves the exact binomial count. The constants are fixed before X tends to infinity. This is a statement for all sufficiently large X, so in particular for every sufficiently large dyadic X. No assertion about primes in a shrinking relative interval is needed.

For n in S_X and any original neighbor m, the gcd a retains at least k-2 of n's source factors. Since n and m are distinct multiples of a,

$$
|n-m|\ge a\ge L_X:=(\alpha X)^{1-2/k}. \tag{L10}
$$

This includes the orientation where n contributes the lone reduced prime, which actually retains k-1 factors. It also includes every head-tail edge in the graph. Integer distances, rather than ratios alone, give L10.

Let h1=H(1)=2 gamma-1>0 and h2=H(2)=log 2+4 gamma-3>0. The constant enclosures in the finite certificate verify h1>0.1544 and h2>0.0019. For t in [t0 X,2X] a label n in S_X is active and terminal, so

$$
v_n(t)=h1(t-n)\ge h1(t_0-\beta)X. \tag{L11}
$$

If a neighbor m is terminal and m<=t, then |v_n-v_m|=h1|n-m|>=h1 L_X. If it is terminal and m>t, its prefix is zero, so L11 is the lower bound for the edge.

The remaining case m<X cannot be discarded. The ratio restriction gives m>=n/2>3X/4, hence only the cells H(1),H(2) occur in its integral. Its exact prefix is

$$
v_m(t)=h1(t-X)+(h2-h1)(t-2m)_+.
$$

As n<=2m, for t<=2m the difference v_m-v_n is h1(n-X). For t>=2m, positivity of h2 gives

$$
\begin{aligned}
 v_m(t)-v_n(t)
 &=h1(n-X)+(h2-h1)(t-2m)\\
 &\ge h1(n+2m-X-t)\\
 &\ge h1(2n-3X)\ge h1(2\alpha-3)X.
 \end{aligned} \tag{L12}
$$

The t<=2m case is at least the same last bound because alpha<2. Thus head neighbors stay farther away than the sublinear scale L_X. For all sufficiently large X,

$$
L_X\le \min(t_0-\beta,2\alpha-3)X.
$$

Equations L10-L12 then show that every unmatched cost at n in S_X and every incident edge cost is at least h1 L_X throughout the whole late interval. This is an observable-distance obstruction, proved on actual arithmetic labels.

## 4. The time-dependent dual and failure of the cost target

The elementary raw-cost dual is particularly useful here. If real numbers z_n satisfy

$$
z_n\le|f_n|,\qquad z_n+z_m\le|f_n-f_m|
       \quad\hbox{on every edge},
$$

then summing over the unmatched vertices and edges of any partial matching gives sum z_n<=c_M(f). Minimization preserves the inequality.

At each t in [t0 X,2X], take z_n=h1 L_X for n in S_X and z_n=0 elsewhere. There is no edge joining two vertices of S_X, since all have the same Möbius sign. Section 3 proves every other constraint. Therefore even the pointwise optimum satisfies

$$
C(v(t))\ge h1 L_X|S_X|
       \gg\frac{X^{2-2/k}}{(\log X)^k}.
 \tag{L13}
$$

Since d_X>=0, the prefix term alone in L4 yields

$$
\boxed{\mathcal K_X\ge(2-t_0)X\,[h1 L_X|S_X|]^2
      \gg\frac{X^{5-4/k}}{(\log X)^{2k}}.} \tag{L14}
$$

For k=5, the exponent is 21/5. Thus the proposed O_epsilon(X^(4+epsilon)) bound fails for each epsilon<1/5. The lower bound permits matchings to change with time, and permits independently chosen prefix and suffix matchings. A fixed matching usable for both has no better cost.

The same argument says C0(v)+Gamma(v)>=h1 L_X|S_X|. It does not separately lower-bound C0 or Gamma by that value. The only automatic penalty conclusion is Gamma>=max(0,h1 L_X|S_X|-C0). Complete-graph edges need not respect L10. Likewise, L14 makes no statement about the size of the signed sum in L3. Further cancellation between its different terms remains possible.

There is a sharp logarithmic-exponent consequence for this positive cost. The linked integrated-divisor estimate and the exact terminal ramps give O(X) for every vertex observable. Leaving all O(X) vertices unmatched proves K_X=O(X^5), including the O(X) corrections. For any fixed delta>0, choosing a sufficiently large fixed k in L14 and absorbing its fixed logarithmic loss proves K_X>>_delta X^(5-delta). Consequently log(K_X)/log X tends to 5. This describes the original graph-cost majorant, not the signed prime-error energy.

## 5. A precise fixed-move generalization

Consider any graph on the same actual squarefree vertices, with every edge joining opposite Möbius signs, endpoint ratio in [1/2,2], and

$$
\omega\bigl(n/\gcd(n,m)\bigr)\le r,
 \qquad \omega\bigl(m/\gcd(n,m)\bigr)\le r, \tag{L15}
$$

where r>=1 is fixed. The condition bounds the number of distinct source prime factors deleted at either endpoint; the number added is bounded by applying it at the other endpoint. It does not merely bound the number of abstract graph operations.

Use the same family S_X with a fixed integer k>r. The gcd retains at least k-r of n's factors, so replace L_X by (alpha X)^(1-r/k). The observable proof L11-L12 uses only the endpoint ratio and is unchanged. Opposite parity again forbids edges internal to S_X. The same raw dual proves

$$
\mathcal K_X\gg_{k,r,\alpha,\beta,t_0}
                \frac{X^{5-2r/k}}{(\log X)^{2k}}. \tag{L16}
$$

Choosing k>2r disproves the all-epsilon target for this entire fixed-r class. For the specific displayed alpha,beta,t0, constants depend only on fixed k,r. More generally t0 can be chosen as (beta+2)/2, making all constants depend on fixed k,r,alpha,beta.

A path of at most ell original moves deletes at most 2 ell distinct original source factors. If its endpoint ratio is also restricted to [1/2,2], L16 therefore applies with r=2 ell. Without that endpoint restriction a three-step path can have ratio as large as 8, and the head-neighbor proof L12 does not apply. Neither unrestricted ratios nor an unbounded number of deleted factors are excluded by this result.

## 6. Finite construction and its weighted deficits

The [exact finite checker](../../certificates/coherent_large_label_matching.py) tests $X=128$, $N=255$. It reuses the elementary rational observable and graph definitions in [the three-step checker](../../certificates/matching_three_step.py). There are 157 vertices and 2,553 original edges. All label cutoffs, signs and endpoint ratios are actual integers.

It computes the complete prefix and suffix histories, the exact maximum over their integer knots, and the graphs with distance cap eta=1,2,4. Decisions include the constant-oracle error radii, and no threshold is ambiguous. In addition it constructs the odd path closure of length at most three. With the original bipartite adjacency matrix A, this is the nonzero pattern of A+A A^T A. The small integer matrix products are exact without int64 overflow. Every edge selected in a repaired matching has an explicit path witness in the checked construction.

For each graph, a floating-point assignment search proposes one fixed matching by maximizing the reduction in the integrated first moment of prefix plus suffix absolute costs. This objective is not the squared energy. The script verifies the selected edges and disjointness exactly, then evaluates that one matching throughout the entire interval for both primitives. Maximum cardinalities are separately certified by exact matching and equal-size vertex-cover witnesses, using alternating reachability.

| Graph | Edges | Maximum matched pairs | Forced unmatched count | Chosen unmatched count | Corrected fixed energy divided by X² |
|---|---:|---:|---:|---:|---:|
| Original full | 2553 | 77 | 3 | 5 | [1106.1527615585,1106.1527615587] |
| Original, cap 1 | 122 | 39 | 79 | 79 | [6694.4051300512,6694.4051300514] |
| Original, cap 2 | 268 | 55 | 47 | 49 | [3571.4035150099,3571.4035150102] |
| Original, cap 4 | 595 | 61 | 35 | 37 | [2732.7683158691,2732.7683158695] |
| Three-step, cap 1 | 154 | 43 | 71 | 71 | [5803.8806389900,5803.8806389904] |
| Three-step full | 5244 | 77 | 3 | 3 | [952.7275807833,952.7275807838] |

The intervals in the table deliberately widen the rational certificate enclosures. Normalization by X² is used only to display manageable numbers. The asymptotic target concerns the unnormalized energy. These are feasible fixed-matching energy bounds, not certificates of minimum coherent squared energy.

The cap graphs also have actual weighted deficits among large labels n>floor(sqrt(128))=11. The cap-1 original graph has 52 isolated large labels, whose forced unmatched integrated prefix-plus-suffix cost is within 0.001 of 90018.661. Cap 2 has 30 with cost within 0.001 of 54573.356; cap 4 has 21 with cost within 0.001 of 40221.825. The three-step cap-1 repair reduces this to 42 labels with cost within 0.001 of 75041.897. The checker constructs their labels and evaluates their total weight with exact rational error bounds. These are first moments of forced unmatched costs, not squared energies. They explain why adding a proximity cutoff by itself loses too many useful neighbors at this X.

At t=240, a separate raw-cost primal/dual computation certifies the following displayed values to within 0.000001. The complete relaxation C0 is 79.544378 throughout this comparison.

| Graph | Pointwise C(v) | Gamma=C-C0 |
|---|---:|---:|
| Original full | 173.413269 | 93.868891 |
| Original, cap 1 | 814.454481 | 734.910103 |
| Original, cap 2 | 555.735366 | 476.190988 |
| Original, cap 4 | 466.838852 | 387.294474 |
| Three-step, cap 1 | 758.061974 | 678.517595 |
| Three-step full | 130.734362 | 51.189983 |

The linear program only searches for a dual. Its proposed nonnegative cover is converted to integers and increased to repair every constraint exactly. A feasible matching supplies the opposite bound. These certificates concern one specified time and retain C0 and Gamma separately. No all-time optimum is inferred from them.

## 7. An exact local obstruction and a tested repair

At X=128, the even-parity label 210=2*3*5*7 has precisely the following original neighbors:

$$
110,114,130,138,154,165,170,174,182,186,
 190,195,222,230,231,238,246,255.
$$

For every t in [240,256], its unmatched prefix is at least 30 h1. A head neighbor m<128 has gap at least 36 h1 by L12 with n=210. An active terminal neighbor has gap at least 12 h1, because the nearest terminal neighbor is 222. An inactive terminal neighbor has gap at least 30 h1. Hence assigning the raw dual value 12 h1 at vertex 210 and zero elsewhere is feasible throughout this interval. Since 12 h1>1.8528, vertex 210 is isolated in the uniform cap-1 original graph. This is an exact actual weighted cut, independent of an assignment optimizer.

The valid path

$$
210\longleftrightarrow222\longleftrightarrow185
             \longleftrightarrow211 \tag{L17}
$$

repairs this particular cut. The first move reduces to 5*7 versus 37 after dividing by 6; the second to 2*3 versus 5 after dividing by 37; the third to 5*37 versus the prime 211. All intermediate labels lie within the original cutoff and every move has ratio in [1/2,2]. The endpoint pair has opposite Möbius signs. Since 210 and 211 are terminal, its uniform prefix/suffix distance is exactly h1<1.

For t>=222 the successive signed prefix differences are 12 h1, -37 h1, 26 h1. Their sum is h1, while the sum of their absolute values is 75 h1. Allowing the endpoint pair therefore preserves real cancellation before taking an absolute value. The finite fixed-matching table shows that this repair also improves an actual whole-interval witness. It does not supply a uniform asymptotic estimate. Even if one restricts the repaired endpoints to ratio [1/2,2], a fixed path length is covered by L16 with larger k. The table's full three-step graph was not restricted by endpoint ratio and lies outside that particular proof. The [separate ratio-eight argument](../prime-distribution/bounded-factor-matching.md) treats it by controlling the measure of cheap head-edge times.

## 8. Certificate arithmetic and remaining obligation

The script's arithmetic oracle encloses logarithms by a rational atanh series and Euler's constant by a harmonic-sum Euler-Maclaurin remainder. H(q) enclosures, not approximate generic observables, determine all midpoint histories. It certifies h1>0.1544 and h2>0.0019. Integer graph validity, maximum-cardinality certificates, threshold decisions, and repaired pointwise LP bounds are exact rational checks.

For each chosen fixed matching, its midpoint absolute-affine terms have rational zeros on every unit time cell. The integrator splits at those zeros, adds the exact quadratic correction d_X or D_X-d_X, squares, and integrates the resulting quartic rational polynomial. It rounds outward by at most 10^-12 per piece. If E bounds the uniform perturbation of a corrected cost and B bounds its midpoint magnitude, the certificate adds 2X(2BE+E²) to enclose both integrated-square terms. The chosen bounds are

$$
E=\sum_n \operatorname{rad}(v_n)+2X\operatorname{rad}(\gamma),
 \qquad B=X\sum_n\max_{q\le\lfloor 2X/n\rfloor}|H_{\rm mid}(q)|
                +(2\gamma_{\rm mid}+1/2)X.
$$

Only cells up to 2X-1 enter, as in the actual histories. The absolute-value Lipschitz inequality makes this perturbation estimate valid even when true zero locations move. The checker verifies rational lower and upper energy bounds, pointwise primal–dual bounds, cardinality covers, matchings and path witnesses. Floating-point assignment searches propose witnesses only. The subsequent inequalities are exact, including repairs of every dual constraint. This matching theorem is not formalized in Lean; its elementary actual-H bound has the separate formal source linked above.

Run `python3 certificates/coherent_large_label_matching.py` with NumPy 2.4.6 and SciPy 1.17.1 installed. The published checker passed all six displayed energy intervals, graph cardinalities and pointwise primal–dual enclosures. It performs no numerical quadrature: roots and integrations on each cell are rational, with the stated outward error bounds. The existence of these fixed witnesses is distinct from optimality of their integrated squared energy.

The proposed cheap-neighbor mechanism has a definite outcome. Observable proximity produces a useful exact metric and a finite path repair, but the original graph's cost criterion fails by the time-dependent dual L14. Enlarging to any fixed-r graph with the stated endpoint ratio also fails by L16. A further matching repair must escape at least one hypothesis of that theorem, or preserve signed cancellation between larger collections instead of bounding each pair separately. It would still have to control the complete prefix and suffix energies at every dyadic X, including the large-scale mean and L3's correction. The [signed coarse-primitive criterion](../prime-distribution/coarse-energy-rh-criterion.md) remains open and is unchanged by this exclusion. RH remains unproved.


The analytic tools are the classical prime number theorem in a fixed-ratio interval, elementary weak matching duality, and the integrated divisor theorem cited above. The exact finite proof uses the matching/vertex-cover equality and rational certificates for feasible linear-programming duals. No literature-priority or RH claim is made for this arithmetic application.
