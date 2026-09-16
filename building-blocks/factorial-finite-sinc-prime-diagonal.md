# Finite sinc form and the paid prime diagonal

## Status and scope

Seven public finite-algebra theorems are compiled in `ActualFiniteSincPrimeDiagonal.lean`. A bounded worker derived and compiled the module; root reviewed its definitions, hypotheses, and exact scope before publication. The analytic interval-integral/Bochner Parseval passage, infinite Abel limit, and central-arc arithmetic upper bound remain open. This module is not an RH conclusion.

For a symmetric angular arc of half-width δ, define the normalized integer Fourier coefficient

    sinc_δ(k) = δ/π                         if k=0,
                sin(kδ)/(πk)                otherwise.

The compiled identities prove its exact diagonal value and symmetry under k↦−k. For a finite horizon set S, radius r, and arbitrary real covariance `cov`, the complete form is

    F_S(δ,r,cov)
      = Σ_(m,n∈S) r^(m+n) sinc_δ(m−n) cov(m,n).

No off-diagonal term is removed from this definition.

For a finite selected prime set P and nonnegative diagonal data q(p), the paid row is

    D_P(δ,r,q) = (δ/π) Σ_(p∈P) r^(2p)q(p).

The module proves D_P≥0 for δ≥0. If P⊆S and q is nonnegative on S, it also proves that D_P is at most the complete finite birth diagonal. Consequently an upper bound B for `F_S−D_P`, together with a full-diagonal budget V, gives `F_S≤B+V` without assigning a sign to the remaining prime-prime, prime-composite, or composite-composite rows.

For the literal collision kernel K, the exact selected-prime norm inserted in the diagonal is

    q(p)=K(2p)−2K(p+1)+K(2).

The equality is compiled without asymptotic replacement. Its nonnegativity is deliberately supplied as the norm-square hypothesis in the generic theorem; connecting it to the already compiled birth collision norm and passing to the analytic arc integral are separate formalization obligations.

All seven public conclusions depend only on `propext`, `Classical.choice`, and `Quot.sound`. Prime diagonal subtraction pays a known nonnegative row, but it does not create the missing signed cancellation in the remainder.
