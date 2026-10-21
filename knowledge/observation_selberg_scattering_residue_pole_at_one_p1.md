# Selberg Automorphic Scattering Matrix Pole and Contraction Failure at s = 1

Type: observation
Confidence: high
Source: Candidate explorer_r2_L00_N21 (Iteration 1, Round 2, Level 0)
Relevant to: Automorphic scattering methods, Eisenstein series, Lax-Phillips semigroups on $\operatorname{SL}(2, \mathbb{Z})\backslash\mathbb{H}$, and inner function formulations of RH.

## Statement
The scalar scattering matrix $\phi(s)$ of the Laplace-Beltrami operator on the modular surface $X = \operatorname{SL}(2, \mathbb{Z})\backslash\mathbb{H}$ is given by Selberg's exact formula:
$$\phi(s) = \sqrt{\pi} \frac{\Gamma(s - 1/2)}{\Gamma(s)} \frac{\zeta(2s - 1)}{\zeta(2s)} = \frac{s}{s - 1} \frac{\xi(2s - 1)}{\xi(2s)}$$
The factor $\frac{s}{s-1}$ arises because the completed zeta function definition $\xi(w) = \frac{1}{2}w(w-1)\pi^{-w/2}\Gamma(w/2)\zeta(w)$ evaluates to $\frac{2s-2}{2s} = \frac{s-1}{s}$ in the ratio $\frac{\xi(2s-1)}{\xi(2s)}$.
Consequently:
1. The scattering matrix $\phi(s)$ is NOT equal to $\frac{\xi(2s-1)}{\xi(2s)}$; it possesses an explicit simple pole at $s = 1$ with residue:
$$\operatorname{Res}_{s=1} \phi(s) = \frac{1}{\operatorname{vol}(X)} = \frac{3}{\pi} \approx 0.9549296586$$
corresponding to the constant Laplace eigenfunction $\lambda_0 = 0$.
2. Because $s = 1$ lies inside the physical half-plane $\operatorname{Re}(s) \ge 1/2$, $\phi(s)$ is NOT holomorphic on $\operatorname{Re}(s) \ge 1/2$.
3. The claim that $\phi(s)$ satisfies the inner contraction bound $|\phi(s)| \le 1$ on $\operatorname{Re}(s) \ge 1/2$ is mathematically false. Near $s = 1$, $|\phi(s)| \to \infty$. Along the real segment $s \in (1, 3.5)$, $\phi(s) > 1$ strictly (e.g. $\phi(1.05) \approx 19.96$, $\phi(1.1) \approx 10.41$, $\phi(1.5) \approx 2.74$).

## Evidence
High-precision evaluation in mpmath (35 decimal digits) confirming $\lim_{s \to 1} (s-1)\phi(s) = 3/\pi$ to 15 decimal digits, and direct numerical evaluation showing $|\phi(s)| > 1$ for all tested points in $s \in [1.05, 3.5]$.

## Implications
Strategies attempting to model $\phi(s)$ as an inner function or contractive transmission operator on $\operatorname{Re}(s) \ge 1/2$ fail at the real axis point $s = 1$. Even if the pole is excised by considering the normalized ratio $\Phi(s) = \frac{\xi(2s-1)}{\xi(2s)}$ (which is an inner function), inner function contraction $|\Phi(s)| \le 1$ does not restrict the location of interior zeros: arbitrary Blaschke products $B(s) = \prod \frac{s - s_k}{s + \bar{s}_k - 1}$ satisfy $|B(1/2+it)| = 1$ and $|B(s)| \le 1$ while possessing zeros anywhere in $\operatorname{Re}(s) > 1/2$.

## Caveats
Cuspidal truncations or subtracting the constant eigenfunction projection can remove the pole at $s = 1$, but this introduces boundary operator terms whose spectral properties are equivalent to RH.
