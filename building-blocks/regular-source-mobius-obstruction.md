# A fixed regular source with a large Möbius floor inverse

For every real $r<2/3$, there is a fixed real sequence $f$ satisfying

$$
|f(q)|\le\sqrt q,\qquad |f(q+1)-f(q)|\le1\quad(q\in\mathbb N),
$$

whose inverse has no eventual bound with constants $C>0$ and $N_0$ valid for every integer $N\ge N_0$:

$$
|I_f(N)|\le C N^r,\qquad
I_f(N)=\sum_{d=1}^N\mu(d)f(\lfloor N/d\rfloor).
$$

The sequence may depend on $r$. The theorem does not assert that one sequence works simultaneously for every $r<2/3$. It is not identified with the actual centered divisor forcing $H$.

The extra regularity is a uniform bound on first differences; it does not assert differentiability of a real extension. The theorem is formalized in [RegularSource.lean](BuildingBlocks/RegularSource.lean). The proof below preserves its finite construction and the distinct Banach–Steinhaus step that produces one fixed sequence.

## Separated tents and the finite lower bound

The finite construction retains the actual Möbius coefficients. Fix an integer t≥1 and put

$$
N=t^3,\qquad c_d=\lfloor t^3/d\rfloor\ (1\le d\le t),\qquad A=t/2.
$$

For real x define the triangular function

$$
T_{A,c}(x)=\max(0,A-|x-c|).
$$

It lies between zero and A and has Lipschitz constant one. For z=1 and z=−1, let P_z(x) be the maximum of zero and the tents centered at those c_d for which μ(d)=z. The formal definition takes a nonempty finite supremum over indices 0 through t; index zero contributes the constant zero.

A finite maximum of functions with Lipschitz constant one has the same bound. Lean proves this directly by comparing each term with the other supremum. Therefore

$$
f_t(q)=\frac{P_1(q)-P_{-1}(q)}2
$$

satisfies

$$
|f_t(q)-f_t(k)|\le|q-k|,\qquad |f_t(q)|\le t/4.
$$

The factor one half is essential to the simple Lipschitz estimate: the difference of the two envelopes has Lipschitz constant at most two. This construction avoids needing a global disjoint-support argument for regularity.

The floor quotients nevertheless have enough separation for exact evaluation at their centers. Lean proves

$$
c_e+t\le c_d\qquad(1\le d<e\le t).
$$

Indeed c_e≥t² and ec_e≤t³. Since d+1≤e and dt≤t²≤c_e,

$$
d(c_e+t)\le(d+1)c_e\le ec_e\le t^3.
$$

Dividing by d gives the claim. Thus at c_d, every tent with a different center vanishes, while the tent at c_d has value A. The three possible Möbius values give

$$
f_t(c_d)=\frac t4\mu(d).
$$

The large-divisor terms vanish exactly. For d>t, Lean proves

$$
\lfloor t^3/d\rfloor+t\le t^2.
$$

Every center is at least t², so these quotients lie outside every tent of radius A=t/2. More generally the envelopes vanish whenever x+t/2≤t². Where the source may be nonzero, q>t²−t/2. For t≥1 this is at least t²/16, so the bound |f_t(q)|≤t/4 implies |f_t(q)|≤√q. Lean handles the vanishing and nonvanishing regions separately, including q=0.

Consequently the actual signed inverse is

$$
\boxed{I_{f_t}(t^3)=\frac t4\sum_{d\le t}\mu(d)^2
\ge\frac{t^2}{64}\qquad(t\ge256).}
$$

For completeness, an elementary squarefree count gives $\sum_{d\le t}\mu(d)^2\ge t/16$ for $t\ge256$. One can use the stronger bound $t/4$: every nonsquarefree integer is divisible by some $j^2$, $j\ge2$, and
$$
\#\{d\le t:d\text{ is not squarefree}\}
\le\sum_{j=2}^{\lfloor\sqrt t\rfloor}\lfloor t/j^2\rfloor
\le t\sum_{j\ge2}j^{-2}\le3t/4.
$$
The last inequality follows from the $j=2$ term and integral comparison on $[2,\infty)$. The stated weaker constant matches the formal theorem. No absolute value is inserted into the inverse sum. The test source makes its product with μ(d) equal a positive multiple of μ(d)².

This excludes a common eventual CN^r bound for all sources satisfying the two displayed regularity inequalities when r<2/3. Otherwise t²≤64Ct^{3r} for every sufficiently large t, which contradicts 3r<2.

## One source by uniform boundedness

To obtain one fixed source, the complete function space must control the first differences as well as the source values. Let B be the Banach space of bounded real sequences with its supremum norm. Inside B×B define

$$
E=\{(g,h):h(q)=\sqrt{q+1}\,g(q+1)-\sqrt q\,g(q)
\text{ for every }q\in\mathbb N\}.
$$

For each fixed q, this is a continuous linear constraint on the pair. Lean defines E as the intersection of their kernels, proves it is closed, and obtains completeness from the complete product space. The norm is the maximum of the two supremum norms. The coordinate factors √q are finite in each constraint; no claim is made that multiplying every coordinate by √q is bounded on all of B.

For N≥1, restrict the finite functional

$$
L_{r,N}(g,h)=\frac1{N^r}\sum_{d\le N}
\mu(d)\sqrt{\lfloor N/d\rfloor}\,g(\lfloor N/d\rfloor)
$$

to E. At N=0 the finite sum is empty and the formal functional is zero. All these maps are continuous linear maps on E, since they use finitely many coordinates.

Every source f satisfying the two regularity inequalities lifts to

$$
g(q)=f(q)/\sqrt q,\qquad h(q)=f(q+1)-f(q),
$$

an element of E with norm at most one. The size condition forces f(0)=0, so the total quotient at zero causes no loss of information. The value of the functional at this lift is exactly I_f(N)/N^r. The finite sources therefore imply unbounded operator norms for r<2/3.

Conversely, each p=(g,h)∈E supplies the permitted source

$$
f_p(q)=\frac{\sqrt q\,g(q)}{\max(1,\|p\|)}.
$$

The relation defining E bounds its first differences by one. If every such fixed source had an eventual power bound, the corresponding functional values at each p would be bounded after a cutoff. The finite initial segment also has a finite bound. The [uniform boundedness theorem already proved in the pinned mathlib version](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/Normed/Operator/BanachSteinhaus.lean) would then give uniformly bounded operator norms, a contradiction. The resulting fixed-source theorem uses no unproved mathematical premise.

## What this excludes for the arithmetic forcing

Let $H(q)=\log(q!)-\sum_{n\le q}d(n)+2\gamma q$, where $d(n)$ counts positive divisors and $H(0)=0$. Its square-root bound is proved in [DivisorForcingBound.lean](BuildingBlocks/DivisorForcingBound.lean), and its exact inverse is the prime error. The connection to the particular arithmetic forcing is explicit. Define

$$
W(q)=1+|\log(q+1)|+d(q+1)+2|\gamma|,
$$

Then $W(q)\ge1$, and the exact increment of $H$ is

$$
H(q+1)-H(q)=\log(q+1)-d(q+1)+2\gamma.
$$

Therefore

$$
|H(q)|\le13\sqrt q,\qquad |H(q+1)-H(q)|\le W(q).
$$

The fixed counterexample satisfies these same two upper bounds because it satisfies the stronger unit bounds above. Thus these particular coarse bounds, although both true of H, do not imply the desired inverse estimate as a general rule. The counterexample does not satisfy the exact increment identity that defines H. The missing argument must use more of that arithmetic identity.

The estimate needed for RH remains the signed bound for I_H(N)=ψ(N)−N+2γ, as also expressed by the [finite Mertens-to-prime transfer](README.md#finite-mertens-to-prime-transfer). No bound for I_H at the RH scale, and no conclusion about zeta zeros, follows from this obstruction.

## Formal theorem and attribution

The canonical namespace is `BuildingBlocks.RegularSource`. The finite construction is proved by `smoothTestSource_increment_le`, `smoothTestSource_abs_le_sqrt`, `signedMobiusInverse_smoothTestSource` and `signedMobiusInverse_smoothTestSource_lower`. The closed Banach subspace and its finite continuous functionals are defined by `regularSourceSpace` and `regularMobiusFunctional`. The concluding theorem is `exists_fixed_regular_source_with_unbounded_inverse`, whose only mathematical hypothesis is $r<2/3$. It excludes an eventual bound with any real constant; the displayed positive-constant formulation is equivalent.

The existing integrated module and its proof assumptions are unchanged by this written reconstruction. The final comparison with the exact increment of $H$ is a written consequence; it does not identify the constructed source with $H$ or formalize a new estimate for its inverse.

The construction uses elementary squarefree counting, finite Lipschitz envelopes and the classical uniform boundedness principle. The Lean proof uses mathlib's [Banach–Steinhaus theorem](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Analysis/Normed/Operator/BanachSteinhaus.lean), by Jireh Loreaux, and [bounded-function normed spaces](https://github.com/leanprover-community/mathlib4/blob/f897ebcf72cd16f89ab4577d0c826cd14afaafc7/Mathlib/Topology/ContinuousMap/Bounded/Normed.lean), by Sébastien Gouëzel, Mario Carneiro, Yury Kudryashov and Heather Macbeth. Their Apache 2.0 attribution is retained in the repository. Priority of this exact construction or its formalization is unestablished.
