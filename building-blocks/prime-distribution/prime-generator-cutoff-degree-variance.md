# A uniform degree-variance bound for the prime-generator cutoff graph

For every sufficiently large real cutoff, every normalized nonnegative symmetric conductance system on the actual prime-generator graph has degree variance bounded below by a fixed positive constant. This rules out the small-degree-variance Cauchy shortcut to Liouville cancellation. It does not lower-bound the Liouville average, exclude other graph methods, strengthen a prime-error estimate, or prove RH. The onset is uncomputed. No priority claim is made.

The theorem and its elementary weighted-count proof are written below. The [Lean module](../../formalization/BuildingBlocks/PrimeGraphDegreeVariance.lean) formalizes the finite graph, weighted projection and exact rational algebra described in its declaration-level verification section. The fixed-period CRT counting, weighted asymptotics and their eventual real-cutoff consequences remain written analysis.

## The actual graph and theorem

Let \(X>2\). The vertices are positive integers \(n<X\), with

\[
Z_X=\sum_{1\le n<X}\frac{X-n}{\sqrt n},\qquad
\pi_X(n)=\frac{X-n}{\sqrt n Z_X}.
\]

An ordinary prime \(p\) gives an undirected edge between \(n\) and \(pn\) whenever both vertices are present. Every proper prime-power state is retained. Give these edges arbitrary symmetric nonnegative conductances \(c(n,m)\), with zero conductance on other pairs. Define

\[
d(n)=\frac{\sum_m c(n,m)}{\pi_X(n)},\qquad
E_{\pi_X}d=1,\qquad
V_X=E_{\pi_X}(d-1)^2.
\]

Conductances and degrees may depend on \(X\). Isolated vertices with degree zero are allowed. At an integer cutoff the vertex \(n=X\) is excluded because its weight is zero.

**Theorem.** There exists a real \(X_0\), independent of the conductance choices, such that for every real \(X\ge X_0\) and every conductance system satisfying the preceding conditions,

\[
\boxed{V_X>\frac{49}{75\cdot2^{25}-49}>0.}
\tag{1}
\]

No value of \(X_0\) is claimed. The proof fixes the finite sieve level before letting \(X\) tend to infinity; it asserts no uniform estimate at growing sieve depth.

## A finite weighted projection inequality

For any finite probability law, suppose disjoint sets \(S,T\) have masses \(m,q\), with \(m>q\), and every neighbor of \(S\) belongs to \(T\). Nonnegative symmetric conductances give

\[
E[\mathbf1_Sd]=\sum_{n\in S,m\in T}c(n,m)
\le\sum_{m\in T,n}c(m,n)=E[\mathbf1_Td].
\]

Set \(a=\mathbf1_S-\mathbf1_T\) and \(r=m-q>0\). Then \(Ea=r\), \(Ea^2=m+q\), and \(E(d-1)=0\). Consequently

\[
E[(a-r)(d-1)]=E(ad)-r\le-r.
\]

Weighted Cauchy-Schwarz yields

\[
r^2\le\bigl(m+q-r^2\bigr)V_X,
\qquad
\boxed{V_X\ge\frac{(m-q)^2}{m+q-(m-q)^2}.}
\tag{2}
\]

The denominator is positive. If it vanished, \(a\) would be constant on the positive-mass support, making the displayed centered pairing zero, contrary to its upper bound \(-r\). The inequality concerns a cut constraint. Its equality conditions do not assert attainment by conductances on the whole prime graph.

## Rough integers and their smaller neighbors

Fix \(Y\ge6\), and put

\[
P_Y=\prod_{p\le Y}p,\qquad
S_X=\{n:X/2<n<3X/4,\ \gcd(n,P_Y)=1\},
\]
\[
T_X=\{n:1\le n\le3X/(4Y)\}.
\]

These are rough integers, not just primes. The sets are disjoint. An upward prime move from \(S_X\) has \(pn\ge2n>X\), so it leaves the graph. For a downward move \(n\mapsto n/p\), roughness forces \(p>Y\), and

\[
n/p<3X/(4Y).
\]

Thus every graph neighbor of \(S_X\) lies in \(T_X\). Equation (2) applies to every admissible conductance assignment.

Let \(m_X=\pi_X(S_X)\) and \(q_X=\pi_X(T_X)\). Write

\[
\delta_Y=\prod_{p\le Y}(1-1/p),\qquad
A=\frac{9\sqrt3-10\sqrt2}{16}.
\]

For this one fixed \(Y\), CRT gives

\[
\#\{n\le u:\gcd(n,P_Y)=1\}=\delta_Yu+O(P_Y)
\]

uniformly for real \(u\). The cutoff weight \((X-n)/\sqrt n\) has size and total variation \(O(\sqrt X)\) on \((X/2,3X/4)\). Partial summation therefore gives weighted CRT error \(O(P_Y\sqrt X)\). Since ordinary power sums give

\[
Z_X=\frac43X^{3/2}+O(X),
\]

the normalized error tends to zero. The weighted Riemann integral is

\[
\frac34\int_{1/2}^{3/4}\frac{1-u}{\sqrt u}\,du=A.
\]

Hence, through all real cutoffs,

\[
m_X\longrightarrow A\delta_Y.
\tag{3}
\]

Put \(b=3/(4Y)\). The same power-sum estimates, including the integrable singularity at zero, give

\[
q_X\longrightarrow\frac32\sqrt b-\frac12b^{3/2}.
\tag{4}
\]

The initial-block normalized error is \(O(X^{-1/2})\). Strict endpoints and noninteger cutoffs change neither limit. The counting argument uses a fixed finite modulus; it does not replace the ordinary integers by a Haar-distributed model.

## An elementary product estimate

Every prime at least five is coprime to six. Adding factors between zero and one decreases a product, so

\[
\delta_Y\ge\frac13
\prod_{\substack{5\le n\le Y\\(n,6)=1}}(1-1/n).
\]

For \(n\ge5\), \(\log(1-1/n)>-1/(n-1)\). Separate the term \(n=5\); the pair \(6k+1,6k+5\), for \(k\ge1\), contributes at most \(1/(3k)\) to the reciprocal sum. Therefore

\[
\sum_{\substack{5\le n\le Y\\(n,6)=1}}\frac1{n-1}
\le\frac14+\frac13H_{\lfloor Y/6\rfloor}
\le\frac7{12}+\frac13\log Y.
\]

Also \(\log2>7/12\): integrate \(1/t\) separately on \([1,3/2]\) and \([3/2,2]\), giving strict lower bounds \(1/3\) and \(1/4\). It follows that

\[
\delta_Y>\frac16Y^{-1/3}.
\tag{5}
\]

This deliberately coarse finite product bound needs neither PNT nor Mertens' asymptotic formula.

Fix \(Y=2^{48}\). The elementary bounds \(A>1/16\) and \(\sqrt3<2\), together with (3)--(5), give

\[
\lim m_X>m_0:=\frac1{6\cdot2^{20}},\qquad
\lim q_X<q_0:=\frac3{2^{25}}.
\]

For example, \(A>1/16\) follows by squaring the positive sides of \(9\sqrt3>10\sqrt2+1\), using \(\sqrt2<3/2\). The limits are strict, so one common \(X_0\) gives \(m_X>m_0\) and \(q_X<q_0\) for every real \(X\ge X_0\). These masses depend on the cutoff, not on conductance choices.

For \(m>q\) and positive denominator \(s=m+q-(m-q)^2\), the function

\[
f(m,q)=\frac{(m-q)^2}{s}
\]

increases in \(m\) and decreases in \(q\). Its partial derivatives are \((m-q)(m+3q)/s^2\) and \(-(m-q)(3m+q)/s^2\). The comparison stays within the probability-mass region, where the intermediate denominators are positive. Finally,

\[
m_0-q_0=\frac7{3\cdot2^{25}},\qquad
m_0+q_0=\frac{25}{3\cdot2^{25}},\qquad
f(m_0,q_0)=\frac{49}{75\cdot2^{25}-49}.
\]

Equation (2) and the strict mass comparison prove (1).

## What this says about Liouville cancellation

For actual Liouville \(\lambda(n)=(-1)^{\Omega(n)}\), every prime edge flips its sign, including edges adding a repeated prime factor. Symmetry gives the exact finite identity

\[
E_{\pi_X}(\lambda d)
=\frac12\sum_{n,m}c(n,m)\bigl(\lambda(n)+\lambda(m)\bigr)=0.
\]

Thus

\[
|E_{\pi_X}\lambda|
=|E_{\pi_X}[\lambda(1-d)]|
\le\sqrt{V_X}.
\]

One might try to make the right side small by selecting nearly constant degrees. Theorem (1) shows that it cannot tend to zero for this graph and this probability law, regardless of the conductance choices. The signed average can nevertheless be much smaller than this Cauchy upper bound. No lower bound for that average follows, and no graph-to-RH implication is asserted.

## Verification and comparison

The argument uses finite conductance balance and weighted Cauchy-Schwarz, followed by elementary fixed-period counting and power sums. It is presented as a supporting result for a specific cutoff graph, without a claim that the projection method or variance phenomenon is new. Earlier independent written reviews checked the support, centering, rough-neighbor inclusion, CRT error, product estimate, strict quantifiers and rational corner.

The finite module was checked with Lean 4.24.0 using both the direct checker and its named Lake target. Its declarations include the actual graph and weights:

- `Vertex`, `integer_lt_cutoff` and `vertexOfNat` enumerate exactly the positive integers below every real cutoff. `tentWeight`, `normalizer`, `pi_pos` and `pi_sum` give the literal positive tent law.
- `rough_prime_neighbors_small` and `rough_small_disjoint` prove the actual prime-edge geometry. `Conductance.degreeMass_cut_le` and `Conductance.rough_degreeMass_le_small` prove the finite conductance comparison.
- `weighted_cut_projection` proves the finite centered inequality. `Conductance.rough_variance_projection` applies it to the literal graph and probability law, with mean degree one and the stated mass ordering.
- `exact_projection_corner` proves the displayed rational identity. `strict_variance_floor` proves the corner comparison by polynomial algebra. `Conductance.rough_variance_gt_corner` proves the strict graph variance bound from the two explicit inequalities for the actual rough-band and initial-block masses.
- `Conductance.liouville_degree_pairing_zero` and `Conductance.liouville_mean_sq_le_variance` prove the actual finite Liouville cancellation identity and its Cauchy consequence, with prime factors counted with multiplicity.

The explicit mass hypotheses in `rough_variance_gt_corner` are discharged eventually by the written counting argument, not by Lean. The identification of the finite prime-divisibility condition with coprimality to \(P_Y\), the CRT count, the product estimate, the weighted limits, and the existence of the common onset remain outside the kernel. No declaration claims the complete eventual theorem (1) without those analytic steps.

The audited theorem dependencies are only `propext`, `Classical.choice` and `Quot.sound`. There are no `sorry` declarations or custom axioms. The focused checks are:

```bash
/Users/arterialist/.elan/bin/lake env lean formalization/BuildingBlocks/PrimeGraphDegreeVariance.lean
/Users/arterialist/.elan/bin/lake build BuildingBlocks.PrimeGraphDegreeVariance
```
