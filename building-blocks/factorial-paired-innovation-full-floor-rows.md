# Paired factorial innovations: complete parity rows and retained terminal covariance

The actual dyadic innovation has an entire family of zero even floor rows, not only its first moment −1. Across all proper quotient histories the complete innovations also sum to zero, forcing a negative integrated aggregate cross correlation. These structural constraints do not enforce a nonpositive correlation of the distinguished innovation with terminal admissions: an actual N=5 example disproves that scalar damping candidate. No energy doubling bound follows from the aggregate cancellation alone.

## Actual full innovation and its floor rows

Keep f_a(t)=1−e^(−at), the original complete factorial weight w(t)=t^(−2)−[t(e^t−1)]^(−1), and the literal Möbius responses g_N. For N≥1 and n≤2N put

q_n=floor(N/n), ε_n=floor(2N/n)−2q_n∈{0,1}.

The full innovation is

d_N(t)=g_(2N)(t)−g_N(2t)
      =f_1(t)Σ_{n≤2N}μ(n)ε_n e^(−2q_n t).   (1)

Every old and newly admitted divisor history is retained. Define c_q=Σ_{n≤2N:q_n=q}μ(n)ε_n. Expanding (1) in the original basis f_a gives paired coefficients D_(2q)=−c_q and D_(2q+1)=c_q for q≥1, plus D_1=c_0 because f_0=0. In particular c_0=M(2N)−M(N) is the actual far-clock terminal value. Its contribution is not silently replaced by a new coefficient vector.

For every integer j≥1, finite termwise floor differences give the exact complete innovation row

Σ_a D_a floor(a/j)
 =Σ_{n≤2N}μ(n)ε_n 1_{j | (2q_n+1)}.   (2)

Indeed increasing 2q by the single carry ε changes floor(2q/j) precisely when ε=1 and j divides 2q+1. Thus ALL EVEN rows in (2) vanish. The first row is Σμ ε=−1, while the odd rows retain their actual divisibility loading. This is a compatibility of the paired sizes before absolute values; there is no assumed independence of the two scales or deletion of prime-power/divisor coefficients. Vanishing even rows alone does not determine the odd rows or the innovation energy.

## All quotient innovations and a global integrated constraint

For k≤2N put q_k=floor(N/k), e_k=floor(2N/k)−2q_k. Define d_(q,e)=g_(2q+e)(t)−g_q(2t), with g_0=0. Subtracting the two complete finite renewal laws gives

Σ_{k=1}^{2N}d_(q_k,e_k)(t)=0.   (3)

The forcings agree exactly at f_(2N); they do not disappear by approximation. All N terminal indices N<k≤2N have q_k=0,e_k=1, so their contribution is N g_1. Consequently the old-history bundle obeys

Σ_{k≤N}d_(q_k,e_k)=−N g_1.   (4)

With the full inner product ⟨u,v⟩_w=∫₀∞u(t)v(t)w(t)dt, all terms are finite: each finite response is O(t) at zero and bounded at infinity. Expanding (3) yields the actual integrated aggregate constraint

Σ_{k≠l}⟨d_(q_k,e_k),d_(q_l,e_l)⟩_w
       =−Σ_k||d_(q_k,e_k)||²_w.   (5)

The ordered pairs include repeated quotient histories. Their individual correlations need not be negative. If the terminal copies are grouped first, (4) instead gives

Σ_{k,l≤N}⟨d_(q_k,e_k),d_(q_l,e_l)⟩_w
       =N² B(1,1)=N²log2.   (6)

Thus the old bundle itself has a positive quadratic reserve of order N². The zero sum does not bound the distinguished d_N from above: other proper-division innovations can cancel it coherently. Reinterpreting (5) as an upper bound without estimating that cancellation would be a tautology, not arithmetic damping.

## A discriminating terminal-admission damping candidate fails

A specific additional scalar proposal is that the distinguished innovation must oppose the new terminal history:

⟨d_N,g_1⟩_w≤0 for every N.   (7)

This is different from comparing d_N to the old response g_N(2t), and is not the already open full doubling-work budget. It tests whether the complete parity rows and proper-division balance force a sign on this particular admission channel.

For actual N=5, retaining the full μ tables through 10 gives

g_10=f_10−f_5−f_3−f_2+f_1,
g_5(2t)=f_10−f_4−2f_2,
d_5=f_4+f_2+f_1−f_5−f_3.

Its entire floor row vector is (−1,0,−1,0,−1) for j=1,...,5 and zero thereafter. It therefore satisfies the zero even rows and all actual odd loads in (2).

The actual complete quotient compatibility at this horizon is

d_(5,0)+d_(2,1)+d_(1,1)+2d_(1,0)+5g_1=0.   (8)

Using the original complete factorial kernel B(a,1)=a log(1+1/a), the admission correlation is exactly

⟨d_5,g_1⟩_w
 =4log(5/4)+2log(3/2)+log2−5log(6/5)−3log(4/3)
 =log(5^9/2^20)>0,

because 1953125>1048576. This disproves (7) on the actual full coefficient system; the aggregate cancellation (8) remains exact. Other innovations compensate the positive distinguished terminal port. No terminal term, reverse ordered cross term, density compensation, or divisor history is omitted.

Equations (2)–(6) are genuine full arithmetic compatibility constraints. The N=5 calculation shows that they do not supply this particular scalar damping sign. A useful upper estimate must control the actual proper-division reserve and all signed correlations, possibly together with the real first-cell Mertens trace; neither replacing that reserve by absolute values nor merely invoking its zero total proves a subpower bound. The stronger diagonal hypothesis is not used here. No claim about the surviving weaker energy target or RH is inferred from this note.

This is written mathematics using the published finite-renewal, binary-carry and complete factorial-kernel identities. It supplies no new compiled Lean theorem or unconditional energy upper bound.

Independent publication review checked the full quotient renewal, the retained N terminal copies, the parity-row identity and both exact logarithmic correlations. The companion [rational certificate](factorial-paired-damping-certificate.py) reconstructs the actual Möbius responses and verifies the N=3 and N=5 claims without quadrature. This certificate checks those finite examples; the general identities are the written algebraic proofs above. Lean formalization of these additional paired-scale identities remains pending.

[Formal complete paired quotient renewal](BuildingBlocks/FactorialPairedRenewal.lean) adds four compiled theorems. Complete response renewal extends to every larger natural cutoff by retaining the zero quotient histories. Subtracting the actual renewal at 2N from the actual renewal at N with clock 2t gives zero total paired response; the same identity holds for the literal carry innovations with quotient N/k and carry( N,0,k ). Every terminal history N<k≤2N contributes exactly the original unit response. The statements hold for all real t and natural N, including N=0 where applicable. The full umbrella build passes with only propext, Classical.choice and Quot.sound. The zero even floor rows, integrated covariance and grouped terminal reserve, exact finite damping failures and RH-scale upper estimate remain additional formal obligations. These complete-history identities supply no arithmetic energy upper bound.

[Formal retained terminal sum and old-history reserve](BuildingBlocks/FactorialPairedRenewal.lean) adds three compiled theorems. The complete N terminal quotient responses sum to N g₁(t), the actual old-history bundle equals −N g₁(t), and its entire positive-clock energy against the original compensated density is exactly N² log 2. The proof partitions the complete quotient cutoff into disjoint old and terminal intervals, uses the actual paired renewal, and integrates the original unit kernel. It holds for every natural N, including zero, and every real t in the pointwise identities. The full umbrella build passes with only propext, Classical.choice and Quot.sound. This discharges the grouped terminal reserve obligation; even floor-row formalization, the full integrated covariance identity, the finite damping counterexamples and an RH-scale arithmetic upper estimate remain further obligations. The quadratic terminal reserve is an exact identity, not the required upper bound on a selected innovation.

[Formal complete paired floor rows](BuildingBlocks/FactorialPairedFloorRows.lean) adds four compiled theorems. The single floor increment at paired sizes 2q and 2q+1 equals the exact divisibility indicator. The original dyadic innovation floor row, defined with all actual Möbius coefficients and natural quotient sizes through 2N, equals the complete signed carry-weighted sum of those indicators. Every even row vanishes, including the total-division row zero; for every positive N the first row is exactly −1. The odd rows retain their actual divisibility loading. The full umbrella build passes using only propext, Classical.choice and Quot.sound. These discharge the complete parity-row and first-mass obligations, without assuming independence or discarding terminal histories. Integrated covariance and the finite damping failures remain further formal obligations, and no RH-scale arithmetic energy upper bound follows from these rows alone.

[Formal complete ordered paired covariance rows](BuildingBlocks/FactorialPairedCovariance.lean) adds three compiled theorems. For any zero-sum finite real family the full ordered offdiagonal product sum equals minus the sum of squares. Its actual paired quotient specialization retains every index through 2N, terminal copies, repeated quotient histories and both cross-term orders. The entire positive-clock integral of the summed cross row against the original compensated weight equals minus the integral of the summed square row. The full umbrella build passes with only propext, Classical.choice and Quot.sound. This is the pointwise covariance identity and its aggregate Bochner integral corollary; the subsequent extension below proves absolute integrability of every port product and exchanges both finite sums with individual clock integrals. The finite damping failures and RH-scale upper bound remain further obligations. Aggregate negativity does not sign a selected port.

[Formal absolute product integrability and full integrated covariance](BuildingBlocks/FactorialPairedCovariance.lean) adds four compiled theorems. Every finite signed natural-scale exponential bilinear row is absolutely integrable against the complete compensated factorial density. This specializes to products of actual Möbius responses at arbitrary natural clock scales, and then to every actual paired quotient port product. Both finite-sum exchanges are justified, proving that the full sum of individual ordered offdiagonal clock correlations equals minus the sum of individual port energies. All quotient histories, terminal copies, signed coefficients, cross-term orders and the entire positive-clock domain remain. The full umbrella build passes with only propext, Classical.choice and Quot.sound. This discharges the individual-product integrability and integrated covariance obligations. The exact damping failures remain to be formalized, and the RH-scale arithmetic upper bound remains unproved; full aggregate negativity does not sign a selected port.

[Formal actual paired example responses](BuildingBlocks/FactorialPairedExamples.lean) adds nine compiled theorems: exact natural-exponent conversion, full response polynomials at 3, 5, 6 and 10, actual paired innovation polynomials at N=3 and N=5, strict negativity of the N=3 innovation at every positive clock time, and the exact N=5 value 11/32 at t=log 2. All finite coefficients come from the existing compiled actual Möbius table through 13; every newly admitted history is retained before cancellation. The full umbrella build passes using only propext, Classical.choice and Quot.sound. These discharge the response/coefficient identification prerequisites for the damping examples. Their integrated positive-correlation formulas and sign counterexamples remain additional formal obligations. A pointwise negative innovation does not determine its correlation with a signed old response; no RH-scale energy upper bound follows.

[Formal full bilinear response kernel dictionary](BuildingBlocks/FactorialResponseBilinear.lean) adds five compiled theorems: the complete ordered finite signed bilinear row, its full positive-clock kernel integral formula with both finite-sum exchanges justified, the exact actual response basis at every natural clock scale, the complete actual cross-response integral formula, and the original old-response × dyadic-innovation correlation as the difference of two complete signed kernel sums for every N. Natural quotient sizes, actual Möbius coefficients, all ordered pairs, both clock scales and the original compensated density remain. The full umbrella build passes with only propext, Classical.choice and Quot.sound. This supplies the analytic and coefficient dictionary needed to evaluate the damping examples. Simplifying those finite kernel sums to their exact logarithmic values and proving the corresponding sign failures remain formal obligations; no uniform RH-scale arithmetic upper estimate is proved.

[Formal actual N=3 old-response damping failure](BuildingBlocks/FactorialPairedDampingFailure.lean) adds four public compiled theorems. The complete original old-response correlation is 10 log 2 + 8 log 5 − 18 log 3 = log(400000000/387420489), hence strictly positive. This refutes the universal nonpositive old-response × dyadic-innovation damping sign on the actual Möbius system. The proof uses the original full bilinear kernel dictionary, the compiled actual Möbius table, all signed quotient pairs and exact integer/logarithm arithmetic; its positive-clock integrability is already proved. The full umbrella build passes with only propext, Classical.choice and Quot.sound. This discharges the N=3 integrated correlation and sign-counterexample obligations. The N=5 terminal-admission failure remains to be formalized. The result refutes this particular damping sign, not a compensated multiscale bound or RH; the RH-scale upper estimate remains unproved.

[Formal actual N=5 terminal-admission damping failure](BuildingBlocks/FactorialPairedDampingFailure.lean) adds four public compiled theorems. The full original correlation of the dyadic innovation with response 1 is 9 log 5 − 20 log 2 = log(1953125/1048576), hence strictly positive. This refutes the universal nonpositive terminal-admission correlation sign on the actual Möbius system. Both full signed product integrals are evaluated through the exact bilinear kernel dictionary, with all natural quotient histories, the actual Möbius table and the complete compensated positive-clock density retained. The full umbrella build passes; the four proofs use only propext, Classical.choice and Quot.sound. Together with the N=3 result, this discharges both stated local integrated damping counterexamples. No compensated multiscale energy upper bound or proof of RH follows; the required arithmetic upper estimate remains open.
