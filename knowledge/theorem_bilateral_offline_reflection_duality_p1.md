# Bilateral Offline Support Reflection Duality

Type: theorem
Confidence: high
Source: Candidates 0, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31 (Level 0), explore_merger_L01_N12 through N14, explore_merger_L02_N00 through N07, explore_merger_L03_N00, L03_N01, L03_N02, L03_N03
Relevant to: Proving unconditional equivalence between unilateral right-half zero-freeness, unilateral left-half zero-freeness, and the Riemann Hypothesis without bilateral conjunctions.

## Statement
Let $\zeta(s)$ denote the Riemann zeta function on $\mathbb{C}$, and let:
$$\mathcal{Z}_{\mathrm{nontriv}} := \{s \in \mathbb{C} \mid \zeta(s) = 0 \wedge (\neg \exists n \in \mathbb{N},\, s = -2(n+1)) \wedge s \ne 1\},$$
$$\mathrm{RightOfflineSupport} := \{s \in \mathcal{Z}_{\mathrm{nontriv}} \mid \operatorname{Re}(s) > 1/2\},$$
$$\mathrm{LeftOfflineSupport} := \{s \in \mathcal{Z}_{\mathrm{nontriv}} \mid \operatorname{Re}(s) < 1/2\}.$$
Then the conformal reflection map $\iota(s) := 1 - s$ restricts to an involutive bijection between $\mathrm{RightOfflineSupport}$ and $\mathrm{LeftOfflineSupport}$.
Consequently, the following unconditional equivalences hold:
$$\mathrm{RightOfflineSupport} = \emptyset \iff \mathrm{LeftOfflineSupport} = \emptyset \iff (\mathrm{RightOfflineSupport} = \emptyset \wedge \mathrm{LeftOfflineSupport} = \emptyset) \iff \mathrm{RiemannHypothesis}.$$

## Proof
1. **Right-to-Left Reflection**: Let $s \in \mathrm{RightOfflineSupport}$. Then $\zeta(s) = 0$, $s \ne 1$, $\neg \exists n \in \mathbb{N}, s = -2(n+1)$, and $\operatorname{Re}(s) > 1/2$.
   - Real part: $\operatorname{Re}(1-s) = 1 - \operatorname{Re}(s) < 1 - 1/2 = 1/2$.
   - Pole exclusion: If $1-s = 1$, then $s = 0$. But $\zeta(0) = -1/2 \ne 0$ (`zeta_zero_ne_origin`), contradicting $\zeta(s) = 0$. Thus $1-s \ne 1$.
   - Zeta vanishing: By the completed functional equation $\xi(s) = \xi(1-s)$, since $s \ne 1$ and $s$ is not a nonpositive even integer, $\zeta(s) = 0 \implies \xi(s) = 0 \implies \xi(1-s) = 0 \implies \zeta(1-s) = 0$ (`reflect_nontrivial_zero`).
   - Trivial zero exclusion: Suppose for contradiction that there exists $n \in \mathbb{N}$ such that $1-s = -2(n+1)$. Then $s = 1 + 2(n+1) = 2n + 3 \ge 3 \ge 1$. Since $s$ is real with $\operatorname{Re}(s) \ge 1$, Mathlib's verified theorem `riemannZeta_ne_zero_of_one_le_re` guarantees $\zeta(s) \ne 0$, contradicting $\zeta(s) = 0$. Thus $\neg \exists n \in \mathbb{N}, 1-s = -2(n+1)$.
   Hence $1-s \in \mathrm{LeftOfflineSupport}$.

2. **Left-to-Right Reflection**: Let $w \in \mathrm{LeftOfflineSupport}$. Then $\zeta(w) = 0$, $w \ne 1$, $\neg \exists n \in \mathbb{N}, w = -2(n+1)$, and $\operatorname{Re}(w) < 1/2$.
   - Real part: $\operatorname{Re}(1-w) = 1 - \operatorname{Re}(w) > 1/2$.
   - Pole exclusion: $1-w = 1 \implies w = 0$, contradicting $\zeta(0) \ne 0$.
   - Zeta vanishing: $\zeta(1-w) = 0$ via functional equation.
   - Trivial zero exclusion: If $1-w = -2(n+1)$, then $\operatorname{Re}(1-w) = -2(n+1) \le -2 < 0$, which contradicts $\operatorname{Re}(1-w) > 1/2 > 0$. Thus $\neg \exists n \in \mathbb{N}, 1-w = -2(n+1)$.
   Hence $1-w \in \mathrm{RightOfflineSupport}$.

3. **Involution and Equivalence**:
   Since $\iota(\iota(s)) = 1 - (1-s) = s$, $\iota$ is a bijection between $\mathrm{RightOfflineSupport}$ and $\mathrm{LeftOfflineSupport}$.
   Therefore $\mathrm{RightOfflineSupport} = \emptyset \iff \mathrm{LeftOfflineSupport} = \emptyset$.
   Combining with the existing theorem $\mathrm{RightHalfZeroFree} \iff \mathrm{RightOfflineSupport} = \emptyset$ and `target_iff_rightHalfZeroFree`, we conclude that either unilateral emptiness condition is equivalent to `RiemannHypothesis`.

## Hypotheses / Conditions
- Standard functional equation of $\zeta(s)$ on $\mathbb{C}$.
- Non-vanishing of $\zeta(s)$ on $\operatorname{Re}(s) \ge 1$ (`riemannZeta_ne_zero_of_one_le_re`).
- $\zeta(0) = -1/2 \ne 0$.

## How It Applies
Allows replacing bilateral conjunction hypotheses (`LeftOfflineSupport = ∅ ∧ RightOfflineSupport = ∅`) with unilateral ones (`RightOfflineSupport = ∅`), halving the required verification burden in subsequent bridge modules.

## Caveats
Analytically, establishing $\mathrm{LeftOfflineSupport} = \emptyset$ directly from first principles is no easier than $\mathrm{RightOfflineSupport} = \emptyset$, as all known Dirichlet and operator machinery operates on $\operatorname{Re}(s) > 1/2$. The value of this theorem is purely structural and foundational within the formalization.
