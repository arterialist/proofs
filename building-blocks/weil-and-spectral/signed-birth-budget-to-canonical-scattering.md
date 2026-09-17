# The actual signed birth budget controls canonical prime scattering

Written proof. Conditional conclusions retain their stated RH hypotheses; none proves an unconditional RH-scale bound. Classical explicit-formula, zero-counting, Fourier and operator tools are attributed below and in the linked dependencies.

Fix the original process $T_t$, $c>0$, and a real Schwartz observation $\chi$. Use the original source norm throughout the source calculation. For integer $N\ge3$, put $A=\log N$ and retain
$$
 J_N=\|T_{c\log N}a_N\|_2^2,\qquad
 \mathbf D_c(N)=\sum_{n=2}^N
       \int_{c\log(n-1)}^{c\log n}\Gamma(T_s a_{n-1})\,ds,
$$
$$
 W_N=\sum_{n=2}^N\Re\langle T_{c\log n}a_{n-1},
                                  T_{c\log n}(a_n-a_{n-1})\rangle,\qquad
 L_N=\sum_{n=2}^N\|T_{c\log n}(a_n-a_{n-1})\|_2^2.
$$
Their exact seeded identity is
$$
 J_N+\mathbf D_c(N)=1+2W_N+L_N\ge0.                  \tag{1}
$$
All full density cells, the diagonal, and both mixed orders are present.

Let $P$ be the established real-line Hardy projection, $\Delta(U)=P-U^*PU$, and $N_\chi(U)=\|M_\chi\Delta(U)\|_1$. The actual canonical compensated prime multiplier is
$$
 \widehat u_N(t)=
 \pi^{-it}\frac{\Gamma(5/4+it/2)}{\Gamma(5/4-it/2)}
 \exp\!\left[
 2i\int_0^A e^{a/2}\frac{\sin(at)}a\,da
 -2i\sum_{p\le N}\sum_{k\ge1}\frac{p^{-k/2}}k\sin(kt\log p)
 \right].                                             \tag{2}
$$
This is the same stable rational/gamma normalization as in
[rational scattering pole factor](rational-scattering-pole-factor.md) and [prime discrepancy scattering norm](prime-discrepancy-scattering-norm.md).
It includes every power of every admitted prime, including $p^k>N$.
Write $\widehat U_N=M_{\widehat u_N}$.

The unconditional comparison proved here is
$$
 \boxed{N_\chi(\widehat U_N)
 \le C_{\chi,c}(1+\log N)
       \sqrt{1+J_N+\mathbf D_c(N)}
 =C_{\chi,c}(1+\log N)\sqrt{2+2W_N+L_N}.}               \tag{3}
$$
The last radicand is at least one by (1).
This bound retains the signed sum $W_N$; it does not
replace it by a sum of absolute birth pairings.
No bound on that sum is assumed or proved by (3).

The mechanism compares the actual source budget and actual local-factor
operator. It uses a scaled oscillator in the existing exact Fourier-column
calculation, followed by unconditional finite-prefix action control.
It is not an identification of the two Hilbert-space metrics.

## 1. A sharper signed charge-history estimate for the full phase

Put $a_0=\log2$, $m(a)=M(e^a)$, and
$$
 H(A)=\int_{a_0}^A\frac{m(a)^2}{a}\,da.
$$
We first prove the unconditional estimate
$$
 N_\chi(\widehat U_N)
 \le C_\chi\left[1+\log(2+A)+|m(A)|+\sqrt{A H(A)}\right].
                                                               \tag{4}
$$
The finite interval $(0,a_0)$ of the continuum phase and the shifted
gamma factor have a fixed trace-class weighted defect.
At a complete prime-power cutoff the remaining signed measure is
$$
 \mu=-dm\big|_{[a_0,A]}
   =e^{a/2}\mathbf1_{[a_0,A]}da
       -\sum_{2\le n\le N}\frac{\Lambda(n)}{\sqrt n}\delta_{\log n}.
                                                               \tag{5}
$$
The left limit is $m(a_0-)=1-2\sqrt2$. The upper value $m(A)=M_N$
includes the atom at $N$ when it is a prime power.

Extract the two endpoint atoms exactly:
$$
 \mu_{\rm res}=\mu+m(A)\delta_A-m(a_0-)\delta_{a_0}.
                                                               \tag{6}
$$
The phase of a mass $b\delta_a$ is $2b\sin(at)/a$.
The already proved weighted interval estimate and Duhamel give
$$
 N_\chi\!\left(M_{\exp(2ib\sin(at)/a)}\right)
 \le C_\chi |b|(1+a^{-1/2}).
                                                               \tag{7}
$$
Thus the upper extracted atom costs $C_\chi|m(A)|$, and the lower
one costs a fixed constant. Extracting them before the column estimate
avoids charging them for two unnecessary output derivatives.

For $j=0,1,2$, use the exact residual columns
$$
 T_{j,r}(t)=\int_{[r,\infty)}
          \frac{(a-r)^j}{a}e^{iat}\,\mu_{\rm res}(da).
$$
For almost every $r\in(0,A)$, Stieltjes integration by parts gives
$$
 \begin{split}
 T_{j,r}(t)={}&
 \mathbf1_{r>a_0}\mathbf1_{j=0}\frac{m(r)}r e^{irt}\\
 &+\int_{\max(r,a_0)}^A m(a)e^{iat}
 \left[
 it\frac{(a-r)^j}{a}
 +j\frac{(a-r)^{j-1}}a-\frac{(a-r)^j}{a^2}
 \right]\,da .
 \end{split}                                                 \tag{8}
$$
The term with $j$ is absent for $j=0$. The upper endpoint and the
lower endpoint for $r<a_0$ cancel precisely by (6).
At an arithmetic value of $r$, use the left limit;
this countable set has no effect on the $dr$ integrals.
There are no columns for $r>A$.

## 2. Scale the trace-class factorization to the actual cutoff

Replace the fixed oscillator by
$$
 \mathscr L_A=1+t^2-A^{-2}\partial_t^2,\qquad A\ge1.
$$
Unitary dilation of the harmonic oscillator gives eigenvalues
$1+(2n+1)/A$, $n\ge0$. Midpoint convexity gives
$$
 \|\mathscr L_A^{-1}\|_{\mathcal S_2}^2
 =\sum_{n\ge0}\left(1+\frac{2n+1}{A}\right)^{-2}
 \le A/2.                                                   \tag{9}
$$
For example apply the midpoint inequality on each interval
$[2n/A,(2n+2)/A]$ to $(1+x)^{-2}$ and sum.
The operator is positive self-adjoint on its oscillator domain.

Let $b_A=(1+t^2)\chi-A^{-2}\chi''$. Applying $\mathscr L_A$ to
the actual column $\chi(t)e^{-irt}T_{0,r}(t)$ gives
$$
 e^{-irt}\left[
 b_A T_{0,r}-2iA^{-2}\chi'T_{1,r}+A^{-2}\chi T_{2,r}
 \right].
$$
The two input-frequency halves have equal squared norm because the
phase and $\chi$ are real. The exact column identity from
[signed scattering tail energy](signed-scattering-tail-energy.md) therefore gives
$$
 \|\mathscr L_A M_\chi[P,M_{\theta_{\rm res}}]\|_{\mathcal S_2}^2
 =\frac1\pi\int_0^A\int_{\mathbb R}
 |b_A T_{0,r}-2iA^{-2}\chi'T_{1,r}+A^{-2}\chi T_{2,r}|^2\,dt\,dr.
                                                               \tag{10}
$$
Here $\theta_{\rm res}=2\int\sin(at)\mu_{\rm res}(da)/a$.
The signed column combination is formed before applying a bound.

For a Schwartz weight $w$, Plancherel in $t$, rather than a triangle
inequality over the history variable $a$, bounds the interior
integral in (8) by
$$
 \begin{split}
 &\int_0^A\int_{\mathbb R}
 \left|w(t)\int_{\max(r,a_0)}^A m(a)e^{iat}
 \left[it\frac{(a-r)^j}{a}
       +j\frac{(a-r)^{j-1}}a-\frac{(a-r)^j}{a^2}\right]da
 \right|^2dt\,dr\\
 &\hspace{15mm}\le C_w
       \int_{a_0}^A m(a)^2\left(a^{2j-1}+a^{2j-3}\right)\,da.
 \end{split}                                                 \tag{11}
$$
Use $\|w\|_\infty,\|tw\|_\infty$ before Plancherel,
then integrate the powers of $a-r$ over $0<r<a$.
The first squared coefficient integrates to $a^{2j-1}/(2j+1)$.
For $j\ge1$, the middle one integrates to
$j^2a^{2j-3}/(2j-1)$; the last has the same power.
For $j=0$, the middle term is absent.
The lower term of (8) costs $C_w\int_{a_0}^A m(r)^2/r^2\,dr$.

The seminorms needed for $b_A$ and $t b_A$ are uniform for $A\ge1$.
In (10), the squared coefficients of $T_1,T_2$ are $O(A^{-4})$.
For $a_0\le a\le A$,
$$
 a^{-3}+a^{-2}\le C/a,\qquad
 A^{-4}(a+a^{-1})\le C/a,\qquad
 A^{-4}(a^3+a)\le C/a.
$$
Consequently
$$
 \|\mathscr L_A M_\chi[P,M_{\theta_{\rm res}}]\|_{\mathcal S_2}^2
 \le C_\chi H(A).                                           \tag{12}
$$
Initially use smooth compact spectral inputs. The columns and their
$\mathscr L_A$ images are square integrable by (10)–(12).
Closedness and the bounded inverse identify the operator with
$\mathscr L_A^{-1}(\mathscr L_A M_\chi[P,M_{\theta_{\rm res}}])$.
Hilbert–Schmidt factorization with (9), and exact trace-norm Duhamel,
prove
$$
 N_\chi(M_{e^{i\theta_{\rm res}}})
 \le C_\chi\sqrt{A H(A)}.                                   \tag{13}
$$
For each fixed $A$, (6) is a finite signed measure supported away
from zero, so its real phase is bounded. Duhamel is a trace-norm
Bochner integral, not an exponentiation of an unregulated series.

## 3. Restore all admitted-prime powers and the exact cocycle

The difference between (5) and the actual product (2) is the phase
$$
 \theta_{\rm tail}(t)=
 -2\sum_{\substack{p\le N,\ k\ge2\\p^k>N}}
       \frac{p^{-k/2}}k\sin(kt\log p).                       \tag{14}
$$
The established interval estimate bounds its full weighted commutator by
$$
 C_\chi\sum_{p\le N,k\ge2}
 \frac{p^{-k/2}}k\left(k\log p+\sqrt{k\log p}\right)
 \le C_\chi(1+\log N).                                      \tag{15}
$$
This includes every $k$; the geometric series is summed, not truncated.
Chebyshev and partial summation give the last estimate, with the square
terms $\sum_{p\le N}\log p/p$ retained.
For fixed $N$, the bounded phase and commutator series converge
in the needed norms, so Duhamel applies to the actual tail.

For commuting scalar unitaries $U,V$, both exact cocycle orderings are
$$
 \Delta(UV)=\Delta(U)+U^*\Delta(V)U
          =\Delta(V)+V^*\Delta(U)V.                         \tag{16}
$$
Since $M_\chi$ commutes with these conjugations, (16) proves
subadditivity of $N_\chi$, without deleting a conjugating factor.
The new exact square-tail separation in
[admitted prime square counterphase](../prime-distribution/admitted-prime-square-counterphase.md) improves this mandatory
proper-power cost. With
$$
 \varphi_A(t)=\int_A^{2A}\frac{\sin(at)}a\,da,
$$
that note proves
$$
 N_\chi(e^{i(\theta_{\rm tail}+\varphi_A)})
 \le C_\chi[A^{5/2}e^{-b\sqrt A}+N^{-1/6}],\qquad
 N_\chi(e^{-i\varphi_A})\le C_\chi\log(2+A).
$$
The first bound retains the signed square-prime discrepancy and every
higher power; the second estimates the deterministic factor itself.
Both product orderings and its cutoff increment are explicit in that
note. Thus the original tail in (14), without changing (2), has weighted
defect $O_\chi(\log(2+A))$. Combining this improvement, (7), (13), and
the fixed gamma/origin factor proves (4). The coarser estimate (15)
is retained as a separate check that all power series converge.

## 4. Insert the actual action and terminal-square controls

The unconditional finite-prefix comparison in
[total clock dissipation and signed work](../factorial-and-renewal/total-clock-dissipation-and-signed-work.md), including its precisely
scaled integer density-cell bridge, gives
$$
 \mathscr J(A):=\int_1^A\frac{m(u)^2}{u^2}\,du
 \le C_c(1+\mathbf D_c(N)).                                \tag{17}
$$
The actual fixed interval $[a_0,1]$ is included in the constant. Thus
$$
 H(A)\le C+A\mathscr J(A)\le C_c A(1+\mathbf D_c(N)).          \tag{18}
$$

For the terminal charge, use the exact frozen-source transform
$$
 \widehat a_N(\xi)=
 \frac{m(A)e^{-i\xi A}+i\xi\int_0^A m(u)e^{-i\xi u}\,du}
      {1/2+i\xi}.
$$
Retaining $|\xi|\le\epsilon/A$ in the nonnegative norm integral,
for one fixed small $\epsilon>0$, gives
$$
 J_N\ge a_{c,\epsilon}\frac{m(A)^2}{A}
                   -b_\epsilon\frac{F(A)^2}{A^3},
 \qquad F(A)=\int_0^A|m(u)|\,du.                            \tag{19}
$$
Use $|p+q|^2\ge|p|^2/2-|q|^2$, the small-band lower bound for
$e^{-2cA\psi(\xi)}$, and a separate upper bound for the negative term.
No cancellation of the signed interior is assumed.
Weighted Cauchy–Schwarz gives
$$
 F(A)^2\le C+C A^3\mathscr J(A).
$$
Equations (17), (19) imply
$$
 |m(A)|^2\le C_c A\left[1+J_N+\mathbf D_c(N)\right].          \tag{20}
$$
Substituting (18), (20) into (4) proves (3).
The endpoint charge has not been removed from the source:
its cost is paid by the original terminal square and actual action.

## 5. Fixed physical tests and the remaining arithmetic obligation

For fixed $f\in C_c^\infty(\mathbb R)$ with both pole moments zero,
take $\chi=|\widehat f|^2$. The complete trace readout of (2) equals
the actual Weil form $Q(f)$ once $\log N$ exceeds the correlation
support diameter, by the exact stable-rational normalization in the
cited notes. This statement and (3) keep the physical test fixed.
The archimedean multiplier, initial source, and admitted-prime tail
remain part of the operator or budget being estimated.

Equation (3) is a quantitative forward comparison with square-root
dependence on the actual positive birth budget. A subpower upper bound
for that budget would imply subpower canonical trace-norm growth,
but no such bound is supplied here. Positivity of $J_N+\mathbf D_c(N)$
is its norm/action identity, not a bound on its magnitude or a sign
for $Q(f)$. The unresolved step remains cancellation in the actual
signed sum $W_N$, with the complete diagonal and dissipation retained.

## 6. The literal dyadic prime cocycle has a local charge-history bound

There is also a comparison that uses only the charge on one dyadic
arithmetic block. For $N\ge3$, put $A=\log N$, $B=\log(2N)$, and
$$
 R_N=\widehat U_N^*\widehat U_{2N},\qquad
 Z_N(t)=\exp\!\left[
       2iM_{2N}\frac{\sin(Bt)}B
       -2iM_N\frac{\sin(At)}A\right].
$$
$R_N$ is the actual relative multiplier: its local factors are exactly
the newly admitted primes $N<p\le2N$, with every power, and its
continuum phase is the original integral over $(A,B]$.
The fixed archimedean and rational factors cancel exactly in this
relative product. They remain in the global operator (2).

The unconditional dyadic estimates are
$$
 \boxed{N_\chi(R_NM_{Z_N})
 \le C_\chi\left[1+
       \left(\int_A^B m(a)^2\,da\right)^{1/2}\right],}           \tag{21}
$$
$$
 \boxed{N_\chi(R_N)
 \le C_\chi\left[1+|M_N|+|M_{2N}|+
       \left(\int_A^B m(a)^2\,da\right)^{1/2}\right].}           \tag{22}
$$
The auxiliary endpoint factor $Z_N$ is displayed in (21) and is paid
for by (7) in the unmodified comparison (22).

To prove these claims, the difference of the complete-cutoff measures
is precisely $-dm$ on $(A,B]$. This excludes the atom at $N$ and
includes the one at $2N$. Its residual after multiplication by $Z_N$
is
$$
 -dm\big|_{(A,B]}+m(B)\delta_B-m(A)\delta_A.                   \tag{23}
$$
The lower boundary value here is $m(A)$, the right value, rather
than $m(A-)$. The calculation (8) holds with lower endpoint $A$,
upper endpoint $B$, and this convention. Apply the oscillator
$\mathscr L_B$. The same Plancherel estimate, now with interior
integration only over $(A,B)$, gives
$$
 N_\chi(e^{i\theta_{\rm res,block}})
 \le C_\chi\left(B\int_A^B\frac{m(a)^2}{a}\,da\right)^{1/2}
 \le C_\chi\left(\int_A^B m(a)^2\,da\right)^{1/2},
                                                               \tag{24}
$$
because $B/A$ is uniformly bounded for $N\ge3$.
The history columns still range over all $0<r<B$; they have not
been restricted to the new arrivals before computing their norm.

The remaining tail difference retains both deterministic square
phases. For $\alpha\ge1$,
$$
 \partial_\alpha\varphi_\alpha(t)
       =\frac{\sin(2\alpha t)-\sin(\alpha t)}{\alpha}.
$$
The interval commutator estimate used in (7) bounds
$\|M_\chi[P,M_{\partial_\alpha\varphi_\alpha}]\|_1$
by a constant $C_\chi$, uniformly for $\alpha\ge1$.
Integrating from $A$ to $B$, whose length is $\log2$, and using
Duhamel proves
$$
 N_\chi(e^{-i(\varphi_B-\varphi_A)})\le C_\chi.               \tag{25}
$$
The corrected square-discrepancy and higher-power factors at $N$
and $2N$ have uniformly bounded weighted defects, in fact tending
to zero, by the square-tail note. The exact commuting cocycle
therefore adds only a fixed constant to (24). This proves (21);
(7) and the inverse of $Z_N$ give (22).

The original growing-prime identity retains its conjugation:
$$
 \Delta(\widehat U_{2N})
   =\Delta(R_N)+R_N^*\Delta(\widehat U_N)R_N.                 \tag{26}
$$
Thus (21)–(22) are estimates for the actual relative factor entering
this identity, not a sum of independent prime defects. For a fixed
compact pole-null physical test, the readout of $Z_N$ is zero once
$A$ exceeds its correlation diameter; this is exact support
orthogonality, not a claim that $Z_N$ has zero defect norm.

Under RH the local square-mean theorem makes the right side of (21)
uniformly bounded. The endpoint costs in (22) remain. Unconditionally
the local charge integral in (21)–(24) is still an actual arithmetic
quantity to be controlled; neither comparison assigns a favorable
sign to the original dyadic cocycle or the full Weil form.
