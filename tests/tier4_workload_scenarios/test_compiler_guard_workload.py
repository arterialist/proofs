"""
Tier 4: Workload Scenarios — Live Execution of Compiler Guards and Core Fixtures
Authoritative Source: formalization/integrations/lean434-axiom-audit/test_compiler_guard.py, run_core_fixtures.py
"""

import json
import unittest
from pathlib import Path
from tests.conftest_utils import AXIOM_AUDIT_DIR, NATIVE_LEAN_BIN, run_command


class TestCompilerGuardWorkload(unittest.TestCase):
    """
    Executes live verification of:
      1. Compiler guard suite (14 non-executing cases rejecting fake shims and unauthorized compilers).
      2. Core fixtures suite (11 Lean 4.34.1 core AST/axiom verification cases).
    """

    def test_workload_02_execute_compiler_guard_suite(self):
        """Input: python3 test_compiler_guard.py
        Authoritative Source: survey_operations.md §4.1
        Expected Output: Exit code 0, all 14 compiler-guard cases passed, receipt generated with all_expectations_met == True."""
        guard_script = AXIOM_AUDIT_DIR / "test_compiler_guard.py"
        self.assertTrue(guard_script.exists())

        proc = run_command(f"python3 {guard_script.name}", cwd=AXIOM_AUDIT_DIR, timeout=30)
        self.assertEqual(
            proc.returncode,
            0,
            f"Compiler guard run failed:\nStdout: {proc.stdout}\nStderr: {proc.stderr}",
        )
        self.assertIn("All 14 nonexecuting compiler-guard cases passed", proc.stdout)

        # Parse latest receipt
        audit_results = AXIOM_AUDIT_DIR / "audit-results"
        receipts = sorted(audit_results.glob("compiler-guard-*/receipt.json"), key=lambda p: p.stat().st_mtime)
        self.assertTrue(receipts, "No compiler-guard receipt.json found")
        latest_receipt = receipts[-1]
        data = json.loads(latest_receipt.read_text(encoding="utf-8"))
        self.assertTrue(data.get("all_expectations_met"), f"Receipt failure in {latest_receipt}")
        self.assertEqual(len(data.get("records", [])), 14)

    def test_workload_03_execute_core_fixtures_suite(self):
        """Input: python3 run_core_fixtures.py --lean <toolchain_lean>
        Authoritative Source: survey_operations.md §4.1
        Expected Output: Exit code 0, all 11 core audit cases passed, receipt generated with all_expectations_met == True."""
        fixtures_script = AXIOM_AUDIT_DIR / "run_core_fixtures.py"
        self.assertTrue(fixtures_script.exists())
        self.assertTrue(NATIVE_LEAN_BIN.exists(), f"Missing native lean binary at {NATIVE_LEAN_BIN}")

        cmd = f"python3 {fixtures_script.name} --lean {NATIVE_LEAN_BIN}"
        proc = run_command(cmd, cwd=AXIOM_AUDIT_DIR, timeout=60)
        self.assertEqual(
            proc.returncode,
            0,
            f"Core fixtures run failed:\nStdout: {proc.stdout}\nStderr: {proc.stderr}",
        )
        self.assertIn("All 11 core audit cases passed", proc.stdout)


if __name__ == "__main__":
    unittest.main()
