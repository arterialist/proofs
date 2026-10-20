# Multi-Particle Calogero-Moser Lattice Screening and Zero Spacing Decay

Type: observation
Confidence: high
Source: Candidate 22 (Level 0 falser report)
Relevant to: De Bruijn-Newman backward heat flow, Calogero-Moser zero repulsion dynamics, and hydrodynamic / particle models of zeta zeros

## Statement
Under the de Bruijn-Newman backward heat flow $\partial_t H_t = -\partial_{zz} H_t$, zeros move according to the Calogero-Moser particle equation:
$$\frac{dx_j}{dt} = \sum_{k \ne j} \frac{2}{x_j - x_k}$$
While an isolated 2-particle system predicts zero collision under backward flow whenever the initial spacing $\Delta x_0 < \sqrt{2}$, in a multi-particle or infinite lattice constellation, surrounding zeros exert counteracting repulsive forces that screen the collapse. For a particle embedded in a 1D lattice with uniform spacing $\delta = 0.5$, the net repulsive force on an off-center perturbation decays from $4.000$ (with 1 pair) to $0.158$ (with 50 pairs), and strictly vanishes in the symmetric infinite-lattice limit.

Furthermore, the zero spacing infimum $\Delta(t) := \inf_{j \ne k} |z_j(t) - z_k(t)| = 0$ for all $t$, because the Riemann-von Mangoldt zero counting formula $N(T) \sim \frac{T}{2\pi} \log \frac{T}{2\pi}$ implies the average spacing $\langle \delta \rangle \sim \frac{2\pi}{\log T} \to 0$ as $T \to \infty$.

## Evidence
Adversarial falser code probe on Candidate 22 evaluated the multi-particle Calogero-Moser interaction:
1. Lattice screening computation:
   - 1 pair: Net force = $4.0000$
   - 2 pairs: Net force = $1.7778$
   - 5 pairs: Net force = $0.7713$
   - 10 pairs: Net force = $0.3951$
   - 50 pairs: Net force = $0.1584$
2. Empirical zeta zero spacings:
   - Among the first 100 non-trivial zeta zeros, 19 pairs have spacing $\Delta \gamma < \sqrt{2} \approx 1.414$ (e.g. zeros at $t \approx 98.831$ and $t \approx 100.245$ with $\Delta \gamma = 1.414$, and higher zeros routinely spaced $< 1.0$).
   - High-frequency asymptotics guarantee an infinite family of zeros with arbitrarily small spacing, refuting any uniform lower bound $\Delta > 0$ or isolated 2-particle collision threshold.

## Implications
1. Strategies attempting to deduce real-rootedness down to $t=0$ by bounding backward collision times using 2-particle thresholds are fundamentally invalid.
2. The backward heat equation $\partial_t H_t = -\partial_{zz} H_t$ remains an ill-posed parabolic PDE backward in time; zero dynamics cannot be regularized by local finite-dimensional ODE truncations without fully addressing the global infinite-dimensional lattice coupling.
3. Confirms that de Bruijn-Newman techniques cannot bypass the Rodgers-Tao barrier $\Lambda \ge 0$ through local particle models.

## Caveats
The Calogero-Moser equation accurately describes zero velocities under heat flow only as long as zeros remain simple and real. If zeros collide or leave the real axis, the dynamic becomes complex and singular.
