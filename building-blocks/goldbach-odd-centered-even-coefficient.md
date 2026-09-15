# The exact even coefficient of the odd-centered source

The odd-total vanishing, state-one pair, finite centered expansion and
exact odd count at N=2m are compiled in
[GoldbachOddPairs.lean](BuildingBlocks/GoldbachOddPairs.lean). The
power-of-two pair classification and proper-power estimate below remain
written mathematics. This complements the finite-energy parity reduction
and distinguishes prime Goldbach representations from complete Mangoldt pairs.

Let o_n=Lambda(n)-2 for odd n>=1 and zero for even n. Put
A_o(N)=sum_(a+b=N) o_a o_b, over ordered positive integers.
It vanishes for odd N. For even N>=2, expansion retains the m=N/2
odd positions and gives

\[
A_o(N)=R_{\rm odd}(N)-4\Psi_{\rm odd}(N-1)+2N,
\]

where R_odd sums Lambda(a)Lambda(b) over odd a,b and Psi_odd is
the full odd Mangoldt prefix. The coefficient at N=2 is 4, from
o_1=-2; that endpoint is part of the source.

Let L_2(X) be the number of positive k with 2^k<=X. Exactly
Psi_odd(X)=psi(X)-(log2)L_2(X). For an even total the only other
nonzero Mangoldt pairs are even-even pairs, hence

\[
A_o(N)=R_\Lambda(N)-(\log2)^2r_2(N)
-4\psi(N-1)+4(\log2)L_2(N-1)+2N,              \tag{1}
\]

with r_2(N)=#{(j,k):j,k>=1,2^j+2^k=N}, ordered. Binary uniqueness
gives r_2(N)=1 when N=2^r with r>=2, r_2(N)=2 when its binary
expansion has exactly two nonzero bits, both above the units bit,
and zero otherwise. In particular this complete even-power pair
correction is bounded by 2(log2)^2. It is evaluated, not deleted.

For N>4, ordinary prime Goldbach is equivalent to positivity of
the odd-prime weighted pair count R_prime,odd(N). The difference
R_odd(N)-R_prime,odd(N) is nonnegative and counts pairs having
at least one odd proper prime power. A crude unconditional bound is

\[
0\le R_{\rm odd}(N)-R_{\rm prime,odd}(N)
\le C\sqrt N(\log(2N))^3.                    \tag{2}
\]

Indeed there are at most sum_(k=2..floor(log_2 N)) N^(1/k)
<=C sqrt N log(2N) proper powers up to N, even allowing composite
bases. Each specified endpoint determines its complementary integer,
there are two orientations, and each Mangoldt product is at most
(log N)^2. Overcounting endpoints occurring in two descriptions only
enlarges this upper bound.

Thus an actual lower bound for the right side of (1) after reversing
the centering, exceeding the error in (2), would prove existence of
two odd primes. Neither such a lower bound nor the positive-norm
RH estimate is proved here. A positive complete Mangoldt pair count
alone can be paid by proper powers, while a finite centered heat norm
is a different quantitative condition. The two targets must remain
separate even after the exact parity reduction.
