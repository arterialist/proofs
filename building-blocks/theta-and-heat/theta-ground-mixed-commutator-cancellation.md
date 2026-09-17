# Exact cancellation of the mixed commutator in the actual ground clock

This note tests a proposed mechanism for the score-matched covariance residual: use commutation of a continuous translation and a prime-power translation, together with their shared ground source, to force a favorable mixed correlation. The actual ground weights give an explicit nonzero rate commutator. After retaining both orientations and all holding terms, its real quadratic pairing cancels exactly. Thus this commutator supplies no signed quadratic payment for the residual. This is a mechanism failure, not a counterexample to the actual affine optimizer.

The existing `theta-distinct-prime-plaquette-residual.md` already treats the symmetric mixed product for the original theta clock, including its four-corner signed remainder and actual negative two-prime examples. Those examples do not automatically transfer to the killed ground clock. Here the distinction is resolved directly at the level of the actual ground rates; no new assertion about the sign of the ground-clock anticommutator is made.

## Actual ground rates, hard support, and finite cutoffs

Fix the actual exterior ground state and extend it by zero on the core. Put
\[
 H(u)=1_O(u)\psi(u)\Phi(u),\qquad
 c(u)=(\rho(u)b(u))^{-1}=e^{|u|/2},\qquad Z(u)=c(u)H(u).
\]
The clock is exactly \(d\gamma=H(u)c(u)^{-1}du\) on \(O\). The internal ground conductance has rate
\[
 q_a(u)=c(u)H(u+a),\quad u\in O,
 \qquad \gamma(du)q_a(u)=H(u)H(u+a)du.
 \tag{1}
\]
In particular destinations in the killed core have zero internal rate. An intermediate core visit cannot be treated as an allowed translation path.

Use a symmetric continuous displacement cutoff \(\epsilon\le |a|\le A\), and a finite set of prime powers containing both displacements \(\pm\log n\) with weight \(\Lambda(n)/\sqrt n\). Write their measures as \(\eta_c,\eta_p\). Define
\[
 I_iF(u)=\int q_a(u)F(u+a)\eta_i(da),\qquad
 d_i(u)=\int q_a(u)\eta_i(da),\qquad T_i=D_i-I_i,
 \tag{2}
\]
where \(D_i\) is multiplication by \(d_i\). On these cutoffs the operators are bounded: the fixed bounded ground state and theta decay bound \(c(u)H(u+a)\) uniformly for a bounded displacement set. Each \(T_i\) is selfadjoint in the actual clock by (1). Their holding/departure terms have not been removed.

## The actual two-path defect

Translation composition itself commutes, but its weights do not. Direct substitution in (2) gives
\[
 [I_c,I_p]F(u)
 =\iint c(u)H(u+a+b)
       [Z(u+a)-Z(u+b)]F(u+a+b)\eta_c(da)\eta_p(db).
 \tag{3}
\]
This retains every allowed intermediate endpoint through the zero extension of \(H\). The full generator commutator is
\[
 [T_c,T_p]=[I_c,I_p]+[I_p,D_c]+[D_p,I_c],
 \tag{4}
\]
with the two additional terms explicitly
\[
 [I_p,D_c]F(u)=\int q_b(u)[d_c(u+b)-d_c(u)]F(u+b)\eta_p(db),
\]
\[
 [D_p,I_c]F(u)=\int q_a(u)[d_p(u)-d_p(u+a)]F(u+a)\eta_c(da).
 \tag{5}
\]
Equations (3)--(5) keep the full holding costs at every permitted site. The internal ground transform is used here; original killed departure costs are encoded in its ground equation, rather than added a second time to (2).

## Both orientations cancel the quadratic commutator exactly

For a real bounded test \(F\), the quadratic pairing in (3) is
\[
 \iint\!\int_O H(u)H(u+a+b)[Z(u+a)-Z(u+b)]
       F(u)F(u+a+b)\,du\,\eta_c(da)\eta_p(db).
 \tag{6}
\]
Apply the measure-preserving substitution
\(u'=u+a+b, a'=-a,b'=-b\). Both displacement measures are symmetric. The endpoints interchange, the intermediate sites interchange, and the bracket changes sign. The endpoint support remains \(O\); a forbidden intermediate site still has its zero value of \(Z\). Hence (6) equals its negative and is zero. This establishes cancellation directly with the actual rates and hard support, rather than assuming constant rates or commuting incoming operators.

The first holding contribution in (5) similarly pairs as
\[
 \int\!\int_O H(u)H(u+b)[d_c(u+b)-d_c(u)]F(u)F(u+b)
       du\,\eta_p(db).
\]
Under \(u'=u+b,b'=-b\), it changes sign. The second contribution cancels by the corresponding \(a\)-substitution. Consequently
\[
 \boxed{\operatorname{Re}\langle F,[T_c,T_p]F\rangle_\gamma=0.}
 \tag{7}
\]
For complex tests the same substitutions give a purely imaginary pairing, equivalently (7) follows from skew-adjointness of the commutator of two bounded selfadjoint operators. At each finite cutoff, bounded tests are dense in L²(γ), and every operator in (2)--(5) is bounded. Continuity of the quadratic pairing therefore extends (7) to every F∈L²(γ), including the potentially unbounded common-score trial F_s. A real common source cannot recover a signed term from this imaginary part.

This proof includes all four combinations of continuous/prime orientations. It applies to any finite collection of prime powers without selecting favorable powers. Removing the cutoffs leaves identically zero scalar pairings whenever the full operator products have a justified limit. On a general full-form test, those products need not exist; their zero cutoff pairing does not license defining an unbounded commutator. In particular the established full-form membership of the actual affine trial is sufficient for its edge energies but is not an assertion that either mixed operator product acts on it.

## What the actual ground and score equations do, and what is left

The published `theta-killed-core-return-comparison.md` already retains mixed continuous/prime histories through the complete killed semigroup and its original holding and boundary costs, in its return identity (11). Its positivity is positivity of the complete excursion operator; it does not assert a sign for a separately polarized mixed jump product. The present commutator cancellation neither improves nor invalidates that complete-history identity.

The ground equation is essential for the legitimate conservative internal transform (1). It does not change the antisymmetry proof. Even if it supplies additional identities for the complete departure row, inserting those identities in (4)--(5) cannot turn (7) into a positive real quadratic quantity. Cancellation holds for the actual ground before using any estimate of its size, derivative, or normalization.

In the notation of `theta-affine-comparison-conditional-edge-energy.md`, retain its single common coefficient and set \(F_s=v_U-s\varphi\). The conditional residual is
\[
 n[v_U]=\min_s\{R_c[F_s]+R_p[F_s]\},
\]
where each \(R_i\) includes its same-half energy and centered crossing variance. At every finite cutoff, (7) holds for every \(F_s\), hence also at the actual common coefficient whenever its operator-product use is legitimate. It imposes no favorable restriction on that coefficient or on either retained variance.

The symmetric mixed observable, when defined, is instead
\[
 2\operatorname{Re}\langle T_cF_s,T_pF_s\rangle
 =\langle F_s,(T_cT_p+T_pT_c)F_s\rangle.
 \tag{8}
\]
Equation (7) concerns the difference of these products, not their sum. Neither (3) nor the ground equation by itself assigns a sign to (8). Moreover (8) is a higher-action observable; the residual being estimated is a first-form sum. A proposed use of (8) would need an additional inequality connecting it to that sum with all continuous, clock-weight, boundary, minorant, and rank-subtraction costs retained. The finite component and score rank subtractions likewise remain in \(R_i\); their mixed products cannot be dropped when passing from \(T_i\) to residual actions.

The result is an actual-kernel realization of classical skew-adjoint commutator cancellation, with explicit actual rate and holding terms. It supplies no substantive new arithmetic restriction and no signed correlation estimate beyond Cauchy--Schwarz. A useful continuation must estimate the symmetric weighted mixed product or directly the complete conditional edge residual. The coherent score-action covariance is already controlled, the actual optimizer has its required full-form domain, and smallness of the remaining full arithmetic residual remains open. No sharp theta gap or RH conclusion follows.

## Compiled pointwise algebra and remaining analytic scope

[GroundRateCommutator.lean](../../formalization/BuildingBlocks/GroundRateCommutator.lean) formalizes four exact real pointwise identities: the incoming two-path defect (3), the incoming/holding defect, the full generator defect including both holding rows (4)--(5), and reversal antisymmetry of the density-cancelled two-path pairing (6). Its incoming displacement is c(u)H(u+a)F(u+a). The identities hold for arbitrary real functions c,H,F and departure profiles, so zero extension on the hard core and the actual ground-rate specialization do not require modifying the algebra. Every displacement is retained; no restriction to selected primes or orientations enters these identities.

The covariance branch supplied the actual-rate calculation and mechanism analysis. Root independently reviewed the full generator signs, support reversal and cutoff argument and supplied these four Lean proofs. The continuum measure-preserving substitutions, complex L2 operator argument, actual ground transform identification and unbounded operator-product limits are written arguments here and remain further formalization obligations. The pointwise Lean identities do not certify those analytic steps or construct the killed ground. This is a formalization of the algebra underlying classical commutator cancellation, with no novelty or RH claim.
