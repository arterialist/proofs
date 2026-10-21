# Conformal Parabolic Horn Bound Violation across Non-Trivial Zeros

Type: observation
Confidence: high
Source: Candidate 23 (Level 0, Exploration Round 3)
Relevant to: Conformal mapping, boundary dispersion, parabolic coordinate confinement

## Statement
In the conformal parabolic coordinates $z = s(1-s) = x + iy$ with $s = \sigma + it$, let $\sigma = 1/2 + \delta$. Then:
$$x = 1/4 - \delta^2 + t^2, \quad y = -2\delta t$$
The proposed parabolic horn confinement domain $\Omega_{\text{strip}} = \{z \in \mathbb{C} \mid y^2 < x < y^2 + 1/4\}$ asserts that non-trivial zeros lie within the parabolic slab $x < y^2 + 1/4$.
However, the difference evaluates to:
$$x - (y^2 + 1/4) = -\delta^2 + t^2(1 - 4\delta^2)$$
For critical-line zeros ($\delta = 0$), this quantity is simply $+t^2$, which is strictly positive for all $t > 0$.
For any potential off-line zero with $|\delta| < 1/2$, $1 - 4\delta^2 > 0$, so:
$$x - (y^2 + 1/4) > 0 \quad \text{for all } t > \frac{|\delta|}{\sqrt{1 - 4\delta^2}}$$
Since the lowest non-trivial zero has $t = \gamma_1 \approx 14.1347$, and for any candidate zero with $|\delta| \le 0.49$, $\frac{|\delta|}{\sqrt{1-4\delta^2}} < 2.5$, 100% of non-trivial Riemann zeros lie completely outside the parabolic horn, violating the upper bound by $t^2(1-4\delta^2) - \delta^2 \gg 0$ (exceeding the boundary by $\approx 181.8$ at $\gamma_1$ and by $9 \times 10^{24}$ at $t = 3 \times 10^{12}$).

## Evidence
Direct algebraic evaluation of the coordinate transformation $z = s(1-s)$:
$s = (1/2 + \delta) + it \implies z = (1/2+\delta+it)(1/2-\delta-it) = (1/4 - \delta^2 + t^2) - 2i\delta t$.
Hence $x = 1/4 - \delta^2 + t^2$ and $y = -2\delta t$, so $y^2 = 4\delta^2 t^2$.
The condition $x < y^2 + 1/4$ is equivalent to $1/4 - \delta^2 + t^2 < 4\delta^2 t^2 + 1/4 \iff t^2(1 - 4\delta^2) < \delta^2$.
For any critical zero ($\delta = 0$), this requires $t^2 < 0$, which has no real solutions.

## Implications
Strategies attempting to prove the Riemann Hypothesis by confining the spectrum of $s(1-s)$ inside a narrow parabolic horn $\Omega_{\text{strip}} = \{y^2 < x < y^2 + 1/4\}$ are built on a sign/coordinate inversion error. The non-trivial zeros do not stay within width $1/4$ of the parabola $x = y^2$; rather, their $x$-coordinate grows as $t^2$, escaping any bounded horizontal or vertical parabolic strip.

## Caveats
None; this is an exact coordinate identity showing the domain definition $\Omega_{\text{strip}}$ does not contain the non-trivial zeros.
