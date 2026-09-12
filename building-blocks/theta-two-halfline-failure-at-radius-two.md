# A concrete failure of the two-halfline comparison at radius two

This is a written proof for the actual theta form, with no Lean claim. It uses the [complete ground covariance clock](theta-complete-ground-covariance-clock.md), its [weighted source domain](theta-groundstate-bounded-weighted-crossing.md), and the original [theta Weil form and score identities](theta-weil-jump-form.md). The method uses classical closed-form comparison, scalar optimization and the indicated exact theta/arithmetic identities; no priority claim is made.

The failed lower comparison is a sufficient test, not the exact constrained form. The [true affine score calibration](theta-true-affine-odd-score-calibration.md) retains the complete Green covariances. The [full continuous-only failure](theta-full-continuous-comparison-failure.md) is stronger than failure of a same-half-line minorant.

For the actual core $C=[-2,2]$, the actual odd score $x=(\Phi'/\Phi)1_C$, and the full affine two-halfline covariance majorant $U_h$, this note proves
$$
\boxed{\quad
E_C[x]-\alpha_2\|x\|_\nu^2
-\operatorname{Cost}_{U_h}(B_2x,\langle x,\tau\rangle_\nu)
<-\frac1{10}.
\quad}
\tag{1}
$$
This is failure of that sufficient lower comparison. It is not a negative value of the exact constrained form $F_{\alpha_2}$, and it does not contradict RH. The test is nonconstant and odd, hence centered for the actual even boundary-arrival probability. Its nonzero affine score is retained.

The proof uses the exact sign-commutator calculation and finite-core inequality in [theta-two-halfline-odd-score-failure.md](theta-two-halfline-odd-score-failure.md). All numerical bounds below are deliberately loose elementary inequalities. They require neither a computed ground state nor a finite prime approximation. No floating-point sample is used as a certificate.

## Complete theta envelopes

For $t\ge0$ put $y=\pi e^{2t}$. The complete theta series and its first derivative have summands
$$
\Phi_n(t)=e^{t/2-n^2y}Q_0(n^2y),\quad
\Phi_n'(t)=e^{t/2-n^2y}Q_1(n^2y),
$$
$$
Q_0(Y)=4Y^2-6Y,\qquad
Q_1(Y)=-8Y^3+30Y^2-15Y.
$$
For $Y\ge3$, $2Y^2\le Q_0(Y)\le4Y^2$ and $|Q_1(Y)|\le20Y^3$. Also
$$
\sum_{n\ge1}n^6e^{-3(n^2-1)}<2.
\tag{2}
$$
Indeed the first tail term is $64e^{-9}$, and successive tail terms have ratio at most $(3/2)^6e^{-15}<1/2$. Thus the tail is at most $128e^{-9}<1$. The same bound applies with $n^4$ and with any $y\ge3$ in place of 3.

Using $3<\pi<4$, the complete series therefore gives
$$
\begin{split}
\Phi(t)&\le128e^{9t/2}e^{-3e^{2t}},\\
|\Phi'(t)|&\le2560e^{13t/2}e^{-3e^{2t}},\\
|\sigma(t)|=|\Phi'(t)/\Phi(t)|&\le20y\le80e^{2t}.
\end{split}
\tag{3}
$$
The quotient estimate uses the positive first theta term to bound the denominator by $2e^{t/2}y^2e^{-y}$. No lower bound on the killed ground state is involved. Reflection gives the corresponding bounds for negative arguments.

Write $d\nu=b\Phi\,dt$, $b(t)=2\cosh(t/2)$. Since $b(t)\le2e^{t/2}$ for $t\ge0$,
$$
\frac{d\nu}{dt}\le256e^{5t}e^{-3e^{2t}}.
\tag{4}
$$
Consequently the full score norm obeys
$$
\begin{split}
\|\sigma\|_\nu^2
&\le 3276800\int_0^\infty e^{9t}e^{-3e^{2t}}\,dt\\
&=1638400\int_1^\infty v^{7/2}e^{-3v}\,dv
\le1638400\frac{4!}{3^5}<10^6.
\end{split}
\tag{5}
$$

The elementary inequalities $8/3<e<3$ imply
$$
e^4>50,\qquad e^{125}>10^{50},\qquad e^{150}>10^{60}.
\tag{6}
$$
For the last two, use $(8/3)^5>100$. For $v\ge50$, $v^4\le e^{v/2}$: this holds at 50 and the derivative of $v/2-4\log v$ is positive thereafter. Integrating (4)--(5) only over $|t|>2$ gives
$$
\|\sigma1_{O_2}\|_\nu^2
\le\frac{3276800}{5}e^{-125}<10^{-40},
\qquad
\nu(O_2)\le\frac{512}{5}e^{-125}<10^{-47}.
\tag{7}
$$
Moreover (3) and (6) give
$$
\Phi(2)\le128e^9e^{-3e^4}
<128\,3^9\,10^{-60}<10^{-52}.
\tag{8}
$$

## The complete prime norm and the exterior deficit

In physical Lebesgue coordinates put $\omega=\sqrt{\Phi/b}$. The envelope in (3) decreases on $[0,\infty)$, and yields
$$
\|\omega\|_\infty<3,\qquad
\|1_{O_2}\omega\|_\infty<10^{-26},
\qquad
\omega(t)\le8e^{9|t|/4}e^{-3e^{2|t|}/2}.
\tag{9}
$$
For example $\Phi(t)\le128e^{-3}<16$, so $\omega^2<8$; (8) bounds the exterior supremum. The final envelope is decreasing for $|t|\ge0$.

The actual prime operator has shift coefficients
$\Lambda(n)n^{-1/2}\omega(u)\omega(u\pm\log n)$. In the difference $K_p-P_CK_pP_C$, at least one endpoint is outside the core. Sum the norm bounds of all shifts and both orientations. For $2\le n\le100$, use $\Lambda(n)\le\log n<5$, $n^{-1/2}\le1$, and (9), giving a contribution at most
$$
2\cdot100\cdot5\cdot3\cdot10^{-26}=3\cdot10^{-23}.
\tag{10}
$$
For every $n>100$, at least one endpoint has absolute value at least $(\log n)/2$. The last bound in (9) gives the complete remaining contribution at most
$$
48\sum_{n>100}\log n\,n^{5/8}e^{-3n/2}
\le48\sum_{n>100}e^{-5n/4}
\le96e^{-125}<10^{-48}.
\tag{11}
$$
Here $\log n\,n^{5/8}\le n^2\le e^{n/4}$ for $n\ge100$, and the geometric tail denominator exceeds $1/2$. All proper powers are included in the sum; replacing $\Lambda(n)$ by $\log n$ is an upper bound over all integers, not a discarded arithmetic tail.

Thus one may take $\Gamma_2<10^{-21}$ in the actual physical prime-tail norm bound. The established hard crossing and exterior form inequalities are
$$
\|B_2\|\le2\pi\|\omega\|_\infty
                  \|1_{O_2}\omega\|_\infty+\Gamma_2,
\qquad
\alpha_2\ge\lambda-\delta_2,
\quad\delta_2=|a_0|\|1_{O_2}\omega\|_\infty^2+\Gamma_2.
$$
The constant $a_0=\psi_{\rm digamma}(1/4)-\log\pi$ has $|a_0|<10$. One can bound this directly from
$\psi_{\rm digamma}(z)=-\gamma_E-1/z+\sum_{n\ge1}z/[n(n+z)]$, $0<\gamma_E<1$, and the already established $a_0<0$. We therefore have the explicit ample bounds
$$
\boxed{\quad \|B_2\|<10^{-20},\qquad \delta_2<10^{-20}.\quad}
\tag{12}
$$
These estimates retain the continuous Carleman crossing and the exact prime--archimedean exterior cancellation from the public theta form. They do not replace the exterior form by a prime-only generator.

## The cross-halfline score arrival and the exact affine score

The full elementary Chebyshev bound $\psi_{\rm Ch}(X)\le4X$ is sufficient here. For completeness,
$\psi_{
\rm Ch}(2n)-\psi_{\rm Ch}(n)\le\log\binom{2n}{n}\le2n\log2$: every prime-power level in $(n,2n]$ contributes one to the central binomial valuation, and all other valuation contributions are nonnegative. Sum this at powers of two and enlarge to the next power of two. The result is $\psi_{\rm Ch}(X)<4X\log2<4X$ for $X>1$.

Let $K_\times$ contain all arrivals between the two exterior halves, and let
$\epsilon_2=\|K_\times(|\sigma|1_{O_2})\|_\infty$. The previously proved positive rate estimate is
$$
\epsilon_2\le
\frac{e^{-2}}{1-e^{-8}}\int_2^\infty e^{-t/2}|\Phi'(t)|\,dt
+4e\sum_{j\ge2}e^{j/2}\sup_{j\le t\le j+1}|\Phi'(t)|.
\tag{13}
$$
For the first term, (3) and the same substitution as in (7) give an integral at most $512e^{-125}<10^{-47}$; its displayed prefactor is less than one. For the series, the derivative envelope in (3) is decreasing for $t\ge2$, so
$$
\sum_{j\ge2}e^{j/2}\sup_{[j,j+1]}|\Phi'|
\le2560\sum_{j\ge2}e^{7j}e^{-3e^{2j}}
\le5120e^{14}e^{-3e^4}<4\cdot10^{-50}.
$$
Successive terms have ratio at most $3^7e^{-900}<1/2$, which justifies the factor two. Since $4e<12$,
$$
\boxed{\quad \epsilon_2<10^{-40}.\quad}
\tag{14}
$$
This is a uniform bound in the exterior starting point. Every prime power and the continuous opposite-half arrival remain.

For $m_2=\langle\sigma1_C,\tau\rangle_\nu$, the exact integration-by-parts identity is
$$
m_2=4\sinh(1)\Phi(2)-\frac12\nu(C).
$$
Using (7)--(8) and $4\sinh1<6$,
$$
-\frac12\le m_2\le-\frac12+10^{-40}<0,
\qquad |m_2|\le\frac12.
\tag{15}
$$

## Insert the bounds into the signed comparison

The exact score identity is $E(\sigma)-\lambda\|\sigma\|^2=\lambda/4$, with $\lambda=1/2$. The nonnegative exterior energy, the hard split, and (12) bound the baseline by
$$
E_C[x]-\alpha_2\|x\|^2
\le\frac18+\frac12\|\sigma1_{O_2}\|^2
+\delta_2\|x\|^2+2\|B_2\|\|x\|\|\sigma1_{O_2}\|
<\frac18+2\cdot10^{-14}.
\tag{16}
$$
The exact sign commutator from the companion proof gives
$$
\frac{\ell(B_2x)}{\ell(q)}
\ge\frac14-\frac{2\epsilon_2}{\tanh1}.
$$
The affine majorant satisfies
$\operatorname{Cost}_{U_h}(f,m)\ge-2m\ell(f)/\ell(q)-m^2/\ell(q)^2$,
with $\ell(q)\ge e^2-1>6$. Since $\tanh1>1/2$, (14)--(16) give
$$
\begin{split}
E_C[x]-\alpha_2\|x\|^2-\operatorname{Cost}_{U_h}(B_2x,m_2)
&\le\frac18+2\cdot10^{-14}
 +2m_2\left(\frac14-4\cdot10^{-40}\right)+\frac1{144}\\
&<-\frac{17}{144}+3\cdot10^{-14}
<-\frac1{10}.
\end{split}
\tag{17}
$$
This proves (1) at the explicit radius two. No ground eigenfunction moments had to be estimated: the exact sign commutator has a nonnegative ground-weighted score term, while its opposing term is bounded by (13).

The same-halfline comparison therefore cannot certify the full core sign, even on this fixed actual input. A repair must use additional parts of the complete covariance, in particular the response that the unpenalized odd sign potential misses. The positive bridge comparison, the full prime histories, and the exact covariance itself are separate stronger constructions; this counterexample does not declare them insufficient.
