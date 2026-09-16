# Actual physical scattering moment signs

Sixteen public theorems are compiled in `ActualScatteringMomentSigns.lean`, `ActualScatteringMellinSignBridge.lean`, `ActualPrimeBlockMellinParity.lean`, and `ActualPrimeBlockWeilWeightParity.lean`. RH Agent3 supplied the proofs in the original physical notation. The bounded translation worker changed namespace and import paths only for the first three modules; root made the same namespace/import translation for the fourth and reviewed the literal coefficients and physical Mellin correspondence. These are finite-history sign and dictionary results, not a sign theorem for the full Weil form or an RH proof. No novelty certificate is claimed.

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

The list-valued `physicalBlock` iterates the complete physical history at every prime in order, with a separate depth at each prime. Its regularity, exact Mellin product, and preservation of every zero Mellin moment are compiled. For primes of positive depth and h≥1, its amplitude is strictly positive and its two-sided Mellin product is exactly `(−1)^|B|` times that amplitude and the original seed's two-sided product. Repeated list entries are permitted by the formal statement; no distinctness is needed for the multiplicative identity.

For an even seed, Mellin reflection converts the conjugate-polarized `pairedWeight` into the nonnegative squared norm of its Mellin value on the real line. The varying-depth physical block therefore has an exact real parity-signed paired weight. Multiplication by `(−1)^|B|` makes this one row nonnegative when every depth and h are positive. This proof does not assume the scattered block itself is even.

All sixteen public conclusions depend only on `propext`, `Classical.choice`, and `Quot.sound`. The infinite gamma-series passage, finite overlap rows, all signed prime-power contributions, and the actual arithmetic upper bound remain separate obligations. A single parity-signed paired row does not discharge them.
