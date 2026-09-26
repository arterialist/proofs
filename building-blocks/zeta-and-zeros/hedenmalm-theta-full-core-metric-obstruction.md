# A full-core metric obstruction for the theta spectral pencil

**Status.** This is an unconditional obstruction to one operator realization of
[Hedenmalm's theta spectral pencil](https://arxiv.org/abs/2606.17494), not a
zero-free theorem and not progress toward proving RH. It concerns a closed,
positive form whose domain has all compact smooth functions as a form core.
It does not address the paper's proposed form on the finite span of
zero-eigenfunctions.

Write $x=\log t$, $D=-i\partial_x$, and
\[
 K(x)=\Theta_{00}(i e^{2x}),\qquad
 \phi(x)=-\log K(x),\qquad A=D-i\phi'(x).
\]
Here $K$ is the positive, even, rapidly decaying theta kernel in
Hedenmalm's equations (1.2.3) and (2.2.1). In particular $AK=0$, and
\[
 \widehat K(\xi)=\int_{\mathbb R}K(x)e^{i\xi x}\,dx=\Xi(\xi).
 \tag{1}
\]
The function in (1) is entire and not identically zero, so its real zeros
have measure zero.

**Theorem.** Let $q$ be a densely defined, closed, nonnegative Hermitian
form on $L^2(\mathbb R,dx)$. Suppose $C_c^\infty(\mathbb R)$ lies in its
domain and is a form core, $K$ lies in its domain with $q(K,K)=0$, and
\[
 q(Du,v)=q(u,Dv)
 \qquad(u,v\in C_c^\infty(\mathbb R)).
 \tag{2}
\]
Then $q$ is the zero form. Consequently no nonzero closed positive
pullback $q(u,v)=\langle Au,Av\rangle_2$ can satisfy (2) on this full
core while including $K$ in its domain, with the pullback formula valid
there: $q(K,K)=\|AK\|_2^2=0$.

*Proof.* We take forms to be linear in the first argument. For a fixed
compact interval $I$, the form seminorm is continuous
on the Fréchet space of smooth functions supported in $I$. Indeed, the
closed form has an associated positive square root $S^{1/2}$, and the map
$u\mapsto S^{1/2}u$ from that Fréchet space to $L^2$ has a closed graph;
the closed-graph theorem applies. Thus for compact smooth $u,v$, the map
\[
 a\longmapsto q(U_a u,U_a v),\qquad U_a=e^{-iaD},
\]
is differentiable, locally in the form norm. Its derivative is
$-i q(DU_a u,U_a v)+i q(U_a u,DU_a v)=0$ by (2). Hence translations
preserve $q$ on $C_c^\infty$, and the form-core assumption extends this
invariance to the whole form domain.

The nullspace $N=\{u\in\operatorname{dom}q:q(u,u)=0\}$ is closed in ordinary
$L^2$: an $L^2$-Cauchy sequence in $N$ is also Cauchy in the form norm, and
closedness of $q$ gives its limit in $N$. Translation invariance and
$q(K,K)=0$ put every translate $U_aK$ in $N$. Their linear span is
dense in $L^2$. Indeed, if $h$ is orthogonal to every translate, the
Fourier transform of their correlation gives
$\widehat h(\xi)\overline{\widehat K(\xi)}=0$ almost everywhere;
(1) therefore forces $h=0$. So $N=L^2$, proving $q=0$. ∎

The theorem excludes the full-core route even for a nonlocal positive
metric. It does not exclude a form whose domain omits the theta null mode,
whose compact smooth functions are not a form core, which is indefinite or
nonclosed, or which is defined only on Hedenmalm's finite
zero-eigenfunction span. Any such restricted construction still needs an
independent argument that controls the actual off-line zeta zeros.
