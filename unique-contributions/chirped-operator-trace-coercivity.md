# Scalar trace contradiction under assumed uniform bounds

**Classification:** conditional scalar theorem

**Lean module:** [`ChirpedOperatorTraceCoercivity.lean`](../formalization/BuildingBlocks/ChirpedOperatorTraceCoercivity.lean)

The formalized "trace functionals" are arbitrary real-valued functions of a carrier and a finite coefficient vector:

```lean
def ArithmeticTraceFunctional (ι : Type*) := ℝ -> (ι -> ℂ) -> ℝ
def SpectralTraceFunctional (ι : Type*) := ℝ -> (ι -> ℂ) -> ℝ
```

No operator, trace-class condition, or trace is constructed. The useful theorem is scalar. If two supplied functions satisfy uniform `ArithmeticCoercivity`, uniform `SpectralTraceZeroBound`, and exact equality for every carrier and coefficient vector, then a nonzero vector turns the two bounds into an impossible power-versus-logarithm inequality.

`OperatorTraceEvaluation s` stores all three decisive properties, positive coupling, and a nonzero test vector. The module proves that this package is empty when $\operatorname{Re}s>1/2$. It does not show that an actual zeta zero produces the package.

`OperatorTraceCoercivitySystem` adds a low-frequency certificate and an evaluator for every high-frequency candidate. The declarations yielding high-frequency zero-freeness, right-half zero-freeness, RH, and support confinement are conditional on that system. No system value is built in this file.

This scalar certificate layer is reused almost verbatim by the Fredholm, Carleman, support, and measure-named modules. Consolidating those wrappers around one accurately named contradiction theorem would make the dependency graph smaller and reduce the risk that definitions are mistaken for constructed operators.
