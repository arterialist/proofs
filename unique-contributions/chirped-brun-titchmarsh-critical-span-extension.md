# Chirped Brun–Titchmarsh Weil constellation beyond critical span

**Status:** unconditional written analytic proof, 18 September 2026.
The finite Hermitian row-bound and diagonal dominance algebra are compiled in
[CriticalChirpedGramFinite.lean](../formalization/BuildingBlocks/CriticalChirpedGramFinite.lean).
Attribution: Arterialist RH research team, September 2026.
To the best of our knowledge, the extension of Weil form positivity for structured
families of packets up to support span $2\log T + 2\log\log T$ has not previously
appeared in the literature.

## Statement

Fix profile $a \in C_c^\infty((0, w))$ with $0 < w < \log 2$, chirp parameter
$0 < \eta < 1/(8w)$, and the exactly pole-null packet
\[
 q_T(x) = \frac{(\partial_x^2 - 1/4)\{a(x) e^{i\eta T x^2 - iTx}\}}{\|(\partial_x^2 - 1/4)\{a(x) e^{i\eta T x^2 - iTx}\}\|_2}.
\]
Let $Q$ denote the complete actual-zeta Weil form.

**Theorem.** Given $0 < \epsilon < 1$, there exist fixed constants $B > 0$ and $T_0$
such that, for all $T \ge T_0$, every ordered center set satisfying
\[
 0 \le x_1 < \cdots < x_M \le 2\log T + 2\log\log T - B, \qquad x_{j+1} - x_j > w,
\]
and every complex coefficient vector satisfy
\[
 \boxed{\quad
 Q\left( \sum_{j=1}^M c_j \tau_{x_j} q_T \right) \ge (1-\epsilon) \log T \sum_{j=1}^M |c_j|^2.
 \quad}
\]
The statement includes every prime power $\Lambda(p^k) = \log p$, both poles, and
the exact archimedean gamma term. The constellation allows $M = O_w(\log T)$ translates.

## Mathematical mechanism

1. **Pole annihilation:** The differential operator $(\partial_x^2 - 1/4)$ forces
   $E_{\pm 1/2}(q_T) = 0$ identically, completely removing the $s=0$ and $s=1$ pole terms.
2. **Chirp dispersion:** The quadratic phase $e^{i\eta T x^2}$ creates a linearly varying
   instantaneous frequency $\omega(x) = -T + 2\eta T x$. Off-diagonal prime correlations
   between translates at distance $\Delta x = x_k - x_j$ sample primes with non-stationary
   phases, yielding power-decay savings via van der Corput.
3. **Brun–Titchmarsh prime mass bound:** Montgomery and Vaughan's arbitrary-interval
   Brun–Titchmarsh theorem $\pi(u+h) - \pi(u) < 2h/\log h$ bounds the total prime mass
   in short intervals up to $e^{2\log T + 2\log\log T} = T^2 (\log T)^2$.
4. **Hermitian row dominance:** The sum of off-diagonal rows is strictly bounded by
   $\epsilon \log T$, ensuring that the diagonal archimedean term $\log T$ dominates
   the entire Gram matrix.

Full proof: [building-blocks/weil-and-spectral/chirped-brun-titchmarsh-span-constellation.md](../building-blocks/weil-and-spectral/chirped-brun-titchmarsh-span-constellation.md).
Formalization: [formalization/BuildingBlocks/CriticalChirpedGramFinite.lean](../formalization/BuildingBlocks/CriticalChirpedGramFinite.lean).
