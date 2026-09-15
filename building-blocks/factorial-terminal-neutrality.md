# The actual factorial ground is asymptotically isometric on the evolved source

This note proves a quantitative constraint on the actual signed
prime-minus-density terminal correction. It retains the original physical
metric and the complete causal prime process. The factorial ground
transform preserves the terminal source energy up to a relative error
that tends to zero and an explicitly decaying absolute error. This does
not bound that energy or its time-ordered work budget.

Let
$$
g_N(x)=\frac{E(\min(x,N))}{x},\qquad E(x)=\psi(x)-x,
\qquad N\ge2,
$$
with all prime powers admitted at the right endpoint and the literal
constant cumulative tail after $N$. The origin state is
$g_1=-1/x$. In the unchanged space $L^2((1,\infty),dx)$, put
$$
Hf(x)=\frac1x\int_1^xf(y)\,dy,\qquad V=I-H,
\qquad R_F=V-b_FH,
$$
where $F$ is the full actual factorial potential and
$b_F=xF'/F$. The established domain theorem gives a bounded Hermitian
form
$$
Q(f,g)=\langle f,g\rangle-\langle R_Ff,R_Fg\rangle
=B_P(f,g)-B_C(f,g).
\tag{1}
$$
Its exact representation is
$$
Q(f,g)=\langle Vf,b_FHg\rangle
+\langle b_FHf,Vg\rangle-\langle b_FHf,b_FHg\rangle.
\tag{2}
$$
The prime observation in $B_P$ includes every observing prime power,
including those above the source cutoff.

Let $T_s$ be the complete causal contraction process, conjugated to the
physical space, and fix any $c>0$. Write
$$
f_N=T_{c\log N}g_N,\qquad M_N=\|f_N\|_2^2.
\tag{3}
$$
There exist constants $C,\eta,d>0$, depending on $c$ and the actual
process, such that for all sufficiently large integer $N$,
$$
\boxed{
|Q(f_N,f_N)|
\le C e^{-\eta\sqrt{\log N}}M_N+CN^{-d}.
}
\tag{4}
$$
In particular,
$$
\boxed{
\|R_Ff_N\|_2^2=M_N
+O_c(e^{-\eta\sqrt{\log N}}M_N+N^{-d}).
}
\tag{5}
$$

## 1. A causal lower-tail bound requires no positive age moment

Let $\eta_s$ be the complete process probability law on
$[0,\infty)$, with Laplace transform
$$
\int e^{-qv}\eta_s(dv)=e^{-s\Phi(q)},\qquad q>0.
\tag{6}
$$
The actual positive nonzero Lévy measure gives $\Phi(1)>0$.
For every $L\ge0$, Markov's inequality applied to $e^{-v}$ gives
$$
\eta_s([0,L])\le e^L e^{-s\Phi(1)}.
\tag{7}
$$
This includes the no-jump atom and all jump histories. It uses a negative
Laplace moment, not a positive exponential moment of the infinite-mean
age law.

Choose
$$
a=\min\{1/2,c\Phi(1)/3\},\qquad
d_0=c\Phi(1)-3a/2\ge c\Phi(1)/2>0,
\qquad X=N^a.
\tag{8}
$$
The established unitary map is $Ug(v)=e^{v/2}g(e^v)$. Causality means
that the output up to age $\log X$ sees only input up to that age and
process increments in $[0,\log X]$. Young's inequality therefore gives
$$
\|\mathbf1_{[1,X]}f_N\|_2
\le\eta_{c\log N}([0,\log X])
\|\mathbf1_{[1,X]}g_N\|_2.
\tag{9}
$$
Since $a\le1/2$, one has $X<N$, so the input in (9) is the actual
unfrozen source $E(x)/x$. Chebyshev's estimate $|E(x)|\le Cx$
gives $\|\mathbf1_{[1,X]}g_N\|_2\le C\sqrt X$.
Combining (7)--(9),
$$
\boxed{\|\mathbf1_{[1,X]}f_N\|_2\le CN^{-d_0}.}
\tag{10}
$$

## 2. The factorial correction is small on right-supported inputs

The unconditional PNT and the positive factorial lower bound give
$$
\beta_X:=\mathop{\rm ess\,sup}_{x\ge X}|b_F(x)|
\le C e^{-\nu\sqrt{\log X}},\qquad X\ge2,
\tag{11}
$$
for some $\nu>0$. This is the ordinary PNT envelope; no square-root
error estimate is used.

If $g$ is supported in $[X,\infty)$, then $Hg$ and $Vg$
have the same right support. In each term of (2), the late input or its
Hardy image forces the integrand into that region. The Hardy bound
$\|H\|\le2$ and the exact isometry $\|Vf\|=\|f\|$ give
$$
|Q(f,g)|\le4\beta_X(1+\beta_X)\|f\|_2\|g\|_2.
\tag{12}
$$
This remains valid for arbitrary $f$, even when $f$ reaches the
singular origin. The coefficient $b_F$ is only bounded on the forced
right-support region.

Split $f_N=l_N+r_N$, where
$l_N=\mathbf1_{[1,X]}f_N$ and
$r_N=\mathbf1_{(X,\infty)}f_N$. The global boundedness of $Q$
controls its low block; (12) controls the high block and both cross
orders. Hence
$$
|Q(f_N,f_N)|
\le C\|l_N\|_2^2+C\beta_X(1+\beta_X)
(\|r_N\|_2^2+2\|l_N\|_2\|r_N\|_2)
\le C\|l_N\|_2^2+C\beta_X(1+\beta_X)M_N.
\tag{13}
$$
For the last inequality, use
$2\|l_N\|\|r_N\|\le\|l_N\|^2+\|r_N\|^2=M_N$.
Substituting (10)--(11) and $\log X=a\log N$ proves (4), with
$d=2d_0$ and a smaller positive $\eta$ if necessary. Equation (1)
then proves (5).

## 3. Implication and scope

The actual signed terminal prime-minus-density observation is
asymptotically negligible relative to $1+M_N$. If $M_N\to\infty$
along a subsequence, the ratio $\|R_Ff_N\|^2/M_N$ tends to one there.
The original terminal energy and the factorial-ground terminal energy
therefore have the same nonnegative power-growth exponent.

This is an unconditional statement about the actual arithmetic source,
not an arbitrary coefficient counterexample. It shows that the positive
factorial ground and its terminal coercivity cannot by themselves lower
the unresolved source exponent. The full time-ordered signed work and
clock correction remain distinct quantities; (4) assigns them no sign
and does not bound their coherent constant-coefficient direction.

The source subpower estimate, equivalently RH by the established
original-source theorem, remains unproved. The domain, source, PNT tail,
and process ingredients are the written theorems in
[factorial original-domain theorem](factorial-ground-state-original-l2-domain.md),
[original-source criterion](actual-short-time-psi-correlation.md),
[factorial clock loading](factorial-source-clock-loading.md), and
[complete positive prime-history process](positive-successor-seed-jump-process.md) .
No Lean formalization of this terminal estimate is claimed.

## 4. The actual clock correction retains a signed transport drift

Write $\ell(dv)$ for the full finite Lévy measure, with total mass
$\lambda$, and let
$$
D_vf(x)=e^{-v/2}f(e^{-v}x)\mathbf1_{x\ge e^v}
$$
be the physical causal isometric dilation. Then
$\mathsf A=\lambda I-\int D_v\ell(dv)$. Its complete law retains
every prime interval and the no-jump component.

For $f=T_sg_{n-1}$, put $h=Hf$, $q=h/F$,
$k=H\mathsf Af=\mathsf Ah$, and $q_A=k/F$. Hardy commutation
with the actual process gives
$$
\boxed{
\Gamma_Q(f):=2\Re Q(f,\mathsf Af)
=2\Re\left[
\sum_{m\ge2}\Lambda(m)F(m)\overline{q(m)}q_A(m)
-\int_1^\infty F(x)\overline{q(x)}q_A(x)\,dx
\right].
}
\tag{20}
$$
The full original-domain observation bounds justify every term. The
observing sum still runs beyond the source cutoff.

Square expansion in the bounded Hermitian form $Q$ also gives the
exact paired-history identity
$$
\boxed{
\Gamma_Q(f)=\int
\left[Q(f-D_vf,f-D_vf)+Q(f,f)-Q(D_vf,D_vf)\right]\ell(dv).
}
\tag{21}
$$
Unlike the original norm, $Q$ has no positivity. The second term is
the actual factorial transport drift. Its precise commutator is
$$
\boxed{
R_FD_vf-D_vR_Ff
=[b_F(e^{-v}x)-b_F(x)]D_vHf.
}
\tag{22}
$$
This equality is an original-$L^2$ identity; the singular origin is
handled by the bounded product $b_FH$, not by assigning a value to
$b_F(1)$. The coefficient in (22) is used only on $x>e^v$ and
set to zero on $x<e^v$, where $D_vHf$ vanishes. With this
convention, let $\chi_v(x)=b_F(e^{-v}x)-b_F(x)$ on $x>e^v$.
The drift is
$$
Q(f,f)-Q(D_vf,D_vf)
=2\Re\langle D_vR_Ff,\chi_vD_vHf\rangle
+\|\chi_vD_vHf\|^2.
\tag{23}
$$
The square has a sign; the cross pairing does not. Positivity of the
history law and the PNT envelope do not sign $\chi_v$ or the pairing.

There is an unconditional quantitative extension of terminal neutrality
to each actual short clock interval. Causality of the generator gives
$$
\|\mathbf1_{[1,X]}\mathsf Af\|_2
\le2\lambda\|\mathbf1_{[1,X]}f\|_2.
$$
The same support split used in (13), with the negative-Laplace estimate
uniform for $s\in[c\log(n-1),c\log n]$, yields
$$
\boxed{
|\Gamma_Q(T_sg_{n-1})|
\le Ce^{-\eta\sqrt{\log n}}\|T_sg_{n-1}\|_2^2+Cn^{-d}.
}
\tag{24}
$$
Consequently the complete accumulated signed correction satisfies
$$
|D_N^Q|\le C+C\sum_{n\le N}
\frac{e^{-\eta\sqrt{\log n}}}{n}
\sup_{s\in[c\log(n-1),c\log n]}\|T_sg_{n-1}\|_2^2.
\tag{25}
$$
Chebyshev and contraction give
$|D_N^Q|\le C+CN e^{-\eta\sqrt{\log N}}$, after decreasing
$\eta>0$. Existing PNT input improves the envelope but not this
fixed power scale.

The full actual cocycle remains
$$
D_N^Q=Q(g_1,g_1)+2W_N^Q+L_N^Q-Q(T_{c\log N}g_N,T_{c\log N}g_N).
\tag{26}
$$
The signed diagonal $L_N^Q$ converges. The terminal term is relatively
negligible by (4). The mixed work, equivalently the coherent transport
drift in (21)--(23), is still uncontrolled. Thus terminal neutrality does
not extend to an absolute subpower bound for the entire time-ordered
correction without a new actual arithmetic cancellation estimate.


## Attribution and formal scope

The factorial Picone and domain identities are established in the linked predecessors. The negative-Laplace bound is Markov’s inequality applied to the classical compound-Poisson transform; the support split uses Hardy’s inequality and the exact Hardy isometry. The tail estimate (11) uses the classical effective PNT envelope, as recorded in [Johnston–Yang](https://arxiv.org/abs/2204.01980). These inputs yield the actual terminal comparison and clock-correction bounds above. The written proof and process-clock extension have passed independent review. They are not Lean-formalized, and neither their terminal estimate nor their cocycle signs or bounds the unresolved coherent arithmetic work.
