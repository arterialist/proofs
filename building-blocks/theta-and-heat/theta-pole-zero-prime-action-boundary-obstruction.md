# Complete bare prime action fails even on compact pole-zero tests

This is a written counterexample to using the complete physical prime convolution as an L²(du) action on every actual theta form test. It addresses a signed infinite-action factorization, rather than a positive finite-cycle or Doeblin comparison. The full weighted jump form remains legitimate and is not disproved.

Define the actual bare physical prime action

    Sf(u)=Σ_(n≥2) Λ(n)/√n [f(u−log n)+f(u+log n)].

For compactly supported f this sum is locally finite. A proposed commuting mixed-action or anticommutator certificate involving A and S would need justified L² actions and products on its test class. This remains a substantive requirement even after enforcing both pole moments to vanish, as the following actual counterexample shows.

## An explicit pole-zero test from one unconditional critical zero

Fix any actual zeta zero ρ=1/2+iγ on the critical line with γ≠0. Such zeros exist unconditionally by Hardy's 1914 theorem; the argument does not assume RH. Choose a nonzero even nonnegative smooth bump g supported in [−ε,ε], where ε|γ|<π/3. Then

    ∫g(v)cos(γv)dv>0.

Set f=g''−g/4. This is real, smooth and compactly supported, with

    ∫e^(v/2)f(v)dv=∫e^(−v/2)f(v)dv=0

by integration by parts. Its compact Laplace transform F(w)=∫f(v)e^(−wv)dv satisfies

    F(w)=(w²−1/4)∫g(v)e^(−wv)dv,
    F(iγ)=−(γ²+1/4)∫g(v)cos(γv)dv≠0.             (1)

The actual potential h=f/Φ is smooth, even and compactly supported because Φ is positive, even and smooth. It has finite full theta norm and full continuous/ALL-prime-power energy, and its two physical pole moments vanish. These moments also give ν(h)=0 and beta(h)=0. Thus this is within the genuine centered form test class, not an arbitrary distribution or nonzero-pole exception.

## The prime series produces a forbidden boundary pole

Take R>ε. For u>R the upward term f(u+log n) is zero, so Sf is the downward sum. For Re w>1/2, absolute convergence justifies its half-line Laplace transform and gives

    H(w):=∫_R^∞ Sf(u)e^(−wu)du
         =F(w)Σ_(n≥2)Λ(n)n^(−1/2−w)+B_R(w)
         =−F(w) ζ'(1/2+w)/ζ(1/2+w)+B_R(w).        (2)

Here B_R is entire. Indeed all n with log n>R+ε contribute their full translated support and exactly the factor n^(−w)F(w); only finitely many smaller n have an endpoint correction. Each correction is an integral over a bounded interval of a compact smooth function against exp(−wu), hence entire. No prime powers have been dropped.

Suppose Sf belonged to L²((R,∞),du). Then H is holomorphic for Re w>0 and Cauchy–Schwarz gives

    |H(w)|≤||Sf||_(L²(R,∞)) exp(−R Re w)/sqrt(2 Re w).   (3)

The meromorphic right side of (2) must agree with H throughout Re w>0 by analytic continuation from Re w>1/2. More explicitly, deleting its isolated poles leaves a connected domain; equality there forces any interior singularities to be removable, since H is holomorphic. This does not presuppose the absence of off-critical zeros.

Let m be the actual multiplicity of the chosen critical zero. Its isolation gives, along w=ε_0+iγ with ε_0→0+,

    ζ'(1/2+w)/ζ(1/2+w)=m/ε_0+O(1),
    H(ε_0+iγ)=−mF(iγ)/ε_0+O(1).                 (4)

By (1) this has nonzero order ε_0^(−1), contradicting the order at most ε_0^(−1/2) in (3). Therefore

    Sf∉L²((R,∞),du), hence Sf∉L²(ℝ,du).         (5)

This failure occurs on a compact actual pole-zero full-form test. It is forced by a known critical zero, not by a hypothetical off-critical zero.

## Equality calibration does not supply the missing common action

The actual derivative radical identity gives the local-convergent complete source identity

    SΦ=AΦ+cosh(u/2).

Differentiation shows that the physical equality functions

    Φ^(2j)−4^(−j)Φ,
    Φ^(2j+1)−4^(−j)Φ'

satisfy Sf=Af, because their pole contributions cancel exactly. Thus a bare commuting-action factorization can be perfectly calibrated on the entire equality tower while failing to be an L² expression on another legitimate pole-zero form test. Equation (5) is the decisive obstruction to that proposed common L² realization; it is not an argument against every signed nonlocal factorization.

The weighted ground-space incoming operator, compensated continuous form, complete holdings, and pole corrections are different objects and remain available. In particular compact f has finite actual quadratic prime form: its correlations vanish once log n exceeds the support diameter. The divergent bare action cannot be substituted for that valid form.

## Attribution and formal scope

Hardy's primary note, *Sur les zéros de la fonction ζ(s) de Riemann*, Comptes rendus 158 (1914), pp. 1012–1014, states and proves infinitely many critical-line zeros; [the opening original page](https://fr.wikisource.org/wiki/Page:Comptes_rendus_hebdomadaires_des_s%C3%A9ances_de_l%E2%80%99Acad%C3%A9mie_des_sciences,_tome_158,_1914.djvu/1014) was checked for the precise unconditional input. The Euler logarithmic-derivative identity in Re s>1, compact integration by parts, analytic continuation, and the elementary half-line L² Laplace bound yield the argument above. A distinct mathematical agent independently checked the finite endpoint correction, both transform signs, centered/pole-zero conditions, continuation without an RH premise, and the boundary growth contradiction. No priority claim is made. This is written mathematics, not Lean; Hardy's theorem, the actual Euler identity and the complex-analytic boundary argument are not formalized here. It supplies no RH proof or negative full-energy test.

RH Agent2 supplied this argument; RH Proof independently checked the compact transform sign, finite endpoint correction, exact centered and pole-zero conditions, and the comparison between the nonzero simple logarithmic-derivative pole and the half-line L² bound. For each fixed compact support, the actual prime action is locally finite because an observing logarithm must lie in a bounded interval around u or -u. Absolute Laplace interchange for Re w>1/2 follows from the convergent actual series sum Lambda(n)n^(-1/2-Re w). Holomorphy under the hypothetical L² assumption follows by local domination with e^(-sigma u) times polynomial powers of u. Equality of the meromorphic and holomorphic functions on the right half-plane uses the identity theorem, so any interior poles are forced removable; no zero-free strip is assumed. These details preserve the full source and both endpoint conventions.

## Every finite Lp action requires zero annihilation

RH Proof derived a broader necessary condition from the same literal half-line identity. Let f be any compact smooth complex seed, supported in [-a,a], let R>a, and put F(w)=integral f(v)exp(-wv)dv. If the actual complete Sf belongs to Lp((R,infinity),du) for some real 1<=p<infinity, then

\[
 F(\rho-1/2)=0
 \quad\text{for every nontrivial zeta zero }\rho
 \text{ with }\Re\rho\ge1/2.
\tag{6}
\]

No pole-null or parity assumption is needed for this necessity. For 1<p<infinity, let q=p/(p-1). Holder's inequality gives, with sigma=Re w>0,

\[
 |H(w)|\le\|Sf\|_p e^{-R\sigma}(q\sigma)^{-1/q}.
\tag{7}
\]

For p=1 the corresponding bound is |H(w)|<=||Sf||_1 exp(-R sigma). In either case H is holomorphic on Re w>0. To justify derivatives locally, fix sigma_0>0 and use Holder with u^j exp(-sigma_0 u), for each nonnegative integer j; its conjugate norm is finite, including the supremum norm when p=1. The actual prime-series identity (2), with its entire finite endpoint correction, initially holds on Re w>1/2 and extends meromorphically to the right half-plane.

If Re rho>1/2 and F(rho-1/2) is nonzero, the right side has an interior pole with residue -m_rho F(rho-1/2), contradicting holomorphy of H. If Re rho=1/2, write rho=1/2+i gamma. At w=sigma+i gamma the same residue gives H(w)=-m_rho F(i gamma)/sigma+O(1). For p>1, the exponent 1/q=1-1/p in (7) is strictly less than one, so multiplying by sigma makes its bound tend to zero. For p=1 the bounded estimate gives the same contradiction. This proves (6) for all finite p, with every prime power retained.

The necessary zero of F has order at least one. This argument does not force F to vanish to the zeta zero's multiplicity: the logarithmic derivative has a simple pole whose residue is that multiplicity. Nor does (6) prove a sufficient Lp condition.

For an even compact seed, F(-w)=F(w). The functional-equation reflection rho -> 1-rho carries a nontrivial zero to another nontrivial zero. Hence (6) also forces F(rho-1/2)=0 for zeros left of the critical line. Thus finite-Lp bare action for an even compact seed requires annihilation at every distinct nontrivial zeta zero, wherever it lies. This does not assume RH and does not assert that every compact seed fails this condition.

In particular the explicit even two-pole-zero seed f=g''-g/4 above has F(i gamma) nonzero at the chosen unconditional critical zero. The same single f therefore satisfies

\[
 Sf\notin L^p((R,\infty),du)\qquad(1\le p<\infty).
\tag{8}
\]

At p=infinity, Holder only gives an order 1/sigma bound; the residue argument alone yields no contradiction there. No bounded-action failure is claimed by (8). The weighted theta action and compensated mixed forms remain separate valid objects. This extension uses classical Holder bounds and the existing actual Euler identity, with no priority claim. It is written mathematics requiring Lean formalization; it supplies no arithmetic energy upper bound or RH proof.

## Complete compact-core exclusion using simple-zero density

The [compact-core sequel](../prime-distribution/compact-bare-prime-action-finite-lp-exclusion.md) strengthens (6) with an explicit existing simple-critical-zero density theorem. A nonzero compact smooth seed has an entire transform with only O_f(T) zeros up to height T, by Jensen's formula, whereas actual simple critical-line zeros number at least c T log T for all sufficiently large T. Thus no nonzero compact smooth seed has a complete bare action in any finite Lp tail. This further statement uses the cited unconditional simple-zero density input, not Hardy's infinitude alone. It is written mathematics, not Lean, and has no p=infinity or weighted compensated-action conclusion.
