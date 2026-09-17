# Complete Bernstein exponents with theta growth and nonreal zeros

Meromorphy, zero drift, membership in $B_J$, the asymptotic $\phi(s)\sim16s/\log^2s$, and a double-exponential mixing tail do not force the associated entire function to have only real zeros. The family below proves this even for complete Bernstein functions, whose Lévy densities are completely monotone. The class $B_J$ requires only a nonincreasing Lévy density.

The family matches the leading exponent growth and the double-logarithmic mixing-tail rate of the [actual theta arcsine law](theta-arcsine-law.md). It does not match the exact theta law, its modular identities or its full tail equivalent. This is a written counterexample to a specified general real-zero mechanism, with no Lean formalization or conclusion about zeros of the actual xi function.

## The classical real-zero condition

Konstantopoulos, Patie and Sarkar prove that $\Psi(s)=s\phi(s)$ with $\phi\in B_J$ gives a van Dantzig function

$$
\mathcal J_\Psi(z)=\sum_{n=0}^\infty
\frac{(-1)^n z^{2n}}{n!\prod_{k=1}^n\phi(k)}.
$$

Their Theorem 4.4 gives a sufficient global real-zero condition: $\phi$ must be a Pick function with their meromorphic $1$-separation property for its zeros and poles. Proposition 4.7 gives order one and infinite type when $\Psi(s)=s^2/\ell(s)$ with $\ell$ slowly varying and divergent; it does not assert real zeros. Their Mittag–Leffler examples establish failure of real-zero behavior in the broader class, but have power growth and thus do not themselves match theta. See the published [KPS paper, Theorems 4.1 and 4.4, Proposition 4.7, §4.2.4, and Proposition 5.2](https://aif.centre-mersenne.org/item/10.5802/aif.3600.pdf). These numbering references are to the final 2024 paper.

## An explicit family with the required asymptotic

For an integer $N\ge3$, define

$$
\phi_0(s)=\frac32\frac{\Gamma(\frac32s+\frac32)}{\Gamma(\frac32s+1)},
\qquad
\chi_N(s)=32s\sum_{n=N}^\infty\frac{1}{(s+n)\log^3n},
\qquad
\phi_N=\phi_0+\chi_N,\qquad\Psi_N(s)=s\phi_N(s).
$$

Also write $\Psi_0(s)=s\phi_0(s)$ for the unperturbed exponent.

Let $I_N=\int_0^{T_N}e^{-S_t}dt$, where $S$ is the subordinator with exponent $\phi_N(s)-\phi_N(0)$ and $T_N$ is an independent exponential lifetime of rate $\phi_N(0)$. Thus $I_N$ is the exponential functional of the killed subordinator with exponent $\phi_N$.

**Theorem.** For every sufficiently large integer $N$, the following statements hold.

1. $\phi_N$ is a meromorphic complete Bernstein function, belongs to $B_J$, has zero drift, and satisfies $\phi_N(s)\sim16s/\log^2s$.
2. $\Psi_N$ has zero killing and largest nonnegative root zero. Its KPS function $\mathcal J_{\Psi_N}$ is an even entire characteristic function of order one and infinite exponential type, with at least one nonreal zero.
3. The associated subordinator exponential functional $I_N$ satisfies

$$
\lim_{t\to\infty}\frac{\log\log(1/\mathbb P(I_N>t))}{\sqrt t}=4.
$$

Thus its upper tail has the same double-exponential scale as the actual theta arcsine mixing law.

### Bernstein membership and the perturbation asymptotic

The gamma-ratio integral gives

$$
\phi_0(s)=\frac{3\sqrt\pi}{4}
+\int_0^\infty(1-e^{-sr})\nu_0(r)\,dr,
\qquad
\nu_0(r)=\frac{e^{-r}}{2\sqrt\pi(1-e^{-2r/3})^{3/2}}.
$$

The binomial expansion writes $\nu_0$ as a positive sum of decaying exponentials. It is completely monotone and satisfies Lévy integrability, since it is $O(r^{-3/2})$ at zero and decays exponentially at infinity. Thus $\phi_0$ is complete Bernstein. It has zero drift and $\phi_0(s)\sim(3/2)^{3/2}s^{1/2}$.

The formula for $\chi_N$ is a positive discrete Stieltjes representation of a complete Bernstein function. Equivalently its completely monotone Lévy density is

$$
\nu_N(r)=32\sum_{n=N}^\infty\frac{n e^{-nr}}{\log^3n}.
$$

Indeed $\int_0^\infty(1-e^{-sr})ne^{-nr}\,dr=s/(s+n)$. The Lévy integrability condition follows from $\sum_{n\ge N}1/(n\log^3n)<\infty$. Complete monotonicity implies that these densities are nonnegative and nonincreasing, as required for $B_J$.

For fixed $s\ge0$,

$$
0\le\chi_N(s)\le32s\sum_{n=N}^\infty\frac{1}{n\log^3n}
\le\frac{16s}{\log^2(N-1)}\longrightarrow0.
$$

The defining series converges uniformly on every complex compact set avoiding its poles $-N,-N-1,\ldots$. Thus $\chi_N$, and hence $\phi_N$, is meromorphic. To compute its positive-real asymptotic for fixed $N$, note that $x\mapsto((s+x)\log^3x)^{-1}$ is decreasing for $x>1$. Integral comparison gives

$$
0\le\chi_N(s)-32s\int_N^\infty\frac{dx}{(s+x)\log^3x}
\le\frac{32s}{(s+N)\log^3N}=O_N(1).
$$

Split the integral at $x=s$. Its part over $x\ge s$ is

$$
32s\int_s^\infty\frac{dx}{x\log^3x}
+O\left(s^2\int_s^\infty\frac{dx}{x^2\log^3x}\right)
=\frac{16s}{\log^2s}+O\left(\frac{s}{\log^3s}\right).
$$

The part over $N\le x\le s$ is $O(s/\log^3s)$. To see this, split again at $\sqrt s$; the lower portion is $O(\sqrt s)$ and on the upper portion $\log x\ge\frac12\log s$. Therefore $\chi_N(s)\sim16s/\log^2s$, and the smaller $\phi_0$ term does not change the asymptotic. In particular $\phi_N(s)/s\to0$, which verifies zero drift directly. Also $\phi_N(0)=3\sqrt\pi/4>0$, so $\Psi_N(0)=0$ and $\Psi_N(s)>0$ for every $s>0$.

### The limiting Mittag–Leffler function has nonreal zeros

The gamma factors telescope:

$$
\mathcal J_{\Psi_0}(z)
=\Gamma(3/2)\sum_{n=0}^\infty
\frac{(-z^2)^n}{\Gamma(\frac32n+\frac32)}
=\Gamma(3/2)E_{3/2,3/2}(-z^2).
$$

We can verify its nonreal zeros without locating any of them numerically. For $X>0$, deform the standard Hankel representation of $E_{3/2,3/2}(-X)$ to its negative-real branch cut. The two poles at $X^{2/3}e^{\pm2\pi i/3}$ contribute their residues, giving the exact formula

$$
E_{3/2,3/2}(-X)
=\frac43X^{-1/3}e^{-X^{2/3}/2}
\cos\left(\frac{\sqrt3}{2}X^{2/3}-\frac\pi3\right)
-\frac1\pi\int_0^\infty\frac{e^{-r}r^{3/2}}{X^2+r^3}\,dr.
$$

The starting representation is $(2\pi i)^{-1}\int e^w/(w^{3/2}+X)\,dw$. It is the $\alpha=\beta=3/2$ case of the general Hankel representation; see [Hilfer and Seybold, equation (15)](https://www2.icp.uni-stuttgart.de/~hilfer/publikationen/html/ITSF-2006-17-637/ITSF-2006-17-637.S2.html). The branch-cut difference gives the negative integral above. Dominated convergence in that integral proves

$$
\mathcal J_{\Psi_0}(x)\sim-\frac{3}{8x^4}\qquad(x\to\pm\infty).
$$

It therefore has only finitely many real zeros. Its coefficient formula and Stirling's formula give entire order $4/3$. If it had only finitely many zeros in total, Hadamard factorization would express it as a polynomial times $e^{az+b}$. Evenness forces $a=0$, contradicting its nonzero value at zero and its decay on the real axis. It has infinitely many nonreal zeros.

### Persistence after the growth-changing perturbation

For every fixed positive integer $k$, $\phi_N(k)\to\phi_0(k)$ as $N\to\infty$. Since $\phi_N(k)\ge\phi_0(k)>0$, the series on $|z|\le R$ are dominated term by term by the convergent positive series $\mathcal J_{\Psi_0}(iR)$. Thus

$$
\mathcal J_{\Psi_N}\longrightarrow\mathcal J_{\Psi_0}
\quad\text{uniformly on every complex compact set}.
$$

Choose a small closed disk around one nonreal zero of the limiting function, disjoint from the real axis and with no zero on its boundary. Rouché's theorem implies that the disk contains a zero of $\mathcal J_{\Psi_N}$ for every sufficiently large $N$. This proves nonreal zeros for the family with the changed asymptotic, rather than merely invoking the differently growing limiting example.

The coefficient denominator satisfies

$$
\log\left(n!\prod_{k=1}^n\phi_N(k)\right)
=2n\log n-2n\log\log n+n(\log16-2)+o(n).
$$

The usual coefficient formulas for entire order and type now give order one and infinite type. This also follows from KPS Proposition 4.7. The characteristic-function assertion can also be read directly from the moments below. Let $A$ have the arcsine density $1/(\pi\sqrt{4-x^2})$ on $(-2,2)$, independently of $I_N$. Since $\mathbb E A^{2n}=(2n)!/(n!)^2$, the characteristic function of $\sqrt{I_N}A$ is exactly $\mathcal J_{\Psi_N}$. The positive series at $iR$ converges for every $R$, justifying the moment expansion and its entire continuation. Membership in $B_J$ additionally supplies the van Dantzig property through KPS Theorem 4.1 and Proposition 5.2.

### The double-exponential mixing tail

Let $m_n=\mathbb E I_N^n$. The classical exponential-functional recurrence gives

$$
m_n=\prod_{k=1}^n\frac{k}{\phi_N(k)},\qquad
\frac1n\log m_n=2\log\log n-\log16+o(1),
\qquad m_n^{1/n}\sim\frac{\log^2n}{16}.
$$

Fix $0<\varepsilon<1$. In Markov's inequality choose $n=\lfloor\exp(4(1-\varepsilon)\sqrt t)\rfloor$. Then $m_n^{1/n}/t\to(1-\varepsilon)^2<1$, so for some $c_\varepsilon>0$ and all sufficiently large $t$,

$$
\mathbb P(I_N>t)\le m_n/t^n\le e^{-c_\varepsilon n}.
$$

This proves the lower bound $4(1-\varepsilon)$ for the limiting double-logarithmic rate. For the other bound take $n=\lceil\exp(4(1+\varepsilon)\sqrt t)\rceil$. Then $(m_n/2)^{1/n}>t$ eventually. Paley–Zygmund applied to $I_N^n$ gives

$$
\mathbb P(I_N>t)\ge\frac{m_n^2}{4m_{2n}}.
$$

The displayed moment asymptotic shows $\log m_{2n}-2\log m_n=o(n)$. Consequently the right side is at least $e^{-n}$ for sufficiently large $n$. This proves the upper bound $4(1+\varepsilon)$. Letting $\varepsilon\downarrow0$ proves the claimed limit. Equivalently,

$$
\mathbb P(I_N>t)=\exp\{-\exp[(4+o(1))\sqrt t]\}.
$$

## The remaining structural distinction

This family has both the Pick property and meromorphic continuation. What it lacks is KPS's additional $1$-separation property. Every point $-n$, $n\ge N$, is a genuine pole of $\chi_N$, with residue

$$
\operatorname{Res}_{s=-n}\chi_N(s)=-\frac{32n}{\log^3n}<0.
$$

The poles of $\phi_0$ are $-1-2m/3$, $m=0,1,\ldots$, and their residues are negative too. Thus coincident poles cannot cancel on addition. In particular $\phi_N$ has a pole at every sufficiently large negative integer.

KPS's $1$-separation condition writes the interlacing poles as $\rho_k=z_k-1>z_{k+1}$, where the zeros are ordered down the negative real axis. Consequently $\rho_{k+1}=z_{k+1}-1<\rho_k-1$: consecutive poles must be more than one unit apart. The pole lattice just established contradicts this requirement. The exact leading asymptotic and double-exponential tail scale do not impose the missing separation.

For comparison, the actual theta mixing law has the sharper equivalent

$$
\mathbb P(I_\theta>t)\sim\frac{4\sqrt2\pi^2}{Z}t^{1/4}
\exp\!\left(7\sqrt t-\pi e^{4\sqrt t}\right),
\qquad Z=2\int_0^\infty\Phi(u)du.
$$

Only its double-logarithmic rate $4$ has been matched here. No match is asserted for its killing value, finite coefficient data, modular identities, exact tail equivalent or the particular quotient $F(s)/F(s+1)$ defining the natural theta exponent. The theorem establishes that $B_J$ membership, zero drift, the exact leading exponent asymptotic, order one of infinite type, and the leading double-exponential mixing-tail scale do not by themselves give a global Laguerre–Pólya mechanism.

The proof uses classical complete Bernstein representations, the Mittag–Leffler Hankel formula, Hadamard factorization, Rouché's theorem and the Markov and Paley–Zygmund inequalities. For Bernstein representations and their uniqueness see Schilling, Song and Vondraček, [*Bernstein Functions: Theory and Applications*](https://motapa.de/bernstein_functions/index.shtml), Chapters 3 and 6. The exponential-functional recurrence is treated by Patie and Savov in [*Bernstein-gamma functions and exponential functionals of Lévy processes*](https://arxiv.org/abs/1604.05960). The KPS theorem numbers above refer to Konstantopoulos, Patie and Sarkar, *Annales de l’Institut Fourier* **74** (2024), 377–421. No priority claim is made.
