# Off-Line Zero Quadruplet Curvature Defect Overpowering by Adjacent Roots

Type: observation
Confidence: high
Source: Candidates explorer_r2_L00_N16, explorer_r2_L00_N23 (Iteration 1, Round 2, Level 0)
Relevant to: Strategies attempting to disprove the existence of off-line zeros by showing that their negative curvature defect $-2/y_0^2$ in $-d^2/dt^2 \log |\Xi(t)| = L[\Xi](t)/\Xi(t)^2$ creates a detectable local sign reversal.

## Statement
In the partial fraction decomposition of the transverse curvature along the critical axis:
$$\frac{L[\Xi](t)}{\Xi(t)^2} = -\frac{d^2}{dt^2} \log |\Xi(t)| = \sum_n \operatorname{Re}\left( \frac{1}{(t - z_n)^2} \right) = \sum_n \frac{(t - \gamma_n)^2 - y_n^2}{((t - \gamma_n)^2 + y_n^2)^2}$$
a hypothetical off-line zero quadruplet $\{\pm \gamma_0 \pm i y_0\}$ ($y_0 > 0$) creates a singular negative defect of $-2/y_0^2$ at $t = \gamma_0$.
However, this negative defect does NOT necessarily force the total curvature $L[\Xi](\gamma_0)$ to become negative. Any adjacent critical zero $\gamma_{\text{adj}}$ at distance $\delta := |\gamma_0 - \gamma_{\text{adj}}| < y_0 / \sqrt{2}$ contributes a positive term:
$$\frac{1}{\delta^2} > \frac{2}{y_0^2}$$
which completely neutralizes and overpowers the negative quadruplet defect.

## Evidence
Explicit partial fraction evaluation on counterexample $f(t) = ((t-1)^2 + 1/4)((t+1)^2 + 1/4)(t^2 - 1.21)$ from N23:
At $t = 1$, the off-real quadruplet at $\pm 1 \pm 0.5i$ ($y_0 = 0.5$) contributes a negative defect of $-2/(0.5)^2 = -8$.
However, the adjacent real root at $t = 1.1$ ($\delta = 0.1$) contributes $+1/(0.1)^2 = +100$.
The net partial fraction sum at $t = 1$ is:
$$\frac{L[f](1)}{f(1)^2} = -8 + 0.415 + 100 + 0.227 = +92.642 > 0$$
At high ordinates $T$, the mean zero spacing decays as $\Delta T \sim 2\pi / \log T \to 0$. Any potential off-line zero situated near an ordinary critical zero will have its negative curvature defect overwhelmed by the positive $1/\delta^2$ contribution of its neighbor.

## Implications
Proof strategies cannot claim that an off-line zero forces $L[\Xi](\gamma_0) < 0$ or turns the critical line into a transverse local maximum. Transverse modulus convexity $M''(0) > 0$ at the critical line can fully coexist with an off-critical zero at displacement $y_0 > 0$, because the transverse slice $M(y) = |\Xi(\gamma_0 - iy)|^2$ can have a local minimum at $y = 0$, increase to an intermediate local maximum, and then descend to zero at $y = y_0$.

## Caveats
If $y_0$ is extremely small (e.g. $y_0 < 10^{-6}$) and happens to lie in a wide gap between critical zeros ($\delta \gg y_0$), the defect $-2/y_0^2$ would dominate locally. But without an a priori lower bound on the separation between off-line zeros and critical zeros, curvature positivity does not exclude off-line zeros.
