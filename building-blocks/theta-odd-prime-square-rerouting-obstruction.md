# Actual prime-square rerouting: exact cost and obstruction

This tests a specific arithmetic coupling in the odd half-line theta form. It gives an exact two-edge inequality and proves that its required uniform congestion constant is infinite. It does not give a negative full-form test or disprove the sharp gap.

Write a=log n, c_n=Λ(n)/√n, with n a prime power. For 0<x<a set y=a−x and z=x+a. A reflected n edge can be routed through a same-side n edge and a reflected n² edge, since

    h(x)+h(y) = [h(x)−h(z)] + [h(z)+h(y)],
    z+y=2a=log(n²),  c_(n²)=c_n/√n.

Use the actual positive conductances

    w_0=c_n Φ(x)Φ(y),
    w_1=c_n Φ(x)Φ(z),
    w_2=c_(n²) Φ(z)Φ(y).

These are local conductances in the complete folded form. Its same-side n term has coefficient 2c_n; its reflected n² term integrates both endpoint orientations. To avoid assuming that different paths have disjoint budgets, first test the displayed conductances. Even granting both routed conductances twice this budget will not repair the obstruction below.

For arbitrary real endpoint values A=h(x), B=h(y), and intermediate value Z=h(z), completion of the square gives

    w_1(A−Z)²+w_2(Z+B)²
      = [w_1w_2/(w_1+w_2)](A+B)²
        +(w_1+w_2)[Z−(w_1 A−w_2 B)/(w_1+w_2)]².

Consequently the smallest constant in the pointwise rerouting comparison

    w_0(A+B)² ≤ C_n(x)[w_1(A−Z)²+w_2(Z+B)²]

is exactly

    C_n(x)=w_0(1/w_1+1/w_2)
          =[Φ(a−x)+√n Φ(x)]/Φ(x+a).                  (1)

Optimality follows by choosing the displayed minimizing Z and A+B nonzero. Doubling both available routed weights divides this constant by two. This is an algebraic conductance test, prior to any global load accounting; overlapping paths can only tighten the capacity constraint.

## Divergence with the literal theta coefficients

At x=a/2, equation (1) becomes

    C_n(a/2)=(1+√n) Φ((log n)/2)/Φ(3(log n)/2).       (2)

Use the literal positive theta series

    Φ(u)=Σ_(k≥1) [4π²k⁴ exp(9u/2)−6πk² exp(5u/2)]
                       exp(−πk² exp(2u)).

For u≥0 every summand is positive. At u=(log n)/2 its first term is

    2π n^(5/4)(2πn−3) exp(−πn)
      ≥ 2π² n^(9/4) exp(−πn),  n≥2.

The established literal Gaussian envelope has a finite positive constant A with

    Φ(u)≤A exp(9u/2) exp[−(π/2)exp(2u)],  u≥0.

Applying it at u=3(log n)/2 gives

    C_n(a/2) ≥ (2π²/A) n^(−4)
                           exp[(π/2)n³−πn] →∞.      (3)

Take n=2^k, so every tested coefficient is a genuine nonzero prime-power coefficient, including its square. Continuity makes the divergence persist on positive-width x windows for every finite proposed constant; this is not an isolated-point artifact. Thus the uniform pointwise two-edge rerouting consumer fails, even with doubled routed budgets. No omitted prime powers or replacement arithmetic weights are involved.

## Why a single-prime ladder cannot pay the norm by itself

For any fixed prime p, the smooth odd function

    H(u)=sin(2πu/log p)

has H(u+k log p)=H(u) for all integers k. Its complete p-power jump energy is zero. In the odd fold, both the same-side differences and the reflected sums vanish:

    H(x)+H(k log p−x)=0.

H is nonzero in the actual L²(2cosh(u/2)Φ(u)du) space and belongs to the full jump-form domain. Boundedness and theta moments control long jumps and the complete prime-power sum; its bounded derivative supplies the O(a²) increment bound at the continuous kernel's O(1/a) singularity. Smooth cutoffs give membership in the closed smooth-core form domain by the same bounds.

Therefore same-base powers provide a consistent signed ladder rather than a coercive odd cycle. The continuous energy and all other prime bases remain present and positive in the full form; they cannot be deleted when interpreting this example. This obstruction excludes a ladder-only norm payment, while (3) separately excludes the particular uniformly bounded n-to-n² rerouting comparison.

The companion smeared-reflection-triangle construction instead uses two continuous edges and retains an explicit cycle defect and every unused energy. Its sharp row-only calibration also fails, but a joint estimate using its row, defect, and unused energies remains open. Neither result proves RH or supplies a counterexample to the full sharp theta inequality.

Review and attribution: RH Agent2 supplied the written construction and obstruction. RH Proof independently reviewed the folded coefficients, shared capacity accounting and complete prime-power retention. The triangle equality-mode argument uses the published written odd synthesis and derivative-radical identity, including its original weighted norm and full-domain hypotheses. The prime-square ratio uses the literal first theta term and the compiled Gaussian envelope in the theta moment foundation. These functional and asymptotic arguments remain written mathematics, not compiled Lean theorems. No literature priority claim is made.

[OddTriangleConductance.lean](BuildingBlocks/OddTriangleConductance.lean) formalizes the exact three-increment cycle decomposition, the polynomial weighted route decomposition and its harmonic-conductance lower bound. This certifies the local algebra only. It does not formalize the folded integration, countable capacity packing, optimal actual theta ratio, periodic full-domain construction, or sharp-row obstruction. Those remain further Lean obligations.

For clarity, the periodic test's domain estimate can be made explicit. Literal theta domination gives Phi(u)<=C exp(-|u|). Thus for a>=0, its edge product integral is at most C^2(a+1)exp(-a). For any bounded Lipschitz H with bound M and Lipschitz constant L, the edge energy is at most min(4M^2,L^2 a^2) C^2(a+1)exp(-a). This is integrable against r(a) near zero and infinity. On every prime displacement it is bounded by a constant times Lambda(n)(log n+1)/n^(3/2), whose complete sum converges, even using Lambda(n)<=log n. The actual Hilbert measure is finite, so H also has finite norm. Smooth cutoffs with uniformly bounded derivatives approximate H in the full form norm by dominated convergence with these same bounds. This proves the stated closed smooth-core membership without claiming that a periodic test has zero continuous or other-prime energy.
