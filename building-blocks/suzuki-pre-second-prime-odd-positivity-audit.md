# Certified odd pole-free positivity through the second-prime threshold

The [first-window certificate](suzuki-reflected-two-half-window-positive-certificate.md) extends to the largest interval on which only the reflected \(n=2\) prime shift has positive-measure overlap. The [Arb certificate](certificates/suzuki_odd_pre_second_prime_endpoint.py) and its operator normalization have been independently checked. The resulting bound is
\[
\boxed{L_a^{\rm odd}\ge \frac1{625}I\qquad(0<a\le (\log3)/2).}
\]

Let \(a_*=(\log3)/2\). At this endpoint, \(e^{2a_*}=3\), and the \(n=3\) shift touches the two interval endpoints only; its correlation is zero. Thus equation (2) of the first-window certificate remains exact with \(a=a_*\), \(\ell=\log2\), \(w=(\log2)/\sqrt2\), \(E=(\ell-a_*,a_*)\), and \(Ju(x)=u(\ell-x)\) on \(E\). The script asserts \(0<\ell-a_*<a_*\).

This time choose \(M=13/10\) and \(T=24\). The increasing digamma multiplier satisfies \(m(24)>M\) by Arb comparison. As before, let \(C=MI+wJ\), and dominate \((M-m(t))_+\) with a rational step function \(q\) on 300 cells of width \(2/25\), with denominator \(10^{12}\). Every cell's weight is chosen from an outward Arb upper endpoint and individually verified. The script proves \(w<1/2\), hence \(C>(4/5)I\), and \(\int_0^{24}q(t)dt<50\). Its mass enclosure centers at \(24.10534876303504\).

Using 24 odd Taylor terms for the sine kernel, \(24a_*<66/5\) gives the rational uniform remainder
\[
 R=\frac{(66/5)^{49}}{49!},\qquad 5R<10^{-6}.
\]
The same Hilbert–Schmidt estimate as in the first-window proof gives \(\|C^{-1/2}(B-B_{24})\|<5R\): indeed \(2a_*<11/10\), \(\pi>3\), \(\int q<50\), and \(C>4I/5\) make the squared coefficient less than \((11/10)(50)/(3(4/5))=275/12<25\).

The exact same polynomial integration and interval-Cholesky construction, now in dimension 24, verifies
\[
 G_U>0,\qquad (997/1000)I-H^*G_VH>0,
 \qquad G_U=HH^*.
\]
The smallest Cholesky pivot enclosures center at \(3.4112893028\cdot10^{-29}\) for \(G_U\) and \(0.02829669649\) for the second matrix, with radii below \(4\cdot10^{-266}\) and \(5\cdot10^{-291}\), respectively. Consequently
\[
 \|C^{-1/2}B\|^2<(\sqrt{997/1000}+10^{-6})^2<499/500,
\]
where the final comparison is also asserted by Arb. The endpoint bound is
\[
 L_{a_*}^{\rm odd}\ge (1-499/500)C>\frac1{625}I.
\]
Zero extension then yields the same lower bound for every \(0<a\le a_*\), since the full-space Weil form and the \(L^2\) norm of a zero-extended test function do not change.

The reproducible inputs are \(a_*=(\log3)/2\) as an Arb enclosure, rational \(M=13/10\), \(T=24\), 300 cells, denominator \(10^{12}\), Taylor rank 24, comparison \(997/1000\), rational sine-argument ceiling \(66/5\), error threshold \(10^{-6}\), and final norm ceiling \(499/500\). The script uses 1024-bit Arb via `python-flint==0.9.0` with FLINT 3.6.0. The bound says nothing about \(a>a_*\) or the odd rank-one return \(\tau_a\).
