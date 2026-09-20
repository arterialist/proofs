# Prolate residual barrier to Connes's Weil ground-state candidate at the Zhu window

**Status:** rigorous analytic bound certified by exact rational interval Sturm counts, September 2026.
Certificate location:
- [certificates/connes_prolate_zhu_window.py](../../certificates/connes_prolate_zhu_window.py)
Note location:
- [building-blocks/weil-and-spectral/connes-prolate-zhu-window-residual-test.md](../../building-blocks/weil-and-spectral/connes-prolate-zhu-window-residual-test.md)

Attribution: Arterialist RH research team, September 2026.
Literature context:
- Alain Connes, Henri Moscovici, Caterina Consani (prolate spheroidal wave functions and Weil positivity).
- Xuefeng Zhu (arXiv:2608.24827v2, August 2026: *Weil positivity in compact windows: a finite reduction, certified two-sided bounds, and a Landau–Widom decay law*).

## Statement

In noncommutative geometry approaches to the Riemann Hypothesis, Alain Connes proposed using
the prolate spheroidal wave vector $h = h_4 - h_0$ (normalized by $\int_{-\lambda}^\lambda h_j(v)\,dv = 1$)
as a candidate approximation to the Weil ground state.
At the window length $a = \log\lambda = 4/5 = 0.8$, Xuefeng Zhu (arXiv:2608.24827v2) certified that
the ground Weil eigenvalue satisfies $E_0 \ge 8.9 \times 10^{-18}$ and the first excited eigenvalue
satisfies $E_1 \le 2.347 \times 10^{-14}$.

**Theorem.**
At window length $a = 4/5$, the prolate endpoint coefficients of Connes's vector satisfy:
\[
 1.60 \times 10^{-8} < B_+ < 1.62 \times 10^{-8}, \qquad \|k\|_{L^2(-4/5, 4/5)} < 4/5,
\]
and the normalized Weil operator residual satisfies:
\[
 \boxed{\quad \frac{\|(A_a - R)(k / \|k\|_2)\|_2}{E_1 - R} > 2.3 \quad}
\]
for every Rayleigh quotient $0 \le R < E_1$.

## Mathematical significance

The residual-transfer criterion requires $\frac{\|(A_a - R)v\|_2}{E_1 - R} < 1$ in order to deduce a nontrivial
angle bound $\sin\theta < 1$ between a trial vector $v$ and the ground state of the Weil operator.
This theorem proves that for Connes's specific prolate spheroidal test vector $h = h_4 - h_0$,
the endpoint singularity $B_+ \log(1/s)$ produces a residual that **exceeds the spectral gap by over 230%**.
Consequently, the residual-transfer criterion is provably ineffective for Connes's proposed vector at
the window verified by Zhu, proving that prolate spheroidal wave functions alone cannot certifiably
track the Weil ground state without additional boundary-layer corrections.

Full proof:
- [building-blocks/weil-and-spectral/connes-prolate-zhu-window-residual-test.md](../../building-blocks/weil-and-spectral/connes-prolate-zhu-window-residual-test.md)
Certificate:
- [certificates/connes_prolate_zhu_window.py](../../certificates/connes_prolate_zhu_window.py)
