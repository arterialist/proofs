# Complete-clock weighted flux and exact prime-pair energy

RH Agent3, 2026-09-17. **Status:** unconditional written identity for the actual factorial ground and the complete prime-power clock. It gives a positive bulk energy and an unconditional lower floor for a *corrected flux difference*. It does not bound the signed score, prove RH, or constitute a Lean formalization.

Let \(\psi(x)=\sum_{n\le x}\Lambda(n)\) be right-continuous, \(E(x)=\psi(x)-x\), and let \(F(x)>0\) be the actual factorial ground, with \(F'(x)=-E(x)/x^2\) and \(F(x)\to\kappa_F=1+\gamma>0\). For \(u\ge\log2\), put
\[
r(u)=\frac{E(e^u)}{e^uF(e^u)}.
\]
The prime number theorem makes \(r\) bounded on this half-line and \(r(u)\to0\). At every fixed clock \(s\ge0\), use the *complete* age law \(\mathsf P_s\), including its no-jump mass \(p_s=e^{-\lambda s}\) and every ordinary-prime and proper-power history, and set
\[
h(t)=t e^{-t/2}{\bf1}_{t\ge0},\quad
j_s=h*\mathsf P_s,\quad H_s=j_s^2,\quad K_s=H_s-H_s',\quad
T_Aq(u)=\int_0^\infty A(t)q(u+t)\,dt.
\]
The [complete original-ground score](factorial-f-ground-fixed-positive-clock-measure-inverse.md) is
\[
G_s(u)=\int_{[e^u,\infty)}
 \frac{H_s(\log(x/e^u))}{xF(x)}\,dE(x)
=T_{K_s}r(u)-T_{H_s}(r^2)(u).                         \tag{1}
\]
The Stieltjes source in (1) is literally \(dE=\sum_{n\ge2}\Lambda(n)\delta_n-dx\); the lower prime-power atom has zero coefficient since \(H_s(0)=0\). No clock history or continuous density has been dropped.

## Positive flux before endpoint correction

Young's inequality gives \(j_s\in H^1\cap L^2\) because \(\mathsf P_s\) is a probability measure and \(h,h'\in L^2\). Consequently \(H_s,H_s'=2j_sj_s'\in L^1\) and \(H_s(0)=0\). Future convolution against a bounded, possibly jumping \(r\) is therefore locally absolutely continuous, with
\[
\frac d{du}T_{H_s}r(u)=-T_{H_s'}r(u)
\quad\text{for almost every }u.
\]
There is no boundary distribution from \(r\)'s prime-power jumps: translation of the \(W^{1,1}\) kernel gives this derivative, and \(H_s(0)=0\). Define \(M_s(u)=e^uT_{H_s}r(u)\). Then
\[
M_s'(u)=e^uT_{K_s}r(u),\qquad
\boxed{M_s(V)-M_s(U)-\int_U^V e^uG_s(u)\,du
=\int_U^V e^uT_{H_s}(r^2)(u)\,du\ge0}              \tag{2}
\]
for every \(\log2\le U<V\). This identity includes both finite endpoints.

The no-jump clock mass makes the right side quantitatively coercive in the original ground metric. Since \(j_s(t)\ge p_sh(t)\), restrict the right side of (2) to \(0\le t\le1\), change variable \(v=u+t\), and retain \(U+1\le v\le V\). For \(V\ge U+1\), this gives
\[
M_s(V)-M_s(U)-\int_U^V e^uG_s(u)du
\ge p_s^2 c_0\int_{U+1}^V e^v r(v)^2dv
=p_s^2c_0\int_{e^{U+1}}^{e^V}\frac{E(x)^2}{x^2F(x)^2}dx,
\quad c_0=\int_0^1t^2e^{-2t}dt=\frac{1-5e^{-2}}4>0. \tag{3}
\]
The factor \(p_s^2\) is positive for each fixed clock but shrinks with \(s\); (3) asserts no clock-uniform lower bound.

## Exact finite-window endpoint square

The boundary correction removes even the unit collar in (3). Define
\[
a_s=\int_0^\infty H_s(t)e^{-t}dt>0,\qquad
b_s(\tau)=e^\tau\int_\tau^\infty H_s(t)e^{-t}dt\quad(\tau\ge0).
\]
Both are finite, \(b_s\ge0\), and Tonelli gives
\(\|b_s\|_1=\int_0^\infty H_s(t)(1-e^{-t})dt\le\|H_s\|_1\).
For any bounded measurable \(q\), Fubini and \(v=u+t\) yield the finite-interval identity
\[
\boxed{\int_U^V e^uT_{H_s}q(u)du
=a_s\int_U^V e^v q(v)dv
 +\big[e^uT_{b_s}q(u)\big]_{u=U}^{u=V}.}            \tag{4}
\]
Indeed the shifted interval \([U+t,V+t]\) contributes the base \([U,V]\), an upper collar \([V,V+t]\), and a lower collar \([U,U+t]\), with respective signs \(+,+,-\). Their tail coefficients are precisely \(b_s\). Boundedness of \(q\), \(H_s\in L^1\), and \(b_s\in L^1\) justify each exchange on a finite \(u\)-window.

Set
\[
\mathcal C_s(u)=e^u\{T_{H_s}r(u)-T_{b_s}(r^2)(u)\}.
\]
Combining (2) and (4) with \(q=r^2\) proves the exact **complete-clock weighted-flux identity**
\[
\boxed{\mathcal C_s(V)-\mathcal C_s(U)-\int_U^V e^uG_s(u)du
=a_s\int_U^V e^v r(v)^2dv
=a_s\int_{e^U}^{e^V}\frac{E(x)^2}{x^2F(x)^2}dx\ge0.} \tag{5}
\]
Since \(j_s\ge p_sh\), \(a_s\ge p_s^2/4\). At clock zero one can check every coefficient explicitly:
\[
H_0(t)=t^2e^{-t},\qquad a_0=\frac14,\qquad
b_0(t)=e^{-t}\left(\frac{t^2}{2}+\frac t2+\frac14\right).
\]
Formula (5) is an exact positive birth/endpoint balance in the original \(F\)-metric. It is not a sign statement for \(G_s(u)\) at a point: both endpoint values of \(\mathcal C_s\) and the integrated score are signed.

## Unconditional growth of the corrected difference

[Brent, Platt and Trudgian](https://arxiv.org/pdf/2008.06140) prove unconditionally that, for all sufficiently large \(X\),
\[
\int_X^{2X}E(x)^2dx\ge\frac{X^2}{5374}.          \tag{6}
\]
Choose \(U\) sufficiently large that (6) applies at \(X=e^U\) and later scales and \(F(x)\le M_F\) for \(x\ge e^U\), with any fixed \(M_F>\kappa_F\). On each full dyadic block \([X,2X]\),
\[
\int_X^{2X}\frac{E(x)^2}{x^2F(x)^2}dx
\ge\frac1{4\cdot5374\,M_F^2}.
\]
Thus, with \(N=\lfloor(V-U)/\log2\rfloor\), (5) gives the actual-source lower floor
\[
\boxed{\mathcal C_s(V)-\mathcal C_s(U)-\int_U^V e^uG_s(u)du
\ge\frac{a_sN}{4\cdot5374\,M_F^2}
\ge\frac{p_s^2N}{16\cdot5374\,M_F^2}.}           \tag{7}
\]
The positive difference grows at least linearly in the number of complete logarithmic dyadic blocks for each fixed \(s\). It supplies no upper bound for the energy or for either signed term on the left of (7). In particular, it does not pay the RH-equivalent pointwise estimate for the actual full score.

## Exact Goldbach-coordinate expansion of the bulk

For \(A=e^U\), \(B=e^V\), write \(w_F(x)=1/(x^2F(x)^2)\) and, with value zero if the lower limit is at least \(B\), define
\[
\mathcal K_{A,B}(y)=\int_{\max(A,y)}^B w_F(x)dx,\qquad
\mathcal L_{A,B}(y)=\int_{\max(A,y)}^B\frac{dx}{xF(x)^2}.
\]
Expanding \(E(x)^2=(\psi(x)-x)^2\) on the finite interval, and interchanging only finite sums with integrals, gives
\[
\boxed{\begin{aligned}
\int_A^B\frac{E(x)^2}{x^2F(x)^2}dx
={}&\sum_{m,n\le B}\Lambda(m)\Lambda(n)\,
  \mathcal K_{A,B}(\max(m,n))\\
&-2\sum_{n\le B}\Lambda(n)\,\mathcal L_{A,B}(n)
  +\int_A^B\frac{dx}{F(x)^2}.
\end{aligned}}                                                   \tag{8}
\]
At \(A\) or \(B\), the inclusion of an atom in a finite sum changes no Lebesgue integral, so (8) is valid without an endpoint convention shortcut. It includes every \(\Lambda(p^k)\), including proper powers, and both density-centering terms.

Regroup the ordered pair term by the additive total \(k=m+n\) and gap \(d=|m-n|\):
\[
\sum_{k\le2B}\ \sum_{\substack{m+n=k\\2\le m,n\le B}}
\Lambda(m)\Lambda(n)\,
\underbrace{\int_{\max(A,(k+|m-n|)/2)}^B\frac{dx}{x^2F(x)^2}}
_{\displaystyle\mathcal K_{A,B}((k+|m-n|)/2)}.          \tag{9}
\]
Equation (9) is an exact Goldbach-coordinate bridge: the ordinary-prime sector counts weighted representations \(k=p+q\), while proper-power sectors remain present. The kernel depends on the gap as well as the total, and (8) subtracts the single-prime and continuous terms. Existence of one Goldbach representation for an even \(k\) therefore gives neither an upper bound for the bulk nor a sign for \(G_s\). A usable additive theorem would have to control the weighted pair distribution and its two exact centering terms at the needed scale.

## The gap correction is macroscopic for the actual prime source

The gap in (9) cannot be treated as a lower-order endpoint error. Set
\(A=X\), \(B=2X\), and keep the actual \(F\)-weight
\(w_F(x)=1/(x^2F(x)^2)\). Compare the true positive pair term
\[
 P_X=\sum_{m,n\le2X}\Lambda(m)\Lambda(n)
       \mathcal K_{X,2X}(\max(m,n))
 \tag{10}
\]
with the total-only, but still cutoff-preserving, additive surrogate
\[
 T_X=\sum_{m,n\le2X}\Lambda(m)\Lambda(n)
       \mathcal K_{X,2X}((m+n)/2).
 \tag{11}
\]
Thus \(T_X\) can be regrouped by the **clipped** Goldbach total
\(G_{2X}(k)=\sum_{m+n=k,\,m,n\le2X}\Lambda(m)\Lambda(n)\).
Using the untruncated Goldbach total would add still more terms.
Since \((m+n)/2\le\max(m,n)\) and \(\mathcal K\) decreases,
\(D_X:=T_X-P_X\ge0\) term by term. More explicitly,
\[
 D_X=\sum_{m,n\le2X}\Lambda(m)\Lambda(n)
 \int_{\max(X,(m+n)/2)}^{\max(X,m,n)}w_F(x)\,dx.
 \tag{12}
\]

**Proposition.** Unconditionally, for the complete von Mangoldt
source, including all proper powers,
\[
 P_X\sim\frac X{\kappa_F^2},\qquad
 T_X\sim\frac{(8\log2-4)X}{\kappa_F^2},\qquad
 \boxed{D_X\sim\frac{(8\log2-5)X}{\kappa_F^2}},
 \quad \kappa_F=1+\gamma.
 \tag{13}
\]
The last constant is positive: \(8\log2-5>1/3\), since
\(\log2>2/3\).

Here is a proof using only the [prime number theorem in the form
\(\psi(x)=x+o(x)\)](https://dlmf.nist.gov/25.16.i) and
\(F(x)\to\kappa_F\). Fubini makes
\(P_X=\int_X^{2X}\psi(x)^2w_F(x)dx\), proving its asymptotic.
For \(T_X\), set
\(\mu_X=X^{-1}\sum_{n\le2X}\Lambda(n)\delta_{n/X}\).
The prime number theorem gives weak convergence of \(\mu_X\) to
Lebesgue measure on \([0,2]\), hence of \(\mu_X\otimes\mu_X\) to
Lebesgue measure on \([0,2]^2\). For fixed \(1\le v\le2\), the
line \(u+w=2v\) has zero limiting area, so
\[
 X^{-2}\sum_{\substack{m,n\le2X\\m+n\le2Xv}}
       \Lambda(m)\Lambda(n)
 \longrightarrow
 \operatorname{area}\{(u,w)\in[0,2]^2:u+w\le2v\}
 =4-2(2-v)^2.
 \tag{14}
\]
The left side is uniformly bounded by \((\psi(2X)/X)^2\).
Dominated convergence, with \(x=Xv\) and
\(F(Xv)\to\kappa_F\) uniformly for \(1\le v\le2\), now gives
\[
 \frac{T_X}{X}\longrightarrow
 \frac1{\kappa_F^2}\int_1^2
 \frac{4-2(2-v)^2}{v^2}\,dv
 =\frac{8\log2-4}{\kappa_F^2}.
 \tag{15}
\]
Subtracting the limit for \(P_X\) proves (13). The difference
has positive geometric density
\((2-v)(3v-2)/v^2\) on \(1\le v<2\).

The two centering terms in (8) each have leading magnitude
\(X/\kappa_F^2\): specifically,
\(\sum_n\Lambda(n)\mathcal L_{X,2X}(n)
=\int_X^{2X}\psi(x)/(xF(x)^2)dx\sim X/\kappa_F^2\), and
\(\int_X^{2X}F(x)^{-2}dx\sim X/\kappa_F^2\).
They cancel the leading \(P_X\) term, leaving the true
\(F\)-ground energy
\(\int_X^{2X}E(x)^2/(x^2F(x)^2)dx=o(X)\) by the prime number theorem.
Replacing \(P_X\) by \(T_X\) while retaining those exact centering
terms instead creates the spurious positive main term
\((8\log2-5)X/\kappa_F^2\). Thus an additive-total Goldbach estimate
must retain or pay the full gap distribution before it can bound the
original-metric flux at an RH-relevant scale. This proposition does
not prove a new bound for that flux or RH.
