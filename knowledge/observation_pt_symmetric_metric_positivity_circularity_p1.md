# Observation: PT-Symmetric Metric Operator Positivity Circularity and Krein Collapse

Type: mathematical_observation
Confidence: high
Source Nodes: [explorer_r14_L00_N24, explore_merger_r14_L01_N12, explore_merger_r14_L04_N00]

## Summary
Non-Hermitian $\mathcal{PT}$-symmetric quantum mechanics (Bender-Boettcher) and pseudo-Hermitian operator theory (Mostafazadeh) investigate non-self-adjoint differential operators $H \ne H^\dagger$ satisfying $\mathcal{PT} H = H \mathcal{PT}$. In the unbroken $\mathcal{PT}$-symmetric phase, all eigenvalues are real, and there exists an invertible Hermitian metric operator $\eta = e^{-Q} > 0$ such that $H^\dagger = \eta H \eta^{-1}$. Defining the inner product $\langle \psi, \phi \rangle_\eta = \langle \psi, \eta \phi \rangle$ renders $H$ formally self-adjoint on a modified Hilbert space $\mathcal{H}_\eta$.

However, attempting to deduce the reality of the Riemann zeros via pseudo-Hermiticity encounters fatal circularity. Mostafazadeh's spectral theorem proves that a positive definite metric operator $\eta > 0$ intertwining $H$ and $H^\dagger$ exists if and only if the spectrum of $H$ is purely real and possesses a complete set of eigenvectors. If a single off-line zero pair $\rho_0 = \beta_0 \pm i\gamma_0$ ($\beta_0 \ne 1/2$) exists, the $\mathcal{PT}$ symmetry is spontaneously broken, the intertwining operator $\eta$ develops an indefinite signature (possessing negative eigenvalues for odd parity eigenstates), and the underlying space collapses into an indefinite Krein space. Thus, proving that $\eta > 0$ is unconditionally positive definite carries 100% of Millennium RH analytical depth.
