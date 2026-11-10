"""Perfect counting, unique factorization and the functional equation do not force RH for abstract systems
of function-field type.

Abstract system: P(n) 'primes' of degree n, G(n) elements of degree n, Z(u) = sum G(n) u^n = prod (1-u^n)^(-P(n)).
Genus-one shape: Z(u) = (1 - a u + q u^2) / ((1-u)(1-qu)), which satisfies the functional equation of a curve of
genus one over a field with q elements. Real curves have |a| <= 2 sqrt(q) (Hasse), which is the Riemann hypothesis.
For q = 5 the values a = -5, 5, 6 give nonnegative integer P(n), an exactly geometric G(n), the functional equation,
and zeros off the circle |u| = q^(-1/2). Exact integer arithmetic; checks n <= 40."""
from fractions import Fraction
import math

def mobius(n):
    r = 1; p = 2; m = n
    while p * p <= m:
        if m % p == 0:
            m //= p
            if m % p == 0: return 0
            r = -r
        p += 1
    return -r if m > 1 else r

def system(q, a, N=40):
    s = [2, a]
    for n in range(2, N + 1): s.append(a * s[-1] - q * s[-2])
    c = [0] + [q**n + 1 - s[n] for n in range(1, N + 1)]          # c_n = sum_{d|n} d P(d)
    P = [0]; ok = True
    for n in range(1, N + 1):
        tot = sum(mobius(n // d) * c[d] for d in range(1, n + 1) if n % d == 0)
        ok = ok and tot % n == 0 and tot >= 0
        P.append(tot // n)
    G = [1]                                                        # n G(n) = sum_k c_k G(n-k), from the Euler product
    for n in range(1, N + 1):
        G.append(sum(c[k] * G[n - k] for k in range(1, n + 1)) // n)
    return P, G, ok

if __name__ == "__main__":
    q, a = 5, 5
    P, G, ok = system(q, a)
    print(f"q={q}, a={a}; Hasse bound |a| <= {2*math.sqrt(q):.3f}")
    print("P(1..10) =", P[1:11], " nonnegative integers up to n=40:", ok)
    print("G(0..8)  =", G[:9], " equals (5^n - 1)/4 for 1 <= n <= 40:", all(Fraction(q**n - 1, 4) == G[n] for n in range(1, 41)))
    w1 = (a + math.sqrt(a*a - 4*q)) / 2; w2 = q / w1
    print(f"inverse zeros {w1:.4f}, {w2:.4f}; sqrt(q) = {math.sqrt(q):.4f}; exponents {math.log(w1)/math.log(q):.4f}, {math.log(w2)/math.log(q):.4f} (RH needs 0.5)")
    for a in range(-6, 8):
        P, G, ok = system(5, a)
        print(f"  a={a:+d}: legitimate={ok}  obeys RH={abs(a) <= 2*math.sqrt(5)}  P(1)={P[1]}")
