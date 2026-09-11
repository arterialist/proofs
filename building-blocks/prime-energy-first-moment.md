# Exact prime-energy balance and a bounded signed first moment

Let $\Lambda$ be the von Mangoldt function, including every prime power, and put

$$
e_n=\psi(n)-n,\qquad a_n=\Lambda(n)-1,
\qquad \psi(n)=\sum_{k\le n}\Lambda(k).
$$

Then $e_0=0$ and $e_n-e_{n-1}=a_n$. [PrimeEnergy](BuildingBlocks/PrimeEnergy.lean) and [PrimeSignedAverage](BuildingBlocks/PrimeSignedAverage.lean) formalize the finite identities and unconditional estimates below. They are elementary summation-by-parts results, not an RH estimate or a first-formalization claim.

Define

$$
V_N=\sum_{n=1}^N\frac{e_n^2}{n(n+1)},\qquad
D_N=\sum_{n=1}^N\frac{e_{n-1}a_n}{n},\qquad
I_N=\sum_{n=1}^N\frac{a_n^2}{n}.
$$

The exact balance is

$$
\boxed{V_N=2D_N+I_N-\frac{e_N^2}{N+1}.}              \tag{1}
$$

To prove it, telescope the weighted differences $\sum_{n\le N}(e_n^2-e_{n-1}^2)/n$ and insert $e_n^2-e_{n-1}^2=2e_{n-1}a_n+a_n^2$. The terminal square is part of the identity. The theorem `weighted_energy_balance` proves the summation formula for any real sequence starting at zero; `prime_energy_balance` specializes it to the actual arithmetic sequence.

For $N\ge1$,

$$
I_N\le2(\log N)^2+1+\log N.                         \tag{2}
$$

Indeed $0\le\Lambda(n)\le\log N$ for $n\le N$, hence $(\Lambda(n)-1)^2\le\Lambda(n)\log N+1$. The exact factorization sum $\log(N!)=\sum_{n\le N}\lfloor N/n\rfloor\Lambda(n)$ implies $\sum_{n\le N}\Lambda(n)/n\le2\log N$ by the elementary bounds $\log(N!)\le N\log N$ and $\psi(N)\le N\log N$. Summing the inequality and using $H_N\le1+\log N$ proves (2).

Thus

$$
V_N+\frac{e_N^2}{N+1}
\le2D_N+2(\log N)^2+1+\log N.                        \tag{3}
$$

A bound on the signed drift $D_N$ would control the energy and terminal error. Equation (2) alone does not do so. In fact the actual drift is already positive at $N=2$:

$$
D_2=(1-\log2)/2>0.
$$

This rules out an everywhere-nonpositive drift premise, not a suitable asymptotic upper bound. As a general-sequence comparison, the trajectory $e_n=n$ has increment energy $H_N$ but $V_N\ge N/2$, so a small diagonal increment energy by itself cannot imply a small error energy.

## An unconditional signed first moment

Let $L_N=\sum_{n\le N}\Lambda(n)/n$. The exact floor remainder is

$$
NL_N-\log(N!)
=\sum_{n\le N}\left(\frac Nn-\left\lfloor\frac Nn\right\rfloor\right)\Lambda(n),
\qquad 0\le NL_N-\log(N!)\le\psi(N).
$$

Using the elementary Chebyshev estimate $\psi(N)\le4(\log2)N$ and integral bounds for $\log(N!)$ gives

$$
\log N-1\le L_N\le\log N+4\log2\qquad(N\ge1).       \tag{4}
$$

The Chebyshev and factorial estimates are proved in the existing [CoarsePrimeBounds](BuildingBlocks/CoarsePrimeBounds.lean) and [DivisorForcingBound](BuildingBlocks/DivisorForcingBound.lean) modules; no prime number theorem is used.

Ordinary partial summation, with the terminal value retained, yields

$$
\sum_{n=1}^N\frac{e_n}{n(n+1)}
=L_N-H_N-\frac{e_N}{N+1}.                            \tag{5}
$$

From (4), $\log N\le H_N\le1+\log N$, and $-1\le e_N/(N+1)\le4\log2$, it follows that

$$
\boxed{\left|\sum_{n=1}^N\frac{e_n}{n(n+1)}\right|
\le2+4\log2\qquad(N\ge0).}                          \tag{6}
$$

This is `signedPrimeErrorAverage_abs_le`. The signed first moment (6) is a different observable from the nonnegative energy $V_N$ and supplies no bound for it.

The classical arithmetic ingredients are $\log n=\sum_{d\mid n}\Lambda(d)$ and finite partial summation; see [DLMF §27.6](https://dlmf.nist.gov/27.6). The new extracted Lean sources compile using Lean 4.24.0 and the repository's pinned mathlib. Their full transitive axiom closure contains only the standard Lean axioms; no prime-distribution premise is hidden in (1), (2), (4), (5) or (6).
