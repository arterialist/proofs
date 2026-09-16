# Odd graph-null modes before the fifth integer enters

The [fixed-window graph uncertainty theorem](odd-prime-graph-logarithmic-uncertainty.md) proves that the actual odd prime graph has no nonzero null vector once $a\ge\tfrac12\log6$. Below that radius, $\log3$ acts only on part of a $\log2$-periodic cell. This note constructs graph-null modes at every radius after the first prime edge enters and before $n=5$ enters, extending the linked theorem's one explicit first-prime example. It retains the admitted prime power $n=4$, the odd constraint, the pole moment and the logarithmic form domain. It does not determine the sign of the full Weil form.

Let $I_a=(-a,a)$, $\phi(x)=\cosh(x/2)$, and let $D_a[F]\ge0$ and $S_a[F]$ be the full prime graph and weighted row forms in equations (1)--(2) of the linked theorem. Let $H_a$ denote its positive logarithmic odd archimedean form. Put
$$
 L=\log2,\qquad M=\log3,\qquad T=2a,\qquad
 \alpha=M-L.
$$

**Theorem.** For every
$$
 \frac12\log2<a<\frac12\log5,
\tag{1}
$$
there is an infinite-dimensional space of odd, bounded-variation functions $F\in L^2(I_a)$ with finite $H_a[\sqrt2F|_{(0,a)}]$, $D_a[F]=0$, and $S_a[F]>0$ for every nonzero member of a specified subspace. In particular, one such nonzero $F$ can be chosen with exact pole moment $\langle\sqrt2\sinh(\cdot/2),\sqrt2F|_{(0,a)}\rangle=0$. There are odd compactly supported smooth tests with exact pole moment zero, bounded normalized logarithmic energy and $D_a[F]/S_a[F]\to0$ at each fixed radius in (1).

For $L<T\le M$, only $n=2$ enters. The $n=2$ graph equation identifies $g=F/\phi$ with a function on the circle $\mathbb R/L\mathbb Z$ in the coordinate $\theta=x+a\pmod L$. Oddness is the reflection $Q\theta=T-\theta\pmod L$. This reflection has at most two fixed points, while the active $n=2$ edge has positive-length coordinate arc $(0,T-L)$ and is preserved by $Q$. Choose disjoint small intervals $J_j$ inside that arc, away from the fixed points, such that all $J_j,Q(J_j)$ are disjoint. The step functions $h_j=\mathbf1_{J_j}-\mathbf1_{Q(J_j)}$ are odd under $Q$ and $L$-periodic. Their physical functions $F_j(x)=\phi(x)h_j(x+a\pmod L)$ are linearly independent odd graph-null modes with $S_a[F_j]>0$. The regularity, pole-null combination and smooth approximation below apply to these modes too.

Now assume $M<T<\log5$ and put $d=T-M\in(0,\log(5/3))$. Only $n=2,3,4$ enter the complete prime sum. Since $d<L$, the $n=2$ graph equation again identifies $g$ with a function on the circle. The $n=4$ equation follows automatically from $L$-periodicity. The $n=3$ equation is precisely
$$
 g(\theta)=g(\theta+\alpha)
 \quad\text{for almost every }\theta\in A:=(0,d).
\tag{2}
$$
Oddness is the reflection law $g(Q\theta)=-g(\theta)$, where
$$
 Q\theta=T-\theta\pmod L.
\tag{3}
$$
The map $Q$ reverses the partial graph edges in (2): if $\theta\in A$, then $Q(\theta+\alpha)=d-\theta\pmod L\in A$.

Let $R\theta=\theta+\alpha\pmod L$, and set $B=(d,L)$ on the circle. The ratio $\alpha/L$ is irrational: a rational ratio would give $3^q=2^p$ for positive integers. Every forward $R$-orbit hits the open arc $B$. Compactness and minimality of irrational rotation give an integer $N=N(a)$ such that every point hits $B$ within $N$ steps. Define the first-hit map
$$
 \tau(\theta)=\min\{k\ge0:R^k\theta\in B\},
 \qquad b(\theta)=R^{\tau(\theta)}\theta\in B.
\tag{4}
$$
Up to arc endpoints, the partial graph in (2) consists of finite paths, each with exactly one terminal point in $B$: an edge is present from $\theta$ to $R\theta$ exactly when $\theta\in A$, and $R$ has no finite orbit. Thus $b(\theta)=b(R\theta)$ on $A$. The bounded hitting time partitions the circle into finitely many intervals on which $b$ is a translation.

Because $Q$ maps edges to edges, it induces an involution $q:B\to B$ defined by
$$
 q(v)=b(Qv),\qquad b(Q\theta)=q(b(\theta)),\qquad q^2(v)=v.
\tag{5}
$$
It is piecewise a reflected translation with finitely many breaks. It is not the identity on any interval. Indeed, if $q(v)=v$, then $Qv$ is on the finite path terminating at $v$, so $Qv=R^{-k}v$ for some $0\le k\le N$. This implies
$$
 2v\equiv T+k\alpha\pmod L,
\tag{6}
$$
which has only finitely many solutions in $B$.

The image $b(A)$ contains a nonempty interval, since $A$ has positive length and $b$ is piecewise a translation. Choose a small interval $J\subset b(A)$ on which $q$ is a reflected translation, $q(J)\cap J=\varnothing$, and both $J,q(J)$ avoid the finitely many breakpoints. Divide $J$ into pairwise disjoint smaller intervals $J_j$. For each $j$, define
$$
 h_j=\mathbf1_{J_j}-\mathbf1_{q(J_j)}\quad\text{on }B,
 \qquad g_j(\theta)=h_j(b(\theta)),
 \qquad F_j(x)=\phi(x)g_j(x+a\pmod L).
\tag{7}
$$
Equations (2), (5), and $h_j\circ q=-h_j$ prove that $F_j$ is odd and every admitted prime-power edge has zero graph difference. Hence $D_a[F_j]=0$. The $F_j$ are linearly independent. Because $J_j\subset b(A)$, each nonzero finite combination is nonzero on a positive-measure part of an active $n=3$ edge, so its weighted row satisfies $S_a[F]>0$.

Each $h_j$ is a finite step function; the finite-interval structure of $b$ makes $g_j$ a finite step function too. Its zero-extended physical $F_j=\phi g_j$ has bounded variation and compact support. Its Fourier transform is $O_a((1+|t|)^{-1})$, so the logarithmic multiplier $h(t)=O(1+\log(2+|t|))$ gives finite $H_a$. Two independent $F_j$ allow a nonzero finite combination with one prescribed zero pole moment.

Finally, let $F_0$ be such a pole-null combination. Symmetric cutoffs removing boundary strips of width $\rho$, followed by interior mollification, approximate $F_0$ in the logarithmic form norm. For the cutoff error, boundedness, strip length $O(\rho)$, and bounded variation give a Fourier bound $O_a(\min(\rho,|t|^{-1}))$, hence logarithmic form error $O_a(\rho\log(1/\rho))\to0$. Subtract its vanishing pole moment times a fixed smooth odd test with nonzero pole moment, then normalize. The graph and row forms are bounded on $L^2(I_a)$; therefore $D_a\to D_a[F_0]=0$ and $S_a\to S_a[F_0]>0$, while normalized logarithmic energies remain bounded. This proves the final assertion.

The result places a concrete obstruction throughout $\tfrac12\log2<a<\tfrac12\log5$. The later $n=5$ edge and the remaining interval up to $\tfrac12\log6$ are not settled here. The construction is a graph/domain statement, not a negative full-Weil witness or an RH argument.
