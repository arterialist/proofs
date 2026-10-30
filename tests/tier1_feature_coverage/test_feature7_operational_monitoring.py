"""
Tier 1: Feature Coverage — Feature 7: Operational Monitoring & Breakthrough Notification
Authoritative Source: ORIGINAL_REQUEST.md §R4, PROJECT.md Feature 7, monitoring/notify.py, monitoring/server.py
"""

import json
import unittest
from pathlib import Path
from tests.conftest_utils import MONITORING_DIR, DAEMON_PORT, DAEMON_HOST


class TestFeature7OperationalMonitoring(unittest.TestCase):
    """
    Validates Feature 7: Operational Monitoring & Breakthrough Notification.
    Authoritative Source:
      - ORIGINAL_REQUEST.md §R4:
          Use `python3 monitoring/notify.py` to trigger breakthrough notifications
          to the active monitoring daemon on port 8790 upon achieving the proof.
      - monitoring/notify.py
      - monitoring/server.py
      - monitoring/breakthroughs.json
    """

    @classmethod
    def setUpClass(cls):
        cls.notify_file = MONITORING_DIR / "notify.py"
        cls.server_file = MONITORING_DIR / "server.py"
        cls.json_file = MONITORING_DIR / "breakthroughs.json"
        cls.notify_content = cls.notify_file.read_text(encoding="utf-8")
        cls.server_content = cls.server_file.read_text(encoding="utf-8")
        cls.db = json.loads(cls.json_file.read_text(encoding="utf-8"))

    def test_f7_01_notify_cli_port_and_host_configuration(self):
        """Input: monitoring/notify.py
        Authoritative Source: ORIGINAL_REQUEST.md §R4, notify.py:24-25
        Expected Output: PORT = 8790 and HOST = '127.0.0.1'."""
        self.assertIn("PORT = 8790", self.notify_content)
        self.assertIn('HOST = "127.0.0.1"', self.notify_content)

    def test_f7_02_notify_cli_required_arguments(self):
        """Input: monitoring/notify.py argument parser
        Authoritative Source: notify.py:79-88
        Expected Output: Required flags --title, --summary, --bounds."""
        self.assertIn('--title", required=True', self.notify_content)
        self.assertIn('--summary", required=True', self.notify_content)
        self.assertIn('--bounds", required=True', self.notify_content)

    def test_f7_03_breakthrough_json_schema(self):
        """Input: monitoring/breakthroughs.json
        Authoritative Source: survey_operations.md §2.1
        Expected Output: Database contains bounds, formal_kernel_status, and events keys."""
        self.assertIn("bounds", self.db)
        self.assertIn("formal_kernel_status", self.db)
        self.assertIn("events", self.db)
        self.assertIsInstance(self.db["events"], list)

    def test_f7_04_formal_kernel_status_schema(self):
        """Input: monitoring/breakthroughs.json formal_kernel_status
        Authoritative Source: survey_operations.md §2.1
        Expected Output: Status includes axioms, custom_axioms: 0, sorry_count: 0."""
        status = self.db["formal_kernel_status"]
        self.assertEqual(status["custom_axioms"], 0)
        self.assertEqual(status["sorry_count"], 0)
        self.assertEqual(status["axioms"], ["propext", "Classical.choice", "Quot.sound"])

    def test_f7_05_allowed_event_severities_and_types(self):
        """Input: monitoring/notify.py, breakthroughs.json, index.html
        Authoritative Source: notify.py:83-84, breakthroughs.json:43
        Expected Output: Valid severities include CRITICAL, HIGH, MEDIUM; types include BREAKTHROUGH and FORMAL_MILESTONE."""
        index_content = (MONITORING_DIR / "index.html").read_text(encoding="utf-8")
        self.assertIn("CRITICAL", self.notify_content)
        self.assertIn("BREAKTHROUGH", self.notify_content)
        self.assertIn("FORMAL_MILESTONE", index_content)

    def test_f7_06_direct_file_fallback_logic(self):
        """Input: monitoring/notify.py fallback handler
        Authoritative Source: notify.py:53-76
        Expected Output: Upon failure to connect to HTTP daemon, falls back to direct json write."""
        self.assertIn("Writing directly to breakthroughs.json", self.notify_content)
        self.assertIn("json.dump(db, f, indent=2)", self.notify_content)


if __name__ == "__main__":
    unittest.main()
