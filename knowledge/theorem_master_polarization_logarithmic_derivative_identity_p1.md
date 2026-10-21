# Master Polarization Logarithmic Derivative Identity

Type: theorem
Confidence: high
Source: Aggregators L02_N02, L02_N04, L02_N06 (Level 2); r2_L03_N00, r2_L03_N01, r2_L03_N02, r2_L03_N03 (Level 3)
Relevant to: de Branges space companion function modulus asymmetry, phase monotonicity, and establishing contractivity/norm inequalities on the critical strip.

## Statement
Let $\xi(s)$ be the completed Riemann xi function, and let $\Xi(t) = \xi(1/2 + it)$ be the Riemann Xi function. Under the change of variables $s = 1/2 + iz$ with $z = t - i(\sigma - 1/2) \in \mathbb{C}^+$ (so that $\sigma > 1/2 \iff \operatorname{Im}(z) < 0$, or conversely with $z \in \mathbb{C}^+$ corresponding to $\sigma < 1/2$, or setting $w = -i(s - 1/2) \in \mathbb{C}^+$ when $\sigma > 1/2$), define the de Branges companion entire function:
$$E_+(z) := \Xi(z) + i\Xi'(z).$$
Under the identification $\Xi(z) = \xi(1/2 + iz)$, we have $\Xi'(z) = i \xi'(1/2 + iz) = i \xi'(s)$, and hence:
$$E_+(z) = \xi(s) - \xi'(s), \quad \text{and} \quad E_+^\sharp(z) := \overline{E_+(\bar{z})} = \xi(s) + \xi'(s).$$
Then for all $s \in \mathbb{C}$:
1. The modulus asymmetry between $E_+(z)$ and its conjugate reflection satisfies the exact polarization identity:
   $$|E_+(z)|^2 - |E_+(\bar{z})|^2 = -4 |\xi(s)|^2 \operatorname{Re}\left(\frac{\xi'(s)}{\xi(s)}\right).$$
2. In terms of the phase function $\theta(t) = -\arg E_+(t)$ on $\mathbb{R}$, de Branges contractivity $|E_+(z)| < |E_+(\bar{z})|$ on the upper half-plane $\mathbb{C}^+$ is strictly equivalent to:
   $$\operatorname{Re}\left(\frac{\xi'(s)}{\xi(s)}\right) > 0 \quad \text{for } \sigma > \frac{1}{2}.$$

## Proof
Let $A = \xi(s)$ and $B = \xi'(s)$. Then:
$$E_+ = A - B, \quad \overline{E_+(\bar{z})} = A + B.$$
Evaluating the modulus squared difference:
$$|E_+|^2 - |\overline{E_+(\bar{z})}|^2 = |A - B|^2 - |A + B|^2.$$
Expanding each modulus squared:
$$|A - B|^2 = (A - B)(\bar{A} - \bar{B}) = |A|^2 - A\bar{B} - \bar{A}B + |B|^2,$$
$$|A + B|^2 = (A + B)(\bar{A} + \bar{B}) = |A|^2 + A\bar{B} + \bar{A}B + |B|^2.$$
Subtracting the two expressions:
$$|A - B|^2 - |A + B|^2 = -2(A\bar{B} + \bar{A}B) = -4 \operatorname{Re}(\bar{A}B).$$
Dividing and multiplying by $|A|^2 = |A|^2$:
$$-4 \operatorname{Re}(\bar{A}B) = -4 |A|^2 \operatorname{Re}\left(\frac{B}{A}\right) = -4 |\xi(s)|^2 \operatorname{Re}\left(\frac{\xi'(s)}{\xi(s)}\right).$$
Thus:
$$|E_+(z)|^2 - |E_+(\bar{z})|^2 = -4 |\xi(s)|^2 \operatorname{Re}\left(\frac{\xi'(s)}{\xi(s)}\right).$$
When $\sigma > 1/2$, the de Branges contractivity condition $|E_+(z)| < |E_+(\bar{z})|$ (or phase derivative $\theta'(t) > 0$) holds if and only if the left-hand side is strictly negative, which, since $|\xi(s)|^2 > 0$ outside zeros, holds if and only if:
$$\operatorname{Re}\left(\frac{\xi'(s)}{\xi(s)}\right) > 0.$$

## Hypotheses / Conditions
- $s \in \mathbb{C}$ away from zeros of $\xi(s)$.
- Consistent convention on variable identification between the upper half-plane de Branges parameter $z$ and strip coordinate $s = 1/2 + iz$.

## How It Applies
This identity rigorously reduces the contractivity of the Hermite-Biehler / de Branges companion function $E_+(z)$ in the upper half-plane to the sign of the real part of the logarithmic derivative $\operatorname{Re}(\xi'(s)/\xi(s))$ across the critical strip. Coupled with the conformal logarithmic derivative identity $\operatorname{Re}(\xi'/\xi) = 2(\sigma - 1/2)\operatorname{Re}(F) - 2t\operatorname{Im}(F)$, it forms the exact analytical link between de Branges space theory and Herglotz/spectral theory of $\Xi_*(z)$.

## Caveats
- The identity is an algebraic equivalence. Proving that the right-hand side is strictly positive for $\sigma > 1/2$ is equivalent in depth to the Riemann Hypothesis.
- Near zeros, sign competition between $\operatorname{Re}(F)$ and $\operatorname{Im}(F)$ prevents proving positivity via separate termwise bounds (see observation on polarization decomposition sign competition).
