# Complete divisor birth cancellation and the signed LCM boundary

## Status and attribution

The exact finite arithmetic chain below is compiled in Lean 4/mathlib, using the actual response and actual Möbius function. Full-clock absolute integrability and the exact integrated boundary decomposition are compiled too. The numerical integral comparison is independently reviewed written mathematics; its formalization remains pending. The final arithmetic upper bound is open. This does not prove RH.

The complete-LCM multiplication was proposed by the coordinator's isolated Astra investigation on 16 September 2026. Root independently proved the finite divisor-inversion argument and the linear interior comparison, and formalized the exact pointwise decomposition. The underlying multiplication is classical necklace algebra: Moree, *The formal series Witt transform*, Theorem 1(1), pp. 144–145, reports the Metropolis–Rota formula and its earlier history. [Published primary paper](https://pure.uva.nl/ws/files/4076156/164745_238164.pdf). No positivity of integer-alphabet necklace counts is transferred to real arguments between zero and one.

## Literal response and complete histories

Let

    g_N(t) = Σ_(1≤d≤N) μ(d)(1−exp(−⌊N/d⌋t)),
    h_n(t) = g_n(t)−g_(n−1)(t)  (n≥1),  h_0(t)=0,
    β(t) = (1−exp(−t))/(1+exp(−t)).

All the following pointwise identities hold for every real t, including zero and negative clocks. Additive birth includes the new divisor n:

    h_n(t) = (1−exp(−t)) Σ_(d|n) μ(d) exp(−(⌊(n−1)/d⌋)t).

Finite Möbius inversion gives the complete divisor observation

    Σ_(d|n) h_d(t) = (1−exp(−t)) exp(−(n−1)t).

Every ordered pair with lcm(i,j)=k consists of divisors of k. Sum these classes over k|n: the resulting complete pair sum is the square of the divisor observation. That square equals β(t) times the same observation at 2t. Applying finite Möbius inversion again proves

    Σ_(lcm(i,j)=k) h_i(t)h_j(t) = β(t)h_k(2t).

For 1≤k≤N, every pair in this class already belongs to the actual integer rectangle i,j≤N. Thus all complete interior classes telescope, giving the exact original-response identity

    g_N(t)² = β(t)g_N(2t) + E_N(t),
    E_N(t) = Σ_(1≤i,j≤N, lcm(i,j)>N) h_i(t)h_j(t).

No future arrival is added, no signed pair is discarded, and both ordered copies remain. The decomposition includes N=0. In Lean, positive births use `arrival n t`; `birth N t` denotes the arrival at N+1.

## Full original clock: written comparison

Keep the full compensated weight

    w(t)=1/t²−1/[t(exp(t)−1)],   t>0,
    Q_N=∫_(0,∞) g_N(t)² w(t) dt.

Every fixed-horizon birth is O_N(t) at the origin and bounded at infinity, so each finite ordered pair is absolutely integrable against w. The interior row is also absolutely integrable. Define

    L_N=∫_(0,∞) β(t)g_N(2t)w(t)dt,
    B_N=∫_(0,∞) E_N(t)w(t)dt.

Then Q_N=L_N+B_N. For β(t)≤t/2, set a(t)=t−2+(t+2)exp(−t). Its derivative is 1−(t+1)exp(−t)≥0 by exp(t)≥1+t, and a(0)=0. Thus t(1+exp(−t))≥2(1−exp(−t)). The other scalar inequalities follow directly from 0<exp(−t)≤1. The compiled actual bound |g_N(2t)|≤N and these scalar inequalities yield

    |L_N|≤5N/4.

Indeed, on 0<t≤1 use w(t)≤1/(2t), giving β(t)w(t)≤1/4. On t≥1 use w(t)≤1/t² and β(t)≤1, whose integral is one. Therefore, for every integer X≥1,

    |Σ_(X≤N<2X) L_N|≤5X(3X−1)/8.

The exact remaining sufficient arithmetic estimate is the one-sided signed bound

    Σ_(X≤N<2X) B_N ≤ C_ε X^(2+ε),  for every ε>0.

It would bound the full original dyadic energy at the required scale. It is unproved. Absolute-pair or positive-fiber bounds are different statements and cannot be substituted for it.

## Formal coverage

`FactorialIntegerBirth.lean` adds exact arrival support, the divisor birth formula, birth telescoping, and signed work telescoping: four new compiled theorems.

`FactorialBirthDivisorGhost.lean` proves actual birth inversion, complete divisor cancellation, complete ordered-pair cancellation, and the doubled-clock scalar identity: four compiled theorems.

`FactorialBirthLcmGhost.lean` proves divisor filtering, complete class divisor sums, LCM-class cancellation, rectangle completeness, actual rectangle-class identification, positive-arrival telescoping, the complete interior sum, interior pair identification, and the full signed boundary decomposition: nine compiled theorems.

`FactorialBirthLcmEnergy.lean` adds the literal predecessor response identity, absolute integrability of every birth product and every selected finite pair sum, absolute integrability of the interior and boundary, and the exact integrated energy decomposition: six compiled theorems.

All twenty-three added theorems use only the standard logical axioms `propext`, `Classical.choice`, and `Quot.sound`. The constant 5/4, the dyadic polynomial sum, and the RH consumer implication in this formulation remain written proof obligations. The signed arithmetic estimate is open, not an assumed mathematical axiom.
