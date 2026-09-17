# The actual short-time source norm as a signed psi correlation

This written proof retains the actual frozen source, every prime power, both endpoint corrections and the entire two-history age law. It gives a direct Abel reconstruction as well as a meromorphic proof of the growth-exponent criterion. The subpower arithmetic bound remains open. The [complete process](../successor-and-division/positive-successor-seed-jump-process.md) has separate Lean coverage; none of the source-correlation or exponent theorems below is formalized by those modules.

Let
$$
 E(x)=\psi(x)-x,\quad E_N(x)=E(\min(x,N)),\quad
 a_N(v)=e^{-v/2}E_N(e^v)\mathbf1_{v\ge0},\qquad N\ge2.
\tag{1}
$$
Every value of $\psi$ includes all prime powers at the right endpoint. Retain the complete prime-only process
$$
 \mu_t=e^{-\lambda t}\delta_0+m_t(v)dv,\quad
 T_tf=\mu_t*f,\quad
 \Phi(z)=\int_0^\infty(1-e^{-zv})F(v)dv.
\tag{2}
$$
Its finite Lévy measure includes every depth of every prime. The norm below is original $L^2(dv)$, unitarily equal to physical $L^2(dx)$.

The actual target is exactly an average of signed two-scale $\psi$ correlations with explicit frozen-tail terms. The proved process variation estimate and a primary unconditional PNT estimate yield a logarithmic smoothing gain. A separate small-Laplace-parameter test shows that subpower growth at even one fixed time coefficient $c>0$ would imply RH.

## 1. Exact two-history correlation and frozen endpoints

Define the even real correlation
$$
 \Gamma_N(r)=\int_{\mathbb R}a_N(v)a_N(v+r)dv.
$$
For $r\ge0$, changing variables gives
$$
 \boxed{\Gamma_N(r)=e^{-r/2}\int_1^\infty
                  E_N(x)E_N(e^rx)\frac{dx}{x^2}.}
\tag{3}
$$
Write $L=\log N$. For $0\le r\le L$, the exact split is
$$
 \boxed{\begin{aligned}
 \Gamma_N(r)=e^{-r/2}\bigg[
 &\int_1^{Ne^{-r}}E(x)E(e^rx)\frac{dx}{x^2}\\
 &+E(N)\int_{Ne^{-r}}^NE(x)\frac{dx}{x^2}
 +\frac{E(N)^2}{N}\bigg].
 \end{aligned}}
\tag{4}
$$
The second term has one frozen sample and the third has two. For $r\ge L$, put
$$
 D_N(s)=-1+\sum_{2\le n\le N}\Lambda(n)n^{-s}
                         -\int_1^Nx^{-s}dx.
\tag{5}
$$
Stieltjes integration by parts, with $E(1)=-1$, gives
$$
 \boxed{\Gamma_N(r)=e^{-r/2}E(N)D_N(1),\qquad r\ge L.}
\tag{6}
$$
Thus the large-separation correlation is retained and is not assigned a positive sign.

Let $\widetilde\mu_t$ be the reflected measure, and let
$\omega_t=\mu_t*\widetilde\mu_t$. This is the difference law of two independent complete ages. Then
$$
 \boxed{\|T_ta_N\|_2^2=\int_{\mathbb R}\Gamma_N(r)\omega_t(dr).}
\tag{7}
$$
Absolute Fubini follows because the integral of the absolute product of any two translates is at most $\|a_N\|_2^2$, by Cauchy--Schwarz. The no-jump term remains:
$$
 \omega_t=e^{-2\lambda t}\delta_0+q_t(r)dr,\qquad
 q_t=e^{-\lambda t}(m_t+\widetilde m_t)+m_t*\widetilde m_t.
\tag{8}
$$
The measure is nonnegative, while its actual arithmetic integrand in (7) is signed.

## 2. Exact Mellin form

For $\Re s>0$, the literal frozen extension satisfies
$$
 \int_1^\infty E_N(x)x^{-s-1}dx=\frac{D_N(s)}s.
\tag{9}
$$
Indeed $E_N$ is the cumulative mass of
$$
 -\delta_1+\sum_{2\le n\le N}\Lambda(n)\delta_n
                              -\mathbf1_{(1,N)}dx.
$$
There is no extra terminal atom. Formula (9) keeps the seed, the admitted endpoint and the constant cumulative tail.

Under $\widehat a(\xi)=\int e^{-i\xi v}a(v)dv$, Plancherel therefore gives
$$
 \boxed{\|T_ta_N\|_2^2=
 \frac1{2\pi}\int_{\mathbb R}e^{-2t\Re\Phi(i\xi)}
       \frac{|D_N(1/2+i\xi)|^2}{1/4+\xi^2}\,d\xi.}
\tag{10}
$$
The finite expression $D_N$ is entire, with its continuous integral evaluated by the removable limit at $s=1$. No infinite Dirichlet series is substituted on the critical line.

The [established actual tail](../successor-and-division/collective-successor-seed-long-memory.md) $F(v)\sim2/v^2$ gives
$$
 \Re\Phi(i\xi)\sim\pi|\xi|,\qquad \xi\to0.
\tag{11}
$$
Separate a fixed bounded interval, whose contribution is $O(\xi^2)$, and rescale $u=|\xi|v$ on the tail. Dominated convergence follows from $F(v)\le C/v^2$ and
$\int_0^\infty(1-\cos u)u^{-2}du=\pi/2$.
At $t=cL$, frequencies $|\xi|\lesssim1/L$ therefore retain a multiplier bounded away from zero. A large-frequency Dirichlet-polynomial mean square does not replace the required narrow-band control.

## 3. An unconditional logarithmic smoothing gain

The [complete-process variation theorem](dyadic-prime-process-variation.md)
gives $\operatorname{Var}(m_t)\le C/t$ for $t\ge1$. Whole-line integrable BV densities have zero limits at both infinities. Nonnegativity then implies
$$
 \|m_t\|_\infty\le\tfrac12\operatorname{Var}(m_t)\le C/t,
 \qquad \|q_t\|_\infty\le C/t.
\tag{12}
$$
The latter bound follows directly from (8), using $\|m_t\|_1\le1$.
The exact source norms are
$$
 \|a_N\|_1=\int_1^N|E(x)|x^{-3/2}dx+\frac{2|E(N)|}{\sqrt N},
\quad
 \|a_N\|_2^2=\int_1^N|E(x)|^2x^{-2}dx+\frac{|E(N)|^2}{N}.
\tag{13}
$$
Tonelli gives $\int|\Gamma_N|\le\|a_N\|_1^2$. Applying an absolute bound only after retaining (7) proves
$$
 \boxed{\|T_ta_N\|_2^2
 \le e^{-2\lambda t}\|a_N\|_2^2+\frac Ct\|a_N\|_1^2,\qquad t\ge1.}
\tag{14}
$$
This keeps the no-jump contribution and uses no positive exponential age moment.

For a precise primary arithmetic input, Johnston and Yang, *Some explicit estimates for the error term in the prime number theorem*, [Theorem 1.4](https://arxiv.org/pdf/2204.01980v2), prove for $x\ge23$
$$
 |E(x)|\le0.026x(\log x)^{1.801}
 \exp[-0.1853(\log x)^{3/5}(\log\log x)^{-1/5}].
\tag{15}
$$
Their $\psi$ includes every $p^m\le x$. Only this $\psi$ inequality is used.
Set
$$
 R(L)=L^{1.801}
       \exp[-0.1853L^{3/5}(\log L)^{-1/5}]
$$
for sufficiently large $L$. Since $(\log R)'(L)\to0$, integration of $e^{av}R(v)^j$, with $(a,j)=(1/2,1)$ or $(1,2)$, gives
$$
 \|a_N\|_1\le C\sqrt N R(L),\qquad
 \|a_N\|_2^2\le CN R(L)^2.
\tag{16}
$$
Explicitly, the logarithmic derivative of either integrand is at least $a/2$ for large $v$; integrating that differential inequality controls the integral by its upper endpoint. The finite initial range is absorbed in the constant. The natural terminal terms in (13) obey the same bounds.

For every fixed $c>0$, $e^{-2\lambda cL}=O_c(L^{-1})$. Thus
$$
 \boxed{\|T_{c\log N}a_N\|_2^2
 \le C_c N(\log N)^{2.602}
 \exp[-0.3706(\log N)^{3/5}(\log\log N)^{-1/5}].}
\tag{17}
$$
This all-large-$N$ bound gains one logarithm over direct contraction with the same PNT envelope. It is stronger than $N/(\log N)^A$ for every fixed $A$, but it does not supply any fixed exponent $N^\epsilon$, $\epsilon<1$. The cited PNT constants are an applicable unconditional choice, not an optimality claim.

## 4. Exact scope of short-interval mean-square estimates

The translation-variance identity is
$$
 \boxed{\|T_ta_N\|_2^2=\|a_N\|_2^2-
 \frac12\int_{\mathbb R}\|a_N-\tau_ra_N\|_2^2\omega_t(dr).}
\tag{18}
$$
An upper bound on the difference square gives a lower bound through (18). A small upper bound for the smoothed norm instead requires this averaged difference square to nearly exhaust $2\|a_N\|_2^2$.
For $r\ge0$, that difference is exactly
$$
 \begin{aligned}
 \|a_N-\tau_ra_N\|_2^2={}&
 \int_1^{e^r}E_N(x)^2\frac{dx}{x^2}\\
 &+\int_1^\infty
 [e^{-r/2}E_N(e^rx)-E_N(x)]^2\frac{dx}{x^2}.
 \end{aligned}
\tag{19}
$$
On the unfrozen region its last bracket equals
$$
 e^{-r/2}[\psi(e^rx)-\psi(x)-(e^r-1)x]
                       +(e^{-r/2}-1)E(x).
\tag{20}
$$
Only the first summand is the usual interval discrepancy. The second still contains the original error, and the other regions retain the frozen samples.

The primary theorem on page 225 of Zaccagnini, *Primes in almost all short intervals*, [Acta Arithmetica 84 (1998)](https://matwbn.icm.edu.pl/ksiazki/aa/aa84/aa8432.pdf), gives
$$
 \int_X^{2X}\left|\pi(x)-\pi(x-H)-\frac H{\log x}\right|^2dx
 \ll\frac{XH^2}{(\log X)^2}
       \left(\epsilon(X)+\frac{\log\log X}{\log X}\right)^2
$$
for $X^{1/6-\epsilon(X)}\le H\le X$, $0\le\epsilon(X)\le1/6$, and $\epsilon(X)\to0$.
The original typeset primary PDF is also available from this [working mirror](https://pdfs.semanticscholar.org/b948/bb4b7f651170adb9ba42c038771847f13e54.pdf). Its first PDF page is printed page 225.
It concerns $\pi$-increments, not (3) or the full expression (19). No unproved conversion to a stronger $\psi$-estimate is used here. Even a suitable upper bound on the first summand of (20) would leave the sign-direction and boundary issues in (18).

The process does not concentrate on a fixed short multiplicative window. By (8) and (12), for every fixed $R>0$,
$$
 \omega_t([-R,R])\le e^{-2\lambda t}+CR/t\longrightarrow0.
\tag{21}
$$
This is a concrete mismatch with replacing the complete two-history average by one short-additive-interval estimate.

## 5. Small Laplace parameters sharpen the necessary quantifiers

Fix $q>0$ and set $s=1/2+q$. Absolute integration and (9) imply
$$
 \int_0^\infty e^{-qv}(T_ta_N)(v)dv
                      =e^{-t\Phi(q)}\frac{D_N(s)}s.
$$
Since $\|e^{-qv}\mathbf1_{v\ge0}\|_2=(2q)^{-1/2}$,
$$
 \boxed{|D_N(1/2+q)|
 \le\frac{1/2+q}{\sqrt{2q}}\,
        N^{c\Phi(q)}\|T_{c\log N}a_N\|_2.}
\tag{22}
$$
The finite Lévy measure and absence of killing give $\Phi(q)\to0$ as $q\downarrow0$, by dominated convergence. No first moment is required.

Suppose for one fixed $c>0$ and some $\eta\ge0$ that
$$
 \|T_{c\log N}a_N\|_2^2=O_\epsilon(N^{\eta+\epsilon})
                    \quad\text{for every }\epsilon>0.
\tag{23}
$$
Then, for every fixed $q>0$,
$$
 D_N(s)=O_{q,c,\epsilon}(N^{\eta/2+c\Phi(q)+\epsilon}).
\tag{24}
$$
The same estimate holds for real cutoffs between integers, because only the bounded continuous-cell increment changes there.

There is an elementary direct reconstruction of the original arithmetic error. For every real $X\ge1$, Abel inversion gives
$$
 \boxed{E(X)=X^sD_X(s)-s\int_1^Xx^{s-1}D_x(s)dx.}
\tag{24a}
$$
To verify it, write $D_x(s)=\int_{[1,x]}y^{-s}d\nu(y)$, with the signed innovation defined below. Interchanging the two finite-variation integrals on $[1,X]$ gives
$$
 s\int_1^Xx^{s-1}D_x(s)dx
 =\int_{[1,X]}y^{-s}(X^s-y^s)d\nu(y)
 =X^sD_X(s)-E(X).
$$
The atom $-\delta_1$ is inside both expressions. At $X=1$, (24a) gives $E(1)=D_1(s)=-1$; at a prime-power endpoint $X$, the atom is included on both sides. No endpoint is replaced by a midpoint convention.

For $s>0$ and $b\ge0$, a bound $|D_X(s)|\le C X^b$ yields explicitly
$$
 |E(X)|\le C\left(1+\frac{s}{s+b}\right)X^{s+b}.
\tag{24b}
$$
Applying this to (24), and then choosing $q>0$ and its error exponent sufficiently small, proves directly
$$
 \boxed{E(X)=O_\delta\!\left(X^{(1+\eta)/2+\delta}\right)
                  \quad\text{for every }\delta>0.}
\tag{24c}
$$
Here $c$ is any one fixed positive value; the choice uses only
$q+c\Phi(q)\to0$. This reconstruction needs finite Stieltjes integration and real estimates, not complex continuation.

It also proves a source-only exponent preservation theorem. Put
$$
 \kappa_0=\limsup_{N\to\infty}
       \frac{\log(1+\|a_N\|_2^2)}{\log N},\qquad
 \kappa_c=\limsup_{N\to\infty}
       \frac{\log(1+\|T_{c\log N}a_N\|_2^2)}{\log N}.
$$
Both are finite and nonnegative by the unconditional bounds above. Contraction gives $\kappa_c\le\kappa_0$. For each $\eta>\kappa_c$, the definition of limsup implies (23). Equations (24c) and (13) then give
$\|a_N\|_2^2=O_\epsilon(N^{\eta+\epsilon})$, retaining its terminal term. Thus $\kappa_0\le\eta$, and letting $\eta\downarrow\kappa_c$ proves
$$
 \boxed{\kappa_c=\kappa_0\qquad(c>0\text{ fixed}).}
\tag{24d}
$$
This proof preserves the nonnegative power-growth exponent without mentioning zeros. The Mellin argument that follows identifies that exponent with the zero abscissa.

Define the full signed innovation
$$
 d\nu=-\delta_1+\sum_{n\ge2}\Lambda(n)\delta_n
                              -\mathbf1_{(1,\infty)}dx.
$$
Its Mellin transform for $\Re z>1$ is
$$
 G(z)=\int x^{-z}d\nu(x)
       =-1-\frac{\zeta'(z)}{\zeta(z)}-\frac1{z-1}.
\tag{25}
$$
If $D_X(s)=O(X^\kappa)$, partial summation yields a locally uniformly convergent continuation
$$
 G(z)=(z-s)\int_1^\infty D_x(s)x^{s-z-1}dx,
                       \qquad\Re z>s+\kappa.
\tag{26}
$$
The seed belongs to $D_x$; the formula includes its endpoint contribution. Initially verify (26) in the common region of convergence, then apply analytic continuation.

Equations (24)--(26) exclude every zero in
$\Re z>1/2+q+\eta/2+c\Phi(q)+\epsilon$.
At a nontrivial zero the residue of $-\zeta'/\zeta$ is minus its full multiplicity. Neither the constant nor the pole correction at one can cancel it; that correction makes the pole at one removable. Letting $q,\epsilon\downarrow0$ gives
$$
 \boxed{\Theta:=\sup_\rho\Re\rho\le(1+\eta)/2.}
\tag{27}
$$
This needs no rightmost zero or simplicity assumption.

In particular the subpower source target, for any one fixed $c>0$, already implies RH. Conversely RH gives the all-epsilon square-root discrepancy bound, hence subpower growth of (13), and contraction gives the target at every time. Arbitrarily small $c$ is unnecessary for this source implication.

The exact growth calibration is therefore
$$
 \boxed{\limsup_{N\to\infty}
 \frac{\log(1+\|T_{c\log N}a_N\|_2^2)}{\log N}
       =2\Theta-1,\qquad c>0\text{ fixed}.}
\tag{28}
$$
For the upper bound use $E(x)=O(x^\Theta\log^2x)$, obtained from
[Dudek, Theorem 2.1](https://arxiv.org/pdf/1401.4233) and the right-continuous endpoint argument in the [zero-abscissa growth proof](../weil-and-spectral/zero-abscissa-scattering-growth.md). Substitution in (13) and contraction give $O_\epsilon(N^{2\Theta-1+\epsilon})$. For the reverse bound apply (27) to every exponent above the limsup. If $\Theta=1/2$, nonnegativity of the displayed logarithm supplies the lower bound zero.

The unconditional estimate proved here is (17). The actual signed arithmetic quantities a stronger method must control are (7) and (10). The short-interval result examined above does not provide that cancellation, and (27)--(28) do not evaluate the unknown exponent. The one-fixed-$c$ equivalence here concerns the entire original source norm. It is not transferred to a diagonal $W$ observation: the latter's separate criterion retains its small-time-coefficient quantifier. No short-time target or RH proof is asserted.

The [successor-transfer theorem](../successor-and-division/short-time-source-and-W-successor-transfer.md) changes the actual source norm by $O(1/(1+t))$ uniformly over natural cutoffs. The [diagonal $W$ theorem](../dynamics-and-feedback/diagonal-process-time-W-transform.md) has a different hypothesis: bounds at arbitrarily small fixed time ratios for a scalar observation. The one-fixed-$c$ result here uses the entire original frozen-source $L^2$ norm.


The [variable-time extension](../dynamics-and-feedback/variable-time-source-exponent.md) retains this finite-source normalization and replaces the fixed logarithmic schedule by arbitrary schedules. It proves the exact nonnegative growth exponent $\max(\kappa_0-\delta,0)$ when the time exponent converges to $\delta$, using a moving low-Laplace parameter and an exact real-cell Abel absorption.
