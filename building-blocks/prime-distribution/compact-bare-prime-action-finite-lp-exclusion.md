# No nonzero compact smooth seed has a finite-Lp bare prime action

This is a written consequence of the actual half-line prime-action identity proved in the [finite-Lp necessity note](../theta-and-heat/theta-pole-zero-prime-action-boundary-obstruction.md#every-finite-lp-action-requires-zero-annihilation). It concerns the bare unweighted action, not the compensated theta form, and proves no RH bound. It strengthens the necessary zero-annihilation condition to an exclusion for every nonzero compact smooth seed, without parity or pole-moment hypotheses.

Let f be a nonzero complex smooth function supported in [-a,a], with a finite and nonnegative. Put

F(w) = integral_R f(v) exp(-wv) dv.

Let S be the literal complete physical prime action of the reviewed note, with every von Mangoldt term retained. For every R>a and every real 1<=p<infinity,

S f does not belong to Lp((R,infinity),du).

## Compact support limits transform zeros

Compact integration gives an entire F and the global bound

|F(w)| <= ||f||_1 exp(a |Re w|).

F is not identically zero: compact smooth f is Schwartz, F(it) is its ordinary Fourier transform, and Fourier inversion would give f=0 if F vanished identically. Choose w0 with F(w0) nonzero. On the circle w=w0+z, |z|=2T, the bound is at most C exp(2aT), with C=||f||_1 exp(a |Re w0|)>0.

Jensen's formula therefore bounds the number n(T) of F zeros in |w-w0|<=T, counting multiplicity, by

n(T) log 2 <= 2aT + log C - log |F(w0)|.

If a zero lies on the outer integration circle, take radii decreasing to 2T from above that avoid zeros. The same limiting estimate applies. Thus n(T)=O_f(T). In particular the number of distinct positive ordinates gamma<T at which F(i gamma)=0 is O_f(T), because these points lie in the disk of radius T+|w0| about w0.

## Actual distinct critical zeros exceed this capacity

[Bui, Conrey and Young, Theorem 1.1](https://arxiv.org/pdf/1002.4127v2), with the definitions immediately preceding it, proves unconditionally that liminf N0_simple(T)/N(T)>=0.4058. These are simple critical-line zeros, hence distinct points. The classical zero count N(T)~T log T/(2pi) is also unconditional; [Trudgian, Corollary 1 and equations (2.2)-(2.5)](https://arxiv.org/pdf/1208.5846v2) gives a quantitative version.

Consequently N0_simple(T)>=0.4 N(T) for all sufficiently large T, and the number of distinct critical ordinates is at least c T log T for some c>0. This contradicts the O_f(T) transform-zero count if F vanishes at every actual critical ordinate. Total zeta zero counts alone, without a distinct-zero input, would not justify this step: the logarithmic-derivative pole only requires a simple transform zero even when a zeta zero is multiple.

## Apply the reviewed finite-Lp necessity

If S f belonged to any finite Lp tail space, the actual Euler/Laplace identity in that necessity note and Holder boundary estimate would force F(rho-1/2)=0 at every nontrivial zero with Re rho>=1/2. In particular F(i gamma)=0 at every simple critical zero. The preceding counts contradict this for every nonzero compact smooth f. No evenness, RH, hypothetical off-line zero, or finite prime truncation is used.

The zero seed is the only compact smooth exception. The p=infinity case is not covered by the finite-Lp boundary estimate, so no corresponding bounded-action conclusion is asserted. Weighted arrival operators, exact holding terms, gamma and pole compensation, and the legitimate compact quadratic prime form are not excluded. This is standard Jensen/Fourier-inversion reasoning applied to the reviewed necessary condition, with no novelty claim. The primary density inputs and analytic steps are not Lean-formalized here. This excludes the common bare finite-Lp action realization on the entire compact core, not the prescribed growing-carrier signed arithmetic estimate.

## Review, dependencies and attribution

RH Agent3 supplied this consequence of RH Proof's finite-Lp necessity theorem. RH Proof independently checked the entire transform bound, Fourier-inversion nonvanishing, the Jensen disk centered at a nonzero transform value, the treatment of zeros on the outer circle, and the translation from that disk count to positive imaginary ordinates. The primary sources were read for the exact simple-zero definitions and unconditional theorem statements. Taking 0.4 below the stated liminf bound ensures the lower density holds for every sufficiently large T. Simple zeros give distinct ordinates on the critical line, so no multiplicity assumption is hidden.

The deep simple-zero density theorem is an explicit existing input. This argument does not reprove it, does not assume that all zeros are simple, and does not infer the contradiction from the total zero count alone. It is a standard entire-function zero-capacity argument applied to the literal complete prime action, with no priority claim. All analytic steps and the primary density inputs remain written mathematics requiring Lean formalization. The result excludes the ordinary finite-Lp bare action on every nonzero compact smooth test; it leaves the legitimate weighted arrival operator and compensated full form unchanged.
