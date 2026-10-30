"""
Tier 1: Feature Coverage — Feature 8: E2E Regression & Adversarial Testing
Authoritative Source: PROJECT.md Feature 8, ORIGINAL_REQUEST.md §R4, survey_operations.md §3
"""

import unittest
from pathlib import Path
from tests.conftest_utils import (
    REPO_ROOT,
    MIN_DISK_FREE_GIB,
    check_disk_space_gib,
    AXIOM_AUDIT_DIR,
)


class TestFeature8RegressionAdversarial(unittest.TestCase):
    """
    Validates Feature 8: E2E Regression & Adversarial Testing.
    Authoritative Source:
      - PROJECT.md Feature 8: Multi-tier test suite and operational guardrails
      - ORIGINAL_REQUEST.md §R4: Maintain available disk space above 6.0 GiB at all times.
      - formalization/integrations/lean434-axiom-audit/test_compiler_guard.py
    """

    def test_f8_01_host_disk_space_exceeds_critical_threshold(self):
        """Input: Host filesystem at REPO_ROOT
        Authoritative Source: ORIGINAL_REQUEST.md §R4, PROJECT.md §Operational Guardrail
        Expected Output: Free disk space strictly exceeds 6.0 GiB."""
        free_gib = check_disk_space_gib(REPO_ROOT)
        self.assertGreater(
            free_gib,
            MIN_DISK_FREE_GIB,
            f"Disk space critical: {free_gib:.2f} GiB available, required > {MIN_DISK_FREE_GIB} GiB",
        )

    def test_f8_02_lean_toolchain_version_pinned(self):
        """Input: lean-toolchain file
        Authoritative Source: PROJECT.md §Architecture
        Expected Output: lean-toolchain contains leanprover/lean4:v4.34.1."""
        toolchain_file = REPO_ROOT / "lean-toolchain"
        self.assertTrue(toolchain_file.exists())
        content = toolchain_file.read_text(encoding="utf-8").strip()
        self.assertEqual(content, "leanprover/lean4:v4.34.1")

    def test_f8_03_compiler_guard_script_exists(self):
        """Input: formalization/integrations/lean434-axiom-audit/test_compiler_guard.py
        Authoritative Source: survey_operations.md §4.1
        Expected Output: test_compiler_guard.py exists and defines main entrypoint."""
        guard_file = AXIOM_AUDIT_DIR / "test_compiler_guard.py"
        self.assertTrue(guard_file.exists())
        content = guard_file.read_text(encoding="utf-8")
        self.assertIn("def main() -> int:", content)

    def test_f8_04_core_fixtures_script_exists(self):
        """Input: formalization/integrations/lean434-axiom-audit/run_core_fixtures.py
        Authoritative Source: survey_operations.md §4.1
        Expected Output: run_core_fixtures.py exists and supports --lean execution."""
        fixtures_runner = AXIOM_AUDIT_DIR / "run_core_fixtures.py"
        self.assertTrue(fixtures_runner.exists())
        content = fixtures_runner.read_text(encoding="utf-8")
        self.assertIn("--lean", content)

    def test_f8_05_precompiled_research_local_mathlib_preserved(self):
        """Input: research-local package tree
        Authoritative Source: survey_operations.md §3.2
        Expected Output: research-local packages exist and must never be deleted via lake clean."""
        packages_dir = (
            REPO_ROOT
            / "research-local"
            / "agent-results"
            / "20261007-openai-math"
            / "kernel-verification"
            / "workspace"
            / ".lake"
            / "packages"
        )
        self.assertTrue(packages_dir.exists(), f"Missing precompiled packages at {packages_dir}")
        self.assertTrue((packages_dir / "mathlib").exists(), "Missing mathlib package directory")

    def test_f8_06_lake_build_cache_directory_exists(self):
        """Input: .lake/build/lib/lean
        Authoritative Source: survey_operations.md §3.2
        Expected Output: Precompiled BuildingBlocks oleans intact in .lake/build/lib/lean."""
        lake_build_dir = REPO_ROOT / ".lake" / "build" / "lib" / "lean"
        self.assertTrue(lake_build_dir.exists())
        self.assertTrue((lake_build_dir / "BuildingBlocks").exists())


if __name__ == "__main__":
    unittest.main()
