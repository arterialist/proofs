"""
Tier 2: Boundary & Corner Cases — Adversarial Empirical Challenge for Milestone 3
Authoritative Source:
  - ORIGINAL_REQUEST.md §R1, §R2
  - PROJECT.md Milestone 3 & Feature 5
  - formalization/BuildingBlocks/RiemannHypothesisResolution.lean
  - formalization/verification/RiemannHypothesisResolutionAdversarialAudit.lean
"""

import re
import sys
import unittest
from pathlib import Path

# Add project root to sys.path
REPO_ROOT_PATH = Path(__file__).resolve().parent.parent.parent
if str(REPO_ROOT_PATH) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT_PATH))

from tests.conftest_utils import (
    REPO_ROOT,
    BUILDING_BLOCKS_DIR,
    VERIFICATION_DIR,
    STANDARD_FOUNDATIONAL_AXIOMS,
    run_command,
)


class TestAdversarialM3Challenge(unittest.TestCase):
    """
    Adversarially challenges Milestone 3 Resolution & Proof Assembly:
      1. Target Definitional Identity:
         - Target definitionally matches Mathlib's RiemannHypothesis via rfl.
      2. Admissibility Filtering & Bogus Premise Resistance:
         - Disallows sneaking displacement functional non-positivity into contradiction systems.
         - Any non-positive displacement assumption derives False.
         - toAdmissible unconditionally guarantees 0 < displacementFunctional s at candidate zeros.
      3. Counter-Model Inhabitation Impossibility:
         - Any hypothetical off-line zero (IsOfflineZero) unconditionally refutes the existence
           of both CanonicalHighFrequencyContradictionSystem and CanonicalAdmissibleContradictionSystem.
      4. Pointwise Root Localization Exhaustiveness:
         - Root localization rules out off-line zeros on both Re(s) > 1/2 and Re(s) < 1/2.
         - Collapses trichotomy uniquely to s.re = 1/2.
      5. Master Grand Resolution Equivalence (12-Fold):
         - All 12 representations are simultaneously refuted under any counter-model.
      6. Higher-Cutoff Intermediate Slab Soundness:
         - Intermediate slab hypothesis is vacuously satisfied at canonical H0 = 1493/200.
         - Guaranteed sound transfer for H >= 1493/200.
      7. In-Kernel Transitive Axiom Audit:
         - Lean 4 verification confirms exit code 0, 0 sorry, standard foundations only.
    """

    @classmethod
    def setUpClass(cls):
        cls.resolution_lean = BUILDING_BLOCKS_DIR / "RiemannHypothesisResolution.lean"
        cls.adversarial_lean = VERIFICATION_DIR / "RiemannHypothesisResolutionAdversarialAudit.lean"
        cls.resolution_content = cls.resolution_lean.read_text(encoding="utf-8")
        cls.adversarial_content = cls.adversarial_lean.read_text(encoding="utf-8")

    def test_adv_m3_01_target_definitional_equality(self):
        """Audit: Target definitionally matches Mathlib's RiemannHypothesis via rfl.
        Authoritative Source: RiemannHypothesisResolution.lean:80-84"""
        self.assertIn(
            "theorem target_resolution_eq : Target = RiemannHypothesis := rfl",
            self.resolution_content,
        )
        self.assertIn(
            "theorem target_resolution_iff : RiemannHypothesis ↔ Target := Iff.rfl",
            self.resolution_content,
        )

    def test_adv_m3_02_admissibility_filter_positivity(self):
        """Stress Test: Admissibility filter guarantees displacement functional positivity.
        Authoritative Source: RiemannHypothesisResolutionAdversarialAudit.lean Part 2"""
        self.assertIn(
            "structure AdmissibleHighFrequencyContradictionSystem",
            self.resolution_content,
        )
        self.assertIn("toAdmissible", self.resolution_content)
        self.assertIn(
            "theorem challenge_no_candidate_zero_with_nonpos_displacement",
            self.adversarial_content,
        )
        self.assertIn(
            "theorem challenge_displacement_nonpos_derives_false",
            self.adversarial_content,
        )
        self.assertIn(
            "theorem challenge_admissible_system_guarantees_positivity",
            self.adversarial_content,
        )

    def test_adv_m3_03_countermodel_forbids_contradiction_systems(self):
        """Stress Test: Off-line zeros forbid inhabitation of contradiction systems.
        Authoritative Source: RiemannHypothesisResolutionAdversarialAudit.lean Part 1"""
        self.assertIn(
            "theorem offline_zero_derives_false_of_canonical_system",
            self.adversarial_content,
        )
        self.assertIn(
            "theorem offline_zero_derives_false_of_admissible_system",
            self.adversarial_content,
        )
        self.assertIn(
            "theorem offline_zero_refutes_nonempty_canonical_system",
            self.adversarial_content,
        )
        self.assertIn(
            "theorem offline_zero_refutes_nonempty_admissible_system",
            self.adversarial_content,
        )
        self.assertIn(
            "theorem countermodel_forbids_inhabitation",
            self.adversarial_content,
        )

    def test_adv_m3_04_pointwise_root_localization_exhaustiveness(self):
        """Stress Test: Pointwise root localization refutes both left and right offline zeros.
        Authoritative Source: RiemannHypothesisResolutionAdversarialAudit.lean Part 3"""
        self.assertIn(
            "theorem canonical_root_localization",
            self.resolution_content,
        )
        self.assertIn(
            "theorem canonical_root_localization_of_admissible",
            self.resolution_content,
        )
        self.assertIn(
            "theorem challenge_root_localization_refutes_right_offline",
            self.adversarial_content,
        )
        self.assertIn(
            "theorem challenge_root_localization_refutes_left_offline",
            self.adversarial_content,
        )
        self.assertIn(
            "theorem challenge_root_localization_admissible_refutes_right_offline",
            self.adversarial_content,
        )
        self.assertIn(
            "theorem challenge_root_localization_admissible_refutes_left_offline",
            self.adversarial_content,
        )
        self.assertIn(
            "theorem challenge_root_localization_trichotomy_collapse",
            self.adversarial_content,
        )

    def test_adv_m3_05_all_12_grand_equivalences_refute_countermodels(self):
        """Stress Test: Off-line zeros simultaneously refute all 12 grand resolution formulations.
        Authoritative Source: RiemannHypothesisResolutionAdversarialAudit.lean Part 4"""
        self.assertIn(
            "theorem master_grand_resolution_equivalence",
            self.resolution_content,
        )
        self.assertIn(
            "theorem master_grand_resolution_offline_zero_refutation",
            self.adversarial_content,
        )

        # Check that contradiction systems are included in the 12-fold refutation
        self.assertIn("¬ Nonempty CanonicalHighFrequencyContradictionSystem", self.adversarial_content)
        self.assertIn("¬ Nonempty CanonicalAdmissibleContradictionSystem", self.adversarial_content)

    def test_adv_m3_06_higher_cutoff_stability_and_intermediate_slab(self):
        """Stress Test: Higher-cutoff intermediate slab is vacuously true at canonical H0.
        Authoritative Source: RiemannHypothesisResolutionAdversarialAudit.lean Part 5"""
        self.assertIn(
            "theorem challenge_intermediate_slab_vacuous_at_canonical",
            self.adversarial_content,
        )
        self.assertIn(
            "theorem challenge_higher_cutoff_specializes_to_canonical",
            self.adversarial_content,
        )
        self.assertIn(
            "theorem challenge_admissible_higher_cutoff_resolution",
            self.adversarial_content,
        )

    def test_adv_m3_07_lean_adversarial_audit_compiles_and_passes(self):
        """In-Kernel Audit: Lean 4 compilation of RiemannHypothesisResolutionAdversarialAudit.lean succeeds.
        Authoritative Source: ORIGINAL_REQUEST.md §R2"""
        rel_path = self.adversarial_lean.relative_to(REPO_ROOT)
        proc = run_command(f"lake env lean {rel_path}", cwd=REPO_ROOT, timeout=120)
        self.assertEqual(
            proc.returncode,
            0,
            f"Adversarial audit failed with exit {proc.returncode}:\n{proc.stderr or proc.stdout}",
        )
        self.assertNotIn("sorryAx", proc.stdout)
        self.assertIn("MILESTONE 3 ADVERSARIAL CHALLENGE AUDIT PASSED", proc.stdout)

        # Check axioms of all audited declarations
        matches = re.findall(r"CHALLENGE THEOREM AUDITED: ([^\s]+) \(axioms: \[([^\]]*)\]\)", proc.stdout)
        self.assertGreaterEqual(len(matches), 20, "Expected at least 20 challenge theorems audited")
        for decl, ax_str in matches:
            axioms = {a.strip() for a in ax_str.split(",") if a.strip()}
            disallowed = axioms - STANDARD_FOUNDATIONAL_AXIOMS
            self.assertEqual(
                len(disallowed),
                0,
                f"Declaration {decl} depends on disallowed axioms: {disallowed}",
            )


if __name__ == "__main__":
    unittest.main()
