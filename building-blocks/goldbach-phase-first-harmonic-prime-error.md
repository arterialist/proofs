# The first centered Goldbach phase harmonic reconstructs the prime error

Written arithmetic proof, 17 September 2026. The complete prime-generator
phase has a first angular harmonic that recovers the actual Chebyshev error
$E(N)=\psi(N)-N$. A moving square-root prime band gives an explicit
$O_c(\sqrt N\log N)$ reconstruction error; the single generator $2$
has a bounded ladder correction. This is an exact additive/multiplicative
bridge: the angular
projection removes the critical prime-square main term found in the
[complex phase cut](goldbach-complex-prime-phase-square-transition.md).
An $N^{1+\varepsilon}$ bound for this **signed centered harmonic** is
equivalent to RH; no such bound is proved here. The construction uses
weighted prime-power Goldbach pairs over all totals, and does not assert
binary Goldbach existence for individual even integers.

## Complete centered source and its first harmonic

Let $N\ge4$ be an integer and $2\le z<N$. For every prime generator put
$\chi_\theta(p)=e^{i\theta}$ when $p\le z$ and $1$ otherwise, and extend
completely multiplicatively. Thus

\[
 \chi_\theta(n)=e^{i\Omega_z(n)\theta},\qquad
 \Omega_z(n)=\sum_{p\le z}v_p(n).
 \tag{1}
\]

Every von Mangoldt coefficient is retained, including $\Lambda(1)=0$
and all prime powers. Define the real, right-endpoint-inclusive
Hermitian centered triangle

\[
 \mathcal C_\theta(N)=
 \sum_{\substack{a,b\ge1\\a+b\le N}}
  (\Lambda(a)\chi_\theta(a)-1)
  (\Lambda(b)\overline{\chi_\theta(b)}-1),
 \qquad
 \mathfrak H_1(N,z)=\frac1\pi\int_0^{2\pi}
                \mathcal C_\theta(N)\cos\theta\,d\theta.
 \tag{2}
\]

The triangle is real by swapping $a,b$. Centering is at the complete
integer reference: the coefficient at $1$ in each factor is $-1$.
The finite cumulative triangle itself need not be nonnegative; its
positive heat transform is a different operation.
The exact finite real-angle expansion of the centered phase difference
is compiled in [GoldbachPrimePhaseCutFinite.lean](BuildingBlocks/GoldbachPrimePhaseCutFinite.lean),
theorem `centered_phase_difference`. Its one-leg factor is the actual
`vonMangoldt b - 1`, and it retains the two-active-coordinate term.
The angular projection and prime-power specialization below remain
written proofs.

For every integer $m$, Fourier orthogonality gives

\[
 \frac1\pi\int_0^{2\pi}e^{im\theta}\cos\theta\,d\theta
   =\mathbf1_{m=1}+\mathbf1_{m=-1}.
 \tag{3}
\]

Expanding the two centered factors **before** taking the harmonic,
and using the symmetry of the pair triangle, proves the exact finite
identity

\[
 \boxed{\quad
 \mathfrak H_1(N,z)=2\left[
   \sum_{\substack{a+b\le N\\
           \Omega_z(a)=\Omega_z(b)+1}}
       \Lambda(a)\Lambda(b)
   -\sum_{p\le z}(\log p)(N-p)
 \right].\quad}
 \tag{4}
\]

In the second term, $N-p$ is the exact number of allowed positive
partners for $p$; it includes the endpoint $a+b=N$. Formula (4)
preserves both orientations through the factor $2$. Its first term
includes every proper prime power: if both labels are positive, pairs
of adjacent exponents can contribute to this harmonic.

## Exact prime row and finite remainder

Let $\mathcal A_z(N)=\{p^k\le N:p\le z,\ k\ge1\}$ and

\[
 M_z(N)=\sum_{a\in\mathcal A_z(N)}\Lambda(a)
       =\sum_{\substack{p\le z,\ k\ge1\\p^k\le N}}\log p,
 \qquad \vartheta(z)=\sum_{p\le z}\log p.
 \tag{5}
\]

On the von Mangoldt support, label $\Omega_z=1$ means exactly an
ordinary prime $p\le z$. Split the first sum in (4) according to
$\Omega_z(b)=0$ or $\Omega_z(b)\ge1$. The zero-label row gives
$\sum_{p\le z}(\log p)\psi(N-p)$ after subtracting the partners
in $\mathcal A_z(N)$. The positive-label row consists of pairs
$(p^{k+1},q^k)$ with both bases at most $z$, including all allowed
additive endpoints. Thus, with $E(y)=\psi(y)-y$,

\[
 \boxed{\quad
 \mathfrak H_1(N,z)
 =2\sum_{p\le z}(\log p)E(N-p)+2(T_{\rm adj}-T_0),
 \quad}
 \tag{6}
\]

Here the two nonnegative interaction totals are exactly

\[
 \begin{aligned}
 T_0&=\sum_{p\le z}\ \sum_{\substack{b\in\mathcal A_z(N)\\p+b\le N}}
                   (\log p)\Lambda(b),\\
 T_{\rm adj}&=\sum_{\substack{a,b\in\mathcal A_z(N)\\a+b\le N\\
                            \Omega_z(a)=\Omega_z(b)+1}}
                   \Lambda(a)\Lambda(b).
 \end{aligned}
 \tag{6a}
\]

Each is at most $M_z(N)^2$ by
dropping the additive cutoff; hence

\[
 |\mathfrak H_1(N,z)-2\sum_{p\le z}(\log p)E(N-p)|
 \le4M_z(N)^2.
 \tag{7}
\]

For $p\le z<N$, the literal interval $(N-p,N]$ contains $p$
integers and $0\le\Lambda(n)\le\log N$. Therefore

\[
 |E(N-p)-E(N)|
 \le p(1+\log N).
 \tag{8}
\]

Combining (7)–(8) gives the finite reconstruction inequality

\[
 \boxed{\quad
 |\mathfrak H_1(N,z)-2\vartheta(z)E(N)|
 \le2(1+\log N)z\vartheta(z)+4M_z(N)^2.
 \quad}
 \tag{9}
\]

No prime number theorem, zero-free region or RH input is used in
(4)–(9); only the actual prime-power support, the trivial Mangoldt
bound and finite Fourier orthogonality enter. The term $4M_z^2$
retains the complete interaction of two active prime-power histories.

## Square-root cutoff and RH-scale reading

Fix $c>0$ and take $z=c\sqrt N$ for sufficiently large $N$.
Chebyshev gives $\vartheta(z)\asymp_c\sqrt N$, while the complete
active mass satisfies

\[
 M_z(N)\ll_c\sqrt N+N^{1/3}\log(2N)=O_c(\sqrt N).
 \tag{10}
\]

The prime and square packets are both included in (10); exponents
at least three give the smaller second term. Equation (9) becomes

\[
 \boxed{\quad
 \mathfrak H_1(N,c\sqrt N)
    =2\vartheta(c\sqrt N)E(N)+O_c(N\log N),
 \qquad
 E(N)=\frac{\mathfrak H_1(N,c\sqrt N)}
             {2\vartheta(c\sqrt N)}+O_c(\sqrt N\log N).
 \quad}
 \tag{11}
\]

The exact fixed-generator specialization is sharper. Set $z=2$ and
$N\ge4$. Then $\mathcal A_2(N)$ consists of all powers $2^k\le N$.
The interaction $T_0$ in (6) counts $2^k\le N-2$, while
$T_{\rm adj}$ counts $2^{k+1}+2^k=3\cdot2^k\le N$.
Thus, with

\[
 d_N^{(2)}=\#\{k\ge1:N/3<2^k\le N-2\},
 \qquad 0\le d_N^{(2)}\le2,
 \tag{11a}
\]

the complete exact row is

\[
 \boxed{\quad
 \mathfrak H_1(N,2)=2\log2\,[E(N-2)-(\log2)d_N^{(2)}].
 \quad}
 \tag{11b}
\]

Three powers of $2$ have endpoint ratio at least $4$, whereas the
interval in (11a) has ratio less than $3$, proving the bound on $d_N^{(2)}$.
This reconstructs $E(N-2)$ with a bounded error; $E(N)$ differs by at
most $O(\log N)$ across the two intervening integer arrivals. The
generator-$2$ row pairs $2$ with odd prime powers, so its main additive
totals are **odd**. The [parity-aware generator-$3$ consumer](goldbach-even-three-phase-prime-error.md)
gives the corresponding exact reconstruction using even totals.

Consequently, for any one fixed $c>0$,

\[
 \boxed{\quad
 \mathrm{RH}
 \quad\Longleftrightarrow\quad
 \mathfrak H_1(N,c\sqrt N)=O_{c,\varepsilon}(N^{1+\varepsilon})
 \text{ for every }\varepsilon>0.
 \quad}
 \tag{12}
\]

Likewise (11b) yields the fixed-generator criterion
$\mathrm{RH}\Longleftrightarrow
\mathfrak H_1(N,2)=O_\varepsilon(N^{1/2+\varepsilon})$
for every $\varepsilon>0$; its required upper bound is still open.

Indeed RH gives $E(N)=O_\varepsilon(N^{1/2+\varepsilon})$ and
the first line of (11) gives the harmonic estimate. Conversely the
second line gives the same all-$\varepsilon$ Chebyshev-error bound,
since $\sqrt N\log N=O_\varepsilon(N^{1/2+\varepsilon})$.
The integer bound extends to real $x$ using
$\psi(x)=\psi(\lfloor x\rfloor)$ and an $O(1)$ endpoint difference,
and the classical Chebyshev-error criterion then gives RH.

The equivalence is a **consumer** for a future arithmetic inequality,
not an unconditional harmonic estimate. Positivity of the uncentered
Hermitian cut controls its deterministic $N^{3/2}$ phase cost; the
centered first harmonic in (12) is signed, and subtracting its density
row is exactly where $E(N)$ enters. Ordinary binary Goldbach existence
only makes selected raw even coefficients positive and supplies no
upper bound for (12). The finite Fourier extraction, complete-history
remainder and analytic equivalence are written proofs. The exact
centered pair algebra is compiled, while Lean formalization of
the angular extraction and (4)–(12) remains open.
