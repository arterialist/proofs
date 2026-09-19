# Power-log contradiction from a universal scalar balance package

**Taxonomy:** building block. The Lean declarations cover only the scalar, algebraic, numerical, or conditional interface stated below; they do not construct the advertised analytic operator or prove an unconditional RH consequence.
**Classification:** conditional bridge theorem

**Lean module:** [`ChirpedUniversalFredholmExclusion.lean`](../../formalization/BuildingBlocks/ChirpedUniversalFredholmExclusion.lean)

This module proves a contradiction from a strong package of scalar inequalities. It does not construct a Fredholm operator or determinant.

For positive $\gamma$ and displacement $d$, `UniversalFredholmEvaluation gamma d` contains a freely supplied real function `log_det2` together with

$$
2bT^{2d}-(A\log T+C)\leq \operatorname{log\_det2}(T)
$$

and

$$
\operatorname{log\_det2}(T)\leq M_{\rm bal}
$$

for every $T>16$. Carrier tuning chooses a large $T$, and elementary real inequalities then contradict these two fields. This is `refute_universal_fredholm_evaluation`.

The word "universal" belongs to an assumption. `UniversalFredholmSystem.evaluator` must produce the whole inconsistent evaluation package from every putative upper-half-plane zero. The module does not define such a system, derive its lower or balance fields from the Weil explicit formula, or connect `log_det2` to an operator determinant. Consequently,

```lean
UniversalFredholmSystem -> RiemannHypothesis
```

is a conditional reduction, not an unconditional proof of RH. The reflection and real-axis hypotheses in the right-half-plane theorem are also explicit arguments.

The reusable result is the quantified power-versus-logarithm contradiction. An analytic application still has to construct the evaluator without assuming the decisive incompatible bounds.
