# The admitted square tail has an explicit continuum counterphase

Written proof. Conditional conclusions retain their stated RH hypotheses; none proves an unconditional RH-scale bound. Classical explicit-formula, zero-counting, Fourier and operator tools are attributed below and in the linked dependencies.

This consumes the original weighted phase-column estimate in
[signed scattering tail energy](signed-scattering-tail-energy.md) and its application in
[prime discrepancy scattering norm](prime-discrepancy-scattering-norm.md). The observation $\chi$ is fixed
and Schwartz, and
$$
 N_\chi(U)=\|M_\chi(P-U^*PU)\|_1.
$$
The complete local factors, stable rational factor, gamma factor, and
pole-null test class are unchanged.

For real $X\ge e$, write $A=\log X$. The exact admitted-prime tail
phase is
$$
 \theta_X^{\rm tail}(t)
 =-2\sum_{\substack{p\le X,\ k\ge2\\p^k>X}}
             \frac{p^{-k/2}}k\sin(kt\log p).
 \tag{1}
$$
Define the deterministic phase
$$
 \varphi_A(t)=\int_A^{2A}\frac{\sin(at)}a\,da
            =\int_{\sqrt X}^{X}
                 \frac{\sin(2t\log y)}{y\log y}\,dy.
 \tag{2}
$$
Then the corrected tail satisfies the unconditional estimate
$$
 \boxed{
 N_\chi\!\left(e^{i(\theta_X^{\rm tail}+\varphi_A)}\right)
 \le C_\chi\left[
 A^{5/2}e^{-b\sqrt A}+X^{-1/6}\right]\longrightarrow0
 }
 \tag{3}
$$
for some fixed $b>0$. Constants may depend on the classical PNT
remainder and finitely many Schwartz seminorms of $\chi$.

The continuum factor in (2) remains in the exact product. Estimate
(3) is a comparison after its removal, not a bound for the original
tail without that factor.

## 1. Exact square measure and endpoint conventions

Let $\vartheta(y)=\sum_{p\le y}\log p$ and
$E_\vartheta(y)=\vartheta(y)-y$. The square part of (1) is
$$
 \theta_{X,2}(t)
 =-\sum_{\sqrt X<p\le X}\frac{\sin(2t\log p)}p
 =-\int_{(\sqrt X,X]}
       \frac{\sin(2t\log y)}{y\log y}\,d\vartheta(y).
$$
Therefore
$$
 \theta_{X,2}(t)=-\varphi_A(t)+\epsilon_X(t),\qquad
 \epsilon_X(t)
 =-\int_{(\sqrt X,X]}
       \frac{\sin(2t\log y)}{y\log y}\,dE_\vartheta(y).
 \tag{4}
$$
A prime at $\sqrt X$ is excluded: its square already belongs to the
complete $n\le X$ cutoff. A prime at $X$ is included. These
conventions are not changed by the continuum integral.

In the frequency variable $a=2\log y$, put
$$
 \mu_X^{(2)}(da)
 =\frac12\mathbf1_{(A,2A)}(a)\,da
   -\sum_{\sqrt X<p\le X}\frac{\log p}{p}\,
                     \delta_{2\log p}(da).
 \tag{5}
$$
Then $\epsilon_X=2\int \sin(at)\mu_X^{(2)}(da)/a$.
Equivalently, this measure is the pushforward of
$-y^{-1}dE_\vartheta(y)$ on $(\sqrt X,X]$. In particular the
factor $1/2$ in its continuum density is essential.

## 2. The signed square remainder in the existing column norm

Use the classical unconditional PNT remainder
$$
 |E_\vartheta(y)|\le C y e^{-b_0\sqrt{\log y}},\qquad y\ge2.
 \tag{6}
$$
The same estimate holds for left limits after enlarging constants.
This is the same classical input already used in
[signed scattering phase transport](signed-scattering-phase-transport.md); no zero-location assumption is
made. A primary stronger psi remainder and its convention are
recorded in [actual short time psi correlation](actual-short-time-psi-correlation.md), (15).
Its theta consequence follows by subtracting the elementary
$O(\sqrt y\log^2(2y))$ proper-power contribution.

For $j=0,1,2$ and $0<r<2A$, define the actual signed columns
$$
 T_{j,r}(t)=\int_{[r,\infty)}
       \frac{(a-r)^j}{a}e^{iat}\,\mu_X^{(2)}(da).
 \tag{7}
$$
There is no tail for $r>2A$. Let
$$
 b_*=\max(A/2,r/2),\qquad
 F_j(b,r,t)=e^{(-1+2it)b}\frac{(2b-r)^j}{2b}.
$$
Stieltjes integration by parts gives, for almost every $r$,
$$
 T_{j,r}(t)
 =-E_\vartheta(X)F_j(A,r,t)
  +E_*F_j(b_*,r,t)
  +\int_{b_*}^{A}E_\vartheta(e^b)
                         \partial_bF_j(b,r,t)\,db.
 \tag{8}
$$
For $r\le A$, $E_*=E_\vartheta(\sqrt X)$, the right value,
because the lower square threshold is excluded. For $A<r<2A$,
$E_*=E_\vartheta(e^{r/2}-)$ when the frequency tail includes
an atom at its lower endpoint. These endpoint choices also give
the exact version at exceptional $r$; changing them at countably
many $r$ has no effect on the column norm.

Set $\varepsilon_A=e^{-b_0\sqrt{A/2}}$, and first take $A$
larger than a fixed constant. Throughout the integration interval,
$$
 |E_\vartheta(e^b)|e^{-b}\le C\varepsilon_A.
$$
For $a=2b$, the derivative integrand is consequently bounded by
$$
 C\varepsilon_A\left[
 (1+|t|)\frac{(a-r)^j}{a}
 +j\frac{(a-r)^{j-1}}a
 +\frac{(a-r)^j}{a^2}\right],
 \tag{9}
$$
where the middle term is absent for $j=0$.
Use
$$
 \|\mathbf1_{0<r<a}(a-r)^j\|_{L^2(dr)}
       =\frac{a^{j+1/2}}{\sqrt{2j+1}}.
$$
The upper endpoint in (8) and the lower endpoint on $r\le A$
each cost $O(\varepsilon_A A^{j-1/2})$.
For $r>A$, the lower endpoint vanishes if $j\ge1$; if $j=0$
its norm is $O(\varepsilon_A A^{-1/2})$.
Minkowski applied to (9) on $A<a<2A$ proves
$$
 \boxed{
 \|T_{j,\cdot}(t)\|_{L^2(0,2A)}
 \le C(1+|t|)\varepsilon_A A^{j+1/2},
 \qquad j=0,1,2.}
 \tag{10}
$$
The countably many prime endpoints are thus retained before the
signed integral is estimated.

With $b_\chi(t)=(1+t^2)\chi(t)-\chi''(t)$, the exact column energy
is
$$
 \mathcal J_\chi(\mu_X^{(2)})
 =\int_{\mathbb R}\|
 b_\chi(t)T_{0,\cdot}(t)-2i\chi'(t)T_{1,\cdot}(t)
                  +\chi(t)T_{2,\cdot}(t)\|_2^2\,dt.
$$
The existing trace-class factorization and Duhamel estimate give
$$
 N_\chi(e^{i\epsilon_X})
 \le\sqrt{\pi/24}\,\mathcal J_\chi(\mu_X^{(2)})^{1/2}
 \le C_\chi A^{5/2}e^{-b\sqrt A}.
 \tag{11}
$$
Only the signed theta discrepancy enters (8)–(11). Replacing it
by total variation before integration would destroy this decay.

## 3. Every higher power is a vanishing tail

Let $\theta_{X,\ge3}$ denote the part of (1) with $k\ge3$.
The existing single-frequency estimate
$$
 \|M_\chi[P,M_{\sin(at)}]\|_1\le C_\chi(a+\sqrt a)
$$
and Duhamel imply
$$
 N_\chi(e^{i\theta_{X,\ge3}})
 \le C_\chi
 \sum_{\substack{p\le X,\ k\ge3\\p^k>X}}
                   (\log p)p^{-k/2}.
 \tag{12}
$$
The square-root term has been absorbed using $k\log p\ge3\log2$.

Here is a uniform bound including arbitrarily deep powers. Chebyshev's
bound $\vartheta(y)\le Cy$ and partial summation give, for $s>1$
and $Y\ge2$,
$$
 \sum_{p>Y}(\log p)p^{-s}
 \le C\frac{s}{s-1}Y^{1-s}.
 \tag{13}
$$
For large $X$, set $K=\lfloor\log X/\log2\rfloor$.
The depth $k=3$ costs $O(X^{-1/6})$.
For $4\le k\le K$, apply (13) with $Y=X^{1/k}$ and $s=k/2$;
their total is
$$
 O((\log X)X^{-1/4})=O(X^{-1/6}).
$$
For $k>K$, sum over all primes and use
$$
 \sum_p(\log p)p^{-k/2}\le C2^{-k/2};
$$
this follows from the same Chebyshev integral starting at $2-$.
The geometric sum is $O(2^{-K/2})=O(X^{-1/2})$. Consequently
$$
 \boxed{N_\chi(e^{i\theta_{X,\ge3}})
                       \le C_\chi X^{-1/6}.}
 \tag{14}
$$
The finitely many smaller cutoffs are covered by enlarging constants.
No depth, including powers of two, has been discarded.
Equations (11) and (14) prove (3).

## 4. The exact product, cutoff cocycle, and compact readout

Write the full multiplier from [prime discrepancy scattering norm](prime-discrepancy-scattering-norm.md)
as a product of its fixed baseline, complete-cutoff phase, and
$e^{i\theta_X^{\rm tail}}$. It is exactly
$$
 \widehat U_X
 =U_0 e^{i\theta_X^{\rm complete}}
       e^{-i\varphi_{\log X}}
       e^{i\epsilon_X}e^{i\theta_{X,\ge3}}.
 \tag{15}
$$
Thus the deterministic factor is a retained part of the product,
not an omitted tail. In particular,
$$
 \left|N_\chi(\widehat U_X)
 -N_\chi(U_0e^{i\theta_X^{\rm complete}}
                    e^{-i\varphi_{\log X}})\right|
 \le C_\chi\left[A^{5/2}e^{-b\sqrt A}+X^{-1/6}\right].
 \tag{16}
$$
This uses the exact commuting-multiplier cocycle
$\Delta(UV)=\Delta(V)+V^*\Delta(U)V$, with
$\Delta(U)=P-U^*PU$; multiplication by $\chi$ commutes with $V$,
so unitary conjugation preserves the weighted trace norm.
The reverse inequality follows using $V^{-1}$.
All factors in (15) have a trace-class weighted defect for fixed $X$.

At two arbitrary actual cutoffs $Y>X$, the phase increment is
exactly
$$
 \theta_Y^{\rm tail}-\theta_X^{\rm tail}
 =-(\varphi_{\log Y}-\varphi_{\log X})
   +(\epsilon_Y-\epsilon_X)
   +(\theta_{Y,\ge3}-\theta_{X,\ge3}).
 \tag{17}
$$
This displays the clock contribution of the new counterphase.
Nothing is silently removed from a successor or cutoff cocycle.

Finally fix a compactly supported physical test $f$ in the existing
pole-null class and take $\chi=|\widehat f|^2$.
Its autocorrelation $C_f(a)$ is zero once $|a|$ exceeds the
diameter of its support. The derivative of (2) is
$\varphi_A'(t)=\int_A^{2A}\cos(at)\,da$.
Hence its signed trace/readout pairing with $\chi$ is exactly zero
once $A$ exceeds that diameter. The same holds for every frequency
in the full tail (1). This is support orthogonality, not an estimate
of a positive form. The seed, pole-null constraints, gamma factor,
and original completed readout are preserved.

The earlier $O_\chi(\log X)$ proper-power bound is therefore
replaceable by the explicit deterministic factor (2) and a relative
defect tending to zero. This separation alone does not bound the
remaining complete-cutoff discrepancy. The following local argument
also controls the retained deterministic factor; neither step supplies
an unconditional RH bound.


## 5. Local trace decay for the retained deterministic phase

The deterministic factor itself has a better bound than the earlier
single-frequency triangle estimate:
$$
 \boxed{
 N_\chi(e^{-i\varphi_A})\le C_\chi\log(2+A),\qquad A\ge1.
 }
 \tag{18}
$$
This is a localized statement. No unweighted trace-class assertion
is needed.

Put
$$
 h(s)=\int_1^2\frac{\sin(bs)}b\,db,\qquad
 \varphi_A(t)=h(At).
$$
For $j=0,1,2,3$, differentiation under the finite integral and one
integration by parts in $b$ give
$$
 |h^{(j)}(s)|\le\frac{C_j}{1+|s|},\qquad h\in L^2(\mathbb R).
 \tag{19}
$$
The endpoint terms at $b=1,2$ are kept; they are precisely compatible
with the $1/|s|$ decay.

We first prove the local estimate
$$
 \boxed{
 \|M_\phi[P,M_h]\|_1
 \le \frac{C}{1+|T|}
          \max_{0\le j\le2}\|\phi^{(j)}\|_\infty,
 \quad \phi\in C_c^2((T-1,T+1)).
 }
 \tag{20}
$$
The Hardy commutator kernel, up to its harmless sign convention, is
$$
 \frac{\phi(t)}{2\pi i}
       q(t,u),\qquad
 q(t,u)=\frac{h(t)-h(u)}{t-u}.
$$
There is no diagonal distribution after taking the commutator.

For $|T|\ge8$, let $t$ belong to the output window and
$d=t-u$. On $|d|\le1$, the segment between $t$ and $u$
stays at distance comparable to $|T|$ from zero. The divided
difference identity gives, for $j=0,1,2$,
$$
 |\partial_t^jq(t,u)|
 \le\frac{\sup_{\text{segment}}|h^{(j+1)}|}{j+1}
 \le C|T|^{-1}.
$$
On $1<|d|<|T|/2$, both $|u|$ and $|t|$ are comparable
from below to $|T|$. Differentiate the quotient explicitly:
$$
 q_t=\frac{h'(t)}d-\frac{h(t)-h(u)}{d^2},\qquad
 q_{tt}=\frac{h''(t)}d-\frac{2h'(t)}{d^2}
                       +\frac{2(h(t)-h(u))}{d^3}.
$$
Equation (19) therefore bounds each derivative through order two by
$C/(|T||d|)$. Their squared integrals over this middle region
are $O(T^{-2})$.

On $|d|\ge|T|/2$, the local $h(t),h'(t),h''(t)$ terms
have input $L^2$ norms $O(|T|^{-3/2})$.
For the remote terms, use the actual global square integrability:
$$
 \left\|\mathbf1_{|t-u|\ge|T|/2}
       \frac{h(u)}{(t-u)^{j+1}}\right\|_{L^2(du)}
 \le \left(\frac2{|T|}\right)^{j+1}\|h\|_2.
$$
Thus every output derivative through order two has input $L^2$
norm $O(|T|^{-1})$, uniformly over the output window. For
$|T|<8$, the corresponding uniform $O(1)$ bound follows from
bounded derivatives near the diagonal and the square-integrable
$1/|t-u|$ tail.

Apply the translated oscillator
$L_T=1+(t-T)^2-\partial_t^2$ to the output variable. The preceding
bounds, the output support of length at most two, and the product
rule show
$$
 \|L_T M_\phi[P,M_h]\|_2
 \le\frac{C}{1+|T|}
          \max_{j\le2}\|\phi^{(j)}\|_\infty.
$$
Here the norm on the left is Hilbert--Schmidt, first identified from
the distributional kernel. Since
$\|L_T^{-1}\|_2=\pi/\sqrt{24}$, Schatten factorization proves
(20), by the same oscillator factorization used above.
All input locations are covered; no decay assumption on a remote
derivative has replaced the global $L^2$ estimate.

For a real bounded $h$, Duhamel gives
$$
 [P,e^{-ih}]
 =-i\int_0^1 e^{-i(1-v)h}[P,h]e^{-ivh}\,dv.
$$
Multiplication by $\phi$ commutes with these unitary factors.
Consequently
$$
 N_\phi(e^{-ih})\le\|M_\phi[P,h]\|_1.
 \tag{21}
$$
This use of Duhamel introduces no derivatives of the unitary
factors into the local estimate.

## 6. Exact dilation and the sum of observation windows

Positive real dilation commutes with the Hardy projection.
The unitary $D_Af(s)=A^{-1/2}f(s/A)$ sends multiplication by
$h(At)$ to multiplication by $h(s)$. It also sends the actual
observation $\chi(t)$ to $\chi(s/A)$. Hence
$$
 N_\chi(e^{-i\varphi_A})
       =N_{\chi(\cdot/A)}(e^{-ih}).
 \tag{22}
$$
In particular the observation must be dilated along with the phase.

Take a fixed smooth unit-window partition of unity and apply
(20)–(21) to each window. Its product-rule constants are fixed.
For $A\ge1$, a Schwartz seminorm controls
$$
 \max_{j\le2}\sup_{|s-n|\le1}
       |\partial_s^j\chi(s/A)|
 \le C_\chi(1+|n|/A)^{-2}.
$$
The factors $A^{-j}$ from differentiation cause no growth.
Thus
$$
 N_{\chi(\cdot/A)}(e^{-ih})
 \le C_\chi\sum_{n\in\mathbb Z}
             \frac{(1+|n|/A)^{-2}}{1+|n|}
 \le C_\chi\log(2+A).
 \tag{23}
$$
The last estimate is the harmonic sum for $|n|\le A$, followed
by a bounded $A^2\sum_{|n|>A}|n|^{-3}$ tail.
Finite window sums converge in trace norm by this estimate and
in operator norm to the actual localized defect, since the
omitted observation tends to zero in supremum norm.
This proves (18) on the original observation space.

## 7. Consequence for the retained all-power scattering norm

Combining (3), (15), and (18) gives
$$
 N_\chi(e^{i\theta_X^{\rm tail}})
 \le C_\chi\log(2+\log X)
       +C_\chi\left[
       (\log X)^{5/2}e^{-b\sqrt{\log X}}+X^{-1/6}\right].
 \tag{24}
$$
Thus the actual mandatory proper-power tail costs
$O_\chi(\log(2+\log X))$, with its square continuum phase
retained. The signed remainder around that phase still tends to
zero as in (3).

In the notation of [prime discrepancy scattering norm](prime-discrepancy-scattering-norm.md), the resulting
bound for its unchanged full multiplier is
$$
 \boxed{
 N_\chi(\widehat U_X)
 \le C_{\chi,C,\beta,m}
 \left[1+\log(2+\log X)
       +\mathfrak B_{\beta-1/2,m}(\log X)\right].
 }
 \tag{25}
$$
This replaces that note's separate $O(\log X)$ power-tail cost.
The complete-cutoff discrepancy term has not been altered or bounded
without its stated arithmetic hypothesis. Equations (15)–(17)
continue to give the exact product, cutoff increment, and preserved
compact pole-null readout. No positive-form conclusion or
unweighted trace-class claim follows from (18).

