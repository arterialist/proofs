# A PNT-scale bound for the actual weak theta ground row

Fix a finite core \(C=[-R,R]\) and its normalized even killed ground \(\psi_R\). Put \(G=\Phi\psi_R1_{O_R}\). The published [weak mixed-ground theorem](theta-ground-exponential-weak-cross-row.md) defines the complete Weil row \(Q_{\rm W}(G,h_t)\) for the actual signed scaling test
\[
 h_t(v)=H(te^{|v|}),\qquad H(z)=-\sqrt z\,K(z),
\]
where \(K\) is the [actual successor scaling kernel](successor-feedback-kernel-scaling.md). The full prime-power sum, both pole products, the archimedean multiplier and the hard core are retained.

**Claim.** There are \(c>0\) absolute and \(C_{R,\psi}<\infty\) such that, for all sufficiently small \(t>0\),
\[
 \boxed{\quad
 \sqrt t\,|Q_{\rm W}(G,h_t)|
 \le C_{R,\psi}\exp[-c\sqrt{\log(1/t)}].
 \quad}                                                        \tag{1}
\]
This improves the unconditional [Goldbach-norm mixed-row estimate](goldbach-scaling-kernel-hard-wall.md) \(O_{c'}(t^{1/2-c'})\), \(c'>1\), for this specified test. It supplies no sign or RH conclusion.

## Pole-density cancellation

For any pair \(G,h\) with the displayed integrals absolutely convergent, define the density translation form
\[
 S_{\rm den}(G,h)
 =\int_{\mathbb R}G(u)\int_1^\infty x^{-1/2}
       [h(u+\log x)+h(u-\log x)]\,dx\,du .
\]
Changing variables \(v=u\pm\log x\) gives
\[
 S_{\rm den}(G,h)
   =\iint G(u)h(v)e^{|u-v|/2}\,du\,dv.             \tag{2}
\]
The actual two-pole bilinear term is
\[
 P_{\rm pole}(G,h)
 =M_{1/2}(G)M_{-1/2}(h)+M_{-1/2}(G)M_{1/2}(h)
 =\iint G(u)h(v)\,2\cosh((u-v)/2)\,du\,dv.
\]
Thus the cancellation is exact:
\[
 P_{\rm pole}(G,h)-S_{\rm den}(G,h)
 =\iint G(u)h(v)e^{-|u-v|/2}\,du\,dv.            \tag{3}
\]
Write \(\Psi(x)=\sum_{n\le x}\Lambda(n)\), \(E(x)=\Psi(x)-x\) for \(x\ge1\), and
\[
 \mathcal D(G,h)=\int G(u)\int_{(1,\infty)}x^{-1/2}
       [h(u+\log x)+h(u-\log x)]\,dE(x)\,du .
\]
The signed Stieltjes measure includes the whole density interval \((1,2)\), where there is no prime atom. It retains every later prime power. Since the physical form is \(A-S\), equations (2)–(3) give the exact decomposition
\[
 Q_{\rm W}(G,h)=A(G,h)
 +\iint G(u)h(v)e^{-|u-v|/2}\,du\,dv
 -\mathcal D(G,h).                               \tag{4}
\]
The endpoint at \(x=1\) is not silently removed: \(E(1)=-1\), and Stieltjes integration by parts on any tail \((X,\infty)\), \(X>1\), uses the term \(-E(X)f(X)\).
More explicitly, for \(f_{u,\pm}(x)=x^{-1/2}h(u\pm\log x)\), the exact global identity is
\[
 \int_{(1,\infty)}f_{u,\pm}(x)\,dE(x)
 =f_{u,\pm}(1)-\int_1^\infty E(x)f'_{u,\pm}(x)\,dx. \tag{4a}
\]
For \(h=h_t\), the derivative is understood piecewise across the single absolute-value cusp. The test is continuous there, so no contact atom appears. Its large-\(x\) decay makes the boundary at infinity zero.

## The explicit test and PNT error

The kernel expansions \(K(z)=-z^{-1/2}+O(1)\) at zero and \(K(z)=O(z^{-3/2})\) at infinity, together with \(K'(z)=-b(z)/(2z)\), imply
\[
 |H(z)|+|zH'(z)|\le C\min(1,z^{-1})\qquad(z>0). \tag{5}
\]
In particular \(h_t\) is bounded uniformly in \(t\). Its \(L^2\) and weak derivative norms satisfy
\[
 \|h_t\|_2^2+\|h_t'\|_2^2\le C(1+V),
 \qquad V=\log(1/t),                              \tag{6}
\]
by integrating (5) over the plateau \(|v|\le V\) and its exponential tails. Since \(G\) belongs to the physical logarithmic form space,
\[
 |A(G,h_t)|\le C_{R,\psi}\sqrt{1+V},\qquad
 \left|\iint G(u)h_t(v)e^{-|u-v|/2}\,du\,dv\right|
 \le C_{R,\psi}.                                  \tag{7}
\]

Use the complete unconditional PNT error in the form
\[
 |E(x)|\le C x e^{-a\sqrt{\log x}}\qquad(x\ge x_0) \tag{8}
\]
for fixed absolute \(a,C,x_0>0\). This follows from [Trudgian's Theorem 1](https://arxiv.org/pdf/1401.2689), which explicitly bounds the full prime-power \(\Psi(x)\); its logarithmic polynomial prefactor is absorbed by reducing \(a\). Put \(X=e^{V/2}\) and first restrict to \(|u|\le V/4\). The low part \(1<x\le X\) of \(\mathcal D\) has absolute value \(O(\sqrt X)=O(e^{V/4})\), by \(|h_t|\le C\), the elementary complete Chebyshev estimate
\(\sum_{n\le X}\Lambda(n)/\sqrt n\le C\sqrt X\), and \(\int_1^Xx^{-1/2}dx\le2\sqrt X\).

For \(x>X\) and \(|u|\le V/4\), the two tests become \(H(\tau_\pm x)\), with \(\tau_\pm=t e^{\pm u}\). Their transition points \(Y_\pm=\tau_\pm^{-1}\) satisfy \(Y_\pm\ge e^{3V/4}>X\). By (5),
\[
 \left|\frac d{dx}[x^{-1/2}H(\tau_\pm x)]\right|
 \le Cx^{-3/2}\min(1,Y_\pm/x).                    \tag{9}
\]
Stieltjes integration by parts on \((X,\infty)\), retaining \(-E(X)f(X)\), and (8)–(9) give
\[
 \begin{split}
 \left|\int_{(X,\infty)}x^{-1/2}H(\tau_\pm x)dE(x)\right|
 &\le C e^{-a\sqrt{V/2}}
 \left[\sqrt X+\int_X^{Y_\pm}x^{-1/2}dx
 +Y_\pm\int_{Y_\pm}^\infty x^{-3/2}dx\right]\\
 &\le C\sqrt{Y_\pm}\,e^{-a\sqrt{V/2}}\\
 &\le Ct^{-1/2}e^{|u|/2}e^{-a\sqrt{V/2}} .
 \end{split}                                      \tag{10}
\]
The \(x=1\) density endpoint and any prime-power atom at \(X\) are in the low part under this convention.

For \(|u|>V/4\), use (5) and Chebyshev directly on the prime and density sums. Split their \(x\)-integrals at \(e^{V+|u|}\). Below it, the total is at most \(Ct^{-1/2}e^{|u|/2}\); above it, (5) and \(\sum_{n>N}\Lambda(n)n^{-3/2}\le CN^{-1/2}\) give the same bound. Thus the omitted \(u\)-tail in \(\mathcal D\) is at most
\[
 Ct^{-1/2}\int_{|u|>V/4}G(u)e^{|u|/2}du
 \le C_{R,\psi}t^{-1/2}\exp[-c_0e^{V/2}],          \tag{11}
\]
using \(G\le\|\psi\|_\infty\Phi\) and the theta envelope. Finally \(\int G e^{|u|/2}<\infty\), so (10)–(11) and the low part imply
\[
 |\mathcal D(G,h_t)|
 \le C_{R,\psi}t^{-1/2}e^{-c_1\sqrt V}.            \tag{12}
\]
Combine (4), (7), and (12), reducing \(c_1\) if needed to absorb \(O(\sqrt V)\), to prove (1).

This is a written fixed-core bound. Its \(t^{-1/2}\) exponent still permits the \(t^{1/2-\beta}\) growth caused by a hypothetical off-critical zero with \(\beta<1\), so it cannot establish RH. No Lean proof of the Stieltjes or weak-form passage is claimed.
