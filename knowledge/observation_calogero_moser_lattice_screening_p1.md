# Multi-Particle Calogero-Moser Lattice Screening and Zero Spacing Decay

Type: observation
Confidence: high
Source: Candidate 22 (Level 0 falser report), Candidate L01_N04, explore_falser_L01_N04
Relevant to: De Bruijn-Newman backward heat flow, Calogero-Moser zero repulsion dynamics, and hydrodynamic / particle models of zeta zeros

## Statement
1. Under the de Bruijn-Newman backward heat flow $\partial_t H_t = -\partial_{zz} H_t$, zeros move according to the Calogero-Moser particle equation:
$$\frac{dx_j}{dt} = \sum_{k \ne j} \frac{2}{x_j - x_k}.$$
While an isolated 2-particle system predicts zero collision under backward flow whenever the initial spacing $\Delta x_0 < \sqrt{2}$, in a multi-particle or infinite lattice constellation, surrounding zeros exert counteracting repulsive forces that screen the collapse. For a particle embedded in a 1D lattice with uniform spacing $\delta = 0.5$, the net repulsive force on an off-center perturbation decays from $4.000$ (with 1 pair) to $0.158$ (with 50 pairs), and strictly vanishes in the symmetric infinite-lattice limit.

2. However, multi-particle lattice screening does **not** prevent zero collisions under backward heat flow:
When two adjacent particles approach each other ($\delta \to 0$), the local pairwise attractive force $-2/\delta$ diverges, whereas the tidal restoring force from the background lattice is strictly bounded:
$$F_{\mathrm{lattice}}(\delta) = \sum_{k=1}^\infty \left( \frac{2}{k d + \delta} - \frac{2}{k d - \delta} \right) \approx \frac{\pi^2}{3 d^2} \delta = O(\delta).$$
As $\delta \to 0$, $-2/\delta \to -\infty$ while $F_{\mathrm{lattice}}(\delta) \to 0$. Thus local attractive forces completely overwhelm the lattice field.

3. The zero spacing infimum $\Delta(t) := \inf_{j \ne k} |z_j(t) - z_k(t)| = 0$ for all $t$, because the Riemann-von Mangoldt zero counting formula $N(T) \sim \frac{T}{2\pi} \log \frac{T}{2\pi}$ implies the average spacing $\langle \delta \rangle \sim \frac{2\pi}{\log T} \to 0$ as $T \to \infty$.

4. Simplicity of real zeros on $[0, 1/2]$ is strictly stronger than the Riemann Hypothesis ($\Lambda \le 0$):
The exact polynomial solution $H_t(z) = z^2 - 2t$ satisfies $\partial_t H_t = -\partial_{zz} H_t$ and has only real roots $\pm \sqrt{2t}$ for all $t \ge 0$ (so $\Lambda = 0$), but develops a double root at $z = 0$ at $t = 0$ where $H_0(0) = 0$ and $\partial_z H_0(0) = 0$, violating simplicity. Furthermore, the Riemann Hypothesis allows multiple zeros on the critical line. Thus, claiming logical equivalence between RH and real zero simplicity on $[0, 1/2]$ is mathematically false.

## Evidence
Adversarial falser code probes on Candidate 22 and Candidate L01_N04 evaluated:
1. Lattice screening vs local attraction:
   - In a 101-particle regular lattice ($d = 1.0$), for perturbed pair separation $\delta$:
     - $\delta = 0.50$: Local attraction = $-4.000$, Lattice force = $+0.970$, Net = $-3.030$.
     - $\delta = 0.10$: Local attraction = $-20.000$, Lattice force = $+1.780$, Net = $-18.220$.
     - $\delta = 0.05$: Local attraction = $-40.000$, Lattice force = $+1.905$, Net = $-38.095$.
     - $\delta = 0.01$: Local attraction = $-200.000$, Lattice force = $+1.978$, Net = $-198.022$.
2. Counterexample to simplicity equivalence:
   - For $H_t(z) = z^2 - 2t$: $\partial_t H_t = -2$, $-\partial_{zz} H_t = -2$. Zeros are $z = \pm\sqrt{2t} \in \mathbb{R}$ for $t \ge 0$, non-real for $t < 0$. Thus $\Lambda = 0$. But $H_0(0) = 0$ and $H_0'(0) = 0$.
3. High-frequency zero spacing:
   - Among the first 100 non-trivial zeta zeros, 19 pairs have spacing $\Delta \gamma < \sqrt{2} \approx 1.414$, and high-frequency zeros have mean spacing $\sim 2\pi/\log T \to 0$.

## Implications
1. Neither isolated 2-particle thresholds nor multi-particle lattice screening can resolve the de Bruijn-Newman backward heat collision problem.
2. The backward heat equation $\partial_t H_t = -\partial_{zz} H_t$ remains an ill-posed parabolic PDE backward in time; high-frequency Fourier modes are magnified by $\exp(\Delta t \cdot u^2) \sim 10^{955}$ at $u=100$ across $\Delta t = 0.22$.
3. Proving real-rootedness cannot be reduced to zero simplicity without overclaiming.

## Caveats
The Calogero-Moser equation accurately describes zero velocities under heat flow only as long as zeros remain simple and real. If zeros collide or leave the real axis, the dynamic becomes complex and singular.
