# Semilocal scattering and signed arithmetic phases

This collection fixes the complete finite-place multiplier and the negative-frequency Hardy projection throughout. Every admitted prime contributes all of its powers, including powers beyond the place cutoff. These are written proofs. No Lean source here proves the analytic scattering estimates or the missing RH premise.

## The fixed finite-place operator

The [semilocal foundation](semilocal-weighted-scattering.md) starts with Connes–Consani's distinction between exact triangularity and triangularity modulo compact operators. It identifies the compact negative part with the singular values of the lower corner, proves ordinary Schwartz-weighted trace class, and gives the exact finite signed trace. For a fixed nonzero compact test, the canonical positive and negative weighted traces both diverge as places are added, even though their difference stabilizes. Separate bounds therefore lose the required cancellation.

The [continuum counterphase](continuum-scattering-counterphase.md) retains the exact conjugated cocycle, restores the two pole moments, and subtracts the principal prime density before taking a norm. Its compactness and winding do not imply positivity. It also proves that this multiplier fails to preserve the actual theta transform image, so the physical test must remain fixed.

The [rational pole factor](rational-scattering-pole-factor.md) replaces the decaying half of that counterphase by $(1+2it)/(1-2it)$. Gamma recurrence shifts the baseline from $1/4$ to $5/4$, and the replacement error is at most $sqrt{2/(Xlog X)}$ in Hilbert–Schmidt norm, uniformly in the complete finite prime product.

## Collective estimates before the signed readout

The [signed tail energy](signed-scattering-tail-energy.md) gives an exact Hilbert–Schmidt identity with the Brownian kernel $min(a,b)$. A harmonic-oscillator factorization yields a sufficient trace-norm bound that retains every prime–prime and prime–density cross term.

The [frequency-transport proof](signed-scattering-phase-transport.md) instead couples the prime measure with the continuum in one dimension. A $1/2$-Hölder bound for moving Hardy frequency intervals retains the endpoint mass and gives the unconditional estimate

$$
N_chi(widehat U_X)
=O_chi!left(sqrt X e^{-csqrt{log X}}+log X+1
ight)
=o_chi(sqrt X).
$$

The [discrepancy-to-norm theorem](prime-discrepancy-scattering-norm.md) inserts the complete signed prime-power discrepancy into the tails before taking their $L^2$ norm. It proves

$$
psi(x)-x=O(x^etalog^m x)quadLongrightarrowquad
N_chi(widehat U_X)=O_chi(X^{eta-1/2}log^{m+3/2}X+log X+1)
$$

for $eta>1/2$. Its stated boundary estimate at $eta=1/2$ has one extra logarithmic power. This is a different proof from the transport estimate and avoids its geometric mean of unsigned mass and discrepancy.

## The remaining norm criterion

The [single-observation theorem](single-observation-scattering-criterion.md) proves that one fixed everywhere-positive Schwartz observation satisfying $N_chi(widehat U_X)=O_epsilon(X^{sigma+epsilon})$ for every $epsilon>0$ excludes all zeros with real part greater than $1/2+sigma$. The proof uses local $L^1$-valued continuation and the positive residue of a zero of any multiplicity. It needs no globally rightmost zero.

Consequently RH is equivalent to the subpower bound for that one observation. The available unconditional $o(sqrt X)$ estimate is weaker, and no sign of the full Weil form follows from the finiteness of these auxiliary norms. The [arithmetic subject index](arithmetic-subject-index.md) records the counting, division and covariance identities that may supply further input.
