# Canonical cell 9 and an uncut even-hat observation

At radius two, the
[published canonical cutoff](canonical-finite-prime-observation-and-ground-input.md#2-what-the-published-theorem-actually-chooses)
is

\[
 E_4=\{u\in O_2: |u|\le4,\ \operatorname{dist}(u,[-2,2])\ge1/4,\
          1/4\le\psi_2(u)\le4,\ \ell(u)\le4\},
\]

where \(\ell=q_{\rm p}^{\gamma}(u,O_2)\) is the **complete**
prime-power departure rate. The geometric \(q=3,+\), start-cell 6
interval is \(I=(9/4,4-\log3)\), with \(v=u+\log3\in
(9/4+\log3,4)\). Write

\[
 A_9=\{u\in I:
 1/4\le\psi_2(u),\psi_2(v)\le4,\
 \ell(u),\ell(v)\le4\}.
\]

The canonical cell mass is exactly

\[
 m_9={\log3\over\sqrt3}
 \int_{A_9}
 {\psi_2(u)\psi_2(v)\Phi(u)\Phi(v)\over
  (a+\ell(u))(a+\ell(v))}\,du.                         \tag{1}
\]

The normalized ground is positive almost everywhere; \(\Phi\) is
positive and \(a>0\). On this compact strip the complete \(\ell\)
series is finite almost everywhere from the published bounded-ground
and theta-tail estimates. Therefore

\[
 m_9>0\quad\Longleftrightarrow\quad |A_9|>0.          \tag{2}
\]

A quantitative sufficient certificate is a measurable \(J\subset I\)
with \(|J|>0\) and the four simultaneous cutoff inequalities on
\(J\) and \(J+\log3\). If \(\Phi_{\min}=\min_{[9/4,4]}\Phi>0\)
and \(a\le\bar a\), then

\[
 m_9\ge {\log3\over\sqrt3}\,
       {\Phi_{\min}^{\,2}|J|\over16(\bar a+4)^2}>0.
                                                               \tag{3}
\]

The published radius-two facts give global \(L^2\) normalization,
positivity, a coarse upper bound on \(\psi_2\), and positive ground
mass on a strip whose outer endpoint is selected later. They do not
give a local lower bound \(\psi_2\ge1/4\) at a translated pair in
\(I\), nor the simultaneous upper bounds \(\psi_2\le4\) and
\(\ell\le4\) there. The existing validated-Galerkin plan explicitly
lists local/translated ground enclosures and \(\ell\)-series
enclosures as missing numerical inputs. Thus (2) is an exact missing
theorem, and the canonical odd-reflection witness cannot be made
unconditional from the published estimates.

There is a distinct *uncut* finite test. Restrict the full
\(\mathsf P_1\), with no \(E_4\) factor, to the same geometric
\(q=3,+\) interval \(I\). Its mass is strictly positive: its
integrand is positive almost everywhere on \(I\). It is also a
well-typed observation of every \(F\in L^2(\gamma)\):
the published marginal inequality
\(\mathsf P_1(du,O_2)\le a^{-1}\gamma(du)\) and reversal symmetry give

\[
 \int|F(v)-F(u)|^2\,d\mathsf P_1
 \le {4\over a}\|F\|_{L^2(\gamma)}^2.                 \tag{4}
\]

Indeed, the pointwise square is at most
\(2(|F(v)|^2+|F(u)|^2)\); symmetry makes the two endpoint
integrals equal, and the marginal bound pays each. Restricting to
the one geometric cell only decreases the left side. Its normalized
cell observation therefore obeys
\[
 \left|{1\over\sqrt{2m_9^{\rm full}}}
  \int_{D_9^{\rm full}}(F(v)-F(u))\,d\mathsf P_1\right|^2
 \le {2\over a}\|F\|_{L^2(\gamma)}^2.               \tag{5}
\]
This uncut observation is **not** a row of the published canonical
\(\sigma_4\) Galerkin map, whose cells require \(u,v\in E_4\).

Take \(h=1_{[e^{13/4},e^4]}\), which is an admissible bounded
compact clock test. For every \(|\theta|<X^{-1/2}\), its \(Z_1,Z_2\)
vanish at the start \(u<3\), are positive-amplitude at the end
\(v>13/4\), and vanish on the reflected negative cell.
Their centred versions have the same edge differences. In raw uncut
rows, the reflected row 10 vanishes and
\[
\begin{aligned}
 r_9(Y_1)-r_{10}(Y_1)&=e^{i\theta}A_1, &
 A_1&=\int_I d(v)c_{1,X}(e^v)\,d\mathsf P_1(3,+;u)>0,\\
 r_9(Y_2)-r_{10}(Y_2)&=e^{2i\theta}A_2, &
 A_2&=\int_I d(v)s_X(e^v)c_{1,X}(e^v)\,
                         d\mathsf P_1(3,+;u)>0.
\end{aligned}                                                   \tag{6}
\]
The amplitudes \(d,c_{1,X},s_X\) are the explicit
[source factors](collective-lambert-first-source-range-audit.md#1-canonical-smeared-columns).
Both integrals are positive because the uncut cell has positive mass.
The coherent difference has positive real amplitude after removal
of \(e^{i\theta}\), because \(1-s_X(e^v)\cos\theta>0\).
Each of the five even-hat crossing columns has equal uncut
observations on cells 9 and 10 by reflection. Thus these chosen
targets are excluded from the **five-even-hat span**. The same
statement is not asserted for an arbitrary \(h\), the full core
range, or RH.

[UncutEdgeParityFinite.lean](BuildingBlocks/UncutEdgeParityFinite.lean)
compiles the finite factor-four symmetric-edge estimate from explicit
marginal and reflection hypotheses, and the finite algebra excluding
an odd target row from an even-hat span. The actual
\(\mathsf P_1\) marginal, ground positivity, and uncut cell geometry
are analytic inputs from the linked theta construction and the
[first-cell ledger](radius-two-first-edge-cell-geometry.md), not
Lean-proved here.
