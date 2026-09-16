# Causal renewal and Euler-discrepancy audit

This note checks the integer-minus-continuum formulas used in the causal
renewal equation. It uses no BIBO assertion and no zero-free hypothesis.

## 1. Endpoint convention and the first primitive

Put

\[
S_n=\sum_{m=1}^n m^{-1/2},\qquad
E(u)=S_{\lfloor e^u\rfloor}-2(e^{u/2}-1),\qquad
c=2+\zeta(1/2).
\]

The sum is right-continuous: the integer \(m=n\) is present at
\(u=\log n\). Thus \(E(0)=1\), and the causal discrepancy

\[
H(u)=1_{u\geq0}(E(u)-c)
\]

has right trace \(H(0+)=1-c\). On the half-open cell
\([\log n,\log(n+1))\),

\[
H(u)=A_n-2e^{u/2},\qquad A_n=S_n-\zeta(1/2).                 \tag{1}
\]

Consequently \(DH\) has an origin atom \((1-c)\delta _0\), interior
atoms \(n^{-1/2}\delta_{\log n}\) for \(n\geq2\), and density
\(-e^{u/2}\,du\). Therefore the endpoint-exact identity is

\[
\boxed{\nu-\kappa=c\delta _0+DH},                           \tag{2}
\]

where \(\nu=\sum_{n\geq1}n^{-1/2}\delta_{\log n}\) and
\(\kappa=e^{u/2}1_{u\geq0}\,du\). At the origin the two atoms add to
one, as required. A left-continuous floor convention would miss this check.

Let

\[
J(u)=\int_0^uH(s)\,ds,\qquad j_n=J(\log n),\qquad
q_n=j_{n+1}-j_n.
\]

With \(a=\sqrt n\), \(b=\sqrt{n+1}\), direct integration of (1) gives

\[
q_n=2\log(b/a)\{A_n-2L(a,b)\},\qquad
L(a,b)=\frac{b-a}{\log b-\log a}.                           \tag{3}
\]

There is no seam term because \(J\) is continuous.

## 2. Cell signs

The exact trapezoid remainder gives

\[
A_n=2\sqrt n+\frac1{2\sqrt n}-\frac1{24n^{3/2}}+r_n,
\qquad 0<r_n<\frac1{384n^{7/2}}.                            \tag{4}
\]

Also

\[
2L(\sqrt n,\sqrt{n+1})
 <2\sqrt n+\frac1{2\sqrt n}-\frac1{8(n+1)^{3/2}}.
\]

Since \((n+1)^{3/2}/n^{3/2}\leq2\sqrt2<3\), the last negative term
has magnitude greater than \(1/(24n^{3/2})\). Equations (3) and (4)
therefore prove

\[
q_n>0.                                                       \tag{5}
\]

Moreover \(2\sqrt n<A_n<2\sqrt{n+1}\). Hence \(H\) crosses zero
exactly once in each cell, from positive to negative. Since the right
endpoint of the \(J\)-cell is higher by \(q_n\), the within-cell path
never falls below its left endpoint.

For \(u=\log n+t\), \(0\leq t<\log(1+1/n)\), define

\[
Q(u)=j_n,\qquad R(u)=J(u)-j_n.
\]

Then

\[
R(\log n+t)=A_nt-4\sqrt n(e^{t/2}-1)\geq0.                 \tag{6}
\]

Thus \(J=Q+R\), with \(Q\) nondecreasing and \(R\) a nonnegative
arch. At \(\log(n+1)\), \(Q\) jumps upward by \(q_n\) and \(R\)
resets from \(q_n\) to zero. These are artificial opposite jumps; their
sum \(J\) is continuous.

## 3. Centered tail and its sign

Expanding the two terms in (3) gives

\[
q_n=\frac1{8n^{5/2}}+O(n^{-7/2}),\qquad
\ell-j_n=\frac1{12n^{3/2}}+O(n^{-5/2}),                    \tag{7}
\]

where \(\ell=\sum_{n\geq1}q_n=\int_0^\infty H\). On the \(n\)-th
cell, \(|H|\leq n^{-1/2}\) and the cell length is at most \(n^{-1}\),
so \(0\leq R\leq n^{-3/2}\). Therefore

\[
\boxed{J(u)-\ell=O(e^{-3u/2})}                              \tag{8}
\]

uniformly through the logarithmic endpoints.

The decay does not have a one-sided sign. At
\(u=\log n+\theta/n\), for fixed \(0\leq\theta<1\),

\[
n^{3/2}(J(u)-\ell)
 \longrightarrow-\frac1{12}+\frac\theta2-\frac{\theta^2}2.
\tag{9}
\]

The limit is \(-1/12\) at \(\theta=0\) and \(+1/24\) at
\(\theta=1/2\). This is an explicit counterexample to any claimed
eventual fixed sign of the centered memory. It agrees with the leading
Bernoulli profile \(-B_2(\theta)/(2n^{3/2})\).

## 4. Correct response identity and traces

Extend \(\widetilde J=(J-\ell)1_{u\geq0}\) causally. Its right trace is
\(-\ell\), and

\[
D\widetilde J=H\,du-\ell\delta_0,
\qquad
\nu-\kappa=c\delta_0+\ell\delta_0'+D^2\widetilde J.         \tag{10}
\]

Hence, with distributional derivatives of zero extensions,

\[
\boxed{\mathcal Zh=\mathcal Kh+ch+\ell Dh+\widetilde J*D^2h}. \tag{11}
\]

If the original renewal equation is \(\mathcal Zh=g\), this is the
claimed second-order response. On a purely causal half-line it must be
written with the history-corrected forcing

\[
g_{\rm causal}(v)=g(v)-\sum_{\log m>v}m^{-1/2}h(v-\log m),  \tag{12}
\]

unless the negative-time history is zero.

There is a second convention that cannot be suppressed. If \(h\) is
classically twice differentiable on the right with traces
\(h_0=h(0+)\), \(h_1=h'(0+)\), then the regular part of the last two
terms in (11) is

\[
\ell h'_{\rm cl}+\widetilde J*h''_{\rm cl}
       +h_1\widetilde J+h_0H.                               \tag{13}
\]

The origin atoms \(\ell h_0\delta_0\) and
\(-\ell h_0\delta_0\) cancel. Thus

\[
\ell h'+ch+\mathcal Kh+\widetilde J*h''=g                  \tag{14}
\]

is exact as written only with causal distributional derivatives. With
classical derivatives, (12) and the two trace functions in (13) are the
required correction.

## 5. A finite-horizon inequality from the linked cells

The positive increments and arches give more than separate positivity.
Set \(a_n=\log(n+1)\). The step part has the exact linked expansion

\[
Q(u)=\sum_{n\geq1}q_n1_{[a_n,\infty)}(u).                  \tag{15}
\]

Since \(\widetilde J=Q+R-\ell1_{[0,\infty)}\), causal primitive
calculus gives, for \(f=Dh\),

\[
\boxed{
\ell f+\widetilde J*Df
 =\sum_{n\geq1}q_nT_{a_n}f+R*Df.}                          \tag{16}
\]

This identity keeps the increments and their arches linked; replacing
either family independently loses (16).

Here is one unconditional finite-horizon consequence. Let
\(h\in H^2(0,T)\), assume \(h(0+)=0\), put
\(f=h'_{\rm cl}1_{[0,\infty)}\), and retain
\(h_1=h'(0+)\). For \(x\geq0\), use

\[
\|v\|_{x,T}^2=\int_0^T e^{-2xu}|v(u)|^2du
\]

and define

\[
A_{x,T}=\sum_{a_n<T}q_ne^{-xa_n},\quad
B_{x,T}=\int_0^T e^{-xs}R(s)ds,\quad
C_{x,T}=\left(\int_0^T e^{-2xs}R(s)^2ds\right)^{1/2}.       \tag{17}
\]

Weighted translation is contractive with
\(\|T_af\|_{x,T}\leq e^{-xa}\|f\|_{x,T}\), and weighted Young gives
\(\|R*h''\|_{x,T}\leq B_{x,T}\|h''\|_{x,T}\). Since
\(Df=h''_{\rm cl}1_{[0,\infty)}+h_1\delta_0\), (16) yields

\[
\boxed{
\begin{aligned}
\Re\langle\ell h'+\widetilde J*D^2h,h'\rangle_{x,T}
\geq{}&-A_{x,T}\|h'\|_{x,T}^2\\
&-\bigl(B_{x,T}\|h''\|_{x,T}
       +|h_1|C_{x,T}\bigr)\|h'\|_{x,T}.
\end{aligned}}                                             \tag{18}
\]

All constants are explicit positive cell quantities. For finite \(T\),

\[
A_{x,T}<\sum_{n\geq1}q_n=\ell.                             \tag{19}
\]

Equation (18) is a genuine finite-horizon energy inequality, but it is
not the missing coercivity theorem: the arch term pays one derivative,
and \(A_{0,T}\uparrow\ell\).

The obstruction is already exact on the first cell. If
\(T<\log2\) and \(h_\omega=e^{i\omega v}\phi(v)\), with nonzero
\(\phi\in C_c^\infty(0,T)\), then \(\mathcal Zh_\omega=h_\omega\).
Therefore

\[
\Re\langle\widetilde J*h_\omega'',h_\omega'\rangle
=-\ell\|h_\omega'\|_2^2+O_{\phi,T}(1+|\omega|).             \tag{20}
\]

Thus the actual memory can cancel the entire nominal local damping for
arbitrary inputs. The linked-cell inequality (18) is unconditional;
turning it into a useful estimate for the distinguished arithmetic heat
requires control of its correlated head and initial history, not a BIBO
equivalence.

## Conclusion

The endpoint formula, positive cell increments, nonnegative arches, and
the \(e^{-3u/2}\) centered remainder are correct. The centered remainder
does change sign, as (9) shows. The response equation is correct in the
causal distributional convention; its classical form requires the history
correction (12) and the trace terms (13). Equation (18) is the finite-horizon
energy statement supplied directly by the linked step/arch geometry. It
also displays why that geometry alone does not close the RH-strength
coercivity problem.
