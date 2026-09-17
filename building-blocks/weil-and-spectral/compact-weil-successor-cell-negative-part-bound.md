# A zero-free-region bound for the successor-cell Weil negative part

The [successor-cell spaces](compact-weil-successor-cell-refinement.md) are finite,
form-dense models of the complete compact Weil form. Their prime matrix retains
every admitted von Mangoldt prime power, and the form also includes the exact
gamma integral and both pole moments. This note gives an **unconditional upper
bound on the negative part** of that complete matrix. The bound grows with the
window; it does not establish Weil positivity or RH. The proof is written
analysis, with no Lean formalization.

Put \(X=N+1\), \(L=\tfrac12\log X\), and let \(S_N\subset L^2([-L,L])\) be the
\(N\)-cell space in the refinement note. Write \(Q_L\) for its complete form,
normalized as in equation (8) there. For sufficiently large \(N\), there are
absolute constants \(c,C>0\) such that every complex \(f\in S_N\) satisfies
\[
\boxed{\quad
 Q_L(f)\ge
 -C\sqrt X\exp\!\left[-c\,
   \frac{(\log X)^{1/3}}{(\log\log X)^{1/3}}\right]\|f\|_2^2.
\quad} \tag{1}
\]
Equivalently, the negative part of the Hermitian \(N\times N\) cell matrix has
operator norm at most the coefficient on the right. The estimate uses the
classical Korobov–Vinogradov zero-free region, through the already proved
[uniform twisted PNT lemma](../prime-distribution/odd-prime-graph-zero-free-region-log-frequency-gap.md).

## Exact cancellation of the continuous prime density

Use the Fourier convention \(\widehat f(t)=\int f(x)e^{itx}\,dx\). Replace the
actual prime operator \(K_L\) by the continuous-density operator
\[
 P_{L,\mathrm{cont}}
 =M_L\int_0^{2L}e^{u/2}(U_u+U_{-u})\,du\,M_L.
\tag{2}
\]
Its kernel on the window is \(e^{|x-y|/2}\). The complete pole term
\(2\operatorname{Re}(E_+(f)\overline{E_-(f)})\) has kernel
\(2\cosh((x-y)/2)\). Their difference is the positive-definite kernel
\(e^{-|x-y|/2}\), whose full-line Fourier multiplier is
\((t^2+1/4)^{-1}\). Thus the digamma recurrence gives the **exact** identity
\[
 Q_L(f)=\frac1{2\pi}\int_{\mathbb R} b(t)|\widehat f(t)|^2\,dt
       -\langle f,(K_L-P_{L,\mathrm{cont}})f\rangle,
 \qquad
 b(t)=\operatorname{Re}\psi\!\left(\frac54+\frac{it}{2}\right)
       -\log\pi.
\tag{3}
\]
Here \(b_*:=\inf_{t\in\mathbb R}b(t)>-\infty\): \(b\) is continuous and
\(b(t)=\log(|t|/(2\pi))+O(t^{-2})\) at infinity. Equation (3) retains the
signed gamma term and both poles, rather than estimating any of them away.

Set
\[
 \Delta_X(t)=\sum_{n<X}\frac{\Lambda(n)}{\sqrt n}n^{it}
       -\int_1^X x^{-1/2+it}\,dx.
\tag{4}
\]
Autocorrelation and Plancherel turn the remaining quadratic term into
\[
 \langle f,(K_L-P_{L,\mathrm{cont}})f\rangle
 =\frac1{2\pi}\int_{\mathbb R}
       2\operatorname{Re}\Delta_X(t)|\widehat f(t)|^2\,dt.
\tag{5}
\]
All the \(n<X\) terms in (4) occur in the exact successor-cell matrix.

## Frequency bound on every cell vector

Define
\[
 \epsilon_3(X)=X^{-1/2}\sup_{|t|\le X^3}|\Delta_X(t)|.
\]
The [uniform twisted PNT lemma](../prime-distribution/odd-prime-graph-zero-free-region-log-frequency-gap.md)
gives, for fixed absolute \(c_3>0\) and some \(C_3\),
\[
 \epsilon_3(X)\ll(\log X)^{C_3}
 \exp\!\left[-c_3\frac{(\log X)^{1/3}}
                         {(\log\log X)^{1/3}}\right].
\tag{6}
\]
Its zero-free-region input is [Bellotti's explicit theorem](https://arxiv.org/abs/2306.10680).
Chebyshev's \(\psi(X)=O(X)\), followed by partial summation, also gives
\(|\Delta_X(t)|\le C\sqrt X\) for all real \(t\).

For \(f=\sum_{n=1}^N z_n\mathbf1_{I_n}\), extended by zero, the cell lengths
\(\ell_n=\log(1+1/n)\ge1/(n+1)\) imply
\[
 \operatorname{TV}(f)\le2\sum_{n=1}^N|z_n|
 \le2\Bigl(\sum_{n=1}^N\ell_n|z_n|^2\Bigr)^{1/2}
       \Bigl(\sum_{n=1}^N\ell_n^{-1}\Bigr)^{1/2}
 \le CN\|f\|_2.
\tag{7}
\]
Consequently \(|\widehat f(t)|\le\operatorname{TV}(f)/|t|\) and
\[
 \frac1{2\pi}\int_{|t|>X^3}|\widehat f(t)|^2\,dt
 \le\frac{\operatorname{TV}(f)^2}{\pi X^3}
 \le\frac C X\|f\|_2^2.
\tag{8}
\]
Splitting (5) at \(X^3\), using (6) at low frequencies and (8) at high
frequencies, proves the more precise bound
\[
 Q_L(f)\ge
 \bigl(b_*-2\sqrt X\,\epsilon_3(X)-CX^{-1/2}\bigr)\|f\|_2^2.
\tag{9}
\]
Absorbing the fixed \(b_*\) and the logarithmic factor in (6) into a smaller
positive exponent constant proves (1).

The cell-average projections converge to each fixed compact smooth test in
form topology, as proved in the [refinement note](compact-weil-successor-cell-refinement.md).
That density does not turn (1) into a sign theorem: its permitted negative
size is \(X^{1/2-o(1)}\), and the right-hand side of (1) tends to
\(-\infty\). A bound at the RH-scale, or an actual nonnegative sign, remains
open.
