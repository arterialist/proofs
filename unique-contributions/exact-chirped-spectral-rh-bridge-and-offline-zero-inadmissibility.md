# Incompatibility of an assumed chirped off-line configuration

**Classification:** conditional bridge theorem

**Lean module:** [`ChirpedSpectralRHBridge.lean`](../formalization/BuildingBlocks/ChirpedSpectralRHBridge.lean)

The module defines an abstract `ChirpedOfflineZeroConfiguration d`. A witness consists of two real functions, positive constants, exact equality of the functions, an eventual arithmetic lower bound, and an eventual spectral upper bound containing $-2bT^{2d}$.

For $d>0$, those fields are inconsistent because a positive power eventually dominates the logarithmic terms. The theorem

```lean
chirped_offline_zero_inadmissible :
  0 < d -> ¬ ChirpedOfflineZeroConfiguration d
```

is therefore a valid real-analysis exclusion for that abstract configuration.

The RH statements require the missing analytic map explicitly:

```lean
h_carrier :
  ∀ s, 1 / 2 < s.re -> s ≠ 1 -> riemannZeta s = 0 ->
    ChirpedOfflineZeroConfiguration (s.re - 1 / 2)
```

Both `rightHalfZeroFree_of_chirped_configuration` and `RiemannHypothesis_of_chirped_configuration` take `h_carrier` as an argument. The module does not construct it. In particular, it does not prove the stated Brun-Titchmarsh lower bound or the off-line spectral upper bound for actual chirped Weil packets. Those are fields of the configuration.

The machine-checked contribution is a conditional reduction: constructing the carrier map would imply RH, while any one of the incompatible abstract configurations is impossible. It is not an unconditional off-line zero exclusion.
