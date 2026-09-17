# Global smeared reflection-triangle packing in the actual odd theta form

A reflected prime edge can be joined to two continuous difference edges through a smeared third vertex. The odd sign forces a nonzero cycle sum. This gives a rigorous global capacity-packing inequality with exact coefficients, all prime powers, and explicit unspent energy. The row-only sharp calibration of this particular packing is impossible; joint use of its row and unspent energies remains open.

This construction uses continuous edges for the other two sides of the triangle. It differs from rerouting through a power of the same prime.

## Actual complete folded energy

Write b(x)=2cosh(x/2), m(x)=b(x)Φ(x), λ=1/2, l_n=log n and w_n=Λ(n)/√n. For a real odd potential restrict h to x>0; its full norm is 2∫m h². Every n≥2 is retained. The energy is

E[h] = ∫∫ Φ(x)Φ(z)r(|x−z|)(h(x)−h(z))² dx dz
       + ∫∫ Φ(x)Φ(z)r(x+z)(h(x)+h(z))² dx dz
       + Σ_n w_n {2∫₀∞ Φ(x)Φ(x+l_n)(h(x+l_n)−h(x))² dx
                   +∫₀^{l_n} Φ(x)Φ(l_n−x)(h(x)+h(l_n−x))² dx}.   (1)

Both double integrals run over positive x,z; r(a)=e^(−a/2)/(1−e^(−2a)). In particular the original continuous same-half difference energy has unordered edge capacity

C(s,t)=2Φ(s)Φ(t)r(|s−t|), s<t.   (2)

This uses the original positive energy, not positivity of a folded net offdiagonal kernel. Oddness does not impose the beta constraint; no pole constraint is silently added.

## A global packing with actual capacities

Choose measurable t_n(x,z)≥0 supported on 0<x<l_n,z>0, symmetric under x↔l_n−x, and extended by zero elsewhere. Require

T_n(x):=∫₀∞ t_n(x,z)dz ≤ c_n(x):=w_nΦ(x)Φ(l_n−x),   (3)

L(s,t):=2Σ_n[t_n(s,t)+t_n(t,s)] ≤ C(s,t), s<t.   (4)

Each triangle has vertices x,y=l_n−x,z, and uses difference edges (x,z),(y,z) and reflected sum edge (x,y). Symmetry of t_n makes the two directed difference loads identical. Passing to unordered edges adds the (s,t) and (t,s) loads, proving the factor two in (4). The reflected energy in (1) already integrates the full x∈(0,l_n) rectangle, so its budget is precisely (3), with no further factor.

All prime powers compete for the same continuous capacity in (4). These constraints form a testable linear packing problem on actual densities, without an unknown spectral inverse or an equivalent formulation of the desired gap. For example t_n=c_n(x)p_n(z|x) uses probability subdensities ∫p_n≤1 symmetric in reflected endpoints; (4) is the remaining loading test. Compact windows away from zero give nonzero finite routings after sufficiently small common scaling when the loading ratio is bounded. Countable families are legitimate under (3)–(4). Setting a routing to zero never deletes that prime-power energy from (1).

## Exact cycle payment and defect

Put a=h(z)−h(x), b=h(x)+h(y), d=h(z)−h(y). Then a+b+d=2h(z), giving the exact identity

a²+b²+d² = (4/3)h(z)² +(1/3)[(a−b)²+(a−d)²+(b−d)²].   (5)

Thus define

W(z)=(4/3)Σ_n∫₀^{l_n}t_n(x,z)dx,

D_triangle[h]=(1/3)Σ_n∫∫t_n(x,z)[(a−b)²+(a−d)²+(b−d)²]dx dz.   (6)

Accounting for the allocated edges before using (5) gives the exact complete identity

E[h]=∫₀∞ W(z)h(z)²dz + D_triangle[h]
      + E_cont_unused[h] + E_prime_reflected_unused[h]
      + E_cont_reflected[h] + E_prime_same[h].   (7)

Here E_cont_unused integrates (C−L)(h(s)−h(t))² over s<t. E_prime_reflected_unused is Σ_n∫₀^{l_n}(c_n−T_n)(h(x)+h(l_n−x))²dx. The final two terms are exactly the second continuous integral and the complete same-half prime sum in (1). Every term is nonnegative; every prime power and both orientations remain. In particular a feasible W≥2κm gives E[h]≥κ||h||² on the odd space, while (7) retains the more informative spatial row and its complete costs.

There is no pointwise trace estimate here. The reflected value h(l_n−x) is the original translation trace integrated in x. Only the third vertex z is smeared. Reflection preserves null sets, so the terms depend only on the Hilbert representative. Replacing the reflected trace by a window average would require additional difference-edge payment and is not justified by (5).

For any full-form h, (3)–(4) bound the sum of allocated increment squares by E[h]. Equation (5) bounds ∫Wh² and D_triangle by this sum. All unused energies are submeasures of the actual energy. Nonnegative integration therefore proves (7) on the complete odd form domain, without differentiability, a finite continuous jump rate, or mixed operator products. A restriction to a window J retains the exact complement ∫_{Jᶜ}Wh² and its routed defects. Dropping those terms gives only a window coercivity conclusion. Boundary endpoints 0,l_n are null and are never promoted to point constraints.

## A decisive counterexample to the row-only sharp target

Because the full odd norm contains a factor two, the row-only threshold target λ=1/2 would be W≥m. No densities satisfying (3)–(4) can meet that target.

The published theta-odd-zero-mode-synthesis.md provides the actual nonzero odd equality eigenvector

e₁=q₃−q₁/4, q_j=Φ^(j)/Φ, E[e₁]=(1/2)||e₁||².   (8)

It belongs to the full form domain and has beta zero. Its same-half n=2 energy is strictly positive. Otherwise positivity of Φ forces e₁(x+log2)=e₁(x) almost everywhere on x>0; smoothness gives genuine periodicity. But theta derivative asymptotics have leading terms q₃(x)∼(−2πe^(2x))³ and q₁(x)∼−2πe^(2x). Thus e₁ is unbounded at positive infinity and cannot be periodic. Consequently E_prime_same[e₁]>0.

If W≥m, the first term in (7) at e₁ is already at least (1/2)||e₁||². The strictly positive retained same-half q=2 energy makes the right side larger, contradicting (8). This disproves the row-only sharp calibration of this particular equal-conductance smeared triangle packing using one actual theta test. It does not disprove (7), the full gap, or more elaborate triangle mechanisms.

More precisely, every feasible packing satisfies the necessary equality-mode calibration

    ∫₀∞ (m(z)−W(z))e₁(z)² dz
      = D_triangle[e₁]+E_cont_unused[e₁]+E_prime_reflected_unused[e₁]
        +E_cont_reflected[e₁]+E_prime_same[e₁]
      ≥ E_prime_same,n=2[e₁] > 0.

Both integrals defining the signed difference are finite, since the allocated row is bounded by the finite energy. Hence W<m on a positive-measure set where e₁ is nonzero. A joint sharp estimate must pay this actual weighted row deficit with the retained defect and unused energies; it cannot assume the deficit away.

In particular the combined row, defect, and unspent energies could conceivably reach λ=1/2; the argument does not exclude that global coupling. A successful use would have to respect equality-mode cancellation rather than require the allocated row alone to pay the entire sharp norm. The existing odd synthesis and two-halfline score failure leave the complete sharp gap open. No RH conclusion follows.

Review and attribution: RH Agent2 supplied the written construction and obstruction. RH Proof independently reviewed the folded coefficients, shared capacity accounting and complete prime-power retention. The triangle equality-mode argument uses the published written odd synthesis and derivative-radical identity, including its original weighted norm and full-domain hypotheses. The prime-square ratio uses the literal first theta term and the compiled Gaussian envelope in the theta moment foundation. These functional and asymptotic arguments remain written mathematics, not compiled Lean theorems. No literature priority claim is made.

[OddTriangleConductance.lean](../../formalization/BuildingBlocks/OddTriangleConductance.lean) formalizes the exact three-increment cycle decomposition, the polynomial weighted route decomposition and its harmonic-conductance lower bound. This certifies the local algebra only. It does not formalize the folded integration, countable capacity packing, optimal actual theta ratio, periodic full-domain construction, or sharp-row obstruction. Those remain further Lean obligations.
