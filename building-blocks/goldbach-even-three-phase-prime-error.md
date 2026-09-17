# The even-Goldbach three-phase harmonic recovers the complete prime error

Written arithmetic proof and Lean formalization by RH Proof,
17 September 2026. A phase on the single
generator $3$, observed through **even additive totals** and centered by
the exact odd-lattice reference, recovers $\psi(N-3)-(N-3)$ with a
power-of-two correction and a bounded same-prime ladder. This is a
source-specific additive/multiplicative identity, not a proof of binary
Goldbach or RH. The resulting square-root bound for the signed harmonic
is equivalent to RH and remains unproved.

## The parity-aware centered triangle

Let $N\ge6$ be even. Define the completely multiplicative phase

\[
 \chi_\theta(3)=e^{i\theta},\qquad
 \chi_\theta(p)=1\quad(p\ne3),\qquad
 \chi_\theta(3^k)=e^{ik\theta}.
 \tag{1}
\]

Set $r(n)=2\mathbf1_{n\ {\rm odd}}$. The factor $2$ is the density
reference on the odd lattice; at $n=1$ the centered coefficient is
$\Lambda(1)-r(1)=-2$. Every actual Mangoldt weight, including proper
prime powers, remains in

\[
 \mathcal C^{\rm even}_\theta(N)=
 \sum_{\substack{a,b\ge1\\a+b\le N\\a+b\ {\rm even}}}
 [\Lambda(a)\chi_\theta(a)-r(a)]
 [\Lambda(b)\overline{\chi_\theta(b)}-r(b)],
 \qquad
 \mathfrak H^{\rm even}_1(N)=\frac1\pi\int_0^{2\pi}
    \mathcal C^{\rm even}_\theta(N)\cos\theta\,d\theta.
 \tag{2}
\]

The full ordered triangle and equality at $a+b=N$ are retained.
Swapping $a,b$ shows that $\mathcal C^{\rm even}_\theta$ is real.
The parity-aware reference is essential: centering by $1$ on each
odd index would leave a false order-$N$ density in the first harmonic.
The real-angle finite even-total centering algebra, with the actual
`vonMangoldt` weights and $r(n)$, is compiled in
[GoldbachEvenPhaseCenterFinite.lean](BuildingBlocks/GoldbachEvenPhaseCenterFinite.lean).
The same module proves the exact $N-2$ odd-partner reference at every
even terminal total. [GoldbachThreePhaseHarmonicFinite.lean](BuildingBlocks/GoldbachThreePhaseHarmonicFinite.lean)
formalizes the actual Mangoldt support classification for the two
surviving row types, the bound $d_N\le2$, and ordered-pair symmetry
of the algebraic first harmonic. [GoldbachThreePhaseEndpoint.lean](BuildingBlocks/GoldbachThreePhaseEndpoint.lean)
compiles the unique-partner reduction, the exact one-leg endpoint,
the odd/even prime-power split, the power-of-two count, and the final
finite regrouping into (5). The analytic Fourier-integral
identification remains a written proof.

## Exact first-harmonic extraction

Let $\nu_3(n)=v_3(n)$. The Fourier identity
$\pi^{-1}\int_0^{2\pi}e^{im\theta}\cos\theta\,d\theta
=\mathbf1_{m=1}+\mathbf1_{m=-1}$ gives

\[
 \mathfrak H^{\rm even}_1(N)=2\left[
  \sum_{\substack{a+b\le N\\a+b\ {\rm even}\\
                 \nu_3(a)=\nu_3(b)+1}}
    \Lambda(a)\Lambda(b)
  -(\log3)\sum_{\substack{1\le b\le N-3\\b\ {\rm odd}}}r(b)
 \right].
 \tag{3}
\]

The second sum is $2\#\{b\le N-3:b\text{ odd}\}=N-2$, since
$N-3$ is odd. The first sum has exactly two types of nonzero rows.
When $\nu_3(b)=0$, the first index is $a=3$ and $b$ is an odd
prime power with base different from $3$. When $\nu_3(b)=k\ge1$,
the pair is $(a,b)=(3^{k+1},3^k)$ and contributes only if
$4\cdot3^k\le N$. Thus no even prime power is discarded silently:
the powers of $2$ are absent from the even-total $3+b$ row by parity
and reappear explicitly below.

Put

\[
 P_2(x)=\sum_{\substack{j\ge1\\2^j\le x}}\log2,
 \qquad E(x)=\psi(x)-x,
 \qquad
 d_N=\#\{k\ge1:N/4<3^k\le N-3\}.
 \tag{4}
\]

The complete odd prime-power prefix is
$\psi_{\rm odd}(x)=\psi(x)-P_2(x)$. The zero-label row in (3) is
$(\log3)[\psi_{\rm odd}(N-3)
 -(\log3)\#\{k\ge1:3^k\le N-3\}]$.
The positive-label row has
$(\log3)^2\#\{k\ge1:4\cdot3^k\le N\}$.
Subtracting the two counts gives $-d_N$. Therefore the exact
even-total identity is

\[
 \boxed{\quad
 \mathfrak H^{\rm even}_1(N)
 =2\log3\,[E(N-3)-P_2(N-3)-1-(\log3)d_N].
 \quad}
 \tag{5}
\]

The terminal $-1$ comes from the odd-lattice endpoint:
$2\#\{b\le N-3:b\text{ odd}\}=N-2=(N-3)+1$.
It is not a negligible origin convention. The powers of two in
$P_2$ retain every even prime-power arrival, and the $3^k$ ladder
retains all same-generator interactions.

There are at most two powers of $3$ in
$(N/4,N-3]$: three would have ratio at least $9$, whereas this
interval has endpoint ratio less than $4$. Thus
$0\le d_N\le2$ and $P_2(N-3)=O(\log N)$. Equation (5) gives the
explicit reconstruction

\[
 \boxed{\quad
 E(N-3)=\frac{\mathfrak H^{\rm even}_1(N)}{2\log3}
       +P_2(N-3)+1+(\log3)d_N.
 \quad}
 \tag{6}
\]

All nonharmonic arithmetic has size $O(\log N)$, and the
same-generator correction is bounded independently of $N$.

## RH criterion and scope

The standard complete-prime-power criterion says RH is equivalent to
$E(x)=O_\varepsilon(x^{1/2+\varepsilon})$ for every $\varepsilon>0$.
Every odd integer $m\ge3$ is $N-3$ for an even $N=m+3$.
The difference between any $E(x)$ and the nearest odd-integer value
is $O(\log(2x))$, since at most two Mangoldt arrivals are crossed.
It follows from (6) that

\[
 \boxed{\quad
 \mathrm{RH}\quad\Longleftrightarrow\quad
 \mathfrak H^{\rm even}_1(N)
   =O_\varepsilon(N^{1/2+\varepsilon})
 \quad\text{for every }\varepsilon>0
 \text{ and every sufficiently large even }N.
 \quad}
 \tag{7}
\]

No positivity estimate for the signed harmonic in (7) is known here.
Ordinary binary Goldbach existence makes selected raw even
representation coefficients positive; it does not control the
centered angular coefficient in (3). The fixed generator $2$ in the
[all-total harmonic](goldbach-phase-first-harmonic-prime-error.md)
also recovers $E$ with a short ladder, but its main $2+$odd-prime
row has **odd** total. The generator $3$ and parity-aware reference
in (2) keep this consumer on even totals. Equations (3)–(7) are
written proofs. The finite parity-centered pair identity, reference
count, three-adic row classification, oriented algebraic harmonic,
short ladder bound, and exact arithmetic identity (5) for that
algebraic harmonic are compiled. The analytic Fourier extraction and
RH-equivalence step remain unformalized.

## Unconditional oscillation on the actual even totals

The [Hardy--Littlewood/Littlewood oscillation theorem](https://projecteuclid.org/journals/acta-mathematica/volume-41/issue-none/Contributions-to-the-theory-of-the-riemann-zeta-function-and/10.1007/BF02422942.pdf)
gives the actual complete-prime-power error
\[
 E(x)=\Omega_\pm\!\bigl(\sqrt x\log\log\log x\bigr).
 \tag{8}
\]
The half-weight convention at an integer prime power changes this by
at most $\tfrac12\log x$, so it does not affect (8). A nearest odd
integer $m$ is within one unit of $x$; because each von Mangoldt atom
is at most $\log(x+2)$, replacing $x$ by $m$ changes $E$ by
$O(\log(x+2))$. Consequently (8) holds along odd integers. Equation
(5), $P_2(m)\le\log m$, and $0\le d_{m+3}\le2$ then give
\[
 \boxed{\quad
 \mathfrak H^{\rm even}_1(N)
  =\Omega_\pm\!\bigl(\sqrt N\log\log\log N\bigr)
  \quad\text{through even }N.\quad}
 \tag{9}
\]
In particular **neither eventual sign** of the actual first harmonic
can hold. A proof of its RH-scale bound must control the size of both
oscillating signs, not seek a one-sided sign law.

There is also unconditional logarithmic smallness at many sparse even
totals. The [Morrill--Platt--Trudgian theorem](https://arxiv.org/html/1910.14203v3)
proves that the number $V_\psi(T)$ of sign changes of $E(x)$ up to $T$
is at least $c\log T$ for some $c>0$ and all large $T$. In any
two-unit interval $[m,m+2)$ with $m$ odd, $E$ decreases with slope
$-1$ between the two integer arrivals and jumps upward only at those
arrivals. Hence that interval contains at most four sign changes.
If it contains one, comparison with its left odd endpoint gives
$|E(m)|\le2+2\log(T+2)$: the drift costs at most two and the two
possible Mangoldt jumps cost at most $2\log(T+2)$. Thus, for large $T$,
\[
 \#\{\,N\le T+3:N\text{ even},\
      |\mathfrak H^{\rm even}_1(N)|\le C\log(T+2)\,\}
       \gg\log T                                             \tag{10}
\]
for an absolute $C$. At those same odd $m=N-3$, the actual prime error
satisfies $|E(m)|\ll\log T$. This is a strong **sparse** bound; it
does not approach the uniform estimate required for RH.

[GoldbachOddCrossing.lean](BuildingBlocks/GoldbachOddCrossing.lean)
compiles the exact complete-von-Mangoldt two-step increment, its
$2+2\log(m+2)$ absolute bound, and the near-zero bound when two odd
samples straddle a sign change. The external oscillation/counting
theorems, the real-to-odd sampling argument, and the analytic
identification of (2) with the algebraic first harmonic are written
inputs and remain Lean obligations. This corollary closes an eventual
first-harmonic sign route, but does not give a uniform prime-error
bound or RH.
