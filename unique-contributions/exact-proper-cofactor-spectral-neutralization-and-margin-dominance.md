# Real-power identities for a modeled cofactor exponent

**Classification:** elementary algebraic model, conditional analytic interpretation

**Lean module:** [`ActualCofactorSpectralNeutralization.lean`](../formalization/BuildingBlocks/ActualCofactorSpectralNeutralization.lean)

The Lean file defines

```lean
offlineAmplitude ε T := T ^ ε
scatteringModulus ε T := T ^ (-ε)
```

using real powers. The name `scatteringModulus` is a model definition. It is not proved equal to the exact modulus $|\chi(1/2+\varepsilon+iT)|$ of the Riemann functional-equation factor. Accordingly,

$$
T^\varepsilon T^{-\varepsilon}=1
$$

is an elementary real-power identity, not exact neutralization by the actual scattering multiplier.

The remaining checked results are also exponent algebra:

- $\delta(\varepsilon+1/2)<\varepsilon$ under the displayed threshold;
- for every $\nu>0$, some $\delta>0$ makes that exponent smaller than $\nu$;
- the modeled product is below $T^\nu$ when $T>1$;
- every fixed constant is eventually smaller than $a\log T$ for $a>0$.

The module does not define the proper-cofactor sum, derive a dual Dirichlet polynomial from it, prove an actual product estimate for $\chi(s)$, or bound the full off-line spectral contribution by a fixed constant. The last logarithmic dominance theorem applies only after such a constant bound has independently been established.

These lemmas may support an analytic proof once uniform Stirling estimates, triangle bounds for the actual Dirichlet polynomial, and the cofactor identity are supplied. They do not by themselves yield spectral neutralization or an RH consequence.
