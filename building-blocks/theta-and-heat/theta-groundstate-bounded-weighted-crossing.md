# Boundedness of the killed ground state and the weighted crossing map

This is a written proof for the actual full theta jump form. No theorem in this chapter is formalized in Lean. The killed-ground-state and constrained-domain inputs are established in the [ground-pole theorem](theta-killed-return-ground-pole.md) and [constrained Schur construction](theta-constrained-schur-across-ground-pole.md).

The proof uses the classical positive-semigroup resolvent barrier and Carleman boundary-kernel estimate. Its arithmetic input is the established full prime return law from the prime number theorem; no uniform constant as the exterior ground pole approaches the threshold is asserted.

Fix $R>0$, $C=[-R,R]$, and $O=\mathbb R\setminus C$. Write
$$
 b(u)=2\cosh(u/2),\quad d\nu=b\Phi\,du,\quad
 \rho(u)=e^{-|u|/2}/b(u),\quad \lambda=1/2.
$$
Let $D=L_O$ be the actual killed generator, including the continuous kernel
$r(t)=e^{-t/2}/(1-e^{-2t})$, every prime power and both displacement directions. Its simple positive normalized ground state satisfies
$$
 D\psi=\alpha\psi,\qquad 0<\alpha<\lambda,
 \qquad \|\psi\|_{L^2(\nu_O)}=1.
$$
We prove that $\psi\in L^\infty(O)$, and then that
$$
 \boxed{\quad
 J_W(Bx):=\int_O\frac{\psi}{\rho}|Bx|^2d\nu
 \le C_R\|x\|_{L^2(\nu_C)}^2
 \quad(x\in L^2(\nu_C)).\quad}
\tag{1}
$$
The finite constant depends on the actual fixed core and ground state. No uniform estimate as $\alpha\uparrow\lambda$ or sharp covariance comparison is asserted.

## A bounded barrier using the full prime return law

Put $d=\lambda-\alpha>0$. Choose $S>R+1$ with
$\nu(|u|>S)<d/(4\lambda)$, and choose
$M>\max(1,4\lambda\nu(O)/d)$. Take an even smooth function $w$ on $O$ such that
$$
 1\le w\le M,\qquad w=1\text{ for }R<|u|\le S,
 \qquad w=M\text{ for }|u|\ge S+1.
$$
Extend it by zero on $C$, and put $m=\int_Ow\,d\nu$. Then
$$
 \frac mM\le\frac{\nu(O)}M+\nu(|u|>S)<\frac d{2\lambda}.
\tag{2}
$$
This extension is constant at each infinite end and has only the two hard-boundary jumps. It belongs to $D(L)$: the established hard-indicator domain theorem handles those jumps, while the remaining smooth transition has compactly supported derivatives; its continuous compensated generator and full prime generator are in $L^2(\nu)$. In particular $w\in D(D)$.

The actual prime return law, applied to this bounded, piecewise smooth extension, gives
$$
 Dw(u)\longrightarrow\lambda(M-m)
 \qquad(u\longrightarrow\pm\infty).
\tag{3}
$$
Indeed the full prime departure rate tends to $\lambda$, its arrival term tends to $\lambda\int w(1\mp\tau)d\nu=\lambda m$ by evenness, and the continuous generator tends to zero. The two finite jumps cause no problem in ordinary PNT partial summation; their endpoint error terms tend to zero. Equivalently one can sandwich the nonnegative finite-interval jump tests by continuous functions and use the positive prime return measures. This application concerns the specified regular barrier, not arbitrary $L^2$ inputs.

By (2), the limit of $(D-\alpha)w$ is larger than $dM/2$. Thus there is $U>S+1$ such that
$$
 (D-\alpha)w\ge dM/4\quad\text{on }|u|>U.
\tag{4}
$$
On the bounded exterior strip $R<|u|\le U$, $(D-\alpha)w$ has a finite uniform lower bound. Near a hard boundary, $w=1$, so its continuous contribution is the nonnegative core killing singularity plus a bounded term from the distant smooth transition; its prime contribution is bounded below by $-M$ times the bounded full prime departure rate. Away from the two boundaries the continuous generator of this fixed smooth function is bounded. Notice that (3) is not the false assertion $\kappa_O\to\lambda$: for this fixed core, $\kappa_O=B1_C\to\lambda\nu(C)$.

## Remove only the bounded continuous arrivals

For $0<\varepsilon<1$, define
$$
 K_\varepsilon h(u)=\frac1{b(u)}
 \int_{\substack{v\in O\\|u-v|\ge\varepsilon}}
 r(|u-v|)\Phi(v)h(v)\,dv,
 \qquad q_\varepsilon=K_\varepsilon1_O.
\tag{5}
$$
This is a bounded, symmetric, positivity-preserving operator on $L^2(\nu_O)$: its row integral $q_\varepsilon$ is uniformly bounded, and symmetry gives the column bound. More strongly, Cauchy–Schwarz gives
$$
 |K_\varepsilon h(u)|
 \le\frac1{b(u)}
 \left(\int_{\substack{v\in O\\|u-v|\ge\varepsilon}}
 r(|u-v|)^2\frac{\Phi(v)}{b(v)}\,dv\right)^{1/2}\|h\|_\nu
 \le C_\varepsilon\|h\|_\nu.
\tag{6}
$$
Here $b\ge2$, $r$ is bounded on $[\varepsilon,\infty)$, and $\int\Phi/b<\infty$. No prime translation was treated as an $L^2$-to-$L^\infty$ operator.

The operator
$$
 A_\varepsilon=D+K_\varepsilon
\tag{7}
$$
is a Dirichlet generator on $D(D)$. To see this directly, split the continuous internal jump form at $\varepsilon$. Its large-jump part is the multiplication form $q_\varepsilon$ minus the arrival operator $K_\varepsilon$. Adding $K_\varepsilon$ removes exactly those arrivals and leaves their rates as killing. All smaller continuous jumps, all internal prime-power jumps, and all original core killing remain.

On $R<|u|\le U$, $q_\varepsilon\to\infty$ uniformly as $\varepsilon\downarrow0$. For example, from any positive exterior point integrate displacements $v-u\in[\varepsilon,a]$ directed to the right, with a fixed small $a>0$; at negative points use leftward displacements. These remain in $O$. On the resulting bounded interval $\Phi(v)/b(u)$ has a uniform positive lower bound, while $\int_\varepsilon^a r(t)dt\to\infty$. Since $w\ge1$, $K_\varepsilon w\ge q_\varepsilon$.

Choose $\varepsilon$ small enough to pay the bounded negative part preceding (5). Equations (4)–(7) then give, for $\delta=d/8$,
$$
 (A_\varepsilon-\alpha)w\ge\delta w
 \quad\text{almost everywhere on }O.
\tag{8}
$$
The tail inequality follows because $K_\varepsilon w\ge0$ and $w=M$ there. On the bounded strip it follows from uniform divergence of $q_\varepsilon$. This construction allows $\varepsilon$ to depend on $R,\alpha,S,M$.

## Resolvent domination at the original pole

Let $P_t=\exp(-tA_\varepsilon)$. Positivity and (8), with $w\in D(A_\varepsilon)$, imply
$$
 0\le P_tw\le e^{-(\alpha+\delta)t}w.
\tag{9}
$$
For instance differentiate $e^{(\alpha+\delta)t}P_tw$ in $L^2$, or integrate its nonpositive derivative using the positive semigroup. Since $1\le w\le M$, (9) implies
$\|P_t\|_{\infty\to\infty}\le M e^{-(\alpha+\delta)t}$.
Symmetry gives the same $L^1$ bound, and interpolation gives the $L^2$ bound. Therefore the resolvent
$$
 (A_\varepsilon-\alpha)^{-1}
   =\int_0^\infty e^{\alpha t}P_t\,dt
$$
exists on $L^2$, and maps bounded functions to bounded functions with norm at most $M/\delta$. This is a new resolvent of (7), not the singular inverse of $D-\alpha$.

The actual eigenfunction equation now yields
$$
 \psi=(A_\varepsilon-\alpha)^{-1}K_\varepsilon\psi,
 \qquad
 \boxed{\ \|\psi\|_\infty\le MC_\varepsilon/\delta<\infty.\ }
\tag{10}
$$
Thus boundedness has been proved before making any bounded-forcing application of a logarithmic boundary theorem. No such boundary theorem is needed for (1).

## The weighted crossing operator

It remains to prove
$$
 \rho^{-1/2}B:L^2(C,\nu)\longrightarrow L^2(O,\nu)
 \quad\text{is bounded}.
\tag{11}
$$
For the continuous part, conjugating both spaces to Lebesgue $L^2$ gives the kernel
$$
 r(|u-v|)
 \sqrt{e^{|u|/2}\Phi(u)\Phi(v)/b(v)},\qquad u\in O,\ v\in C.
\tag{12}
$$
In fixed neighborhoods of the two common endpoints its smooth factor is bounded, and the singular factor is bounded by a constant times the Carleman kernel $(s+t)^{-1}$, whose $L^2(0,\infty)$ operator norm is $\pi$. Away from these two adjacent endpoint regions, (12) is square-integrable: the diagonal is separated, the core is bounded, and the exterior factor has theta decay. Hence the continuous crossing part satisfies (11).

For a prime-power index $n$, a crossing branch has $u=v\pm\log n$, $v\in C$, $u\in O$, and coefficient $\Lambda(n)\Phi(v)/(\sqrt n\,b(u))$. Its norm after the same weighted conjugation is bounded by
$$
 \Lambda(n)\sup_{v\in C}
 \sqrt{\frac{e^{|v\pm\log n|/2}
                   \Phi(v\pm\log n)\Phi(v)}{n\,b(v)}}.
\tag{13}
$$
The sum of these bounds over $n\ge2$ and both signs is finite. The finitely many small indices are harmless; for large $n$, $|v\pm\log n|\ge\log n-R$, and the full theta bound makes $\Phi(v\pm\log n)$ decrease faster than any power of $n$, uniformly for $v\in C$. The elementary estimate $\Lambda(n)\le\log n$ suffices. Thus the complete prime-power crossing series converges in the weighted operator norm. This proves (11), without assigning pointwise bounds to individual prime translates of a general input.

Combining (10) and (11) proves (1). In particular the actual source map
$$
 x\longmapsto Bx/\rho
 \quad\text{from }L^2(\nu_C)\text{ to }L^2(\gamma),
 \qquad d\gamma=\rho\psi\,d\nu,
\tag{14}
$$
is bounded. Ground-pole centering and the odd column are also admissible: $\int\psi\rho^{-1}d\nu<\infty$ follows from boundedness of $\psi$ and theta decay, and their coefficients are bounded core functionals. Consequently the full centered and affine source maps are bounded on the same space.

Finally, the established fixed-core compact embedding $D(E_C)\hookrightarrow L^2(\nu_C)$, with its form norm, composed with (14) gives
$$
 \boxed{\quad D(E_C)\longrightarrow L^2(\gamma),\quad
 x\longmapsto Bx/\rho,\quad\text{compact}.\quad}
\tag{15}
$$
Thus the rank-one weighted deficit and the prime-retained covariance bound are continuous compact quadratic corrections on the actual core form domain. This removes their previous extra weighted-source hypothesis for unbounded core inputs. It does not establish that the resulting correction is dominated by $E_C-\alpha\|\cdot\|^2$, nor any uniform constant or threshold gap.
