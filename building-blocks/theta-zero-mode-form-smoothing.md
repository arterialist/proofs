# Weighted smoothing into the actual jump-form domain

This is a written mathematical proof for the complete theta kernel and its actual weighted Hilbert space. It is not a Lean theorem or a positivity proof. The cited entire-function and functional-analysis tools are classical; no priority claim is made.

Let $H=L^2(\nu)$, $d\nu=M^{-1}\cosh(u/2)\Phi(u)du$, $M=1/2$, and let $E$ be the closed actual jump form, including every prime-power jump and the archimedean logarithmic singularity. For $\delta>0$, put
$$
 H_\delta=L^2(e^{\delta\pi e^{2|u|}}\nu).
$$
Choose a nonnegative even $\rho\in C_c^\infty([-1,1])$ with $\int\rho=1$, set $\rho_s(v)=s^{-1}\rho(v/s)$, and define
$$
 M_sh(u)=\frac1{\cosh(u/2)}
 \int\rho_s(v)\cosh((u-v)/2)h(u-v)dv.
 \tag{1}
$$

**Smoothing theorem.** For every $\delta>0$, there is $s_\delta>0$ such that, for each fixed $0<s\le s_\delta$,
$$
 M_s:H_\delta\longrightarrow D(E)
 \quad\text{is bounded}. \tag{2}
$$
For every $\varepsilon>0$ and $h\in D(E)\cap H_\varepsilon$,
$$
 \|M_sh-h\|_H^2+E(M_sh-h)\longrightarrow0
 \quad(s\downarrow0). \tag{3}
$$
Finite complete multiplicity-jet spaces of actual global zero modes are preserved. The theorem does not assume boundedness of nontrivial translations on $H$, nor any zero-mode density theorem.

## 1. Coordinates and two distinct translation estimates

Write
$$
 c(u)=\cosh(u/2),\quad A(u)=\Phi(u)/c(u),\quad k(u)=c(u)h(u),
 \quad f(u)=\Phi(u)h(u)=A(u)k(u).
$$
Then
$$
 \|h\|_{H_\delta}^2=\int a_\delta(u)|k(u)|^2du,
 \qquad a_\delta(u)=M^{-1}A(u)e^{\delta\pi e^{2|u|}}.
 \tag{4}
$$
The complete theta asymptotic gives
$$
 A(u)\asymp e^{4|u|-\pi e^{2|u|}},\qquad
 |A'(u)|\le Ce^{2|u|}A(u)
 \tag{5}
$$
outside a compact interval, with smooth bounded behavior on compact intervals.

For the Hilbert norm, set $\delta_0=\min(\delta,1/2)$ and choose, for example,
$$
 s_\delta=\tfrac14\log\frac1{1-\delta_0}.
 \tag{6}
$$
Since $e^{-2s_\delta}-(1-\delta_0)>0$, (5) implies
$$
 \sup_{|v|\le s_\delta}\sup_t
 \frac{a_0(t+v)}{a_{\delta_0}(t)}<\infty. \tag{7}
$$
Indeed the leading exponent in the ratio is at most
$-\pi[e^{-2s_\delta}-(1-\delta_0)]e^{2|t|}+C|t|$.
Thus translations of $k$ are uniformly bounded from $L^2(a_{\delta_0}du)$ to $L^2(a_0du)$, for these small shifts. Minkowski gives
$$
 \|M_sh\|_H\le C_\delta\|h\|_{H_\delta},
 \qquad 0<s\le s_\delta. \tag{8}
$$
This is a stronger-space-to-weaker-space estimate, not translation boundedness on the original space.

A different estimate controls the physical Fourier norm. Choose once and for all $s_*<\tfrac12\log2$. The full theta tail in (5) gives
$$
 \sup_{|v|\le s_*}\sup_t\frac{|A'(t+v)|^2}{a_0(t)}<\infty,
 \qquad \sup_t\frac{|A(t)|^2}{a_0(t)}<\infty. \tag{9}
$$
For the first ratio the decisive exponential coefficient is
$-\pi[2e^{-2s_*}-1]e^{2|t|}$; every derivative prefactor is absorbed by its positive margin. The choices in (6) are smaller than some such fixed $s_*$.

## 2. The exact commutator with ordinary convolution

Equation (1) gives
$$
 \Phi M_sh=\rho_s*f+C_s,
$$
$$
 C_s(u)=\int\rho_s(v)[A(u)-A(u-v)]k(u-v)dv.
 \tag{10}
$$
This identity is valid for all $h\in H$ locally; $k$ is locally $L^2$. For $|v|\le s_*$, the mean-value formula and (9) yield
$$
 \|[A(\cdot)-A(\cdot-v)]k(\cdot-v)\|_2
 \le C|v|\|h\|_H.
$$
Consequently
$$
 \|C_s\|_2\le Cs\|h\|_H. \tag{11}
$$
To differentiate without assuming a derivative of $k$, write the integral in the variable $t=u-v$:
$$
 C_s'(u)=\int\rho_s'(u-t)[A(u)-A(t)]k(t)dt
       +A'(u)\int\rho_s(u-t)k(t)dt.
$$
The same bound for the first term and (9) for the second give
$$
 \|C_s'\|_2
 \le C\left(\int|v\rho_s'(v)|dv+\int\rho_s(v)dv\right)\|h\|_H
 \le C\|h\|_H. \tag{12}
$$
The constants are independent of $s\le s_*$, because the first displayed integral is invariant under the scaling of $\rho_s$. Thus the whole-kernel commutator has small $L^2$ norm and uniformly bounded first Sobolev norm.

## 3. The exact logarithmic norm of the full form

Use the established full arithmetic identity, initially on compact smooth tests,
$$
 E(h)-\tfrac12\|h\|_H^2
 =\mathcal A(\Phi h)-\langle \sqrt{d\nu/du}\,h,
 K_{\rm p}\sqrt{d\nu/du}\,h\rangle_{L^2(du)}.
 \tag{13}
$$
Here $\mathcal A$ has multiplier
$a(t)=\Re\psi(1/4+it/2)-\log\pi$. The operator $K_{\rm p}$ retains all prime powers and is bounded: its weighted-shift coefficient suprema are summable by full theta decay. These are the results in §§8 and 11 of the [ground-state chapter](theta-weil-jump-form.md). In particular no prime term is discarded in this argument.

Since $a(t)-a(0)\ge0$, $a(t)=\log(2+|t|)+O(1)$, and multiplication $h\mapsto\Phi h$ is bounded from $H$ to $L^2(du)$, (13) implies the form-norm equivalence
$$
 \|h\|_H^2+E(h)\asymp
 \|h\|_H^2+\|\Phi h\|_{\log}^2,
 \qquad
 \|f\|_{\log}^2=\frac1{2\pi}\int\log(2+|t|)|\widehat f(t)|^2dt.
 \tag{14}
$$
It holds on the compact core and extends to $D(E)$ by the closed logarithmic Fourier form, as in the [ground-state chapter](theta-weil-jump-form.md). The logarithmic multiplier is the exact regularity associated with the archimedean diagonal singularity.

We also need one elementary sufficient domain statement. If $g$ is smooth, $g\in H$, and $\Phi g\in H^1(du)$, then $g\in D(E)$. To prove it, use compact smooth cutoffs $g_N=\chi(u/N)g$. They converge in $H$; their physical functions $\Phi g_N=\chi(u/N)\Phi g$ converge in $H^1$, hence in the logarithmic norm. Equation (14) on differences of compact smooth cutoffs makes $g_N$ Cauchy in the actual form norm, and its limit is $g$. This checks the closed-form domain rather than merely a formal finite-energy expression.

## 4. Fixed-s boundedness and form-norm convergence

For $h\in H_\delta$ and fixed $s\le s_\delta$, the function $M_sh$ is smooth, since $k$ is locally $L^2$ and $\rho_s$ is compact smooth. It belongs to $H$ by (8). Also $f=\Phi h\in L^2$, and (10)–(12) give
$$
 \|\Phi M_sh\|_{H^1}
 \le C(1+s^{-1})\|h\|_H.
$$
The sufficient domain statement and (14) prove (2), quantitatively in the form
$$
 \|M_sh\|_H^2+E(M_sh)
 \le C_\delta[1+s^{-2}]\|h\|_{H_\delta}^2.
 \tag{15}
$$
Only boundedness for each fixed $s$ is claimed here; this bound may grow as $s\downarrow0$.

Now let $h\in D(E)\cap H_\varepsilon$. Estimate (7), density of compact smooth functions in $L^2(a_\varepsilon du)$, and ordinary translation continuity for each compact smooth function show
$$
 \|M_sh-h\|_H\longrightarrow0. \tag{16}
$$
Explicitly, approximate $k$ first in the stronger weighted norm; (7) bounds the approximation error uniformly for small $s$, and for the fixed compact approximation translation continuity is local and unweighted. This step does not use translations on all of $H$.

Since $h\in D(E)$, (14) gives $f=\Phi h$ in the logarithmic Fourier space. Ordinary convolution satisfies
$\rho_s*f\to f$ in that space by dominated convergence of its bounded Fourier multipliers. On the other hand, $\log(2+|t|)\le C(1+t^2)^{1/2}$, so Cauchy–Schwarz in frequency, (11), and (12) give
$$
 \|C_s\|_{\log}^2
 \le C\|C_s\|_2\|C_s\|_{H^1}
 \le Cs\|h\|_H^2\longrightarrow0.
 \tag{17}
$$
The exact identity (10) thus proves
$\Phi M_sh\to\Phi h$ in logarithmic Fourier norm. Combining this with (16) and (14) proves the actual form-norm convergence (3).

## 5. The precise invariant finite zero-mode spaces

For a zero $\zeta$ of multiplicity $m_\zeta$, the even raw zero modes are
$$
 b_{\zeta,k}(u)=\frac{\partial_\zeta^k\cos(\zeta u)}{\cosh(u/2)},
 \qquad 0\le k<m_\zeta.
$$
Let $c_s(\zeta)=\int\rho_s(v)\cos(\zeta v)dv$. Evenness of $\rho_s$ gives, for every complex $\zeta$,
$$
 M_sb_{\zeta,0}=c_s(\zeta)b_{\zeta,0},\qquad
 M_sb_{\zeta,k}=
 \sum_{\ell=0}^k\binom{k}{\ell}
 c_s^{(k-\ell)}(\zeta)b_{\zeta,\ell}.
 \tag{18}
$$
Compact support justifies all parameter derivatives. Thus every finite sum of complete multiplicity-jet spaces is invariant; parity is preserved. Each such image remains a finite combination of the same actual allowed zero modes.

One wording distinction matters: the span of an isolated higher derivative need not be invariant, because (18) can produce lower derivatives. Given any finite collection, adjoining those finitely many lower derivatives gives the invariant space required here. No new zero locations or excessive multiplicity orders are introduced.

## 6. Form synthesis for general regular even complement vectors

Suppose the separate argument supplies, for a particular
$h\in D(E)\cap H_\varepsilon$, finite allowed zero-mode combinations $b_n$ such that $b_n\to h$ in $H_\delta$, where $0<\delta<\varepsilon$. The smoothing theorem proves, for each fixed sufficiently small $s$,
$$
 M_sb_n\longrightarrow M_sh\quad\text{in actual form norm}.
$$
Each approximant on the left is still a finite zero-mode combination by (18). Then (3), followed by a diagonal choice of $s\downarrow0$ and $n\to\infty$, approximates $h$ in form norm by finite zero modes. All prime jumps and the archimedean logarithmic regularity remain controlled throughout.

The stronger-weight theorem in [theta stronger weight synthesis](theta-stronger-weight-synthesis.md) supplies this approximation: if $h\in H_e^0\cap S^\perp\cap H_\varepsilon$, $0<\varepsilon<1$, then finite allowed zero modes approximate it in every $H_\delta$, $0\le\delta<\varepsilon$. Applying that theorem gives the precise corollary
$$
 \boxed{D(E)\cap H_e^0\cap S^\perp\cap H_\varepsilon
 \ \subset\ \overline{\mathscr B}^{\,\|\cdot\|_H^2+E},
 \qquad \varepsilon>0,}
 \tag{19}
$$
where $\mathscr B$ denotes the finite allowed even zero-mode combinations. For $\varepsilon\ge1$, first replace it by any smaller positive parameter below one. Then choose one fixed $0<\delta<\varepsilon$ in that range and apply the preceding argument.

The approximants $M_sb_n$ remain in $\mathscr B$, and the convergence is in the actual closed form norm. Equation (19) applies to general regular complement vectors in the form domain; it requires no eigenvector smoothness theorem. The stronger-norm synthesis is an explicitly imported mathematical input, while the smoothing and closed-domain steps are proved here. No spectral-gap conclusion or RH exclusion is asserted.

## 7. The odd augmented space

Let $\mathscr B_o$ be the finite raw sine zero-mode combinations, including the allowed multiplicity derivatives, and let $t(u)=\tanh(u/2)$. The sine version of (18) preserves each complete finite jet space. Also the exact convolution of $c(u)t(u)=\sinh(u/2)$ gives
$$
M_st=\left(\int\rho_s(v)\cosh(v/2)\,dv\right)t.
\tag{20}
$$
Thus the augmented finite span $\mathscr B_o+\operatorname{span}\{t\}$ is preserved. The stronger weighted odd synthesis, equation (8) of [theta stronger weight synthesis](theta-stronger-weight-synthesis.md), supplies its $H_\delta$ approximants. The same diagonal argument proves
$$
\boxed{D(E)\cap H_{\rm odd}\cap S_o^\perp\cap H_\varepsilon
\ \subseteq\ 
\overline{\mathscr B_o+\operatorname{span}\{t\}}^{\,\|\cdot\|_H^2+E},
\qquad \varepsilon>0.}
\tag{21}
$$
The rank-one term has been retained. Its coefficient for an actual odd subthreshold eigenvector is fixed by the score identity in [theta odd zero mode synthesis](theta-odd-zero-mode-synthesis.md).
