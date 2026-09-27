# No bounded injective $L^2$ metric symmetrizes the theta pencil

**Status.** This is an unconditional obstruction to the standard Haar-space
pairing, the standard $H^s$ pairing for every fixed integer $s\ge0$,
and bounded positive-definite target metrics on each of these spaces in
[Hedenmalm's theta pencil](https://arxiv.org/html/2606.17494). It is not a
zero-free theorem or progress toward the Riemann hypothesis. Many more
singular target inner products remain open; the explicit \(K^{-2}\) target
is excluded in the
[inverse-theta metric note](hedenmalm-theta-singular-weighted-metric-obstruction.md).

In the logarithmic coordinate $x=\log t$, write

\[
 K(x)=\Theta_{00}(i e^{2x}),\qquad
 p(x)=-(\log K(x))',\qquad
 D=-i\partial_x,\qquad A=D-ip.
\]

The actual Jacobi kernel $K$ is positive and even, and $AK=0$. With the
first-slot-linear $L^2(\mathbb R,dx)$ pairing, define on
$\operatorname{Dom}(A)$ the natural pullback in Hedenmalm's equation (4.2.1):

\[
 q_A(u,v)=\langle Au,Av\rangle_2.
\]

**Theorem.** Let $u_\alpha$ be the pencil eigenfunction corresponding to a
real zero $\Xi(\alpha)=0$. As $\alpha\to+\infty$ through real zeros,

\[
 \alpha^4\langle Au_\alpha,Au_{-\alpha}\rangle_2
   =\|p'K\|_2^2+O(\alpha^{-1}),
 \qquad \|p'K\|_2^2>0. \tag{1}
\]

Consequently, for every sufficiently large positive real zero $\alpha$,
the two actual zero eigenfunctions $u_\alpha,u_{-\alpha}$ violate the
pair-symmetry condition in Hedenmalm's Definition 4.2.1:

\[
 q_A(Du_\alpha,u_{-\alpha})
 -q_A(u_\alpha,Du_{-\alpha})
 =-2\alpha\langle Au_\alpha,Au_{-\alpha}\rangle_2\ne0. \tag{2}
\]

*Proof.* Hedenmalm's Mellin formula gives
$\Xi(\alpha)=\int_{\mathbb R}e^{i\alpha y}K(y)\,dy$. For a real zero, put

\[
 J_m(x;\alpha)=e^{-i\alpha x}
    \int_{-\infty}^{x}e^{i\alpha y}K^{(m)}(y)\,dy
 \qquad(m\ge0).
\]

Integration by parts on the full line gives
$\int e^{i\alpha y}K^{(m)}(y)dy=(-i\alpha)^m\Xi(\alpha)=0$.
Thus $J_m$ can also be written as minus the corresponding upper-tail
integral. In particular,

\[
 |J_m(x;\alpha)|\le
 M_m(x):=\min\!\left\{
 \int_{-\infty}^{x}|K^{(m)}(y)|dy,
 \int_x^\infty|K^{(m)}(y)|dy\right\}. \tag{3}
\]

The theta series and Jacobi inversion show that $K$ and every fixed
derivative have double-exponential tails at both ends. The same is true of
$M_m$. Moreover $p(x)=O(e^{2|x|})$, so $M_m,pM_m\in L^2$, uniformly
in the real zero $\alpha$. Since $J_m'=K^{(m)}-i\alpha J_m$,
these bounds put $J_m$ in the graph domain of $A$. They also justify all
integrations by parts below.

The eigenfunction is $u_\alpha=J_0(\cdot;\alpha)$. Both $u_\alpha$ and
$D u_\alpha$ belong to $\operatorname{Dom}(A)$ by (3) and $AK=0$. Direct
differentiation gives

\[
 (D+\alpha)u_\alpha=-iK,
 \qquad A D u_\alpha=-\alpha A u_\alpha. \tag{4}
\]

For $z=i\alpha$, one integration by parts gives
$J_m=K^{(m)}/z-J_{m+1}/z$. Iterating four times gives the exact identity

\[
 u_\alpha=\frac Kz-\frac{K'}{z^2}
             +\frac{K''}{z^3}-\frac{K'''}{z^4}
             +\frac{J_4}{z^4}. \tag{5}
\]

Since $AK=0$, differentiation gives $AK'=ip'K$. Also
$J_4'=K^{(4)}-i\alpha J_4$, and (3) implies
$\|AJ_4\|_2=O(1+|\alpha|)$. Applying $A$ to (5) therefore yields,
uniformly through real zeros of either sign,

\[
 \alpha^2 Au_\alpha=ip'K+O_{L^2}(|\alpha|^{-1}). \tag{6}
\]

The function $p'K$ is nonzero: otherwise $p$ would be constant, which
is incompatible with a positive even kernel decaying at both ends. Applying
(6) to $\alpha$ and $-\alpha$ proves (1). Hardy's theorem supplies
unbounded positive real zeros; the evenness of $K$ makes $-\alpha$ a zero
as well. Thus the leading term in (1) is nonzero for
such a pair. Finally, (4) and the first-slot-linear pairing give (2). ∎

In fact (6) shows that, for any two real zero parameters tending to infinity
in absolute value, their normalized pullback vectors
$\alpha^2Au_\alpha$ converge to the same nonzero vector $ip'K$.
Their Gram matrix is asymptotically rank one, whereas pair symmetry
would require vectors for distinct real zeros to be orthogonal.

**Corollary (bounded target obstruction).** Let $T$ be a bounded,
self-adjoint, nonnegative operator on $L^2(\mathbb R,dx)$, and replace
$q_A$ by $q_T(u,v)=\langle TAu,Av\rangle_2$. If Hedenmalm's pair
symmetry holds on the finite span of the actual real-zero eigenfunctions,
then $T(p'K)=0$. In particular, no bounded injective positive target
operator can supply that symmetry.

*Proof.* For distinct real zeros $\alpha,\beta$, equation (4) and pair
symmetry give $\langle TAu_\alpha,Au_\beta\rangle_2=0$. Choose distinct
positive real zeros $\alpha_n\to\infty$ and put
$w_n=\alpha_n^2Au_{\alpha_n}$. By (6), $w_n\to g=ip'K\ne0$ in $L^2$.
For fixed $n$, let $m\to\infty$ in
$\langle Tw_n,w_m\rangle_2=0$, and then let $n\to\infty$. Boundedness
gives $\langle Tg,g\rangle_2=0$. Since $T$ is nonnegative, $Tg=0$,
and hence $T(p'K)=0$. ∎

**Finite Sobolev orders.** The same obstruction holds if the target is
$H^s(\mathbb R)$ for any fixed integer $s\ge0$, or if its pairing is
induced by a bounded positive injective operator on $H^s$. Indeed, repeat
the integration by parts underlying (5) with $N\ge s+4$ terms. For the tail
$J_N$, repeated differentiation of its defining integral gives

\[
 J_N^{(k)}=(-i\alpha)^kJ_N+
 \sum_{j=0}^{k-1}(-i\alpha)^{k-1-j}K^{(N+j)}.
\]

The two-sided envelope (3), with the double-exponential theta tails,
then gives $\|AJ_N\|_{H^s}=O_s(|\alpha|^{s+1})$; derivatives of $p$
grow at most exponentially in $|x|$. The longer expansion therefore
upgrades (6) to
$\alpha^2Au_\alpha=ip'K+O_{H^s}(|\alpha|^{-1})$.
The orthogonality-limit proof of the corollary applies in $H^s$.

This result sharpens the [full-core obstruction](hedenmalm-theta-full-core-metric-obstruction.md)
in a different direction: bounded positive-definite target metrics fail
already on the finite real-zero span, without imposing symmetry on a
form core. Degenerate bounded forms, other unbounded or spatially weighted
metrics that are not continuous on any fixed $H^s$, and forms defined
only on the finite zero span are not excluded by this argument. Nothing
here locates zeta zeros.
