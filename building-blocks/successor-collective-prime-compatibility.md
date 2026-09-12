# Successor compatibility with the full prime operator

The actual successor is $\sigma(v)=\log(e^v+1)$. Its Jacobian-weighted pullback has an exact affine relation with dilation. Combining that relation with the complete prime-power kernel gives a bound for its commutator on the actual cutoff history. The initial boundary is explicit and has a convergent collective $L^2$ response.

Use $\mathcal H=L^2(\mathbb R,dv)$, $\Pi=1_{[0,\infty)}$, $Q=I-\Pi$, and $E_hf(v)=f(v+h)$. The change of coordinates

$$
(\mathcal Wf)(x)=x^{-1/2}f(\log x),\qquad x>0,
\tag{1}
$$

is unitary onto $L^2((0,\infty),dx)$. Under it, $E_h$ becomes the unitary dilation $\mathsf D_af(x)=\sqrt a f(ax)$, $a=e^h$.

## The successor and its initial interval

For $s>0$, define

$$
J_sf(v)=\sqrt{\frac{e^v}{e^v+s}}\,
f\bigl(\log(e^v+s)\bigr).
\tag{2}
$$

Under (1), $J_s$ is the additive pullback $\mathsf T_sg(x)=g(x+s)$. It is a coisometry, not a unitary. The actual causal successor is $S=\Pi J_1\Pi$ on $\Pi\mathcal H$. It satisfies

$$
SS^*=I_{\Pi\mathcal H},\qquad
S^*S=1_{[\log2,\infty)}.
\tag{3}
$$

Thus its missing input is exactly the initial interval $[0,\log2)$. Direct substitution gives the full affine identity

$$
E_hJ_s=J_{se^{-h}}E_h,
\qquad J_sE_h=E_hJ_{se^h}.
\tag{4}
$$

This is the classical compatibility of addition and multiplication, with the Jacobian fixed by the actual $L^2(dv)$ space. It does not identify the continuous representation with a discrete counting isometry.

Take the actual causal history

$$
a(v)=e^{-v/2}(\psi(e^v)-e^v),\qquad a(0)=-1,
$$

and $a_T=\chi_Ta$, extended by zero to negative time. The cutoff is one through $T$, linear to zero at $T+1$, and zero thereafter. Write $x=e^v$ for $v\ge0$. The inclusive successor increment is exactly

$$
\begin{aligned}
(S-I)a_T(v)
={}&\left[\chi_T(\sigma(v))\frac{x}{x+1}-\chi_T(v)\right]a(v)\\
&+\chi_T(\sigma(v))\frac{\sqrt x}{x+1}
\bigl[\Lambda(\lfloor x\rfloor+1)-1\bigr].
\end{aligned}
\tag{5}
$$

Indeed, $(x,x+1]$ contains precisely the integer $\lfloor x\rfloor+1$. Equation (5) retains the upper cutoff, every proper prime power, and the continuous density. Away from the upper cutoff it reduces to the same formula with both cutoff values equal to one.

## Full prime powers and the causal commutator

For a prime $p$, set $h=\log p$, $r=p^{-1/2}$, and use the full-line unitary

$$
U_p=(I-rE_h)(I-rE_{-h})^{-1}
=-rE_h+(1-r^2)\sum_{j\ge0}r^jE_{-jh}.
\tag{6}
$$

The series converges in operator norm. No prime-power depth is removed. Let

$$
L_P=\sum_{p\le P}(U_p-I)^*(U_p-I)
=\sum_{p\le P}(2I-U_p-U_p^*),
\qquad L_{P,+}=\Pi L_P\Pi.
\tag{7}
$$

The same-prime cancellation gives the exact local kernel

$$
L_p=2r^2I+r^3(E_h+E_{-h})
-(1-r^2)\sum_{j\ge2}r^j(E_{jh}+E_{-jh}).
\tag{8}
$$

The terms of order $r$ have canceled before any estimate. Since $\Pi J_1Q=0$, compression gives

$$
[S,\Pi U_p\Pi]
=\Pi[J_1,U_p]\Pi+\Pi U_pQJ_1\Pi,
\tag{9}
$$

$$
\boxed{[S,L_{P,+}]
=\Pi[J_1,L_P]\Pi+\Pi L_PQJ_1\Pi.}
\tag{10}
$$

The second term is the initial boundary, not an error from the small displacement $\sigma(v)-v$. The full-power bulk commutator is specified by (4), (6), and (8). In additive coordinates it uses the particularly simple identity

$$
[\mathsf T_1,\mathsf D_a]
=\mathsf D_a(\mathsf T_a-\mathsf T_1).
\tag{11}
$$

The restriction in (7) also retains the negative-output energy. If $V_p=\Pi U_p\Pi$ and $F_p=QU_p\Pi$, then

$$
\sum_{p\le P}(V_p-I)^*(V_p-I)
=L_{P,+}-\sum_{p\le P}F_p^*F_p.
\tag{12}
$$

Replacing $L_{P,+}$ by the left side would therefore discard an actual port.

## The actual initial boundary has a collective limit

Assume $T\ge\log2$. Below the first prime, $a(v)=-e^{v/2}$, so the negative successor output is exactly

$$
h_0(v):=QJ_1a_T(v)=-e^{v/2}1_{v<0}.
\tag{13}
$$

It is independent of the upper cutoff and has squared norm one. Summing (6) on $v\ge0$ gives

$$
\Pi U_ph_0(v)=-e^{v/2}p^{-\lfloor v/\log p\rfloor-1},
\qquad
\Pi U_p^*h_0(v)=p^{-1}e^{v/2}1_{0\le v<\log p}.
\tag{14}
$$

Endpoints are immaterial in $L^2$. Both terms in (14) are retained in (10). Their leading strip cancels, leaving

$$
\boxed{B_p(v):=\Pi L_ph_0(v)
=e^{v/2}p^{-\lfloor v/\log p\rfloor-1}
1_{v\ge\log p}.}
\tag{15}
$$

In particular $\|B_p\|_2=p^{-1}$. The triangle bound obtained by summing these norms diverges over all primes, but the complete response does converge. Define

$$
B_\infty(v)=\sum_pB_p(v).
$$

The sum is pointwise finite because only $p\le e^v$ contribute. For $x=e^v$ large, split the primes at $\sqrt x$. In the lower part $p^{\lfloor\log x/\log p\rfloor+1}>x$, whereas in the upper part the exponent is exactly two. Chebyshev counting and partial summation imply

$$
B_\infty(v)
\le\frac{\pi(\sqrt x)}{\sqrt x}
+\sqrt x\sum_{p>\sqrt x}p^{-2}
\ll\frac1{\log x}.
$$

The initial bounded interval gives the uniform form

$$
\boxed{0\le B_\infty(v)\ll\frac1{1+v},\qquad
\sup_P\|\Pi L_PQJ_1a_T\|_2<\infty.}
\tag{16}
$$

Moreover, primes greater than $P$ contribute only for $v\ge\log P$. Therefore

$$
\left\|B_\infty-\sum_{p\le P}B_p\right\|_2
\ll\frac1{\sqrt{\log(2P)}}.
\tag{17}
$$

This is an actual-source estimate using only Chebyshev bounds. It does not use a prime-independence model or a discarded high-power tail.

## A bounded-variation estimate for the bulk

For $g\in L^2(\mathbb R)\cap L^\infty(\mathbb R)$ of finite total variation, put $N=\|g\|_2$, $M=\|g\|_\infty$, and $V=\operatorname{TV}(g)$. Translation of its derivative measure and Fubini give

$$
\|\mathsf T_ag-\mathsf T_bg\|_1\le V|a-b|,
\qquad
\|\mathsf T_ag-\mathsf T_bg\|_2
\le\min(2N,\sqrt{2MV|a-b|}).
\tag{18}
$$

Functions on $(0,\infty)$ are extended by zero before using this estimate. Restriction back to the positive axis can only reduce the norm. Thus (11) gives

$$
\|[\mathsf T_1,\mathsf D_a]g\|_2
\le\min(2N,\sqrt{2MV|a-1|}).
\tag{19}
$$

Assume $MV>0$ and put $A=N/\sqrt{MV}$. Inserting (19) into the complete signed kernel (8) proves

$$
\|[J_1,L_p]\mathcal W^{-1}g\|_2
\ll\sqrt{MV}\left[
\frac1p+\sum_{j\ge2}\min(2A p^{-j/2},1)\right].
\tag{20}
$$

Here the first-power pair contributes $O(\sqrt{MV}/p)$. The negative-shift higher powers contribute the same bound since $|p^{-j}-1|\le1$ and $\sum_{j\ge2}p^{-j/2}\ll p^{-1}$. For the positive shifts, the factor $p^{j/2}$ in (19) cancels the geometric coefficient only until the alternative $2N$ bound takes over. The remaining depth sum satisfies

$$
\sum_{j\ge2}\min(2A p^{-j/2},1)
\ll1+\frac{\log_+(2A)}{\log p}.
\tag{21}
$$

This follows by splitting at $j=2\log_+(2A)/\log p$ and summing the complete geometric tail. If $MV=0$, the compactly supported input is zero and the estimates hold trivially.

For the actual source, (1) gives

$$
g_T(x)=1_{x\ge1}\chi_T(\log x)
\left[\frac{\psi(x)}x-1\right].
\tag{22}
$$

Chebyshev's bound $\psi(x)\le Cx$ proves

$$
\|g_T\|_\infty\ll1,\qquad
\operatorname{TV}(g_T)\ll T+1,\qquad
\|g_T\|_2\ll e^{(T+1)/2}.
\tag{23}
$$

To verify the variation bound, retain the initial jump $-1$ at $x=1$ and every jump $\chi_T(\log n)\Lambda(n)/n$. Their absolute sum is $O(T+1)$ by partial summation. Between arrivals the derivative is

$$
\chi_T'(\log x)\frac{\psi(x)/x-1}{x}
-\chi_T(\log x)\frac{\psi(x)}{x^2}.
$$

Its absolute integral is $O(T+1)$. The continuous cutoff creates no new atom at either upper join. Thus no minimum spacing or smoothness across prime powers is assumed.

The initial jump also gives $M,V\ge1$, so $\log_+(2A)\ll T+1$. Summing (20)--(21), and using
$\pi(P)\ll P/\log(2P)$ and
$\sum_{p\le P}(\log p)^{-1}\ll P/\log^2(2P)$, yields

$$
\boxed{
\|[J_1,L_P]a_T\|_2
\ll\sqrt{T+1}\,\frac{P}{\log(2P)}
\left[1+\frac{T+1}{\log(2P)}\right].}
\tag{24}
$$

Together with the exact boundary (16), this proves

$$
\boxed{
\|[S,L_{P,+}]a_T\|_2
\ll1+\sqrt{T+1}\,\frac{P}{\log(2P)}
\left[1+\frac{T+1}{\log(2P)}\right],
\quad T\ge\log2.}
\tag{25}
$$

All implicit constants can be chosen from a fixed Chebyshev constant. The exponential upper bound for the source norm in (23) enters only through its logarithm in (21).

If $I_T=(S-I)a_T$ is the exact innovation (5), the compatibility statement can equivalently be read as

$$
(S-I)L_{P,+}a_T-L_{P,+}I_T
=[S,L_{P,+}]a_T,
\tag{26}
$$

with the right side controlled by (25). This constrains the innovation family generated by the actual successor and the complete prime operator. It does not bound $L_{P,+}a_T$ itself.

## A stronger actual-source modulus, uniform in the cutoff

The classical PNT remainder improves (25) to a bound independent of $T$. Keep the same exact $g_T$ from (22), extended by zero to the entire additive line, and put
$g_\infty(x)=1_{x\ge1}(\psi(x)/x-1)$.
There are constants $C,c_1>0$, independent of $T$, such that

$$
\boxed{\|g_T(\cdot+h)-g_T\|_2^2
\le\begin{cases}
Ch,&0<h\le1,\\
Ch\exp(-c_1\sqrt{\log h}),&h\ge2.
\end{cases}}
\tag{27}
$$

The bounded intermediate interval is absorbed by changing $C$.

For the first estimate, the additive distributional derivative has the initial atom $-\delta_1$, the exact atoms $\chi_T(\log n)\Lambda(n)n^{-1}\delta_n$, and the continuous density displayed after (23). The sum of squared atomic coefficients is bounded uniformly in $T$, since $\sum_{n\ge2}(\log n)^2/n^2<\infty$. An interval of length $h\le1$ contains at most one integer, apart from endpoints of measure zero. Thus the atomic translation energy is at most $Ch$. The continuous density has uniformly bounded $L^2$ norm, giving $Ch^2$. This proves the first line and retains all prime-power jumps.

For the second estimate use the classical unconditional bound

$$
|g_\infty(x)|\le C_0e^{-c_0\sqrt{\log x}},\qquad x\ge1.
\tag{28}
$$

A split at $\sqrt Y$ shows, after reducing the exponent if necessary,

$$
\int_1^Y|g_\infty(x)|^2dx
\le C Y e^{-c_0\sqrt{\log Y}}.
\tag{29}
$$

For large $h$ put $Y=h\exp(d\sqrt{\log h})$, where $d=c_0/2$. On $-h\le x\le Y$, the energy of the difference is bounded by a constant times the integral of $|g_\infty|^2$ through $Y+h$. Equations (28)--(29) bound it by $Ch\exp(-c_0\sqrt{\log h}/2)$.

For $x\ge Y$ the interval $(x,x+h]$ has at most $h+1$ integers, so

$$
|\psi(x+h)-\psi(x)|\le(h+1)\log(x+h).
$$

Chebyshev's estimate then gives
$|g_\infty(x+h)-g_\infty(x)|\le Ch\log x/x$ for $h\ge1$ and $x\ge Y\ge2h$. The cutoff has exactly the required uniform estimate

$$
|\chi_T(\log(x+h))-\chi_T(\log x)|
\le\log(1+h/x)\le h/x.
$$

Since $|g_\infty|$ is bounded, the product $g_T$ satisfies the same tail bound. Hence

$$
\int_Y^\infty|g_T(x+h)-g_T(x)|^2dx
\le C\frac{h^2\log^2Y}{Y}
\le Ch\exp(-c_1\sqrt{\log h})
$$

for a fixed $c_1>0$. Together with the head estimate this proves (27), including both cutoff transitions. Increasing $C$ covers the remaining bounded values of $h$.

For each fixed $h$, these same tail bounds and local convergence show that
$g_T(\cdot+h)-g_T\to g_\infty(\cdot+h)-g_\infty$ in $L^2$.
No assertion that $g_\infty$ itself belongs to $L^2$ is used.

Insert (27) into the exact affine commutator (11). For positive dilation $p^j$, its translation increment is $p^j-1$. The norm is bounded by
$Cp^{j/2}\exp(-c_2\sqrt{j\log p})$, with fixed $c_2>0$. For negative dilation $p^{-j}$ the increment has length less than one, giving a uniform bound. Thus (8) gives the cutoff-uniform estimate

$$
\boxed{\sup_{T\ge\log2}\|[J_1,L_p]a_T\|_2
\le C\left[\frac1p+
\sum_{j\ge2}e^{-c_2\sqrt{j\log p}}\right].}
\tag{30}
$$

Every depth remains in this convergent sum. For fixed $p$, its tail after $j=J$ is bounded by a constant depending on $p$ times $(1+\sqrt J)e^{-c_2\sqrt{J\log p}}$. Each individual translation difference converges in $L^2$ as $T\to\infty$, so dominated convergence of the operator series proves that $[J_1,L_p]a_T$ has an $L^2$ limit. This is a statement about the commutator on the actual source, even if the complete source has unbounded $L^2$ energy.

Combining (30) with the exact seed term gives

$$
\boxed{\sup_{T\ge\log2}\|[S,L_{P,+}]a_T\|_2
\le C\left[1+\sum_{p\le P}\left\{
\frac1p+\sum_{j\ge2}e^{-c_2\sqrt{j\log p}}
\right\}\right].}
\tag{31}
$$

For every finite $P$, the commutator has an $L^2$ limit as $T\to\infty$. An integral estimate for the depth sum, followed by a split of the primes at $\sqrt P$, also gives constants $C,c_3>0$ such that the right side of (31) is at most

$$
C\left[1+\frac{P}{\log(2P)}
e^{-c_3\sqrt{\log(2P)}}\right].
\tag{32}
$$

The constants in (31)--(32) are independent of both cutoffs. No uniform bound as $P\to\infty$ is asserted. The estimate does not turn the actual source into a global $H^{1/2}$ function: its jump at $x=1$ already prevents that. It uses a gain for large additive increments and retains the order-$h$ small-increment jump energy.

## Why small displacement is not an operator-norm argument

Although $\sigma(v)-v\to0$, $J_1-I$ need not be small on arbitrary functions supported at large $v$. In additive coordinates choose a slowly cut-off wave $e^{i\pi x}$ supported well inside $[e^R,2e^R]$. Unit translation reverses its phase; only short endpoint pieces are lost. Its normalized difference under $\mathsf T_1-I$ tends to two as $R\to\infty$. The corresponding logarithmic history lies in an interval of fixed length $\log2$ at large age and has increasingly high frequency. Estimates (18)--(25) explicitly pay for variation instead of making a small-displacement norm assertion.

The bounds above neither extend a collective spectral gap to the exponentially larger actual readout band nor control the signed harmonic $W$ readout. They give a compatible actual-source commutator and a finite initial-boundary limit. The full prime-power jumps and upper cutoff remain available for a subsequent estimate.

## Attribution and relation to existing constructions

The affine relation is classical. Joachim Cuntz, [C*-algebras associated with the ax+b-semigroup over N](https://arxiv.org/pdf/math/0611541), section 2, printed pages 2--3, gives the counting isometries and the relation $s_nv^k=v^{nk}s_n$. The Jacobian-weighted representation (1)--(4) is the corresponding direct calculation for the actual logarithmic Hilbert space; it is not a new ax+b algebra.

The exact successor normalization is from [An age-resolved lift of the actual prime-error history](age-resolved-prime-history-lift.md). The signed full-power kernel (8) follows by adding the complete geometric series (6) and its adjoint in (7). The existing [Actual successor jumps and a finite-frequency critical readout](actual-successor-frequency-cutoff.md) retains the logarithmic derivative atoms and their readout tail; here the additive-coordinate variation in (22)--(23) has a different commutator consumer. The repository's [Divisor transport of the successor and its signed overlap](divisor-successor-overlap.md) concerns a different divisor-conjugated finite matrix and is not reinterpreted as (7).

For (28), a precise primary input is Tim Trudgian, [Updating the error term in the prime number theorem](https://arxiv.org/pdf/1401.2689), Theorem 1, printed page 3. It bounds $|\psi(x)-x|/x$ by a constant times $(\log x)^{1/4}e^{-\sqrt{\log x/6.455}}$. After reducing the exponential constant this gives (28), with the initial compact interval absorbed in $C_0$.

The actual seed completion (15)--(17), the bounded-variation mechanism (20)--(26), and the strengthened actual-source modulus and commutator limits (27)--(32) are written deductions from the stated inputs. No RH hypothesis or Lean claim is made.
