# A finite-prime phase barrier below the odd Weil Schur scale

This note tests a quantitative route from the
[odd prime-graph uncertainty theorem](odd-prime-graph-logarithmic-uncertainty.md)
to the signed Weil form. It gives actual odd tests on which any selected
set of prime coordinates, including **all admitted powers of those
primes**, has almost zero graph energy at an archimedean energy below
the full Schur row. The omitted prime coordinates are uncontrolled and
may supply the missing energy. There is no sign claim for the full
Weil form.

Let \(a\ge1\), \(I_a=(-a,a)\), \(\phi(x)=\cosh(x/2)\), and let
\(S\) be a finite set of \(m\) primes containing \(2\). Sum the actual
shift terms \(w_{p^r}=\log p/p^{r/2}\) over every \(p\in S\) and
\(r\ge1\) with \(r\log p<2a\), obtaining \(P_{S,a}\). Define
\[
 R_{S,a}=P_{S,a}\phi/\phi,\qquad
 \mathsf S_{S,a}[F]=\int_{I_a}R_{S,a}|F|^2,
 \qquad
 \mathsf D_{S,a}[F]=\mathsf S_{S,a}[F]-\langle F,P_{S,a}F\rangle.
\tag{1}
\]
These are the corresponding sub-row and nonnegative subgraph of the
exact weighted prime graph. Use the normalized odd logarithmic form
\(H_a\) from [the first-prime spectrum](first-prime-log-normalized-remainder-schatten-transition.md),
with \(u=\sqrt2F|_{(0,a)}\) and
\(H_a[u]=(2/\pi)\int_0^\infty h(t)|\int_0^a u(x)\sin(tx)dx|^2dt\),
where \(h(t)=1+\Re\psi(5/4+it/2)-\Re\psi(5/4)\).

**Proposition.** There are absolute constants \(A,B>0\) such that,
for every \(a\ge1\), every such \(S\), and every integer \(Q\ge2\),
some integer \(1\le q\le Q^{m-1}\) gives the nonzero odd form-domain
test
\[
F_{a,q}(x)=\phi(x)\sin(\kappa x)\mathbf1_{I_a}(x),
\qquad \kappa=\frac{2\pi q}{\log2},
\tag{2}
\]
with
\[
\boxed{\quad
\frac{\mathsf D_{S,a}[F_{a,q}]}{\|F_{a,q}\|_2^2}
 \le A\frac{m a^3}{Q^2},
\qquad
\frac{H_a[\sqrt2F_{a,q}|_{(0,a)}]}{\|F_{a,q}\|_2^2}
 \le (m-1)\log Q+B.
\quad}
\tag{3}
\]
The constants are independent of \(a,S,m,Q\). In particular, for a
fixed finite \(S\), taking
\(Q=\lceil\exp(\theta e^a/(m-1))\rceil\), where \(m\ge2\) and
\(0<\theta<1\), gives logarithmic energy at most
\(\theta e^a+O(1)\) and subgraph energy at most
\(O_S(a^3\exp(-2\theta e^a/(m-1)))\).
The full Schur constant is \(C_a=(1+o(1))e^a\), so these tests lie
below that energy scale for large \(a\).

The assertion also permits growing sets. If \(S_a\) contains \(2\)
and \(m(a)=o(e^a/\log a)\), choose \(Q=\lceil a^4\rceil\). Then
\[
 \frac{H_a[u]}{\|u\|_2^2}=o(e^a),
 \qquad
 \frac{\mathsf D_{S_a,a}[F]}{\|F\|_2^2}
 =O\!\left(\frac{m(a)}{a^5}\right)=o(e^a).
\tag{4}
\]
For example, \(S_a=\{p:p<e^a\}\) has
\(m(a)\sim e^a/a=o(e^a/\log a)\), while its sub-row at the
origin is already of Schur order:
\[
R_{S_a,a}(0)=\sum_{n<e^a}\Lambda(n)(1+n^{-1})
=e^a+o(e^a).
\tag{5}
\]
Equation (5) is a pointwise row statement. It does not say that this
sub-row has order \(e^a\) on the particular boundary-weighted tests
in (2).

**Proof.** The function \(\log\phi\) is \(1/2\)-Lipschitz, so
\(\phi(x\pm r\log p)/\phi(x)\le p^{r/2}\) when the translated point
lies in \(I_a\). Each oriented \(p^r\) term in \(R_{S,a}\) is
therefore at most \(\log p\). The number of admitted powers of \(p\)
is strictly less than \(2a/\log p\). Thus, including both
orientations and all powers,
\[
 0\le R_{S,a}(x)\le
 2\sum_{p\in S}\log p\,\#\{r\ge1:r\log p<2a\}
 \le4ma.\tag{6}
\]
No assumption that \(p<e^a\) is used here.

Apply the elementary simultaneous Dirichlet theorem to the \(m-1\)
numbers \(\log p/\log2\), \(p\in S\setminus\{2\}\). It gives
\(1\le q\le Q^{m-1}\) with each
\(\|q\log p/\log2\|_{\mathbb R/\mathbb Z}\le1/Q\).
For \(p=2\) the phase \(\kappa r\log p\) is an exact multiple of
\(2\pi\); for every other admitted power,
\[
|e^{i\kappa r\log p}-1|
 \le\frac{2\pi r}{Q}
 \le\frac{4\pi a}{Q\log2}.
\tag{7}
\]
The graph identity bounds the sine difference on each edge by (7).
For \(v_a=\phi\mathbf1_{I_a}\), the total unoriented edge integral
equals \(\mathsf S_{S,a}[v_a]/2\). Equations (6)–(7) give
\[
 \mathsf D_{S,a}[F_{a,q}]
 \le \frac12\left(\frac{4\pi a}{Q\log2}\right)^2
       \mathsf S_{S,a}[v_a]
 \le \frac{32\pi^2}{(\log2)^2}\,
       \frac{ma^3}{Q^2}\,\|v_a\|_2^2.
\tag{8}
\]

It remains to justify that division by \(\|F_{a,q}\|_2^2\) and the
energy estimate in (3) cost no hidden factor depending on \(a\).
Direct integration gives \(\|v_a\|_2^2=a+\sinh a\), and the
zero-extended \(v_a\) has \(L^1\)-norm
\(4\sinh(a/2)\) and total variation
\(4\cosh(a/2)-2\). These three quantities imply the uniform Fourier
envelope
\[
\frac{|\widehat v_a(s)|^2}{\|v_a\|_2^2}
 \le B_0\min(1,|s|^{-2})\qquad(a\ge1),
\tag{9}
\]
for an absolute \(B_0\). Also \(v_a^2\) has total variation
\(2\cosh a\le2(a+\sinh a)\). Integration by parts in its Fourier
transform yields, uniformly for \(\kappa\ge2\pi/\log2\),
\[
\|v_a\sin(\kappa\cdot)\|_2^2
=\left(\frac12+O(\kappa^{-1})\right)\|v_a\|_2^2
\ge c_0\|v_a\|_2^2
\tag{10}
\]
with an absolute \(c_0>0\). Combining (8) and (10) proves the
first bound in (3).

For an odd test, the half-line sine form is the full-line Fourier
form with symbol \(h(|t|)\). The Fourier transform of (2) is the
difference of the two translates
\((\widehat v_a(t-\kappa)-\widehat v_a(t+\kappa))/(2i)\).
The digamma asymptotic gives \(h(t)=\log t+O(1)\) as
\(t\to\infty\). By (9), each packet has weighted diagonal integral
\((\log\kappa+O(1))\|v_a\|_2^2\), uniformly in \(a\).
The weighted cross integral of the two packets is
\(O((\log\kappa)^2/\kappa)\|v_a\|_2^2\): use (9) to bound its
integrand by a constant times
\(\log(2+|t|)/[(1+|t-\kappa|)(1+|t+\kappa|)]\).
Together with (10), this proves
\[
\frac{H_a[\sqrt2F_{a,q}|_{(0,a)}]}{\|F_{a,q}\|_2^2}
=\log\kappa+O(1)\le(m-1)\log Q+O(1),
\tag{11}
\]
with absolute error constants. The jump at \(\pm a\) has Fourier
decay \(O_a(|t|^{-1})\), so these tests belong to the logarithmic
form domain. Finally, (4) follows from (3), and (5) follows from the
prime number theorem applied to
\(\sum_{n<e^a}\Lambda(n)\), with
\(\sum_{n<e^a}\Lambda(n)/n=O(a)\). \(\square\)

The actual signed odd form is
\(\mathcal W_a[u]=H_a[u]-c\|u\|_2^2-S_a[F]+D_a[F]-\mathcal G_a[u]\),
where \(S_a,D_a\) are the **full** row and graph and
\(\mathcal G_a\ge0\). The proposition concerns only
\(\mathsf D_{S,a}\). It refutes a proof strategy that tries to pay
an order-\(e^a\) full-row deficit using phase frustration of a fixed,
or the specified moderately growing, set of prime coordinates.
It neither upper-bounds \(D_a\) nor rules out an all-prime estimate.
Indeed primes near the far end of the window are omitted in (4), and
their count and graph weight grow rapidly with \(a\). An all-test
inequality strong enough to make \(\mathcal W_a\ge0\) at every
window would be the odd Weil positivity criterion, so it needs an
arithmetic argument beyond finite-coordinate irrationality.
Lower bounds for individual nonzero linear forms
\(q\log p-k\log2\), including Baker-type bounds, could make a
fixed-coordinate gap effective. They cannot raise that gap to Schur
order on the energy cap in (3): the explicit Dirichlet tests already
put an upper bound on the best possible gap from those coordinates.
