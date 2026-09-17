# Integrated factorial floor-derivative sampling: an actual counterexample

The complete integer quotient constraints make adjacent floor-transform differences vanish in the bulk. One natural energy-sampling proposal is that the integer floor derivative acts contractively in the actual compensated factorial kernel. This proposal is false for the unique actual Möbius quotient vector at N=13, with an exact integer certificate. Two-dimensional interior quotient compatibility does not repair that specific sampling inequality; boundary and unsampled cell costs remain separate possibilities.

## Full arithmetic rows and a concrete integrated candidate

Use the published complete factorial kernel

B(x,y)=∫₀∞(1−e^(−xt))(1−e^(−yt))w(t)dt,
w(t)=t^(−2)−[t(e^t−1)]^(−1)>0.

Its integer value is entropy minus log binomial. The factorial identity retains every von Mangoldt prime-power valuation and the entire density compensation. Nothing is removed from this kernel below.

For integer N≥1 group the literal coefficients A_q=Σ_{n≤N:floor(N/n)=q}μ(n). Put

G_A(t)=Σ_q A_q(1−e^(−qt)),
F_A(k)=Σ_q A_q floor(q/k), k≥1,
ΔF_A(k)=F_A(k)−F_A(k+1).

The actual complete constraints give F_A(k)=1 for 1≤k≤N and F_A(k)=0 for k>N. They uniquely identify the grouped actual vector; no fabricated first-moment vector is substituted. Define the sampled derivative response

H_A(t)=Σ_{k=1}^N ΔF_A(k)(1−e^(−kt)).

A concrete integrated sampling/data-processing candidate is

∫₀∞|G_A(t)|²w(t)dt ≤ ∫₀∞|H_A(t)|²w(t)dt.   (1)

Both sides use the original full compensated positive kernel and the entire positive clock axis. This is an operator-contraction proposal for integer floor derivative sampling, rather than the diagonal hypothesis Q≤D or a pointwise response-sign claim. No Jensen estimate, Möbius inversion of F, or monotone-birth premise is used.

On the actual vector all adjacent differences vanish for k<N, while ΔF_A(N)=1. Thus H_A(t)=1−e^(−Nt), including the terminal trace, and the candidate becomes

Q_N ≤ B(N,N).   (2)

It would be incorrect to erase ΔF_A(N) and conclude the sampled energy is zero. The proper sampled energy in (2) retains that terminal contribution exactly.

## Two-dimensional quotient compatibility and the missing cost

The same full rows also impose, for integers k,l≥1,

F_A(kl)=Σ_q A_q floor(floor(q/k)/l)=1_{kl≤N}.

Therefore the double difference

R_A(k,l)=F_A(kl)−F_A((k+1)l)−F_A(k(l+1))+F_A((k+1)(l+1))   (3)

vanishes whenever (k+1)(l+1)≤N. This is an exact compatibility of one common coefficient vector over the two quotient directions; it does not treat the directions as independent histories. At the product boundary its value is the corresponding double difference of 1_{kl≤N}, and those terminal rectangles need not vanish.

Any proposed repair of (1) that adds only nonnegative weighted interior squares |ΔF_A(k)|² for k<N and |R_A(k,l)|² for (k+1)(l+1)≤N contributes exactly zero on the actual system. Consequently such an interior difference cost cannot repair (2). This statement does not exclude a cost involving boundary rectangles, real quotient cells, or genuinely nonlocal arithmetic data. Their connection to the original energy would have to be derived, rather than assumed from the bulk sampled zeros.

## Exact actual N=13 certificate

The published actual Möbius grouping at N=13 is

A_13=1, A_6=−1, A_4=−1, A_1=−2,

with every other grouped coefficient zero. It satisfies all rows F_A(k)=1, k≤13. Its original complete response is

G_A(t)=−3+2z+z⁴+z⁶−z¹³, z=e^(−t).

The sampled response is H_A(t)=1−z¹³. In particular the original terminal value is −3 whereas the sampled terminal value is 1; the small-clock slopes are respectively 1 and 13. The sampling proposal must integrate compensation between these different regions; one boundary alone does not decide it.

Expanding every ordered kernel pair with the exact integer formula

B(a,b)=log[((a+b)^(a+b)a!b!)/(a^a b^b(a+b)!)],

gives

Q_13−B(13,13)
 =log[5³⁵13¹⁰⁴/(2⁶¹3²⁵7²⁸11·17³⁰19³⁶)]>0.   (4)

This sign is certified by direct integer comparison. Its numerator is

206090888544856400489835512885219892359209589127498312678030729492134701652895950170003334116274581315428405348975679953582584857940673828125

and its denominator is

878205564785592141495307779066535135043886794662565575536795415380520803654942088790208078913973161171288982619220079971202748877136461824.

Thus (1)–(2) fail on the actual unique coefficient vector, retaining the full density-minus-factorial kernel and all ordered cross-size terms. For orientation only, Q_13 is approximately 7.32264 and B(13,13) approximately 1.86445; the proof of the sign is the integer inequality, not these decimal values.

This is a decisive counterexample to the specified integrated floor-derivative sampling contraction. It also excludes repair using only the vanishing interior costs in (3). It does not refute the open diagonal hypothesis Q_N≤D_N, a linear or subpower upper bound, or a sampling comparison with separately derived real-cell and terminal reserves. The actual full constraints identify A; they supply no contraction constant by themselves.

All finite energy integrals are legitimate by the published factorial dictionary. This is written mathematics with an exact integer calculation, not an assertion of additional compiled Lean. No RH conclusion follows.

## Independent review and signed boundary total

The root independently checked all thirteen quotient rows and reconstructed the exact rational in (4) by multiplying every ordered kernel-pair factor with its signed coefficient product. The numerator exceeds the denominator by direct integer comparison. No decimal approximation is needed.

There is also an exact boundary conservation identity for every N≥1. With F(k)=1_{k≤N}, double telescoping gives

    Σ_{k=1}^N Σ_{l=1}^N R(k,l)
      =F(1)−F(N+1)−F(N+1)+F((N+1)²)=1.

This is a signed identity. At N=13, R(1,6)=−1 and R(1,13)=1. Thus the product boundary is retained and its rectangles are not a positive measure. The signed total one does not bound the sum of absolute values or its quadratic cost. A comparison involving boundary rectangles remains possible, but needs its own weighted energy identity and bound.

RH Agent2 and its bounded mathematical descendant supplied the sampling counterexample; RH Agent2 supplied the real first-cell companion. The root supplied the independent full-row and ordered-pair review and the signed boundary telescoping observation.

## Relation to the centered-consumer obstruction

The failed contraction is a genuinely distinct finite no-go. It disproves a
specific data-processing inequality for the complete compensated factorial
kernel at one actual cutoff; it does not follow from, and does not prove, the
asymptotic centered Abel--Mertens mean-square criterion. By contrast, the
real first-cell companion isolates `M(N)^2` itself and therefore rejoins that
criterion rather than adding a second asymptotic obstruction.

[FactorialFloorDerivativeObstruction.lean](../../formalization/BuildingBlocks/FactorialFloorDerivativeObstruction.lean)
formalizes all thirteen quotient rows, the interior and terminal sampled
differences, the exact numerator-denominator inequality and positive log
ratio, the first-cell algebra, its scalar length normalization, and the
two-dimensional boundary telescope. Every printed theorem uses only the
standard axioms; no analytic energy upper bound or RH claim is added.
