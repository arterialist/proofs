# Central angular mass on a coupled low physical clock

This independently reviewed written proof shows that the exact successor field satisfies the desired arc-length local-mass bound on a coupled portion of angular and physical clock space. For angular width δ=1/H, the paid physical range is

t≤T_H=1/(sqrt(H) log(4X)).

This is an unconditional estimate for the actual response. It preserves every Möbius coefficient and horizon endpoint. The complementary physical clock remains open.

Fix X≥2 and an integer sqrt(X)≤H≤X. Write

g_N(t)=Σ_{d≤N}μ(d)(1−exp(−floor(N/d)t)),
h_N=g_N−g_(N−1).

## Actual short horizon blocks

For 0≤A<B with B−A≤H, the 1-Lipschitz property of v↦1−exp(−v) gives

|g_B(t)−g_A(t)|
 ≤t Σ_{d≤B}[floor(B/d)−floor(A/d)].                 (1)

The sum counts factor pairs (d,k) with A<dk≤B. Every such pair has d≤sqrt(B) or k≤sqrt(B). Hence, counting the two orientations and allowing their overlap,

Σ_{d≤B}[floor(B/d)−floor(A/d)]
 ≤2Σ_{d≤sqrt(B)}(H/d+1)
 ≤C[H log(4+B)+sqrt(B)].                             (2)

In particular, when B≤3X the assumption H≥sqrt(X) gives

|g_B(t)−g_A(t)|≤C Ht log(4X).                       (3)

No cancellation hypothesis is used in (1)−(3). The exact Möbius signs remain present until the final absolute majorant.

Put r=exp(−1/X). A weighted successor block also has the same scale. Summation by parts gives

Σ_{A<n≤B}r^n h_n
 =r^B(g_B−g_A)+(1−r)Σ_{A<n<B}r^n(g_n−g_A).          (4)

Every inner difference has length at most H. Since (1−r)H≤1, equations (3)−(4) imply

|Σ_{A<n≤B}r^n h_n(t)|≤C Ht log(4X).                 (5)

Using the original complete weight w(t)≤1/(2t),

∫_0^T |Σ_{A<n≤B}r^n h_n(t)|²w(t)dt
 ≤C H²T²log²(4X).                                   (6)

## Fejér localization

Let a_n be Hilbert-space vectors supported on X≤n<2X and set A(θ)=Σa_ne^(inθ). For real x put S_H(x)=Σ_{x<n≤x+H}a_n. Direct finite expansion gives

∫_R ||S_H(x)||²dx
 =Σ_{m,n}(H−|m−n|)_+〈a_m,a_n〉
 =(1/(2π))∫_(−π)^π ||A(θ)||²
   [sin(Hθ/2)/sin(θ/2)]²dθ.                         (7)

For |θ|≤1/H, the square bracket is at least cH². Consequently

(1/(2π))∫_(|θ|≤1/H)||A(θ)||²dθ
 ≤C H^(−2)∫_R||S_H(x)||²dx.                         (8)

First apply (8) in the Hilbert space L²((0,T),w(t)dt) with a_n=r^n h_n restricted to X≤n<2X. A moving window containing n=X may start at A=X−1; equations (1)−(3) cover this endpoint. The moving sums vanish outside an x-set of length O(X), and (6) applies to every nonzero sum. Therefore

(1/(2π))∫_(|θ|≤1/H)∫_0^T
 |Σ_{X≤n<2X}r^nh_n(t)e^(inθ)|²w(t)dtdθ
 ≤C X T²log²(4X).                                   (9)

The same estimate holds for the complete Abel series Σ_(n≥1)r^nh_ne^(inθ), with a larger absolute constant. For x≥0, equations (1)−(2) and summation by parts bound its moving block by

C r^x t[H log(4+x+H)+sqrt(x+H)].

Squaring and integrating in x gives

C T²[H²Xlog²(4X)+X²].

Indeed, r^n≤C r^x throughout x<n≤x+H, and

∫_0^∞ r^(2x)log²(4+x+H)dx≤CXlog²(4X),
∫_0^∞ r^(2x)(x+H)dx≤CX².

For the infinite series, apply the finite Fejér identity first and pass to the limit. The linear birth budget and the Abel factor make the Hilbert square sum convergent.

After the H^(−2) factor in (8), this is

C T²[Xlog²(4X)+X²/H²].                              (9a)

The boundary range −H<x<0 contributes at most C H³T²log²(4X) before that H^(−2) factor. At the choice of T below, the second term of (9a) is bounded by CX/H because H²≥X. The boundary contribution is O(1), hence is also bounded by CX/H because H≤X.

Choose

T=T_H=1/[sqrt(H)log(4X)].

Then (9), and also the complete-series estimate (9a), become the desired local-density estimate

(1/(2π))∫_(|θ|≤1/H)∫_0^(T_H)
 |Σ_{X≤n<2X}r^nh_n(t)e^(inθ)|²w(t)dtdθ
 ≤C X/H=CXδ.                                        (10)

The same right side holds when the shell sum in (10) is replaced by the complete series Σ_(n≥1)r^nh_n(t)e^(inθ), by (9a) and H²≥X.

## A paid curved portion of the central Poisson consumer

Let δ_j=2^j/X until δ_j is comparable with X^(−1/2), and put T_j=sqrt(δ_j)/log(4X). Use (10) for the complete series with H_j comparable with 1/δ_j. On the inner arc |θ|≤δ_0 retain 0<t≤T_0. On each shell δ_(j−1)<|θ|≤δ_j retain 0<t≤T_j. Since

|1−re^(iθ)|² is comparable with X^(−2)+θ²,

the inner contribution to the exact Poisson consumer is at most C(Xδ_0)X²=CX². The j-th shell contribution is at most

C(Xδ_j)/δ_(j−1)²≤CX/δ_j.

These bounds form a decreasing geometric series. Therefore the complete actual successor field satisfies

(1/(2π))∫∫_R |Σ_(n≥1)r^nh_n(t)e^(inθ)|²
            w(t)dt dθ / |1−re^(iθ)|²
 ≤CX²,                                                (11)

where R is the curved central region just described. Up to dyadic constants, it is

|θ|≤X^(−1/2),  0<t≤sqrt(max(|θ|,X^(−1)))/log(4X).

Thus a genuine two-dimensional portion of the central Poisson variance is already paid at the target scale. The unresolved complement lies above this angular-dependent physical-clock boundary.

This covers the complete scale range X^(−1)≤δ≤X^(−1/2). At the widest central arc it pays t≤X^(−1/4)/log(4X), close to the growing-profile cutoff. At the narrowest arc it pays t≤X^(−1/2)/log(4X).

Equation (10) is a genuine coherent horizon estimate. It is stronger than summing the one-horizon rounding-error budgets, because the Fejér identity uses actual short horizon differences before squaring. It also avoids any prime-birth diagonal subtraction.

The remaining region t>T_H still includes the far-clock Abel-weighted Möbius polynomial isolated in the sinc-covariance note. No estimate here controls that complement, the full central Poisson variance, or RH. No Lean formalization is asserted.
