# Integer birth probe: independent proof and clock scope

Attribution: RH Proof, independent review and alternate estimates.

Written mathematical review of the Creative Anchor's `integer-birth-probe-joint-history-and-work-transfer.md`, 16 September 2026. This verifies its new finite probe construction and transport estimates. It does not prove RH or provide Lean certification. The exact full-factor scalar identification is consumed from the existing fixed-packet source identity.

Let h_T be a fixed compact smooth profile translated to age T, supported in [T-d,T+d]. Put H_T(x)=sqrt(x) h_T(log x), extended smoothly by zero, and alpha_m=H_T(m)-H_T(m-1). For large T, H_T(0)=0. Finite telescoping proves sum alpha_m=0 and

    R_T(v)=exp(-v/2) H_T(floor(exp v)).

This is an equality of functions away from irrelevant endpoint conventions, and it includes the last coefficient after the support ends. Omitting that last coefficient would destroy the tail cancellation.

On every unit cell meeting the support, x is comparable to exp T and |H_T'(x)| is at most C exp(-T/2). Therefore

    |alpha_m|/sqrt(m) <= C exp(-T),
    |R_T(v)-h_T(v)| <= C exp(-T).

There are O(exp T) cells and their age support has bounded length, including the two boundary cells. Thus the normalized synthesis cost is bounded and both L1 and L2 errors are O(exp(-T)). Applying the same proof to partial_T H_T proves the derivative estimates. The grid is fixed in x, so differentiation produces no moving integer contacts.

For b_m(v)=exp(-v/2) 1_{v>=log m}, direct integration gives <b_m,b_l>=1/max(m,l). The literal frozen source is

    a_N=-b_1+sum_{m<=N} Lambda(m)b_m-integral_1^N b_t dt.

For integer l<=N its pairing is

    <a_N,b_l>=F(l)+sum_{m<=N}Lambda(m)/m-log N-1,
    F(l)=log l-sum_{m<=l}Lambda(m)/m+psi(l)/l.

The density contribution is (l-1)/l+log(N/l), and the seed contributes -1/l. Their sum is -1-log(N/l), which checks the origin constant. Telescoping removes the N-dependent constant exactly. Since

    F(l+1)-F(l)=log(1+1/l)-psi(l)/(l(l+1)),

finite summation by parts gives

    <a_N,R_T>=sum_l H_T(l)[psi(l)/(l(l+1))-log(1+1/l)].

The arrival Lambda(l+1) cancels in the difference of F. This retains every prime power rather than deleting the new arrival by approximation.

For N comparable to exp T and beyond both local supports, ||a_N||_2<=C sqrt N gives |e(T)|+|e'(T)|<=C exp(-T/2), where e=<a,h_T-R_T>. A fixed sufficiently large N may be used throughout each bounded T interval. The equality a_N=a on the probe and derivative supports justifies differentiating the local pairing even though a need not be globally L2.

With T_n=log n+c, the mean value theorem gives e_n=O(n^-1/2) and Delta e_n=O(n^-3/2). The needed unconditional source envelope also yields the scalar envelopes directly: if |E(x)|<=C x exp(-b sqrt(log x)), compactness of h_T and its T derivative gives

    |k_phi(T)|+|partial_T k_phi(T)|
      <= C exp(T/2) exp(-b' sqrt T),

after including the established bounded or decaying smooth archimedean row and decreasing b if necessary. Hence |K_n|<=C sqrt n exp(-b' sqrt(log n)) and |Delta K_n|<=C n^-1/2 exp(-b' sqrt(log n)). No off-critical zero is isolated in this argument.

For G=K+e the exact work difference is

    2 G_n Delta G_n-2 K_n Delta K_n
      =2[e_n Delta K_n+K_n Delta e_n+e_n Delta e_n].

Each mixed order is necessary. Their absolute sum is bounded by C[n^-1 exp(-b' sqrt(log n))+n^-2]. The first term is summable because substitution u=sqrt(log x) gives the tail integral 2 integral u exp(-b'u) du. Loading differences are bounded by C[n^-2 exp(-b' sqrt(log n))+n^-3]. The established full-factor correction r_n=O(n^-5/2), with the same crude increment order, contributes smaller summable work errors. Thus the claimed work transport is valid, with an admissibly decreased decay constant.

For the original finite-activity law the exact clock lift uses q=(T_s^*T_s)^-1 R_T. Bounded generator norm at most 2 lambda gives ||q||<=C exp(4 lambda s). At s=k log log N this is at most C(log N)^(4 lambda k). At the original fixed clock s=c log N the same estimate is C N^(4 lambda c). The first statement does not establish a subpower estimate at the second clock. Nor does subtraction of probe storage prove an upper bound for the signed source work.

The verified conclusion is a native integer-history observable with bounded normalized synthesis cost, controlled local error, and absolutely summable work transport to the established scalar. Its signed cumulative-history work bound remains open. The inverse probe is not asserted to be positive, compact, pole-null, or an actual centered successor frame.

## Finite Lean coverage

`BuildingBlocks/IntegerBirthHistory.lean` formalizes the exact coefficient telescope, the literal integer history field using the actual cumulative von Mangoldt sum, its successor cancellation, finite Abel summation with both boundary terms, and the resulting psi/log pairing when both endpoint profile values vanish. The zero-index term in the weighted sum is zero because von Mangoldt vanishes at zero; all positive prime powers remain. This finite algebra does not formalize the function-space Gram integral, probe approximation, PNT error envelope, infinite work tail, inverse clock, or RH conclusion.

`BuildingBlocks/IntegerBirthGram.lean` additionally proves the literal seed-product integrability, the original dv-metric Gram integral 1/max(m,l) for m,l>=1, diagonal square integrability and evaluation, finite square integrability, the complete double-sum energy expansion, and nonnegativity of that finite kernel quadratic form. The arrival endpoint belongs to the seed's closed half-line; the integral over its endpoint agrees with the open-half-line integral because Lebesgue measure has no atom there. This does not assert that the compound-Poisson law has no atom. The frozen-source density Fubini pairing and function-space approximation remain further formalization obligations.

The history module also compiles the exact reconstruction of psi(n)-n from the literal history difference and the explicit logarithmic remainder, together with the strict bounds zero < remainder < one. These bounds control the integer-cell logarithmic correction, not the arithmetic prime error.
