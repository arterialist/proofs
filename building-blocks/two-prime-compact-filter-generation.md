# Compact smooth test generation by two prime filters

This is a written application of classical logarithmic-form bounds and compact-distribution division, with the complete construction below. It is not a Lean formalization. No claim of positivity or publication priority is made.

Put $L_p=\log p$, $r_p=p^{-1/2}$, and use the Fourier convention

$$
\widehat f(z)=\int_{\mathbb R}f(u)e^{-izu}\,du.
$$

The double shift filter at $p$ is

$$
\mathcal K_pg=(1+r_p^2)g-r_p\bigl(g(\,\cdot+L_p)+g(\,\cdot-L_p)\bigr),
\qquad
K_p(z)=(1-r_pe^{iL_pz})(1-r_pe^{-iL_pz}).
\tag{1}
$$

## The generation theorem

There exist fixed continuous linear maps $S_2,S_3$ on the space

$$
\mathcal D_0=\left\{f\in C_c^\infty(\mathbb R):
\int e^{u/2}f(u)\,du=\int e^{-u/2}f(u)\,du=0\right\}
$$

such that

$$
f=\mathcal K_2S_2f+\mathcal K_3S_3f.
\tag{2}
$$

More precisely, fixed constants $R,C<\infty$ and an integer $m\ge0$ can be chosen so that, whenever $\operatorname{supp}f\subset[A,B]$, the seeds $g_p=S_pf$ satisfy

$$
\operatorname{supp}g_p\subset[A-R,B+R],\qquad
\|g_p^{(j)}\|_\infty
\le C\max_{0\le\ell\le m}\|f^{(j+\ell)}\|_\infty
\quad(j\ge0).
\tag{3}
$$

The same maps can preserve real functions and reflection symmetry. Conversely, every sum on the right side of (2), with compact smooth seeds, belongs to $\mathcal D_0$.

This is a statement about the full space of compact smooth pole-null tests. It does not assert positivity of a Weil quadratic form on their images. The support and derivative constants exist; the proof below does not calculate numerical values for them.

## Removing the common differential factor

Let $\mathcal L_0=-\partial_u^2+1/4$ and define the continuous compactly supported functions

$$
k_p(u)=2r_p\sinh\!\left(\frac{L_p-|u|}{2}\right)
\mathbf1_{\{|u|\le L_p\}}.
$$

Their distributional second derivatives give

$$
\mathcal L_0k_p=(1+r_p^2)\delta_0-r_p(\delta_{L_p}+\delta_{-L_p}),
\qquad
F_p(z):=\widehat k_p(z)=\frac{K_p(z)}{z^2+1/4}.
\tag{4}
$$

Indeed, the derivative jump at zero is $-(1+r_p^2)$, and each endpoint derivative jump is $r_p$. The quotient in (4) is entire, with

$$
F_p(i/2)=F_p(-i/2)=(1-p^{-1})\log p>0.
$$

Its zeros are precisely

$$
\frac{2\pi m}{\log p}+\frac i2,
\qquad
\frac{2\pi m}{\log p}-\frac i2,
\qquad m\in\mathbb Z\setminus\{0\}.
\tag{5}
$$

Thus $F_2$ and $F_3$ have no common zeros. A common zero would require $m\log3=n\log2$, hence $3^m=2^n$ and $m=n=0$, which (5) excludes. The absence of common zeros alone is insufficient for compact distribution division. The quantitative estimate follows next.

## The joint lower bound

There are constants $c>0$ and $a<\infty$ such that

$$
|m\log3-n\log2|
\ge c(1+|m|+|n|)^{-a}
\quad\text{for }(m,n)\ne(0,0).
\tag{6}
$$

This is the fixed-algebraic-number specialization of Matveev's lower bound for a nonzero linear form in logarithms. In his Corollary 2.3 take the number field $\mathbb Q$, the two numbers $3,2$, their real logarithms and integer coefficients $m,-n$. The height factors are fixed, and the only coefficient dependence in the exponent is $\log(e\max\{|m|,|n|\})$. Unique factorization verifies nonvanishing. [Matveev, *An explicit lower bound for a homogeneous rational linear form in the logarithms of algebraic numbers. II*, 2000, Corollary 2.3, printed p. 1219](https://www.mathnet.ru/php/getFT.phtml?jrnid=im&option_lang=eng&paperid=314&what=fullteng).

We claim that, for some $c_1>0$,

$$
|F_2(z)|+|F_3(z)|\ge c_1(1+|z|)^{-a-2}
\qquad(z\in\mathbb C).
\tag{7}
$$

Write $z=x+iy$. If $y\ge1$, the two factors of $K_p$ have lower bounds

$$
|1-r_pe^{iL_pz}|\ge1-p^{-3/2},\qquad
|1-r_pe^{-iL_pz}|\ge r_p(1-r_p)e^{L_py}.
$$

The factors exchange roles for $y\le-1$. Division by $|z^2+1/4|\le C(1+|z|)^2$ proves (7) outside the strip $|y|\le1$.

Inside that strip, outside the two strips $|y-1/2|<1/4$ and $|y+1/2|<1/4$, the radial moduli of both factors stay a fixed distance from one, so $|K_p(z)|\ge c_p>0$.

In the upper remaining strip the factor $1-r_pe^{iL_pz}$ stays bounded away from zero. The other factor has the form $1-qe^{-iL_px}$ with $q=e^{L_p(y-1/2)}$ in a fixed compact subinterval of $(0,\infty)$. Choose $m_p\in\mathbb Z$ with $|L_px-2\pi m_p|\le\pi$. The identity

$$
|1-qe^{-i\theta}|^2=(1-q)^2+4q\sin^2(\theta/2)
$$

then gives

$$
|K_p(x+iy)|\ge c_p\left|x-\frac{2\pi m_p}{L_p}\right|.
$$

For sufficiently large $|x|$, the nearest integers $m=m_2,n=m_3$ are not both zero and have size $O(1+|x|)$. Therefore

$$
\begin{aligned}
|K_2(z)|+|K_3(z)|
&\ge c\left(\left|x-\frac{2\pi m}{L_2}\right|
+\left|x-\frac{2\pi n}{L_3}\right|\right)\\
&\ge\frac{2\pi c}{L_2L_3}|mL_3-nL_2|
\ge c'(1+|x|)^{-a}.
\end{aligned}
$$

The lower strip has the same estimate with the factors exchanged. Dividing by $|z^2+1/4|$ proves (7) outside a compact set. On that compact set, continuity and the absence of common zeros of $F_2,F_3$, including their nonzero removable values, complete the proof.

## Compact distribution division and smooth seeds

The compact distribution generator theorem states that $u_1,u_2\in\mathcal E'(\mathbb R)$ admit $B_1,B_2\in\mathcal E'(\mathbb R)$ with $u_1*B_1+u_2*B_2=\delta_0$ if and only if, for some positive constants,

$$
|\widehat u_1(z)|+|\widehat u_2(z)|
\ge C(1+|z|^2)^{-N}e^{-M|\operatorname{Im}z|}.
$$

This is Corollary 3.1 of [Sara Maad Sasane and Amol Sasane, *Generators for rings of compactly supported distributions*](https://arxiv.org/pdf/1004.0927), printed p. 6. Their proof uses the Paley–Wiener–Schwartz theorem and Hörmander's 1967 analytic generator theorem, recalled as Proposition 2.2. The one-dimensional result was already known, as they state after Theorem 1.1.

The bound (7) is stronger than this hypothesis. Consequently there are fixed compact distributions $B_2,B_3$ such that

$$
k_2*B_2+k_3*B_3=\delta_0.
\tag{8}
$$

For $f\in\mathcal D_0$, set

$$
G(u)=e^{-|u|/2},\qquad h=G*f.
$$

The derivative jump of $G$ is $-1$, so $\mathcal L_0G=\delta_0$. Thus $\mathcal L_0h=f$. If $\operatorname{supp}f\subset[A,B]$, then for $x>B$,

$$
h(x)=e^{-x/2}\int e^{u/2}f(u)\,du=0,
$$

and for $x<A$ the other vanishing moment gives $h(x)=0$. Also $h$ is smooth, and

$$
\operatorname{supp}h\subset[A,B],\qquad
\|h^{(j)}\|_\infty\le4\|f^{(j)}\|_\infty.
\tag{9}
$$

Set $g_p=B_p*h$. Equations (4), (8), and (9) now give

$$
\mathcal K_2g_2+\mathcal K_3g_3
=\mathcal L_0\bigl((k_2*B_2+k_3*B_3)*h\bigr)
=f.
$$

Each fixed compact distribution $B_p$ has finite order. Choose $R,m,C$ that bound both supports and distribution seminorms. Convolution with (9) proves (3). Averaging (8) with its conjugate and reflection gives real even $B_p$, if desired. Finally, $K_p(\pm i/2)=0$ proves the converse moment condition directly.

## What this changes for the scattering question

The two filters generate every compact smooth test satisfying the two pole cancellations. This removes a possible restriction of the test space to prime-filter images. It does not transfer positivity from two individual probes to their arbitrary sums. A Hermitian form evaluated at (2) still contains the mixed term

$$
2\operatorname{Re}\mathcal Q(\mathcal K_2g_2,\mathcal K_3g_3),
$$

whose sign or relative size is not controlled by the division theorem. The Bézout distributions are not required to be positive. Quantitative control of these mixed terms remains a separate arithmetic problem.

The [actual two-prime mixed-moment calculation](two-prime-mixed-scattering.md) illustrates why a mixed interaction must be retained, although that auxiliary moment is distinct from the Weil form in this generation theorem. The [semilocal foundation](semilocal-weighted-scattering.md) fixes the full Weil trace conventions.
