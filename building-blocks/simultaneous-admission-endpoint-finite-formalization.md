# Simultaneous-admission endpoint: finite Lean report

The module `SimultaneousAdmissionEndpointFinite.lean` formalizes the corrected endpoint estimate as a sign-free finite bound. It uses actual `ArithmeticFunction.moebius` in the arithmetic specializations and makes no asymptotic or RH claim.

## One-divisor face

With the literal index change `j=i+1`, the definition is

\[
E_d(q)=(1-q)\sum_{i=0}^{d-1}q^{2d-(i+1)}
=(1-q)\sum_{j=1}^{d}q^{2d-j}.
\]

The proof reverses the finite range and applies the polynomial geometric-sum identity. It establishes for every real `q`, without a convergence assumption,

\[
E_d(q)=q^d-q^{2d}.
\]

For `0≤q≤1`, `endpointFace d q = sqrt(E_d(q))` is a concrete vector in the one-dimensional real Hilbert space and satisfies

\[
\|v_d\|^2=E_d(q)=q^d-q^{2d}\le \frac14.
\]

The quarter bound is the exact elementary inequality `x-x²≤1/4` with `x=q^d`. It includes `q=0`, `q=1`, and `d=0`.

## Finite signed packet

For a finite set `S`, arbitrary vectors `v_i` in any real seminormed vector space, and arbitrary real coefficients `σ_i`, the theorem

```text
signed_packet_norm_sq_le_card_sq_div_four
```

proves

\[
|\sigma_i|\le1,\quad \|v_i\|^2\le\frac14
\quad\Longrightarrow\quad
\left\|\sum_{i\in S}\sigma_i v_i\right\|^2
\le\frac{|S|^2}{4}.
\]

The proof is finite Minkowski followed by squaring. It deliberately uses no sign cancellation or orthogonality.

`mobius_packet_norm_sq_le_card_sq_div_four` discharges the coefficient premise with Mathlib's theorem `ArithmeticFunction.abs_moebius_le_one`, so it applies to the complete actual Möbius packet, including zero coefficients.

## Finite prime product

The module also proves:

1. A positive squarefree integer `P` has `2^(P.primeFactors.card)` divisors.
2. If every element of a finite set `Q` is prime, its product is squarefree and has exactly `2^(Q.card)` divisors.
3. Therefore the complete divisor-face packet of `∏ p∈Q, p` obeys

\[
\left\|\sum_{d\mid\prod Q}\mu(d)v_d\right\|^2
\le \frac{(2^{|Q|})^2}{4},
\]

provided each face has squared norm at most `1/4`.

The prime-product count is proved inside the module from pairwise coprimality and Mathlib's actual divisor/factorization API; it is not an extra hypothesis.

## Compilation and axioms

Lean 4.24 compiles the module without warnings. Every printed theorem reports exactly

```text
[propext, Classical.choice, Quot.sound]
```

There is no `sorry`, `admit`, or new axiom.
