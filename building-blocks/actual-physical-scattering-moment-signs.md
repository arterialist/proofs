# Actual physical scattering moment signs

Six public theorems are compiled in `ActualScatteringMomentSigns.lean` and `ActualScatteringMellinSignBridge.lean`. RH Agent3 supplied the proofs in the original physical notation. The bounded translation worker changed namespace and import paths only; root reviewed the literal coefficients and physical Mellin correspondence. These are finite-history sign and dictionary results, not a sign theorem for the full Weil form or an RH proof. No novelty certificate is claimed.

For a real p≥2 and natural h,M≥1, define the literal multipliers at β=h+1/2 and −β by

    A_+(p,h,M)=−p^h+(1−1/p)Σ_(0≤j<M) p^(−j(h+1)),
    A_−(p,h,M)=−p^(−h−1)+(1−1/p)Σ_(0≤j<M) p^(jh).

The complete geometric sum gives A_+<0 and A_−>0. In particular their product is negative for every prime p. For every finite prime set B, with a separate positive depth M(p) at each prime, the compiled identity is

    Π_(p∈B) A_+(p,h,M(p))A_−(p,h,M(p))
      = (−1)^|B| Π_(p∈B) [−A_+(p,h,M(p))A_−(p,h,M(p))],

and the last product is strictly positive, including the empty block's unit product. No scattered-carrier evenness or separation assumption is introduced.

The dictionary theorems identify these real expressions with `originalHistory p (±(h+1/2)) M` as complex numbers. Those identities hold for every real p and natural h,M under Lean's total complex-power conventions; the physical application uses p prime, so p>0. For continuous compactly supported f:ℝ→ℂ, the established full physical-history Mellin theorem then gives

    Mellin(historyPhysical(1/sqrt(p),M,log(p),f), β)
      · Mellin(historyPhysical(1/sqrt(p),M,log(p),f), −β)
      = A_+(p,h,M)A_−(p,h,M) · Mellin(f,β)Mellin(f,−β).

This physical identity permits every natural h,M, including zero; the strict coefficient sign requires h,M≥1. Both original Mellin integrals and every finite-history atom are retained. A general complex seed's paired Mellin product is not assumed positive.

All six public conclusions depend only on `propext`, `Classical.choice`, and `Quot.sound`. The infinite gamma-series passage, its seed-product sign, finite overlap rows, all signed prime-power contributions, and the actual arithmetic upper bound remain separate obligations. Finite coefficient parity alone does not discharge them.
