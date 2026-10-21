# Unimodular Hankel Operator Norm Vacuity on the Real Axis

Type: observation
Confidence: high
Source: Candidate explore_merger_r2_L01_N05 (Level 1, Iteration 1, Round 2)
Relevant to: Operator-theoretic, Nehari, and Hankel operator criteria for inner functions and de Branges spaces.

## Statement
In Hardy space theory on the upper half-plane $H^2(\mathbb{C}^+)$, let $\Theta(u)$ be any unimodular measurable function on $\mathbb{R}$ ($|\Theta(u)| = 1$ almost everywhere).
The Hankel operator $H_\Theta: H^2(\mathbb{C}^+) \to H^2(\mathbb{C}^-) \cong (H^2)^\perp$ is defined by $H_\Theta f = P_-(\Theta f)$.
By Nehari's theorem, the operator norm of $H_\Theta$ satisfies:
$$\|H_\Theta\| = \operatorname{dist}_{L^\infty}(\Theta, H^\infty(\mathbb{C}^+)) \le \|\Theta\|_{L^\infty(\mathbb{R})} = 1.$$
Therefore, the inequality $\|H_\Theta\| \le 1$ holds **unconditionally and vacuously** for every unimodular boundary symbol on $\mathbb{R}$.
In particular, $\|H_\Theta\| \le 1$ does **not** imply that $\Theta$ is an inner function in $\mathbb{C}^+$.
A function $\Theta$ is inner if and only if $\Theta \in H^\infty(\mathbb{C}^+)$, which is equivalent to $\|H_\Theta\| = 0$ (not $\le 1$).

## Evidence
- Nehari's Theorem: $\|H_\phi\| = \inf_{h \in H^\infty} \|\phi - h\|_\infty$. For any $\phi$ with $\|\phi\|_\infty \le 1$, choosing $h = 0$ yields $\|H_\phi\| \le \|\phi - 0\|_\infty \le 1$.
- Explicit Counterexample: Consider the Blaschke factor for a point in the upper half-plane:
  $$\Theta(z) = \frac{z + i}{z - i}.$$
  For $u \in \mathbb{R}$, $|\Theta(u)| = \left|\frac{u+i}{u-i}\right| = 1$, so $\|\Theta\|_{L^\infty(\mathbb{R})} = 1$, and consequently $\|H_\Theta\| \le 1$ (in fact $\|H_\Theta\| = 1$).
  However, $\Theta(z)$ has a simple pole at $z = i \in \mathbb{C}^+$. It is meromorphic in $\mathbb{C}^+$, not analytic, and satisfies $|\Theta(2i)| = |3i/i| = 3 > 1$. Thus $\Theta$ is not contractive in $\mathbb{C}^+$ and is not inner, despite satisfying $\|H_\Theta\| \le 1$.

## Implications
Strategies that attempt to prove the Hermite-Biehler property or RH by constructing a scattering phase or ratio $\Theta(u) = E^*(u)/E(u)$ on $\mathbb{R}$ and showing $\|H_\Theta\| \le 1$ are proving a trivial identity that holds for all unimodular phase factors, including those with poles in $\mathbb{C}^+$. To establish innerness or contractivity in $\mathbb{C}^+$, one must prove $\|H_\Theta\| = 0$ (i.e., that $\Theta$ has zero antianalytic projection in $H^2$), which is mathematically equivalent to the absence of poles in $\mathbb{C}^+$.

## Caveats
If the symbol $\Theta$ is already known to be analytic in $\mathbb{C}^+$, then contractivity $|\Theta(z)| \le 1$ on $\mathbb{C}^+$ follows from the maximum modulus principle applied to the boundary values $|\Theta(u)| \le 1$. The failure occurs precisely when trying to deduce analyticity/innerness from boundary unimodularity via Hankel norm bounds.
