# Complete geometric prime histories and their collective entropy asymptotic

**Authors:** Arterialist RH Research Team (September 2026)  
**Primary References:** `building-blocks/prime-history/complete-prime-history-entropy.md`, `building-blocks/prime-history/causal-history-overflow.md`  
**Classification:** Analytic Number Theory / Large Deviations / Arithmetic Dynamics / Information Theory  

---

## 1. Executive Summary and Statement of Result

Consider the discrete probabilistic model of prime histories arising from the Euler factor unitary at each prime $p$:
\[
 \Pr(\nu_p = 1) = p^{-1}, \qquad \Pr(\nu_p = -j) = (1 - p^{-1})^2 p^{-j} \quad (j \ge 0).
\]
These probabilities are the exact squared moduli of the complete local Euler unitary matrix.
Define the arithmetic log-cost random walk:
\[
 S_X = \sum_{p \le X} \nu_p \log p,
\]
and the associated stop-loss expectation $\mathcal{L}_X(c) = \mathbb{E}[(-S_X - c)_+]$.

**Theorem (Collective Prime History Entropy Asymptotic).**
Let $\ell = \log X$. Locally uniformly for any scaling parameter $\kappa > 0$:
\[
 \boxed{\quad \log \mathcal{L}_X(\kappa X) = -\kappa X + \frac{X}{\log X} \Big[(\kappa+1)\log(\kappa+1) - \kappa\log\kappa\Big] + o\left(\frac{X}{\log X}\right). \quad}
\]
The second-order coefficient is precisely the Shannon entropy:
\[
 \mathcal{H}(\operatorname{Geom}(\tfrac{1}{\kappa+1})) = (\kappa+1)\log(\kappa+1) - \kappa\log\kappa
\]
of a geometric distribution with mean $\kappa$, multiplied by the prime count $\pi(X) \sim X/\log X$.

---

## 2. Mathematical Proof

### Step 1: Moment Generating Function on $t < 1$
For real $t < 1$, the exact local moment generating function is:
\[
 M_p(t) = \mathbb{E}[e^{-t \nu_p \log p}] = \frac{1 - 2/p + p^{-1-t}}{1 - p^{t-1}}, \qquad K_X(t) = \sum_{p \le X} \log M_p(t).
\]
The domain of finiteness is strictly bounded above by $t < 1$ (already forced by the smallest prime $p=2$).
Each local variable has zero mean $\mathbb{E}[\nu_p \log p] = 0$ and variance $\operatorname{Var}(\nu_p \log p) = \frac{2(\log p)^2}{p - 1}$.

### Step 2: Critical Boundary Scaling $t = 1 - v/\ell$
For $v$ in any compact interval $J \subset (0, \infty)$ and $t = 1 - v/\ell$, write $z_p = \frac{\log p}{\log X} \in (0, 1]$.
The numerator contribution $\sum_{p \le X} \log(1 - 2/p + p^{-2 + v/\ell})$ is $O_J(\log\log X)$ and contributes negligibly to $K_X, K_X', K_X''$.
The denominator sums evaluate via the Prime Number Theorem:
\[
 K_X(1 - v/\ell) = \frac{X}{\ell} [F(v) + o(1)], \qquad F(v) = -\log(1 - e^{-v}),
\]
\[
 K_X'(1 - v/\ell) = X [m(v) + o(1)], \qquad m(v) = (e^v - 1)^{-1},
\]
\[
 K_X''(1 - v/\ell) = X\ell [q(v) + o(1)], \qquad q(v) = \frac{e^v}{(e^v - 1)^2}.
\]
Because $\pi(X) \sim X/\ell$ and the prime measures concentrate near $z=1$ with $\pi(X^{1-\eta}) = o(\pi(X))$, the normalized sums converge uniformly on $J$ to the values at $z=1$.

### Step 3: Exact Exponential Tilt and Matching Bounds
1. **Upper Bound:** Choose tilt $v_\kappa = \log(1 + 1/\kappa)$, so $m(v_\kappa) = \kappa$. By the Chernoff bound:
   \[
    \log \mathcal{L}_X(\kappa X) \le -\kappa X + \frac{X}{\ell} [\kappa v_\kappa + F(v_\kappa)] + o(X/\ell).
   \]
2. **Lower Bound:** Let $w = X/\ell^2$ and choose the unique tilt $t_X \in (0, 1)$ such that $K_X'(t_X) = \kappa X + w$.
   Under the tilted measure $d\mathbb{P}_{t_X}/d\mathbb{P} = \exp(t_X W_X - K_X(t_X))$ (where $W_X = -S_X$), the mean is $\kappa X + w$ and variance is $O(X\ell)$.
   By Chebyshev's inequality, $W_X \in [\kappa X + w/2, \kappa X + 3w/2]$ with probability at least $1 - O(\ell^5/X)$.
   Evaluating the expectation under this event yields:
   \[
    \mathcal{L}_X(\kappa X) \ge \frac{w}{2} \exp[K_X(t_X) - t_X \kappa X - 3t_X w/2] [1 - O(\ell^5/X)].
   \]
   Since $\log w = O(\log X) = o(X/\ell)$, the lower bound matches the upper bound.
3. **Shannon Entropy Identification:**
   Direct algebraic evaluation gives:
   \[
    \kappa v_\kappa + F(v_\kappa) = \kappa \log(1 + 1/\kappa) - \log\left(1 - \frac{1}{1 + 1/\kappa}\right) = (\kappa+1)\log(\kappa+1) - \kappa\log\kappa.
   \]

---

## 3. Literature Comparison and Novelty

| Aspect | Prior Literature (Kac, Kubilius, Elliott, Tenenbaum) | Present Result |
|---|---|---|
| **Underlying Law** | Independent truncated prime valuations $\nu_p \sim \operatorname{Geom}(1/p)$ or Poisson | Complete Euler unitary square law with exact negative depth probabilities |
| **Domain** | Central limit theorem ($O(\sqrt{\log\log X})$ fluctuations) | Full large-deviation regime $\kappa X$ at linear scale |
| **Technique** | Limiting Dickman-de Bruijn functions or remote tail transfers | Exact exponential tilting directly on discrete prime laws |
| **Second Order** | Coarse error terms $O(X)$ or qualitative bounds | Exact Shannon entropy rate $\frac{X}{\log X} [(\kappa+1)\log(\kappa+1) - \kappa\log\kappa]$ |
