# A sparse coherent-prime-weight countermodel to terminal sign from ground positivity

RH Agent3, 2026-09-17; independently audited. This is a rigorous **countermodel to a proposed type of argument**, not a statement about the actual von Mangoldt weights. It preserves the ordinary integer successor, the exact prime-power support, one coherent coefficient for every power of a prime, a prime-number-theorem asymptotic, and a strictly positive factorial ground. Nevertheless one fixed pole-null terminal-prime packet has signed scores unbounded in both directions. Therefore those structural properties alone cannot prove the one-sided \(O(1)\) terminal bound needed for RH; the exact amplitudes \(\Lambda(p^r)=\log p\) or another genuinely arithmetic constraint must enter. A [separate coefficient countermodel](odd-terminal-schur-coefficient-countermodel.md) treats moderate-frequency Schur trials; the construction here tests factorial-ground positivity and a bounded-arch fixed-shell score.

Fix a nonzero real \(g\in C_c^\infty(0,B)\) with
\(M_g(1/2)=\int_0^B e^{-y/2}g(y)dy=0\), and put \(k=g*g\). A signed two-bump profile gives such a \(g\). Then \(k\in C_c^\infty(0,2B)\), \(k\not\equiv0\), and
\[
 c_k:=\int_0^{2B}e^{-s/2}k(s)^2ds>0.
\tag{1}
\]
For the actual von Mangoldt source, define the signed terminal packet at \(N=e^{2a}\) by
\[
 T_\Lambda(N)=-2\sum_{Ne^{-2B}<n<N}
 \frac{\Lambda(n)}{\sqrt n}
 k\!\left(\log\frac Nn\right).
\tag{2}
\]
The continuous-prime main term is \(-2e^aM_g(1/2)^2=0\); the prime number theorem therefore gives \(T_\Lambda(e^{2a})=o(e^a)\). The [fixed-shell diagnostic](offline-zero-terminal-prime-pole-null-signature.md) explains that the finite-window exact pole correction to \(g\) is only \(O(e^{-a})\), changing (2) by \(O(1)\).

**Theorem (coherent sparse perturbation).** There exists a positive coefficient system \(\Lambda_*\) on the actual prime powers such that:

1. \(\Lambda_*(p^r)=\lambda_p\log p\) for every prime \(p\) and every \(r\ge1\), with \(1/2\le\lambda_p\le3/2\) and \(\lambda_p\to1\) as \(p\to\infty\); \(\Lambda_*(n)=0\) off prime powers.
2. \(\psi_*(x)=\sum_{n\le x}\Lambda_*(n)=x+o(x)\). Its complete factorial ground
\[
 \mathfrak F_*(x)=\log x-\sum_{n\le x}\frac{\Lambda_*(n)}n
                       +\frac{\psi_*(x)}x
\tag{3}
\]
is strictly positive for every \(x>1\), continuous across every prime-power arrival, and satisfies \(d(x^2\mathfrak F_*')=dx-d\psi_*\).
3. For the **same** fixed \(g\), the terminal scores \(T_{\Lambda_*}(N)\), defined by (2) with \(\Lambda_*\), have \(\limsup_{N\to\infty}T_{\Lambda_*}(N)=+\infty\) and \(\liminf_{N\to\infty}T_{\Lambda_*}(N)=-\infty\). This remains true after the \(O(e^{-a})\) exact pole correction of the odd boundary packet, whose archimedean logarithmic energy stays \(O_g(1)\).

In particular, even complete prime-power histories plus the positive ground and PNT do not enforce the required one-sided signed bound.

**Construction and proof.** Let \(\varepsilon_j=\varepsilon_0 2^{-j}\), with \(\varepsilon_0>0\) sufficiently small, and choose signs \(\sigma_j=(-1)^j\). Inductively choose real \(a_j\to\infty\) and \(N_j=e^{2a_j}\) so that the prime bands
\(I_j=(N_je^{-2B},N_j)\) are disjoint and widely separated,
\(\varepsilon_j e^{a_j}\to\infty\), and
\[
 |T_\Lambda(N_j)|\le j^{-1}c_k\varepsilon_j e^{a_j}.
\tag{4}
\]
This is possible because \(T_\Lambda(e^{2a})=o(e^a)\). For each prime \(p\in I_j\) set
\[
 \lambda_p=1+\sigma_j\varepsilon_j
 k\!\left(\log\frac{N_j}{p}\right),
\tag{5}
\]
and set \(\lambda_p=1\) for primes outside all bands. Take \(\varepsilon_0\|k\|_\infty\le1/2\). The same \(\lambda_p\) multiplies \(\log p\) at **every** power \(p^r\); hence no future multiplicative history is omitted. Equivalently, \(-\zeta_*'/\zeta_*\) has these coefficients for the generalized Euler product
\(\zeta_*(s)=\prod_p(1-p^{-s})^{-\lambda_p}\) on \(\operatorname{Re}s>1\).

Because \(\lambda_p\to1\), the modified source still obeys PNT. More explicitly, for any \(\delta>0\), all sufficiently large prime bases have \(|\lambda_p-1|\le\delta\), so their complete prime-power contribution to \(|\psi_*−\psi|\) is at most \(\delta\psi(x)=O(\delta x)\); the finitely many smaller modified bases contribute only \(O_\delta(\log x)\). Therefore \(\psi_*(x)-\psi(x)=o(x)\), and \(\psi_*(x)=x+o(x)\).

For the ground, the actual \(\mathfrak F(x)\) in (3) with \(\Lambda\) is positive and tends to \(1+\gamma>0\). Below the first modified band it is unchanged. On and above that band,
\[
 |\mathfrak F_*(x)-\mathfrak F(x)|
 \le\sum_{n\le x}\frac{|\Lambda_*(n)-\Lambda(n)|}{n}
      +\frac1x\sum_{n\le x}|\Lambda_*(n)-\Lambda(n)|.
\tag{6}
\]
For each fixed-width prime band, prime-number-theorem partial summation gives
\(\sum_{p\in I_j}(\log p)/(p-1)=2B+o(1)\), uniformly bounded for large \(j\). Thus the first term is at most \(C_B\|k\|_\infty\sum_j\varepsilon_j\). The second is at most \(C\varepsilon_0\|k\|_\infty\psi(x)/x\le C'\varepsilon_0\|k\|_\infty\). Choose \(\varepsilon_0\) sufficiently small and the first band sufficiently far out that (6) is less than half the positive lower bound of \(\mathfrak F\) there. Hence \(\mathfrak F_*>0\) globally. The jump cancellation in (3) and the distributional derivative identity are algebraic and hold for any coherent weights.

At \(N_j\), no first power from another modified band lies in \(I_j\). The current band's primes have \(p^2>N_j\), so their perturbation to (2) is
\[
 -2\sigma_j\varepsilon_j
 \sum_{p\in I_j}\frac{\log p}{\sqrt p}
 k\!\left(\log\frac{N_j}{p}\right)^2
 =-2\sigma_j\varepsilon_j e^{a_j}(c_k+o(1)),
\tag{7}
\]
by PNT. Modified primes from earlier bands can enter \(I_j\) only through proper powers. The total weight of all proper powers in any fixed-width terminal band is \(O_B(1)\): squares contribute \(B+o(1)\) to \(\sum(\log p)/p\), and \(r\ge3\) powers have a globally convergent \(\sum(\log p)p^{-r/2}\). Their perturbation is therefore \(O_B(1)\). Combining (4), (7), and \(\varepsilon_j e^{a_j}\to\infty\), we get
\[
 T_{\Lambda_*}(N_j)
 =-2\sigma_j c_k\varepsilon_j e^{a_j}
   +o(\varepsilon_j e^{a_j})+O_B(1),
\tag{8}
\]
which alternates sign with unbounded magnitude. The exact pole correction changes the score by \(O_g(1)\) and preserves the bounded arch energy, proving the last assertion. \(\square\)

This countermodel does **not** modify the actual Riemann zeta function or prove RH false. The integer successor \(n\mapsto n+1\), strict division graph, prime support, complete powers, positivity of every arrival weight, PNT, and factorial-ground positivity all survive. What fails is the exact arithmetic amplitude \(\log p\) at each prime base. Any successful one-sided terminal inequality must use that exact amplitude or another property that excludes the coherent sparse perturbations; support, positivity, and asymptotic density alone cannot supply it.
