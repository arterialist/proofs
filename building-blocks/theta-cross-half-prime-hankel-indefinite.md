# The actual opposite-half theta arrival operator is indefinite at every radius

The exact positive-half block equation for the killed theta ground contains an opposite-half arrival `B_R^×`. Its kernel is pointwise nonnegative, so it preserves nonnegative functions. Its **quadratic form is nevertheless indefinite** for every finite core radius `R>0`. This is an actual-prime obstruction to replacing the Schur cross operator by a positive semidefinite rank or to inferring that only the even ground can lie below the half-line bottom. It does not show that the actual positive ground has a negative cross pairing, and it does not refute the full theta gap or RH.

Use `H_+=L²((R,∞),ν)`, `dν=bΦ du`, `b(u)=2cosh(u/2)`, and the actual reflected opposite-half arrival

`(B_R^×v)(u)=b(u)^(−1)∫_R^∞Φ(s)r(u+s)v(s)ds
   +b(u)^(−1)Σ_{n≥2;\log n>u+R}[Λ(n)/√n]Φ(\log n−u)v(\log n−u)`,

where `r(t)=e^(−t/2)/(1−e^(−2t))`. Its continuous part and every prime power are present. For a real compact smooth physical test `g=Φv` supported in `(R,∞)`, weighted symmetry and the substitution `s=log n−u` give the exact scalar pairing

`⟨v,B_R^×v⟩_ν=C[g]+P[g]`,

`C[g]=∫_{u,s>R}r(u+s)g(u)g(s)duds`,

`P[g]=Σ_{n≥2}[Λ(n)/√n](g*g)(log n)`.       (1)

The sum is finite for this compact test. The continuous form is positive semidefinite even for signed `g`, since `r(t)=Σ_{j≥0}e^{−(2j+1/2)t}` and hence `C[g]=Σ_{j≥0}(∫e^{−(2j+1/2)u}g(u)du)²≥0`.

Fix any ordinary prime `p>e^{2R}`. Choose `a,b>R`, `a≠b`, with `a+b=log p` and with neither `2a` nor `2b` equal to the logarithm of a prime power. This is possible because the forbidden choices form a finite set in the bounded interval `R<a<log p−R`. Let `η∈C_c^∞(−1,1)` be real, even, nonnegative, and `||η||₂=1`; set `η_ε(u)=ε^(−1/2)η(u/ε)` and

`g_ε(u)=η_ε(u−a)−η_ε(u−b)`.

For sufficiently small `ε>0`, both bumps lie in `(R,∞)`. Their three sum-support intervals near `2a`, `a+b`, and `2b` are disjoint, and among all prime-power logarithms only `log p` lies in their union. Every proper power and every other ordinary prime therefore contributes exactly zero to (1). Reflection across `a+b` exchanges the two bumps, so

`(g_ε*g_ε)(log p)=−2`,

`P[g_ε]=−2(log p)/√p`.                       (2)

On the fixed compact sum interval `u+s≥2R>0`, `r(u+s)` is bounded. Since `||g_ε||₁=O(√ε)`,

`0≤C[g_ε]=O_{R,p,η}(ε)`.                     (3)

Equations (1)–(3) give `⟨g_ε/Φ,B_R^×(g_ε/Φ)⟩_ν<0` for all sufficiently small `ε`. A single positive bump centered at `(log p)/2` yields a strictly positive pairing, so `B_R^×` is indefinite, not merely non-positive.

The diagonal half-line operator `A_R=D_{+,R}−α_R` is strictly positive at the even ground energy. To see the strict inequality, let `ϕ_R≥0` be a normalized positive-half ground at `β_R=inf σ(D_{+,R})<1/2`, whose existence follows from the published half-line threshold-index theorem. The even trial `(ϕ_R,ϕ_R)/√2` has Rayleigh value `β_R−⟨ϕ_R,B_R^×ϕ_R⟩`. The cross pairing is strictly positive: its continuous kernel `r(u+s)` is positive on every pair of positive-half points, while every prime-power term is nonnegative for `ϕ_R≥0`. Therefore `α_R<β_R` and `A_R≥(β_R−α_R)I>0`.

The conjugated Birman–Schwinger operator `A_R^(−1/2)B_R^×A_R^(−1/2)` consequently also has a negative quadratic direction: take `f=A_R^(1/2)(g_ε/Φ)`, for which its quadratic pairing equals (1). The full block positivity still bounds its spectrum inside `[-1,1]` and the actual even ground supplies eigenvalue `+1`; the present construction shows that the negative side cannot be discarded by kernel positivity.

This obstruction is sharply scoped. The signed two-bump test is not the nonnegative ground and carries archimedean kinetic cost `A[g_ε]=2log(1/ε)+O_{R,p,η}(1)`: each scaled bump has `log(1/ε)+O(1)` from the digamma multiplier, and the separated cross pairing is bounded. It does not produce a subthreshold eigenfunction or disprove a source-specific estimate that pays this cost. It rules out only the proposed route that treats the exact cross operator, or its Schur conjugate, as a positive semidefinite form merely because all arrival rates are nonnegative.
