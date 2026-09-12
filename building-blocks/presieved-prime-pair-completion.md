# Presieving before positive matrix completion

This written proof constructs the matrix on residues allowed by a small-prime sieve before testing positivity. It preserves both a scalar obstruction and a finite nonuniform repair. No Lean theorem or RH conclusion is asserted. The Chinese remainder theorem, cyclic Fourier diagonalization and Schur completion are classical; Ramanujan’s [1918 paper, §2](https://ramanujan.sirinudi.org/Volumes/published/ram21.pdf) gives the residue sums and their Möbius identity. The actual complete-error consumer belongs to the [Haar energy decomposition](haar-prime-energy-completion.md).

There are two distinct outcomes. A masked Fourier vector gives an exact Ramanujan/CRT formula and a quantitative scalar-charge obstruction when $h\ge4W$. For primorial $W\ge30$ in that regime, the minimal scalar charge is at least $[\phi(W)/W]h^2/(8\pi^4)$. This is still too expensive on the actual prime-power weights. The proof does not exclude all adaptive sieves with $W$ comparable to or larger than $h$.

A nonuniform completion succeeds in a finite actual test where the best scalar completion fails. At $(X,h,W,q)=(64,16,6,96)$, exact rational matrices and enclosing logarithm balls prove a positive pair lower bound above 16.90, while the optimal scalar bound is below -61.02. That construction uses the known actual support and places large charges on zero-weight coordinates. It supplies no uniform arithmetic estimate. Both the success and its cost are explicit below.

## Kernel normalization

The literal cubic kernel is the convolution of four interval indicators,

$$
r=1_{[-1/4,1/4]}^{*4},\qquad
r(u)=\begin{cases}
1/12-u^2/2+|u|^3/2,&|u|\le1/2,\\
(1-|u|)^3/6,&1/2\le|u|\le1,\\
0,&|u|>1.
\end{cases}
$$

In the Fourier convention $\widehat r(\xi)=\int r(u)e^{-i\xi u}du$, this gives $\widehat r(\xi)=\tfrac1{16}[\sin(\xi/4)/(\xi/4)]^4$. Scaling proves the continuous version of (S9). Its numerator is $2\pi$-periodic when $4\mid h$, so Poisson summation gives exactly (S9). At zero, the removable value is $I_h$, while every nonzero alias vanishes. In particular the discrete row sum equals the integral $I_h$, rather than merely approaching it.

## 1. The restricted matrix and its exact completion

Let $h=2^k\ge8$, let $W$ be a squarefree even primorial, and let $q$ be a common multiple of $h$ and $W$ with $q\ge2h$. Retain the actual kernel

$$
R_h(d)=\frac h2[r(d/h)-r(2d/h)],\qquad
R_h\ge0,\quad R_h(0)=0,\quad \operatorname{supp}R_h\subset[-h,h],
\qquad I_h=\int R_h=h^2/64.
\tag{S1}
$$

Its integer-periodized kernel is $R_h^{(q)}(d)=\sum_{\ell\in\mathbb Z}R_h(d+\ell q)$. Put

$$
S=\{j\bmod q:(j,W)=1\},\quad
\rho=\phi(W)/W,\quad |S|=q\rho,\quad c=I_h/q,
$$

$$
\mathsf B=(R_h^{(q)}(j-k))_{j,k\in S}-c\mathbf1\mathbf1^*.
\tag{S2}
$$

This is an actual finite real symmetric matrix, with no assumption of translation invariance on S. Its minimal scalar completion is exactly

$$
\boxed{\lambda_* =\max(0,-\lambda_{\min}(\mathsf B)),\qquad
\mathsf B+\lambda_* I\succeq0.}
\tag{S3}
$$

Hence every real weight vector supported on S satisfies

$$
\boxed{\sum_{j,k\in S}a_ja_kR_h^{(q)}(j-k)
\ge cP_1^2-\lambda_*P_2,
\quad P_1=\sum a_j,\quad P_2=\sum a_j^2.}
\tag{S4}
$$

The diagonal of the kernel is zero, so the left side is the ordered distinct-pair energy. The density coefficient is exactly the prescribed $I_h$/q.

There is always a finite constructive upper bound $\lambda_*\le I_h$. On the full cyclic group, the constant Fourier eigenvalue of R is $I_h$, and all eigenvalues have absolute value at most $I_h$ because the entries are nonnegative with row sum $I_h$. Subtracting $c\mathbf1\mathbf1^*$ changes only that constant eigenvalue to zero. Its principal submatrix S2 therefore has minimum eigenvalue at least $-I_h$. Thus $\mathsf B+I_h I$ is one explicit completion, although it is generally expensive.

For an exact block construction, write $q=QW$ and $j=r+tW$, with r in the reduced residues modulo W. Translation by W gives $Q$ blocks of size $\phi(W)$:

$$
\mathsf B_\ell(r,s)=\sum_{v=0}^{Q-1}R_h^{(q)}(r-s+vW)e^{-2\pi i\ell v/Q}
-\mathbf1_{\ell=0}\,cQ,
\qquad 0\le\ell<Q.
\tag{S5}
$$

The spectrum of B is the union of these block spectra. This specifies the restricted matrix beyond a scalar or translation-invariant ansatz.

## 2. A masked bad vector and two exact arithmetic formulas

Let $\theta_*=4\pi/h$ and use the vector

$$
w_j=\mathbf1_{(j,W)=1}e^{i\theta_*j}\quad(j\bmod q).
$$

Its squared norm is $q\rho$. It has exactly zero sum. Indeed, the mask has period W, so summing over its Q periods kills this character unless $h/2$ divides $W$. For dyadic $h\ge8$, $h/2$ is divisible by four, whereas squarefree even W has only one factor of two. The exceptional divisibility is impossible. Thus the density subtraction in S2 has zero quadratic value on this vector, for every size of W.

Let $c_W(b)=\sum_{r\bmod W,\,(r,W)=1}e^{2\pi i br/W}$. Fourier expansion of the mask gives the exact Rayleigh quotient

$$
\boxed{\mathcal Q_{h,W}:=\frac{w^*\mathsf B w}{q\rho}
=\frac1{W\phi(W)}\sum_{b=0}^{W-1}c_W(b)^2
\mathscr R_h(\theta_*+2\pi b/W),}
\tag{S6}
$$

where $\mathscr R_h(\theta)=\sum_{d\in\mathbb Z}R_h(d)e^{-i\theta d}$. This is independent of the admissible choice of q. For squarefree W,

$$
c_W(b)=\mu(W/g)\phi(g),\qquad g=(W,b).
\tag{S7}
$$

The formula follows by multiplying the elementary local sums over each prime dividing W. The Fourier coefficients in S6 are squared Ramanujan coefficients, not assumed prime exponential-sum estimates.

There is an equivalent exact real-space formula. The Chinese remainder theorem gives

$$
\frac1W\#\{r\bmod W:(r,W)=(r-d,W)=1\}
=\prod_{p\mid W}\frac{p-\nu_p(d)}p,
\quad
\nu_p(d)=\begin{cases}1&p\mid d,\\2&p\nmid d.\end{cases}
$$

Consequently

$$
\boxed{\mathcal Q_{h,W}
=\sum_{d\in\mathbb Z}R_h(d)\cos(4\pi d/h)
\prod_{p\mid W}\frac{p-\nu_p(d)}{p-1}.}
\tag{S8}
$$

All odd differences vanish because 2 divides W. This formula implements the small-prime exclusions before positivity. It uses exact congruence counts rather than a model for actual prime pairs. Since $\lambda_*\ge-\mathcal Q_{h,W}$, a negative value is an obstruction for every scalar completion of this restricted matrix.

## 3. A quantitative regime where the scalar charge remains large

The earlier exact Fourier calculation, with h divisible by four, gives

$$
\mathscr R_h(\theta)=\frac{64}{h^2}
\sin^4(h\theta/8)\{2\cos^4(h\theta/8)-1\}
\sum_{l\in\mathbb Z}(\theta+2\pi l)^{-4}.
\tag{S9}
$$

At $\theta_*$ this is $-D_h$, with $D_h\ge h^2/(4\pi^4)$. The $b=0$ term in S6 is therefore at most $-\rho h^2/(4\pi^4)$.

Suppose now $h\ge4W$. For $1\le b<W$ put $b_*=\min(b,W-b)$. The distance of $\theta_*+2\pi b/W$ from $2\pi\mathbb Z$ is at least $\pi b_*/W$. If a nonzero angle has distance $\delta\le\pi$ from 2pi Z, then

$$
\sum_l(\theta+2\pi l)^{-4}\le3\delta^{-4}.
$$

One proof bounds the nearest term by $\delta^{-4}$, and the two remaining tails by the odd and even reciprocal fourth powers, whose sum is $\zeta(4)<2$. Formula S9 therefore bounds each nonzero-b alias in absolute value by $192W^4/(\pi^4h^2b_*^4)$.

The squared Ramanujan weights have a useful summable bound. Since $c_W(b)^2\le\gcd(W,b)^2$,

$$
\sum_{b\ge1}\frac{c_W(b)^2}{b^4}
\le\zeta(4)\sum_{d\mid W}d^{-2}
\le\zeta(4)\prod_p(1+p^{-2})=\zeta(2).
$$

The first inequality follows by majorizing $\gcd(W,b)^2$ by $\sum_{d\mid W,\,d\mid b}d^2$. Reflection $b$ to $W-b$ consequently gives $\sum_{b=1}^{W-1}c_W(b)^2/b_*^4\le2\zeta(2)=\pi^2/3$. Combining these facts proves the explicit estimate

$$
\boxed{\lambda_*\ge
\rho\frac{h^2}{4\pi^4}-\frac{64W^2}{\pi^2\rho h^2},
\qquad h\ge4W.}
\tag{S10}
$$

For fixed W this is $\rho h^2/(4\pi^4)+o(h^2)$ as a lower bound. It also provides a uniform growing-W regime. The ratio of the displayed error to its main lower bound is at most $\pi^2/\phi(W)^2$ when $h\ge4W$. Every primorial $W\ge30$ has $\phi(W)\ge8$. Thus

$$
\boxed{\lambda_*\ge\frac{\rho h^2}{8\pi^4}
\quad\text{if }W\ge30\text{ is primorial and }h\ge4W.}
\tag{S11}
$$

This verifies the proposed obstruction in an explicit regime, including $W=o(h)$. The smaller fixed primorials are also covered asymptotically by S10. No conclusion for every adaptive W follows by taking an asymptotic with W fixed.

For comparison with $O(h\log^C h)$, the adopted quantitative PNT implies $\rho$ is comparable to $1/\log\log W$ as W tends through primorials. Only that coarse comparability is needed here. A derivation from the existing baseline is short: partial summation of $\pi(t)-\operatorname{Li}_2(t)$ shows $\sum_{p\le z}1/p=\log\log z+O(1)$, the higher powers in $\log\prod_{p\le z}(1-1/p)$ have bounded total, and $\log W=\vartheta(z)$ is asymptotic to z. Therefore S11 is much larger than $O(h\log^C h)$ for any fixed C, throughout its regime. This uses no unproved AP or prime-pair estimate.

## 4. Exact tests beyond the separated-alias regime

The real-space formula S8 also permits checks where W is larger than h. At $h=8$ and $h=16$, only rational cosine values remain after parity removes odd differences. Exact evaluation gives

$$
\mathcal Q_{8,2}=-1/6,\qquad \mathcal Q_{16,2}=-1/3.
$$

For every primorial $W\ge6$, including arbitrarily large W,

$$
\boxed{\mathcal Q_{8,W}=-\frac3{32}
\prod_{\substack{p\mid W\\p\ge5}}\frac{p-2}{p-1},\qquad
\mathcal Q_{16,W}=-\frac3{16}
\prod_{\substack{p\mid W\\p\ge5}}\frac{p-2}{p-1}.}
\tag{S12}
$$

For example, $\mathcal Q_{8,30}=-9/128$ and $\mathcal Q_{16,210}=-15/128$. To derive S12 directly, at $h=8$ the relevant even differences are 2,4,6. At $h=16$ the nonzero cosine terms occur at 4,8,12. Prime 3 changes only the last of each list, and every prime at least 5 contributes the displayed common factor. The exact certificate checks these formulas using exact fractions for $W=2,6,30,210,2310$.

These tests show that crossing $W=h$ does not automatically remove the bad mode. They do not supply a uniform lower bound for all growing h and all larger primorials W. In that region several Fourier aliases can approach the low-frequency band; S10's separated-alias proof does not apply. Formula S8 leaves the exact weighted congruence expression that a larger-sieve repair must change or estimate.

A separate cost appears in the chosen period. Since h is dyadic and W squarefree even,

$$
\operatorname{lcm}(h,W)=hW/2,\qquad q\ge hW/2.
\tag{S13}
$$

If h is comparable to X and W grows, q grows relative to X. Retaining $c=I_h/q$ then reduces the positive bulk term itself. A smaller matrix eigenvalue cannot be credited as a repair without also evaluating this density loss.

## 5. Actual prime powers, the nonwrap condition, and scalar failure

Let $X\ge h$ be an integer and use the actual weights $\Lambda(n)$ for $X<n\le2X$. Choose

$$
q=\operatorname{lcm}(h,W)
\left\lceil\frac{X+2h}{\operatorname{lcm}(h,W)}\right\rceil.
\tag{S14}
$$

Place each weight at its actual residue $n$ modulo $q$: $a_j$ is the sum of $\Lambda(n)$ over $X<n\le2X$ with n congruent to j modulo q, restricted to j in S. There is at most one such n. In particular, $a_j$ is not $\Lambda(j)$ evaluated at a residue representative. Because W divides q, its allowed/excluded status is unchanged. Distinct integers in the interval have difference at most $X-1$; every nontrivial wrapped distance is greater than h. Thus $R_h^{(q)}(n-m)=R_h(n-m)$ for every pair under consideration, even if the chosen cyclic origin falls inside the interval. No wrapped pair is added.

Split the actual weights into A, with $\gcd(n,W)=1$, and E, with prime base $p$ dividing $W$. For each such prime, at most one power $p^k$ lies in $(X,2X]$. Define

$$
E_1=\sum_{p\mid W}\log p\left(
\left\lfloor\frac{\log(2X)}{\log p}\right\rfloor-
\left\lfloor\frac{\log X}{\log p}\right\rfloor\right),
\quad E_2=\sum_{n\in E}\Lambda(n)^2.
$$

Then $E_1\le\log W$ and $E_2\le\log(p_{\max})\log W$. Write $P_A=P-E_1$ and $P_{2,A}=P_2-E_2$. All higher powers on primes not dividing W stay in A. With ordered cross-pair notation,

$$
T_h=T_{AA}+2T_{AE}+T_{EE},\qquad
T_h\ge T_{AA}\ge cP_A^2-\lambda_*P_{2,A}.
\tag{S15}
$$

The retained exceptional terms are nonnegative and satisfy the explicit estimate

$$
0\le2T_{AE}+T_{EE}
\le\frac h{12}P_AE_1+\frac h{24}(E_1^2-E_2),
\tag{S16}
$$

since $R_h\le h/24$. The change from $cP_A^2$ to $cP^2$ is at most $2cPE_1$. These terms are small at the proposed forcing scale when $\log W$ is suitably bounded; they are not silently discarded. If W includes primes on the scale of X, $E_1$ need not be a small error.

In the regime $W\ge30$, $h\ge4W$, $h\le X$, the scalar estimate is asymptotically unhelpful on the actual data. The existing PNT gives $P_A$ asymptotic to X and $P_{2,A}$ asymptotic to $X\log X$, uniformly in these W because $E_1\le\log X$ and $E_2\le\log^2X$. Also $\rho$ is bounded below by a fixed positive constant divided by $\log\log(3X)$. Consequently S11 makes $\lambda_*P_{2,A}$ exceed the positive term $cP_A^2$ by a factor tending to infinity. Here $q\ge X$ and $c=I_h/q$. The resulting scalar lower bound is negative for all sufficiently large X in this regime. This is a statement about the completed bound, not a lower bound on the actual error or evidence that actual pair energy is small.

## 6. A certified nonuniform repair on actual support

Allow a diagonal $D=\operatorname{diag}(d_j)$ rather than a scalar charge. The exact completion condition and bound become

$$
\mathsf B+D\succeq0
\quad\Longrightarrow\quad
T_{AA}\ge cP_A^2-\sum_{j\in S}d_j a_j^2.
\tag{S17}
$$

The masked vector in section 2 still proves

$$
\frac1{|S|}\sum_{j\in S}d_j\ge-\mathcal Q_{h,W}.
\tag{S18}
$$

Thus arbitrary nonuniform charges cannot evade the average-charge obstruction. This does not bound the actual weighted cost in S17. Some coordinates have $a_j=0$, and large charges there cost nothing in that particular bound.

This distinction gives a finite successful repair. Take $X=64,h=16,W=6,q=96$. The allowed matrix has 32 coordinates, $c=1/24$, and the excluded actual prime powers are exactly 81 with weight $\log3$ and 128 with weight $\log2$. The actual allowed support has 15 points and includes the higher powers 121 and 125.

For this full 32-coordinate matrix, exact rational arithmetic proves

$$
\boxed{\lambda_*=105/128.}
\tag{S19}
$$

An explicit witness is $w_j=-1$ on j congruent to 1 or 11 modulo 12, and $w_j=1$ on j congruent to 5 or 7 modulo 12. These are all allowed residues modulo 6. The certificate checks $\mathsf Bw=-(105/128)w$ exactly and supplies a semidefinite rational LDL factorization of $\mathsf B+(105/128)I$ proving the other direction. Enclosing actual logarithms then give

$$
cP_A^2-(105/128)P_{2,A}<-61.02.
\tag{S20}
$$

The best scalar completion is therefore worse than the elementary nonnegative pair bound in this actual example.

For the nonuniform repair, ordinary SLSQP first proposed charges on the 15 actual support coordinates. Each proposal was rounded upward to a rational multiple of $10^{-6}$, then increased by $10^{-4}$. These proposals are not trusted for validity. Exact rational LDL verifies that the resulting active matrix A satisfies

$$
A\succeq\epsilon I,\qquad \epsilon=1/20000.
$$

To complete every allowed coordinate, let C be the cross block between active and inactive coordinates. The remaining 17 coordinates receive the common rational charge

$$
d_{\rm out}=I_h+\|C\|_F^2/\epsilon
=\frac{151260307}{4608},\qquad
\|C\|_F^2=\frac{241987}{147456}.
\tag{S21}
$$

The uncharged inactive principal block is bounded below by $-I_hI$, as in section 1. The Schur complement is therefore nonnegative because $A^{-1}\le\epsilon^{-1}I$ and $\|C\|_{\rm op}^2\le\|C\|_F^2$. This proves a positive completion on all 32 allowed coordinates. It is not merely a positive active principal submatrix.

The full rational charge list is fixed explicitly in the linked certificate source. Its actual weighted cost is enclosed near 147.4327707542, and it proves

$$
\boxed{T_{AA}\ge cP_A^2-\sum_{j\in S}d_j a_j^2>16.90.}
\tag{S22}
$$

The rigorous lower bound exceeds $16.9064$; the executable certificate prints its full enclosing ball. Directly evaluated actual allowed energy is approximately 216.7908584302. The prime-power exceptions and cross terms remain as in S15–S16, so the full actual pair energy is also above 16.90.

This repair uses the exact prime support, in addition to the small-prime mask. Its large inactive charges explain why it does not contradict S18. It gives a concrete positive finite bound where the optimal scalar completion gives a negative one. No bound on those charges for a growing family of actual intervals has been proved.

There is an explicit arithmetic condition behind that remaining issue. Testing S17's matrix positivity on $z_j=a_je^{i\theta j}$ gives

$$
\sum_j d_j a_j^2\ge
c\left|\sum_j a_je^{i\theta j}\right|^2
-\sum_{j,k}a_ja_kR_h^{(q)}(j-k)\cos(\theta(j-k)).
\tag{S23}
$$

Unlike S18, this lower bound charges exactly the actual prime-power weights. The right side contains an actual signed pair sum. Bounding it, or constructing uniformly cheap charges despite it, requires arithmetic beyond exact residue exclusion. Uniform counting of allowed residues does not control these weighted data.

## 7. Density boundaries and the complete error remain

The cyclic completion preserves the stated $c=I_h/q$, and S14 removes pair wrapping. It does not replace the interval's continuous density interactions. For $\nu=\sum_{X<n\le2X}\Lambda(n)\delta_n-1_{[X,2X]}dt$, put

$$
J(n)=\int_X^{2X}R_h(n-t)dt,\quad L(n)=I_h-J(n)\ge0.
$$

For $h\le X$, direct integration gives $\int|d|R_h(d)dd=7h^3/1280$ and therefore

$$
\boxed{\mathcal F_h(\nu)=-T_h+I_h(2P-X)
+7h^3/1280-2\sum_n\Lambda(n)L(n).}
\tag{S24}
$$

Here $L(2X)=I_h/2$, and all other missing-density boundary terms remain in the sum. A completion bound substitutes for $T_h$ in this formula; it does not remove its other terms. In particular, when q grows relative to X, $cP^2=I_hP^2/q$ loses a macroscopic part of the density term even if diagonal charges were favorable. Large W in S13 can worsen that problem.

The complete zero-extended error has the corrected measure $\widetilde\nu=\nu+b_0\delta_X-b_1\delta_{2X}$, where $b_0=\psi(X)-X$ and $b_1=\psi(2X)-2X$. Let $A_y=\int R_h(y-t)d\nu(t)$. Its forcing is exactly

$$
\mathcal F_h(\widetilde\nu)=\mathcal F_h(\nu)-2b_0A_X+2b_1A_{2X}
+2b_0b_1R_h(X).
\tag{S25}
$$

The last term vanishes for $h\le X$. The two signed endpoint interactions do not vanish. The added endpoint masses are error values, so the $\log W$ exception estimate for positive prime-power weights cannot be applied to them. The boundary-square terms and the large-scale squared mean from the [complete Haar decomposition](haar-prime-energy-completion.md) also remain. No full mean-square improvement is inferred from S22.

## Exact finite certificate and remaining obligations

The [rational/Arb certificate](certificates/presieved_prime_pair.py) uses fixed rational data, without a floating optimizer or eigensolver. Exact fractions verify (S12); an exact eigenvector and reconstructed semidefinite LDL factorization prove the scalar optimum (S19). Another reconstructed LDL factorization proves the active lower bound, and (S21) completes all allowed coordinates. The certificate also checks every actual interval pair for wrapping and encloses the logarithms at 80 decimal digits. It passed with Python 3 and python-flint 0.9.0, giving scalar upper bound below $-61.02$ and nonuniform lower bound above $16.90$.

These are separate conclusions: the scalar obstruction holds uniformly only in (S11), the fixed-scale formulas (S12) allow arbitrary primorials, and the nonuniform repair is one complete finite actual example. A growing-scale construction must retain the interval density, independently bound the actual weighted charge in (S23), and keep (S24)–(S25) and the squared mean. Those uniform estimates remain unproved.

## 9. An independent cyclotomic and Sturm proof of the finite example

The [independent certificate](certificates/presieved_prime_pair_sturm.py) proves the same finite scalar optimum by characteristic polynomials and Sturm root counts, rather than the semidefinite LDL decomposition above. It reconstructs the kernel from the distinct truncated-power formula
$$
r(t)=\frac1{48}\sum_{j=0}^4(-1)^j\binom4j(2|t|+2-j)_+^3,
\qquad R_h(d)=\frac h2[r(d/h)-r(2d/h)].
$$
Exact integration of its three polynomial pieces gives $\int R_1=1/64$ and $\int|t|R_1(t)dt=7/1280$, agreeing with the full density moments used above.

For the five fixtures $(h,W,q)=(8,2,16),(8,6,24),(16,6,96),(16,30,240),(32,30,480)$, write every phase as a polynomial in a primitive $q$th root. Reduction modulo the exact cyclotomic polynomial proves that the masked phase has zero mean and that its direct quadratic form equals both the CRT displacement sum and the complete Ramanujan-alias expression. The script computes Ramanujan sums by the divisor–Möbius identity. These are finite exact checks of the formulas in Section 2; their general proof remains there.

At $(h,W,q)=(16,6,96)$ let $\mathsf B$ be the full $32\times32$ allowed-coordinate matrix of Section 6. Form
$$
p(t)=\det(tI-\mathsf B),\qquad q(t)=p(t-105/128).
$$
The exact rational polynomial $q$ has a zero of multiplicity one at zero. After removing that factor, its Sturm count on $(-\infty,0)$ is zero. Since $\mathsf B$ is real symmetric, every root is real, so this proves $\mathsf B+(105/128)I\ge0$ and that its minimum eigenvalue is exactly zero. Hence the optimal scalar correction is $105/128$, independently of the earlier LDL argument.

The certificate also factors every integer of the actual interval $(64,128]$ to recover the complete prime-power support, checks every pair for absence of cyclic wrapping, and verifies the active matrix by rational elimination in increasing integer order. It recovers the cross-block squared Frobenius norm $241987/147456$ and the full inactive charge $151260307/4608$. With all actual logarithms enclosed by Arb, the scalar bound is below $-61.02$ and the nonuniform bound exceeds $16.90$. No optimizer or floating eigenvalue calculation enters this second proof.

Run `python -B certificates/presieved_prime_pair_sturm.py` from this directory with `sympy==1.14.0` and `python-flint==0.9.0`. The exact polynomial/root-count tests and all interval inequalities passed. This is a second finite proof mechanism for the same example, not a new uniform weighted-prime estimate or Lean formalization.
