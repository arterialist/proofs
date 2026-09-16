# Odd graph-null modes through the first fifth-integer window

The [fixed-window graph uncertainty theorem](odd-prime-graph-logarithmic-uncertainty.md) proves that the actual odd prime graph has no nonzero null vector once $a\ge\tfrac12\log6$. Below that radius, $\log3$ acts only on part of a $\log2$-periodic cell. This note constructs graph-null modes after the first prime edge enters and through a nontrivial range after $n=5$ enters, extending the linked theorem's one explicit first-prime example. It retains the admitted prime power $n=4$, the odd constraint, the pole moment and the logarithmic form domain. It does not determine the sign of the full Weil form.

Let $I_a=(-a,a)$, $\phi(x)=\cosh(x/2)$, and let $D_a[F]\ge0$ and $S_a[F]$ be the full prime graph and weighted row forms in equations (1)--(2) of the linked theorem. Let $H_a$ denote its positive logarithmic odd archimedean form. Put
$$
 L=\log2,\qquad M=\log3,\qquad T=2a,\qquad
 \alpha=M-L,\qquad T_*=\log(50/9).
$$

**Theorem.** For every
$$
 \frac12\log2<a<\frac12\log(50/9),
\tag{1}
$$
there is an infinite-dimensional space of odd, bounded-variation functions $F\in L^2(I_a)$ with finite $H_a[\sqrt2F|_{(0,a)}]$, $D_a[F]=0$, and $S_a[F]>0$ for every nonzero member of a specified subspace. In particular, one such nonzero $F$ can be chosen with exact pole moment $\langle\sqrt2\sinh(\cdot/2),\sqrt2F|_{(0,a)}\rangle=0$. There are odd compactly supported smooth tests with exact pole moment zero, bounded normalized logarithmic energy and $D_a[F]/S_a[F]\to0$ at each fixed radius in (1).

For $L<T\le M$, only $n=2$ enters. The $n=2$ graph equation identifies $g=F/\phi$ with a function on the circle $\mathbb R/L\mathbb Z$ in the coordinate $\theta=x+a\pmod L$. Oddness is the reflection $Q\theta=T-\theta\pmod L$. This reflection has at most two fixed points, while the active $n=2$ edge has positive-length coordinate arc $(0,T-L)$ and is preserved by $Q$. Choose disjoint small intervals $J_j$ inside that arc, away from the fixed points, such that all $J_j,Q(J_j)$ are disjoint. The step functions $h_j=\mathbf1_{J_j}-\mathbf1_{Q(J_j)}$ are odd under $Q$ and $L$-periodic. Their physical functions $F_j(x)=\phi(x)h_j(x+a\pmod L)$ are linearly independent odd graph-null modes with $S_a[F_j]>0$. The regularity, pole-null combination and smooth approximation below apply to these modes too.

Now assume $M<T<T_*<\log6$ and put $d=T-M\in(0,L)$. The admitted integers are among $n=2,3,4,5$. The $n=2$ graph equation again identifies $g$ with a function on the circle. The $n=4$ equation follows automatically from $L$-periodicity. The $n=3$ equation is precisely
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

If $T<\log5$, then the image $b(A)$ contains a nonempty interval, since $A$ has positive length and $b$ is piecewise a translation. Choose a small interval $J\subset b(A)$ on which $q$ is a reflected translation, $q(J)\cap J=\varnothing$, and both $J,q(J)$ avoid the finitely many breakpoints.

If $\log5\le T<T_*$, put $e=T-\log5\in[0,\log(10/9))$ and $\beta=\log5-2L=\log(5/4)$. The $n=5$ edge begins on the coordinate arc $A_5=(0,e)$ and ends on $A_5+\beta\pmod L$. Let
$$
 U=b(A_5)\cup b(A_5+\beta)\subset B.
\tag{7}
$$
The following exact itinerary leaves a wider gap than the coarse estimate $|U|\le2e$. Set
$$
\begin{gathered}
 r_3=\log(27/16),\qquad c_2=\log(15/8),\\
 c_1=\log(81/80),\qquad w=\log(256/243),
 \qquad w'=\log(16/15)=c_1+w.
\end{gathered}
\tag{8}
$$
For a source point $\theta=s\in(0,e)$, its first hit in $B$ occurs at step $3$ if $s>e-c_1$, with label at most $r_3+e$; otherwise it occurs at step $5$ if $s<w$, or at step $10$ if $s\ge w$, with label at least $\log(243/128)>c_2$. For a target point $\theta=\beta+s$, the first hit occurs at step $1$ if $s<w'$, with label at least $c_2$; otherwise it occurs at step $6$, with label at least $\log(243/128)$. These are direct additions of $\alpha$ modulo $L$, away from the finitely many arc endpoints. For the late source route, the intermediate positions at steps $1,\ldots,9$ are $s+r_k\pmod L$ with
$$
 (r_1,\ldots,r_9)=
 \bigl(\log(3/2),\log(9/8),\log(27/16),\log(81/64),
 \log(243/128),\log(729/512),\log(2187/2048),
 \log(6561/4096),\log(19683/16384)\bigr).
$$
The step-$5$ position wraps when $s\ge w$. At the other intermediate source steps except $3$ and $5$, the listed $r_k$ are all below $\log(5/3)$, so $r_k+s<d$; the step-$3$ branch condition supplies that comparison there. At step $10$, $r_{10}+s$ with $r_{10}=\log(59049/32768)$ is in $B$: $r_{10}+w=\log(243/128)>d$, and $r_{10}+e-c_1<L$. The late target route similarly has intermediate positions after its first wrap at $\log(45/32)+s,\log(135/128)+s,\log(405/256)+s,\log(1215/1024)+s$, all below $d$ because their constant parts are below $\log(5/3)$, followed by $\log(3645/2048)+s\in B$: at $s=w'$ this is $\log(243/128)>d$, while its value at $s=e<\log(10/9)$ is below $L$. Thus
$$
 J_e:=\bigl(r_3+e,c_2\bigr)\subset B\setminus U,
 \qquad |J_e|=\log(10/9)-e>0.
\tag{9}
$$
The parity reflection reverses every $n=5$ edge: $Q(\theta+\beta)=e-\theta\pmod L\in A_5$ for $\theta\in A_5$. Hence the induced $q$ preserves $U$ and its complement. Choose a small interval $J\subset J_e$ on which $q$ is a reflected translation, $q(J)\cap J=\varnothing$, and both $J,q(J)$ avoid the finitely many breakpoints. This choice makes every $n=5$ graph difference zero because both endpoint labels lie in $U$, where the functions below vanish.

In either case, divide $J$ into pairwise disjoint smaller intervals $J_j$. For each $j$, define
$$
 h_j=\mathbf1_{J_j}-\mathbf1_{q(J_j)}\quad\text{on }B,
 \qquad g_j(\theta)=h_j(b(\theta)),
 \qquad F_j(x)=\phi(x)g_j(x+a\pmod L).
 \tag{10}
$$
Equations (2), (5), and $h_j\circ q=-h_j$ prove that $F_j$ is odd and every admitted prime-power edge has zero graph difference. Hence $D_a[F_j]=0$. The $F_j$ are linearly independent. For $T<\log5$, $J_j\subset b(A)$ makes each nonzero finite combination active on a positive-measure part of an $n=3$ edge, so $S_a[F]>0$. For $T\ge\log5>2L$, the $n=2$ row alone gives $S_a[F]\ge(L/2)\|F\|_2^2>0$.

Each $h_j$ is a finite step function; the finite-interval structure of $b$ makes $g_j$ a finite step function too. Its zero-extended physical $F_j=\phi g_j$ has bounded variation and compact support. Its Fourier transform is $O_a((1+|t|)^{-1})$, so the logarithmic multiplier $h(t)=O(1+\log(2+|t|))$ gives finite $H_a$. Two independent $F_j$ allow a nonzero finite combination with one prescribed zero pole moment.

Finally, let $F_0$ be such a pole-null combination. Symmetric cutoffs removing boundary strips of width $\rho$, followed by interior mollification, approximate $F_0$ in the logarithmic form norm. For the cutoff error, boundedness, strip length $O(\rho)$, and bounded variation give a Fourier bound $O_a(\min(\rho,|t|^{-1}))$, hence logarithmic form error $O_a(\rho\log(1/\rho))\to0$. Subtract its vanishing pole moment times a fixed smooth odd test with nonzero pole moment, then normalize. The graph and row forms are bounded on $L^2(I_a)$; therefore $D_a\to D_a[F_0]=0$ and $S_a\to S_a[F_0]>0$, while normalized logarithmic energies remain bounded. This proves the final assertion.

The result places a concrete obstruction throughout $\tfrac12\log2<a<\tfrac12\log(50/9)$. The remaining interval up to $\tfrac12\log6$ is not settled here. The construction is a graph/domain statement, not a negative full-Weil witness or an RH argument. No priority claim is made, and no Lean formalization is claimed.
