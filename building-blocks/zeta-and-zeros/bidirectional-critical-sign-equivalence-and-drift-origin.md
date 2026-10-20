# Bidirectional critical-sign equivalence and the triple-pole drift origin

### Status, Claims, Assumptions, and Proof Status
- **Claim**: Bidirectional spectral equivalence $\text{RH} \iff \exists A \ge 1, \forall x > A, W(x) \le 0$ for the square-root harmonic observable $W(x) = \sum_{d \le x}\sqrt{d} V(x/d)$. Under RH, $W(x) = -\frac{1}{6}x^{3/2}\log^2 x + O(x^{3/2}\log x)$.
- **Assumptions**: The forward reduction assumes the arithmetic sign hypothesis `hsign : ∀ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re ≤ 0`. The converse assumes RH.
- **Parameter ranges**: $x > 1$; transform parameter $\operatorname{Re}(s) > 1$ continuing to $\operatorname{Re}(s) > 1/2$; hypothetical off-critical zeros $\rho = \beta + i\gamma$ have $\beta \in (1/2, 1)$ and $|\gamma| > 3 \times 10^{12}$ (Platt & Trudgian 2021).
- **Proof status**: The forward reduction $W(x) \le 0 \implies \text{RH}$ is completely proved and machine-checked in Lean 4 ([`formalization/BuildingBlocks/ActualCriticalSignCriterion.lean`](../../formalization/BuildingBlocks/ActualCriticalSignCriterion.lean)), with standard foundational axioms `[propext, Classical.choice, Quot.sound]` verified via automated audit ([`formalization/verification/ActualCriticalSignCriterionAudit.lean`](../../formalization/verification/ActualCriticalSignCriterionAudit.lean)), zero custom axioms, zero `sorry`. The RH-conditional reverse asymptotic has a written analytic proof based on a global boundary-line estimate and PNT partial summation ([`research-local/agent-results/critical-sign-rh-converse-audit-20260924.md`](../../research-local/agent-results/critical-sign-rh-converse-audit-20260924.md)); it is not formalized in Lean. The unconditional sign premise remains unproved.
- **Structural Boundary**: Sieve methods hit Selberg's parity barrier floor $O(x^2/\log^A x)$ with fatal wrong-sided quadratic defects $+2.612\varepsilon x^2$ exceeding drift by 15.08x at $x=10^{14}$ ($\varepsilon=10^{-4}$); the machine-checked forward implication shows by contraposition that failure of RH rules out eventual nonpositivity, without providing a quantitative excursion rate; finite testing on $[185, 20000]$ cannot establish eventual nonpositivity. See the full structural boundary report in [`critical-sign-criterion-structural-boundary.md`](critical-sign-criterion-structural-boundary.md).


## 1. Executive summary and exact equivalence statement

Let $\Lambda$ be the von Mangoldt function, and define the distinct-prime convolution and reduced potential for real $x > 1$:

$$
c(n) = \sum_{ab=n}\Lambda(a)\Lambda(b) - \Lambda(n)\bigl(\log n - \Lambda(n)\bigr),
$$

$$
V(x) = \sum_{n \le x}\left[(x-n)c(n) - \Lambda(n)\frac{x^2-n^2}{n}\right] + \frac{x^2}{2}\log x + \frac{x^2}{4} - \frac{1}{4},
$$

with $V(x) = 0$ for $x \le 1$, and let $W(x)$ denote the square-root harmonic aggregate:

$$
W(x) = \sum_{d \le x}\sqrt{d}\,V(x/d).
$$

### Bidirectional equivalence (reverse direction analytic, not machine-checked)
The following assertions are logically equivalent:
1. The Riemann Hypothesis holds: every non-trivial zero of $\zeta(s)$ satisfies $\operatorname{Re}(s) = 1/2$.
2. Eventual nonpositivity of $W(x)$: there exists a real threshold $A \ge 1$ such that
   $$
   \forall x > A, \quad W(x) \le 0.
   $$
3. Eventual strict negativity of $W(x)$: there exists a real threshold $A \ge 1$ such that
   $$
   \forall x > A, \quad W(x) < 0.
   $$

Furthermore, under the Riemann Hypothesis, $W(x)$ satisfies the asymptotic law:

$$
\boxed{
W(x) = -\frac{1}{6} x^{3/2} \log^2 x + O(x^{3/2} \log x).
}
\tag{1}
$$

Conversely, suppose RH fails and $\rho_0=\beta_0+i\gamma_0$ is an off-critical zero with $\beta_0>1/2$. The Landau comparison argument in Section 3 proves that, for every $0<\eta<\beta_0-1/2$,

$$
\boxed{
\limsup_{x\to\infty}\frac{W(x)}{x^{3/2+\eta}}=+\infty,
\qquad
\liminf_{x\to\infty}\frac{W(x)}{x^{3/2+\eta}}=-\infty.
}
\tag{2}
$$

This is weaker than $W(x)=\Omega_\pm(x^{\beta_0+1}\log x)$: the exponent in (2) is strictly below $\beta_0+1$, and (2) supplies neither an exact excursion scale nor an asymptotic excursion-to-drift ratio. The machine-checked forward implication also gives the qualitative contrapositive $\forall A\ge1,\exists x>A,\operatorname{Re}W(x)>0$.

---

## 2. Analytic origin of the leading negative drift

For $\operatorname{Re}(s) > 1$, absolute convergence yields the exact Mellin representation:

$$
\mathcal{M}_W(s) = \int_1^\infty W(x) x^{-s-2}\,dx = \frac{\zeta(s+1/2)}{s(s+1)}\bigl(G(s)^2 - H(s)\bigr),
\tag{3}
$$

where $G(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s-1}$ and $H(s) = \sum_{p, k \ge 2}(k-1)(\log p)^2 p^{-ks}$ is the prime-square Dirichlet series.

At the critical boundary point $s = 1/2$:
1. **Double pole of $H(s)$**: By Mertens' second theorem, $\sum_{p \le X} \frac{\log^2 p}{p} = \frac{1}{2}\log^2 X + O(\log X)$. Mellin integration converts this logarithmic squared growth into a second-order pole:
   $$
   H(s) = \frac{1}{4(s-1/2)^2} + O\left(\frac{1}{s-1/2}\right).
   $$
   (Note: Numerical conjectures asserting that $H(1/2)$ converges to a finite constant $\approx 76.4$ were refuted; $H(s)$ strictly diverges as $s \downarrow 1/2$).
2. **Simple pole of $\zeta(s+1/2)$**: The Riemann zeta function has residue $1$ at its pole, so:
   $$
   \zeta(s+1/2) = \frac{1}{s-1/2} + \gamma_E + O(s-1/2).
   $$
3. **Geometric evaluation**: The rational factor evaluates at $s=1/2$ to $-\frac{1}{s(s+1)}\big|_{s=1/2} = -\frac{4}{3}$.

Multiplying these singular factors proves that the leading singularity of $\mathcal{M}_W(s)$ at $s = 1/2$ is an **exact triple pole**:

$$
\mathcal{M}_W(s) = -\frac{4}{3} \cdot \frac{1}{s-1/2} \cdot \frac{1}{4(s-1/2)^2} + O\left(\frac{1}{(s-1/2)^2}\right) = -\frac{1}{3(s-1/2)^3} + O\left(\frac{1}{(s-1/2)^2}\right).
\tag{4}
$$

Since (3) is already the Mellin transform of $W$, its inversion uses
$x^{s+1}$ with no additional factor $1/(s+1)$. The residue of the leading
triple-pole term is:

$$
\operatorname*{Res}_{s=1/2}
\left[-\frac{x^{s+1}}{3(s-1/2)^3}\right]
=-\frac{1}{3\cdot 2!}x^{3/2}\log^2 x
=-\frac{1}{6}x^{3/2}\log^2 x.
$$

This identifies the coefficient that would appear when contour inversion is
justified. The local Laurent expansion alone does not establish the error
term in (1); that needs a separate bound for the remaining contour or an
explicit formula.

Under RH, the required global bound is
$$
\int_{\mathbb R}
\frac{|\zeta(1+\varepsilon+it)|\,|G(1/2+\varepsilon+it)|^2}
{|(1/2+\varepsilon+it)(3/2+\varepsilon+it)|}\,dt
\ll\varepsilon^{-1}.
$$
It gives $N_*(x)=O(x^{3/2}\log x)$ after shifting to
$\operatorname{Re}s=1/2+1/\log x$. PNT partial summation gives
$T_*(x)=\frac16x^{3/2}\log^2x+O(x^{3/2}\log x)$ while retaining all prime
powers. Since $W=N_*-T_*$, these two global estimates prove (1). The proof is
conditional on RH and does not constitute RH progress.

---

## 3. The circularity wall and sieve parity barrier

The decomposition $W(x) = N_*(x) - T_*(x)$ splits $W(x)$ into the centered distinct-prime convolution $N_*(x)$ and the deterministic same-prime extraction $T_*(x) = \frac{1}{6}x^{3/2}\log^2 x + O(x^{3/2}\log x)$.

Proving $W(x) \le 0$ unconditionally requires establishing:

$$
N_*(x) \le \frac{1}{6}x^{3/2}\log^2 x + O(x^{3/2}\log x).
\tag{5}
$$

This requirement encounters three fundamental mathematical barriers:
1. **RH-Level Logical Obstruction**: The Mellin transform of $N_*(x)$ contains double poles at every non-trivial zero $\rho$ of $\zeta(s)$. The machine-checked implication from eventual nonpositivity to RH gives the qualitative obstruction by contraposition. The Landau comparison below also gives the weaker quantitative statement (2), but neither argument identifies the exact pointwise contribution of an arbitrary zero.
2. **The Sieve Parity Barrier**: Bilinear decompositions (Vaughan, Heath-Brown) isolate Type I and Type II sums. Cauchy--Schwarz on Type II sums inherently incurs an $L^2$ square-root loss over the modulus, yielding at best unconditional bounds of order $O(x^2 \exp(-c\sqrt{\log x}))$. Purely combinatorial sieves cannot break the parity barrier to save the required $x^{1/2}$ power factor without an explicit zero-free region input.
3. **Termwise Indefiniteness**: In the discrete algebraic expansion $W(x) = B_*(x) + \sum_{n \le x}\frac{x-n}{\sqrt{n}}[L(n)^2 - Q(n) - (1+x/n)L(n)]$, the arithmetic bracket is not termwise nonpositive. For composite integers (e.g. $n=36, x=72$), the bracket evaluates to $+1.9102 > 0$. Over $x \le 200$, 88 of 199 integers (44.2%) have positive brackets, disproving any termwise or cone-invariance bound.

### Landau proof of the weaker quantitative statement

Fix $0<\eta<\beta_0-1/2$ and put
$$
\alpha=\frac32+\eta,
\qquad
a=\alpha-1=\frac12+\eta<\beta_0.
$$
The arithmetic definition gives $W(x)=O(x^2\log x)$, so all tail transforms below converge for $\operatorname{Re}s>1$ and have finite abscissa of convergence at most $1$.

Suppose first that $W(x)\le Cx^\alpha$ for all $x>A$, with $C>0$. Then $F_+(x)=Cx^\alpha-W(x)$ is nonnegative on that tail, and for $\operatorname{Re}s>1$ its transform is
$$
\begin{aligned}
\mathcal L_+(s)
&=\int_A^\infty F_+(x)x^{-s-2}\,dx\\
&=\frac{C A^{a-s}}{s-a}-\mathcal M_W(s)
  +\int_1^A W(x)x^{-s-2}\,dx.
\end{aligned}
\tag{6}
$$
The last term is entire. The Mellin formula (3) continues meromorphically to $\operatorname{Re}s>1/2$. It is analytic at every real $s>1/2$: $G$ has a removable singularity at $1$, zeta has no real zero in $(1/2,1)$, $H$ is holomorphic there, and the shifted-zeta pole lies at the excluded endpoint $s=1/2$. At $s=\rho_0$, however, $\mathcal M_W$ has a noncancelled double pole; for zero multiplicity $m_{\rho_0}$ its leading coefficient is
$$
\frac{m_{\rho_0}^2\zeta(\rho_0+1/2)}{\rho_0(\rho_0+1)}\ne0.
$$

Let $\sigma_+$ be the convergence abscissa of the nonnegative transform $\mathcal L_+$. If $\sigma_+<\beta_0$, the integral would define a holomorphic function at $\rho_0$, contradicting the double pole in the continuation (6). Hence $\sigma_+\ge\beta_0>a$. Landau's theorem for nonnegative Laplace--Mellin transforms says that the real boundary point $s=\sigma_+$ must be singular. But the right side of (6) is analytic near that real point: its added real pole is only at $a<\beta_0$, and $\mathcal M_W$ is analytic on the real interval $(1/2,\infty)$. This contradiction rules out every eventual upper bound $W(x)\le Cx^\alpha$ and proves the positive limsup in (2).

For the negative liminf, assume $W(x)\ge-Cx^\alpha$ eventually and apply the same argument to the nonnegative function $F_-(x)=Cx^\alpha+W(x)$. Its transform is
$$
\mathcal L_-(s)=\frac{C A^{a-s}}{s-a}+\mathcal M_W(s)
-\int_1^A W(x)x^{-s-2}\,dx,
$$
which has the same real-axis analyticity and a noncancelled double pole at $\rho_0$. Thus no eventual lower bound of this order exists. Together the two contradictions prove (2) without assuming that $\rho_0$ is rightmost or isolated from other zeros.

---

## 4. Finite numerical regime and blind-spot analysis

1. **Sampled initial window**: Numerical evaluation suggests a sign crossing near $x=184.31$ and gives $W(185)\approx-22.58$ and $W(2500)\approx-739421.60$. A finite sample does not establish a sign on a whole interval. Also $W(1)=0$ by definition, so strict positivity on $[1,184.31]$ is false.
2. **Blind spot against high-ordinate zeros**: Verified zero locations up to a finite height cannot rule out an off-critical zero above that height. Its contribution to a putative explicit formula depends on its ordinate, horizontal displacement, multiplicity, and the other zero contributions. No universal crossover threshold such as $10^{250}$ follows from the displayed residue factor alone. The sampled negative values do not establish eventual nonpositivity.

---

## 5. Machine verification and axiom audit

The forward implication of Theorem 1.1 is verified in Lean 4:

```lean
namespace BuildingBlocks.ActualCriticalSignCriterion

theorem RiemannHypothesis_of_nonpos_after {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) :
    RiemannHypothesis

theorem RiemannHypothesis_of_eventually_nonpos
    (hsign : ∀ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re ≤ 0) :
    RiemannHypothesis
```

Source: [`formalization/BuildingBlocks/ActualCriticalSignCriterion.lean`](../../formalization/BuildingBlocks/ActualCriticalSignCriterion.lean).
Dedicated automated audit file: [`formalization/verification/ActualCriticalSignCriterionAudit.lean`](../../formalization/verification/ActualCriticalSignCriterionAudit.lean).

Axiom dependencies verified via `Lean.CollectAxioms`:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`. Verified via `lake env lean formalization/verification/ActualCriticalSignCriterionAudit.lean`.

Supporting computational certificates and structural analyses:
- [`certificates/haselgrove_crossover_scale_certificate.py`](../../certificates/haselgrove_crossover_scale_certificate.py): Computes scenario-dependent crossover scales for selected hypothetical parameter pairs. It does not provide a uniform coefficient bound or universal crossover threshold.
- [`critical-sign-criterion-structural-boundary.md`](critical-sign-criterion-structural-boundary.md): Structural boundary report covering the exact eventual-sign implication, the limits of local pole arguments, the audited sieve-loss model, and finite numerical checks.
