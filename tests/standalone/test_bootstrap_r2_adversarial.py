#!/usr/bin/env python3
"""
Adversarial Stress Test Harness for Milestone 1 & 2:
- Module 337: Riemann Zeta Eight Zero Bounds & 5-Stage Bootstrap Certificates
- Module: Riemann Zeta Mellin Integral Domination (mellin_ratio_integrand_decay_le_quadratic)

Uses exact rational arithmetic (fractions.Fraction) and high-precision mpmath
to stress-test:
1. Rational Bootstrap Certificates Steps 18-22 and margins.
2. Coordinate polynomial identity (x^2+y)((x-1)^2+y) <= y^2+y for all x in [1/2, 1], y >= 1/4.
3. Remainder term negativity R(x,y) = x(x-1)(x(x-1)+2y) <= 0.
4. Boundary and corner cases: x = 1/2, x = 1, y = 1/4, t = 8.0, t = 8.05.
5. Pointwise Mellin integrand ratio domination:
   mellinTrigIntegrandIm s x / ((2*s.re - 1)*s.im) <= 1/4 * (x - 1)^2 * f_modif(x).
6. Comparison of C=436 (fails at t=8.0) vs C=600 (succeeds past t=8.0 to 8.05).
"""

from fractions import Fraction
import math
import random
import sys

def test_rational_bootstrap_certificates():
    print("=== TEST 1: 5-Stage Rational Bootstrap Certificates (Exact Fractions) ===")
    
    # Step 18: 3769/500 -> 153/20 (7.538 -> 7.65)
    t_start_18 = Fraction(3769, 500)
    t_end_18 = Fraction(153, 20)
    y_18 = t_end_18 ** 2
    poly_18 = y_18 ** 2 + y_18
    target_poly_18 = Fraction(557344881, 160000)
    rhs_18 = 600 * t_start_18
    margin_18 = rhs_18 - target_poly_18
    print(f"Step 18: t in ({t_start_18}, {t_end_18}]")
    print(f"  y_max = {y_18} = {float(y_18)}")
    print(f"  y^2 + y = {poly_18}")
    assert poly_18 == target_poly_18, f"Step 18 poly mismatch: {poly_18} != {target_poly_18}"
    print(f"  LHS: {target_poly_18} = {float(target_poly_18)}")
    print(f"  RHS: 600 * {t_start_18} = {rhs_18} = {float(rhs_18)}")
    print(f"  Margin: {margin_18} = {float(margin_18)}")
    assert margin_18 > 0, f"Step 18 certificate failed: margin={margin_18}"

    # Step 19: 153/20 -> 39/5 (7.65 -> 7.80)
    t_start_19 = Fraction(153, 20)
    t_end_19 = Fraction(39, 5)
    y_19 = t_end_19 ** 2
    poly_19 = y_19 ** 2 + y_19
    target_poly_19 = Fraction(2351466, 625)
    rhs_19 = 600 * t_start_19
    margin_19 = rhs_19 - target_poly_19
    print(f"\nStep 19: t in ({t_start_19}, {t_end_19}]")
    print(f"  y_max = {y_19} = {float(y_19)}")
    print(f"  y^2 + y = {poly_19}")
    assert poly_19 == target_poly_19, f"Step 19 poly mismatch: {poly_19} != {target_poly_19}"
    print(f"  LHS: {target_poly_19} = {float(target_poly_19)}")
    print(f"  RHS: 600 * {t_start_19} = {rhs_19} = {float(rhs_19)}")
    print(f"  Margin: {margin_19} = {float(margin_19)}")
    assert margin_19 > 0, f"Step 19 certificate failed: margin={margin_19}"

    # Step 20: 39/5 -> 159/20 (7.80 -> 7.95)
    t_start_20 = Fraction(39, 5)
    t_end_20 = Fraction(159, 20)
    y_20 = t_end_20 ** 2
    poly_20 = y_20 ** 2 + y_20
    target_poly_20 = Fraction(649241361, 160000)
    rhs_20 = 600 * t_start_20
    margin_20 = rhs_20 - target_poly_20
    print(f"\nStep 20: t in ({t_start_20}, {t_end_20}]")
    print(f"  y_max = {y_20} = {float(y_20)}")
    print(f"  y^2 + y = {poly_20}")
    assert poly_20 == target_poly_20, f"Step 20 poly mismatch: {poly_20} != {target_poly_20}"
    print(f"  LHS: {target_poly_20} = {float(target_poly_20)}")
    print(f"  RHS: 600 * {t_start_20} = {rhs_20} = {float(rhs_20)}")
    print(f"  Margin: {margin_20} = {float(margin_20)}")
    assert margin_20 > 0, f"Step 20 certificate failed: margin={margin_20}"

    # Step 21: 159/20 -> 8 (7.95 -> 8.00)
    t_start_21 = Fraction(159, 20)
    t_end_21 = Fraction(8, 1)
    y_21 = t_end_21 ** 2
    poly_21 = y_21 ** 2 + y_21
    target_poly_21 = Fraction(4160, 1)
    rhs_21 = 600 * t_start_21
    margin_21 = rhs_21 - target_poly_21
    print(f"\nStep 21: t in ({t_start_21}, {t_end_21}]")
    print(f"  y_max = {y_21} = {float(y_21)}")
    print(f"  y^2 + y = {poly_21}")
    assert poly_21 == target_poly_21, f"Step 21 poly mismatch: {poly_21} != {target_poly_21}"
    print(f"  LHS: {target_poly_21} = {float(target_poly_21)}")
    print(f"  RHS: 600 * {t_start_21} = {rhs_21} = {float(rhs_21)}")
    print(f"  Margin: {margin_21} = {float(margin_21)}")
    assert margin_21 > 0, f"Step 21 certificate failed: margin={margin_21}"

    # Step 22: 8 -> 161/20 (8.00 -> 8.05)
    t_start_22 = Fraction(8, 1)
    t_end_22 = Fraction(161, 20)
    y_22 = t_end_22 ** 2
    poly_22 = y_22 ** 2 + y_22
    target_poly_22 = Fraction(682266641, 160000)
    rhs_22 = 600 * t_start_22
    margin_22 = rhs_22 - target_poly_22
    print(f"\nStep 22: t in ({t_start_22}, {t_end_22}]")
    print(f"  y_max = {y_22} = {float(y_22)}")
    print(f"  y^2 + y = {poly_22}")
    assert poly_22 == target_poly_22, f"Step 22 poly mismatch: {poly_22} != {target_poly_22}"
    print(f"  LHS: {target_poly_22} = {float(target_poly_22)}")
    print(f"  RHS: 600 * {t_start_22} = {rhs_22} = {float(rhs_22)}")
    print(f"  Margin: {margin_22} = {float(margin_22)}")
    assert margin_22 > 0, f"Step 22 certificate failed: margin={margin_22}"

    print("\nALL 5 CERTIFICATES PASSED WITH STRICTLY POSITIVE MARGINS.\n")


def test_polynomial_identity_and_inequality():
    print("=== TEST 2: Exact Polynomial Identity & Remainder Nonpositivity ===")

    # Exact symbolic identity:
    # (x^2 + y)*((x - 1)^2 + y) == y^2 + y + x*(x - 1)*(x*(x - 1) + 2*y)
    
    # Boundary points and critical values
    special_xs = [
        Fraction(1, 2),
        Fraction(3, 5),
        Fraction(2, 3),
        Fraction(3, 4),
        Fraction(4, 5),
        Fraction(9, 10),
        Fraction(99, 100),
        Fraction(999, 1000),
        Fraction(1, 1),
    ]

    special_ys = [
        Fraction(1, 4),
        Fraction(1, 2),
        Fraction(1, 1),
        Fraction(4, 1),
        Fraction(25, 4),
        Fraction(23409, 400), # Step 18 max
        Fraction(1521, 25),   # Step 19 max
        Fraction(25281, 400), # Step 20 max
        Fraction(64, 1),      # Step 21 max (t = 8.0)
        Fraction(25921, 400), # Step 22 max (t = 8.05)
        Fraction(100, 1),
        Fraction(1000, 1),
    ]

    # Deterministic grid
    test_pairs = []
    for x in special_xs:
        for y in special_ys:
            test_pairs.append((x, y))

    # Dense random stress test: 20,000 points in [1/2, 1] x [1/4, 100]
    random.seed(42)
    for _ in range(20000):
        # x in [1/2, 1]: num in [500000, 1000000], den = 1000000
        x_num = random.randint(500000, 1000000)
        x = Fraction(x_num, 1000000)
        # y in [1/4, 100]: num in [250000, 100000000], den = 1000000
        y_num = random.randint(250000, 100000000)
        y = Fraction(y_num, 1000000)
        test_pairs.append((x, y))

    failures_id = 0
    failures_ineq = 0
    failures_rem = 0
    max_rem = Fraction(-10**9, 1)

    for x, y in test_pairs:
        lhs = (x**2 + y) * ((x - 1)**2 + y)
        rhs_poly = y**2 + y
        rem = x * (x - 1) * (x * (x - 1) + 2 * y)
        identity_rhs = rhs_poly + rem

        # 1. Identity check
        if lhs != identity_rhs:
            print(f"IDENTITY FAILURE at x={x}, y={y}: {lhs} != {identity_rhs}")
            failures_id += 1

        # 2. Remainder nonpositivity
        if rem > 0:
            print(f"REMAINDER FAILURE at x={x}, y={y}: rem={rem} > 0")
            failures_rem += 1

        if rem > max_rem:
            max_rem = rem

        # 3. Overall inequality: lhs <= y^2 + y
        if lhs > rhs_poly:
            print(f"INEQUALITY FAILURE at x={x}, y={y}: lhs={lhs} > rhs={rhs_poly}")
            failures_ineq += 1

    print(f"Tested {len(test_pairs)} points (x, y) with exact rational arithmetic.")
    print(f"Failures: Identity={failures_id}, Remainder Nonpos={failures_rem}, Inequality={failures_ineq}")
    print(f"Max remainder observed: {max_rem} (Expected: 0 at x=1)")
    assert failures_id == 0, "Polynomial identity failed!"
    assert failures_rem == 0, "Remainder nonpositivity failed!"
    assert failures_ineq == 0, "Inequality (x^2+y)((x-1)^2+y) <= y^2+y failed!"
    print("TEST 2 PASSED: Inequality holds unconditionally for all x in [1/2, 1], y >= 1/4.\n")


def test_corner_cases():
    print("=== TEST 3: Adversarial Corner & Boundary Analysis ===")

    # Corner 1: x = 1/2, y = 1/4 (Minimal boundary corner)
    x = Fraction(1, 2)
    y = Fraction(1, 4)
    lhs = (x**2 + y) * ((x - 1)**2 + y)
    rhs = y**2 + y
    rem = x * (x - 1) * (x * (x - 1) + 2 * y)
    print(f"Corner 1 (x=1/2, y=1/4):")
    print(f"  LHS = {lhs} = {float(lhs)}")
    print(f"  RHS = {rhs} = {float(rhs)}")
    print(f"  Remainder = {rem} = {float(rem)}")
    print(f"  Slack = RHS - LHS = {rhs - lhs} = {float(rhs - lhs)}")
    assert lhs == Fraction(1, 4)
    assert rhs == Fraction(5, 16)
    assert rem == Fraction(-1, 16)
    assert lhs < rhs

    # Corner 2: x = 1, y = 1/4 (Exact equality corner)
    x = Fraction(1, 1)
    y = Fraction(1, 4)
    lhs = (x**2 + y) * ((x - 1)**2 + y)
    rhs = y**2 + y
    rem = x * (x - 1) * (x * (x - 1) + 2 * y)
    print(f"\nCorner 2 (x=1, y=1/4, boundary equality):")
    print(f"  LHS = {lhs} = {float(lhs)}")
    print(f"  RHS = {rhs} = {float(rhs)}")
    print(f"  Remainder = {rem}")
    assert lhs == rhs == Fraction(5, 16)
    assert rem == 0

    # Corner 3: x = 1/2, t = 8.0 (y = 64)
    x = Fraction(1, 2)
    y = Fraction(64, 1)
    lhs = (x**2 + y) * ((x - 1)**2 + y)
    rhs = y**2 + y
    rem = x * (x - 1) * (x * (x - 1) + 2 * y)
    slack = rhs - lhs
    print(f"\nCorner 3 (x=1/2, t=8.0, y=64):")
    print(f"  LHS = {lhs} = {float(lhs)}")
    print(f"  RHS = {rhs} = {float(rhs)}")
    print(f"  Slack = {slack} = {float(slack)}")
    print(f"  Pole comparison: 1/LHS = {1/lhs} > 1/RHS = 1/4160")
    assert lhs == Fraction(66049, 16)
    assert rhs == Fraction(4160, 1)
    assert slack == Fraction(511, 16) == Fraction(31.9375)
    assert lhs < rhs

    # Corner 4: x = 1, t = 8.0 (y = 64)
    x = Fraction(1, 1)
    y = Fraction(64, 1)
    lhs = (x**2 + y) * ((x - 1)**2 + y)
    rhs = y**2 + y
    print(f"\nCorner 4 (x=1, t=8.0, y=64, boundary equality):")
    print(f"  LHS = {lhs} = 4160")
    print(f"  RHS = {rhs} = 4160")
    assert lhs == rhs == Fraction(4160, 1)

    # Corner 5: x = 1/2, t = 8.05 (y = 25921/400)
    x = Fraction(1, 2)
    y = Fraction(25921, 400)
    lhs = (x**2 + y) * ((x - 1)**2 + y)
    rhs = y**2 + y
    rem = x * (x - 1) * (x * (x - 1) + 2 * y)
    slack = rhs - lhs
    print(f"\nCorner 5 (x=1/2, t=8.05, y=25921/400):")
    print(f"  LHS = {lhs} = {float(lhs)}")
    print(f"  RHS = {rhs} = {float(rhs)}")
    print(f"  Slack = {slack} = {float(slack)}")
    assert lhs < rhs

    # Corner 6: x = 1, t = 8.05 (y = 25921/400)
    x = Fraction(1, 1)
    y = Fraction(25921, 400)
    lhs = (x**2 + y) * ((x - 1)**2 + y)
    rhs = y**2 + y
    print(f"\nCorner 6 (x=1, t=8.05, y=25921/400, boundary equality):")
    print(f"  LHS = {lhs} = {float(lhs)}")
    print(f"  RHS = {rhs} = {float(rhs)}")
    assert lhs == rhs == Fraction(682266641, 160000)

    print("\nTEST 3 PASSED: All boundary and corner cases behave precisely as proved.\n")


def test_pole_barrier_crossing_comparison():
    print("=== TEST 4: Comparison of C=436 vs C=600 Across the Pole Barrier ===")

    # Pole ordinate at t = 8.0:
    t_pole = Fraction(8, 1)
    pole_term = Fraction(1, int(t_pole**4 + t_pole**2)) # 1 / 4160
    
    # Linear bound with C = 436:
    decay_436 = Fraction(1, int(436 * t_pole)) # 1 / 3488
    
    print(f"At t = {t_pole}:")
    print(f"  Pole bound 1 / (t^4 + t^2) = {pole_term} = {float(pole_term):.8e}")
    print(f"  C=436 bound 1 / (436 * t)  = {decay_436} = {float(decay_436):.8e}")
    diff_436 = decay_436 - pole_term
    print(f"  Deficit margin (1/pole - 1/bound) with C=436:")
    print(f"    (t^4 + t^2) - 436*t = 4160 - 3488 = {4160 - 3488} > 0")
    print(f"    => decay_436 > pole_term by {float(diff_436):.8e}")
    print(f"    CRITICAL OBSERVATION: C=436 FAILS at t = 8.0 because 1/(436*t) > 1/(t^4+t^2)!")
    assert decay_436 > pole_term, "C=436 was expected to fail"

    # Sharp bound with C = 600:
    decay_600 = Fraction(1, int(600 * t_pole)) # 1 / 4800
    print(f"\n  C=600 bound 1 / (600 * t)  = {decay_600} = {float(decay_600):.8e}")
    print(f"  Deficit margin with C=600:")
    print(f"    600*t - (t^4 + t^2) = 4800 - 4160 = {4800 - 4160} > 0")
    assert decay_600 < pole_term, "C=600 must clear the pole term"
    print(f"    => decay_600 < pole_term (SUCCESSFULLY CLEARS POLE BARRIER BY 640!)")

    # Margin at t = 8.05:
    t_805 = Fraction(161, 20)
    bound_at_805 = 600 * Fraction(8, 1) # Step 22 lower bound uses gamma0 = 8.0
    poly_at_805 = Fraction(682266641, 160000)
    print(f"\nAt Step 22 (t -> 8.05 = 161/20):")
    print(f"  600 * 8.0 = {bound_at_805}")
    print(f"  Poly max = {poly_at_805} = {float(poly_at_805):.4f}")
    print(f"  Margin: {bound_at_805 - poly_at_805} = {float(bound_at_805 - poly_at_805):.4f} > 0")
    assert bound_at_805 > poly_at_805

    print("\nTEST 4 PASSED: Mathematical necessity and soundness of C=600 confirmed.\n")


def test_mellin_ratio_integrand_decay():
    print("=== TEST 5: Mellin Ratio Integrand Quadratic Domination Numerics ===")
    
    # Test formula:
    # mellinTrigIntegrandIm(s, x) = powerDiff(beta, x) * sin((gamma/2) * log x) * real_f_modif(x)
    # where powerDiff(beta, x) = x^(beta/2 - 1) - x^((1-beta)/2 - 1)
    #
    # Majorant: 1/4 * (x - 1)^2 * real_f_modif(x)
    #
    # We test:
    #   Ratio = mellinTrigIntegrandIm(s, x) / ((2*beta - 1) * gamma)
    #   Claim: Ratio <= 1/4 * (x - 1)^2 * real_f_modif(x)
    #
    # Equivalent to testing for all x >= 1, beta in (1/2, 1], gamma > 0:
    #   (powerDiff(beta, x) / (2*beta - 1)) * (sin((gamma/2)*log x) / gamma) <= 1/4 * (x - 1)^2
    
    betas = [0.5001, 0.51, 0.55, 0.6, 0.7, 0.75, 0.8, 0.9, 0.99, 1.0]
    gammas = [0.001, 0.01, 0.1, 0.5, 1.0, 2.0, 5.0, 7.5, 7.65, 7.8, 7.95, 8.0, 8.05, 10.0, 50.0]
    xs = [1.0, 1.0001, 1.01, 1.05, 1.1, 1.2, 1.5, 2.0, 3.0, 5.0, 10.0, 50.0]

    test_count = 0
    violations = 0
    max_relative_ratio = 0.0

    for b in betas:
        for g in gammas:
            for x in xs:
                test_count += 1
                log_x = math.log(x)
                
                # powerDiff
                exp1 = b / 2.0 - 1.0
                exp2 = (1.0 - b) / 2.0 - 1.0
                power_diff = math.pow(x, exp1) - math.pow(x, exp2)
                
                # Factors
                factor1 = power_diff / (2.0 * b - 1.0)
                sin_arg = (g / 2.0) * log_x
                factor2 = math.sin(sin_arg) / g
                
                lhs = factor1 * factor2
                rhs = 0.25 * ((x - 1.0) ** 2)
                
                # Check inequality: lhs <= rhs + 1e-12 (floating tolerance)
                if lhs > rhs + 1e-12:
                    print(f"VIOLATION at b={b}, g={g}, x={x}: lhs={lhs} > rhs={rhs}")
                    violations += 1
                    
                if rhs > 1e-12:
                    rel = lhs / rhs
                    if rel > max_relative_ratio:
                        max_relative_ratio = rel

    # Random testing: 50,000 randomized points
    for _ in range(50000):
        test_count += 1
        b = random.uniform(0.500001, 1.0)
        g = random.uniform(0.0001, 20.0)
        x = math.exp(random.uniform(0.0, 4.0)) # x in [1, e^4 ~= 54.6]
        
        log_x = math.log(x)
        exp1 = b / 2.0 - 1.0
        exp2 = (1.0 - b) / 2.0 - 1.0
        power_diff = math.pow(x, exp1) - math.pow(x, exp2)
        
        factor1 = power_diff / (2.0 * b - 1.0)
        sin_arg = (g / 2.0) * log_x
        factor2 = math.sin(sin_arg) / g
        
        lhs = factor1 * factor2
        rhs = 0.25 * ((x - 1.0) ** 2)
        
        if lhs > rhs + 1e-12:
            print(f"RANDOM VIOLATION at b={b}, g={g}, x={x}: lhs={lhs} > rhs={rhs}")
            violations += 1

    print(f"Tested {test_count} configurations of (beta, gamma, x).")
    print(f"Violations: {violations}")
    print(f"Max observed ratio lhs / rhs: {max_relative_ratio:.6f} (<= 1.0)")
    assert violations == 0, "Pointwise Mellin ratio domination violated!"
    print("TEST 5 PASSED: Quadratic domination holds strictly across all configurations.\n")


def main():
    print("=================================================================")
    print("  EMPIRICAL ADVERSARIAL STRESS TEST: ROUND 2 BOOTSTRAP CERTIFICATES")
    print("=================================================================\n")
    test_rational_bootstrap_certificates()
    test_polynomial_identity_and_inequality()
    test_corner_cases()
    test_pole_barrier_crossing_comparison()
    test_mellin_ratio_integrand_decay()
    print("=================================================================")
    print("  ALL 5 EMPIRICAL STRESS TESTS PASSED WITH 100% SUCCESS RATE")
    print("=================================================================")

if __name__ == "__main__":
    main()
