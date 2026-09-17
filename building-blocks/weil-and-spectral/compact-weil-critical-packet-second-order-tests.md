# Second-order phase tests at the critical Weil packet scale

The [critical packet crossover](compact-weil-critical-packet-crossover.md)
has a rank-one leading form on fixed smooth log-shell profiles. Its
constant profile has a positive finite residual. This note tests two
families that the leading limit alone does not settle: a perturbation
of that profile at its natural \(1/\sqrt{\log N}\) scale, and fixed
multiplicative phases on the actual prime coordinates. It also
checks both endpoint label blocks. Every statement concerns the
complete compact Weil form on specified packets; no uniform
full-packet or full-window sign is claimed.

Use the notation of the critical crossover: \(L_N=\frac12\log(N+1)\),
\(R=\log N\), \(T=cN\) with fixed \(c>4\), and a real norm-one
\(p\in C_c^\infty(-\delta,0)\), \(0<\delta<1\). The orthonormal
packets \(p_n\), \(1\le n\le N\), have the exact divisor prime
compression \(A_N\). Set
\[
 C_{p,c}=\log c+\gamma+g_p+\frac{\mu_p^2}{c}>0,
 \quad
 \mu_p=\int p,\quad
 g_p=\frac1{2\pi}\int\log\frac{|u|}{2\pi}
                         |\widehat p(u)|^2du.
 \tag{1}
\]

## Smooth perturbations of the Perron profile

Let \(v\in C^1[0,1]\) be complex with \(\int_0^1v=0\), and put
\[
 W_{N,v}=\sum_{n=1}^N\frac{1}{\sqrt n}
 \left[1+\frac{v(\log n/R)}{\sqrt R}\right]p_n.
 \tag{2}
\]

**Proposition 1.** For every such fixed \(v\),
\[
 \boxed{\quad
 \lim_{N\to\infty}
 \frac{Q_{L_N}(W_{N,v})}{\|W_{N,v}\|_2^2}
 =C_{p,c}+\int_0^1|v(s)|^2ds>0.
 \quad}
 \tag{3}
\]

**Proof.** Harmonic quadrature with \(v\in C^1\) gives
\(\sum_{n\le N}v(\log n/R)/n=O_v(1)\) because \(\int v=0\), and
\[
 \|W_{N,v}\|_2^2
 =H_N+\int_0^1|v|^2+o(1)=R+O_v(1).
 \tag{4}
\]
The exact Schur row of \(w_n=n^{-1/2}\) in the sharpness addendum is
\[
 (A_Nw)_n=w_n\{R+e(N/n)\},\qquad
 e(x)=\sum_{d\le x}\frac{\Lambda(d)}d-\log x=O(1).
 \tag{5}
\]
Hence the prime cross between \(w\) and
\(w_nv(\log n/R)/\sqrt R\) is \(O_v(\sqrt R)\).
The prime quadratic of the latter is \(o(R)\), by the fixed-profile
rank-one limit in the critical note and \(\int v=0\).
The off-center gamma and pole quadratics are \(O(R)\) on bounded
log-shell coefficients; changing the coefficients by
\(O_v(R^{-1/2})\) changes those terms by \(O_v(\sqrt R)\).
The local gamma correction \(g_p\) changes by \(O_v(1)\).
The only new order-\(R\) term is
\[
 (\log T)\bigl(\|W_{N,v}\|_2^2-H_N\bigr)
 =R\int_0^1|v|^2+o(R).
\]
The constant vector has \(Q_{L_N}(\sum w_np_n)
=H_N(C_{p,c}+o(1))\) by the critical theorem.
Divide the resulting quadratic by (4) to obtain (3). \(\square\)

## Fixed prime phases

Fix a finite set \(S\) of primes and phases \(|z_p|=1\).
Define the completely multiplicative phase
\[
 \chi(n)=\prod_{p\in S}z_p^{v_p(n)},\qquad
 F_{N,\chi}=\frac1{\sqrt{H_N}}
          \sum_{n=1}^N\frac{\chi(n)}{\sqrt n}p_n.
 \tag{6}
\]
The empty set gives the Perron packet. Set
\[
 \kappa_\chi=\prod_{p\in S}
                \frac{1-p^{-1}}{1-z_pp^{-1}},
 \qquad
 D_\chi=2\sum_{p\in S}\sum_{j\ge1}
             \frac{\log p}{p^j}
             (1-\Re z_p^j)\ge0.
 \tag{7}
\]

**Theorem 2.** Each fixed finite-prime phase has the exact
critical residual
\[
 \boxed{\quad
 \lim_{N\to\infty}Q_{L_N}(F_{N,\chi})
 =\log c+\gamma+g_p+D_\chi
           +\frac{\mu_p^2}{c}|\kappa_\chi|^2>0.
 \quad}
 \tag{8}
\]
In particular, these arithmetic phase vectors have prime Rayleigh
value \(\log N-\gamma-D_\chi+o(1)\). Thus the rank-one
fixed-log-shell limit does not describe the growing packet matrix
uniformly: many phase directions retain prime energy
\(\log N-O(1)\).

**Proof.** Complete multiplicativity makes each edge phase
\(\overline{\chi(n)}\chi(nd)=\chi(d)\). The prime Rayleigh value is
\[
 \frac2{H_N}\sum_{d\le N}
       \frac{\Lambda(d)\Re\chi(d)}d
       H_{\lfloor N/d\rfloor}.
 \tag{9}
\]
Subtract it from the untwisted exact value
\(\log N-\gamma+o(1)\). Since only powers of primes in \(S\)
change, dominated convergence in the finite-prime geometric
series gives precisely \(D_\chi\).

For the pole and gamma terms, first note that
\[
 \frac1N\sum_{n\le N}\chi(n)\longrightarrow\kappa_\chi,
 \qquad
 \frac1R\sum_{n\le N}\frac{\chi(n)}n
       \longrightarrow\kappa_\chi.
 \tag{10}
\]
One direct proof truncates each valuation at \(K\):
\(\chi_K(n)=\prod_{p\in S}z_p^{\min(v_p(n),K)}\) is periodic
modulo \(\prod_{p\in S}p^K\). Its mean tends to the Euler product
in (7), while \(\chi_K\ne\chi\) only on a set of upper density
at most \(\sum_{p\in S}p^{-K}\). Cesàro means and then partial
summation give (10). The exact packet pole moments now show that
their product tends to \(2\mu_p^2|\kappa_\chi|^2/c\).

The logarithmic gamma kernel of the critical note gives
\[
 \Gamma(F_{N,\chi})
 =\log T+g_p
 -\frac{\mu_p^2}{T H_N}\Re
   \sum_{n<m\le N}
   \frac{\overline{\chi(n)}\chi(m)}
        {\sqrt{nm}\log(m/n)}
 +o(1).
 \tag{11}
\]
Here the profile-denominator error is \(O(1/H_N)\) by the
\(C_N=O(N^2)\) bound in that note, and the \(L^1\) digamma
remainder is also \(o(1)\). The absolute difference between
the sum in (11) and
\[
 U_N(\chi)=\sum_{n<m\le N}
             \frac{\overline{\chi(n)}\chi(m)}{m-n}
 \tag{12}
\]
is \(O(N)\), by the same near/far comparison used to prove
\(B_N=N\log N+O(N)\).

We claim
\[
 U_N(\chi)=|\kappa_\chi|^2N\log N+o(N\log N).
 \tag{13}
\]
For a fixed periodic sequence \(a_n\) of period \(q\) and mean
\(\bar a\), its lag correlation has periodic main term
\(q^{-1}\sum_{r=1}^q\overline{a_r}a_{r+k}\), with \(O(q)\)
error in each partial sum. Averaging that correlation over
one period of \(k\) gives \(|\bar a|^2\); harmonic summation
over \(k\) proves \(U_N(a)=|\bar a|^2N\log N+O_q(N)\).
Apply this to \(\chi_K\). The matrix
\((\mathbf1_{\{m>n\}}/(m-n))_{n,m}\) has operator norm
\(O(\log N)\) because both its row and column sums have that
bound. Thus replacing \(\chi_K\) by \(\chi\) changes
\(U_N/(N\log N)\) by
\(O((\sum_{p\in S}p^{-K})^{1/2})\). Let \(N\to\infty\),
then \(K\to\infty\), to obtain (13). Equations (11)--(13)
give the signed off-center gamma limit
\(-\mu_p^2|\kappa_\chi|^2/c\).
Combining it with the pole and (9) proves (8).
The lower bound \(g_p\ge\log(1/(2\delta))-1\) from the
critical note, together with \(c>4\) and \(D_\chi\ge0\),
makes (8) strictly positive. \(\square\)

For example, taking \(S=\{2\}\) and \(z_2=-1\) gives
\(\kappa_\chi=1/3\) and \(D_\chi=(8/3)\log2\).
This direction still has prime Rayleigh energy
\(\log N-\gamma-(8/3)\log2+o(1)\), but its full
critical Weil residual is positive.

## Endpoint label blocks

The arithmetic graph has no edges between two labels both
larger than \(N/2\): their ratio is strictly below \(2\).
For vectors supported on \(N/2<n\le N\), (11) of the
critical note and \(\|p\|_1^2\le\delta\) give
\[
 |\kappa_p(T\log(m/n))|
 \le\frac{\delta}{2(c|m-n|-\delta)}
 \quad(m\ne n),
\]
because \(T|\log(m/n)|\ge c|m-n|\).
The absolute off-center row sum is at most
\(\frac{\delta}{c-\delta}\log N+O(1)\).
The \(L^1\) digamma remainder has operator norm \(O(N/T)=O(1)\),
and the pole norm on this top-half block is \(O(N/T)=O(1)\):
the squared norms of its two moment vectors are bounded by
\(T^{-1}e^{L_N}\sum_{n>N/2}n^{-1}=O(e^{L_N}/T)\) and
\(T^{-1}e^{-L_N}\sum_{n>N/2}n
=O(e^{-L_N}N^2/T)\), respectively.
Consequently
\[
 Q_{L_N}(f)\ge
 \left[\left(1-\frac{\delta}{c-\delta}\right)\log N-O(1)\right]
 \|f\|_2^2
 \quad\left(f\in\operatorname{span}\{p_n:N/2<n\le N\}\right).
 \tag{14}
\]
This is positive for all sufficiently large \(N\).

At the other end, for fixed \(0<\alpha<1\), the labels
\(1\le n\le\lfloor N^\alpha\rfloor\) have exact prime
compression \(A_{\lfloor N^\alpha\rfloor}\), with norm at most
\(\alpha\log N+O(1)\). Their off-center gamma and pole
norms are \(o(1)\). Indeed, for \(M=\lfloor N^\alpha\rfloor\),
the spacing row estimate
\(\sup_{n\le M}\sum_{m\ne n\le M}|\log(m/n)|^{-1}
=O(M\log M)\) makes the off-center gamma norm
\(O(M\log M/T)=o(1)\); the uniform digamma remainder
has norm \(O(M/T)=o(1)\). The pole moment estimate
(16) of the growing-packet theorem is
\(O(M\sqrt{\log(2M)}/T)=o(1)\). Hence
\[
 Q_{L_N}(f)\ge
 \bigl[(1-\alpha)\log N-O(1)\bigr]\|f\|_2^2
 \quad\left(f\in\operatorname{span}
 \{p_n:1\le n\le N^\alpha\}\right).
 \tag{15}
\]

The tested smooth perturbations, fixed finite-prime phases,
and separate endpoint blocks have positive margins or residuals.
The results do not control vectors that mix these sectors with
prime phases or supports depending on \(N\). A negative test for
the actual \(\Lambda\) form was not found. The full compact-support
Weil positivity problem remains separate.
