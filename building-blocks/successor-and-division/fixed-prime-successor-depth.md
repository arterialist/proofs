# Fixed-prime depths along the successor path

For a fixed finite set of primes, the normalized prime-power depths at fixed integer offsets have an exact cluster set. Each prime can occupy at most one offset to positive limiting depth, and the total depth is at most one. Chinese remaindering attains every permitted vector, including the boundary. An infinite-offset extension identifies the exact scale of uniform observation horizons.

These are written consequences of the classical smooth-part theorem and CRT. The finite CRT and divisibility tools are already formalized in the linked Lean modules; the analytic cluster-set and horizon theorems below are not formalized. No priority or RH claim is made.

## The fixed-offset cluster set

Let $S$ be a fixed finite set of primes and let $h_1,\ldots,h_k$ be distinct fixed integers, with $k\ge1$. For sufficiently large positive integers $n$, define

$$
a_{p,i}(n)=\frac{v_p(n+h_i)\log p}{\log n}.
$$

The set of subsequential limits of these vectors is exactly

$$
\mathcal A=\left\{(a_{p,i}):\ a_{p,i}\ge0,\quad
\sum_{p\in S}\sum_{i=1}^k a_{p,i}\le1,\quad
\#\{i:a_{p,i}>0\}\le1\text{ for each }p\right\}.
\tag{1}
$$

To prove the upper inclusion, the elementary divisibility relation

$$
\min\{v_p(n+h_i),v_p(n+h_j)\}\le v_p(h_i-h_j)
\qquad(i\ne j)
\tag{2}
$$

excludes two positive limiting coordinates at the same prime. The remaining input is Luca–Pollack's smooth-part theorem: for a fixed polynomial with simple roots and a fixed smoothness bound, its smooth part at $n$ exceeds $n^{1+\varepsilon}$ only finitely often. Apply it to $F(T)=\prod_i(T+h_i)$ and a bound containing $S$. It gives

$$
\sum_{p\in S}\sum_i v_p(n+h_i)\log p\le(1+\varepsilon)\log n
\tag{3}
$$

for all sufficiently large $n$. Letting $\varepsilon\downarrow0$ proves the total-budget condition. The threshold depends on the fixed primes, offsets and $\varepsilon$; the subspace-theorem argument does not make it effective. [Luca and Pollack, *How many primes can divide the values of a polynomial?*, Lemma 1, pages 6–8](https://www.pollack-math.net/primenote.pdf).

The finite overlap in (2) can be retained exactly. Set

$$
U_S(n)=\prod_{p\in S}p^{\sum_i v_p(n+h_i)},\qquad
M_p=\max_i v_p(n+h_i),\qquad
B_S=\prod_{p\in S}p^{\max_i\sum_{j\ne i}v_p(h_i-h_j)}.
$$

Then

$$
U_S(n)=\left(\prod_{p\in S}p^{M_p}\right)C(n),\qquad C(n)\mid B_S.
\tag{4}
$$

Choose a maximizing index $i$ for each $p$. Equation (2) bounds every other valuation by $v_p(h_i-h_j)$, which proves (4). More precisely, put $D_p=\max_{i\ne j}v_p(h_i-h_j)$, with $D_p=0$ when $k=1$. If $M_p>D_p$, the maximizing index is unique and

$$
v_p(n+h_j)=v_p(h_i-h_j)\qquad(j\ne i).
\tag{5}
$$

This follows from the unequal-valuation rule applied to $(n+h_i)+(h_j-h_i)$.

## Effective attainment, including the boundary

Fix a vector in (1). For every active prime, write its unique positive coordinate as $\alpha_p=a_{p,i_p}$, and set $A=\sum_p\alpha_p\le1$. At a real scale $X>1$, prescribe

$$
b_p=\left\lfloor\frac{\alpha_p\log X}{\log p}\right\rfloor,
\qquad n\equiv-h_{i_p}+p^{b_p}\pmod{p^{b_p+1}}.
\tag{6}
$$

Once $b_p>D_p$, this gives exactly $v_p(n+h_{i_p})=b_p$ and the fixed other valuations in (5). At each inactive prime choose a fixed $c_p$ with $p^{c_p}>k$, and choose a residue modulo $p^{c_p}$ avoiding all $-h_i$. All its valuations are then at most $c_p-1$. The classical Chinese remainder theorem produces one residue class modulo

$$
Q_X\le C X^A,\qquad
C=\prod_{\alpha_p>0}p\prod_{\alpha_p=0}p^{c_p}.
\tag{7}
$$

Choose its first representative $n_X\ge X$. Then $X\le n_X<X+Q_X$. For an active coordinate,

$$
0\le\alpha_p-\frac{b_p\log p}{\log n_X}
\le\frac{\log p+\alpha_p\log(1+C)}{\log X}.
\tag{8}
$$

Indeed $0\le\alpha_p\log X-b_p\log p<\log p$ and $n_X/X<1+C$, since $A\le1$. The other coordinates are bounded by constants divided by $\log X$. This proves convergence to the target with error $O_{S,h,a}(1/\log X)$. An explicit sufficient lower threshold for the active congruences is

$$
X\ge\max_{\alpha_p>0}p^{(D_p+1)/\alpha_p},
\tag{9}
$$

together with positivity of all shifted integers. If there are no active primes, the active maximum is omitted.

For $A<1$, every sufficiently large scale has a realizing integer within $CX^A$ of $X$. The same residue class has at least $C^{-1}X^{1-A}-1$ representatives in $[X,2X]$, all with the same limiting target and error $O_{S,h,a}(1/\log X)$. Thus the construction supplies more than one attaining subsequence.

For example, with offsets $0,2,6$, $n=592$ and $S=\{2,3\}$, the valuation rows are $(4,1,1)$ and $(0,3,0)$. Here $U_S=1728=4\cdot432$ and $B_S=24$. The finite overlap is real, and (3) cannot be strengthened to $U_S(n)\le n$ at every cutoff.

## All successor offsets and uniform horizons

Keep $S$ fixed, and now use offsets $j\in\mathbb N_0$. The exact pointwise cluster set is

$$
\left\{(a_{p,j}):\ a_{p,j}\ge0,\quad
\#\{j:a_{p,j}>0\}\le1\text{ for each }p,\quad
\sum_{p\in S}\sum_{j\ge0}a_{p,j}\le1\right\}.
\tag{10}
$$

Necessity follows by applying (1) to each finite window and then increasing the window. This uses no estimate uniform in its length.

For attainment, fix a target in (10), with active depth $\alpha_p$ at time $j_p$. Because $S$ is finite, there are only finitely many target event times. Choose any integer horizon satisfying

$$
J(X)\longrightarrow\infty,\qquad \log J(X)=o(\log X).
\tag{11}
$$

For each active prime use (6) with $h_{i_p}=j_p$. Eventually $J\ge\max j_p$ and $p^{b_p}>J$. Throughout the window the congruence therefore gives

$$
v_p(n+j_p)=b_p,\qquad
v_p(n+j)=v_p(j-j_p)\quad(0\le j\le J,\ j\ne j_p).
\tag{12}
$$

At each inactive prime choose $c_p$ minimal with $p^{c_p}>J+1$, and prescribe $n\equiv1\pmod{p^{c_p}}$. Then $v_p(n+j)=v_p(j+1)$ throughout the window. If $s_0$ is the number of inactive primes, the total modulus satisfies

$$
Q_X\le C X^A(J+1)^{s_0},\qquad C=\prod_{p\in S}p.
\tag{13}
$$

Its first representative above $X$ has

$$
\log n_X=\log X+O_S(1+\log J).
$$

The rounding estimate in (8), with this last error in place of $\log(1+C)$, handles each active coordinate. Every zero coordinate in (12) is at most $\log(J+1)/\log X$. Consequently

$$
\sup_{\substack{p\in S\\0\le j\le J(X)}}
\left|\frac{v_p(n_X+j)\log p}{\log n_X}-a_{p,j}\right|
=O_{S,a}\!\left(\frac{1+\log J(X)}{\log X}\right)\longrightarrow0.
\tag{14}
$$

If $A<1$, equation (13) still gives $n_X=X+o(X)$. For example, $J(X)=\lfloor e^{\sqrt{\log X}}\rfloor$ gives uniform error $O(1/\sqrt{\log X})$.

The subpolynomial restriction is necessary for vanishing uniform error when $S$ is nonempty. Fix $p\in S$ and let $L=J+1$. For sufficiently large $J$, every block of $L$ consecutive integers contains at least two multiples of

$$
p^{\lfloor\log_p(L/2)\rfloor}.
$$

At most one can occupy the target's positive coordinate. Some zero target coordinate therefore has normalized depth at least

$$
\frac{\log L-\log(2p)}{\log n}.
\tag{15}
$$

Thus uniform approximation along any $n\to\infty$ forces $\log J/\log n\to0$. Equations (11)–(14) attain exactly that scale. This conclusion does not extend the non-effective upper theorem uniformly to growing prime sets or growing windows.

## Formalized inputs and scope

[ExactPrimePowerCRT.lean](../../formalization/BuildingBlocks/ExactPrimePowerCRT.lean) proves `exists_exact_residue_class`, `exists_first_representative` and `exists_positive_exact_depths_above`. They supply the exact prescribed depth, complete modulus and first-representative interval used in (6)–(8). [LcmDifferenceProduct.lean](../../formalization/BuildingBlocks/LcmDifferenceProduct.lean) proves `prod_dvd_lcm_mul_differenceProduct`, a general finite overlap identity complementing (4). Their existing compilation and assumptions are recorded in the [finite arithmetic tools](../prime-distribution/finite-arithmetic-energy-tools.md); neither module formalizes the Luca–Pollack input or the complete statements (1), (10) and (14).

This classifies fixed-prime division depths along the actual successor path. It makes no assertion uniform in an increasing set of primes and gives no signed prime-error estimate.
