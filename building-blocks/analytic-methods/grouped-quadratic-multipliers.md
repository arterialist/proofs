# Grouping a conjugate pair with real factors

A quadratic whose values do not form a multiplier sequence can acquire that property after multiplication by suitable real linear factors. The following sufficient condition follows from classical Laguerre polynomial recurrences and a positive definite Jacobi matrix. Applying it to the actual theta Mellin function requires suitable actual real zeros; their existence in the necessary groups remains unproved.

## Sufficient condition

Let $A,B,C>0$, let $m$ be a nonnegative integer, and use the rising factorial

$$
(n+C)_m=\prod_{j=0}^{m-1}(n+C+j).
$$

Define

$$
q(n)=\left((n+A)^2+B^2\right)(n+C)_m,
$$

$$
\beta=(m+1)(m+C)-(A-C-m)^2-B^2.
$$

**Theorem.** If $\beta\ge0$, then $\{q(n)\}_{n\ge0}$ is a classical multiplier sequence.

## Proof

Put

$$
P_m(z)=m!L_m^{C-1}(-z),\qquad \theta=z\frac{d}{dz}.
$$

The exponential generating function of $(n+C)_m$ is $e^zP_m(z)$. Consequently the generating function of $q$ is $e^zR(z)$, where

$$
R(z)=\left((\theta+z+A)^2+B^2\right)P_m(z).
$$

The Laguerre differential equation and recurrences give

$$
zP_m''+(C+z)P_m'-mP_m=0,
$$

$$
zP_m'=mP_m-m(m+C-1)P_{m-1},
$$

$$
P_{m+1}=(z+2m+C)P_m-m(m+C-1)P_{m-1}.
$$

Substitution yields the exact identity

$$
R(z)=(z+d_0)P_{m+1}(z)-\beta P_m(z),
\qquad d_0=2A+1-C.
$$

For $m=0$ the same identity follows directly from $P_0=1$ and $P_1=z+C$.

Write $p_j(x)=(-1)^jP_j(-x)$, the monic Laguerre polynomials. Then

$$
(-1)^{m+2}R(-x)=(x-d_0)p_{m+1}(x)-\beta p_m(x).
$$

This is the characteristic polynomial of the real symmetric tridiagonal matrix with diagonal

$$
C,\ C+2,\ \ldots,\ C+2m,\ d_0
$$

and squared off-diagonal entries

$$
j(j+C-1)\quad(1\le j\le m),\qquad \beta.
$$

The leading Laguerre block is positive definite: its successive leading determinants are $(C)_j>0$. Its last inverse diagonal entry is $1/(C+m)$. The Schur complement for the final row is

$$
d_0-\frac{\beta}{C+m}
=\frac{A^2+B^2}{C+m}>0.
$$

Thus the full matrix is positive definite, including when $\beta=0$. Every zero of $R$ is strictly negative. The Pólya–Schur theorem applied to $e^zR(z)$ proves the claim.

## Two useful parameter choices

For the centered progression

$$
C=A-\frac{m-1}{2}>0,
$$

the sufficient condition becomes

$$
B^2\le(m+1)A+\frac{(m+1)^2}{4}.
$$

At $m=0$ this recovers the individual quadratic condition $B^2\le A+1/4$.

Alternatively, $C=A$ gives

$$
B^2\le m(A+1)+A.
$$

Therefore, for any fixed $A,B>0$, sufficiently many real factors in this precise progression make the quadratic admissible. This statement does not supply those factors for a particular entire function.

## An explicit example

Take $A=1$, $B=2$, $C=1/2$, and $m=2$. The quadratic alone fails: its coefficientwise action sends $(1+x)^2$ to

$$
5+16x+13x^2,
$$

whose discriminant is $-4$.

In contrast, define the normalized polynomial

$$
L(z)=\frac{(2z+1)(2z+3)((z+1)^2+4)}{15}.
$$

Its values have exponential generating function

$$
\sum_{n=0}^\infty L(n)\frac{x^n}{n!}
=\frac{e^x}{15}
\left(15+105x+115x^2+40x^3+4x^4\right).
$$

Here $\beta=5/4$. The Jacobi matrix has diagonal
$(1/2,5/2,9/2,5/2)$ and squared off-diagonal entries $(1/2,3,5/4)$.
Its leading determinants are $1/2,3/4,15/8,15/4$, all positive.
Thus $\{L(n)\}$ is a multiplier sequence although $L$ itself has a nonreal pair that violates the individual quadratic condition.

This also illustrates why a multiplier sequence and a complex-zero-decreasing sequence are different notions. The theorem claims preservation of real-rootedness, not the stronger general decrease of nonreal zeros.

## What an actual entire-function application would require

For a real entire function of order at most one, a finite collection of canonical factors differs from its corresponding real polynomial factors by a positive constant and a geometric factor when sampled at nonnegative integers. These factors preserve the multiplier property.

If all zeros could be partitioned, with multiplicity and without reuse, into admissible groups, and the resulting canonical products converged with the required normalization, finite products and coefficientwise limits would yield a multiplier sequence. The remaining real zeros and the exponential factor must also be accounted for.

For the actual theta Mellin function, the [certified violating pair](../theta-and-heat/theta-mellin-parabola-obstruction.md) makes such grouping relevant. The required actual zero partition and convergence argument have not been established. This theorem is not a factorization of that function or a proof of RH.

## Attribution

The proof uses classical [Laguerre recurrences](https://dlmf.nist.gov/18.9), the [Laguerre differential equation](https://dlmf.nist.gov/18.8), and the Pólya–Schur theory summarized by Craven and Csordas in [*Problems and theorems in the theory of multiplier sequences*](https://math.hawaii.edu/~tom/mathfiles/serdica1.pdf), Sections 2–3. Their Proposition 3.5 already studies a conjugate quadratic multiplied by one real linear factor and supplies its cubic discriminant criterion. The present note gives a Jacobi-matrix sufficient condition for a rising-factorial group; no priority claim is made for this specialized condition.
