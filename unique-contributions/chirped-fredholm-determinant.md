# Chirped trace-discrepancy exponentials

**Classification:** conditional reformulation, machine-checked scalar algebra

**Lean module:** [`ChirpedFredholmDeterminant.lean`](../formalization/BuildingBlocks/ChirpedFredholmDeterminant.lean)

The names in this module are stronger than the objects it constructs. `LogFredholmDeterminant` is defined to be the scalar difference

$$
T_{\rm arith}(T,c)-T_{\rm spec}(T,c),
$$

and `RegularizedFredholmDeterminant` is its real exponential. The file does not define a Hilbert space operator, prove compactness or a Schatten-class property, construct a Fredholm determinant, or identify its zero set with zeta zeros. It should therefore be read as a trace-discrepancy model, not as a constructed spectral determinant.

The useful checked result is algebraic. If supplied functions satisfy `ArithmeticCoercivity`, `SpectralTraceZeroBound`, and exact `WeilTraceEquivalence`, then their scalar gap becomes positive for a nonzero coefficient vector and contradicts equality. `FredholmSpectralBalance` is another name for the equality of the two supplied scalar functions, so `fredholmSpectralBalance_iff_weilTraceEquivalence` is a definitional reformulation.

The global declarations remain conditional:

- `FredholmDeterminantEvaluation` contains the arithmetic lower bound, the spectral upper bound with its decisive negative power term, exact balance, and a nonzero test vector as fields.
- `FredholmDeterminantSystem` assumes a `LowFrequencyZeroFree` certificate and an evaluator producing that package for every relevant high-frequency zero candidate.
- `RiemannHypothesis_of_fredholm_system` proves `FredholmDeterminantSystem -> RiemannHypothesis`. No inhabitant of that system is constructed in this module.

The formalization is useful as a consistency check for a proposed analytic argument. Calling its exponential an actual Fredholm determinant, or describing the final implication as an unconditional RH proof, is unsupported by the Lean definitions.

No priority claim is made here. A bounded audit found classical surrounding themes in regularized determinant and Hilbert-Pólya literature, but did not perform an exhaustive novelty search for this particular scalar packaging.
