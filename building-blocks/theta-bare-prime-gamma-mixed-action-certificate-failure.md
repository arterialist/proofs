# Bare complete prime–gamma mixed-action certificate: collisions, calibration, and failure

A possible nonlocal arithmetic certificate uses the commuting physical gamma multiplier and complete prime translations, rather than finite-vertex squares. Its equality calibration is exact, but its signed mixed-action premise fails on actual compact odd tests before the prime cutoff is removed. The complete theta energy remains legitimate. The failed operation is passage to bare unweighted mixed action norms without the original clock and holding/pole compensations.

## Explicit candidate and the intended sufficiency argument

Use the unnormalized ground measure dnu=b(u)Phi(u)du, b(u)=2cosh(u/2), and the corresponding complete jump energy E. This distinguishes the Hilbert-space norm here from the normalized probability convention in the introductory theta chapter. Use the actual physical gamma operator A with multiplier

a(t)=Re ψ(1/4+it/2)−logπ, a₀=a(0)<0.

Put w_n=Λ(n)/√n and

S_N f(u)=Σ_{2≤n≤N}w_n[f(u+log n)+f(u−log n)].

Every prime power and both orientations enter; zero von Mangoldt terms vanish. Let d>−a₀, A_d=A+dI, S_{N,d}=S_N+dI. The bare mixed-action certificate candidate is

0 ≤ lim_N Re⟨A_d f,S_{N,d}f⟩ ≤ ||A_d f||²,   (1)

on physical f=Φh arising from the actual mean-zero full theta form tests, with limits and extension to the required commuting spectral class justified. In a genuine commuting selfadjoint realization with A_d>0, the upper inequality on a full common spectral test class makes A_d(A_d−S_d) nonnegative. The positive multiplier A_d could then be canceled in joint spectral calculus, giving A−S≥0. The actual identity

E[h]−λ||h||²_ν=⟨Φh,(A−S)Φh⟩, λ=1/2,   (2)

would imply the sharp bound on centered h. Equation (1) is an explicit stronger cross-action condition, not an asserted equivalent theta criterion or an unknown theta inverse. The cancellation argument requires the stated realization and spectral-test extension; those conditions are not supplied by mere local translation commutation. In fact (1) itself already fails on the actual compact odd core, as proved below.

## Exact multiplicative collisions in the two-sided action square

For real f let C_f(a)=∫f(u)f(u+a)du. Finite expansion gives

||S_N f||²=2Σ_{n,m≤N}w_nw_m
                [C_f(log(n/m))+C_f(log(nm))].   (3)

The ratio terms come from the two equal-sign translations; product terms from the two opposite-sign translations. Both orientations, repeated powers, n=m, and multiplicative coincidences are retained. Product collisions nm=k have weight Λ(n)Λ(m)/√k; ratio collisions retain all common factors n=jp,m=jq, with weight Λ(jp)Λ(jq)/(j√(pq)). No independence of prime histories is assumed.

For any nonzero nonnegative compact smooth f all terms in (3) are nonnegative, so

||S_N f||²≥2||f||²Σ_{n≤N}Λ(n)²/n→∞.   (4)

Euler divergence of Σ_p1/p suffices for this divergence; no PNT is needed. This observation diagnoses the unweighted action problem. A nonnegative compact f is not itself a centered odd test; the decisive counterexample to (1) uses a compact odd f below.

## Exact signed mixed tails and a compact odd counterexample

For real compact smooth f put M_±=∫e^(±u/2)f(u)du. The full gamma jump kernel is r(a)=e^(−a/2)/(1−e^(−2a)). The digamma integral representation in [DLMF 5.9.16](https://dlmf.nist.gov/5.9.E16), after subtracting its value at 1/4 and changing variables t=2a, gives a(xi)-a(0)=2 integral_0^infinity r(a)(1-cos(xi*a))da. Thus outside the compact support its action is

Af(u)=−∫r(|u−v|)f(v)dv.

The local compensated singularity remains in A; only this off-support evaluation uses an ordinary integral. Expanding the actual tail r(a)=e^(−a/2)+O(e^(−5a/2)) gives

Af(u)=−M_+e^(−u/2)+O_f(e^(−5u/2)), u→+∞,
Af(u)=−M_-e^(u/2)+O_f(e^(5u/2)), u→−∞.

Consequently, for large n,

⟨Af,f(·+log n)+f(·−log n)⟩
       =−2M_+M_- n^(−1/2)+O_f(n^(−5/2)).

After multiplying by w_n and summing the complete cutoff this proves

Re⟨Af,S_N f⟩=−2M_+M_-Σ_{n≤N}Λ(n)/n+O_f(1).   (5)

The error is bounded because ΣΛ(n)/n³ converges. The shift d in (1) changes (5) by a bounded amount: compact support makes ⟨f,S_Nf⟩ stabilize, while ⟨A_df,f⟩ is fixed.

For f≥0 nonzero, M_+M_->0, and this mixed pairing tends to −∞. Thus blanket nonnegativity of bare gamma–prime mixed action is explicitly false at sufficiently large finite cutoffs.

For the relevant centered class choose a compact smooth odd f supported in two small reflected intervals about v and −v, v>0, positive in the right interval and negative in the left. Then M_- =−M_+ and M_+≠0. Formula (5) instead gives

Re⟨A_df,S_{N,d}f⟩=2M_+²Σ_{n≤N}Λ(n)/n+O_f(1)→+∞.   (6)

Again Euler divergence suffices. The actual h=f/Φ is compact smooth and odd, hence ν(h)=0 and belongs to the full actual form domain. Its ||A_df||² is finite. Therefore the upper mixed-action inequality in (1) fails already for some finite N, and its full-cutoff limit cannot hold on the actual centered core. No zero beta condition was imposed; oddness alone does not supply it. This is a decisive failure of the stated certificate, not a negative value of the full theta residual.

## The complete equality tower passes calibration, but does not repair the failure

The actual derivative radical identity gives locally convergent complete sums

SΦ=AΦ+cosh(u/2),
SΦ^(j)=AΦ^(j)+∂_u^j cosh(u/2).

Differentiation is legitimate on bounded spatial windows: the theta derivative tails dominate the complete prime-power series there. Hence for physical equality insertions

F_j=Φ^(2j)−4^(−j)Φ,
G_j=Φ^(2j+1)−4^(−j)Φ′,

one has SF_j=AF_j and SG_j=AG_j exactly. These are the physical transforms of the actual even centered and odd equality modes. All are smooth theta-decaying functions with gamma actions in ordinary L². Thus their complete mixed pairing saturates the proposed upper calibration:

⟨A_dF_j,(S+d)F_j⟩=||A_dF_j||²,

and likewise for G_j. This complete equality-tower calibration is compatible with, and does not overturn, the compact odd counterexample (6). The pole compensation vanishes on these specific equality combinations.

The actual odd score supplies another concrete distinction. Its physical insertion is f=Φ′, and

SΦ′=AΦ′+(1/2)sinh(u/2).

Although q₁=Φ′/Φ belongs to the actual full operator domain and AΦ′ belongs to ordinary L², SΦ′ does not belong to ordinary L². The equality-tower cancellation cannot be used to suppress this actual pole-growth term.

## The action obstruction survives imposing both pole-zero conditions

The compact odd counterexample (6) has nonzero beta and disproves (1) on the stated whole centered class. It does not by itself disprove a scalar inequality restricted to the two-pole-zero subspace. That restriction still cannot supply the proposed common ordinary L² action realization: the independently checked [pole-zero boundary obstruction](theta-pole-zero-prime-action-boundary-obstruction.md) constructs actual even compact f=g″−g/4 with both moments zero, but Sf not in L².

Its mechanism uses one unconditional critical-line zero 1/2+iγ, chooses g with nonzero Fourier value there, and obtains the exact half-line transform −F(w)ζ′(1/2+w)/ζ(1/2+w) plus an entire finite-endpoint correction. The nonzero boundary pole is of order 1/Re w, contradicting the L² Laplace bound of order (Re w)^(−1/2). This proof does not assume RH or exclude off-line zeros; its full derivation and primary Hardy source are retained in the linked note. The argument has the same elementary analytic-continuation structure as the earlier source-domain calculation in `additive-energy-reflection-domain.md`, applied here to compact pole-zero prime action rather than the Chebyshev error source.

Thus equality-tower calibration does not establish a common L² spectral realization even on the smaller actual pole-zero class. This is a scope-specific obstruction to the norm/product proof route; scalar compensated mixed forms might still be meaningful there and are not excluded by this domain result alone.

## Holding costs and the legitimate weighted alternative

With b(u)=2cosh(u/2), f=Φh, the actual individual generators have exact actions

L_cont h=[Af−hAΦ]/b,
L_prime h=[hSΦ−Sf]/b.

Their holding terms are essential. The ground identity SΦ−AΦ=cosh(u/2)=λb gives

Lh=λh+(Af−Sf)/b.

Thus the growing prime term in the bare score action cancels against its actual holding/source compensation in the legitimate theta operator. Neither (5) nor (6) changes this operator or omits a prime power from it. For compact f, ⟨f,S_Nf⟩ stabilizes exactly once log N exceeds the support diameter, while the mixed action in (6) continues to diverge. The original first-form residual (2) remains finite throughout.

In the original theta Hilbert space the complete prime arrival operator is K_prime=ωSω, ω=√(Φ/b), and is bounded; the full gamma form and all holding costs remain. Its weighted mixed products, when their domains are justified, are different observables from (1). The present argument does not exclude a signed, genuinely nonlocal factorization built from those weighted actions and exact compensation terms. It excludes the explicit bare commuting mixed-action certificate on the actual centered core, despite its perfect equality-tower calibration.

The full arithmetic residual smallness, sharp theta gap, and RH remain open. This is independently reviewed written mathematics, not a Lean formalization.

## Independent review and attribution

RH Agent2 and its mathematical descendant supplied the candidate, finite collision expansion, mixed-tail counterexample and pole-zero domain obstruction. RH Proof independently checked the two translation orientations in (3), the factor -2 in (5), oddness versus the two pole conditions, the unnormalized measure in (2), and the finite-cutoff stability of the ordinary first form. Root also checked the primary digamma formula and the Hardy input used in the separate boundary proof. The global spectral cancellation remains conditional on a genuine common realization and full spectral-test extension. Local commutation is not substituted for either condition.

The mixed pairing on the odd compact test tends to positive infinity; it has no finite real limit satisfying (1). Since the right-hand norm is finite, some sufficiently large finite cutoff also violates that upper bound. On the smaller two-pole-zero class, the separate boundary proof excludes the proposed ordinary L² action route, while leaving scalar compensated forms available. None of these assertions is yet formalized in Lean. The method uses classical kernel expansion, compact integration and analytic continuation, with no priority claim.
