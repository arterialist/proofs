# Incomplete-box arithmetic carry covariance and exact discrete Fourier reduction

**Authors:** Arterialist RH Research Team (September 2026)  
**Primary References:** `building-blocks/successor-and-division/incomplete-carry-covariance.md`  
**Classification:** Analytic Number Theory / Discrete Fourier Analysis / Probability on Groups / Combinatorics  

---

## 1. Executive Summary and Statement of Result

For any modulus $d \ge 2$ and integers $a, b \in \mathbb{Z}$, the arithmetic carry is defined by:
$$
 \kappa_d(a, b) := \left\lfloor \frac{a+b}{d} \right\rfloor - \left\lfloor \frac{a}{d} \right\rfloor - \left\lfloor \frac{b}{d} \right\rfloor \in \{0, 1\}.
$$
In many analytic and combinatorial applications (including Kummer's theorem on $p$-adic valuations of binomial coefficients $\nu_p\binom{A+B}{A} = \sum_{j \ge 1} \kappa_{p^j}(A, B)$), one needs to compute the covariance of carries across different moduli $d, e$ when $A, B$ are sampled uniformly from an incomplete integer box $\{1, \ldots, H\}$, where $H$ is not necessarily a multiple of $\operatorname{lcm}(d, e)$.

**Theorem (Exact Discrete Fourier Carry Identity).**
For any modulus $d \ge 2$ and all $a, b \in \mathbb{Z}$:
$$
 \boxed{\quad \kappa_d(a, b) = \sum_{j=1}^{d-1} \frac{(1 - e^{2\pi i j a / d})(1 - e^{2\pi i j b / d})}{d(1 - e^{-2\pi i j / d})}. \quad}
$$
The sum is real, non-negative, and strictly evaluates to 0 or 1 for all integer pairs $(a, b)$, including boundary residue zeros.

**Theorem (Incomplete-Box Carry Covariance Reduction).**
Let $A, B$ be independent uniform random variables on $\{1, \ldots, H\}$.
Let $f_d(x) := \{x/d\} - \frac{d-1}{2d}$, $S = A + B$, and define the flat and triangular sawtooth covariances:
$$
 C^{\mathrm{flat}}_{d, e} := \operatorname{Cov}(f_d(A), f_e(A)), \qquad C^{\mathrm{tri}}_{d, e} := \operatorname{Cov}(f_d(S), f_e(S)).
$$
Then the joint covariance satisfies the exact reduction:
$$
 \operatorname{Cov}(\kappa_d, \kappa_e) = 2 C^{\mathrm{flat}}_{d, e} + C^{\mathrm{tri}}_{d, e} - 2 M_{d, e} - 2 M_{e, d},
$$
where $M_{d, e} = \operatorname{Cov}_A(f_d(A), \mathbb{E}_B f_e(A+B))$ is an explicit one-dimensional endpoint covariance.
Furthermore, unconditionally for any $H \ge 1$ and any moduli $d, e \ge 2$:
$$
 \boxed{\quad \left| \operatorname{Cov}(\kappa_d, \kappa_e) - 2 C^{\mathrm{flat}}_{d, e} - C^{\mathrm{tri}}_{d, e} \right| \le \frac{d + e}{8H}. \quad}
$$

---

## 2. Mathematical Proof

### Step 1: Dedekind Sawtooth and Bernoulli-2 Discrete Primitive
Define $c_d = \frac{d-1}{2d}$ and $f_d(x) = \{x/d\} - c_d$. Then:
$$
 \kappa_d(a, b) = c_d + f_d(a) + f_d(b) - f_d(a+b).
$$
Let $r_d(x) \in \{0, \ldots, d-1\}$ be the residue of $x \pmod d$. Define the exact discrete primitive:
$$
 P_d(x) := \frac{r_d(x)(r_d(x)-d)}{2d} = \frac{d}{2}\left(B_2(\{x/d\}) - \frac{1}{6}\right), \qquad -\frac{d}{8} \le P_d(x) \le 0.
$$
Direct inspection verifies that $P_d(x+1) - P_d(x) = f_d(x)$ for all $x \in \mathbb{Z}$ (the jump at residue $d-1 \to 0$ cancels identically).
Hence the conditional expectation over $B \in \{1, \ldots, H\}$ telescopes:
$$
 s_d(a) := \mathbb{E}_B f_d(a+B) = \frac{1}{H}\sum_{b=1}^H f_d(a+b) = \frac{P_d(a+H+1) - P_d(a+1)}{H},
$$
giving the uniform non-asymptotic bound:
$$
 |s_d(a)| \le \frac{d}{8H} \quad \text{for all } a \in \mathbb{Z}.
$$

### Step 2: Covariance Expansion and Cauchy–Schwarz Bound
Expanding the covariance of $\kappa_d = c_d + f_d(A) + f_d(B) - f_d(S)$ using independence and symmetry between $A$ and $B$:
$$
 \operatorname{Cov}(\kappa_d, \kappa_e) = 2\operatorname{Cov}(f_d(A), f_e(A)) + \operatorname{Cov}(f_d(S), f_e(S)) - 2\operatorname{Cov}(f_d(A), f_e(S)) - 2\operatorname{Cov}(f_e(A), f_d(S)).
$$
Conditioning on $A$ in the mixed term gives $\mathbb{E}[f_d(A)f_e(S)] = \mathbb{E}_A[f_d(A) s_e(A)]$, so $\operatorname{Cov}(f_d(A), f_e(S)) = M_{d, e}$.
Because $f_d$ ranges in an interval of length $(d-1)/d < 1$, its variance is $\le 1/4$.
Because $s_e$ ranges in an interval of length at most $e/(4H)$, its variance is $\le (e/(8H))^2$.
By Cauchy–Schwarz:
$$
 |M_{d, e}| \le \sqrt{\operatorname{Var}(f_d(A))\operatorname{Var}(s_e(A))} \le \frac{1}{2} \cdot \frac{e}{8H} = \frac{e}{16H}.
$$
Summing $2|M_{d, e}| + 2|M_{e, d}| \le 2(e/16H) + 2(d/16H) = \frac{d+e}{8H}$, completing the proof of the reduction.

### Step 3: Discrete Fourier Transform of the Carry
The unnormalized DFT of the periodic function $f_d(x)$ on $\mathbb{Z}/d\mathbb{Z}$ is computed by summing roots of unity:
$$
 \widehat{f}_d(j) = \frac{1}{d}\sum_{x=0}^{d-1} f_d(x) e^{-2\pi i j x/d} = -\frac{1}{d(1 - e^{-2\pi i j/d})} \quad (1 \le j < d), \qquad \widehat{f}_d(0) = 0.
$$
Fourier inversion gives:
$$
 f_d(x) = \sum_{j=1}^{d-1} \widehat{f}_d(j) e^{2\pi i j x/d} = -\sum_{j=1}^{d-1} \beta_d(j) e^{2\pi i j x/d}, \qquad \beta_d(j) := \frac{1}{d(1 - e^{-2\pi i j/d})}.
$$
Noting that $c_d = -f_d(0) = \sum_{j=1}^{d-1} \beta_d(j)$, substitution into $\kappa_d(a, b) = c_d + f_d(a) + f_d(b) - f_d(a+b)$ gives:
$$
 \kappa_d(a, b) = \sum_{j=1}^{d-1} \beta_d(j) \left[ 1 - e(ja/d) - e(jb/d) + e(j(a+b)/d) \right] = \sum_{j=1}^{d-1} \beta_d(j) (1 - e(ja/d))(1 - e(jb/d)).
$$

---

## 3. Literature context and priority status

| Aspect | Prior Literature (Diaconis–Fulman, Holte, Rassias–Tóth) | Present Result |
|---|---|---|
| **Carry Representation** | Markov transition matrices on digits or digits sum $a+b = \kappa b + r$ | Exact finite DFT product formula $(1 - \mathrm{e}(ja/d))(1 - \mathrm{e}(jb/d)) / (d(1-\mathrm{e}(-j/d)))$ |
| **Domain** | Full periodic torus $\mathbb{Z}/b^k\mathbb{Z}$ or asymptotic limit $H \to \infty$ | Exact incomplete box $\{1, \ldots, H\}$ with arbitrary non-periodic $H$ |
| **Mixed Terms** | Ignored or assumed zero by periodicity | Fully bounded by explicit non-asymptotic $(d+e)/(8H)$ |
| **Application** | Card shuffling and base-$b$ Markov chains | Exact valuation variance $\operatorname{Var}(\log\binom{A+B}{A})$ in analytic number theory |
