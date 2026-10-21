# Poisson-Jensen Boundary Modulus Invariance Under Complex Conjugation of Zeros

Type: observation
Confidence: high
Source: Candidate 23 (Level 0, Exploration Round 3)
Relevant to: Poisson-Jensen formula, Carleman formulas, half-plane dispersion, boundary modulus techniques

## Statement
In any Poisson-Jensen or boundary modulus dispersion formula evaluated along the real axis $\mathbb{R}$ (or any symmetry axis for a real entire function $F(\bar{z}) = \overline{F(z)}$), the boundary modulus $|F(x)|$ depends on zeros $\lambda = u + iv$ purely through the squared distance:
$$|x - \lambda|^2 = (x - u)^2 + v^2$$
Because this expression is strictly invariant under complex conjugation $\lambda \leftrightarrow \bar{\lambda}$ (i.e., $v \leftrightarrow -v$), the boundary modulus $|F(x)|$ on $\mathbb{R}$ is identical whether an off-axis zero lies in the upper half-plane $\mathbb{C}^+$ ($v > 0$) or in the lower half-plane $\mathbb{C}^-$ ($v < 0$).
Consequently, any argument attempting to deduce that $F$ has no zeros in $\mathbb{C}^-$ by computing an integral of $\log|F(x)|$ along the real axis and equating it to a sum over zeros in $\mathbb{C}^-$ will produce an identical boundary value if the zeros are reflected into $\mathbb{C}^+$, creating an inescapable sign ambiguity or structural defect.

## Evidence
For a canonical Hadamard/Weierstrass product with zeros $\{\lambda_k\}$, the boundary modulus on $x \in \mathbb{R}$ is given by:
$$|F(x)| = |C| e^{A x} \prod_k \left|1 - \frac{x}{\lambda_k}\right| e^{\operatorname{Re}(x/\lambda_k + \dots)}$$
Replacing any zero $\lambda_k = u_k + i v_k$ with its conjugate $\bar{\lambda}_k = u_k - i v_k$ leaves $|x - \lambda_k| = |x - \bar{\lambda}_k|$ and $\operatorname{Re}(x/\lambda_k) = \operatorname{Re}(x/\bar{\lambda}_k) = x u_k / (u_k^2 + v_k^2)$ invariant.
In candidate 23's attempt to use Poisson-Jensen in the lower half-plane $\mathbb{C}^-$, the boundary integral $\frac{1}{\pi} \int_{\mathbb{R}} P(z, x) \log|\Xi_*(x)| dx$ cannot distinguish between a zero at $\lambda \in \mathbb{C}^-$ and its symmetric partner $\bar{\lambda} \in \mathbb{C}^+$.

## Implications
Boundary modulus data along the axis of symmetry cannot unilaterally certify the half-plane location of zeros without incorporating phase data ($\arg F(x)$), harmonic measure gradients, or asymmetric domain boundaries that break the reflection symmetry.

## Caveats
This obstruction specifically applies when boundary integrals are evaluated purely along the real axis (the line of reflection symmetry) using modulus data alone. Contours that enter the interior of $\mathbb{C}^-$ or include directed winding numbers break this symmetry.
