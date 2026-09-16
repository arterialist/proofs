# A spatial bound for the localized prime-shift operator

In [Suzuki's Fourier formula](https://arxiv.org/html/2606.09096v1), §2.4, the prime contribution to the Weil form on \(I_a=(-a,a)\) is \(-\langle f,P_af\rangle\), where zero extension is understood and
\[
 (P_af)(x)=\sum_{\log n<2a}\frac{\Lambda(n)}{\sqrt n}
 \bigl(f(x+\log n)+f(x-\log n)\bigr),\qquad x\in I_a.
\tag{1}
\]
Terms touching an interval endpoint have zero quadratic-form contribution. The sign in the full form is minus; \(P_a\) itself is a self-adjoint operator with nonnegative off-diagonal kernel, though it need not be positive semidefinite.

Let \(\phi(x)=\cosh(x/2)>0\), and define \(\Psi(X)=\sum_{n<X}\Lambda(n)\) and \(H(X)=\sum_{n<X}\Lambda(n)/n\). For every \(|x|<a\), direct substitution into (1) gives the **exact** identity
\[
\begin{aligned}
 2(P_a\phi)(x)={}&e^{x/2}\{\Psi(e^{a-x})+H(e^{a+x})\}\\
 &+e^{-x/2}\{H(e^{a-x})+\Psi(e^{a+x})\}.
\end{aligned}
\tag{2}
\]
Consequently, with the finite, explicitly computable constant
\[
 C_a=\operatorname*{ess\,sup}_{|x|<a}\frac{(P_a\phi)(x)}{\phi(x)},
\]
the weighted Schur inequality gives
\[
 \boxed{\|P_a\|_{L^2(I_a)\to L^2(I_a)}\le C_a.}
\tag{3}
\]
The essential supremum is a finite calculation. Between consecutive points \(x=|a-\log n|\) for \(\log n<2a\), the two cutoff sets in (2) are fixed. There \((P_a\phi)/\phi=(Ue^x+V)/(e^x+1)\) with constants \(U,V\), so its derivative has the fixed sign of \(U-V\). Hence \(C_a\) occurs as a one-sided limit at one of those finitely many points or at an interval endpoint.
Indeed \(|\langle f,P_af\rangle|\le\langle |f|,P_a|f|\rangle\), and applying
\(2|f(x)f(y)|\le \phi(y)|f(x)|^2/\phi(x)+\phi(x)|f(y)|^2/\phi(y)\)
to each symmetric shift gives \(\langle |f|,P_a|f|\rangle\le\int (P_a\phi/\phi)|f|^2\). Testing on \(\phi\) also yields
\[
 \operatorname*{ess\,inf}_{|x|<a}\frac{(P_a\phi)(x)}{\phi(x)}
 \le \|P_a\|\le C_a.
\tag{4}
\]
More precisely, writing \(\ell_n=\log n\) and \(w_n=\Lambda(n)/\sqrt n\), one has the exact weighted graph identity
\[
 \int_{I_a}\frac{P_a\phi}{\phi}|f|^2dx-\langle f,P_af\rangle
 =\sum_{\ell_n<2a}w_n\int_{-a}^{a-\ell_n}
 \phi(x)\phi(x+\ell_n)
 \left|\frac{f(x)}{\phi(x)}-\frac{f(x+\ell_n)}{\phi(x+\ell_n)}\right|^2dx.
\tag{5}
\]
This states exactly what is lost when the prime shifts are replaced by their weighted row sums.

The prime number theorem makes (3) asymptotically sharp:
\[
 \boxed{\|P_a\|=(1+o(1))e^a\qquad(a\to\infty).}
\tag{6}
\]
To see the uniformity needed here, fix \(\varepsilon>0\). The PNT supplies a constant \(D_\varepsilon\) such that \(|\Psi(X)-X|\le\varepsilon X+D_\varepsilon\) for all \(X\ge1\); partial summation gives \(H(X)=O(1+\log X)\). Replacing both \(\Psi\)-terms in (2) by their main terms yields exactly \(e^a\phi(x)\), since
\[
 \frac12\left(e^{x/2}e^{a-x}+e^{-x/2}e^{a+x}\right)=e^a\cosh(x/2).
\]
The two errors together, divided by \(\phi(x)\), are bounded uniformly for \(|x|<a\) by \(\varepsilon e^a+D_\varepsilon+O(a)\). Hence \((P_a\phi)(x)/\phi(x)=e^a+o(e^a)\) uniformly, and (4) proves (6).

In contrast, [Zhu's pointwise-comb lemma and §14 barrier](https://arxiv.org/html/2608.24827v2) use the trigonometric polynomial
\[
 p_a(t)=2\sum_{\log n<2a}\frac{\Lambda(n)}{\sqrt n}\cos(t\log n),
 \qquad \sup_t p_a(t)=A_a:=2\sum_{\log n<2a}\frac{\Lambda(n)}{\sqrt n}
 =(4+o(1))e^a.
\]
There is no conflict: for \(f\) supported in \(I_a\), Plancherel identifies \(\langle f,P_af\rangle\) with the average of \(p_a(t)\) against \(|\widehat f(t)|^2\), not with its pointwise supremum. Equation (6) says that the restricted Fourier transforms cannot concentrate enough to attain the worst simultaneous prime-phase alignment. It replaces Zhu's pointwise comb constant by a spatial operator bound one quarter as large asymptotically; it does **not** invalidate his theorem that the pointwise constant is optimal for pointwise-envelope certificates.

[Liu's 2026 manuscript and released certificate package](https://github.com/luciferyu666/certified-weil-positivity/releases/tag/v1.0-mcom-submission) also use weighted Schur estimates for finite Weil windows. Their external reproduction is stated as incomplete. No priority claim is made here for the Schur method or the asymptotic formula (6).

One could use \(C_a\) in a constant-baseline splitting of the archimedean multiplier, as in the [odd half-window certificate](suzuki-reflected-two-half-window-positive-certificate.md). Since that multiplier grows like \(\log(t/(2\pi))\), the corresponding safe cutoff still scales as \(\exp((1+o(1))e^a)\). Thus (3)–(6) improve the exponent constant in that particular reduction but retain a doubly exponential cost. They establish no positivity of the Weil form for a new window and imply nothing about RH.
