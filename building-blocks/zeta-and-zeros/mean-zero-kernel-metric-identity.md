# Mean-zero kernel metric identity

[Suzuki, *Weil’s quadratic form via the screw function*, Section 8](https://arxiv.org/html/2606.09096v1#S8) formulates the localized problem using a continuous screw kernel and the inverse Neumann metric. The generalized quotient retains the original physical L2 denominator. This source supplies an additional analytic route, not an unconditional positivity theorem at all interval sizes.

The root finite algebra formalization [MeanZeroKernelGauge.lean](../../formalization/BuildingBlocks/MeanZeroKernelGauge.lean) proves that adding f(x)+g(y)+d to a kernel does not change its quadratic sum when the real coefficients have total sum zero. Indeed each added contribution contains the factor sum c_i. No symmetry, positivity or eigenvalue hypothesis is used.

For N_a(x,y)=(x²+y²)/(4a)-|x-y|/2+a/6 and B_a(x,y)=a-max(x,y), direct algebra gives

N_a(x,y)-B_a(x,y)=[x²/(4a)+x/2]+[y²/(4a)+y/2]-5a/6.

Consequently their finite quadratic sums agree on zero-total-coefficient configurations. The algebraic identity holds for every real a with Lean's total division convention. The inverse-Laplacian interpretation requires a > 0 and its stated mean-zero interval domain.

This is a classical kernel identity with an independent Lean proof. It does not yet formalize Sobolev differentiation, interval operator domains, a generalized eigenvalue theorem, or positivity of the actual screw kernel. Those analytic identifications and the RH arithmetic constraint remain unfinished.

All three declarations independently compile using only `propext`, `Classical.choice` and `Quot.sound`, without new-module warnings.
