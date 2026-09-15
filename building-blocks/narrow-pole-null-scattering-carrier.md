# A narrow carrier with both pole moments zero

For any real L > 0, choose a smooth real bump kappa, equal to one at zero and supported in (-L/32,L/32). Put epsilon=L/8 and C=exp(epsilon/2)+exp(-epsilon/2). The carrier

eta(v)=kappa(v)-C kappa(v-epsilon)+kappa(v-2epsilon)

is smooth, compactly supported in (-L/32,9L/32), and equals one at zero. Its support width is 5L/16, strictly less than L. The two displaced bumps vanish at zero.

For the literal weighted integral M_s(f)=integral f(v)exp(sv)dv, translation gives M_s(f(v-d))=exp(sd)M_s(f). Compact support and continuity establish integrability before splitting the carrier integral. Thus

M_s(eta)=M_s(kappa)[1-C exp(s epsilon)+exp(2s epsilon)].

The bracket vanishes at s=1/2 and s=-1/2 because exp(epsilon/2)exp(-epsilon/2)=1. Complex lifting preserves these exact moments. The squared complex norm is integrable and has strictly positive integral, since the real square is continuous, nonnegative and nonzero at zero.

[NarrowPoleNullPacket.lean](BuildingBlocks/NarrowPoleNullPacket.lean) formalizes this construction in fifteen checked declarations. The carrier proof was supplied by the scattering research branch and independently reviewed and compiled. No novelty claim is made for smooth bump construction or exponential-moment annihilation.

The root integration theorem `exists_prime_amplifying_narrow_carrier` in [CompactScatteringOperator.lean](BuildingBlocks/CompactScatteringOperator.lean) takes any prime p and finite history depth M >= 1, sets L=log p, constructs this carrier and a finite phase box, and proves that the complete physical output square exceeds the input square. Every output boundary coefficient remains in the norm sum. Carrier existence, width, integrability and positive mass are proved rather than assumed.

[CompactScatteringRegularity.lean](BuildingBlocks/CompactScatteringRegularity.lean) proves preservation of smoothness, compact support and zero pole moments under arbitrary finite weighted translate sums. Its `exists_prime_smooth_pole_null_amplification` constructs an actual smooth compact function f with both pole moments zero and strict gain under the complete finite physical operator, for every prime and every depth M >= 1. It does not prove an estimate for the actual arithmetic source, an infinite prime product, the full Weil form, or RH.

Independent central compilation checks the fifteen carrier declarations and the new integration theorem using only `propext`, `Classical.choice` and `Quot.sound`. Both changed modules emit no warnings.

The root regularity proof uses the actual finite coefficient expansion. Translation preserves compact support by a homeomorphism, multiplication by a constant preserves it, and finite addition gives compact support by induction. The chain rule and finite-sum differentiation preserve smoothness. Each translated weighted integrand is integrable by continuous compact support. Splitting its integral and translating Lebesgue measure gives M_s(f(v-d))=exp(sd)M_s(f); hence a finite linear combination preserves each zero moment. These statements apply to arbitrary complex coefficients and real translate spacing. All seven regularity declarations independently compile with the same standard axioms and no new-module warnings.
