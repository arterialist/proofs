# Support emptiness from supplied low- and high-frequency certificates

**Taxonomy:** building block. The Lean declarations cover only the scalar, algebraic, numerical, or conditional interface stated below; they do not construct the advertised analytic operator or prove an unconditional RH consequence.
**Classification:** conditional set-theoretic reformulation

**Lean module:** [`ChirpedSpectralMeasureAnnihilation.lean`](../../formalization/BuildingBlocks/ChirpedSpectralMeasureAnnihilation.lean)

The module's measure terminology is informal. It does not define a Radon measure, prove countable additivity, or integrate a test function against a zero measure. The central predicates are pointwise negations:

```lean
def OfflineMeasureAnnihilated (H : ℝ) : Prop :=
  ∀ s : ℂ, s ∈ RightOfflineSupport -> H < |s.im| -> False

def GlobalOfflineMeasureAnnihilated : Prop :=
  ∀ s : ℂ, s ∈ RightOfflineSupport -> False
```

They say that certain sets are empty. `OfflinePointMass` is defined separately as a scalar expression, but the theorem named `offline_point_mass_vanishes` does not prove that expression equals zero. It proves that membership in the already empty high-frequency support implies `False`.

The set-theoretic lemmas are valid under their stated hypotheses. Low-frequency zero-freeness plus high-frequency support emptiness gives global support emptiness, which gives right-half zero-freeness and then RH through existing equivalences. The operator-trace versions remain conditional on an `OperatorTraceCoercivitySystem`, whose fields include the needed low-frequency certificate and evaluator.

The accurate contribution is a machine-checked chain among support-emptiness predicates. Claims about annihilating a spectral Radon measure or isolating point masses are not established by this module. Nor does it prove RH without the system hypotheses.
