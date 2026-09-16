# Even-total compensation in the finite centered heat shell

Fix a source cutoff $Y$ and $T\geq0$. Let

$$
K_T(N)=\frac{e^{-Ne^{-2T}}-e^{-Ne^{-T}}}{N},
\qquad
c_Y(N)=\sum_{\substack{1\leq m,n\leq Y\\m+n=N}}
 (\Lambda(m)-1)(\Lambda(n)-1).
$$

The finite shell is

$$
S_Y(T)=\sum_{N=2}^{2Y}c_Y(N)K_T(N)
=\int_{e^{-2T}}^{e^{-T}}
 \left(\sum_{n=1}^Y(\Lambda(n)-1)e^{-nt}\right)^2dt\geq0.
\tag{1}
$$

Partition the odd totals into the interior
$I_Y=\{N:2\leq N\leq2Y,\ N\text{ odd},\ N\leq Y+1\}$
and the moving upper transition
$U_Y=\{N:2\leq N\leq2Y,\ N\text{ odd},\ Y+1<N\}$.
For interior totals the cutoff does not clip an additive pair, and

$$
c_Y(N)=R_\Lambda(N)-2\psi(N-1)+(N-1),
$$

where $R_\Lambda(N)$ includes all prime powers. Define the interior
odd deficit and the signed transition packet by

$$
\begin{aligned}
D_{Y,T}&=\sum_{N\in I_Y}
 [2\psi(N-1)-(N-1)-R_\Lambda(N)]K_T(N),\\
U_{Y,T}&=\sum_{N\in U_Y}c_Y(N)K_T(N).
\end{aligned}
\tag{2}
$$

Thus the odd shell is exactly $-D_{Y,T}+U_{Y,T}$. If $E_{Y,T}$
is the even centered shell, positivity in (1) gives the unconditional,
finite **compensation inequality**

$$
\boxed{E_{Y,T}\geq D_{Y,T}-U_{Y,T}.}
\tag{3}
$$

The transition term has no fixed sign and cannot be dropped. Equation
(3) holds even when $D_{Y,T}$ itself is negative at small cutoffs.

Write the even raw prime-prime, left marginal, right marginal and pair
count packets as $P^{\rm even}_{Y,T}$,
$L^{\rm even}_{Y,T}$, $R^{\rm even}_{Y,T}$ and
$Q^{\rm even}_{Y,T}$, each weighted by $K_T$ over the even totals. The
literal centering expansion gives

$$
E_{Y,T}=P^{\rm even}_{Y,T}-L^{\rm even}_{Y,T}
-R^{\rm even}_{Y,T}+Q^{\rm even}_{Y,T}.
$$

Consequently (3) is the exact weighted even-Goldbach lower bound

$$
\boxed{
P^{\rm even}_{Y,T}\geq
L^{\rm even}_{Y,T}+R^{\rm even}_{Y,T}-Q^{\rm even}_{Y,T}
+D_{Y,T}-U_{Y,T}.
}
\tag{4}
$$

All four packets retain the bounded ordered pairs and their complete
prime-power weights.

## PNT comparison and its limit

For odd $N$, one source index carrying nonzero $\Lambda$ must be a power
of two. The exact bounded formula and its $O((\log N)^2)$ bound are in the
[adjacent-total audit](centered-goldbach-adjacent-total-faces.md). For
interior odd $N\to\infty$, the [prime number theorem in its Chebyshev
form](https://dlmf.nist.gov/25.16.E3) gives
$c_Y(N)=-N+o(N)$ whenever $Y\geq N-1$. Thus the odd packet contains a
negative first-order density that the even packet must compensate.

To compare (4) with the usual convolution mean, first let $Y\to\infty$
at **fixed** $T$. Exponential weights make the transition packet tend
to zero and justify the complete-source limit. Then let $T\to\infty$.
PNT and elementary Abel summation give

$$
A(t):=\sum_{n\geq1}\Lambda(n)e^{-nt}\sim t^{-1},
\qquad
B(t):=\sum_{n\geq1}e^{-nt}\sim t^{-1}.
\tag{5}
$$

The even-index part of $A(t)$ consists only of powers of two and is
$O(\log(1/t))$; its odd-index part is therefore asymptotic to $t^{-1}$.
The even- and odd-index parts of $B(t)$ are each asymptotic to
$(2t)^{-1}$. It follows that, for the complete source,

$$
\begin{aligned}
P^{\rm even}(t)&\sim t^{-2},\\
L^{\rm even}(t)+R^{\rm even}(t)-Q^{\rm even}(t)&\sim \tfrac12t^{-2},\\
D^{\rm odd}(t)&\sim \tfrac12t^{-2}.
\end{aligned}
\tag{6}
$$

Integrating each row over $[e^{-2T},e^{-T}]$ makes the common unit
$e^{2T}-e^T$. The right side of (4) is therefore
$(1+o(1))(e^{2T}-e^T)$ in this iterated limit, exactly the standard
PNT-level convolution main term of $P^{\rm even}_{Y,T}$.

This is an asymptotically sharp *restatement of first-order PNT*, not a
new weighted Goldbach lower bound. It gives no control of the centered
shell below its $o(e^{2T})$ PNT scale, and in particular no polynomial
doubling estimate. A simultaneous cutoff $Y=Y(T)$ needs its own
quantitative estimate for the signed transition $U_{Y,T}$; none is
assumed here.

## Lean scope

[CenteredGoldbachEvenCompensationFinite.lean](BuildingBlocks/CenteredGoldbachEvenCompensationFinite.lean)
proves (1)--(4) exactly, including the full odd interior/transition
partition and the four even raw packets. Its public axiom reports list
only `propext`, `Classical.choice`, and `Quot.sound`. The PNT-based
limits (5)--(6) are written analytic deductions, not Lean theorems.
