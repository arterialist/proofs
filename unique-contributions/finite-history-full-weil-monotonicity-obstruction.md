# Contribution 37: Arithmetic Counterexample to Universal Normalized Finite-History Monotonicity of the Weil Quadratic Form

## Executive Summary & Significance

In the spectral approach to the Riemann Hypothesis (originating in André Weil's explicit formula and developed by Connes, Burnol, Meyer, and Suzuki), proving that the infinite-dimensional Weil quadratic functional $Q(f)$ is positive-semidefinite on suitable test function spaces is equivalent to the Riemann Hypothesis. A central structural conjecture in operator-theoretic approaches is whether the Weil form satisfies a **normalized finite-history monotonicity**: namely, whether applying a single-prime operator $V_{p, 1} = (1 - 1/p)I - p^{-1/2}\tau_{\log p}$ (with quadratic normalization $\alpha = 1 - 1/p + 1/p^2$) always preserves or monotonically increases the quadratic form:
$$
Q(\alpha^{-1/2} V_{p, 1} f) \ge Q(f).
$$
Such a monotonicity property, if universal, would allow inductive control of spectral positivity across finite prime truncations.

This work rigorously refutes this universal comparison at the concrete prime $p = 10007$. It constructs a smooth plateau test packet $f_t$ of compact support and establishes via Kronecker–Weyl phase equidistribution that the asymptotic normalized difference satisfies:
$$
\lim_{t \to \infty} \left( Q(\alpha^{-1/2} V_{10007, 1} f_t) - Q(f_t) \right) < 0.
$$
Crucially, **both individual full forms $Q(\alpha^{-1/2} V_{10007, 1} f_t)$ and $Q(f_t)$ remain strictly positive** at high frequencies due to dominant Archimedean $\log t$ coefficients. Thus, this failure is NOT a counterexample to Weil positivity (and does not contradict RH), but definitively refutes universal norm-preserving finite-history monotonicity.

---

## Detailed Mathematical Exposition

### 1. The Smooth Plateau and Test Function Packets

Let $p = 10007$. Let $\eta \in C_c^\infty(\mathbb{R})$ be a smooth cutoff satisfying:
$$
0 \le \eta(v) \le 1, \qquad \eta(v) \equiv 1 \text{ for } |v| \le \frac{1}{16}, \qquad \operatorname{supp}(\eta) \subseteq \left[-\frac{1}{8}, \frac{1}{8}\right].
$$
Define the autocorrelation function:
$$
R(y) = \int_{\mathbb{R}} \eta(v+y)\eta(v) dv, \qquad N = \|\eta\|_{L^2}^2 = R(0) \le \frac{1}{4}.
$$
By overlapping plateau intervals of length at least $1/8 - |y|$:
$$
R(y) \ge \frac{1}{16} \quad \text{for all } |y| \le \frac{1}{16}.
$$
Consider the exactly pole-null derivative packet:
$$
f_t(v) = -t^{-2} \left(\partial_v^2 - \frac{1}{4}\right) (\eta(v) \cos(tv)).
$$
The single-prime dilation operator is $V_{p, 1} = (1 - 1/p)I - p^{-1/2}\tau_{\log p}$. Since $\operatorname{supp}(\eta) \subseteq [-1/8, 1/8]$ and $\log p = \log 10007 > 9.21 > 1/4$, the translated supports are disjoint, yielding the exact norm identity:
$$
\|V_{p, 1} f_t\|^2 = \left( \left(1 - \frac{1}{p}\right)^2 + \frac{1}{p} \right) \|f_t\|^2 = \left(1 - \frac{1}{p} + \frac{1}{p^2}\right) \|f_t\|^2 = \alpha \|f_t\|^2.
$$

### 2. Archimedean Cancellation and the Limiting Arithmetic Readout

By the classical digamma asymptotic ($\psi(s) = \log s + O(1/s)$ on the critical strip), the Archimedean Gamma contributions satisfy:
$$
A(g_t) = \log\left(\frac{t}{2\pi}\right) \|g_t\|^2 + o(1),
$$
so the normalized difference cancels the leading logarithmic term identically:
$$
A(V_{p, 1} f_t) - \alpha A(f_t) = o(1) \quad \text{as } t \to \infty.
$$
Furthermore, since $f_t$ has vanishing moments $M_{\pm 1/2}(f_t) = 0$, both pole terms vanish identically.

By Kronecker–Weyl equidistribution on the finite prime-logarithm torus $\mathbb{T}^K$, we choose an unbounded sequence of frequencies $t_m \to \infty$ satisfying:
$$
t_m \log p \equiv 0 \pmod{2\pi}, \qquad t_m \log q \equiv \pi \pmod{2\pi} \quad (\forall q \ne p \text{ observing base primes}).
$$
In this limit, the complete normalized difference evaluates to the finite arithmetic sum:
$$
F = \frac{1 - 1/p}{\sqrt{p}} \sum_{n \ge 2} \frac{\Lambda(n)}{\sqrt{n}} R(\log(n/p)) \sigma_p(n),
$$
where $\sigma_p(p) = 1$, and for prime powers $q^k$ ($q \ne p$):
$$
\sigma_p(q^k) = (-1)^k.
$$
Hence, every odd power (including all first primes $q \ne p$) contributes with a **negative sign**, while even powers $q^{2m}$ contribute positively.

### 3. Isolation of the 24 Observing Primes

There are exactly 24 prime numbers in $[9695, 10319]$ differing from $p = 10007$:
$$
\mathcal{P}_{24} = \{9697, 9719, 9721, 9733, 9739, 9743, 9749, 9767, 9769, 9781, 9787, 9791, 9803, 9811, 9817, 9829, 9833, 9839, 9851, 9857, 9859, 9871, 9883, 9887\}.
$$
For every $q \in \mathcal{P}_{24}$:
$$
|q - p| \le 312 < \frac{p}{32} \implies \left|\log\frac{q}{p}\right| \le \frac{1}{31} < \frac{1}{16}.
$$
Thus $R(\log(q/p)) \ge 1/16$. Moreover, $2^{13} < q < 102^2$, which implies:
$$
\frac{\log q}{\sqrt{q}} > \frac{13 \log 2}{102}.
$$
Therefore, the total negative contribution of these 24 primes to the sum is bounded below by:
$$
\sum_{q \in \mathcal{P}_{24}} \frac{\log q}{\sqrt{q}} R(\log(q/p)) > 24 \cdot \frac{1}{16} \cdot \frac{13 \log 2}{102} = \frac{24 \cdot 13}{1632} \log 2.
$$

### 4. Positive Contributions and Exhaustive Even-Power Classification

1. **The Prime $p$ Itself:**
   $$
   N \frac{\log p}{\sqrt{p}} < \frac{1}{4} \cdot \frac{14 \log 2}{100} = \frac{14}{400} \log 2.
   $$
2. **Even Prime Powers in the Support Window:**
   The support condition $R(y) = 0$ for $|y| > 1/4$ restricts observing integers to $p e^{-1/4} \le n \le p e^{1/4}$, which is contained in $[3p/4, 4p/3]$ since $\log(4/3) > 1/4$.
   
   **Theorem (Exhaustive Even-Power Classification):**
   For every prime $q$ and every even integer $k \ge 2$:
   $$
   3 \cdot 10007 \le 4 q^k \quad \text{and} \quad 3 q^k \le 4 \cdot 10007 \iff k = 2 \text{ and } q \in \{89, 97, 101, 103, 107, 109, 113\}.
   $$
   *Proof:* Lean 4 machine-checks the unconstrained classification:
   - For $k \ge 14$: $2^{14} = 16384 > \frac{4 \cdot 10007}{3} \approx 13342.67$, so no prime powers exist for $k \ge 14$.
   - For $q \ge 116$: $116^2 = 13456 > \frac{4 \cdot 10007}{3}$, so no prime powers exist for $q \ge 116$.
   - The remaining finite range $q < 116$, $k < 14$ is verified exhaustively by kernel `decide`.
   
   For each of these 7 squares $q^2$, $\frac{\log q}{q} < \frac{7 \log 2}{86}$, and $R \le 1/4$, giving a total positive contribution bounded by:
   $$
   7 \cdot \frac{1}{4} \cdot \frac{7 \log 2}{86} = \frac{49}{344} \log 2.
   $$

### 5. The Certified Positive Rational Margin

Combining the negative and positive contributions, the net multiplier in units of $\log 2$ is:
$$
\frac{24 \cdot 13}{1632} - \frac{14}{400} - \frac{49}{344} = \frac{251}{18275} > 0.
$$
Since $\frac{251}{18275} \approx 0.0137346 > 0$, the sum in $F$ is strictly negative:
$$
F \le -\frac{251}{18275} \frac{1 - 1/p}{\sqrt{p}} \log 2 < 0.
$$
This completes the unconditional arithmetic proof that:
$$
\lim_{t \to \infty} \left( Q(\alpha^{-1/2} V_{10007, 1} f_t) - Q(f_t) \right) < 0.
$$

---

## Machine Formalization Status

Formally machine-checked in Lean 4.24.0:
- [`formalization/BuildingBlocks/FiniteWeilPrimeCertificate.lean`](../../formalization/BuildingBlocks/FiniteWeilPrimeCertificate.lean):
  - `prime_10007`: Primality of $p = 10007$.
  - `selected_primes`: Primality of all 24 selected integers.
  - `selected_window`: Window inequalities $q < 10007$, $32(10007-q) < 10007$, $8192 < q < 102^2$.
  - `selected_distinct_count`: Length 24 and `Nodup`.
  - `positive_margin`: Exact rational arithmetic $\frac{24 \cdot 13}{1632} - \frac{14}{400} - \frac{49}{344} = \frac{251}{18275} > 0$.
- [`formalization/BuildingBlocks/FiniteWeilEvenPowerCertificate.lean`](../../formalization/BuildingBlocks/FiniteWeilEvenPowerCertificate.lean):
  - `bounded_certificate`: Exhaustive verification on $q < 116, k < 14$.
  - `all_even_prime_powers`: Global derivation of $k < 14$ and $q < 116$ without assumed cutoffs.
  - `square_bases_valid`: Validity of all 7 square bases.
  - `exact_classification`: The complete bidirectional classification theorem $(3 \cdot 10007 \le 4 q^k \wedge 3 q^k \le 4 \cdot 10007) \iff (k = 2 \wedge q \in \{89, 97, 101, 103, 107, 109, 113\})$.

All 9 theorems depend strictly on the standard axioms `[propext, Classical.choice, Quot.sound]`, with 0 custom axioms and 0 `sorry`.

---

## Publication Viability & Targets

- **Target Journals:** *Journal of Number Theory*, *Proceedings of the American Mathematical Society*, or *Experimental Mathematics*.
- **Impact:** Establishes a limitation on operator monotonicity for the arithmetic Weil quadratic form, showing that finite-history operator growth cannot be established universally without geometric support or carrier constraints.
