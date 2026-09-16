# Abel divisor-cube Stokes identity and the LCM escape obstruction

Put

\[
 \rho=e^{-2/X},\qquad
 K_\rho(d,e)=\frac{\rho^{\max(d,e)}}{1-\rho},
 \qquad M(N)=\sum_{d\leq N}\mu(d).
 \tag{1}
\]

All integer labels below are squarefree; nonsquarefree labels have zero
Möbius coefficient.  The exact Abel Gram is

\[
 \boxed{
 D_X=\sum_{N\geq1}\rho^N M(N)^2
 =\sum_{d,e\geq1}\mu(d)\mu(e)K_\rho(d,e).}
 \tag{2}
\]

This note puts (2) on the oriented Boolean divisor complex.  The weighted
boundary commutator is exact and has the expected horizon faces.  However,
completion of the LCM cubes leaves an escape term equal to
\(M(N)^2-M(N)\).  After Abel summation that escape differs from \(D_X\) by
only an unconditional \(O(X^2)\) linear term.  A Stokes or Hardy estimate
for the escape at scale \(X^{2+\varepsilon}\) is therefore precisely the
original Abel--Mertens target.

## 1. The oriented prime-deletion complex

Order the primes.  If \(n=p_1\cdots p_k\), with
\(p_1<\cdots<p_k\), write \(e_n\) for the corresponding oriented
\(k\)-cell and set

\[
 \partial e_n=\sum_{j=1}^k(-1)^{j-1}e_{n/p_j}.
 \tag{3}
\]

The divisor diamonds give \(\partial^2=0\).  Notice that
\(\mu(n)=(-1)^k\) is the parity augmentation; it is not by itself a
cycle identity.

For a literal horizon \(L\), define

\[
 k_L(d,e)=1_{\max(d,e)\leq L}
 \sum_{N=\max(d,e)}^L\rho^N
 =1_{\max(d,e)\leq L}
 \frac{\rho^{\max(d,e)}-\rho^{L+1}}{1-\rho}.
 \tag{4}
\]

On the tensor product complex let

\[
 B=\partial\otimes1+(-1)^{\deg}\otimes\partial,
 \qquad W_Le_{d,e}=k_L(d,e)e_{d,e}.
 \tag{5}
\]

Here \(W_L\) is the archimedean max-weight, including its hard horizon.
The commutator is

\[
\boxed{
\begin{aligned}
 [B,W_L]e_{d,e}
={}&\sum_{j=1}^{\omega(d)}(-1)^{j-1}
 \bigl[k_L(d,e)-k_L(d/p_j,e)\bigr]e_{d/p_j,e}\\
 &+(-1)^{\omega(d)}\sum_{j=1}^{\omega(e)}(-1)^{j-1}
 \bigl[k_L(d,e)-k_L(d,e/q_j)\bigr]e_{d,e/q_j}.
\end{aligned}}
\tag{6}
\]

Every coefficient in (6) is explicit.  For example, if \(d,e\leq L\),

\[
 k_L(d,e)-k_L(d/p,e)=
 \begin{cases}
 0,&d\leq e,\\[2mm]
 -\displaystyle\sum_{N=\max(d/p,e)}^{d-1}\rho^N,&d>e.
 \end{cases}
 \tag{7}
\]

If \(d>L\), \(e\leq L\), and \(d/p\leq L\), the same coefficient is
the horizon-entry face

\[
 k_L(d,e)-k_L(d/p,e)
 =-\sum_{N=\max(d/p,e)}^L\rho^N.
 \tag{8}
\]

All other cases follow by interchanging \(d,e\), or vanish.  Thus there
is no hidden boundary term: (7) is the interior max-weight flux and (8)
is the exact finite-horizon escape.  Letting \(L\to\infty\) recovers the
kernel in (1).

For comparison, the one-coordinate annihilator \(a_p e_{pm}
=(-1)^{\#\{q<p:q\mid m\}}e_m\) gives directly

\[
 [a_p,G_\rho]_{m,n}
 =(-1)^{\#\{q<p:q\mid m\}}K_\rho(pm,n)
 -1_{p\mid n}(-1)^{\#\{q<p:q\mid n/p\}}K_\rho(m,n/p),
 \tag{9}
\]

where \(G_\rho=(K_\rho(d,e))_{d,e}\).  Formula (9) is the coefficient
space version of (6).  It is a signed difference of the original Gram
rows, not a new positive form.

## 2. Exact completion of an LCM packet

Fix a squarefree \(\ell\).  The complete pair packet with
\([d,e]=\ell\) has oriented augmentation

\[
 \boxed{
 \sum_{[d,e]=\ell}\mu(d)\mu(e)=\mu(\ell).}
 \tag{10}
\]

Indeed, at each prime of \(\ell\) the allowed membership states are
\((1,0),(0,1),(1,1)\), whose signed weights are \(-1,-1,+1\); their
sum is \(-1\), and the primes factor independently.

At horizon \(N\), put

\[
 A_N(\ell)=
 \sum_{\substack{d,e\leq N\\[d,e]=\ell}}\mu(d)\mu(e).
 \tag{11}
\]

If \(\ell\leq N\), every divisor face is present, so (10) gives
\(A_N(\ell)=\mu(\ell)\).  If \(\ell>N\), the LCM packet is cut by
the two inequalities \(d,e\leq N\).  Since a retained pair has
\([d,e]\leq N^2\), grouping the square of the prefix by LCM gives the
finite identity

\[
\boxed{
 M(N)^2=M(N)+\mathcal E_N,
 \qquad
 \mathcal E_N=
 \sum_{N<\ell\leq N^2}A_N(\ell)=M(N)^2-M(N).}
 \tag{12}
\]

Thus \(\mathcal E_N\) is exactly the sum of the incomplete LCM faces.
It is nonnegative because \(M(N)\) is an integer and
\(M(N)^2-M(N)=M(N)(M(N)-1)\geq0\).  Individual LCM packets and
individual prime faces still have either sign.

Equivalently, if

\[
 B_N(\ell)=
 \sum_{\substack{[d,e]=\ell\\\max(d,e)>N}}\mu(d)\mu(e),
 \tag{13}
\]

then for \(N<\ell\leq N^2\),
\(A_N(\ell)=\mu(\ell)-B_N(\ell)\).  This is the literal Stokes
completion: the full Boolean packet contributes the Euler term
\(\mu(\ell)\), while \(B_N(\ell)\) is the face lost through the
archimedean horizon.

## 3. The Abel Stokes flux is the original target

Abel summation of (12) gives

\[
 \boxed{
 D_X=L_X+\mathcal E_X,\qquad
 L_X=\sum_{N\geq1}\rho^NM(N),\qquad
 \mathcal E_X=\sum_{N\geq1}\rho^N\mathcal E_N.}
 \tag{14}
\]

There is also a closed pairwise formula with exact endpoints.  Completion
of every LCM packet below \(N\) says

\[
 M(N)=\sum_{d,e\geq1}\mu(d)\mu(e)
 1_{[d,e]\leq N}.
 \tag{14a}
\]

Since \([d,e]\geq\max(d,e)\), subtraction from the Gram prefix gives

\[
 \mathcal E_N=
 \sum_{d,e\geq1}\mu(d)\mu(e)
 1_{\max(d,e)\leq N<[d,e]}.
 \tag{14b}
\]

The integer interval is empty when \([d,e]=\max(d,e)\).  Summing it
against \(\rho^N\) yields the exact weighted Stokes kernel

\[
\boxed{
 \mathcal E_X=\frac1{1-\rho}
 \sum_{d,e\geq1}\mu(d)\mu(e)
 \left(\rho^{\max(d,e)}-\rho^{[d,e]}\right).}
 \tag{14c}
\]

Correspondingly,

\[
 L_X=\frac1{1-\rho}\sum_{d\geq1}\mu(d)\rho^d
 =\frac1{1-\rho}\sum_{d,e\geq1}
   \mu(d)\mu(e)\rho^{[d,e]}.
 \tag{14d}
\]

The second equality is (10), grouped by \([d,e]\).  Exponential decay
makes these grouped sums absolutely convergent.  Thus (14c) contains
both the max-weight commutator and the LCM-completion face, without a
missing endpoint or sign.

The kernel in (14c) is not positive on arbitrary coefficient packets.  If
\(d,e\) are incomparable, its two-by-two restriction has zero diagonal
and positive off-diagonal entry
\((\rho^{\max(d,e)}-\rho^{[d,e]})/(1-\rho)\), hence one positive and
one negative eigenvalue.  Its nonnegativity on the full Möbius vector is
the arithmetic identity \(\mathcal E_N=M(N)(M(N)-1)\), not generic
Hilbert-space positivity.

The completed-cube term is harmless without cancellation:

\[
 |L_X|
 \leq\sum_{N\geq1}N\rho^N
 =\frac{\rho}{(1-\rho)^2}
 \leq \left(1+\frac X2\right)^2.
 \tag{15}
\]

The last inequality uses
\((1-e^{-u})^{-1}\leq1+u^{-1}\).  Consequently

\[
 \boxed{
 D_X-\left(1+\frac X2\right)^2
 \leq\mathcal E_X
 \leq D_X+\left(1+\frac X2\right)^2.}
 \tag{16}
\]

The escape is therefore quantitatively equivalent to the Abel Gram at
the requested scale.  In particular,

\[
 \mathcal E_X\ll_\varepsilon X^{2+\varepsilon}
 \quad\Longleftrightarrow\quad
 D_X\ll_\varepsilon X^{2+\varepsilon},
 \tag{17}
\]

with only the explicit \(O(X^2)\) loss in (16).  A weighted Stokes or
Hardy inequality that controls all incomplete LCM faces proves exactly
the desired Abel--Mertens estimate; cube exactness and positivity do not
supply that inequality.

## 4. Prime-depleted and one-prime sign tests

For a prime \(p\), let

\[
 M^{(p)}(N)=\sum_{\substack{d\leq N\\p\nmid d}}\mu(d).
 \tag{18}
\]

The same LCM calculation restricted to labels prime to \(p\) gives

\[
 \bigl(M^{(p)}(N)\bigr)^2
 =M^{(p)}(N)+
 \sum_{\substack{N<\ell\leq N^2\\p\nmid\ell}}A_N(\ell).
 \tag{19}
\]

Thus prime depletion does not make the escape coercive; it reproduces the
square of the depleted prefix.  Restoring the prime gives the exact
admission identity

\[
 M(N)=M^{(p)}(N)-M^{(p)}(\lfloor N/p\rfloor)
 \tag{20}
\]

and the energy increment

\[
 M(N)^2-M^{(p)}(N)^2
 =B_N^2-2A_NB_N,
 \quad A_N=M^{(p)}(N),\quad
 B_N=M^{(p)}(\lfloor N/p\rfloor).
 \tag{21}
\]

It has no sign even on the actual sequence.  For \(p=2,N=2\),
\((A_N,B_N)=(1,1)\), so (21) is \(-1\).  For \(p=2,N=3\),
\((A_N,B_N)=(0,1)\), so it is \(+1\).  Hence neither prime admission
nor prime deletion defines a pointwise dissipative filtration.

For the complete one-prime cube \(\{1,p\}\), the coefficient packet is
\(e_1-e_p\).  Its Abel energy is exactly

\[
 \|e_1-e_p\|_{G_\rho}^2
 =\sum_{N=1}^{p-1}\rho^N
 =\frac{\rho-\rho^p}{1-\rho}.
 \tag{22}
\]

The prefix takes only the values zero and one, so its nonlinear LCM
escape \(C(N)^2-C(N)\) vanishes identically.  Thus the escape cannot
dominate even this positive cube energy; here the entire energy sits in
the harmless linear term of (14).  Pairwise, this is simply
\([1,p]=\max(1,p)\), so the kernel (14c) vanishes on the whole
one-prime cube.

## 5. High-label edge packets

Let \(p\nmid m\), \(s=\mu(m)\), and retain the actual oriented edge

\[
 x_{m,p}=s(e_m-e_{pm}).
 \tag{23}
\]

Its prefix is \(s\,1_{m\leq N<pm}\), and hence

\[
 \boxed{
 \|x_{m,p}\|_{G_\rho}^2
 =\sum_{N=m}^{pm-1}\rho^N
 =\frac{\rho^m-\rho^{pm}}{1-\rho}.}
 \tag{24}
\]

This is also exactly the absolute max-weight jump on the corresponding
prime-deletion edge in (7).  For \(m=\lfloor\alpha X\rfloor\) and fixed
\(p\),

\[
 \|x_{m,p}\|_{G_\rho}^2
 =\frac X2\bigl(e^{-2\alpha}-e^{-2p\alpha}\bigr)+O(1).
 \tag{25}
\]

There is no gain in scale from the commutator.  Moreover, the scalar
LCM flux of this packet is zero for either orientation: all its label
pairs are comparable, and therefore \([d,e]=\max(d,e)\) throughout.
Thus the LCM boundary flux vanishes while the prime-deletion commutator
pays exactly the positive energy (24).  For
\(m\gg X\log X\), both sides of (24) are exponentially suppressed; this
is radial decay, not cube cancellation.

When many edges are combined, their interval prefixes overlap.  The
resulting cross terms are exactly the off-diagonal terms in (2), so
paying edge fluxes separately discards the Möbius cancellation and can
only increase the cost.

## 6. An explicit prime-toggle Morse matching

Let \(K_N\) be the downward-closed squarefree divisor complex whose
cells are prime sets \(S\) with \(\prod_{p\in S}p\leq N\), graded by
\(|S|\).  Its signed cell sum is \(M(N)\).  Inside
\(K_N\times K_N\), let

\[
 \Delta_N^{\mathrm{lcm}}
 =\{(d,e):[d,e]\leq N\}.
 \tag{25a}
\]

This is a subcomplex, since prime deletion can only lower the LCM.  By
(10), its signed cell sum is \(M(N)\), whereas that of the product is
\(M(N)^2\).  Therefore

\[
 \chi_{\mathrm{sgn}}
 (K_N\times K_N,\Delta_N^{\mathrm{lcm}})
 =M(N)^2-M(N)=\mathcal E_N.
 \tag{25b}
\]

Thus the escape is the signed Euler sum of a literal relative
prime-deletion complex.  The deleted set is the LCM subcomplex, which is
larger than the ordinary equality diagonal.

The LCM escape set at horizon \(N\) is

\[
 \Omega_N=\{(d,e):d,e\leq N<[d,e],\ d,e\ {\mathrm{squarefree}}\}.
 \tag{26}
\]

There is a concrete acyclic toggle matching, but its critical set is much
too large to estimate unsigned.  Fix \(\ell>N\), put
\(p=P^+(\ell)\), \(r=\ell/p\), and fix a base pair
\((a,b)\) with \([a,b]=r\).  The possible states in the \(p\)-fiber are

\[
 D=(pa,b),\qquad E=(a,pb),\qquad B=(pa,pb).
 \tag{27}
\]

They exist in \(\Omega_N\) under the exact conditions

\[
\begin{array}{c|c}
 D&pa\leq N,\ b\leq N,\\
 E&a\leq N,\ pb\leq N,\\
 B&pa\leq N,\ pb\leq N.
\end{array}
 \tag{28}
\]

If both \(D\) and \(E\) exist, then \(B\) exists, so every nonempty
fiber contains either one state or all three states.  In a three-state
fiber match \(D\leftrightarrow B\) by toggling \(p\) in the second
coordinate and leave \(E\) critical.  A singleton is critical.  The
matching is acyclic.  Indeed, after an upward matched step
\(D\to B\), a downward step other than the matched return either deletes
\(p\) from the first coordinate and terminates at \(E\), deletes a prime
unique to one coordinate and strictly lowers the LCM, or deletes a
nonlargest common prime and strictly lowers the number of common
nonlargest primes while preserving the LCM.  The lexicographic pair
\((\ell,\#\{q<P^+(\ell):q\mid d,e\})\) therefore decreases along every
continuing gradient path, so a closed path is impossible.

The matched signs cancel:

\[
 \mu(pa)\mu(b)=-\mu(a)\mu(b),\qquad
 \mu(pa)\mu(pb)=+\mu(a)\mu(b).
 \tag{29}
\]

Thus the signed sum of the critical cells is still exactly
\(\mathcal E_N\).  The number of critical cells is

\[
\boxed{
 C_N=\sum_{\substack{N<\ell\leq N^2\\\ell\ {\mathrm{squarefree}}}}
 \ \sum_{\substack{[a,b]=\ell/P^+(\ell)}}
 1_{\{P^+(\ell)a\leq N,\ b\leq N\}
       \ \vee\
       \{a\leq N,\ P^+(\ell)b\leq N\}}.}
 \tag{30}
\]

Formula (30) also records the unmatched boundary conditions.  More
explicitly, the singleton \(D\) boundary is

\[
 pa\leq N,\quad b\leq N,\quad pb>N,
 \tag{31}
\]

the singleton \(E\) boundary is obtained by interchanging \(a,b\), and
the three-state interior has \(pa,pb\leq N\) with its unavoidable
residual \(E\).  The odd three-state local fiber is why a prime toggle
cannot remove every critical cell.

The rough high-label sector already makes (30) large.  Let
\(\mathcal P_N=\{q:N/2<q\leq N,\ q\text{ prime}\}\).  For distinct
\(p,q\in\mathcal P_N\), the ordered pair \((p,q)\) belongs to
\(\Omega_N\).  If \(p>q\), it is the singleton \(D\) arising from
\(\ell=pq\) and base \((a,b)=(1,q)\); \((q,p)\) is the corresponding
singleton \(E\).  Consequently

\[
 \boxed{C_N\geq |\mathcal P_N|(|\mathcal P_N|-1)
 \gg \frac{N^2}{\log^2N}.}
 \tag{32}
\]

All these prime-pair critical cells have positive Möbius sign.  Across
horizons \(N\asymp X\), their unsigned Abel mass is of order
\(X^3/\log^2X\), far above the \(X^{2+\varepsilon}\) target.  Composite
critical cells must provide the missing signed repair.  Hence the Morse
matching has not converted the problem to a target-size critical-cell
count; it has isolated the same prime/composite cancellation demanded by
(14c).

## 7. Obstruction

The Boolean divisor complex does give a genuine exact Stokes formula:
(6)--(8) identify every interior and horizon face, while (10)--(14)
complete the divisor cubes and isolate their LCM escape.  It does not
give an independent Hardy inequality.

The completed faces contribute the linear quantity \(L_X=O(X^2)\).
The entire unresolved part is the nonnegative incomplete-face flux
\(\mathcal E_X=D_X-L_X\), which is equivalent to \(D_X\) by (16).
Prime depletion reproduces the same identity, one-prime admission is
sign-indefinite, and a high-label deletion edge pays exactly its original
Abel energy.  The explicit largest-prime toggle leaves at least
\(\gg N^2/\log^2N\) rough critical cells at horizon \(N\), and estimating
them without their composite signed repair loses a full horizon factor
after Abel summation.  Therefore a quantitative cube-Stokes estimate at
\(O(X^{2+\varepsilon})\) would be a proof of the Abel--Mertens target,
not a consequence of homological exactness, boundary orientation, or
archimedean truncation.


## Formalization status

The underlying complete LCM-fiber identity and exact terminal reserve $M(N)(M(N)-1)$ are already compiled in [FactorialTerminalReserve.lean](BuildingBlocks/FactorialTerminalReserve.lean). The tensor-complex commutator, relative-complex interpretation, and explicit Morse matching in this note are reviewed written mathematics and remain to be formalized.
