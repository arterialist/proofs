# Coherent port asymptotics for constrained endpoint packets

The Jensen-Schur majorant grows like
\(\log(1/\varepsilon)^{3/2}\) on normalized endpoint packets and cannot be
paid by the killed core form. This note returns to the original coherent
quantity

\[
 Q(Bx,Bx)=\frac1a\int_O\frac{\psi _2(u)}{\rho(u)}
                         |Bx(u)|^2\,d\nu(u).              \tag{1}
\]

For the same exactly constrained even packets, the coherent port is bounded
and converges to a finite positive prime-power diagonal. Its continuous part
actually tends to zero. The killed core supply grows logarithmically, so this
packet family satisfies the desired port inequality with a diverging margin.
This does not prove the inequality for arbitrary vectors in
\(\mathcal K_{\rm ev}\).

## 1. Packet and notation

Choose a nonnegative nonzero
\(\chi\in C_c^\infty((1,2))\). Put

\[
 p_\varepsilon^+(v)
 =N_\varepsilon\varepsilon^{-1/2}
   \chi\!\left(\frac{2-v}{\varepsilon}\right),\qquad
 p_\varepsilon^-(v)=p_\varepsilon^+(-v),                 \tag{2}
\]

\[
 p_\varepsilon
 =\frac{p_\varepsilon^++p_\varepsilon^-}{\sqrt2},
 \qquad \|p_\varepsilon\|_{L^2(C,\nu)}=1.                \tag{3}
\]

Writing \(m=b\Phi\), normalization gives

\[
 N_\varepsilon^2
 \int_1^2|\chi(z)|^2m(2-\varepsilon z)\,dz=1,
 \qquad
 N_\varepsilon\longrightarrow
 N_0=\frac1{\sqrt{m(2)}\|\chi\|_2}.                      \tag{4}
\]

Let \(L_\varepsilon=\log(1/\varepsilon)\). Decompose the actual crossing
operator, without changing any coefficient, as

\[
 B=B_{\rm c}+B_{\rm p},                                  \tag{5}
\]

where \(B_{\rm p}\) contains both orientations of every prime power.

## 2. Coherent continuous column at one endpoint

Write \(u=2+y\), \(v=2-d\). The positive-endpoint contribution is

\[
 (B_{\rm c}p_\varepsilon)(2+y)
 =\frac{N_\varepsilon}{\sqrt{2\varepsilon}\,b(2+y)}
   \int_1^2\Phi(2-\varepsilon z)\chi(z)
             r(y+\varepsilon z)\,\varepsilon dz.         \tag{6}
\]

For \(y=\varepsilon t\), the exact limit
\(\varepsilon r(\varepsilon(t+z))\to[2(t+z)]^{-1}\) gives

\[
 \varepsilon^{1/2}(B_{\rm c}p_\varepsilon)(2+\varepsilon t)
 \longrightarrow
 \frac{N_0\Phi(2)}{2\sqrt2\,b(2)}
 F_\chi(t),\qquad
 F_\chi(t)=\int_1^2\frac{\chi(z)}{t+z}\,dz.               \tag{7}
\]

This is the cancellation that rowwise Cauchy discarded. The row mass
\(B1_C(2+y)\) integrates the entire core and grows like \(\log(1/y)\).
The coherent column in (6) integrates only the width-\(\varepsilon\) packet.
After the scaling \(y=\varepsilon t\), it is the fixed Stieltjes profile
\(F_\chi\). Since \(F_\chi(t)=O((1+t)^{-1})\),

\[
 \int_0^\infty|F_\chi(t)|^2dt<\infty.                    \tag{8}
\]

The two-sided ground boundary theorem gives, uniformly for bounded \(t\),

\[
 \frac{\psi _2(2+\varepsilon t)}{\rho(2+\varepsilon t)}
 \asymp L_\varepsilon^{-1/2}.                            \tag{9}
\]

Using (7)--(9), first on bounded \(t\), then the
\(O((1+t)^{-1})\) tail, gives constants \(0<c_\chi<C_\chi<\infty\) with

\[
 \boxed{\quad
 c_\chi L_\varepsilon^{-1/2}
 \le Q(B_{\rm c}p_\varepsilon,B_{\rm c}p_\varepsilon)
 \le C_\chi L_\varepsilon^{-1/2}.
 \quad}                                                  \tag{10}
\]

For the upper bound outside a fixed boundary collar, the continuous kernel
is separated from the packet and its column is \(O(\sqrt\varepsilon)\).
Theta decay makes that remote contribution \(O(\varepsilon)\).

The negative endpoint gives the reflected copy of (7). Near the positive
exterior boundary, the column from the negative packet is
\(O(\sqrt\varepsilon)\), and conversely at the negative boundary. Their
mixed term is therefore negligible. There is no reinforcement between the
two hard-boundary singularities.

## 3. The complete prime-power limit

For a branch indexed by \(n\ge2\) and orientation \(\sigma=\pm1\), the
prime crossing is an exact translated packet. If \(v\in C\) and
\(u=v+\sigma\log n\in O\), its diagonal contribution to (1) is

\[
 \frac{\Lambda(n)^2}{a n}
 \int e^{|v+\sigma\log n|/2}G(v+\sigma\log n)
       \Phi(v)^2|p_\varepsilon(v)|^2\,dv,                \tag{11}
\]

where \(G=\Phi\psi _2\). Distinct fixed branches have disjoint translated
packet supports for all sufficiently small \(\varepsilon\). The same is true
between branches issued from opposite endpoints: equality of two centers
would force a rational number to equal \(e^4\).

The full prime tail may be removed uniformly before taking the limit. The
published weighted prime crossing series converges in operator norm, and the
proved finite bound for \(\|\psi _2\|_\infty\) converts that tail to the
\(Q\)-norm. Thus finite-branch disjointness and then tail removal yield

\[
 \boxed{\quad
 Q(B_{\rm p}p_\varepsilon,B_{\rm p}p_\varepsilon)
 \longrightarrow P_{\rm edge}>0,
 \quad}                                                  \tag{12}
\]

with the complete diagonal

\[
 P_{\rm edge}
 =\frac{\Phi(2)}{a\,b(2)}
 \sum_{n\ge2}\frac{\Lambda(n)^2}{n}
 \sum_{\substack{\sigma=\pm1\\|2+\sigma\log n|>2}}
 e^{|2+\sigma\log n|/2}G(2+\sigma\log n).                \tag{13}
\]

Formula (13) retains every proper prime power and both orientations. The
condition in its inner sum says exactly that the translated endpoint lies in
the exterior. Positivity of \(G\) and the \(n=2,\sigma=+1\) term show
\(P_{\rm edge}>0\).

The continuous-prime mixed pairing tends to zero. One sufficient estimate is
Cauchy-Schwarz in the \(Q\)-space:

\[
 |Q(B_{\rm c}p_\varepsilon,B_{\rm p}p_\varepsilon)|
 \le Q(B_{\rm c}p_\varepsilon,B_{\rm c}p_\varepsilon)^{1/2}
      Q(B_{\rm p}p_\varepsilon,B_{\rm p}p_\varepsilon)^{1/2}
 =O(L_\varepsilon^{-1/4}).                               \tag{14}
\]

Combining (10), (12), and (14),

\[
 \boxed{\quad
 Q(Bp_\varepsilon,Bp_\varepsilon)
 =P_{\rm edge}+o(1).
 \quad}                                                  \tag{15}
\]

Thus the original coherent port grows like a constant. Its continuous
hard-boundary part is smaller, of order \(L_\varepsilon^{-1/2}\).
The \(\log^{3/2}\) growth belonged entirely to the rowwise Jensen majorant.

## 4. Exact common constraints do not change the limit

Let \(\mathcal L_1,\ldots,\mathcal L_r\) be a maximal independent list of
the even mean, arrival, and finite observation constraints. Choose smooth
even biorthogonal correctors \(z_j\), all supported in one fixed compact
subset of the open core, and set

\[
 x_\varepsilon
 =p_\varepsilon-\sum_{j=1}^r
   \mathcal L_j(p_\varepsilon)z_j.                       \tag{16}
\]

As proved in the preceding note,
\(\mathcal L_j(p_\varepsilon)\to0\), and
\(x_\varepsilon\in\mathcal K_{\rm ev}\) exactly. The weighted crossing
theorem makes \(x\mapsto Bx\) bounded into the \(Q\)-space. Hence

\[
 Q(Bx_\varepsilon,Bx_\varepsilon)
 -Q(Bp_\varepsilon,Bp_\varepsilon)\longrightarrow0.      \tag{17}
\]

All prime powers remain inside this continuity statement. Therefore

\[
 Q(Bx_\varepsilon,Bx_\varepsilon)\longrightarrow
 P_{\rm edge}.                                           \tag{18}
\]

## 5. Comparison with the complete killed supply

The earlier packet estimate gives the upper bound

\[
 E_C[x_\varepsilon]-\alpha _2\|x_\varepsilon\|^2
 \le C L_\varepsilon+D.                                  \tag{19}
\]

There is also a matching lower bound. On the packet collars, the positive
continuous crossing killing satisfies

\[
 \kappa_C(v)\ge c\log\frac1{2-|v|}-C_0.                  \tag{20}
\]

The correctors vanish on those collars, so
\(x_\varepsilon=p_\varepsilon\) there. Internal continuous and prime forms
are nonnegative. After subtracting the fixed
\(\alpha _2\|x_\varepsilon\|^2\), (20) gives

\[
 E_C[x_\varepsilon]-\alpha _2\|x_\varepsilon\|^2
 \ge c_1L_\varepsilon-C_1.                               \tag{21}
\]

Consequently

\[
 \boxed{\quad
 Q(Bx_\varepsilon,Bx_\varepsilon)=\Theta(1),\qquad
 E_C[x_\varepsilon]-\alpha _2\|x_\varepsilon\|^2
 =\Theta(L_\varepsilon),
 \quad}                                                  \tag{22}
\]

and

\[
 \frac{Q(Bx_\varepsilon,Bx_\varepsilon)}
      {E_C[x_\varepsilon]-\alpha _2\|x_\varepsilon\|^2}
 \longrightarrow0.                                      \tag{23}
\]

The normalized constrained endpoint packets are therefore not
counterexamples to the surviving theta theorem. They satisfy it for all
sufficiently small \(\varepsilon\).

## 6. What this settles

The calculation distinguishes three scales on the same packet:

\[
 \text{Jensen pulled weight } \asymp L_\varepsilon^{3/2},
 \qquad
 \text{killed core supply } \asymp L_\varepsilon,
 \qquad
 \text{coherent port } \asymp 1.                         \tag{24}
\]

The extra square-root logarithm was an artifact of multiplying the full row
mass by the packet's local second moment. The original column averages first
and squares afterward. That order is essential.

This result closes the endpoint-concentration test, including finite
nullspace corrections and the full prime comb. It does not control packets
at intermediate scales, oscillatory boundary profiles, or arbitrary
vectors in the constrained form domain. The remaining proof must estimate
the coherent transform itself. Any return to the pulled multiplication
weight loses too much at the hard boundary.

## 7. Lean artifact

lean/CoherentPacketAlgebra.lean formalizes:

* exact expansion of a coherent complex column norm;
* a deviation bound from the continuous diagonal and mixed pairing;
* the Cauchy square bound for the mixed term;
* the exact quadratic perturbation identity for finite nullspace
  corrections; and
* decay of a bounded port relative to a linearly growing supply.

It compiles with Lean 4.24 and contains no sorry or new axiom. The scaled
Stieltjes limit, the full prime diagonal (13), uniform prime-tail removal,
and killed-form packet bounds are analytic inputs proved in this note.
