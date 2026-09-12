# Coprime interior coordinates and signed divisor histories

The actual interior update admits an exact reduction by the common gcd, with every nonunit divisor retained. The surviving layers are indexed by squarefree divisors b of g that are coprime to q+r. The correction is a signed sum of cyclotomic values at conductors qb; it does not disappear when qr exceeds the cutoff.

A bounded fixture locates the surviving term. For the reduced coordinates q=7,r=8, the update at n=7,N=15 is negative at the closest primitive root, whereas at n=14,N=30 it is positive. Both satisfy the stipulated interior inequalities, and both precede the reduced first-product scale 56. The full derivatives at these two old roots stay above one before and after the update, so their actual clipped occupation changes are zero. This distinguishes a failure of proposed phasewise cancellation from a counterexample to the unresolved aggregate bound. No RH estimate is proved.

## 1. Method and the finite signed object

The nearest known methods are finite incidence Möbius inversion, cyclotomic distribution under dilation, and the Chinese remainder theorem for shifted lattice intersections. The classical cyclotomic product and prime-dilation rules are stated in [Bzdęga, Herrera-Poyatos and Moree, *Cyclotomic polynomials at roots of unity*, section 2.2, equation (4) and Lemma 2](https://arxiv.org/html/1611.06783). The inversion conventions agree with [DLMF 27.5.2–3 and 27.5.8](https://dlmf.nist.gov/27.5). These are established tools. The gcd-layer formula below packages them for the actual conductor/age coordinates; no new general cyclotomic reciprocity theorem is claimed. The proof below uses the finite divisor identity directly.

Let $X,g,q,r$ be positive integers and suppose

$$
 n=qg,\qquad N=(q+r)g=kg\le X,\qquad
 (q,r)=1,\qquad q,r>\lfloor\sqrt X\rfloor. \tag{C1}
$$

In particular q>1, k=q+r, (q,k)=1 and qr>X. The first common positive multiple of the reduced coordinates is qr; that of the actual conductor n and actual age N-n is gqr. Neither is visible below X. Fix a primitive numerator a with (a,n)=1 and alpha=exp(2 pi i a/n).

Use all states 1,...,X, row-source successor S(i,i+1)=1, zero at the boundary, and strict-division incidence L(i,j)=1 when j properly divides i. The exact chain inverse is

$$
 M=(I+L)^{-1}=\sum_{h=0}^{X-1}(-L)^h,
 \qquad M(i,j)={\bf1}_{j\mid i}\mu(i/j). \tag{C2}
$$

Every quotient, including composite quotients, is an edge. A chain of h strict divisions has its actual sign (-1)^h. State 1 is retained as the initial state of the successor path and as a possible final divisor.

Define the finite chord observable on integer states by

$$
 f_{n,a}(d)=\begin{cases}
 \log|1-\alpha^d|,&n\nmid d,\\
 \log d,&n\mid d.
 \end{cases}
$$

The second line is the usual absolute-log regularization of a vanishing factor; no pole is set to zero. In C1 no divisor of N is a multiple of n, since n does not divide N. Thus only the nonsingular first line enters the actual update, and finite cyclotomic inversion gives

$$
 \boxed{v_{n,N}(a)=\log|\Phi_N(\alpha)|
 =e_1^T S^{N-1}M f_{n,a}
 =\sum_{d\mid N}\mu(N/d)\log|1-\alpha^d|.} \tag{C3}
$$

This is an initial literal successor path 1→...→N followed by every signed strict-division chain and the actual terminal chord. No Euclidean subtraction is interpreted as a graph edge, and no unit restriction is imposed on d.

## 2. Exact reduction retaining the nonunit layers

For d|kg, put h=(d,qg). Since (qg,kg)=g, h divides g. Write b=g/h and d=ht. Then

$$
 t\mid k,\qquad (t,qb)=1,\qquad
 \mu(N/d)=\mu(bk/t),\qquad
 \alpha^d=\zeta_{qb}^{at}. \tag{C4}
$$

To justify t|k, first d|kg gives t|bk, and the defining gcd gives (t,b)=1. Conversely every b|g and t|k with (t,b)=1 gives precisely such a layer. Coprimality with q is automatic because (q,k)=1.

If b is not squarefree, mu(bk/t)=0. If a prime divides both b and k, it cannot divide t, so its exponent in bk/t is at least two and this coefficient is again zero. The remaining layers satisfy (b,k)=1, and then every t|k is allowed and mu(bk/t)=mu(b)mu(k/t). Consequently

$$
 \boxed{v_{qg,kg}(a)
 =\sum_{\substack{b\mid g\\(b,k)=1}}\mu(b)
       \log|\Phi_k(\zeta_{qb}^{a})|.} \tag{C5}
$$

All roots here are primitive because (a,qg)=1. None is a k-th primitive root, since q>1 and (q,k)=1. Thus every displayed logarithm is finite. Nonunit d have been grouped and evaluated, not omitted.

The corresponding rational polynomial identity is

$$
 \Phi_{kg}(z)=\prod_{\substack{b\mid g\\(b,k)=1}}
                \Phi_k(z^{g/b})^{\mu(b)}. \tag{C6}
$$

C6 follows by the same divisor grouping before evaluation and is also obtained by iterating the known prime-dilation identities. It is valid as a rational identity whose total is the actual polynomial. C5 is its value at the actual root, with no denominator zero in this domain.

This constructs a definite reduction and its correction:

$$
 v_{qg,kg}(a)=v_{q,k}(a)+
 \underbrace{\sum_{\substack{b\mid g,\ b>1\\(b,k)=1}}
 \mu(b)\log|\Phi_k(\zeta_{qb}^a)|}_{\mathcal C_g(q,k;a)}. \tag{C7}
$$

It gives exact cancellation of the nonsquarefree and k-sharing gcd layers. However, the remaining correction does not involve a count of common multiples of q and r. The concrete hypothesis tested next is whether the pre-product-scale geometry cancels this remaining signed update, or at least allows the g=1 phasewise sign to pass through this reduction without its correction. Neither conclusion holds in the selected fixture.

When g=1, an additional finite reciprocal reduction is legitimate: all complementary divisors e|k are units modulo q. Since k=q+r,

$$
 v_{q,k}(a)=\sum_{e\mid k}\mu(e)
 f_{q,1}(a r e^{-1}\bmod q). \tag{C8}
$$

Here inverse means the modular inverse supplied by Bezout, not an integer division path and not a new graph edge. For g>1, this unit formula cannot simply be used modulo qg for every divisor. C5 is the required correction retaining exactly those nonunit histories.

## 3. What the absent common multiple actually says about succession

There is a separate exact transfer interpretation. Let P_q and P_r be the coordinate projections onto multiples of q and r in states 1,...,X, and let S_col e_j=e_(j+1), zero at X. Then P_r P_q=0 for X<qr. For each integer $h\ge0$ the number of actual h-successor paths from a q-multiple to an r-multiple is

$$
 A_h(q,r;X)=\sum_{1\le i\le X-h}{\bf1}_{q\mid i}{\bf1}_{r\mid i+h}
 =\mathbf1^T P_r S_{\rm col}^{h}P_q\mathbf1.
$$

Let i_h be the unique integer in 1,...,qr with q|i_h and r|i_h+h. The exact CRT count is

$$
 \boxed{A_h(q,r;X)=\max\left(0,1+\left\lfloor
                         \frac{X-h-i_h}{qr}\right\rfloor\right).} \tag{C9}
$$

This includes the cutoff correction at the first product scale: i_0=qr, so the unshifted count first appears at X=qr. Yet the shifted counts can already equal one before that scale. At q=7,r=8,X=15, i_1=7 and A_1=1, realized by the actual edge 7→8. For the g=2 fixture the actual scaled bridge is 14→15→16, still below X=30, while the first common multiple of 14 and 16 is 112. This is exact compatibility with additive succession, not independence of the two divisor sectors.

C9 by itself is not an estimate of C3. It pinpoints why an unshifted intersection statement cannot delete the signed chord terms after actual succession. The shifted successor count and the strict-division incidence remain different operators.

## 4. The bounded actual fixture and its surviving signed term

First take q=7,r=8,g=1,N=X=15,n=7,a=1. Then floor(sqrt X)=3, both reduced coordinates exceed it, and qr=56>X. The four terminal divisor coefficients in C3 are

| d | 1 | 3 | 5 | 15 |
|---|---:|---:|---:|---:|
| mu(15/d) | 1 | -1 | -1 | 1 |
| residue modulo 7 | 1 | 3 | 5 | 1 |

The positive coefficient at d=1 is the sum of the direct 15→1 sign - and the two chains 15→3→1 and 15→5→1 with signs +. The d=15 term is the empty division chain. Thus every sign comes from C2.

Pairing conjugate chords replaces residue 5 by 2. The remaining signed chord expression is

$$
 \boxed{v_{7,15}(1)=2f_{7,1}(1)-f_{7,1}(2)-f_{7,1}(3)<0.} \tag{C10}
$$

The strict inequality follows because sin(pi/7)<sin(2pi/7)<sin(3pi/7). The zero total of the coefficients 2,-1,-1 cancels a constant observable, but does not cancel the actual chord. Hence there is no sign-reversing, chord-weight-preserving pairing of all these signed histories. This is the surviving signed term; it appears entirely before 56.

An exact polynomial check gives

$$
 \Phi_{15}(z)\equiv z^5-z^4+z^3\pmod{\Phi_7(z)}.
$$

Writing y=2cos(2pi/7), the modulus is |y-1|=y-1, with 1<y<2. Thus

$$
 v_{7,15}(1)=\log(2\cos(2\pi/7)-1)<0. \tag{C11}
$$

Now make the concrete gcd-layer repair test with the same q=7,r=8 and g=2. Here n=14,N=X=30, floor(sqrt X)=5, so the specified interior conditions still hold and qr=56>X. C5 reads

$$
 v_{14,30}(1)=\log|\Phi_{15}(\zeta_7)|
              -\log|\Phi_{15}(\zeta_{14})|. \tag{C12}
$$

The first layer consists of the nonunit divisors d=2,6,10,30, with coefficients +,-,-,+. The second consists of d=1,3,5,15, with coefficients -,+,+,-. Omitting nonunits would remove the entire first layer and give the wrong update.

The exact residual polynomial is

$$
 \Phi_{30}(z)\equiv-z^5-z^4-z^3\pmod{\Phi_{14}(z)}.
$$

For y=2cos(pi/7), its modulus is y+1. Therefore

$$
 \boxed{v_{14,30}(1)=\log(2\cos(\pi/7)+1)>0.} \tag{C13}
$$

Equivalently the known identity Phi_30(z)=Phi_15(-z) sends this phase to the conjugate Phi_15(zeta_7^4). The nontrivial gcd correction reverses the selected phasewise sign while the reduced geometry is unchanged. This is compatible with a norm or a positive average over Galois conjugates; it does not contradict a relative-norm identity. Neither a global norm-one statement nor a character average was used to obtain C10-C13.

## 5. Full derivative and clipping are separate consumers

Let $F_K(z)=\prod_{j=1}^K\Phi_j(z)$, including $\Phi_1$, and $b_K(\alpha)=[-\log|F_K'(\alpha)|]_+$. At an old root alpha the actual update is

$$
 F_N'(\alpha)=F_{N-1}'(\alpha)\Phi_N(\alpha),\qquad
 b_N-b_{N-1}=[-(L+v)]_+-[-L]_+,
 \quad L=\log|F_{N-1}'(\alpha)|. \tag{C14}
$$

A sign for v is not a sign or lower bound for a nonzero occupation change. The checker computes the complete derivatives in both fixtures, using Phi_n' times every remaining factor of the actual prefix. No unit normalization or scalar removal is made.

For n=7 and y=2cos(2pi/7), the squared moduli are 196 at cutoff 14 and 196(y-1)^2 at cutoff 15. For n=14 and y=2cos(pi/7), they are

$$
 |F_{29}'|^2=-2352y^2+784y+6272,\qquad
 |F_{30}'|^2=-5488y^2+3136y+12544. \tag{C15}
$$

All four are strictly greater than one. Exact rational enclosures are recorded in the certificate; the selected y values are the largest real roots respectively of y³+y²-2y-1 and y³-y²-2y+1. Consequently both b values and both actual clipped increments are zero in these examples. Multiplying by the actual new-cutoff Farey weights leaves zero. These fixtures falsify a phasewise cancellation or sign-transfer proposal for v; they do not falsify the remaining signed occupation estimate.

## 6. Exact symbolic verification and scope

The standalone checker enumerates all strict-division chains from 15 and 30 to their divisors and checks their alternating sums against the arithmetic Möbius coefficients. It verifies the cyclotomic product in the exact quotient fields, the gcd-layer polynomial identity, every nonunit layer, the polynomial residues in C11-C13 and the actual full prefix derivatives. Exact real-root isolation plus rational interval arithmetic certify the signs and clipping decisions. It also checks the selected CRT successor counts. There is no census, floating root estimate, L-zero calculation or character-mask computation.

Run the [exact checker](certificates/cyclotomic_coprime_interior.py) with Python 3 and SymPy. The all-parameter statements C2-C9 are written finite proofs. The selected fixtures are exact symbolic evidence, not Lean theorems. The useful outputs are the gcd-layer cancellation and correction C5-C7, the exact shifted intersection C9, and the explicit surviving chord combination C10. Their ingredients are classical incidence/distribution/CRT methods; the specialization retains the actual interior coordinates, nonunit layers, signs and full clipping boundary in one bounded test.

The no-common-multiple observation alone does not force the proposed phasewise signed cancellation, and the exact gcd reduction cannot discard its correction or preserve the original phase's sign. A stronger reciprocity could still control a complete weighted sum with its boundary and clipping corrections; no such estimate is derived here, and the finite counterexamples do not exclude it. The [valuation reduction](cyclotomic-valuation-update.md) gives a different prime-adic simplification, and the [activity quadrature theorem](cyclotomic-activity-quadrature.md) retains the full signed angular consumer. Neither is replaced by the absence of a common multiple.

The complementary [common-scale norm proof](cyclotomic-common-scale-norm.md) takes the actual relative Galois norm by prime-step distribution relations. It retains the shared-prime scalar and gives the exact fibre covariance and full clipping corrections needed to compare its positive average with the original weighted observable.
