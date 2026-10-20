"""Scenario calculator for crossover scales in the critical sign criterion.

Mathematical Claim:
  Under the shifted critical arithmetic observable W(x) = sum_{d <= x} sqrt(d) V(x/d),
  the deterministic negative drift from the triple pole at s = 1/2 is given by:
      W_drift(x) = - (1/6) * x^{3/2} * log^2(x) + A_2 * x^{3/2} * log(x) + O(x^{3/2})
  where A_2 = - (1/3)*gamma_0 + 8/9 approx 0.696483667.

  If an off-critical zero rho = beta + i*gamma exists with beta > 1/2 and gamma > 0,
  it introduces a double pole in the Mellin transform with leading coefficient:
      C(rho) = zeta(rho + 1/2) / [rho * (rho + 1)] != 0
  generating two-sided oscillations with peak envelope:
      W_osc(x) = 2 * |C(rho)| * x^{beta+1} * log(x).

  The crossover scale x_cross where W_osc(x) matches and exceeds the negative drift is:
      12 * |C(rho)| * (beta - 1/2) * log(x) * x^{beta - 1/2} / log^2(x) = 1
      ==> u * exp(-u) = 12 * |C(rho)| * delta,   where delta = beta - 1/2, u = delta * log(x)
      ==> x_cross = exp( - (1/delta) * W_{-1}( - 12 * |C(rho)| * delta ) ).

  The values below are evaluations at selected hypothetical (beta, gamma) pairs. They are
  not uniform bounds over all beta > 1/2 and |gamma| > 3 * 10^12. In particular, the
  zero-verification height alone does not bound |zeta(beta + 1/2 + i*gamma)| uniformly as
  beta decreases to 1/2. The output therefore does not certify a universal crossover scale.

Reproduce with: python3 certificates/haselgrove_crossover_scale_certificate.py
"""

import json
import sys

try:
    import mpmath as mp
except ImportError:
    print("Error: mpmath is required for this scenario calculator. Install with 'pip install mpmath'.")
    sys.exit(1)

mp.mp.dps = 50


def compute_scenarios():
    gamma_0 = mp.euler
    A_2 = - gamma_0 / 3 + mp.mpf(8) / 9
    x_drift_crossing = mp.exp(6 * A_2)

    def crossover_scale(beta, gamma):
        rho = mp.mpc(beta, gamma)
        Phi_val = mp.zeta(rho + 0.5) / (rho * (rho + 1))
        abs_C = abs(Phi_val)
        delta = beta - 0.5
        arg = - 12 * abs_C * delta
        # Branch -1 of Lambert W governs the large-u solution
        u = - mp.lambertw(arg, -1)
        log_x = u / delta
        log10_x = log_x / mp.log(10)
        return abs_C, log10_x

    cases = [
        {"name": "hypothetical_low_lying_beta_060", "beta": 0.60, "gamma": 14.13472514},
        {"name": "hypothetical_low_lying_beta_055", "beta": 0.55, "gamma": 14.13472514},
        {"name": "platt_trudgian_boundary_beta_060", "beta": 0.60, "gamma": 3.0e12},
        {"name": "platt_trudgian_boundary_beta_055", "beta": 0.55, "gamma": 3.0e12},
    ]

    results = []
    for c in cases:
        abs_C, log10_x = crossover_scale(c["beta"], c["gamma"])
        results.append({
            "case": c["name"],
            "beta": c["beta"],
            "gamma": c["gamma"],
            "abs_C": float(abs_C),
            "log10_x_crossover": float(log10_x),
        })

    # Sensitivity at x = 20000
    x_test = mp.mpf(20000)
    abs_C_boundary = float(results[2]["abs_C"])
    osc_bound = 2 * abs_C_boundary * (x_test**1.6) * mp.log(x_test)
    drift_val = (mp.mpf(1)/6 * mp.log(x_test)**2 - A_2 * mp.log(x_test)) * (x_test**1.5)
    ratio_test = float(osc_bound / drift_val)

    scenario_data = {
        "status": "SCENARIO_CALCULATION_ONLY",
        "A_2_coefficient": float(A_2),
        "two_term_drift_zero_crossing": float(x_drift_crossing),
        "crossover_results": results,
        "finite_window_sensitivity_at_20000": {
            "x": float(x_test),
            "selected_case_oscillation": float(osc_bound),
            "deterministic_drift_magnitude": float(drift_val),
            "ratio_oscillation_to_drift": ratio_test,
            "case": cases[2]["name"],
        }
    }
    return scenario_data


if __name__ == "__main__":
    scenarios = compute_scenarios()
    print(json.dumps(scenarios, indent=2))
    print("\nScenario calculation completed; no universal bound is certified.")
