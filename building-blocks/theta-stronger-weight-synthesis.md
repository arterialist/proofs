# Regular zero-mode synthesis in stronger weighted norms

This is a written mathematical proof for the complete theta kernel and its actual weighted Hilbert space. It is not a Lean theorem or a positivity proof. The cited entire-function and functional-analysis tools are classical; no priority claim is made.

Use the notation of [theta regular zero mode synthesis](theta-regular-zero-mode-synthesis.md). In particular
$\theta(u)=\pi e^{2|u|}$, $H_a=L^2(e^{a\theta}d\nu)$, and $S$ is the even equality span. Let $\mathscr B$ denote the finite linear combinations of all even xi zero modes and their multiplicity derivatives. Every such vector belongs to every $H_a$ with $a<1$.

**Theorem.** Suppose $h\in H_e^0\cap S^\perp\cap H_\epsilon$, with $0<\epsilon<1$. For every $0\le\delta<\epsilon$,
$$
\boxed{h\in\overline{\mathscr B}^{H_\delta}.}
\tag{1}
$$
The case $\delta=0$ is the original dual-weight theorem. This statement provides approximation in a strictly stronger norm whenever $\delta>0$.

Fix $\delta<\epsilon$. The continuous dual of $H_\delta$, using the original pairing, is $H_{-\delta}$. Let $g\in H_{-\delta}$ annihilate $\mathscr B$. Since $h$ is even, only the even part of $g$ matters, and reflection preserves all these weighted spaces. Thus take $g$ even. The original mean is bounded on $H_{-\delta}$ because $\delta<1$. Subtract its mean and write
$$
g_0=g-\nu g.
\tag{2}
$$
Each zero mode has original mean zero, so $g_0$ still annihilates $\mathscr B$. The transform $Ug_0$ is entire by the weaker-space evaluation estimates. The zero-mode evaluation identities give all xi zeros with their multiplicities. The mean supplies the pole-factor zeros at $\pm i/2$. Therefore
$$
E=(Ug_0)/G
$$
is entire and even.

The quotient-growth proof also applies to $g_0\in H_{-\delta}$, with its constants recomputed. Cauchy-Schwarz replaces the theta exponent $-\theta$ by $-(1-\delta)\theta$, and yields
$$
\log|Ug_0(x+iy)|\le
\frac Y2\log\frac{Y}{\pi(1-\delta)}-\frac Y2+O(\log(Y+2)),
\qquad Y=|y|.
\tag{3}
$$
The xi denominator is unchanged. Relative to the angular bound in [theta quotient indicator lens](theta-quotient-indicator-lens.md), the bound for the upper half-plane indicator increases by
$-\tfrac12\sin\vartheta\log(1-\delta)$. Entire division and the two real-axis Phragmen-Lindelof sectors still give finite exponential type. Optimizing the same halfplanes places the diagram in
$$
\overline K_{-\delta}=
\left\{a+ib:
|a|\le\tfrac12\arccos\frac{1-\delta}{2},\quad
|b|\le\tfrac12\log\frac{2\cos2a}{1-\delta}\right\}.
\tag{4}
$$
This is the closed component in the principal theta strip. For every point of (4),
$$
2e^{-2|b|}\cos(2a)-(1-\epsilon)\ge\epsilon-\delta>0.
\tag{5}
$$
Thus its whole compact closure lies in the open translation lens for $H_{-\epsilon}$. The Borel-contour construction in that weaker norm produces finite original equality combinations $s_n$ such that
$$
\|g_0-s_n\|_{-\epsilon}\longrightarrow0.
\tag{6}
$$
Here $H_{-\delta}\subset H_{-\epsilon}$, and Fourier injectivity identifies the Bochner inverse with $g_0$, exactly as in the original proof.

Since $h\perp S$, weighted duality proves
$$
|\langle h,g_0\rangle_H|
=\lim_n|\langle h,g_0-s_n\rangle_H|
\le\|h\|_\epsilon\lim_n\|g_0-s_n\|_{-\epsilon}=0.
\tag{7}
$$
This notation denotes the extended weighted dual pairing when $g_0\notin H$. It is absolutely convergent. The removed constant also pairs to zero because $\nu h=0$. Hence every continuous functional on $H_\delta$ that annihilates $\mathscr B$ also annihilates $h$. The Hahn-Banach closure criterion proves (1).

There is an analogous whole-odd statement. Write $\mathscr B_o$ for finite raw sine zero-mode combinations and $t=\tanh(u/2)$. If $h\in H_{\rm odd}\cap S_o^\perp\cap H_\epsilon$, then
$$
h\in\overline{\mathscr B_o+\operatorname{span}\{t\}}^{H_\delta},
\qquad 0\le\delta<\epsilon.
\tag{8}
$$
Indeed a dual annihilator $g\in H_{-\delta}$ of that augmented span has $\beta(g)=0$ and all xi-zero evaluations zero. After taking its odd part, $(Ug)/(zG)$ is entire even. Equations (3)-(7) then apply using the odd derivative generator and the odd equality vectors. No mean adjustment is needed.

The result controls the physical tail norm of the approximants. A norm involving jump energy is a separate requirement because the archimedean generator has an unbounded logarithmic Fourier multiplier. No passage to the form norm is made in this note.
