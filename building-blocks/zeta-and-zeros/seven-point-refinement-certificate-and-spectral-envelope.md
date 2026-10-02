# A finite spectral envelope and a reproduced seven-point certificate

Checked supporting mathematics, 3 October 2026. The [finite Lean source](../../formalization/BuildingBlocks/FiniteSpectralEnvelope.lean), [axiom audit](../../formalization/verification/FiniteSpectralEnvelopeAudit.lean), and [portable certificate replay](../../formalization/verification/seven-point-refinement/README.md) accompany this note. The original full signed arithmetic bound and RH remain open.

For a positive semidefinite correlation matrix, the squared distance from the identity measures its off-diagonal overlap. The stability functional used in the simple-critical-zero count does not equal that squared distance once an eigenvalue exceeds two. An exact dimension-dependent envelope accounts for this change. This note records a local Lean proof of its finite zero-sum scalar form, an independently reproduced six-gap certificate, and the reviewed written deduction of a simple-critical-zero proportion. The spectral envelope and certificate come from the pinned source lineage identified below; no mathematical priority or numerical-record claim is made.

## The finite scalar theorem

Let m be any integer with m>=2. For any real vector y=(y_1,…,y_m) with Σ_i y_i=0, define

$$
 E(y)=\sum_{i=1}^{m}y_i^2,\qquad
 R(y)=\sum_{i=1}^{m}\max(y_i-1,0)^2,\qquad
 D(y)=E(y)-R(y).
$$

For every real u, put

$$
 g_m(u)=
 \begin{cases}
 u,&u\le m/(m-1),\\[2pt]
 u/m+2\sqrt{(m-1)u/m}-1,&u>m/(m-1).
 \end{cases}
$$

The square-root branch is used only for positive u. The local Lean declaration `defect_ge_envelope` proves

$$
 \forall m\ge2\;\forall y\in\mathbb R^m,
 \qquad \sum_i y_i=0\ \Longrightarrow\ D(y)\ge g_m(E(y)).
$$

There is no lower bound on the coordinates and no upper bound on E. The local declaration `defect_add_cost_ge_envelope` also proves

$$
 \forall A\in\mathbb R\;\forall x\ge0,
 \qquad A\le E(y)+x\ \Longrightarrow\ D(y)+x\ge g_m(A),
$$

under the same m and zero-sum hypotheses. In particular, A need not be nonnegative. The declarations `envelope_monotone` and `envelope_one_lipschitz` prove monotonicity on the real line and the ordered estimate g_m(A)<=g_m(E)+(A−E) whenever 0<=E<=A. These exact scalar statements are kernel checked under the repository's Lean 4.24.0 setup. The six printed transitive axiom lists are exactly `propext`, `Classical.choice`, and `Quot.sound`. The proof assumes no kernel certificate, matrix spectral identity, analytic zeta statement, or RH hypothesis.

The proof can be read directly in real variables. If R=0, then D=E. Otherwise let H={i:y_i>1}, h=|H|, and r=sqrt(R)>0. The positive excesses have sum at least r; the complementary coordinates sum to minus that excess sum minus h. Their squared sum is therefore at least the square of that total divided by m−h. Because the entire vector sums to zero, 1<=h<m. It follows that

$$
 E\ge h+2r+r^2+\frac{(h+r)^2}{m-h}
 =\frac{m(1+r)^2}{m-1}
  +\frac{(h-1)(m+r)^2}{(m-h)(m-1)}.
$$

Thus positive excess forces E>m/(m−1), and R <= (sqrt((m−1)E/m)−1)^2. Subtracting R from E gives the upper branch. Monotonicity and the bound of one on the envelope's increase then give the nonnegative-cost theorem. The Lean proof uses these finite inequalities and covers both branches, their common endpoint, and E=0.

Sharpness has a short written construction. For any E>=0, take a=sqrt((m−1)E/m), y_1=a, and y_i=−a/(m−1) for i>1. This vector has zero sum, squared energy E, and defect exactly g_m(E). The local Lean file proves the lower bound and cost theorem; it does not formalize this equality construction.

## The matrix interpretation and its limits

For nonnegative t, define

$$
 \Psi(t)=
 \begin{cases}(t-1)^2,&0\le t\le2,\\2t-3,&t\ge2.\end{cases}
 \qquad
 \mathcal D(G)=\operatorname{tr}\Psi(G).
$$

If G is an m by m Hermitian positive semidefinite correlation matrix, its eigenvalues lambda_i have sum m. Setting y_i=lambda_i−1 identifies E with tr(G−I)^2=2Σ_{i<j}|G_ij|² and D with tr Psi(G). The scalar theorem therefore gives the matrix envelope by the standard spectral identities. Correlation matrices have 0<=E<=m(m−1), and the matrix (1−a/(m−1))I+aJ/(m−1) realizes equality throughout that range. The local Lean theorem does not construct a matrix, formalize these spectral identities, or prove spectral pinching. Those statements are written mathematics.

The rectangular Gram trace requires an explicit dimension correction. If V has d rows, r columns and rank k, the nonzero eigenvalues of VV* and V*V agree, while their zero eigenvalue multiplicities are d−k and r−k. Since Psi(0)=1,

$$
 \operatorname{tr}\Psi(V^*V)
 =\operatorname{tr}\Psi(VV^*)+(r-d).
$$

A helper that equates spectral sums only for functions vanishing at zero cannot be applied to raw Psi. Applying it to Psi−1 and restoring the dimensions gives the displayed correction. The stability inequality in the source uses the r-dimensional V*V spectrum and keeps the corresponding −r term. No raw-Psi trace equality is assumed in this note.

## The global six-gap certificate

Define the normalized Montgomery–Taylor overlap kernel by

$$
 K(t)=\int_{-1/2}^{1/2}\cos(\sqrt2\,u)\cos(2\pi tu)\,du,
 \qquad k(t)=\frac{K(t)}{K(0)},\qquad w(t)=k(t)^2,
$$

where K(0)=sqrt(2)sin(1/sqrt(2))>0. With a=1/sqrt(2), the equivalent entire expression is K(t)=(sinc(πt−a)+sinc(πt+a))/2, with sinc(0)=1. For six nonnegative real gaps, put

$$
 F_6(g_1,\ldots,g_6)
 =\frac1{3000}\sum_{i=1}^{6}g_i
  +\sum_{s=1}^{6}\frac{2}{7-s}
    \sum_{i=1}^{7-s}
      w(g_i+\cdots+g_{i+s-1}).
$$

The reproduced certificate establishes

$$
 \forall(g_1,\ldots,g_6)\in[0,\infty)^6,
 \qquad F_6(g_1,\ldots,g_6)\ge\frac{382623}{100000000}.
$$

The quantifier includes zero gaps, coincident points and arbitrarily large gaps. All 21 overlap terms remain. The linear pressure closes the unbounded region as soon as the total gap reaches 3000q=11.47869. On the remaining compact region, reviewed coordinate elimination, closed-cell coverage, rigorous interval bounds, certified convex supporting tangents and exhaustive subdivisions account for every point. An unresolved terminal box causes failure.

The frozen Uwe verifier was independently replayed in two existing local Python runtimes. Both full runs exited successfully with 980069 nodes, 490399 terminal prunes, 489670 splits, 729 initial boxes and maximum depth 65, at 128-bit Arb precision on a grid of mesh 1/4000. The terminal counts were 285258 interval, 3166 pressure and 201975 tangent closures, including 1773 bounded-subcell tangent closures. Both generated table hashes agree with the pinned report. Both strict report comparisons checked all 20 deterministic fields against the committed report, including the frozen verifier source hash. The replays used CPython 3.13.12 and 3.12.12, each with python-flint 0.9.0, on the same macOS arm64 host.

This is a reproduced computer-assisted interval proof, with CPython, IEEE-754 conversions and directed widening, python-flint, FLINT/Arb, the reviewed source, operating system and hardware in its trust base. The replays use the same verifier implementation; they are not an independent interval algorithm. The global F6 theorem is not consumed by the local Lean scalar proof and is not claimed to have a complete public Lean proof.

## The reviewed written zero-count consequence

Let N=N(T,2T) count nontrivial zeta zeros with multiplicity in (T,2T], and let S=N_0^s(T,2T) count those zeros that are both simple and on the critical line. [Anthropic's original paper, Theorem D and §§2,4,5,7.1](https://www-cdn.anthropic.com/564f962e60643842f5fcb4a17c9dbc8f608f1c37.pdf) supplies the unconditional analytic setup, with

$$
 H_{\rm MT}=\frac32-\frac1{\sqrt2}\cot\frac1{\sqrt2}
 =0.6725007036794116457\ldots.
$$

The refinement uses the same tapered cos(sqrt(2)u/L)^(1/2) test family, L=log(T/(2π)), grid spacing 2π/L, and normalization aL². The original sampling identity, simple/multiple/off-line inertia decomposition, prime-side trace estimates, trace-norm tail bound and local zero count are the required inputs. A lower bound for S/N alone would not supply this structure. The source matches the full original setup.

The written stability refinement retains the defect of the simple-zero Gram matrix and gives $S\ge H_{\rm MT}N+\mathcal D(M^{\circ})-o(N)$. Summing the global F6 inequality over consecutive seven-point windows in a block of m points gives overlap energy plus span/500 at least q(m−6). Each pair spanning s gaps appears in at most 7−s windows; each single gap appears in at most six. The scalar cost theorem then gives a block defect plus span/500 of at least g_m(q(m−6)), up to the uniform vanishing error of the actual Gram limit.

The diagonal normalization is paid explicitly. If a block's span already supplies the target, nonnegativity of the defect closes it. Otherwise its span is bounded independently of T; the full-grid overlap converges uniformly on that compact range. Removing normalized endpoint strips of width L² deletes O(L²)=o(N) zeros. Fixed-size block rescaling to diagonal one changes both defect and off-diagonal energy by o(1), uniformly. Averaging all m shifts of the block partition retains S/m+O(1) full blocks and charges any adjacent gap at most m−1 times. The total normalized span is at most LT/(2π)=N+o(N). Consequently

$$
 \mathcal D(M^{\circ})\ge
 \frac{C}{m}S-\frac{m-1}{500m}N-o(N),
 \qquad C=g_m(q(m-6)).
$$

For q=382623/100000000 and m=279, A=q(m−6)=1.04456079>279/278, so the square-root branch is required. Put

$$
 C=\frac{11606231}{3100000000}
   +2\sqrt{\frac{1613266109}{1550000000}}-1.
$$

Combining the count inequality with shifted pinching gives the reviewed written consequence

$$
 \liminf_{T\to\infty}\frac{N_0^s(T,2T)}{N(T,2T)}
 \ge B_{279}
 :=\frac{H_{\rm MT}-139/69750}{1-C/279}
 =0.6730266625438475496579\ldots.
$$

The denominator is positive because C<=A and A/279<q<1. The directed constant replay encloses B279 above the displayed downward truncation 0.6730266625438475. The finite scan and reviewed real-tail argument also support the source's optimum at m279, although choosing an optimum is unnecessary to establish the fixed-m279 inequality.

The original H_MT bound and the pinned comparison bound are strictly smaller. The comparison uses q=191/50000 and m267, giving (13350000H_MT−26600)/13300149=0.6730213619501665335… . The change in the fractions is approximately 0.0005259588644 above H_MT and 0.00000530059368 above that comparison. Exact rational comparisons establish both strict inequalities without relying on the long decimal printout.

This is an asymptotic result as real T tends to infinity, with o(1) loss and no displayed effective onset. The unconditional analytic inputs are the actual zeta functional equation and zero symmetry, Weil explicit formula, Stirling estimates, Riemann–von Mangoldt counting, the local zero-count bound, Chebyshev–Mertens prime-power estimates and the Montgomery–Vaughan mean-value/Hilbert inequality at bandwidth at most one. The assembly, matrix spectral transfer, pinching, actual Gram asymptotic and error bookkeeping in this note are independently reviewed written arguments. They are not newly proved in the local Lean file.

## Provenance and verification scope

The [Uwe Schwarz snapshot at e2453c1cafc1387ef553fe6bee74d1f5223ba801](https://github.com/uwe-schwarz/zeta-simple-zeros-673026/tree/e2453c1cafc1387ef553fe6bee74d1f5223ba801) provides the exact spectral envelope, q=382623/100000000 target and m279 conversion reviewed here. Its stated antecedent is [Ainta at 040c5e899e658aed7b56a2a87f501798fe10761d](https://github.com/ainta/zeta-simple-zeros/tree/040c5e899e658aed7b56a2a87f501798fe10761d), for the stability refinement, seven-point argument, block aggregation, shifted pinching and verifier lineage. [Learademacher at bd4a7d36988b23220034527881f4457f2f689e86](https://github.com/learademacher/ai-refines-ai-zeta-bound/tree/bd4a7d36988b23220034527881f4457f2f689e86) is the pinned comparison for q=191/50000. The actual-zeta foundation is the cited Anthropic paper and its [v1.0 Lean artifact at 3635e74826a4c1fcece7d1cd2b6fa75e43a00510](https://github.com/anthropics/zeta-23-lean/tree/3635e74826a4c1fcece7d1cd2b6fa75e43a00510). These pins identify distinct sources and evidence; combining their metadata does not create a transitive proof.

The Uwe public snapshot contains small JSON build attestations and an explanation that the generated Lean source tree is absent. It does not provide the claimed complete Lean source closure, and its own status file leaves the final finite theorem, zeta integration and transitive axiom audit pending. The source attestations are not formal proofs. The local finite scalar proof is independently checkable source and has the narrower, explicit statement above; its axiom audit cannot be transferred to the global F6 inequality or the improved actual-zeta count.

The supporting results concern a finite scalar inequality, a reproduced global kernel certificate and a written proportion argument. They do not supply the original full all-real F or W upper/sign premise, the coarse energy bound, individual-zero control or an RH proof. The original research goal remains open.
