# Finite arithmetic Weil prime margin and even-power classification

## Summary and verification status

**Classification:** finite formalization record. These certificates check explicit arithmetic cases. They do not formalize the Weil criterion or establish a first formalization of its analytic argument.

This is a formalization record for the finite arithmetic certificates used by
the written norm-preserving comparison argument. Lean checks the selected
prime window, the rational margin, and the exhaustive even-power
classification. It does not formalize the smooth packets, Kronecker--Weyl
phase selection, gamma asymptotics, or the full Weil-form comparison, so this
page alone does not prove the analytic counterexample.

- **Lean Modules:**
  - [`FiniteWeilPrimeCertificate.lean`](../BuildingBlocks/FiniteWeilPrimeCertificate.lean)
  - [`FiniteWeilEvenPowerCertificate.lean`](../BuildingBlocks/FiniteWeilEvenPowerCertificate.lean)
- **Primary Verified Theorems:**
  - `BuildingBlocks.FiniteWeilPrimeCertificate.prime_10007`: $\operatorname{Nat.Prime}(10007)$
  - `BuildingBlocks.FiniteWeilPrimeCertificate.selected_primes`: Primality of all 24 selected integers in $[9695, 10319]$
  - `BuildingBlocks.FiniteWeilPrimeCertificate.selected_window`: Window bounds $q < 10007$, $32(10007-q) < 10007$, $8192 < q < 102^2$
  - `BuildingBlocks.FiniteWeilPrimeCertificate.selected_distinct_count`: `selected.Nodup ∧ selected.length = 24`
  - `BuildingBlocks.FiniteWeilPrimeCertificate.positive_margin`: $\frac{24 \cdot 13}{1632} - \frac{14}{400} - \frac{49}{344} = \frac{251}{18275} \wedge 0 < \frac{251}{18275}$
  - `BuildingBlocks.FiniteWeilEvenPowerCertificate.bounded_certificate`: Finite kernel decision over $q < 116, k < 14$
  - `BuildingBlocks.FiniteWeilEvenPowerCertificate.all_even_prime_powers`: Exhaustive classification for arbitrary prime bases $q$ and even exponents $k \ge 2$ with globally proved cutoffs $k < 14$ and $q < 116$
  - `BuildingBlocks.FiniteWeilEvenPowerCertificate.square_bases_valid`: Validity of bases $\{89, 97, 101, 103, 107, 109, 113\}$
  - `BuildingBlocks.FiniteWeilEvenPowerCertificate.exact_classification`: The complete bidirectional classification:
    $$
    \forall q, k \in \mathbb{N}, \operatorname{Nat.Prime}(q) \wedge 2 \le k \wedge k \equiv 0 \pmod 2 \implies \\
    \left( 3 \cdot 10007 \le 4 q^k \wedge 3 q^k \le 4 \cdot 10007 \right) \iff \left( k = 2 \wedge q \in \{89, 97, 101, 103, 107, 109, 113\} \right)
    $$
- **Compilation Status:** Verified under Lean 4.24.0. Depends strictly on foundational axioms `[propext, Classical.choice, Quot.sound]`, with 0 custom axioms and 0 `sorry`.

---

## Key Proof Architecture

1. **Window Boundaries & Global Exponent Bounds:**
   The interval $[3p/4, 4p/3]$ for $p = 10007$ evaluates to $\approx [7505.25, 13342.67]$.
   - For an even exponent $k \ge 14$, the smallest possible prime base $q = 2$ gives $2^{14} = 16384 > 13342.67$. Lean proves $k < 14$ by contradiction using `pow_le_pow_right'` and `pow_le_pow_left'`.
   - For a square base $q \ge 116$, $116^2 = 13456 > 13342.67$. Lean proves $q < 116$ by contradiction using `pow_le_pow_left'`.
2. **Exhaustive Kernel Decision:**
   With $q < 116$ and $k < 14$ established as rigorous global theorems rather than assumed cutoffs, the remaining finite domain is certified by Lean's kernel via `decide`.
3. **Rational Margin Arithmetic:**
   The positive margin $\frac{24 \cdot 13}{1632} - \frac{14}{400} - \frac{49}{344} = \frac{251}{18275} > 0$ is proved via `norm_num` on $\mathbb{R}$.

---

## Search scope and attribution

The finite arithmetic statements are elementary consequences of primality, integer inequalities, and rational arithmetic. The audit classified them as checked certificates supporting a written argument, not as a first formalization of the Weil criterion or a mathematical contribution by themselves.
