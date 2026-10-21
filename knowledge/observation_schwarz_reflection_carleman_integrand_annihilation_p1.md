# Schwarz Reflection Annihilation of Off-Axis Carleman Integrands for Real Entire Functions

Type: observation
Confidence: high
Source: Explorer r3 Node 14 (Level 0)
Relevant to: Carleman, Poisson-Jensen, and Green contour methods attempting off-axis contour shifts $\operatorname{Im}(z) = -\varepsilon$ to bypass boundary singularities

## Statement
Let $f(z)$ be any entire function that is real on the real axis $\mathbb{R}$. By the Schwarz reflection principle, $f$ satisfies:
$$f(\bar{z}) = \overline{f(z)} \quad \text{for all } z \in \mathbb{C}.$$
Consequently, for any real point $x \in \mathbb{R}$ and any vertical displacement $\varepsilon \in \mathbb{R}$:
$$|f(x + i\varepsilon)| = |\overline{f(x - i\varepsilon)}| = |f(x - i\varepsilon)|.$$
Therefore, the off-axis modulus ratio and its logarithmic discrepancy satisfy the exact algebraic identity:
$$\log \left| \frac{f(x - i\varepsilon)}{f(x + i\varepsilon)} \right| = \log(1) \equiv 0 \quad \text{identically for all } x \in \mathbb{R} \text{ and all } \varepsilon \in \mathbb{R}.$$

In particular, for the conformal uniformized completed zeta function $\Xi_*(z)$ (which is real on $\mathbb{R}$), any proposed off-axis Carleman boundary dispersion integral of the form:
$$\mathcal{D}(\varepsilon) := \frac{1}{2\pi} \int_{1/4}^R \log \left| \frac{\Xi_*(x - i\varepsilon)}{\Xi_*(x + i\varepsilon)} \right| dx$$
vanishes identically ($\mathcal{D}(\varepsilon) \equiv 0.00000000$).

## Evidence
1. **Algebraic Identity**:
   $\Xi_*(z) = \sum_{m=0}^\infty a_m (1/4 - z)^m$ has real Taylor coefficients $a_m \in \mathbb{R}$, so $\overline{\Xi_*(z)} = \Xi_*(\bar{z})$. Taking moduli, $|\Xi_*(x - i\varepsilon)| = |\Xi_*(x + i\varepsilon)|$ identically.
2. **Arbitrary-Precision Quadrature Verification**:
   Numerical integration of $\mathcal{D}(\varepsilon)$ on $[0.25, 100]$ in mpmath at 25 decimal digits precision evaluated to $0.000000000000000000000000$ for all $\varepsilon \in \{0.5, 0.1, 0.01\}$.
3. **Contradiction with Arc Growth**:
   Because $\mathcal{D}(\varepsilon) \equiv 0$, it is mathematically incapable of canceling the outer circular boundary arc integral:
   $$I_{\text{arc}}(R, \varepsilon) \sim \frac{1}{4} R^{1/2} \log R \to +\infty \quad \text{as } R \to \infty.$$
   Under the Riemann Hypothesis (where the off-line zero displacement sum is zero), Carleman's balance equation would assert $0 = 0 + \infty$, a fatal mathematical contradiction.
4. **Physical Clearance Contraction**:
   Under the inverse conformal mapping $s(z) = 1/2 + (1/2)\sqrt{1 - 4z}$, a fixed vertical displacement $\operatorname{Im}(z) = -\varepsilon$ contracts in the physical $s$-plane as:
   $$\operatorname{Re}(s) - \frac{1}{2} \sim \frac{\varepsilon}{2\sqrt{x}} = \frac{\varepsilon}{2t} \to 0 \quad \text{as } t \to \infty.$$
   Thus the off-axis contour $\Gamma_\varepsilon$ in the $s$-plane collapses onto the critical line at rate $O(1/t)$, passing within distance $\varepsilon / (2\gamma_n)$ of critical zeros and destroying any claimed uniform non-vanishing buffer.

## Implications
- Off-axis horizontal contour shifts on symmetric completed functions cannot generate non-trivial dispersion balances against circular arcs.
- Any valid Carleman-Jensen contour formulation must either be applied to asymmetric uncompleted functions (such as $\zeta(s)$, where functional reflection provides non-trivial ratios) or operate on domains with non-reflecting boundary geometries.

## Caveats
Does not apply to asymmetric functions where $f(\bar{z}) \ne \overline{f(z)}$.
