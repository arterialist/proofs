# Structural Boundary of the Critical Sign Criterion (Frontier 1)

This research note records audited limitations of Frontier 1 (the Critical Sign Criterion). It separates the machine-checked forward reduction to the Riemann Hypothesis from the heuristic and model-dependent obstructions considered by the Root Gate Review Level 02 (`gate_verdict.json`).

---

## 1. Status, Claims, Assumptions, and Parameter Ranges

- **Core Mathematical Claim**:
  Let $W(x) = \sum_{d \le x}\sqrt{d} V(x/d)$ be the square-root harmonic aggregate of the reduced distinct-prime potential $V(x)$. The forward implication
  $$
  (\exists A \ge 1, \; \forall x > A, \; W(x) \le 0) \implies \text{RiemannHypothesis}
  $$
  is proved and machine-checked in Lean 4 without custom axioms. Conversely, under the Riemann Hypothesis, $W(x) = -\frac{1}{6}x^{3/2}\log^2 x + O(x^{3/2}\log x)$, establishing an exact bidirectional spectral characterization:
  $$
  \text{RiemannHypothesis} \iff \exists A \ge 1, \; \forall x > A, \; W(x) \le 0.
  $$
- **Assumptions**:
  The forward reduction is conditional on the single arithmetic hypothesis of eventual nonpositivity:
  $$
  \mathtt{hsign} : \forall^\mathtt{f} x : \mathbb{R} \text{ in } \mathtt{atTop}, \; \operatorname{Re}(W(x)) \le 0.
  $$
  The converse asymptotic is conditional on the Riemann Hypothesis.
- **Parameter Ranges**:
  - $x \in \mathbb{R}$, $x > 1$.
  - Transform complex variable $s \in \mathbb{C}$ with $\operatorname{Re}(s) > 1$ for absolute convergence, analytically continuing to $\operatorname{Re}(s) > 1/2$.
  - Hypothetical off-critical zeros $\rho = \beta + i\gamma$ have $\beta \in (1/2, 1)$ and $|\gamma| > 3 \times 10^{12}$ (Platt & Trudgian, 2021).
- **Lean 4 Proof Status**:
  - Machine-checked in [`formalization/BuildingBlocks/ActualCriticalSignCriterion.lean`](../../formalization/BuildingBlocks/ActualCriticalSignCriterion.lean).
  - Standalone automated axiom audit in [`formalization/verification/ActualCriticalSignCriterionAudit.lean`](../../formalization/verification/ActualCriticalSignCriterionAudit.lean) verifies that the transitive axiom dependency union contains strictly the standard foundational axioms:
    $$
    [\mathtt{propext}, \mathtt{Classical.choice}, \mathtt{Quot.sound}]
    $$
    with **zero custom axioms** and **zero `sorry`**.
- **Consensus Gate Verdict**:
  - Root Gate Review Level 02 (`teamwork_preview_gate_merger_gate_L02_N00/gate_verdict.json`): `should_decompose: false`, `recommended_action: "restart_exploration"`, `fatal_flaw: true`.
  - Frontier 1 is cataloged as a bidirectional characterization boundary. Lean verifies only the forward implication from eventual nonpositivity to RH. The reverse implication from RH to the eventual-sign asymptotic is a written analytic argument, audited in [`research-local/agent-results/critical-sign-rh-converse-audit-20260924.md`](../../research-local/agent-results/critical-sign-rh-converse-audit-20260924.md), and is not machine-checked.

---

## 2. Mathematical Definition of the Observable

For positive integers $n$, define the distinct-prime convolution:
$$
c(n) = \sum_{ab=n}\Lambda(a)\Lambda(b) - \Lambda(n)\bigl(\log n - \Lambda(n)\bigr),
$$
which vanishes on prime powers and on integers with $\omega(n) \ge 3$, and is strictly positive if and only if $\omega(n) = 2$ (semiprimes of two distinct primes).

For real $x > 1$, the reduced potential $V(x)$ is defined by:
$$
V(x) = \sum_{n \le x}\left[(x-n)c(n) - \Lambda(n)\frac{x^2-n^2}{n}\right] + \frac{x^2}{2}\log x + \frac{x^2}{4} - \frac{1}{4},
$$
with $V(y) = 0$ for $y \le 1$. The critical observable is the square-root harmonic aggregate:
$$
W(x) = \sum_{d \le x}\sqrt{d}\,V(x/d).
$$

For $\operatorname{Re}(s) > 1$, the Mellin transform of $W(x)$ is identically:
$$
\mathcal{M}_W(s) = \int_1^\infty W(x)x^{-s-2}\,dx = \frac{\zeta(s+1/2)}{s(s+1)}\bigl(G(s)^2 - H(s)\bigr),
$$
where $G(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s-1}$ and $H(s) = \sum_{n \ge 1}\frac{\Lambda(n)(\log n - \Lambda(n))}{n^s}$.

---

## 3. The Four Fundamental Structural Barriers

### Barrier 1: The Eventual-Sign Premise Is at Least as Strong as RH
The proved implication from $\exists A \ge 1, \forall x > A, W(x) \le 0$ to RH makes the premise at least as strong as the Riemann Hypothesis.

At the boundary point $s = 1/2$, the singular interaction between $\zeta(s+1/2)$ (simple pole with residue $1$) and $H(s)$ (double pole with leading coefficient $1/4$) generates the local Laurent term $-\frac{1}{3(s-1/2)^3}$. This identifies the coefficient of the expected leading term
$$
W_{\text{drift}}(x) = -\frac{1}{6}x^{3/2}\log^2 x + A_2 x^{3/2}\log x + O(x^{3/2}),
$$
where $A_2 = -\frac{1}{3}\gamma_0 + \frac{8}{9} \approx +0.696484$, but the local pole alone does not control the inverse-Mellin remainder.

The conditional reverse implication uses global estimates. With the exact split $W=N_*-T_*$, RH gives, uniformly for $0<\varepsilon\le1/4$,
$$
\int_{\mathbb R}
\frac{|\zeta(1+\varepsilon+it)|\,|G(1/2+\varepsilon+it)|^2}
{|(1/2+\varepsilon+it)(3/2+\varepsilon+it)|}\,dt
\ll \varepsilon^{-1}.
$$
This boundary-line $L^1$ estimate justifies shifting the contour for $N_*$ and yields
$$
|N_*(x)|\ll x^{3/2+\varepsilon}\varepsilon^{-1}
=O(x^{3/2}\log x)
$$
after taking $\varepsilon=1/\log x$. Separately, PNT partial summation, retaining every prime power, gives
$$
T(u)=\frac13u^{3/2}\log u+O(u^{3/2}),
\qquad
T_*(x)=\frac16x^{3/2}\log^2x+O(x^{3/2}\log x).
$$
Therefore RH implies
$$
W(x)=-\frac16x^{3/2}\log^2x+O(x^{3/2}\log x),
$$
and hence eventual strict negativity. This is a conditional analytic result, not an unconditional RH argument.

If the Riemann Hypothesis fails, there exists an off-critical zero $\rho = \beta + i\gamma$ with $\beta > 1/2$. Because $\operatorname{Re}(\rho + 1/2) = \beta + 1/2 > 1$, the shifted multiplier $\zeta(\rho + 1/2) \ne 0$ is analytic and non-vanishing by Euler product convergence. If the zero has multiplicity $m_\rho$, then $G(s)^2$ introduces a double pole at $s = \rho$ with leading coefficient
$$
C_{m_\rho}(\rho) = \frac{m_\rho^2\zeta(\rho+1/2)}{\rho(\rho+1)} \ne 0.
$$
The local Laurent expansion alone does not imply
$W(x)=\Omega_\pm(x^{\beta+1}\log x)$ for an arbitrary such zero, nor does it justify an asymptotic excursion-to-drift ratio. Isolating the formal conjugate-pair contribution
$$
2\operatorname{Re}\!\left(C_{m_\rho}(\rho)x^{\rho+1}\log x\right)
$$
as a leading pointwise term would require a justified inverse-Mellin contour shift and control of the other singularities and the remaining contour. For example, an isolated rightmost conjugate pair together with a smaller remainder could supply such a dominance statement; those hypotheses are not established here.

The required sign consequence is nevertheless rigorous and does not need a quantitative oscillation theorem. The machine-checked implication
$$
\text{eventual nonpositivity of }\operatorname{Re}W(x)\;\Longrightarrow\;\mathrm{RH}
$$
gives, by contraposition, that if RH is false then for every cutoff $A$ there is some $x>A$ with $\operatorname{Re}W(x)>0$. It supplies neither a two-sided $\Omega$ estimate nor the size of those positive excursions.

A separate Landau comparison gives a weaker quantitative conclusion. If $\rho=\beta+i\gamma$ is off the critical line, then for every $0<\eta<\beta-1/2$ one can apply the positive-transform theorem to $Cx^{3/2+\eta}\mp W(x)$ to obtain
$$
\limsup_{x\to\infty}\frac{W(x)}{x^{3/2+\eta}}=+\infty,
\qquad
\liminf_{x\to\infty}\frac{W(x)}{x^{3/2+\eta}}=-\infty.
$$
The complete convergence-abscissa and real-axis analyticity argument is given in [`bidirectional-critical-sign-equivalence-and-drift-origin.md`](bidirectional-critical-sign-equivalence-and-drift-origin.md). This weaker statement does not establish the exact scale $x^{\beta+1}\log x$ or the displayed asymptotic excursion-to-drift ratio removed above.

---

### Barrier 2: Sieve Scale Gap and a Modelled Wrong-Sided Quadratic Defect
Decomposing $W(x) = N_*(x) - T_*(x)$ splits the observable into the distinct-prime convolution $N_*(x)$ and the deterministic same-prime extraction $T_*(x) = \frac{1}{6}x^{3/2}\log^2 x + O(x^{3/2}\log x)$. To prove $W(x) \le 0$ from arithmetic first principles, one would require:
$$
N_*(x) \le \frac{1}{6}x^{3/2}\log^2 x + O(x^{3/2}\log x).
$$
The gate review considered classical Vaughan, Heath-Brown, and Selberg-style estimates whose available error scale in this route is too large to establish the displayed bound. It also tested the following simplified multiplicative-loss model.

The model assumes, rather than derives from a defined class of majorants, a positive defect
$$
\Delta_{\mathrm{model}}(x) = \zeta(3/2)\varepsilon x^2 \approx 2.612\varepsilon x^2.
$$
For this model the defect falls on the wrong side of the target inequality $W(x) \le 0$. Its ratio to the leading drift is
$$
\mathcal{R}_{\mathrm{model}}(x) = \frac{6\zeta(3/2)\varepsilon\sqrt{x}}{\log^2 x} \approx \frac{15.674\varepsilon\sqrt{x}}{\log^2 x}
$$
grows as $\sqrt{x}/\log^2 x \to \infty$. Quantitatively:
- At $x = 10^4$ with $\varepsilon = 10^{-4}$: ratio is $0.002$.
- At $x = 10^{10}$ with $\varepsilon = 10^{-4}$: ratio is $0.296$.
- At $x = 10^{14}$ with $\varepsilon = 10^{-4}$: ratio reaches **$15.083$**, yielding a net model value $+2.4392 \times 10^{24} > 0$ after subtracting the leading drift.
- For $\varepsilon = 10^{-2}$ at $x = 10^{14}$: ratio reaches **$1508.34$**.

Thus a loss of the modelled form cannot be absorbed by the negative drift for all large $x$. The calculation does not prove that every multiplicative sieve majorant has this normalization or defect, and it does not rule out every possible combinatorial-sieve argument.

---

### Barrier 3: Finite Numerical Windows Do Not Settle Eventual Sign
Finite numerical evaluations suggest that $W(x)$ is negative at sampled points in $[185, 20000]$ (e.g., $W(185) \approx -22.58$, $W(2500) \approx -7.394 \times 10^5$). These samples do not rule out off-critical zeros.

By Platt & Trudgian (2021), all non-trivial zeros of $\zeta(s)$ up to height $T_0 = 3 \times 10^{12}$ lie on the critical line $\operatorname{Re}(s) = 1/2$. Hence any off-critical zero $\rho = \beta + i\gamma$ must satisfy $|\gamma| > 3 \times 10^{12}$. Its double-pole coefficient would be
$$
|C(\rho)|=\frac{|\zeta(\beta+1/2+i\gamma)|}{|\rho(\rho+1)|}.
$$
The height bound alone does not give a uniform numerical upper bound for this coefficient. Writing $\beta=1/2+\delta$ only yields the elementary estimate $|\zeta(1+\delta+i\gamma)|\le \zeta(1+\delta)$, which is unbounded as $\delta\downarrow0$. The calculations in [`certificates/haselgrove_crossover_scale_certificate.py`](../../certificates/haselgrove_crossover_scale_certificate.py) evaluate selected hypothetical parameter pairs; they do not certify a universal excursion-to-drift ratio or crossover scale. Thus finite testing on $[185,20000]$ cannot establish eventual nonpositivity, but the stated premises do not quantify how far away a hypothetical sign reversal must occur.

---

### Barrier 4: Invariance Under Mollification and Discrete Termwise Indefiniteness
1. **Mollification Invariance**:
   Applying Riesz smoothing $\int_1^x (\log(x/y))^k W(y) y^{-3} dy$ or positive-kernel mollification $\mathcal{L}_K(s)\mathcal{M}_W(s)$ multiplies the Mellin transform by a rational factor $s^{-(k+1)}$ or holomorphic factor $\mathcal{L}_K(s)$. Because $\mathcal{L}_K(\rho) \ne 0$ for generic non-negative kernels, the off-critical double pole persists. Eliminating the double pole would require constructing a kernel vanishing exactly at unknown off-critical zeros, which is circular.
2. **Termwise Arithmetic Indefiniteness**:
   In the algebraic decomposition:
   $$
   W(x) = B_*(x) + \sum_{n \le x}\frac{x-n}{\sqrt{n}}\left[L(n)^2 - Q(n) - \left(1 + \frac{x}{n}\right)L(n)\right],
   $$
   the summand bracket is strictly positive at composite integers. At $n=36, x=72$, the bracket evaluates to $+1.9102 > 0$. On the window $x \le 200$, 88 of 199 integers (44.2%) have positive brackets, disproving any cone-invariance or termwise positivity argument.

---

## 4. Machine-Checked Formalization and Axiom Verification

The forward reduction is fully mechanized in the Lean 4 proof assistant:
```lean
namespace BuildingBlocks.ActualCriticalSignCriterion

theorem RiemannHypothesis_of_nonpos_after {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) :
    RiemannHypothesis

theorem RiemannHypothesis_of_eventually_nonpos
    (hsign : ∀ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re ≤ 0) :
    RiemannHypothesis
```

### Verification Command and Output
Execution of [`formalization/verification/ActualCriticalSignCriterionAudit.lean`](../../formalization/verification/ActualCriticalSignCriterionAudit.lean) via:
```bash
lake env lean formalization/verification/ActualCriticalSignCriterionAudit.lean
```
produces:
```
BuildingBlocks.ActualCriticalSignCriterion.RiemannHypothesis_of_nonpos_after {A : ℝ} (hA : 1 ≤ A)
  (hsign : ∀ (x : ℝ), A < x → (BuildingBlocks.ActualCriticalMellin.W x).re ≤ 0) : RiemannHypothesis
'BuildingBlocks.ActualCriticalSignCriterion.RiemannHypothesis_of_nonpos_after' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
BuildingBlocks.ActualCriticalSignCriterion.RiemannHypothesis_of_eventually_nonpos
  (hsign : ∀ᶠ (x : ℝ) in Filter.atTop, (BuildingBlocks.ActualCriticalMellin.W x).re ≤ 0) : RiemannHypothesis
'BuildingBlocks.ActualCriticalSignCriterion.RiemannHypothesis_of_eventually_nonpos' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
ACTUAL CRITICAL SIGN CRITERION DECLARATION COUNT 2
ACTUAL CRITICAL SIGN CRITERION TRANSITIVE AXIOMS [propext, Classical.choice, Quot.sound]
AUDITED BuildingBlocks.ActualCriticalSignCriterion.RiemannHypothesis_of_eventually_nonpos
AUDITED BuildingBlocks.ActualCriticalSignCriterion.RiemannHypothesis_of_nonpos_after
ACTUAL CRITICAL SIGN CRITERION AXIOM AUDIT PASSED: standard foundational axioms only [propext, Classical.choice, Quot.sound], zero custom axioms, zero sorry
```

---

## 5. Definitive Boundary Assessment

Frontier 1 proposes a bidirectional spectral characterization of the Riemann Hypothesis. Lean verifies the forward implication from eventual nonpositivity to RH. The analytic reverse implication, which derives eventual nonpositivity from RH, is not formalized in Lean. The forward implication alone shows that an unconditional proof of the sign condition would prove RH. The audited sieve, mollification, termwise, and finite numerical arguments do not establish that condition.

This analysis shows why the audited multiplicative-loss model, mollifications, termwise sign arguments, and finite numerical checks do not prove the eventual-sign premise. It does not rule out other sieve constructions or arithmetic methods, or establish what form a viable RH proof must take.
