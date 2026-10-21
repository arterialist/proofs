# Laguerre-Pólya Class Characterization via Differential Invariants

Type: reference
Confidence: high
Source: Candidates explorer_r2_L00_N16, explorer_r2_L00_N18, explorer_r2_L00_N23 (Iteration 1, Round 2, Level 0)
Relevant to: Entire function real-rootedness, Laguerre-Turán inequalities, Jensen polynomial hyperbolicity, and the Riemann Hypothesis.

## Bibliographic Info
- Authors: Edmond Laguerre (1882); George Pólya (1927)
- Title: Laguerre: "Sur les fonctions du genre zéro et du genre un" (1882); Pólya: "Über die algebraisch-funktionentheoretischen Untersuchungen von J. L. W. V. Jensen" (1927)
- Year: 1882, 1927
- ArXiv/DOI: Laguerre: C. R. Acad. Sci. Paris; Pólya: Kgl. Danske Vid. Selsk. Math.-Fys. Medd. VII, 17 (1927), pp. 3–33.
- Theorem/Lemma Number: Laguerre-Pólya Theorem
- Verified via web search: yes

## Key Result
The Laguerre-Pólya class $\mathcal{LP}$ consists of all real-entire functions $f(z)$ that are uniform limits on compact subsets of polynomials with exclusively real roots. An entire function of order $\le 2$ belongs to $\mathcal{LP}$ if and only if it admits the Hadamard representation:
$$f(z) = c z^m e^{-\alpha z^2 + \beta z} \prod_{n=1}^\infty \left(1 - \frac{z}{x_n}\right) e^{z/x_n}$$
where $c, \beta, x_n \in \mathbb{R}$, $\alpha \ge 0$, $m \in \mathbb{N}$, and $\sum x_n^{-2} < \infty$.
A real-entire function $f$ belongs to $\mathcal{LP}$ if and only if all higher Laguerre differential invariants are non-negative on the real axis:
$$L_k[f](t) := (f^{(k+1)}(t))^2 - f^{(k)}(t) f^{(k+2)}(t) \ge 0 \quad \text{for all } k = 0, 1, 2, \dots \text{ and } t \in \mathbb{R}$$
Equivalently, $f \in \mathcal{LP}$ if and only if all associated Jensen polynomials $J_d^{n, f}(X)$ are hyperbolic (have exclusively real roots) for all degrees $d \ge 1$ and shifts $n \ge 0$.

## Hypotheses / Conditions
- $f(z)$ must be an entire function with real Taylor coefficients at the origin.
- Non-negativity must hold for ALL derivatives $k \ge 0$, not merely $k = 0$.
- Hyperbolicity must hold for all degrees $d \ge 1$.

## How It Applies
Since the completed Riemann zeta function $\Xi(t) = \xi(1/2+it)$ is an even real-entire function of order 1, the Riemann Hypothesis is precisely the statement that $\Xi \in \mathcal{LP}$.
While $L_0[\Xi](t) = (\Xi'(t))^2 - \Xi(t)\Xi''(t) \ge 0$ is a necessary condition for RH, it is strictly insufficient by itself (counterexamples of degree 6 exist with $L_0 > 0$ and non-real roots).

## Caveats
1. $L_0[f] \ge 0$ alone does NOT imply $f \in \mathcal{LP}$.
2. Proving that $\Xi \in \mathcal{LP}$ unconditionally carries 100% of the analytical depth of the Riemann Hypothesis.
3. Csordas-Norfolk-Varga (1986) proved Jensen hyperbolicity for $\Xi$ at degree $d \le 4$; Griffin-Ono-Rolen-Zagier (2019) proved hyperbolicity for large shifts $n \ge n_0(d)$; but descending to shift $n = 0$ for all $d \ge 5$ remains open and equivalent to RH.
