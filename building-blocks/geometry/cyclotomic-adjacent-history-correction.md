# A constructed Euclidean history reciprocity and its exact correction

Throughout, $\Phi_n$ denotes the $n$th cyclotomic polynomial, including $\Phi_1(z)=z-1$, and $F_N=\prod_{n=1}^N\Phi_n$. Its roots are simple. The weight $w_N(a/n)$ is half the sum of the two neighboring gaps of $a/n$ in the circular Farey set of order $N$; thus the weights sum to one. The clipped deficit is $[-\log|F_N'(e^{2\pi ia/n})|]_+$. These are the same actual histories used in the [weighted-orbit obstructions](cyclotomic-weighted-orbit-obstructions.md).


The proposed reciprocal transfer fails. The two adjacent parent phases do admit an exact joint history on a common cyclotomic field, but its correction factor need not have modulus one. The actual paired signed old response can be strictly positive. The construction, its correction, and a certified response test are given below without replacing one phase's history by another's.

## The reciprocal candidate at the actual adjacent phases

Fix coprime integers $q,r>1$, let $N=q+r$, and choose the unique integers

$$
1\le a<q,\qquad1\le c<r,\qquad ar-cq=1.
$$

Put $\alpha=\zeta_q^a$, $\beta=\zeta_r^c$. The fractions $c/r<a/q$ are adjacent at cutoff $N-1$; their mediant is born at $N$. They satisfy

$$
\frac aq-\frac cr=\frac1{qr},\qquad
\alpha^N=\zeta_q,\qquad \beta^N=\zeta_r^{-1}.
\tag{1}
$$

These opposite principal residues motivate testing a reciprocal transfer, but they do not identify the earlier histories.

For every $K\ge\max(q,r)$, retain the actual logs

$$
L_{q,K}(a)=\log|F_K'(\alpha)|,
\qquad L_{r,K}(c)=\log|F_K'(\beta)|,
\quad F_K=\prod_{j\le K}\Phi_j.
$$

The full scalar/unit decomposition is

$$
F_K'(\alpha)=q\operatorname{lcm}(1,\ldots,\lfloor K/q\rfloor)U_{q,K}(\alpha),
$$

and similarly at $\beta$. Since $q,r>1$ are coprime, neither divides $N=q+r$. Thus neither scalar jumps from $N-1$ to $N$.

The concrete candidate was therefore

$$
\left|
\frac{U_{q,N}(\alpha)}{U_{q,N-1}(\alpha)}
\frac{U_{r,N}(\beta)}{U_{r,N-1}(\beta)}
\right|=1,
\tag{C}
$$

or equivalently $v_q+v_r=0$, where $v_q=\log|\Phi_N(\alpha)|$, $v_r=\log|\Phi_N(\beta)|$. This was a candidate conservation of the two log increments, not a consequence of a Galois norm identity. Even if it held, clipping at two different actual starting logs would need a separate argument.

## Proved joint history and the algebraic correction

Let $\omega=\zeta_{qr}$. Both phases are represented exactly by

$$
\alpha=\omega^{ar},\qquad\beta=\omega^{cq},\qquad ar-cq=1.
$$

This common field contains both histories but does not make the roots interchangeable: their orders differ. Write $M(t)=\sum_{j\le t}\mu(j)$, and define

$$
B_q(d)=\begin{cases}d,&q\mid d,\\\alpha^d-1,&q\nmid d,\end{cases}
\qquad
B_r(d)=\begin{cases}d,&r\mid d,\\\beta^d-1,&r\nmid d.\end{cases}
$$

The exact complex full-history identity is

$$
\boxed{
\alpha\beta F_K'(\alpha)F_K'(\beta)
=\prod_{d\le K}\bigl(B_q(d)B_r(d)\bigr)^{M(\lfloor K/d\rfloor)}.
}\tag{2}
$$

To prove it, apply the finite Möbius product $F_K(z)=\prod_{d\le K}(z^d-1)^{M(\lfloor K/d\rfloor)}$ separately at each simple root. On the radial path $z=t\alpha$, every vanishing factor has leading term $d(t-1)$, and the net vanishing exponent is one. Dividing by $t-1$ leaves $\alpha F_K'(\alpha)$. This proves (2), including the phase and every derivative scalar. The two coefficient arrays have the same cutoff $K$, while their regularized factors remain distinct.

Subtracting histories at $K=N$ and $K=N-1$ localizes the Mertens difference exactly to divisors of $N$:

$$
M(\lfloor N/d\rfloor)-M(\lfloor(N-1)/d\rfloor)
=\mathbf1_{d\mid N}\mu(N/d).
$$

None of these divisors is divisible by $q$ or $r$. Consequently the exact correction to (C) is

$$
\boxed{
C_N=\Phi_N(\alpha)\Phi_N(\beta)
=\prod_{d\mid N}
\bigl[(1-\alpha^d)(1-\beta^d)\bigr]^{\mu(N/d)}.
}\tag{3}
$$

Every factor in (3) is nonzero. In common-cover coordinates, its individual numerator factor is

$$
1-\omega^{ard}-\omega^{cqd}+\omega^{(ar+cq)d}.
\tag{4}
$$

Equivalently, put $\eta=\exp(\pi i(a/q+c/r))$. Then (4) equals

$$
1-2\eta^d\cos(\pi d/(qr))+\eta^{2d}.
$$

This is the algebraic correction arising from the actual adjacent phases. Opposite residues in (1) do not turn its two chord factors into mutual inverses. In logarithms the proved transfer law is

$$
L_{q,N}+L_{r,N}-L_{q,N-1}-L_{r,N-1}
=\log|C_N|.
\tag{5}
$$

The missing assertion in candidate (C) was precisely $|C_N|=1$.

## Exact small history with nontrivial unit variation

Take $(q,r,N,a,c)=(5,3,8,2,1)$. The full derivative remainders are

$$
\begin{array}{c|cc}
&K=7&K=8\\\hline
\Phi_5&-5z^3&-5(z^2+z^3)\\
\Phi_3&-6(z+1)&-6z.
\end{array}
\tag{6}
$$

They are obtained by differentiating the complete integer prefixes, and are independently reproduced by (2). At $\alpha=\zeta_5^2$, the magnitudes are $5$ and $5/\gamma$, where $\gamma=(1+\sqrt5)/2$. At $\beta=\zeta_3$, both magnitudes are six. The scalars are respectively five and six at both cutoffs. Thus

$$
v_q=-\log\gamma,\qquad v_r=0,
\qquad |C_8|=\gamma^{-1}\ne1.
$$

The complex correction on $\omega=\zeta_{15}$, with $\alpha=\omega^6$, $\beta=\omega^5$, is exactly

$$
C_8=1+\omega^5-\omega^4.
\tag{7}
$$

The actual weights are

$$
\begin{array}{c|cc}
&K=7&K=8\\\hline
2/5&1/21&3/112\\
1/3&2/35&5/112.
\end{array}
$$

All four full derivative magnitudes exceed one, so all four deficits vanish. This is an exact failure of reciprocal unit transfer, but its actual paired signed old response is zero. It does not by itself establish a sign failure after clipping.

## Exact paired response with weights and clipping

Set $f(t)=[-t]_+$, $D_v(t)=f(t+v)-f(t)$,

$$
x=L_{q,N-1}(a),\quad y=L_{r,N-1}(c),\quad
v=v_q,\quad \varepsilon=\log|C_N|.
$$

The actual signed old response of these two endpoints is

$$
P_N=w_N(a/q)D_v(x)+w_N(c/r)D_{-v+\varepsilon}(y).
$$

Its exact decomposition is

$$
\boxed{
P_N=
\underbrace{w_N(a/q)D_v(x)+w_N(c/r)D_{-v}(y)}_{\text{candidate reciprocal response}}
+w_N(c/r)D_{\varepsilon}(y-v).
}\tag{8}
$$

Thus even a hypothetical zero correction would leave different starting logs, thresholds, and weights. The actual correction passes through the second root's actual clipped history, rather than contributing its unweighted log directly.

The weights in (8) are the complete new-cutoff weights, including each endpoint's other neighbor. Their changes are exactly

$$
w_{N-1}(a/q)-w_N(a/q)=\frac1{2Nr},\qquad
w_{N-1}(c/r)-w_N(c/r)=\frac1{2Nq}.
\tag{9}
$$

No weight-loss or birth term is added to $P_N$; those are distinct terms in the global interpolation identity. The present pair consists of these two physical phases. In fixtures with both conductors greater than two, adding the conjugate pair doubles the response.

## Cutoff 33 with the actual adjacent phases

For $q=19,r=14$, the adjacent phases are $a=15,c=11$, since $15\cdot14-11\cdot19=1$. Rational interval evaluation with all Mertens coefficients and derivative scalars gives

$$
\begin{array}{c|cc}
&K=32&K=33\\\hline
L_{19,K}(15)&(4.449483511,4.449483512)&(2.423518415,2.423518416)\\
L_{14,K}(11)&(4.289205411,4.289205412)&(2.522617594,2.522617595).
\end{array}
$$

Their weights change as

$$
15/19:\quad1/336\longrightarrow1/528,
\qquad
11/14:\quad3/874\longrightarrow2/759.
$$

Both increments are strictly negative; their sum lies in $(-3.792552915,-3.792552911)$. Thus the correction in (3) is substantial, but both deficits remain zero and $P_{33}=0$.

A separately checked phase at this cutoff is $8/19$, whose log crosses from $(0.549622459,0.549622460)$ to $(-0.211423700,-0.211423699)$. It is not the phase selected by the pair $19+14$. Its actual neighbors at cutoff 32 have denominators 31 and 26, and its weight stays $3/1612$ at cutoff 33. Replacing $15/19$'s history by this negative phase would invalidate the proposed test. The checker retains both and verifies their distinct weights and signs.

## A certified strictly positive paired old response

A direct signed test is supplied by

$$
N=199,\qquad q=187,\quad r=12,\quad a=78,\quad c=5,
\quad78\cdot12-5\cdot187=1.
$$

The [exact history checker](../../certificates/cyclotomic_adjacent_history.py) uses the full Mertens history with rational sine and logarithm bounds, obtaining

$$
\begin{array}{c|cc}
&K=198&K=199\\\hline
L_{187,K}(78)&(-1.217394639,-1.217394638)&(-5.269526256,-5.269526255)\\
L_{12,K}(5)&(8.071165259,8.071165260)&(6.754207362,6.754207363).
\end{array}
$$

Since 199 is prime, (1) gives the exact increments

$$
v_q=\log\frac{\sin(\pi/187)}{\sin(78\pi/187)}<0,
\qquad
v_r=\log\frac{\sin(\pi/12)}{\sin(5\pi/12)}
=\log(2-\sqrt3)<0.
$$

Both full scalar increments are zero. The first root stays below the clipping threshold, while the second stays above it. The actual weights are

$$
78/187:\quad1/4200\longrightarrow1/34825,
\qquad
5/12:\quad16/36839\longrightarrow33/78406.
$$

Therefore the paired signed old response is exactly

$$
\boxed{
P_{199}=\frac1{34825}
\log\frac{\sin(78\pi/187)}{\sin(\pi/187)}>0.
}\tag{10}
$$

This refutes a universal nonpositive response at the actual adjacent parents, without any phase substitution or omitted scalar. It reuses one fixed certified history, rather than searching neighboring parameters.

There is an exact reason this prime example points in the same direction at both endpoints. If $N=p^k$, every affected parent of order $n>1$ has $(n,N)=1$ and a selected phase with $\alpha^N=\zeta_n^{\pm1}$. Hence

$$
|\Phi_{p^k}(\alpha)|
=\frac{|1-\zeta_n^{\pm1}|}{|1-\alpha^{p^{k-1}}|}\le1,
$$

because the numerator is a smallest nonzero chord among the primitive $n$-th roots. Thus both affected nonzero parent phases have nonpositive log increments, and their deficits cannot decrease. Equality occurs precisely when $p\equiv\pm1\pmod n$. The cyclic parent of order one is the exception to the log-increment statement: $\Phi_{p^k}(1)=p$, while its actual deficit remains zero. This is prime-power forcing of the selected phases, not reciprocal cancellation of their histories.

## What has been constructed and what remains missing

Equations (2)–(5) are proved finite identities for the actual two histories. Candidate (C) is false, with the exact correction (3), and an additional claim that its paired old response is always nonpositive is false by (10). The correction in (8) also shows why unclipped log identities alone cannot transfer clipped occupation between the roots.

No uniform estimate has been established for the signed sum of these corrections together with their actual clipped baselines and time-dependent weights. Longer-time or additional-phase cancellation remains a separate question. No cumulative cancellation estimate or RH inference is drawn here. The construction is restricted to $g=1$; extending it to $g>1$ requires compatible primitive base phases and their common-cover orbit, and is outside this coprime construction.

The reproducible checker is [exact history checker](../../certificates/cyclotomic_adjacent_history.py). It verifies the full complex Mertens histories against differentiated prefixes at the small and cutoff-33 fixtures, the joint-cover correction at cutoff 8, exact sorted-Farey weights, and the fixed rational sign certificates at cutoffs 33 and 199. All checks pass. The checker uses SymPy for the finite exact polynomial identities and rational arithmetic for the logarithm enclosures. A Python environment with SymPy is required; the selected-recovery checker uses only the standard library.
