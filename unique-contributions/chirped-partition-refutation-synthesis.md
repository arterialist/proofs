# RH from a low-height certificate and a linear-bridge witness

**Classification:** conditional partition theorem with numerical carrier algebra

**Lean module:** [`ChirpedPartitionRefutationSynthesis.lean`](../formalization/BuildingBlocks/ChirpedPartitionRefutationSynthesis.lean)

The module proves that a witness assigning a contradictory `LinearVanishingBridgeSystem` to every high-frequency off-line zero yields `HighFrequencyZeroFree H`. Together with a supplied `LowFrequencyZeroFree H`, the existing partition theorem gives RH.

The computations $(4/3)(3\cdot10^{12})=4\cdot10^{12}>16$ and related carrier inequalities are exact elementary arithmetic. They do not prove that the analytic bridge exists at those carriers. The theorem named `platt_trudgian_synthesis_rh` takes both the low-frequency proposition and the linear witness as arguments; neither is proved by this module.

The page records a conditional interface and its numerical calibration.
