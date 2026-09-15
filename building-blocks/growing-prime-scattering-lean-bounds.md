# Finite growing-prime scattering bounds in original notation

[GrowingPrimeScatteringBounds.lean](BuildingBlocks/GrowingPrimeScatteringBounds.lean) retains the original finite history

v(p,z,M)=-p^(z-1/2)+(1-p^(-1)) sum_(0<=j<M) p^(-j(z+1/2))

and the original rational defect

d(p,z,M)=(1-p^(-1))p^(-M(z+1/2))/(1-p^(z-1/2)).

The complex powers use the positive real base p. Their exact exponential dictionary is proved for every complex z and every positive real p, including every history index. No critical-line location is assumed.

For natural p >= 2 and |Re z| <= 1/2, the entire paired multiplier a_p(z)=v(p,z,M)v(p,-z,M) has norm at most three, independently of M. The proof uses the [complete paired identity](BuildingBlocks/PairedScatteringDefect.lean) and its symmetric exponential moment, including the endpoint at depth M. Hence any finite block s satisfies |A_s(z)| <= 3^card(s), where A_s is the product of a_p over the entire block.

For an interior gap delta > 0 with |Re z| <= 1/2-delta, both rational denominators are nonzero and

a_p(z)=(1-d(p,z,M))(1-d(p,-z,M)),

|d(p,z,M)| <= B_p=exp(-M delta log p)/(1-exp(-delta log p)).

The reciprocal rational factors cancel exactly. The product estimate

|product(1-d_i)-1| <= product(1+|d_i|)-1 <= exp(sum |d_i|)-1

then gives |A_s(z)-1| <= exp(sum_(p in s)(2B_p+B_p^2))-1. If every p in the block is at least P > 1, the module also proves the uniform bound B_p <= exp(-M x)(1+x)/x with x=delta log P, using 1-exp(-x) >= x/(1+x). Thus the block defect is at most exp(card(s)(2B+B^2))-1 with this explicit B.

For arbitrary complex weights w_i with sum |w_i| finite, filtering by the full block preserves summability and

sum A_s(z_i)w_i - sum w_i = sum (A_s(z_i)-1)w_i.

All points may lie anywhere in the closed half strip. Splitting at an arbitrary index subset L gives the bound

E sum_(i in L)|w_i| + (3^card(s)+1) sum_(i outside L)|w_i|,

provided E bounds the low-subset defect. Every index and both orientations remain present. Absolute summability is an explicit hypothesis, not a consequence of the multiplier estimate.

The scattering research branch supplied this formalization, independently reviewed with its published paired-identity dependency. These are elementary product, geometric-history and norm bounds; no novelty claim is made. The module has thirty-one printed declarations.

Independent central target compilation checks all thirty-one declarations using only `propext`, `Classical.choice` and `Quot.sound`, without warnings in the new module.

The actual-zero interior gap, zero weights and multiplicities, dyadic prime count, full explicit formula, archimedean comparison and signed arithmetic estimate remain separate obligations. The bounds permit off-critical points and supply no sign for the actual arithmetic readout. RH remains unproved.
