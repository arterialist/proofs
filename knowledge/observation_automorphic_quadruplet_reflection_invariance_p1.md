# Automorphic Quadruplet Reflection Invariance and Scattering Symmetry Preservation

Type: observation
Confidence: high
Source: Aggregator Node L01_N10 (Level 1)
Relevant to: Automorphic scattering determinants, Selberg trace formula, Eisenstein series reflection relations, and functional equation symmetry arguments

## Statement
Let $\rho_0 = \frac{1}{2} + d + i\gamma$ be any hypothetical off-line zero of $\zeta(s)$ with displacement $d \in (0, 1/2)$ and ordinate $\gamma \in \mathbb{R}$. By the functional equation and Schwarz reflection, the zero must occur as part of a quadruplet of zeros:
$$\mathcal{Q}(\rho_0) = \left\{ \frac{1}{2} + d + i\gamma, \; \frac{1}{2} - d + i\gamma, \; \frac{1}{2} + d - i\gamma, \; \frac{1}{2} - d - i\gamma \right\}.$$
Let $P_{\mathcal{Q}}(w)$ denote the monic quartic polynomial whose roots are the elements of $\mathcal{Q}(\rho_0)$:
$$P_{\mathcal{Q}}(w) = \left(w - \left(\frac{1}{2} + d + i\gamma\right)\right) \left(w - \left(\frac{1}{2} - d + i\gamma\right)\right) \left(w - \left(\frac{1}{2} + d - i\gamma\right)\right) \left(w - \left(\frac{1}{2} - d - i\gamma\right)\right).$$
Then:
1. **Reflection Invariance**: $P_{\mathcal{Q}}(w)$ is an even function of $(w - 1/2)$. That is,
   $$P_{\mathcal{Q}}(1 - w) \equiv P_{\mathcal{Q}}(w) \quad \text{for all } w \in \mathbb{C}.$$
2. **Scattering Determinant Preservation**: In the theory of automorphic forms on $\operatorname{PSL}(2, \mathbb{Z})\backslash \mathbb{H}$, the continuous scattering determinant $\phi(s)$ satisfies the functional reflection relation $\phi(s)\phi(1-s) \equiv 1$. Removing or inserting an off-line quadruplet $\mathcal{Q}(\rho_0)$ modifies $\phi(s)$ by a Blaschke quadruplet factor $B_{\mathcal{Q}}(s) = \prod_{\rho \in \mathcal{Q}} \frac{s - \rho}{s - (1 - \bar{\rho})}$. Because $\mathcal{Q}$ is closed under $s \mapsto 1-s$ and $s \mapsto \bar{s}$, the factor satisfies:
   $$B_{\mathcal{Q}}(s) B_{\mathcal{Q}}(1-s) \equiv 1.$$
3. **Obstruction to Symmetry Refutations**: Any attempt to refute off-line zeros by showing that an off-line zero would "break the functional equation" $\xi(s) = \xi(1-s)$ or "violate the scattering reflection identity" $\phi(s)\phi(1-s) = 1$ fails identically, because off-line quadruplets naturally and automatically satisfy these symmetries.

## Evidence
- **Algebraic Expansion**:
  Pair the roots into two quadratic factors:
  $$Q_+(w) = \left(w - \frac{1}{2} - i\gamma - d\right)\left(w - \frac{1}{2} - i\gamma + d\right) = \left(w - \frac{1}{2} - i\gamma\right)^2 - d^2,$$
  $$Q_-(w) = \left(w - \frac{1}{2} + i\gamma - d\right)\left(w - \frac{1}{2} + i\gamma + d\right) = \left(w - \frac{1}{2} + i\gamma\right)^2 - d^2.$$
  Multiplying the two quadratics:
  $$P_{\mathcal{Q}}(w) = Q_+(w) Q_-(w) = \left[\left(w - \frac{1}{2}\right)^2 - \gamma^2 - d^2 - 2i\gamma\left(w - \frac{1}{2}\right)\right] \left[\left(w - \frac{1}{2}\right)^2 - \gamma^2 - d^2 + 2i\gamma\left(w - \frac{1}{2}\right)\right]$$
  $$P_{\mathcal{Q}}(w) = \left[\left(w - \frac{1}{2}\right)^2 - \gamma^2 - d^2\right]^2 + 4\gamma^2 \left(w - \frac{1}{2}\right)^2.$$
  This expression depends exclusively on $\left(w - \frac{1}{2}\right)^2$.
  Under $w \mapsto 1 - w$, $\left(1 - w - \frac{1}{2}\right)^2 = \left(\frac{1}{2} - w\right)^2 = \left(w - \frac{1}{2}\right)^2$.
  Therefore, $P_{\mathcal{Q}}(1 - w) - P_{\mathcal{Q}}(w) \equiv 0$ identically for all $w \in \mathbb{C}$ and all $d, \gamma \in \mathbb{R}$.

## Implications
- Off-line zeros do not produce any symmetry breaking in reflection-symmetric objects (such as $\xi(s) = \xi(1-s)$, $|\Xi(t)| = |\Xi(-t)|$, or $\phi(s)\phi(1-s) = 1$).
- Proof strategies that attempt to deduce RH from the functional equation alone are doomed to circularity or vacuity, as the functional equation is fully compatible with off-line zeros grouped in quadruplets.
- Discrepancy functions based on $F(s) - F(1-s)$ vanish identically on all quadruplets and cannot detect off-line zeros.

## Caveats
- While individual quadruplets preserve reflection symmetry, off-line zeros do alter other non-algebraic geometric properties, such as the number of zeros in horizontal strips (Jensen formula), the sign of the real part of logarithmic derivatives $\operatorname{Re}(\xi'/\xi)$, and positivity in de Branges Hilbert spaces.
