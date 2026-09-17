# A coefficient countermodel to a terminal-layer sign transfer

This is a countermodel to an inference from the
prime number theorem, the terminal edge-mass law, and the leading Schur norm
to an absolute signed prime bound. It changes the zeta prime coefficients and
therefore makes **no claim about the actual Riemann zeta function or RH**.
Every modified coefficient remains positive, has the same prime-power support,
and uses one common factor for all powers of a given prime.

## Statement

Let \(a_j=2^j\) for all sufficiently large integers \(j\),
\(X_j=e^{2a_j}\), and
\[
 B_j=\{p\text{ prime}:X_je^{-2}<p<X_je^{-1}\}.
\]
There are positive numbers \(\alpha_p\), with \(\alpha_p\to1\) as
\(p\to\infty\), such that the modified prime-power coefficients
\[
 \widetilde\Lambda(p^r)=\alpha_p\log p\qquad(r\ge1)
\tag{1}
\]
have all of the following properties.

1. Their summatory function satisfies
   \(\widetilde\psi(x)=\sum_{n\le x}\widetilde\Lambda(n)=x+o(x)\).
   The weighted Schur row, operator norm, terminal edge-mass law, and
   first-order ordinary-comb law consequently have the same leading terms as
   for \(\Lambda\): the row and norm are \((1+o(1))e^a\), and the
   normalized edge gap \(c=2a-\log n\) has density \(ce^{-c}\).
2. For every \(j\), a real odd, exactly pole-null test \(F_j\) in the
   logarithmic form domain satisfies
   \[
   \|F_j\|_2^2=1+o(1),\qquad
   H_{a_j}[\sqrt2F_j|_{(0,a_j)}]=\log a_j+O(1),
   \qquad
   \langle F_j,\widetilde P_{a_j}F_j\rangle
   =\left(\frac{\beta}{2}+o(1)\right)
      \frac{e^{a_j}}{\sqrt{a_j}},
   \tag{2}
   \]
   where \(\beta=\int_1^2ce^{-c}dc=2/e-3/e^2>0\), and
   \(\widetilde P_a\) is the usual zero-extended prime-shift operator
   with \(\Lambda\) replaced by \(\widetilde\Lambda\).

Thus the formal odd quadratic expression obtained by retaining Suzuki's
archimedean and continuum terms but replacing \(P_a\) by
\(\widetilde P_a\) is negative on these tests for large \(j\). This
expression is a comparison model, not the Weil form of a completed
\(L\)-function. It proves that first-order terminal-layer data do not
determine the signed prime expectation at the \(O(\log a)\) archimedean
scale.

## The pole-null moderate carriers

Put \(Z_a=a+\sinh a=\|\cosh(x/2)\|_{L^2(-a,a)}^2\), and define
\[
 F^0_{a,t}(x)=\sqrt{2/Z_a}\,\cosh(x/2)\sin(tx)
                 \mathbf1_{(-a,a)}(x).
\tag{3}
\]
Its odd pole moment, in the half-line normalization
\(u=\sqrt2F^0|_{(0,a)}\) and \(h(x)=\sqrt2\sinh(x/2)\), is
\[
 \langle h,u\rangle
 =\sqrt{2/Z_a}\,
   \frac{\cosh a\sin(ta)-t\sinh a\cos(ta)}{1+t^2}.
\tag{4}
\]
For any positive integer \(k\), the numerator changes sign in
\((k\pi/a,(k+1/2)\pi/a)\): at the left endpoint it has the sign of
\(-\cos(k\pi)\), while at the right endpoint it has the opposite sign.
Equivalently, \(\tan(ta)=t\tanh a\) has a root there. Choose
\(k_j=\lceil a_j^2/\pi\rceil\) and a root \(t_j\) in this interval.
Then \(t_j=a_j+O(a_j^{-1})\), so \(t_j\to\infty\), and
\(F_j=F^0_{a_j,t_j}\) has exact pole moment zero. Uniform Fourier
envelopes for \(\cosh(x/2)\mathbf1_{(-a,a)}\) give
\[
 \|F_j\|_2^2=1+O(a_j^{-1}),\qquad
 H_{a_j}[\sqrt2F_j|_{(0,a_j)}]/\|F_j\|_2^2
 =\log t_j+O(1)=\log a_j+O(1).
\tag{5}
\]
The jumps at \(\pm a_j\) still belong to the logarithmic form domain.
For completeness, the zero-extended \(v_a=\phi\mathbf1_{(-a,a)}\)
satisfies \(\|v_a\|_1+\operatorname{Var}(v_a)=O(e^{a/2})\) and
\(\|v_a\|_2^2\asymp e^a\). Its normalized Fourier density is therefore
bounded by \(C\min(1,|s|^{-2})\), uniformly in \(a\). The Fourier
transform of (3) is the difference of packets centered at \(\pm t\).
The odd archimedean multiplier is \(\log(2+|s|)+O(1)\) at large
\(|s|\); integration against this envelope gives the second estimate
in (5), with a packet-crossing error \(O((\log t)^2/t)\). The same
variation bound gives the first estimate in (5).

We also need a signed bound for the *actual* prime operator on these
carriers. Write \(X=e^{2a}\), \(c_n=\log(X/n)\), and
\[
 E_{a,n}=\frac{\Lambda(n)}{\sqrt n}
   \int_{-a}^{a-\log n}\phi(x)\phi(x+\log n)dx,
 \qquad C_a(t)=\sum_{n<X}E_{a,n}n^{it},
 \quad \phi(x)=\cosh(x/2).
\]
The exact edge integral is
\[
 E_{a,n}=\frac{\Lambda(n)c_n}{4}(1+n^{-1})
       +\frac{\Lambda(n)}2(e^a/n-e^{-a}).
\tag{6}
\]
Expanding \(\sin(tx)\sin(t(x+\log n))\) and integrating the
oscillatory term by parts gives, uniformly for \(t\ge1\),
\[
 \langle F^0_{a,t},P_aF^0_{a,t}\rangle
 =\frac{2}{Z_a}\left(\Re C_a(t)+O(X/t)\right).
\tag{7}
\]
Indeed, the sum of the absolute oscillatory-edge errors before the
factor \(2/Z_a\) is
\(O(t^{-1}\sum_{n<X}\Lambda(n)(1+e^a/n))=O(X/t)\).

For \(t=a+O(a^{-1})\), one has \(C_a(t)=O(X/a^2)\). Here are the
inputs, to make the absolute estimate explicit. The terms in (6)
other than \(\Lambda(n)c_n/4\) have total absolute mass
\(O(ae^a+a^2)\), and \(n\le e^a\) contributes \(O(ae^a)\) to the
remaining sum. On \([e^a,X]\), Stieltjes integration with
\(\psi(y)=y+R(y)\) and the unconditional bound
\[
 |R(y)|\ll y a^{1/4}\exp(-\sqrt{a/6.455})
 \qquad(e^a\le y\le X)
\tag{8}
\]
shows that
\[
 \sum_{n<X}\Lambda(n)c_n n^{it}
 =\frac{X^{1+it}}{(1+it)^2}
   +O\!\left(ae^a+X(1+t)a^{5/4}
                    e^{-\sqrt{a/6.455}}\right).
\tag{9}
\]
The derivative of \(\log(X/y)y^{it}\) is
\(O((1+t)a/y)\) on this interval. Bound (8) is a coarse consequence
of [Trudgian's explicit \(\psi\) estimate](https://arxiv.org/html/1401.2689v2),
Theorem 1. The error in (9) is \(o(X/a^2)\) when \(t=a+O(a^{-1})\).
Equations (6)--(9), \(Z_a\sim e^a/2\), and \(t_j\sim a_j\) imply
\[
 \langle F_j,P_{a_j}F_j\rangle=O(e^{a_j}/a_j).
\tag{10}
\]
The \(O(X/t)\) oscillatory edge error is the dominant term in this
bound. It is small relative to the row \(e^a\), but still far larger
than \(H_a[F_j]\asymp\log a\).

## A positive perturbation on disjoint terminal blocks

Let \(\varepsilon_j=a_j^{-1/2}\). For \(p\in B_j\), set
\[
 \alpha_p=1+\varepsilon_j\cos(t_j\log p),
\tag{11}
\]
and set \(\alpha_p=1\) for all other primes. The blocks are disjoint,
\(1-\varepsilon_j\le\alpha_p\le1+\varepsilon_j\), and
\(\alpha_p\to1\). Every power of an affected prime receives the same
factor in (1).

The modification preserves the prime number theorem. Given \(\eta>0\),
choose \(J\) such that \(|\alpha_p-1|\le\eta\) for all bases in
blocks \(B_j\) with \(j\ge J\). The finitely many earlier bases
contribute \(O_J(\log x)\) to
\(|\widetilde\psi(x)-\psi(x)|\), while the remaining bases contribute
at most \(\eta\psi(x)\). Hence
\(\widetilde\psi(x)=\psi(x)+o(x)=x+o(x)\).
Since \(0<\widetilde\Lambda(n)\le2\Lambda(n)\) on prime powers,
\(\sum_{n<x}\widetilde\Lambda(n)/n=O(\log x)\). The exact Schur-row
formula and the edge-mass calculation use only these estimates, so
they give \(\widetilde r_a(x)=e^a+o(e^a)\) uniformly,
\(\|\widetilde P_a\|=(1+o(1))e^a\), and the same terminal law
\(ce^{-c}dc\).
More explicitly, let
\(\widetilde H_1(y)=\sum_{n<y}\widetilde\Lambda(n)/n\) and
\(\widetilde\Psi_<(y)=\sum_{n<y}\widetilde\Lambda(n)\). The exact
row formula is
\[
2(\widetilde P_a\phi)(x)
=e^{x/2}\{\widetilde\Psi_<(e^{a-x})+\widetilde H_1(e^{a+x})\}
 +e^{-x/2}\{\widetilde H_1(e^{a-x})+\widetilde\Psi_<(e^{a+x})\}.
\]
For every \(\eta>0\), the PNT estimate can be written
\(|\widetilde\psi(y)-y|\le\eta y+C_\eta\) for all \(y\ge1\).
Substitution proves the uniform row assertion. Replacing
\(\Lambda\) by \(\widetilde\Lambda\) in (6) and applying the same
summatory estimate proves the Gamma edge law.

At window \(a_j\), later blocks contain no admitted prime base:
\(\min B_{j+1}>X_j\) for large \(j\). Earlier blocks, including all
their admitted powers, give an operator perturbation of norm
\[
 \ll\sum_{k<j}\varepsilon_k
       \sum_{p\in B_k}\sum_{r\ge1}\frac{\log p}{p^{r/2}}
 \ll\sum_{k<j}\varepsilon_k e^{a_k}
 =O(j e^{a_{j-1}})
 =o(e^{a_j}/\sqrt{a_j}).
\tag{12}
\]

The current block has only first powers below \(X_j\), since
\(p>X_je^{-2}>\sqrt{X_j}\) for large \(j\). For the normalized
carrier (3), direct sine-product expansion gives its signed increment
\[
 \begin{aligned}
 \Delta_j
 &=\langle F_j,(\widetilde P_{a_j}-P_{a_j})_{B_j}F_j\rangle\\
 &=\frac{2\varepsilon_j}{Z_{a_j}}
   \sum_{p\in B_j}\left[
     E_{a_j,p}\cos^2(t_j\log p)
     -w_pJ_{a_j,p}(t_j)\cos(t_j\log p)\right],
 \end{aligned}
\tag{13}
\]
where \(w_p=(\log p)/\sqrt p\) and
\(J_{a,p}(t)=\int_{-a}^{a-\log p}
 \phi(x)\phi(x+\log p)
 \cos(2tx+t\log p)dx\).
The summed \(J\) term is \(O(X_j/t_j)\).

Let \(\beta=\int_1^2ce^{-c}dc\). The terminal law gives
\(\sum_{p\in B_j}E_{a_j,p}=(\beta/4+o(1))X_j\). Also
\[
 \sum_{p\in B_j}E_{a_j,p}e^{2it_j\log p}=o(X_j).
\tag{14}
\]
For (14), use (6) to replace \(E_{a_j,p}\) by
\((\log p)c_p/4\) at \(o(X_j)\) cost, then integrate
\(c_xx^{2it_j}\) against \(d\vartheta(x)\) on
\((X_je^{-2},X_je^{-1})\). The continuous integral is
\(O(X_j/t_j)\); Trudgian's \(\vartheta(x)-x\) bound and integration
by parts make the discrepancy \(o(X_j)\) because \(t_j\asymp a_j\).
Taking real parts of (14) yields
\[
 \sum_{p\in B_j}E_{a_j,p}\cos^2(t_j\log p)
 =\left(\frac\beta8+o(1)\right)X_j.
\]
Since \(2/Z_{a_j}\sim4e^{-a_j}\), equation (13) becomes
\[
 \Delta_j
 =\left(\frac\beta2+o(1)\right)
       \varepsilon_j e^{a_j}.
\tag{15}
\]
The errors in (10) and (12) are smaller than (15), proving (2).

Finally the actual odd decomposition has the sign pattern
\(\mathcal W_a[u]=H_a[u]-c\|u\|_2^2
-\langle F,P_aF\rangle-\mathcal G_a[u]\), with
\(\mathcal G_a\ge0\); see
[Suzuki's Fourier formulas](https://arxiv.org/html/2606.09096v2)
and the [odd graph identity](https://github.com/arterialist/proofs/blob/main/building-blocks/odd-prime-graph-logarithmic-uncertainty.md).
Replacing only \(P_a\) by \(\widetilde P_a\) in this expression gives
\(\widetilde{\mathcal W}_{a_j}[u_j]<0\) by (2).
The raw tests can be approximated in the logarithmic form norm by
compactly supported smooth odd tests. Correct a small pole moment
with a fixed smooth bump at each window, then choose the approximation
error sufficiently small to preserve the strict negative sign. No
functional equation is asserted for the modified Euler factors.

The countermodel leaves a precise gap: the PNT and the positive
terminal-layer law control mass at scale \(e^a\), while the formal odd
Weil expression on these carriers contains a signed prime expectation of
size \(e^a/\sqrt a\) against archimedean energy \(O(\log a)\).
A successful bound for the actual zeta coefficients must control the
**combined** signed prime and continuum terms using arithmetic
information absent from those first-order mass statements. In Fourier
terms, weak convergence of the terminal measure does not control its
coefficient at a frequency \(t_a\to\infty\); the perturbation in
(11) changes precisely that coefficient while leaving its total mass
and weak limit unchanged.

A complementary [sparse prime-weight countermodel](../prime-distribution/sparse-prime-weight-ground-positive-terminal-sign-countermodel.md)
retains a positive factorial ground and coherent factors across all
powers while making a fixed bounded-arch terminal score alternate with
unbounded magnitude. The present construction instead tests the full
formal odd quadratic expression on moderate carriers. Both modify the
zeta coefficients; neither supplies a negative test for the actual Weil
form.
