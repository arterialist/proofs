# Infinite translated tails and the actual optimizer span

This note tests an explicitly summable infinite translated/reflected map. Such a map can see arbitrarily remote theta tails, so the finite-visibility obstruction no longer applies. A different obstruction remains: every bounded map into a fixed Suzuki interval has bounded paid quadratic form, while the actual theta conditional form is unbounded on L²-normalized common-score tests.

On the actual comparison optimizer span, which is finite-dimensional after the exact score cancellation, that obstruction disappears. The needed statement reduces to an explicit two-by-two Gram inequality. The entries retain every theta prime power, both crossing variances, the common score subtraction, and every Suzuki Euler coefficient. No numerical bound for those entries is presently proved.

## A named infinite-tail class

Let H_θ be the actual theta ground Hilbert space and I=[-L,L]. For fixed shifts τ_j, orientations ε_j∈{+1,-1}, and bounded interval multipliers a_j, define

\[
(U_\infty v)(t)=\sum_{j=1}^\infty
b_j a_j(t)v(\epsilon_jt+\tau_j),
\qquad t\in I.
\tag{1}
\]

Write R_j for the translated/reflected restriction in (1). Assume the explicit summability condition

\[
\sum_{j=1}^\infty |b_j|\|a_jR_j\|_{H_\theta\to L^2(I)}=B<\infty.
\tag{2}
\]

Then (1) converges in operator norm and

\[
\|U_\infty\|\le B.
\tag{3}
\]

This class allows infinitely many ports and an unbounded visibility set. It also permits finite-rank source and endpoint rows, provided their operator norms are included in B. If physical theta translations are used, every quotient and endpoint port must first be proved bounded; condition (2) does not declare them bounded by notation.

For the fixed-cutoff Suzuki form

\[
q_\sigma[x]=\|x\|_2^2+\sigma\langle H_\omega x,x\rangle,
\]

boundedness gives

\[
|q_\sigma[U_\infty v]|
\le(1+\|H_\omega\|)B^2\|v\|_{H_\theta}^2.
\tag{4}
\]

Every Euler coefficient and compression endpoint remains inside H_ω. Estimate (4) uses only its fixed-cutoff operator norm.

## Full-domain obstruction for every summable synthesis

Use the exact common-score tests v_ξ from the finite-visibility note. They satisfy both pole constraints, have theta Hilbert norms tending to a finite positive value, and obey

\[
n_T[v_\xi]
=\tfrac12\|\Phi\psi_T\chi\|_2^2\log|\xi|
+o(\log|\xi|)\to\infty.
\tag{5}
\]

Combining (4) and (5) proves that no map satisfying (2) can obey, on the full common-score domain,

\[
n_T[v]\le Cq_\sigma[U_\infty v]
\tag{6}
\]

for a fixed positive C when the target form is nonnegative, nor can it satisfy an exact form identity. If q_σ is not known nonnegative, replace its right side by its absolute value; (4) still contradicts domination of (5).

This is a boundedness obstruction, not a support obstruction. Infinite visibility does not help unless the map is unbounded in the theta Hilbert norm or the target includes an additional unbounded frequency coordinate. Such a map would need a graph domain and a source-specific bound before it could consume the actual optimizer.

The obstruction retains all actual theta terms. The growth in (5) occurs in n_T=K_T-M_T after the common score and both crossing means have already been removed. The full normalized prime part and matched profiles are bounded and do not cancel the logarithmic archimedean growth.

## Why literal full prime coefficients do not solve boundedness

A formal choice of b_j using every prime-power coefficient is not yet a map. To invoke (1), one must prove (2) with the actual translated restriction norms. The theta tail quotient reaches its L² boundary already at the first Suzuki half-shift log2/2. Therefore the literal physical half-history shifts do not even supply finite operator norms for (2).

Damping the coefficients until (2) holds defines a legitimate infinite-tail observation, but it changes the actual prime form unless a separate reconstruction identity restores the missing weights and endpoints. Coefficientwise inclusion and form intertwining are different claims.

## Reduction of the actual optimizer to two source directions

The actual comparison optimizer satisfies the exact score relation

\[
v_U=\varphi-M^{-1}(\delta S_y-t_{\rm score}S_q),
\]

and the conditional residual annihilates φ. Put

\[
g_y=M^{-1}S_y,\qquad g_q=M^{-1}S_q,
\qquad c=\binom{\delta}{-t_{\rm score}}.
\tag{7}
\]

Then

\[
n[v_U]=n[c_1g_y+c_2g_q].
\tag{8}
\]

Define the exact theta residual Gram matrix

\[
N_{ij}=n[g_j,g_i],
\qquad (g_1,g_2)=(g_y,g_q).
\tag{9}
\]

Every entry in N uses the common projection P and has the complete edge expression

\[
N_{ij}=R_c(Pg_j,Pg_i)+R_p(Pg_j,Pg_i).
\tag{10}
\]

Thus it includes the continuous same-half energy, all prime-power same-half shifts, and both separately centered crossing covariances. No component is optimized with a separate score coefficient.

For a proposed U_∞ satisfying (2), define the paid Suzuki Gram matrix

\[
Q^{(\sigma)}_{ij}
=\langle U_\infty g_j,U_\infty g_i\rangle
+\sigma\langle H_\omega U_\infty g_j,U_\infty g_i\rangle.
\tag{11}
\]

The arrival defect is already canceled by the arithmetic identity channel. Hence (11) is in the original interval metric and retains all Euler coefficients.

## Exact optimizer-specific certificates

To pay only the actual affine deficit, the necessary and sufficient scalar condition is

\[
\boxed{\quad
c^TQ^{(\sigma)}c\ge c^TNc=n[v_U].
\quad}
\tag{12}
\]

This keeps the actual coefficient t_{\rm score}. Replacing it by the minimizer of either matrix changes the optimizer.

To pay every source in the two-dimensional affine source span, the exact condition is

\[
\boxed{\quad Q^{(\sigma)}-N\succeq0.\quad}
\tag{13}
\]

For real symmetric two-by-two matrices, (13) is the finite list

\[
D_{11}\ge0,qquad D_{22}\ge0,qquad
D_{11}D_{22}-D_{12}^2\ge0,
\quad D=Q^{(\sigma)}-N.
\tag{14}
\]

Equations (9)-(14) are a concrete quantitative certificate. They require four theta edge evaluations and three interval kernel evaluations after symmetry. A finite interval trial-plus-tail bound may certify the Q entries, but the N entries still require the actual complete conditional edge calculation.

## Source normalization on the optimizer span

Let s be the interval constraint row. Exact source normalization on this span requires only

\[
\langle U_\infty g_y,s\rangle
=\langle g_y,S_q\rangle_\gamma,
\qquad
\langle U_\infty g_q,s\rangle
=\langle g_q,S_q\rangle_\gamma.
\tag{15}
\]

These are two scalar equations. Unlike full-domain normalization, they do not force U_∞*s=S_q globally. A rank-two correction can enforce (15) if its two-by-two observation matrix is invertible. The norm of that correction must then be added to B, and its contribution must remain in Q. Source matching by itself gives no inequality in (12).

Endpoint normalization is similar. A finite number of interval boundary equations can be imposed on the two images, but their correction costs enter the same Gram matrix. They cannot be declared zero after the map has been normalized.

## A precise remaining obstruction quantity

For the named class (1)-(2), define

\[
\Delta_{\rm opt}(U_\infty,\sigma)
=c^T(N-Q^{(\sigma)})c.
\tag{16}
\]

A nonpositive value certifies payment of the actual affine deficit. A positive value is the exact optimizer-specific shortfall of that map. The available theory proves that N is finite and that Q is finite under (2), but supplies no sign or evaluated upper bound for (16).

The generic norm estimate only gives

\[
|c^TQ^{(\sigma)}c|
\le(1+\|H_\omega\|)B^2
\|c_1g_y+c_2g_q\|_{H_\theta}^2.
\tag{17}
\]

It cannot upper-bound N by the right side because n is unbounded relative to the theta Hilbert norm on the full domain. On this fixed two-dimensional span such a bound exists abstractly, but its constant is exactly the largest generalized eigenvalue of (N,G), where G is the Hilbert Gram of g_y,g_q. Evaluating that eigenvalue is the remaining actual arithmetic task, not a consequence of summability.

## Scope

The full common-score form cannot be intertwined by any bounded explicitly summable translated synthesis into a fixed Suzuki interval. The optimizer-specific question is not ruled out. It is reduced to the scalar certificate (12), or the stronger two-by-two certificate (13), with source normalization (15).

No current estimate evaluates those matrices with sufficient sign. This note therefore identifies the exact optimizer-span obstruction rather than claiming failure of every infinite-tail construction. An unbounded frequency-sensitive map also remains outside the named class and would require a proved graph-domain action on g_y and g_q.


This is written analysis. Its domain statements and matrix reduction have not been formalized in Lean.
