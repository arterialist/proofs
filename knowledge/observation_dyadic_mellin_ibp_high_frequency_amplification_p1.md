# Dyadic Mellin Summation-by-Parts High-Frequency Amplification Fallacy

Type: observation
Confidence: high
Source: Explorer r3 Node 11 (Level 0)
Relevant to: Dyadic Mellin continuation, primitive energy bounds, and claims of frequency regularization via integration by parts

## Statement
For any dyadic block $[X, 2X]$ and complex spectral parameter $s = \sigma + it$, integrating the Chebyshev prime-power error $e(x) = \psi(\lfloor x \rfloor) - x$ against the Mellin weight $x^{-s-1}$:
$$M_X(s) := \int_X^{2X} (\psi(\lfloor x \rfloor) - x) x^{-s-1} dx$$
by parts with respect to the primitive $P_X(t) := \int_X^t e(x) dx$ produces the exact identity:
$$M_X(s) = P_X(2X)(2X)^{-s-1} + (s + 1) \int_X^{2X} P_X(x) x^{-s-2} dx.$$

The derivative of the weight $x^{-s-1}$ with respect to $x$ introduces an explicit factor of $-(s+1)$ in the **numerator**, NOT in the denominator. Consequently:
1. The resulting Cauchy-Schwarz block bound grows linearly with the vertical ordinate $|t|$:
   $$\|M_X(s)\| \le \left( 2^{-\sigma-1}\sqrt{2} + |s + 1| \right) X^{-\sigma - 3/2} \sqrt{S_X},$$
   where $|s+1| \approx |t|$ for large $|t|$.
2. Integration by parts performs **frequency differentiation**, amplifying high-frequency oscillations by $|t|$ rather than regularizing them by $1/|s|$.
3. Double integration by parts (integrating $P_X$ to a second primitive $Q_X$) differentiates $x^{-s-1}$ twice, producing a prefactor of $(s+1)(s+2) \approx |t|^2$ in the numerator, exacerbating high-frequency divergence to quadratic growth.

## Evidence
1. **Analytic Derivation**:
   $$\frac{d}{dx}\left(x^{-s-1}\right) = -(s+1) x^{-s-2}.$$
   Dividing or smoothing by $1/|s|$ would require anti-differentiating the weight (which yields $\frac{x^{-s}}{-s}$, shifting the abscissa in the wrong direction and losing boundary vanishing $P_X(X) = 0$).
2. **Numerical Evaluation**:
   At $s = 0.6 + 100i$, $|s+1| = |1.6 + 100i| = \sqrt{1.6^2 + 100^2} \approx 100.0128$, multiplying the interior integral by $\approx 100$, while $1/|s| \approx 0.0099998$ would predict a 100-fold attenuation.
3. **Loss of Phase Cancellation**:
   Applying the triangle inequality and Cauchy-Schwarz to $|(s+1) \int P_X(x) x^{-s-2} dx|$ discards the rapid phase oscillations of $x^{-it} = e^{-it \log x}$, replacing an oscillatory integral with an upper bound that grows linearly with $|t|$.

## Implications
- Claims that dyadic primitive integration by parts "gains a factor of $1/|s|$ frequency smoothing" are mathematically false and inverted.
- Mellin block bounds derived via Cauchy-Schwarz on primitives can yield geometric summability in $X = 2^k$ only on compact subsets of $\operatorname{Re}(s) > 1/2$, but grow with vertical height $T$, providing zero high-frequency regularization along vertical lines.

## Caveats
Does not invalidate the algebraic correctness of the identity $M_X(s) = P_X(2X)(2X)^{-s-1} + (s+1) \int P_X(x) x^{-s-2} dx$, which is machine-checked in Lean 4 (`CoarsePrimitive.lean`); it refutes the claim of $1/|s|$ frequency decay.
