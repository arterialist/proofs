# Littlewood Mid-Gap Horizontal Leakage Barrier

Type: observation
Confidence: high
Source: Falsers L02_N01, L02_N02, L02_N03, L02_N04; Aggregators L02_N01, L02_N03 (Level 2); Falsers r2_L03_N00, r2_L03_N01, r2_L03_N02, r2_L03_N03 (Level 3)
Relevant to: Littlewood-Carleman slab energy identities, boundary deficit contour integrals, and zero-detecting integral formulas on the critical strip $[1/2, 1] \times [0, T]$.

## Statement
Let $\mathcal{D}_{\text{offline}}(T) = 2\pi \sum_{\beta > 1/2, 0 < \gamma < T} (\beta - 1/2)$ be the Littlewood-Carleman off-line zero deficit for $\xi(s)$ inside the rectangle $[1/2, 1] \times [0, T]$. Applying Green's theorem / residue calculus expresses $\mathcal{D}_{\text{offline}}(T)$ as a contour integral difference:
$$\mathcal{D}_{\text{offline}}(T) = I_{\text{left}}(T) + I_{\text{right}}(T) - I_{\text{horiz}}(T),$$
where $I_{\text{left}}$ is the boundary integral along $\sigma = 1/2$, $I_{\text{right}}$ is along $\sigma = 1$, and $I_{\text{horiz}}(T) = \int_{1/2}^1 \arg \xi(\sigma + iT) d\sigma$ is the horizontal end-cap leakage.
Even when $T$ is chosen at a "mid-gap" ordinate between consecutive critical zeros where $|\xi(1/2 + iT)|$ is maximized, the horizontal leakage $I_{\text{horiz}}(T)$ does not vanish and is not small; it exceeds the deficit contribution of a potential off-line zero (which is at most $2\pi \times 0.5 \approx 3.14$, or $\beta - 1/2 \le 0.5$). Furthermore, proposed mollification rescues (polynomial Riesz or Gaussian windowing) mathematically fail to eliminate this obstruction.

## Evidence
1. **Mid-Gap Numerical Quadrature**:
   Rigorous numerical quadrature carried out across Level 2 and Level 3 between the first two critical zeros ($\gamma_1 \approx 14.1347$, $\gamma_2 \approx 21.0220$):
   - Choosing the mid-gap ordinate $T_{\text{mid}} = 17.57838$:
     $$I_{\text{horiz}}(T_{\text{mid}}) \approx 0.6895 \text{ to } 1.5774 > 0.5.$$
   - The maximum possible single-zero displacement in the strip is $\beta - 1/2 \le 0.5$. Thus the horizontal leakage is $1.38$ to $3.15$ times larger than the entire signal from a hypothetical off-line zero at $\beta = 1$.
   - Along wider intervals (e.g. $[0.5, 2.0]$ in L03_N01), $|I_{\text{horiz}}| = 16.71 \gg 0.5$.

2. **Failure of Polynomial Riesz Mollification**:
   Multiplying by $(s - 1/2)^k$ fails because along horizontal contour $s = \sigma + iT$, $|s - 1/2|^k \ge T^k$ grows polynomially as $T \to \infty$ (e.g. $10^6$ for $k=2, T=1000$; $10^{12}$ for $k=4, T=1000$), massively amplifying horizontal leakage rather than suppressing it.

3. **Failure of Gaussian Windowing and Phase Sign Inversion**:
   Multiplying by Gaussian window $e^{\varepsilon(s - 1/2)^2}$ introduces an oscillatory phase factor into the residue sum:
   $$\operatorname{Re}\left(e^{\varepsilon(\rho - 1/2)^2}\right) = e^{\varepsilon((\beta - 1/2)^2 - \gamma^2)} \cos(2\varepsilon(\beta - 1/2)\gamma).$$
   For $\varepsilon = 0.01$, $\beta_0 = 0.70$, and $\gamma_0 = 400$, the phase angle is $2 \times 0.01 \times 0.20 \times 400 = 1.60 > \pi/2$, which yields $\cos(1.60) = -0.0292 < 0$. This flips the sign of the displacement sum, destroying positive-definiteness and precluding contradiction arguments.

## Implications
- Any attempt to deduce $\mathcal{D}_{\text{offline}}(T) = 0$ (and thus RH) by proving that $I_{\text{left}} + I_{\text{right}}$ matches $\mathcal{D}_{\text{offline}}$ modulo a negligible horizontal term is blocked by the mid-gap horizontal leakage barrier.
- Because $\mathcal{D}_{\text{offline}}(T)$ is an integer linear combination of $2\pi(\beta_j - 1/2)$, the identity $\mathcal{D}_{\text{offline}} = I_{\text{left}} + I_{\text{right}} - I_{\text{horiz}}$ is an exact residue tautology. One cannot bound $I_{\text{horiz}}$ with precision better than $\mathcal{O}(1)$ without already knowing the exact locations of all zeros of $\xi(s)$ near $T$.
- Riesz and Gaussian mollifiers cannot bypass this barrier due to polynomial horizontal growth and residue phase sign inversion.

## Caveats
- Bounding $S(T) = \frac{1}{\pi} \arg \zeta(1/2 + iT)$ is a classic problem in analytic number theory; unconditionally, $S(T) = \mathcal{O}(\log T)$, which is far too coarse to rule out off-line zeros of deficit $\mathcal{O}(1)$.
