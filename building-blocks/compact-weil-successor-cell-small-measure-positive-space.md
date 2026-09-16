# A positive successor-cell space with an actual prime edge

The [successor-cell refinement](compact-weil-successor-cell-refinement.md)
tiles the complete Weil window and retains every floor-division child.
Its full matrix is not known to be positive. A support-measure bound does
give a uniform sign on less sparse cell families: the cells fill fixed
spatial intervals, and two such intervals can carry a nonzero actual
prime edge. The bound below includes the gamma multiplier, both pole
moments, and every admitted prime power. It is a local support theorem,
not a sign for the whole successor-cell matrix or an RH result.

Use the notation of that refinement. Thus
\(L_N=\frac12\log(N+1)\),
\(I_n=(L_N-\log(n+1),L_N-\log n]\), and
\(f_z=\sum_{n=1}^N z_n\mathbf 1_{I_n}\). Put
\[
 H(t)=\Re\psi(1/4+it/2)-\log\pi,\qquad
 q(t)=H(t)-\log\frac{|t|}{2\pi},\qquad
 Q_-:=\int_{\mathbb R}\max\{-q(t),0\}\,dt<\infty.
 \tag{1}
\]
The last finiteness follows from the integrable logarithmic singularity
at zero and the [digamma expansion](https://dlmf.nist.gov/5.11.E2)
at infinity. If \(A\) is a nonempty
set of cell labels, let \(S_A=\bigcup_{n\in A}I_n\),
\(\mu_A=|S_A|\), and
\(D_A=\sup S_A-\inf S_A\). Define the complete finite arithmetic
budget
\[
 \mathcal P_N(D)=2\sum_{\substack{2\le d\le N\\\log d\le D}}
                \frac{\Lambda(d)}{\sqrt d}.
 \tag{2}
\]

**Theorem (finite-cell support bound).** For every \(N\ge2\) and
every complex vector \(z\) supported on \(A\), the complete compact
Weil form satisfies
\[
 \boxed{\quad
 Q_{L_N}(f_z)\ge
 \left[\log\frac1{2\mu_A}-1
       -\frac{\mu_A Q_-}{2\pi}
       -2\mu_Ae^{D_A/2}
       -\mathcal P_N(D_A)\right]\|f_z\|_2^2.
 \quad} \tag{3}
\]
For any fixed diameter bound \(D_0\), the bracket is positive once
\(\mu_A\) is sufficiently small, uniformly in \(N\) and the phases
of all cell values. The cutoff \(d\le N\) in (2) is exact; no prime
power is suppressed.

Here is the proof. If \(f_z\ne0\), its Plancherel density
\(\rho(t)=|\widehat f_z(t)|^2/(2\pi\|f_z\|_2^2)\) has total mass one.
Cauchy--Schwarz on its support gives
\(0\le\rho(t)\le\mu_A/(2\pi)\). Among densities with this ceiling,
the integral of the radially increasing function
\(\log(|t|/(2\pi))\) is smallest when the ceiling fills
\(|t|\le\pi/\mu_A\). Subtracting the logarithm's value at that
endpoint proves this directly: inside the interval both the weight
and the density difference are nonpositive, and outside both are
nonnegative. Direct integration therefore gives
\[
 \frac1{2\pi}\int_{\mathbb R}
       \log\frac{|t|}{2\pi}|\widehat f_z(t)|^2dt
 \ge\left(\log\frac1{2\mu_A}-1\right)\|f_z\|_2^2.
 \tag{4}
\]
The negative part of \(q\) costs at most
\(\mu_AQ_-\|f_z\|_2^2/(2\pi)\). The gamma integral is finite for
each cell step function, so these bounds apply to its actual value.

Both pole moments obey Cauchy--Schwarz on \(S_A\):
\[
 \left|2\Re(E_+(f_z)\overline{E_-(f_z)})\right|
 \le 2\|f_z\|_2^2
 \left(\int_{S_A}e^x dx\int_{S_A}e^{-x}dx\right)^{1/2}
 \le2\mu_Ae^{D_A/2}\|f_z\|_2^2.                 \tag{5}
\]
The [exact child rows](compact-weil-successor-cell-refinement.md)
give the prime term as
\[
 2\Re\sum_{d=2}^N\frac{\Lambda(d)}{\sqrt d}
        \sum_{r=d}^N\ell_r\overline{z_r}z_{\lfloor r/d\rfloor}
 =2\Re\sum_{d=2}^N\frac{\Lambda(d)}{\sqrt d}
        \langle f_z,U_{-\log d}f_z\rangle.          \tag{6}
\]
An overlap in (6) requires \(\log d\le D_A\), and each correlation
has absolute value at most \(\|f_z\|_2^2\) by translation
unitarity. This proves the arithmetic loss (2), with all child cells
and the terminal truncation retained. Combining (4)--(6) proves (3).

## Two intervals coupled by the actual prime two

Fix a real \(a\), choose
\(0<\eta<\log(3/2)\), and set
\[
 J=(a,a+\eta),\qquad S=J\cup(J+\log2),\qquad
 A_N=\{n\le N:I_n\subset S\}.                     \tag{7}
\]
For all sufficiently large \(N\), these cells lie inside the Weil
window. If \(f_z\) is supported on \(A_N\), write its two island
pieces as \(f_1+f_2\). Since the difference set of \(S\) meets
\(\{\log d:d\ge2\}\) only at \(\log2\), the complete prime term
contains exactly the \(d=2\) row. Its absolute value is at most
\[
 \frac{2\log2}{\sqrt2}
       |\langle f_1,U_{-\log2}f_2\rangle|
 \le\frac{\log2}{\sqrt2}\|f_z\|_2^2.          \tag{8}
\]
The total support measure is at most \(2\eta\). On the containing
set \(S\), the exact weight integrals in (5) give the sharper pole
bound \(6\sqrt2\sinh(\eta/2)\|f_z\|_2^2\). Consequently
\[
 \boxed{\quad Q_{L_N}(f_z)\ge\beta(\eta)\|f_z\|_2^2,
 \quad
 \beta(\eta)=\log\frac1{4\eta}-1
    -\frac{\eta Q_-}{\pi}
    -6\sqrt2\sinh(\eta/2)
    -\frac{\log2}{\sqrt2}.
 \quad}                                                \tag{9}
\]
Because \(Q_-<\infty\), \(\beta(\eta)>0\) for every sufficiently
small fixed \(\eta>0\). This signs every complex vector in the two
island cell family while allowing the prime-two interaction its
worst phase. The two pole moments are not assumed positive.

This family is spatially filled, unlike the resolved packets. Its
dimension is
\[
 |A_N|=\frac32e^{-a}(1-e^{-\eta})\sqrt{N+1}+O(1),
 \tag{10}
\]
and its cell mesh tends to zero throughout both intervals. Cell
averages therefore approximate every fixed smooth test supported
inside \(S\) in the logarithmic gamma form topology, by the
moving-window argument in the successor-cell refinement. For the
coherent cell values \(z_n=1\) on \(A_N\), the \(d=2\) correlation
tends to \(\eta\) and the norm squared tends to \(2\eta\); hence the
actual prime cost in (8) is attained asymptotically. Reversing one
island's sign reverses that prime contribution, so the proof does
not invoke a pointwise sign or a Markov rule.

The coherent full-window vector \(z_n=1\) has zero cell graph energy,
but its complete prime row is
\(2\sum_{d=2}^N\Lambda(d)d^{-1/2}\log((N+1)/d)>0\) and its pole is
\(8(e^{L_N}-2+e^{-L_N})>0\). Its support measure and diameter grow
with \(N\), so (3) gives no sign there. Thus a graph-energy-only or
pointwise Markov argument would fail this test, whereas (3) makes no
such assertion. The
[actual finite-history counterexample](finite-history-full-weil-monotonicity-obstruction.md)
also remains intact: (3) is a direct support and Fourier bound, not
monotonicity under a scattering history. Its negative high-frequency
comparison concerns \(Q(V_{p,M}f_t)-Q(f_t)\), while (3) concerns the
absolute sign of each sufficiently localized test. The two-island family fills
only two short fixed intervals and cannot yield positivity on all
smooth compact tests. Equations (3) and (9) are written inequalities;
no Lean formalization is claimed.
