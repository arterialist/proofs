# A certified regular rank-146 prolate projection at B=1

The exact rational candidate and enclosing-arithmetic certificate below prove the following fixed-support theorem. The explicit polynomial subspace below has orthogonal projection Π satisfying

$$
 \|\Pi-P_{146}\|<10^{-8}.
$$

Here P₁₄₆ projects onto the first 146 eigenfunctions of the continuous concentration operator with kernel sin(200(x−y))/(π(x−y)) on L²([-1,1]). With both exact pole functions adjoined, the bath estimate proved in Section F2 therefore gives

$$
 q(f)\ge 0.353891999999999\,\|f\|_2^2
 \quad(f\perp \operatorname{ran}\Pi+\operatorname{span}\{e^{x/2},e^{-x/2}\}).
\tag{F1}
$$

The finite matrix used here is a commuting differential-operator matrix, not a retained q matrix. The actual prime operator, both poles, support compression, and the existing cell/mixed-Gram result are unchanged. This resolves the numerical-projection certification dependency at this one support size. It does not certify the retained q block or its mixed Gram.

## F2. Inputs and precisely used classical identification

Use the actual supported form $q=A-J$ defined in the [signed prime-form chapter](signed-prime-bath.md). Its proved bounds are
$$h(t)\ge-5.373,\qquad h(t)\ge3.386\quad(|t|\ge200),\qquad\|J\|\le2.927.$$
The Fourier convention is $\widehat f(t)=\int f(x)e^{-itx}dx$, with Parseval factor $1/(2\pi)$. The positive concentration operator $C_c$ has kernel $\sin(c(x-y))/(\pi(x-y))$. Duration $2$ and angular bandwidth $200$ give $c=200$.

[Karnik–Romberg–Davenport, Corollary 3](https://arxiv.org/html/2006.00427) gives the continuous concentration estimate, with zero-based indexing,
$$
\lambda_k(c)\le10\exp\left(-\frac{k-\lceil2c/\pi\rceil-6}{D(c)}\right),\qquad
D(c)=\frac2{\pi^2}\log(100c/\pi+25),\quad k\ge\lceil2c/\pi\rceil.
$$
At $c=200$, $\lceil400/\pi\rceil=128$, $D(200)<222/125$, and $10e^{-250/37}<0.012$. The accompanying certificate proves these scalar inequalities with rational arctangent, logarithm and exponential series. Thus $\lambda_{146}<0.012$ without numerical concentration eigenvalues.

Let $P=P_{146}$ project onto indices $0,\ldots,145$. For $r\perp\operatorname{ran}P$, the low-frequency Fourier mass is at most $0.012\|r\|^2$, so
$$q[r]\ge[3.386-8.759(0.012)-2.927]\|r\|^2=0.353892\|r\|^2.$$
For an orthogonal projection $\Pi$ with $\|\Pi-P\|\le\eta$ and $r\perp\operatorname{ran}\Pi$, commutation of $P$ with $C_{200}$ removes the spectral cross term:
$$\langle C_{200}r,r\rangle\le0.012\|(I-P)r\|^2+\|Pr\|^2\le[0.012+0.988\eta^2]\|r\|^2.$$
Adjoining both exact pole functions only restricts the complement. On its form domain this proves
$$
q[r]\ge(0.353892-8.653892\eta^2)\|r\|^2.\tag{F2}
$$
This does not assert finite form values for every $L^2$ vector.

The ordering identification is essential: the same prolate functions have increasing differential eigenvalues $\chi_n$ and decreasing concentration eigenvalues $\lambda_n$. [Bonami–Karoui, introduction, equations (1)–(3)](https://arxiv.org/html/1509.02646) states these facts with the same sinc normalization. Hence the first 146 differential modes are precisely the required concentration subspace. Commutation alone would not supply this identification.

## F3. Self-adjoint domain and an exact banded matrix

Let eₙ(x)=√((2n+1)/2)Pₙ(x) be the real orthonormal Legendre basis of H=L²([-1,1]). Define

$$
 D_0e_n=n(n+1)e_n,\qquad
 \mathcal D(D_0)=\left\{\sum a_ne_n:
   \sum n^2(n+1)^2|a_n|^2<\infty\right\},
$$
$$
 D=D_0+40000\,M_{x^2},\qquad \mathcal D(D)=\mathcal D(D_0).
\tag{F3}
$$

The bounded nonnegative potential makes D self-adjoint with compact resolvent. This is the regular Legendre realization of −((1−x²)f′)′+40000x²f. In particular it selects the regular prolate realization at the singular endpoints; no arbitrary boundary extension is inserted.

Writing
$$
 xe_n=\frac{n+1}{\sqrt{(2n+1)(2n+3)}}e_{n+1}
       +\frac{n}{\sqrt{(2n+1)(2n-1)}}e_{n-1},
$$
with the second term absent for n=0, gives the exact two-parity Jacobi matrix
$$
 d_n=n(n+1)+40000\left[
 \frac{(n+1)^2}{(2n+1)(2n+3)}
 +\frac{n^2}{(2n+1)(2n-1)}\right],
$$
$$
 b_n=\langle e_{n+2},De_n\rangle
 =\frac{40000(n+1)(n+2)}
 {(2n+3)\sqrt{(2n+1)(2n+5)}}>0.
\tag{F4}
$$

Every dₙ and bₙ² is rational. This allows exact rational spectral counting even though bₙ itself is generally algebraic.

## F4. A full infinite-dimensional gap from two finite inertia tests

Set N=256 and split H into degrees 0,…,255 and degrees ≥256. In block notation,
$$
 D=\begin{pmatrix}D_N&B^*\\B&D_{\rm tail}\end{pmatrix},
 \qquad D_{\rm tail}\ge N(N+1)I=65792I.
$$
The latter is a form inequality: the kinetic operator has this lower bound on the tail and the compression of 40000x² is nonnegative. B has only two nonzero entries, coupling 254 to 256 and 255 to 257.

For τ<65792 the infinite tail is strictly positive after subtraction of τ, and its exact finite Schur complement is
$$
 S_\tau=D_N-\tau-B^*(D_{\rm tail}-\tau)^{-1}B.
$$
Define the diagonal finite matrix Eτ supported only on coordinates 254 and 255, with respective entries
$$
 \frac{b_{254}^2}{65792-\tau},\qquad
 \frac{b_{255}^2}{65792-\tau}.
$$
The operator inequalities are
$$
 D_N-\tau-E_\tau\ \le S_\tau\le D_N-\tau.
\tag{F5}
$$
There is no truncation of the unknown tail inverse in F5.

At each τ=43800 and τ=43900, exact rational LDL elimination separately in the even and odd blocks found:

| τ | finite matrix | negative even pivots | negative odd pivots |
|---|---|---:|---:|
| 43800 | D_N−τ | 73 | 73 |
| 43800 | D_N−τ−Eτ | 73 | 73 |
| 43900 | D_N−τ | 73 | 73 |
| 43900 | D_N−τ−Eτ | 73 | 73 |

Every pivot is explicitly nonzero. The recurrence is p₀=d₀−τ and pⱼ=dⱼ−τ−bⱼ₋₂²/pⱼ₋₂ along each parity, with the indicated corner penalty included before the final elimination step. All arithmetic in these sign tests uses fmpq exact rational numbers.

The two bounding matrices at a fixed τ are invertible with the same inertia. Ordered-eigenvalue monotonicity in F5 then puts the 146th eigenvalue of Sτ strictly below zero and its 147th strictly above zero. Thus Sτ is invertible and has exactly 146 negative eigenvalues. Schur congruence with the positive invertible tail proves the same negative spectral count for D−τ. Compact resolvent and both endpoint counts now give
$$
 \chi_{145}<43800<43900<\chi_{146},
 \qquad \operatorname{spec}(D)\cap[43800,43900]=\varnothing.
\tag{F6}
$$

This certifies the gap of the full differential operator, including all unrepresented Legendre degrees. It is not merely a gap of D_N.

## F5. The explicit exact candidate and its complete residual

The [exact rational table](certificates/prolate_projection_rationals.txt) gives 146 columns Q∈ℚ²⁵⁶×¹⁴⁶ and diagonal entries θⱼ∈ℚ as numerator/denominator pairs. A SciPy parity eigensolver generated candidate values, but every stored binary float was immediately replaced by its exact integer ratio. The certificate treats those rationals as definitions and does not import or trust SciPy.

The actual functions are
$$
 \phi_j=\sum_{n=0}^{255}Q_{nj}e_n,\qquad
 G=Q^*Q,\qquad
 \Pi=QG^{-1}Q^*
\tag{F7}
$$
under the Legendre isometry. The last formula defines an exact orthogonal projection once G>0 is certified; it is not a floating inverse.

At 256-bit Arb precision, with every rational converted by enclosing arithmetic and each bₙ evaluated as the positive square root of the exact rational bₙ², the following bounds passed:

$$
 \|G-I\|_F<10^{-10},\qquad
 \|DQ-Q\Theta\|_F<10^{-6},\qquad
 \max_j\theta_j<43746.
\tag{F8}
$$

More informative enclosing outputs are approximately
$$
 \|G-I\|_F=1.5057743633295\,10^{-14},
$$
$$
 \|DQ-Q\Theta\|_F=5.1089016481444\,10^{-7}.
$$
These displayed midpoints summarize Arb enclosures; F8 is the asserted rational certificate.

The residual is evaluated in all of H. Its first 256 rows use the exact matrix in F4. Rows 256 and 257 are respectively b₂₅₄Q₂₅₄,ⱼ and b₂₅₅Q₂₅₅,ⱼ. Every later row vanishes exactly because multiplication by x² raises a polynomial's degree by at most two. In particular, the tail was neither omitted nor bounded by a projected residual.

The norm of these two tail rows alone is enclosed near 5.1089012448945·10⁻⁷. It dominates the finite residual. Thus the discriminator genuinely checks the truncation boundary, rather than obtaining a small result solely from a finite eigensolver.

## F6. Residual-to-projection theorem and certificate

Let P=P₁₄₆, identified with the first 146 differential modes as in F2. On P⊥ the full D spectrum is above 43900. For every exact candidate column,
$$
 (D|_{P^\perp}-\theta_j)(I-P)\phi_j
   =(I-P)(D\phi_j-\theta_j\phi_j).
$$
Since θⱼ<43746, the spectral theorem gives
$$
 \|(I-P)Q\|_F
 \le\frac{\|DQ-Q\Theta\|_F}{154}.
\tag{F9}
$$
This columnwise argument requires no unproved approximate-eigenvector ordering and no concentration gap.

The map QG⁻¹ᐟ² is an isometry of rank 146. The two rank-146 orthogonal projections obey the equal-rank principal-angle identity
$$
 \|\Pi-P\|=\|(I-P)QG^{-1/2}\|
 \le
 \frac{\|DQ-Q\Theta\|_F}
 {154\sqrt{1-\|G-I\|_F}}
 <10^{-8}.
\tag{F10}
$$
The actual Arb enclosure of the right side is near 3.3174686026912·10⁻⁹. The looser rational bound 10⁻⁸ is sufficient and is the advertised certificate. Substitution into F2 gives F1 because
$$
 0.353892-8.653892\,10^{-16}>0.353891999999999.
$$

## F7. Both poles, regularity, and the remaining finite problem

Let $g_\pm(x)=e^{\pm x/2}$ and Ppole be the exact orthogonal projection onto their span. Their exact Gram matrix is
$$
 G_{\rm pole}=
 \begin{pmatrix}2\sinh1&2\\2&2\sinh1\end{pmatrix}>0.
$$
Define
$$
 W=\operatorname{ran}\Pi+\operatorname{span}\{g_+,g_-\},
 \qquad L=W\cap\operatorname{span}\{g_+,g_-\}^{\perp}.
\tag{F11}
$$
Equivalently L is spanned by all 146 functions (I−Ppole)φⱼ. No nonzero linear combination of g± is a polynomial on an interval, so these 146 functions remain linearly independent: W has dimension 148 and L has dimension 146. In particular, none of the pole-redistribution directions is discarded.

Every φⱼ is a polynomial; all functions in W are smooth on the closed support interval. Their zero extensions are compactly supported BV functions, whose Fourier transforms are O(1/|t|). Consequently they lie in the archimedean log-growth form and operator domains used in the existing mixed-Gram work. The multiplication/addition by pole functions here is always followed by the same support restriction; it does not enlarge the ambient H.

Exact admissible H decomposes orthogonally as L⊕W⊥. Equation F1 applies to the entire bath W⊥. To finish positivity on this support one still needs the exact supported action on L, the complete mixed Gram, and a suitable Schur estimate. None is supplied by a small L² projection error.

The literal basis (I−Ppole)φⱼ can be numerically ill-conditioned because the prolate subspace approximates smooth low-frequency pole functions very well. The certificate does not assert a lower bound for that pole-projected Gram. A later retained calculation must stabilize and certify all 146 directions, including the two involving pole redistribution, rather than delete small numerical singular values. This is a basis-conditioning issue for the next finite calculation, not a defect in F1 or F10.

Compared with the accepted cell decomposition, the retained dimension falls from 766 to 146 and the certified bath constant rises from 0.3152 to above 0.353891999999999. This is a concrete simplification before attempting another q matrix. The [cell-based complement proof](signed-prime-bath.md) remains a distinct valid construction. Support growth, the global arithmetic input, and RH remain unresolved.

## F8. Exact data and reproduction

The [certificate](certificates/prolate_projection.py) reads the accompanying [rational table](certificates/prolate_projection_rationals.txt). Each `T j -1 a b` defines $\theta_j=a/b$; each `Q j n a b` defines $Q_{nj}=a/b$. Unlisted matrix entries are zero. The data are the exact rational definitions of the candidate, rather than rounded diagnostic eigenvectors.

A parity tridiagonal eigensolver originally proposed the candidate. Its floating values were converted to exact integer ratios. Reproduction uses only these fixed rationals and `python-flint==0.9.0` at 256 bits; it neither imports an eigensolver nor trusts its eigenvalue ordering. Run `python -B building-blocks/certificates/prolate_projection.py` from the repository root. The certificate includes the two full tail rows, exact rational inertia and the rational concentration substitution. The strict bounds in F8 and F10 are the assertions; displayed decimal ball centers are explanatory only.

The self-adjoint domain bridge can also be checked directly. A regular smooth prolate eigenfunction has zero boundary terms in integration by parts against $P_n$ because of the factor $1-x^2$. Thus
$$n(n+1)\langle f,e_n\rangle=\langle-((1-x^2)f')',e_n\rangle.$$
The right side is an $\ell^2$ sequence, placing $f$ in the domain in F3. Completeness of the regular prolate family and self-adjointness identify the whole operator. This does not choose an unspecified singular-endpoint extension.

For general support $[-B,B]$ and frequency cutoff $T$, the same classical concentration estimate uses $c=BT$. Given separately proved bounds $h_{\min}$, $h_{\mathrm{high}}(T)$ and $\|J_B\|$, any $N\ge\lceil2BT/\pi\rceil$ with the displayed concentration upper bound at most $\varepsilon$ gives complement lower bound
$$h_{\mathrm{high}}(T)-[h_{\mathrm{high}}(T)-h_{\min}]\varepsilon-\|J_B\|.$$
This formula supplies no arithmetic control of $T$ as $B$ grows.

These are written spectral and arithmetic applications of the cited classical concentration, Schur-complement and residual-projection methods, with exact rational and Arb checks. They are not Lean formalizations. The retained Weil block, its complete mixed Gram and the support-growth problem remain open in this construction. No priority claim is made.
