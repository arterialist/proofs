# Prime-power discrepancy gives a relative trace-norm growth bound

This note consumes the exact Fourier-column and trace-norm estimate (9) in [signed scattering tail energy](signed-scattering-tail-energy.md). It improves the discrepancy exponent obtained by finite-measure Hölder transport. The test remains fixed, the gamma factor is retained, and the actual product over $p\le X$ keeps every power $p^k>X$.

Let
$$
\widehat U_X=U_X R V_{\log X}^+,
\qquad N_\chi(U)=\|M_\chi(P-U^*PU)\|_1,
$$
with the [stable rational factor](rational-scattering-pole-factor.md) and [continuum counterphase](continuum-scattering-counterphase.md). The Hardy projection and full finite trace domain are fixed in the [semilocal foundation](semilocal-weighted-scattering.md). This is a written analytic theorem, not a Lean formalization. Let $\chi$ be a fixed real Schwartz function. For an actual compact pole-null test $f$, one may take $\chi=|\widehat f|^2$; its signed readout remains exactly $Q(f)$ once the support cutoff is large enough.

## 1. The theorem and its dependence on the discrepancy exponent

Suppose, for some fixed $\beta\ge1/2$ and real $m$,
$$
|E_\psi(x)|:=|\psi(x)-x|
 \le C x^\beta(\log x)^m,\qquad x\ge2.
\tag{1}
$$
Put $\alpha=\beta-1/2$, $A=\log X$, $a_0=\log2$, and assume $X\ge e$. Define the explicit majorant
$$
\begin{aligned}
\mathfrak B_{\alpha,m}(A)={}&1+e^{\alpha A}A^{m+3/2}
 +\int_{a_0}^A e^{\alpha a}a^{m+3/2}da\\
 &+\left(\int_{a_0}^A e^{2\alpha a}a^{2m-2}da\right)^{1/2}.
\end{aligned}
\tag{2}
$$
Then
$$
\boxed{N_\chi(\widehat U_X)
 \le C_{\chi,C,\beta,m}\,[1+\log X+\mathfrak B_{\alpha,m}(\log X)].}
\tag{3}
$$
In particular, for the usual logarithmic-error convention $m\ge0$,
$$
\boxed{
N_\chi(\widehat U_X)=
\begin{cases}
O_{\chi,C,\beta,m}\bigl(X^{\beta-1/2}(\log X)^{m+3/2}+\log X+1\bigr),
 &\beta>1/2,\$$2mm]
O_{\chi,C,m}\bigl((\log X)^{m+5/2}+\log X+1\bigr),
 &\beta=1/2.
\end{cases}}
\tag{4}
$$
Constants in the first line need not stay bounded as $\beta\downarrow1/2$; (2) is the expression that remains valid without suppressing this dependence. For arbitrary real $m$, (2) gives the same first line when $\beta>1/2$. At $\beta=1/2$, its growth is $O(A^{m+5/2})$ if $m>-5/2$, $O(1+\log A)$ if $m=-5/2$, and $O(1)$ if $m<-5/2$, before adding the retained $O(\log X)$ power tail.

Thus the square-root discrepancy input $E_\psi(x)=O(\sqrt x\log^2x)$ gives a $O_\chi((\log X)^{9/2})$ relative norm bound. This is an implication from that discrepancy input, not a proof of it. No converse is used here.

## 2. Complete cutoff first, admitted-prime tail second

Write the growing arithmetic phase as
$$
\begin{aligned}
\theta_X(t)={}&2\int_0^A e^{a/2}\frac{\sin(at)}a da
 -2\sum_{2\le n\le X}\frac{\Lambda(n)}{\sqrt n\log n}\sin(t\log n)\\
 &-2\sum_{\substack{p\le X,\ k\ge2\\p^k>X}}
 \frac{p^{-k/2}}k\sin(kt\log p).
\end{aligned}
\tag{5}
$$
This identity retains the full local factor for every admitted prime. The first line is a complete prime-power cutoff, including $n=X$ whenever $X$ is a prime power. The second line is precisely the omitted tail needed to recover the actual $p\le X$ product.

The fixed interval $0<a<a_0$ in the continuum phase is absorbed into a fixed multiplier $U_0$, together with the shifted gamma factor
$$
\pi^{-it}\Gamma(5/4+it/2)/\Gamma(5/4-it/2).
$$
Its weighted defect is trace class. One direct justification for the origin phase is
$$
\|M_\chi[P,M_{\sin(at)}]\|_1\le C_\chi(\sqrt a+a),
$$
proved by the weighted interval argument in [signed scattering phase transport](signed-scattering-phase-transport.md). Multiplication by $e^{a/2}/a$ is then integrable at zero. The atom at $a_0$, corresponding to $p=2$, is included in the varying part, not in this fixed continuum factor.

The tail in the second line of (5) has weighted phase-commutator norm bounded by
$$
C_\chi\sum_{p\le X,k\ge2}
\frac{p^{-k/2}}k\bigl(k\log p+\sqrt{k\log p}\bigr)
 =O_\chi(\log X).
\tag{6}
$$
This is the already proved full proper-power estimate; restricting it to $p^k>X$ only decreases its majorant. It includes every $k$, and the geometric sums converge for each fixed prime. Duhamel then bounds the defect norm of this tail multiplier by (6). No claim of cancellation inside that tail is required for (3).

It remains to estimate the signed complete-cutoff measure
$$
\mu_X^c(da)=1_{[a_0,A]}(a)e^{a/2}da
 -\sum_{2\le n\le X}\Lambda(n)n^{-1/2}\delta_{\log n}(da).
\tag{7}
$$
In Stieltjes notation it is exactly
$\mu_X^c(da)=-e^{-a/2}dE_\psi(e^a)$, with the lower atom included.

## 3. A signed tail estimate in the history variable

For $j=0,1,2$, set
$$
T_{j,r}(t)=\int_{[r,\infty)}\frac{(a-r)^j}{a}e^{iat}\mu_X^c(da),
\qquad 0<r<A.
\tag{8}
$$
There is no tail for $r>A$. The claim needed for the operator bound is
$$
\boxed{\|T_{j,\cdot}(t)\|_{L^2(0,A)}
 \le C_{C,\beta,m}(1+|t|)\mathfrak B_{\alpha,m}(A),
 \qquad j=0,1,2.}
\tag{9}
$$
Here the signed arithmetic integral is estimated after Stieltjes integration by parts. Replacing $\mu_X^c$ by its total variation before this step would lose the power $X^{\beta-1/2}$.

For clarity, retain the endpoints explicitly. Put $\ell=\max(r,a_0)$ and
$$
F_j(a,r,t)=e^{(-1/2+it)a}\frac{(a-r)^j}{a}.
$$
For almost every $r$, (8) equals
$$
\begin{aligned}
T_{j,r}(t)={}&-E_\psi(X)F_j(A,r,t)
 +E_\psi(e^\ell-)F_j(\ell,r,t)\\
 &+\int_\ell^A E_\psi(e^a)\partial_aF_j(a,r,t)da.
\end{aligned}
\tag{10}
$$
The left limit in the lower term is required when its endpoint is an atom. In particular $E_\psi(2-)=-2$. The upper term uses $E_\psi(X)$, so a prime power at $X$ is included. The countably many history endpoints $r=\log n$ are immaterial to the $L^2(dr)$ norm, but can also be treated with these same left limits.

The upper endpoint in (10) has $L^2(dr)$ norm at most
$$
C e^{\alpha A}A^{m-1}
 \left(\int_0^A(A-r)^{2j}dr\right)^{1/2}
 =\frac{C}{\sqrt{2j+1}}e^{\alpha A}A^{m+j-1/2}.
\tag{11}
$$
For $r<a_0$, the lower endpoint has a norm bounded by a fixed constant, since its discrepancy value is $-2$. For $r\ge a_0$ it vanishes when $j\ge1$. For $j=0$, its norm is bounded by
$$
C\left(\int_{a_0}^A e^{2\alpha r}r^{2m-2}dr\right)^{1/2}.
\tag{12}
$$
The assumed bound also holds at left limits by taking limits from below.

Finally,
$$
\begin{aligned}
|E_\psi(e^a)\partial_aF_j|
\le C e^{\alpha a}\big[&
 (\tfrac12+|t|)a^{m-1}(a-r)^j\\
 &+j a^{m-1}(a-r)^{j-1}
 +a^{m-2}(a-r)^j\big].
\end{aligned}
\tag{13}
$$
The middle term is absent for $j=0$. Minkowski's inequality in $L^2(dr)$, followed by
$$
\|1_{0<r<a}(a-r)^j\|_2=\frac{a^{j+1/2}}{\sqrt{2j+1}},
$$
bounds the integral term by
$$
C(1+|t|)\int_{a_0}^A e^{\alpha a}
 \bigl(a^{m+j-1/2}+a^{m+j-3/2}\bigr)da.
\tag{14}
$$
All powers in (11)–(14) are bounded by (2), up to constants depending on the fixed lower endpoint and $m$. This proves (9). The proof gives a signed $L^2$-history estimate, rather than a pointwise total-variation estimate of the prime measure.

## 4. Consuming the exact operator columns

Let $b_0(t)=(1+t^2)\chi(t)-\chi''(t)$. The exact signed-tail energy for (7) is
$$
\mathcal J_\chi(\mu_X^c)=\int_{\mathbb R}
 \|b_0(t)T_{0,\cdot}(t)-2i\chi'(t)T_{1,\cdot}(t)
       +\chi(t)T_{2,\cdot}(t)\|_{L^2(dr)}^2dt.
$$
Therefore (9) gives
$$
\mathcal J_\chi(\mu_X^c)^{1/2}
\le C_{C,\beta,m}\mathfrak B_{\alpha,m}(A)
 \left(\int(1+|t|)^2
 (|b_0(t)|+2|\chi'(t)|+|\chi(t)|)^2dt\right)^{1/2}.
\tag{15}
$$
This keeps the actual column combination before bounding it and requires only finitely many Schwartz seminorms. Every integral is finite for a fixed cutoff. In particular the trace-class factorization and Duhamel estimate from the signed-tail note apply without an additional limiting-domain assumption.

They imply
$$
N_\chi\left(\exp\left[2i\int\sin(at)\mu_X^c(da)/a\right]\right)
 \le\sqrt{\pi/24}\,\mathcal J_\chi(\mu_X^c)^{1/2}.
$$
Adding the fixed $U_0$ and the exact power tail (6) by the conjugated commuting-multiplier cocycle proves (3). Evaluating the elementary integrals in (2) gives (4).

The improvement over Hölder transport is specific: the signed discrepancy is inserted into the full tails before their $L^2(dr)$ norm is taken. At the square-root discrepancy threshold the resulting operator growth is polynomial in $\log X$; there is no geometric-mean factor involving the unsigned mass $\asymp\sqrt X/\log X$. This supplies a conditional quantitative norm criterion on the original pole-null test class. It does not itself prove the discrepancy hypothesis or the sharp positive jump gap.


The [single-observation converse](single-observation-scattering-criterion.md) detects off-line poles from a subpower bound for this same operator. The two notes together prove an RH equivalence; neither establishes its missing unconditional subpower estimate.
