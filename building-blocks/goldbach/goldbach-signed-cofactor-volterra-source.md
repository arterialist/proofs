# The signed successor cofactor retains the centered prime source

The logarithmic correction in the literal Goldbach successor loss tends
to $1$. The other correction is signed. This note identifies its exact
heat source, including the first integer and the finite cutoff term.
It does not bound that source at the RH scale.

Write $\Lambda(1)=0$, and for integers $y\ge0$ put

\[
a_n=\Lambda(n)-1\quad(n\ge1),\qquad
E_y=\psi(y)-y=\sum_{n=1}^y a_n.
\tag{1}
\]

In particular $a_1=E_1=-1$. The [literal successor
decomposition](goldbach-literal-successor-counting-transport.md#universal-logarithmic-correction-and-signed-arithmetic-remainder)
contains the complete signed row

\[
Q_s=\sum_{m=2}^{s-2}\Lambda(m)\frac{E_{s-m}}{s-m},
\qquad s\ge4.
\tag{2}
\]

## Finite Abel equation and its endpoint

For a cutoff $Y\ge0$ and real $z$, set

\[
D_Y(z)=\sum_{n=1}^Y a_nz^n,\qquad
H_Y(z)=\sum_{y=1}^Y E_yz^y.
\]

Finite summation by parts gives

\[
\boxed{(1-z)H_Y(z)=D_Y(z)-E_Yz^{Y+1}.}
\tag{3}
\]

The terminal term is literal. It is still present when $z=1$,
where (3) says $D_Y(1)=E_Y$. For $t>0$, put

\[
A_Y(t)=\sum_{y=1}^Y\frac{E_y}{y}e^{-ty},\qquad
D_Y(e^{-t})=\sum_{n=1}^Y a_ne^{-tn}.
\]

Since $A_Y'(t)=-H_Y(e^{-t})$, equation (3) becomes

\[
\boxed{D_Y(e^{-t})=-(1-e^{-t})A_Y'(t)+E_Ye^{-(Y+1)t}.}
\tag{4}
\]

The actual bound $0\le\Lambda(n)\le\log n$ for $n\ge2$
gives $E_Y=O(Y\log(2Y))$. For each $t>0$, all series and
their derivatives converge locally uniformly, and the terminal
term in (4) tends to zero. Therefore

\[
\begin{aligned}
P(t)&=\sum_{n\ge1}\Lambda(n)e^{-nt},\\
D(t)&=P(t)-\frac{e^{-t}}{1-e^{-t}},\\
A(t)&=\sum_{y\ge1}\frac{E_y}{y}e^{-ty}
     =\int_t^\infty\frac{D(u)}{1-e^{-u}}\,du,\\
D(t)&=-(1-e^{-t})A'(t).
\end{aligned}
\tag{5}
\]

The integral is an equality of ordinary convergent functions for
every $t>0$. Its sign is not prescribed. The factor
$1-e^{-t}$ makes the map injective: differentiating $A$
recovers the original centered prime heat source $D$.

The cofactor in (2) starts at $s-m=2$, while $A$ includes
$E_1=-1$. Absolute convergence of the additive Cauchy product
thus gives the exact endpoint-corrected heat identity

\[
\boxed{\mathcal Q(t):=\sum_{s\ge4}Q_se^{-st}
 =P(t)\left[A(t)+e^{-t}\right]
 =P(t)\left[e^{-t}+\int_t^\infty
       \frac{D(u)}{1-e^{-u}}\,du\right].}
\tag{6}
\]

Every proper prime power occurs in $P$, $D$, and $Q_s$.
Neither the label-one correction nor the finite Abel endpoint is
discarded.

## What an RH-scale estimate would have to prove

The prime number theorem and partial summation give $P(t)\sim t^{-1}$
as $t\downarrow0$. The standard complete-prime-power form of RH is
$E_y=O_\varepsilon(y^{1/2+\varepsilon})$ for every
$\varepsilon>0$. From (6), these facts yield the conditional
criterion

\[
\boxed{\mathrm{RH}\quad\Longleftrightarrow\quad
 |\mathcal Q(t)|=O_\varepsilon(t^{-3/2-\varepsilon})
 \text{ as }t\downarrow0\text{ for every }\varepsilon>0.}
\tag{7}
\]

Here is the reverse implication, which is the point needing care.
If the bound in (7) holds, $P(t)\sim t^{-1}$ and (6) imply
$A(t)=O_\varepsilon(t^{-1/2-\varepsilon})$ for every
$\varepsilon>0$. Integrating $D=-(1-e^{-t})A'$ by parts gives,
initially for $\Re w>1$,

\[
\begin{aligned}
\Gamma(w)\left(-\frac{\zeta'(w)}{\zeta(w)}-\zeta(w)\right)
&=\int_0^\infty D(t)t^{w-1}\,dt\\
&=\int_0^\infty A(t)
 \left[e^{-t}t^{w-1}+(w-1)(1-e^{-t})t^{w-2}\right]dt.
\end{aligned}
\tag{8}
\]

At zero the bracket is $O_w(t^{\Re w-1})$, while
$A(t)=O_\varepsilon(t^{-1/2-\varepsilon})$. The integral on the
right therefore extends holomorphically to $\Re w>1/2$, choosing
$\varepsilon<\Re w-1/2$ on each compact set. The integration-by-parts
boundary is $O(t^{\Re w-1/2-\varepsilon})$ and vanishes.
At infinity $A$ decays exponentially. A zero of $\zeta$ with
$\Re w>1/2$ would give a pole in $-\zeta'/\zeta$, whereas
$-\zeta$ is regular there. Equation (8) excludes it; reflection
across the critical line gives RH.

Conversely, RH gives $E_y=O(y^{1/2}\log^2(2y))$. Summing this
bound in the definition of $A$ yields
$A(t)=O(t^{-1/2}\log^2(2/t))$; with $P(t)=O(t^{-1})$,
equation (6) gives the all-$\varepsilon$ bound in (7).

The finite identities (2) as a centered source row and (3) are
compiled in
[GoldbachCofactorVolterraFinite.lean](../../formalization/BuildingBlocks/GoldbachCofactorVolterraFinite.lean)
with standard Lean axioms only. Equations (4)–(8), including the
infinite limit and the RH equivalence, are written analysis.
PNT alone gives $\mathcal Q(t)=o(t^{-2})$, not (7).
The universal positive logarithmic correction from the successor
transport cannot supply the missing signed estimate in (7).
