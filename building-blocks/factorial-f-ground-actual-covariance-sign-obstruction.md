# Actual-source covariance has no local sign

2026-09-16. **Status:** unconditional obstruction to a local sign or jump-variance argument for the full factorial-ground score. It does not estimate the dyadic score or establish an eventual sign for its dyadic covariance.

Let \(\psi(x)=\sum_{n\le x}\Lambda(n)\), \(E(x)=\psi(x)-x\), and use the actual factorial ground
\[
 F(x)=\log x-\sum_{n\le x}\frac{\Lambda(n)}n+\frac{\psi(x)}x,
 \qquad F'(x)=-\frac{E(x)}{x^2},\qquad
 F(x)\longrightarrow\kappa_F=1+\gamma>0.
\]
The jumps in the two sum terms cancel, so \(F\) is continuous. For \(v\ge\log2\), put
\[
 r(v)=\frac{E(e^v)}{e^vF(e^v)},\quad
 dB(v)=\sum_{n\ge2}\frac{\Lambda(n)}{nF(n)}\delta_{\log n}(dv)
                  -\frac{dv}{F(e^v)},\quad
 a_n=\frac{\Lambda(n)}{nF(n)}.
\]
The exact source equation is \(dr+(r-r^2)dv=dB\). At a prime power \(n\), \(\Delta r(\log n)=a_n\). In every finite interval \((a,b]\), the finite-variation chain rule therefore gives
\[
 2\int_{(a,b]}r(v-)\,dB(v)
 =r(b)^2-r(a)^2+2\int_a^b(r^2-r^3)\,dv
   -\sum_{e^a<n\le e^b}a_n^2.                         \tag{1}
\]
This identity has no coercive sign: the source covariance on the left is signed.

For integers \(N\ge2\), the covariance on a complete dyadic log block has an exact finite arithmetic form. Since \((1/F)'=E/(x^2F^2)\) away from the atoms,
\[
\begin{aligned}
 C_N&:=\int_{(\log N,\log 2N]}r(v-)\,dB(v)\\
 &=\sum_{N<n\le2N}
   \frac{\Lambda(n)[\psi(n^-)-n]}{n^2F(n)^2}
   +\frac1{F(N)}-\frac1{F(2N)}.                          \tag{2}
\end{aligned}
\]
Every prime-power atom in \((N,2N]\) is retained. Direct finite evaluation of (2), independently checked from the stated finite sums, gives
\[
 C_2=0.18356725634275\ldots,\quad
 C_3=0.04265035231511\ldots,\quad
 C_4=-0.03618010419808\ldots,\quad
 C_5=0.00667426789782\ldots .                         \tag{3}
\]
Thus even complete dyadic blocks have no universal sign. These four values make no claim about an eventual dyadic sign.

The jump-square term in (1) has a definite arithmetic scale:
\[
 Q_N:=\sum_{N<n\le2N}a_n^2
 \sim\frac{\log N}{2\kappa_F^2N}.                       \tag{4}
\]
Indeed \(F(n)=\kappa_F+o(1)\) uniformly on the block. The prime contribution is
\(\sum_{N<p\le2N}(\log p)^2/p^2\sim(\log N)/(2N)\) by the prime number theorem and partial summation; proper prime powers contribute \(O(N^{-3/2}\log^3N)\).

There is a stronger local obstruction for the *actual* von Mangoldt source. At each prime power \(n\),
\[
 \bigl(r_-dB\bigr)(\{\log n\})
 =\frac{\Lambda(n)E(n^-)}{n^2F(n)^2},
 \qquad
 \frac{\bigl(r_-dB\bigr)(\{\log n\})}{a_n^2}
 =\frac{E(n^-)}{\Lambda(n)}.                              \tag{5}
\]
Littlewood's unconditional theorem states
\(E(x)=\Omega_\pm(\sqrt{x}\log\log\log x)\). For a positive excursion at \(x\), choose the last prime power \(n\le x\). The source is constant from \(n\) to \(x\), so
\[
 E(n^-)=E(x)+(x-n)-\Lambda(n)
       \ge c\sqrt{x}\log\log\log x-\log n
       \gg\sqrt n\log\log\log n.
\]
For a negative excursion at \(x\), choose the first prime power \(n>x\). The prime number theorem ensures \(n\le2x\) for all sufficiently large \(x\), and
\[
 E(n^-)=E(x)-(n-x)
       \le-c\sqrt{x}\log\log\log x
       \ll-\sqrt n\log\log\log n.
\]
Both sets of prime powers are unbounded. Since \(\Lambda(n)\le\log n\), (5) has both signs infinitely often and, along both sequences,
\[
 \left|\frac{(r_-dB)(\{\log n\})}{a_n^2}\right|
 \gg\frac{\sqrt n\log\log\log n}{\log n}\longrightarrow\infty. \tag{6}
\]
The continuous part of \(r_-dB\) has locally integrable density. Its integral over a sufficiently short log interval around each such prime power tends to zero while the atom remains, so even arbitrarily late *local integrated* covariances occur with both signs. Equation (6) rules out controlling each source-covariance atom by its jump square, or obtaining a coercive local energy inequality solely from source positivity, the ground equation, and the exact Euler-product weights. Cancellation across a full dyadic block or in the smoothed score \(J(\log Y)\) remains an independent arithmetic question.

Reference for the unconditional oscillation used above: [Nathan Ng, *Prime Number Error Terms*, p. 2](https://moore.pims.math.ca/sites/default/files/lecture-extra-files/CPNTS2024_0.pdf), recording Littlewood's theorem. The original research paper is [Hardy and Littlewood, *Contributions to the theory of the Riemann zeta-function and the theory of the distribution of primes*](https://projecteuclid.org/journals/acta-mathematica/volume-41/issue-none/Contributions-to-the-theory-of-the-riemann-zeta-function-and/10.1007/BF02422942.pdf).
