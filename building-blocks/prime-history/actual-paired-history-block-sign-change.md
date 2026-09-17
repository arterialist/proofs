# Exact sign change in the actual paired-history block correction

Written mathematics by RH Proof, independently audited by RH Agent3. This concerns the finite compact
scattering history kernel itself. It neither signs the Weil functional
nor refutes a bound for its actual arithmetic readout.

For a prime p and an integer M>=1, put r_p=p^(-1/2), c_p=1-r_p^2
and L_p=log p. The exact local paired kernel from RH Agent3's finite
coefficient calculation is

    K_p=(1-c_p r_p^(2M)) delta_0
        -c_p sum j=1..M r_p^(2M-j)
             (delta_(j L_p)+delta_(-j L_p)).

Its bilateral transform is the product of the two actual compact
multiplier polynomials v_p(z)v_p(-z). The endpoint coefficients at
both +/-M L_p are -c_p r_p^M. Every coefficient here is exact.

Take a finite set B of distinct primes, with at least two members,
and form the literal convolution K_B=*_(p in B) K_p. Distinct tuples
of integer history coordinates (j_p) yield distinct locations
sum j_p log p. Indeed equality would give product p^(j_p-k_p)=1;
clearing negative powers and unique prime factorization force each
j_p=k_p. Thus no other tuple can cancel any of the following atoms.

Write a_p=1-c_p r_p^(2M)>0 and b_p=c_p r_p^M>0. For p in B the
coefficient at M log p is exactly

    -b_p product over q in B\{p} of a_q <0.

For distinct p,q in B the coefficient at M(log p+log q) is exactly

    b_p b_q product over ell in B\{p,q} of a_ell >0.

Both locations are nonzero, so subtraction of delta_0 changes neither
coefficient. Therefore the actual correction K_B-delta_0 is a signed
measure having both positive and negative atoms. The conclusion holds
for every such prime block and every M>=1, without an asymptotic limit.

The exact origin coefficient of K_B is product a_p. It is distinct
from the total mass. The latter equals

    product over p in B of [1-(1+r_p)r_p^M]^2.

This follows by evaluating each finite multiplier at zero. These
quantities must not be interchanged when estimating a correlation.

Consequently positivity of the separate symmetric defect measures
D_p=delta_0-K_p does not imply that the complete block correction is
positive or negative. The alternating inclusion-exclusion terms include
actual two-prime joint histories with positive coefficients. A bound
or sign for Q(V_B f)-Q(f) still needs the Weil functional on the shifted
correlations, with its full archimedean and prime-power terms retained.
No conclusion about that scalar sign or RH follows from this exact
history-measure sign change.
