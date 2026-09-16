# A full-label positive packet space at a fixed critical frequency ratio

The exact [divisor-history Dirichlet energy](compact-weil-divisor-graph-dirichlet-energy.md)
can pay the off-center gamma interaction and the signed pole on the
entire resolved packet family when its frequency is $T=cN$ and the
fixed ratio $c$ is sufficiently large. This strengthens the
[one-profile Hardy comparison](compact-weil-critical-packet-hardy-control.md)
by making its bounded mass term explicit at large $c$, and the
[separated-band result](compact-weil-separated-divisor-bands-positive-space.md):
no divisor labels between a low band and the top half are removed.
The packets remain sparse in every fixed spatial interval as $N$
grows, so the theorem does not give full Weil positivity or RH.

Use the two fixed real nonnegative $L^2$-normalized profiles
$p_-\in C_c^\infty(-\delta,0)$ and
$p_+\in C_c^\infty(0,\delta)$ from the
[boundary-packet construction](compact-weil-boundary-packet-growing-positive-space.md),
where $0<\delta<1$. Set
\[
 L_N=\tfrac12\log(N+1),\qquad T=cN,\qquad x_n=L_N-\log n,
 \qquad f_{n,\sigma}(x)=\sqrt T\,p_\sigma(T(x-x_n)).       \tag{1}
\]
Retain $f_{n,-}$ for $1\le n\le N$ and $f_{n,+}$ for
$2\le n\le N$. Their span is $V_{N,c}$. For all sufficiently large
$N$ and $c>4$, the packets are supported in $(-L_N,L_N)$,
orthonormal, and have the exact prime compression
$K_N\oplus K_N^{[2,N]}$ from the boundary-packet theorem.

**Theorem.** There are constants $c_0>4$, $N_0\ge2$, and $C$,
depending only on the two profiles, such that for every $c\ge c_0$,
$N\ge N_0$, and $f\in V_{N,c}$,
\[
 \boxed{\qquad Q_{L_N}(f)\ge(\log c-C)\|f\|_2^2.\qquad} \tag{2}
\]
Increasing $c_0$ makes the right-hand coefficient positive. The
complete compact Weil form $Q_{L_N}$ here includes the actual
von Mangoldt prime powers, the signed gamma multiplier, and both pole
moments. The dimension is $2N-1$.

## A moment transfer from complete divisor histories

Write $f=\sum_{n,\sigma}a_{n,\sigma}f_{n,\sigma}$ and
$g_{n,\sigma}=\sqrt n\,a_{n,\sigma}$, with $g_{1,+}=0$.
For each profile define
\[
 W=\sum_{n,\sigma}\frac{|g_{n,\sigma}|^2}{n}=\|f\|_2^2,
 \quad
 E=\sum_{\sigma}\sum_{\substack{n,d\ge1\\nd\le N}}
       \frac{\Lambda(d)}{nd}
       |g_{n,\sigma}-g_{nd,\sigma}|^2,
 \quad
 Z=\frac{\log N}{N}\sum_{n,\sigma}|g_{n,\sigma}|^2.       \tag{3}
\]
The $d=1$ terms vanish. Let $C_\psi$ be any absolute constant with
$\psi(x)=\sum_{d\le x}\Lambda(d)\le C_\psi x$ for $x\ge1$.
The exact divisor-log identity and $|u|^2\le2|u-v|^2+2|v|^2$
give
\[
\begin{aligned}
 \frac1N\sum_{m,\sigma}(\log m)|g_{m,\sigma}|^2
 &=\frac1N\sum_{\sigma}\sum_{nd\le N}
       \Lambda(d)|g_{nd,\sigma}|^2\\
 &\le 2E+\frac2N\sum_{n,\sigma}|g_{n,\sigma}|^2
                         \psi(N/n)\\
 &\le2E+2C_\psi W.                                  \tag{4}
\end{aligned}
\]
Since $(m/N)\log(N/m)\le1/e$ for $1\le m\le N$, adding the
missing logarithmic part proves the uniform transfer
\[
 \boxed{\qquad Z\le2E+C_MW,\qquad C_M=2C_\psi+1/e.\qquad} \tag{5}
\]
It is crucial that the incoming sum in (4) includes **every**
prime-power divisor of $m$. For a vector concentrated near $N$,
$Z$ is of order $\log N$; (5) shows where that cost is stored in
the original arithmetic graph.

The complex version of the exact graph identity gives
\[
 (\log N)W-\langle f,K_N^{\oplus}f\rangle=E+B,
 \quad
 B=\sum_{n,\sigma}\frac{b_N(n)}n|g_{n,\sigma}|^2\ge0,   \tag{6}
\]
where $b_N(n)=\log(N/n)-\sum_{d\le N/n}\Lambda(d)/d$.
The sign uses [Balazard's published all-cutoff inequality](https://arxiv.org/html/2312.05138v3).

## Gamma interaction at $T=cN$

Put $H(t)=\Re\psi(1/4+it/2)-\log\pi$ and
$q(t)=H(t)-\log(|t|/(2\pi))$. The standard digamma expansion
and the integrable logarithm at the origin imply $q\in L^1(\mathbb R)$.
The gamma matrix on (1) separates into $(\log T)I$, a fixed
same-center profile matrix of norm at most $C_{\rm loc}$, the
off-center Fourier kernel of $\log|u|$, and a $q$ remainder.
For distinct labels and $|s|>2\delta$, that kernel is
\[
 G_{\sigma\tau}(s)=-\frac12\iint
  \frac{p_\sigma(v)p_\tau(w)}{|s+v-w|}\,dv\,dw,
 \qquad s=T\log(m/n).                                 \tag{7}
\]
For $c\ge8$, $N$ sufficiently large, $|s|>4\delta$, and hence
$|G_{\sigma\tau}(s)|\le C/(cN|\log(m/n)|)$.
Each entry of the $q$ remainder is at most $C/(cN)$.

The weighted row estimate needed here is elementary:
\[
 \sum_{\substack{1\le m\le N\\m\ne n}}
       \frac{\sqrt{n/m}}{|\log(m/n)|}
 \le C\bigl(N+n\log(2N)\bigr).                       \tag{8}
\]
For $n/2\le m\le2n$, use
$|\log(m/n)|\ge|m-n|/(2n)$ and sum a harmonic series.
For $m>2n$, the denominator is at least $\log2$ and the sum is
$O(N)$. For $m<n/2$, the sum is $O(n)$ by
$\sum_{m\le n}m^{-1/2}=O(\sqrt n)$. The same weights give an
$O(1/c)$ row for the $q$ remainder because
$\sum_{m\le N}\sqrt{n/m}=O(\sqrt{nN})\le O(N)$.
Weighted Schur, including both profiles, therefore yields
\[
 |\Gamma_{\rm off+q}[f]|
 \le\frac{C_\Gamma}{c}(W+Z)
 \le\frac{2C_\Gamma}{c}E
       +\frac{C_\Gamma(1+C_M)}c W.                  \tag{9}
\]
All constants in (7)--(9) are independent of $N$ and $c\ge8$.

## The signed pole

Let $M$ bound the absolute profile integrals
$\int p_\sigma(s)e^{\pm s/(2T)}ds$ for $T\ge1$. The exact
loadings in the boundary-packet theorem imply
\[
 |2\Re(E_+(f)\overline{E_-(f)})|
 \le\frac{2M^2}{cN}
 \left(\sum_{n,\sigma}\frac{|g_{n,\sigma}|}{n}\right)
 \left(\sum_{n,\sigma}|g_{n,\sigma}|\right).         \tag{10}
\]
The first sum is at most $(2H_NW)^{1/2}$, where
$H_N=\sum_{n\le N}1/n$; the second is at most
$(2N\sum|g_{n,\sigma}|^2)^{1/2}$. Since
$H_N/\log N$ is bounded for $N\ge2$, (5) turns (10) into
\[
 |\text{pole}[f]|\le\frac{C_P}{c}\sqrt{WZ}
 \le\frac{C_P}{c}\sqrt{W(2E+C_MW)}.                 \tag{11}
\]
Young's inequality bounds (11) by
$\frac14E+(2C_P^2/c^2+C_P\sqrt{C_M}/c)W$.
No pole sign is assumed.

Combine (6), (9), (11), the $(\log T)I$ gamma diagonal,
and the bounded same-center profile matrix. Taking
$c_0\ge\max\{8,8C_\Gamma\}$ gives
\[
 Q_{L_N}(f)\ge\frac12E+B+
 \left[\log c-C_{\rm loc}
  -\frac{C_\Gamma(1+C_M)+C_P\sqrt{C_M}}c
  -\frac{2C_P^2}{c^2}\right]W.                 \tag{12}
\]
The bracket is at least $\log c-C$ for one constant $C$,
proving (2). In fact (12) retains a nonnegative fraction of the
complete divisor-history energy and the boundary potential.

This is a written proof. The finite real identity in (6) has a
[Lean formalization](BuildingBlocks/CompactWeilDivisorEnergyFinite.lean);
the transfer (5), gamma and pole estimates, Balazard input, and
complex extension are not Lean-formalized. As $N\to\infty$, the
packets have width $O(N^{-1})$ while their centers near any fixed
spatial point are spaced $\asymp N^{-1/2}$. Thus these positive
spaces do not approximate arbitrary compact tests, and (2) does not
prove RH.
