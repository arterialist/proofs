# Known Mertens oscillation rules out the strong factorial diagonal hypothesis

The strong hypothesis Q_N≤D_N is false for the actual Möbius family. The argument retains the exact floor hyperbola response and the full compensated Bernstein weight. It combines a sharper tail coercivity with the unconditional asymptotic diagonal constant and the published Mertens oscillation theorem of Hurst. It does not refute RH, Q_N=O(N), or the primary target Q_N≪_ε N^(1+ε). The contradiction concerns the specific coefficient-one diagonal upper bound, which was never asserted necessary under RH.

The actual objects are

g_N(t)=(1−e^(−t))Σ_{j=1}^N e^(−(j−1)t)M(floor(N/j)),
Q_N=∫_0^∞ |g_N(t)|²w(t)dt,
w(t)=t^(−2)−[t(e^t−1)]^(−1),
D_N=Σ_{n≤N}μ(n)²b(floor(N/n)), b(q)=B(q,q).

No fabricated coefficients, removed histories, diagonal replacement of Q, or global zero expansion is used.

## Tail coercivity at the asymptotic Mertens amplitude

Put L=limsup_(n→∞)|M(n)|/sqrt(n), allowing L=∞, and β=1+1/sqrt(2). Then

limsup_(N→∞) Q_N/N≥c L²,
c=[1−2/(e²−1)](1−βe^(−2))²/2>1/5.                 (1)

For finite positive L choose N_r→∞ such that |M(N_r)|/sqrt(N_r)→L. For any δ>0 there is K such that |M(m)|≤(L+δ)sqrt(m) for all m≥K. Split the exact response at those j for which floor(N_r/j)≥K. The other histories have uniformly bounded Mertens values, and their geometric weights start at j>N_r/K. At each fixed t>0 their contribution divided by sqrt(N_r) tends to zero. The retained j=1 history therefore gives

liminf_r |g_(N_r)(t)|/sqrt(N_r)
 ≥L(1−e^(−t))−(L+δ)Σ_{j≥2}(1−e^(−t))e^(−(j−1)t)/sqrt(j).

Let δ↓0. Since j≥2 implies 1/sqrt(j)≤1/sqrt(2), the geometric tail is at most e^(−t)/sqrt(2), yielding

liminf_r |g_(N_r)(t)|/sqrt(N_r)≥L(1−βe^(−t)), t≥2.  (2)

For t≥2, t/(e^t−1) decreases, so

w(t)≥[1−2/(e²−1)]/t².

Fatou on the full tail [2,∞), followed by 1−βe^(−t)≥1−βe^(−2), proves (1). Contributions from all other clock regions are nonnegative and have not been presumed to cancel or vanish.

If L=∞, take successive global records of |M(n)|/sqrt(n). At such an N, for every j≤N,

|M(floor(N/j))|≤|M(N)|/sqrt(j).

The same geometric lower bound holds before passage to a limit, giving Q_N≥c|M(N)|². The unbounded record ratios force limsup Q_N/N=∞. Thus (1) also holds in the extended sense. The case L=0 is immediate.

The strict rational lower bound c>1/5 needs no decimal estimate. Taylor's formula gives e²>Σ_{k=0}^8 2^k/k!=2327/315>59/8. Also 1/sqrt(2)<5/7, hence β<12/7. Consequently

c>(35/51)(317/413)²/2=502445/2485434>1/5.             (3)

## A certified upper bound for the actual diagonal constant

The elementary squarefree asymptotic, with every individual μ(n)² retained, gives

D_N/N→d=1/ζ(2) Σ_{q≥1} b(q)/[q(q+1)]<16/25.         (4)

For fixed q, the contributing squarefree indices occupy N/(q+1)<n≤N/q. The classical identity μ(n)²=Σ_{d²|n}μ(d) gives the squarefree count x/ζ(2)+O(sqrt(x)) by summation: the truncated absolutely convergent series Σ μ(d)/d² has tail O(1/sqrt(x)). Hence the count divided by N tends to 1/[ζ(2)q(q+1)]. For q>L0, contributing n satisfy n≤N/(L0+1); using μ²≤1 and b(q)≤log(2q+1), their normalized total is bounded by the decreasing Riemann-sum integral ∫₀^{1/(L0+1)}log(1+2/x)dx. This tends to zero uniformly in N and justifies the series limit. No RH input enters this squarefree asymptotic. Here is an exact rational certificate for the strict upper bound on the resulting constant.

The central-binomial recurrence gives

b(q)=Σ_{r=1}^q log(2r/(2r−1)).

For L0=2000, the first L0 terms of the series S in (4) telescope to

S_partial=Σ_{r=1}^{L0}(1/r−1/(L0+1))log(2r/(2r−1)).

Set z_r=1/(4r−1). The convergent atanh series, with positive terms, yields

log(2r/(2r−1))
 =2Σ_{k≥0} z_r^(2k+1)/(2k+1)
 ≤2z_r+2z_r³/[3(1−z_r²)].                          (5)

The tail is bounded by the full real-cell integral. Since b(q)≤log(2q+1), with a=1/(L0+1),

S_tail≤∫_0^a log(1+2/x)dx
 =a log(1+2/a)+2log(1+a/2)
 ≤a[log(2L0+3)+1]<11/(L0+1).                       (6)

For the last strict inequality, e>27/10 and (27/10)^10>4003=2L0+3 imply log(4003)<10. A lower bound for the denominator is

ζ(2)>Z0:=Σ_{n=1}^{100}1/n²+1/101,                  (7)

using the decreasing integral lower bound for the tail starting at n=101.

Thus d is strictly below the rational number

U=[Σ_{r=1}^{2000}(1/r−1/2001)
       {2z_r+2z_r³/[3(1−z_r²)]}+11/2001]/Z0.

Exact rational arithmetic verifies 16Z0−25{the numerator of U}>0, so U<16/25. The owned script `factorial-diagonal-constant-certificate.py` reproduces this inequality and every rational inequality in (3). It uses Python Fraction only for the certificates, with no floating-point or transcendental evaluation. This is a reproducible finite written-math certificate, not a claim of compiled Lean.

## The published actual oscillation supplies the contradiction

[Hurst, Computations of the Mertens Function and Improved Bounds on the Mertens Conjecture](https://arxiv.org/pdf/1610.08551), Theorem 6.1, published in Mathematics of Computation 87, 2018, proves

liminf_(x→∞) M(x)/sqrt(x)<−1.837625,
limsup_(x→∞) M(x)/sqrt(x)>1.826054.

In particular L>9/5. The step nature of M means the same absolute limsup holds over integers. Hurst's Theorem 4.2 is the Ingham finite-smoothed-sum inequality and explicitly does not assume RH. The oscillation theorem does not require global independence of zero ordinates. Its published computational analytic result is an external theorem input here; its zero data and lattice computation have not been recertified or formalized in this workspace.

Combining this actual input with (1), (3), and (4) gives

limsup Q_N/N> (1/5)(9/5)²=81/125,
d<16/25=80/125,

and therefore

limsup_(N→∞) (Q_N−D_N)/N>1/125.                    (8)

There are infinitely many actual integer cutoffs with Q_N>D_N. No particular violating cutoff is identified. The existence follows from the published asymptotic oscillation theorem and the derived energy coercivity, rather than finite energy computations. Earlier passing numerical tests of the diagonal hypothesis are compatible with this conclusion.

This closes the structural test of the coefficient-one diagonal conjecture. The residue budget remains a valid necessary consequence of a hypothetical strong bound, but it is unnecessary to evaluate arbitrarily many zero derivatives to rule out this particular hypothesis. Uniform Q_N=O(N) with a larger unspecified constant remains unrefuted by this argument, as does the RH-scale subpower target. No proof of actual RH is obtained.

All new energy, limsup, asymptotic, and rational-certification steps remain written mathematics awaiting Lean formalization. Hurst's external oscillation theorem is not a hidden RH assumption or an axiom introduced into Lean. The result must not be described as a complete Lean theorem until that input and every required analytic step are formalized.

RH Agent2 supplied the obstruction argument and rational script, with an independent Sol mathematical audit. The root independently reviewed the finite-L split, infinite-L record argument, full-weight coercivity, squarefree asymptotic and uniform tail, checked the exact rational inequalities, and read Hurst’s Theorems 4.2 and 6.1 directly. This is a new application of published Mertens oscillation to the specified factorial conjecture, not a new Mertens oscillation theorem or an unconditional RH advance.
