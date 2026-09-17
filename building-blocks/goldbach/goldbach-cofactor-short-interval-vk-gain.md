# A short-interval bound for the signed Goldbach cofactor

Let every occurrence of \(\Lambda\) include prime powers. For integers \(s\ge4\), put

\[
E(x)=\psi(x)-x,\qquad q_y=\frac{E(y)}y,\qquad b_m=\Lambda(m)-1,
\qquad Q_s=\sum_{m=2}^{s-2}\Lambda(m)q_{s-m}.
\]

Write

\[
\Phi(X)=\frac{(\log X)^{3/5}}{(\log\log X)^{1/5}},\quad
A_0=\frac1{48.0718},\quad
d=\left(\frac{5^6A_0^3}{2^2 3^4}\right)^{1/5},\quad
J(\lambda)=\frac{3d}{5}\left(\frac{2d/5}{\lambda}\right)^{2/3}.
\tag{1}
\]

The [finite linear split](../../formalization/BuildingBlocks/GoldbachCofactorLinearSplitFinite.lean) gives exactly

\[
Q_s=L_s+V_s,\qquad
L_s=\sum_{y=2}^{s-2}q_y,\qquad
V_s=\sum_{m=2}^{s-2}b_m q_{s-m}.
\tag{2}
\]

The [linear-term proof](goldbach-linearized-pointwise-vk-gain.md) establishes, for every \(\varepsilon>0\),

\[
|L_s|\ll_\varepsilon s\exp[-(c_2-\varepsilon)\Phi(s)],
\qquad c_2=2^{2/5}d.
\tag{3}
\]

Here is a bound for the centered term that is slightly stronger.

**Theorem.** For every fixed \(\varepsilon>0\),

\[
\boxed{|V_s|\ll_\varepsilon
s\exp[-(d+J(d)-\varepsilon)\Phi(s)]},\qquad
\boxed{|Q_s|\ll_\varepsilon
s\exp[-(c_2-\varepsilon)\Phi(s)]}.
\tag{4}
\]

Numerically,

\[
d=0.212579202120942\ldots,\quad J(d)=0.069243447739053\ldots,
\quad d+J(d)=0.281822649859995\ldots,
\quad c_2=0.280499938864373\ldots.
\tag{5}
\]

The margin is \(d+J(d)-c_2=0.001322710995622\ldots>0\).
It can be checked without relying on rounded values:
\(0.5428^3<0.4^2\) and \(1.3196^5>4\) imply
\(1+\frac35(\frac25)^{2/3}>1.32568>1.3196>2^{2/5}\).
Thus \(c_2\) is the exponent of the *separately bounded linear term* in
this proof. It is not a claim about the best possible bound on \(Q_s\):
cancellation between \(L_s\) and \(V_s\) could give more.

## Inputs and a uniform interval estimate

We use four established inputs. [Bellotti's zero-free region](https://arxiv.org/pdf/2306.10680)
gives \(\beta\le1-A_0u(|\gamma|)\) for every sufficiently high nontrivial
zero \(\rho=\beta+i\gamma\), where
\(u(t)=(\log t)^{-2/3}(\log\log t)^{-1/3}\).
[Ingham's density estimate](https://arxiv.org/pdf/2507.15184) gives

\[
N(\sigma,t)\ll t^{3(1-\sigma)/(2-\sigma)}(\log t)^5
\qquad(1/2\le\sigma\le1),
\tag{6}
\]

with zeros counted with multiplicity. [Johnston's PNT transfer](https://arxiv.org/pdf/2411.13791)
gives, for every \(\eta>0\),

\[
|E(x)|\ll_\eta x\exp[-(d-\eta)\Phi(x)].
\tag{7}
\]

Finally, [Cully-Hugill and Johnston, Theorem 1.1](https://arxiv.org/pdf/2402.04272)
gives, for any \(0<\alpha\le1/2\), every sufficiently large real \(x\),
and *every* \(T\) in
\(\max\{51,\log x\}<T<(x^\alpha-2)/2\),

\[
E(x)=-\sum_{|\gamma|\le T}\frac{x^\rho}{\rho}
+O\left(\frac{x\log x}{T}\right).
\tag{8}
\]

We use this version, with the same chosen \(T\) at two endpoints.
Their Theorem 1.3 selects a height \(T^*\) for an interval; the
arbitrary-height Theorem 1.1 makes the common choice explicit here.

**Uniform short-interval lemma.** Fix \(K>0\) and fixed \(0<a<b\).
For every \(\eta>0\), uniformly over
\(\lambda\in[d,d+K]\), \(aX\le x\le bX\), and
\(0\le h\le H:=X\exp[-\lambda\Phi(X)]\), one has

\[
|E(x+h)-E(x)|\ll_{K,a,b,\eta}
H\exp[-(J(\lambda)-\eta)\Phi(X)].
\tag{9}
\]

To prove it, set \(F=\Phi(X)\), \(B=X/H=e^{\lambda F}\), and
\(\lambda_+=d+K\). Choose fixed \(\tau>\lambda_++J(d)+2\) and
\(T=e^{\tau F}\). For all the stated \(x,h,\lambda\), this single
\(T\) lies in the range of (8) at both \(x\) and \(x+h\) once \(X\)
is large. In particular, subtracting (8) yields an error
\(O(X\log X/T)\). Dividing it by \(H\) leaves
\(O(\log X\,e^{-(\tau-\lambda)F})\), uniformly smaller than the
right side of (9).

For each nontrivial zero, the integral and endpoint forms of the
interval kernel give

\[
\left|\frac{(x+h)^\rho-x^\rho}{\rho}\right|
\ll H X^{\beta-1}\min\left\{1,\frac{B}{|\rho|}\right\}.
\tag{10}
\]

All constants here are uniform in \(x\asymp X\) and \(h\le H\).
The optimization behind (1) is the uniform relation

\[
A_0u(e^{zF})\log X=(J(z)+o(1))F
\tag{11}
\]

for \(z\) in any fixed compact subinterval of \((0,\infty)\). Indeed,
\(J(z)=A_0(5/3)^{1/3}z^{-2/3}\); the equality with (1) follows
from the definition of \(d\).

Choose a small fixed \(z_0>0\) such that
\(J(z_0)-z_0>J(d)+2\). The zeros with
\(|\gamma|\le e^{z_0F}\) make a smaller contribution than (9).
To see this without invoking (11) at \(z=0\), isolate the finitely
many zeros below the threshold of Bellotti's theorem. Their real
parts have a fixed gap from \(1\), so (10) gives a power saving.
For the remaining zeros in this low range, the zero-free region,
\(N(t)\ll t\log t\), and monotonicity of \(u\) bound their total,
after division by \(H\), by

\[
\exp\{-[J(z_0)-z_0+o(1)]F\}.
\tag{12}
\]

It remains to sum dyadic blocks \(t\le|\gamma|<2t\) with
\(e^{z_0F}\le t\le T\). Write \(t=e^{zF}\), so
\(z\in[z_0,\tau]\); replacing \(t\) by \(2t\) changes (11) by
\(o(F)\), uniformly. Choose one sufficiently large fixed \(k>1\),
after \(\tau\), such that

\[
kJ(\tau)-\lambda_+>J(d)+2.
\tag{13}
\]

Call a zero on the block near if
\(\beta>1-kA_0u(2t)\). The density estimate (6), at
\(\sigma=1-kA_0u(2t)>1/2\), gives

\[
\#\{\text{near zeros on the block}\}
\ll (2t)^{3kA_0u(2t)/(1+kA_0u(2t))}(\log(2t))^5
=\exp(o(F)),
\tag{14}
\]

uniformly for \(z\in[z_0,\tau]\). Bellotti's region still gives
\(\beta\le1-A_0u(2t)\) for each such zero. By (10), its whole
block contributes at most

\[
H\exp\{-[J(z)+\max(z-\lambda,0)+o(1)]F\}.
\tag{15}
\]

For \(z\le\lambda\), \(J(z)\) decreases, so the exponent in (15)
is at least \(J(\lambda)\). For \(z\ge\lambda\), its derivative is
\(1-2J(z)/(3z)>0\), since \(z\ge\lambda\ge d\). It is again
at least \(J(\lambda)\).

The other zeros on the block have
\(\beta\le1-kA_0u(2t)\). Their crude number \(O(t\log t)\)
and (10) give a bound \(H\) times

\[
\exp\{-[kJ(z)-z+o(1)]F\}\quad(z\le\lambda),
\qquad
\exp\{-[kJ(z)-\lambda+o(1)]F\}\quad(z\ge\lambda).
\tag{16}
\]

The first rate decreases with \(z\) and the second is smallest at
\(z=\tau\). Both exceed \(J(d)+1\) by (13), uniformly over
\(\lambda\in[d,d+K]\). There are \(O(F)\) dyadic blocks, and
their count costs \(e^{o(F)}\). Equations (12), (15), and (16),
together with the truncation error, prove (9) after absorbing these
uniform \(o(F)\) losses into \(\eta F\). The argument treats all
\(h\le H\), including a block's last partial interval.

## Transfer to the centered cofactor

Put \(X=s\), \(F=\Phi(X)\), and fix \(K=0.35>d+J(d)\).
We use (9) on the slightly larger compact interval
\(\lambda\in[d,d+K+1]\). For every fixed
\(\kappa\in[0,K]\), uniformly in \(\kappa\),

\[
\Phi(Xe^{-\kappa F})=F+o(F).
\tag{17}
\]

The difference in (17) need not be bounded; all replacements below
retain an arbitrarily small exponent loss.

First remove both edges. For \(y=s-m\le Xe^{-KF}\), Chebyshev's
\(|E(y)|\ll y\) and \(|b_m|\ll\log X\) give

\[
\sum_{\substack{2\le m,y\le s-2\\m+y=s,\ y\le Xe^{-KF}}}
|b_mq_y|\ll Xe^{-KF}\log X.
\tag{18}
\]

For \(m\le Xe^{-KF}\), one has \(y\asymp X\), and (7) gives

\[
\sum_{\substack{2\le m,y\le s-2\\m+y=s,\ m\le Xe^{-KF}}}
|b_mq_y|
\ll_\eta X\exp[-(K+d-\eta)F]\log X.
\tag{19}
\]

Both rates exceed \(d+J(d)\). In the remaining sum, split at the
smaller coordinate: \(y\le s/2\) and \(m<s/2\), assigning an
equality at even \(s\) to the first side. On either side,
partition that coordinate from the edge cutoff to \(s/2\) into
clipped dyadic shells \([Y,2Y)\) or \([M,2M)\). Their bases have
the form \(Y=Xe^{-\kappa F}\) or \(M=Xe^{-\kappa F}\) with
\(0\le\kappa\le K+o(1)\), and there are \(O(F)\) shells.
The harmless \(o(1)\) at integer cutoffs is covered by the compact
interval specified above.

On a shell in \(y\le s/2\), the prime coordinate \(m=s-y\)
is \(\asymp X\). Divide the \(y\)-shell into integer blocks of
length at most

\[
H_Y=Y e^{-dF}=X e^{-(d+\kappa)F}.
\tag{20}
\]

The direction of \(m\) reverses, but every prefix of a block is a
contiguous prime interval of length at most \(H_Y\). Since
\(\sum_{a<m\le a+h}b_m=E(a+h)-E(a)\), (9) gives its centered
prime sum the bound
\(\ll H_Y e^{-(J(d+\kappa)-\eta)F}\), uniformly for all
full and partial blocks. Meanwhile (7) and (17) give

\[
\sup_{y\text{ in shell}}|q_y|
\ll_\eta e^{-(d-2\eta)F}.
\tag{21}
\]

The exact increment

\[
q_y-q_{y-1}=\frac{b_y}{y}-\frac{E(y-1)}{y(y-1)}
\tag{22}
\]

and Chebyshev's bound give variation at most
\(O(H_Y\log X/Y)=O(e^{-dF}\log X)\) on each block. Thus the
endpoint and variation budget in finite Abel summation is
\(\ll_\eta e^{-(d-2\eta)F}\). The generic endpoint-corrected
finite Abel identity and variation inequality are also compiled in
[GoldbachCofactorPointwiseAbelFinite.lean](../../formalization/BuildingBlocks/GoldbachCofactorPointwiseAbelFinite.lean);
reindexing it to each shell block and the interval estimate are
written steps. Explicitly, for any prime-index block \(a\le m\le b\),
put \(P(j)=E(j)-E(a-1)\). Then

\[
\sum_{m=a}^{b}b_mq_{s-m}
=P(b)q_{s-b}+\sum_{j=a}^{b-1}P(j)
  \bigl(q_{s-j}-q_{s-j-1}\bigr).
\]

Here \(P(j)\) uses the interval of length \(j-a+1\le b-a+1\le H_Y\),
including when the block was clipped at a shell edge. Every block costs

\[
\ll_\eta H_Y
e^{-[d+J(d+\kappa)-3\eta]F}.
\tag{23}
\]

There are \(O(Y/H_Y+1)=O(e^{dF})\) blocks, including the last
partial one. The shell therefore costs

\[
\ll_\eta Y e^{-[d+J(d+\kappa)-3\eta]F}
=X e^{-[\kappa+d+J(d+\kappa)-3\eta]F}.
\tag{24}
\]

The exponent is smallest at \(\kappa=0\), because

\[
\frac{d}{d\kappa}\bigl(\kappa+d+J(d+\kappa)\bigr)
=1-\frac{2J(d+\kappa)}{3(d+\kappa)}>0.
\tag{25}
\]

On the other side, \(m\le s/2\), put
\(M=Xe^{-\kappa F}\) for a shell and divide it into blocks of
length at most \(H_M=M e^{-dF}\). Here \(y=s-m\asymp X\), so
\(|q_y|\ll_\eta e^{-(d-\eta)F}\), and (22) gives block variation
\(O(H_M\log X/X)\ll e^{-dF}\log X\). Apply (9) with base scale
\(M\) and parameter
\(\lambda_M=dF/\Phi(M)=d+o(1)\). Formula (17) gives

\[
\sup_{0\le h\le H_M}|E(a+h)-E(a)|
\ll_\eta H_M e^{-(J(d)-2\eta)F}
\tag{26}
\]

for every block start \(a\asymp M\). Finite Abel summation and
\(O(M/H_M+1)\) blocks therefore bound this shell by

\[
\ll_\eta M e^{-[d+J(d)-4\eta]F}
=X e^{-[\kappa+d+J(d)-4\eta]F}.
\tag{27}
\]

Take \(0<\eta<\min\{\varepsilon,d+J(d)-c_2\}/100\).
The \(O(F)\) shells, the factors \(\log X\) in (18)--(22),
the scale conversion (17), and integer clipping cost less than
another \(4\eta F\) for sufficiently large \(X\). Summing
(18)--(19), (24), and (27) proves the first bound in (4), with
\(8\eta<\varepsilon\). The strict margin in (5) then combines it
with (3) to give the second bound in (4). Enlarging the implied
constant covers the remaining finite values of \(s\).

This is an unconditional Vinogradov--Korobov-scale gain for the
unsmoothed \(Q_s\), not an RH-scale estimate. The analytic short-interval
lemma and shell transfer above are written proofs, not Lean theorems.
The Lean files cited here cover the exact finite split and Abel
algebra, with no analytic zero estimate formalized. We make no
literature-priority claim for the analytic bound.

The [subleading refinement](goldbach-cofactor-subleading-vk-gain.md)
retains Bellotti's exact logarithms and strengthens the full signed
bound to \(s\exp[-c_2\Phi(s)-\theta\Phi(s)\log\log\log s/\log\log s]\)
for every \(\theta<c_2/15\).
