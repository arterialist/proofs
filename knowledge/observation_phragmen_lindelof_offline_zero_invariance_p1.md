# Phragmén-Lindelöf Indicator Invariance Under Off-Line Zeros

Type: observation
Confidence: high
Source: Candidate explorer_r2_L00_N13 (Iteration 1, Round 2, Level 0)
Relevant to: Proof strategies attempting to detect or exclude off-line zeros of $\Xi_*(z)$ or $\Xi(t)$ via asymptotic growth indicators, Phragmén-Lindelöf exponents, or sectorial radial asymptotics.

## Statement
Let $f(z)$ be an entire function of order $\rho \in (0, 1)$ (such as the symmetrized zeta transform $\Xi_*(z) = \Xi(\sqrt{z})$ with order $1/2$), and let $h_f(\theta) = \limsup_{r \to \infty} \frac{\log |f(re^{i\theta})|}{r^\rho}$ be its Phragmén-Lindelöf indicator function.
If an hypothetical off-line zero factor $(1 - z/\rho_0)$ (or quadruplet $\prod (1 - z/\rho_j)$) is introduced or removed, the change in logarithmic modulus along any ray $\arg z = \theta$ is:
$$\Delta \log |f(re^{i\theta})| = \log |1 - re^{i\theta}/\rho_0| = \log r + O(1)$$
Consequently, the perturbation to the Phragmén-Lindelöf indicator is:
$$\Delta h_f(\theta) = \lim_{r \to \infty} \frac{\log r + O(1)}{r^\rho} = 0 \quad (\text{since } \rho > 0)$$
Thus, the asymptotic indicator $h(\theta)$ is completely invariant under the presence or absence of any finite number of off-line zeros, and cannot distinguish an entire function satisfying RH from one with off-line zeros.

## Evidence
Explicit asymptotic analysis for order $\rho = 1/2$. For any finite set of off-line roots $\{z_k\}_{k=1}^m$, the perturbation to $\log |f(z)|$ is at most $m \log(1 + r/|z_k|) \sim m \log r$. Divided by $r^{1/2}$, this tends to 0 as $r \to \infty$. The indicator $h(\theta) = \pi \cos(\theta/2)$ is determined entirely by the infinite sequence of zeros along the critical axis and its global density $(r^{1/2}/4\pi)\log r$, completely drowning out any finite number of off-axis zeros.

## Implications
Asymptotic indicator growth, Phragmén-Lindelöf radial limits, and sectorial indicator comparisons cannot be used to prove that all zeros lie on the real axis (RH). Any criterion based on $h(\theta)$ matching a theoretical profile is satisfied identically whether off-line zeros exist or not.

## Caveats
This invariance applies to finite sets of off-line zeros. An infinite family of off-line zeros with positive relative density would alter $h(\theta)$, but any potential violation of RH consisting of isolated low-lying off-line zeros produces exactly zero signature in the Phragmén-Lindelöf indicator.
