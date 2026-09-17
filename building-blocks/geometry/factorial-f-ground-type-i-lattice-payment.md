# Type-I lattice payment and Möbius barrier for the full factorial-Picone score

RH Agent3, 2026-09-16. Independently checked by a mathematical worker and the supervising RH thread. **Status:** an unconditional partial payment of the actual-source score, not an RH criterion or a Lean formalization. The theorem below pays the **lattice defect** of the \(\Lambda=\mu*\log\) expansion at fixed power across all future dyadic blocks while preserving the actual \(F\), full clock, and endpoints. The continuous Type-I main and complementary divisor sum remain at the classical PNT/Mertens subpower scale. No RH-strength estimate for the complete score is proved.

Let
\[
\Phi_{Y,s}(x)=
\frac{j_s(\log(x/Y))^2{\bf1}_{x\ge Y}
-j_s(\log(x/(2Y)))^2{\bf1}_{x\ge2Y}}{xF(x)},
\qquad I_j=[M,2M),\ M=2^jY,
\tag{1}
\]
with \(Y\ge4\), \(j_s=h_0*\mathsf P_s\), \(h_0(t)=te^{-t/2}{\bf1}_{t\ge0}\), and the complete all-prime-power clock law. The score block is
\[
\mathcal J_{M,j}(Y,s)=\sum_{n\in I_j}\Lambda(n)\Phi_{Y,s}(n)-\int_{I_j}\Phi_{Y,s}(x)dx.
\tag{2}
\]
Half-open blocks keep an atom at \(2M\) in the next block; \(\Phi\) itself keeps the old \(Y\)-profile at \(2Y\), since the new profile vanishes there.

The unconditional bounds \(F\ge c_F>0\), \(|xF'/F|\le C_F\) on \(x\ge2\), \(\|j_s\|_\infty\le2/e\), and \(\operatorname{Lip}(j_s)\le1\) give, uniformly in \(s,Y,j\),
\[
\|\Phi_{Y,s}\|_{L^\infty(I_j)}\le C/M,\qquad
\operatorname{Var}_{I_j}\Phi_{Y,s}\le C/M.
\tag{3}
\]
For the derivative claim, \(j_s\) is a positive-probability convolution of the bounded Lipschitz seed \(h_0\); each logarithmic argument has derivative \(1/x\), and \(1/(xF)\) has derivative \(O(x^{-2})\) almost everywhere. The moving thresholds are continuous because \(j_s(0)=0\). No history or prime-power atom is removed.

## Exact truncated convolution and power-paid lattice defect

Fix \(1\le D<M\). Expanding the **actual** von Mangoldt identity \(\Lambda=\mu*\log\) on \(I_j\) and separating \(d\le D\) gives
\[
\begin{aligned}
\mathcal J_{M,j}
={}&\underbrace{\sum_{d\le D}\mu(d)\left[
\sum_{\substack{m\ge1\\dm\in I_j}}\log m\,\Phi_{Y,s}(dm)
-\frac1d\int_{I_j}\log(x/d)\Phi_{Y,s}(x)dx
\right]}_{\mathcal E_{\le D}(M)}\\
&+\underbrace{\int_{I_j}\Phi_{Y,s}(x)
\left[A_D\log x-B_D-1\right]dx}_{\mathcal M_D(M)}\\
&+\underbrace{\sum_{\substack{d>D,\ m\ge1\\dm\in I_j}}
\mu(d)\log m\,\Phi_{Y,s}(dm)}_{\mathcal H_D(M)},
\end{aligned}
\tag{4}
\]
where \(A_D=\sum_{d\le D}\mu(d)/d\) and \(B_D=\sum_{d\le D}\mu(d)\log d/d\). This is exact with all prime powers and block endpoints. The density \(-dx\) is the \(-1\) in \(\mathcal M_D\), not a missing source row.

**Proposition (uniform Type-I lattice payment).** For every \(D<M\),
\[
\boxed{\quad |\mathcal E_{\le D}(M)|\ll \frac{D\log(2M)}M.\quad}
\tag{5}
\]
Indeed for each \(d\le D\), \(f_d(x)=\log(x/d)\Phi_{Y,s}(x)\) on \(I_j\) satisfies
\(\|f_d\|_\infty+\operatorname{Var}_{I_j}f_d\ll\log(2M)/M\) by (3). Comparing its lattice sum at spacing \(d\) with \(d^{-1}\int f_d\), full cells cost their variation and the two partial endpoint cells cost at most \(2\|f_d\|_\infty\). The result is uniform in \(d\), so summing \(|\mu(d)|\le1\) proves (5). This is a genuine fixed-power payment on an arithmetically constrained sector, not an estimate for the complete Type-I sum including its continuous main.

Taking \(D_j=M^{1/2-\eta}\), \(0<\eta<1/2\), and summing (5) over **every** future block yields
\[
\boxed{\quad
\sum_{j\ge0}|\mathcal E_{\le D_j}(2^jY)|
\ll_\eta Y^{-1/2-\eta}\log(2Y).
\quad} \tag{6}
\]
Thus the small-divisor lattice defect is below the RH target with full clock and actual ground. The quotient layers \(d>D_j\) and the continuous main \(\mathcal M_{D_j}\) are not silently called paid.

## Why the continuous main and high divisors stay subpower

The conservative classical zero-free-region Mertens estimate
\[
M_\mu(x):=\sum_{n\le x}\mu(n)\ll x\Delta(x),
\qquad \Delta(x)=\exp(-c\sqrt{\log x})
\tag{7}
\]
(with an unspecified smaller \(c>0\)) gives by Abel summation
\[
A_D\ll \Delta_1(D),\qquad B_D+1\ll\Delta_1(D),
\quad \Delta_1(D)=\exp(-c_1\sqrt{\log D}).
\tag{8}
\]
The constant \(-1\) is the derivative at \(s=1\) of \(1/\zeta(s)\):
\(\sum_{d\ge1}\mu(d)\log d/d=-1\) in the convergent Abel sense. Consequently (3) bounds the continuous main by
\[
|\mathcal M_D(M)|\ll \log(2M)\Delta_1(D).
\tag{9}
\]
This is subpower, not \(M^{-\delta}\), when \(D=M^\theta\).

The complementary range has the same limitation even after switching divisors. In \(\mathcal H_D\), \(m\le2M/D\). For each \(m\), the allowed \(d\) lie in \((D,\infty)\cap[M/m,2M/m)\); partial summation in \(d\), (3), and (7) give
\[
\left|\sum_{\substack{d>D\\dm\in I_j}}\mu(d)\Phi_{Y,s}(dm)\right|
\ll \frac{\Delta_1(D)}m.
\]
Multiplication by \(\log m\) and \(\sum_{m\le2M/D}\log m/m\ll\log^2(2M)\) yield
\[
|\mathcal H_D(M)|\ll \log^2(2M)\Delta_1(D).
\tag{10}
\]
The estimate is uniform in the complete clock \(s\); it does not take absolute values over \(\mu(d)\) before the partial-summation cancellation. For \(D=M^{1/2-\eta}\), (5) is power-small, but (9)--(10) remain \(\exp[-c_\eta\sqrt{\log M}]\), exactly the classical PNT-quality barrier. The high-\(d\) range includes \(m\) very small as well as the balanced \(d,m\asymp\sqrt M\) region; declaring only the balanced range unresolved would be false.

For example, on the no-jump first block \(I_0=[Y,2Y)\), the single high-divisor fiber \(m=2\) is literally
\[
(\log2)\sum_{Y/2\le d<Y}\mu(d)\,
\frac{p_s^2Y\log^2(2d/Y)}{4d^2F(2d)}.
\tag{10a}
\]
It keeps the exact half-open endpoints and actual \(F\). This is a smooth dyadic Mertens correlation of size only \(\exp[-c\sqrt{\log Y}]\) by (7); no Type-II balance is needed to encounter the present arithmetic barrier. The complete \(\Lambda\) sum may still cancel this fiber against other \(m\), so (10a) is a method obstruction rather than a lower bound for the actual score.

The obstruction is mathematically sharp for this method. If one somehow had \(A_D=O(D^{-\delta})\) for a fixed \(\delta>0\), then Abel summation of
\[
\sum_{n\ge1}\frac{\mu(n)}{n^z}
=\sum_{n\ge1}\frac{\mu(n)}n\,n^{1-z}
\]
would analytically continue \(1/\zeta(z)\) to \(\Re z>1-\delta\), giving a fixed zero-free strip. Such a power estimate is not supplied by known PNT bounds. Conversely, a zero approaching \(\Re z=1\) is precisely the kind of mode that can keep the continuous Type-I main at subpower size. This identifies the arithmetic input missing from (9), rather than positing a sign for \(\mu\).

There is an additional full-score cancellation worth keeping exact. If one freezes \(F=\kappa_F\) only for a scale-invariance diagnostic, then
\[
\int_Y^\infty\Phi_{Y,s}(x)dx=0,\qquad
\int_Y^\infty\Phi_{Y,s}(x)\log x\,dx
=-\frac{\log2}{\kappa_F}\int_0^\infty j_s(t)^2dt.
\tag{11}
\]
Thus the global continuous Type-I main collapses to a multiple of \(A_D\), while the density main cancels. For the actual \(F\), the exact first integral is
\[
\int_0^\infty j_s(t)^2
\left[\frac1{F(Ye^t)}-\frac1{F(2Ye^t)}\right]dt,
\tag{12}
\]
which is controlled only at the PNT ground-convergence scale unconditionally. Equations (11)--(12) explain the signed advantage of the full \(Y\) versus \(2Y\) score but do not turn it into a fixed-power estimate.

The useful result is (6): one full-domain, all-clock, actual-\(F\) Type-I lattice sector is paid below the RH scale. The remaining continuous Möbius moments and switched high-divisor sums require arithmetic cancellation beyond (7). This note supplies no bound for the complete score \(J_Y(s)\) and assumes no RH premise.
