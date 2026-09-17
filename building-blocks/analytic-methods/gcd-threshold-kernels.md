# Gcd threshold kernels and signed divisor squares

The kernel that records whether two integers share at least two distinct prime divisors is pointwise nonnegative but need not be positive semidefinite. Its incidence factorization gives an exact signed sum of squared divisor responses. It also classifies every universally positive semidefinite completion obtained by assigning fixed weights to the zero-, one- and multiple-common-prime levels.

These are finite algebraic statements. They give no prime-error estimate or conclusion about the Riemann hypothesis, and no Lean formalization is asserted.

## Incidence factorization

Write $\omega(n)$ for the number of distinct prime divisors of $n$, with $\omega(1)=0$, and $\mu$ for the Möbius function. For a real arithmetic function $f$, put

$$
b_f(d)=(f*\mu)(d)=\sum_{e\mid d}f(e)\mu(d/e).
$$

Let $S$ be a finite set of positive integers and let $\mathcal D$ be the set of all positive divisors of elements of $S$. Möbius inversion gives

$$
f(\gcd(k,l))=\sum_{d\mid k,\ d\mid l}b_f(d),\qquad k,l\in S.
\tag{1}
$$

Indeed, summing the definition of $b_f$ over divisors of $m$ gives

$$
\sum_{d\mid m}b_f(d)
=\sum_{e\mid m}f(e)\sum_{v\mid m/e}\mu(v)=f(m).
$$

Define the incidence matrix $E$ by $E_{k,d}=\mathbf1_{d\mid k}$. Equation (1) is the matrix factorization

$$
\bigl(f(\gcd(k,l))\bigr)_{k,l\in S}
=E\,\operatorname{diag}(b_f(d):d\in\mathcal D)\,E^{\mathsf T}.
\tag{2}
$$

This is the classical meet-matrix factorization specialized to divisibility; see [Mattila and Haukkanen, *On the positive definiteness and eigenvalues of meet and join matrices*, equation (2.10)](https://arxiv.org/pdf/1209.4287).

**Positivity criterion.** The kernel $f(\gcd(k,l))$ is positive semidefinite on every finite set of positive integers if and only if $b_f(d)\ge0$ for every $d$.

Nonnegative coefficients make (2) positive semidefinite. Conversely, fix $d$ and take $S$ to be all divisors of $d$. Then $\mathcal D=S$, and $E$, ordered by increasing integers, is lower triangular with diagonal entries 1. Congruence by its inverse shows that every diagonal entry $b_f(e)$, including $b_f(d)$, must be nonnegative. This proves the criterion. It concerns all finite sets; negative coefficients outside a particular sparse set do not alone decide that set's positivity.

## The threshold at two common primes

Set

$$
f_2(m)=\mathbf1_{\omega(m)\ge2},\qquad
K_2(k,l)=f_2(\gcd(k,l)).
$$

**Theorem.** Its incidence coefficients are

$$
\boxed{
 b_2(d)=
 \begin{cases}
 (-1)^j(j-1),&d\text{ squarefree and }j=\omega(d)\ge2,\\
 0,&\text{otherwise}.
 \end{cases}}
\tag{3}
$$

To prove this, first suppose $p^a\mid d$ with $a\ge2$. In the convolution defining $b_2(d)$, a nonzero Möbius factor permits only exponents $a$ and $a-1$ of $p$ in $e$. These two possibilities give the same value of $f_2(e)$ and opposite Möbius signs. Pairing them proves $b_2(d)=0$.

For squarefree $d$ with $j$ prime divisors, group its divisors by their number of primes. If $j\ge2$,

$$
b_2(d)=\sum_{i=2}^j\binom ji(-1)^{j-i}
=-\bigl((-1)^j+j(-1)^{j-1}\bigr)
=(-1)^j(j-1).
$$

For $j=0,1$ the sum is empty and equals zero. This proves (3).

Let $u_k$, $k\in S$, be vectors in a real or complex Hilbert space, and define

$$
U_d=\sum_{\substack{k\in S\\d\mid k}}u_k,\qquad d\in\mathcal D.
$$

Expanding the squared norms in (2) gives the exact signed identity

$$
\boxed{
\sum_{k,l\in S}K_2(k,l)\langle u_k,u_l\rangle
=\sum_{\substack{d\in\mathcal D\text{ squarefree}\\\omega(d)\ge2}}
\mu(d)(\omega(d)-1)\|U_d\|^2.}
\tag{4}
$$

Both sides are real. All sums are finite, and the left side includes the diagonal. For the ordered off-diagonal sum, the corresponding formula is

$$
\sum_{\substack{k,l\in S\\k\ne l}}K_2(k,l)\langle u_k,u_l\rangle
=\sum_{d\in\mathcal D}b_2(d)
\left(\|U_d\|^2-\sum_{\substack{k\in S\\d\mid k}}\|u_k\|^2\right).
\tag{5}
$$

For example, (4) can be applied directly to vector-valued functions in an $L^2$ space: their inner products are the corresponding integrated time kernels. It preserves the negative divisor coefficients rather than replacing the time kernel.

If every element of $S$ has at most two distinct prime divisors, (3) has only nonnegative coefficients on $\mathcal D$, so $K_2$ is positive semidefinite on $S$. Repeated prime powers do not affect this conclusion.

A third prime permits failure. On $S=\{6,10,30\}$,

$$
K_2=
\begin{pmatrix}
1&0&1\\
0&1&1\\
1&1&1
\end{pmatrix},\qquad
\det K_2=-1.
$$

The vector $(1,1,-1)$ has quadratic value $-1$. In (4), its only nonzero contributions are $\|U_{15}\|^2=1$ with coefficient 1 and $\|U_{30}\|^2=1$ with coefficient $-2$. The divisor 15 must be included even though it is not a member of $S$.

## Classification of fixed level completions

**Theorem.** For fixed real numbers $A,B,C$, define

$$
K_{A,B,C}(k,l)=
A\mathbf1_{\omega(\gcd(k,l))=0}
+B\mathbf1_{\omega(\gcd(k,l))=1}
+C\mathbf1_{\omega(\gcd(k,l))\ge2}.
$$

This kernel is positive semidefinite on every finite set of positive integers if and only if

$$
\boxed{A=B=C\ge0.}
\tag{6}
$$

The arithmetic function defining this kernel depends only on the set of prime divisors. The same pairing argument used in (3) makes its Möbius coefficient zero at every nonsquarefree integer. At 1 the coefficient is $A$. At a squarefree integer with $j\ge1$ prime divisors it is

$$
\begin{aligned}
&A(-1)^j+Bj(-1)^{j-1}
+C\sum_{i=2}^j\binom ji(-1)^{j-i}\\
&\hspace{2em}=(-1)^j\bigl[(A-C)+(C-B)j\bigr].
\end{aligned}
\tag{7}
$$

There are squarefree integers with arbitrarily many prime divisors. By the positivity criterion, (7) must be nonnegative for every $j\ge1$. If $C-B>0$, its bracket is positive for all sufficiently large odd $j$, contradicting the required sign. If $C-B<0$, sufficiently large even $j$ give a contradiction. Hence $C=B$. Alternating parity then forces $A=C$, and the coefficient at 1 requires $A\ge0$. Conversely, these conditions give the constant kernel $A$, whose quadratic form is $A|\sum_k z_k|^2\ge0$.

Thus a universally positive semidefinite repair using only three fixed level weights is necessarily constant. This classification does not concern coefficients depending on the individual times, valuations or other arithmetic data. It also does not preclude cancellation between a signed kernel and other terms in a larger expression.

## Comparison with the Selberg quadratic form

For finitely supported complex coefficients $\lambda_d$, the Selberg-type identity is

$$
\sum_{d,e}\frac{\lambda_d\overline{\lambda_e}}{\operatorname{lcm}(d,e)}
=\sum_r\varphi(r)
\left|\sum_{r\mid d}\frac{\lambda_d}{d}\right|^2.
\tag{8}
$$

To prove it, use

$$
\frac1{\operatorname{lcm}(d,e)}
=\frac{\gcd(d,e)}{de}
=\frac1{de}\sum_{r\mid d,\ r\mid e}\varphi(r),
$$

and rearrange the finite sums. The coefficients $\varphi(r)$ are nonnegative. The elementary identity $\sum_{r\mid m}\varphi(r)=m$ follows by grouping $1\le a\le m$ according to $m/\gcd(a,m)$.

[Green and Tao, *Restriction theory of the Selberg sieve, with applications*, §7, equations (7.11)–(7.14)](https://arxiv.org/pdf/math/0405581) give the related primary sieve construction: square a divisor expression, group by least common multiples and use multiplicative local densities. Equation (8) states the elementary reciprocal-lcm case explicitly.

The contrast with (4) is exact. The threshold kernel has alternating incidence coefficients, including $b_2(30)=-2$, whereas (8) has nonnegative coefficients. Pointwise nonnegativity or lcm grouping alone therefore cannot justify importing the Selberg positive-square bound into the threshold form. A comparison must retain the actual kernel and its coefficient signs, or prove a separate quadratic-form inequality.

The incidence factorization and the sieve method are classical. The threshold coefficients, finite example and fixed-level classification above are explicit specializations proved here; no originality claim is made.
