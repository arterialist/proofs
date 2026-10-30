#!/usr/bin/env python3
"""
Millennium Riemann Hypothesis Breakthrough Monitor Server
Serves the locally hosted HTML page on 127.0.0.1:8790 and provides real-time
SSE alerts when mathematical breakthroughs advancing bounds occur.
"""

import http.server
import json
import os
import queue
import socketserver
import subprocess
import sys
import threading
import time
from urllib.parse import urlparse

PORT = 8790
HOST = "127.0.0.1"
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_FILE = os.path.join(BASE_DIR, "breakthroughs.json")
INDEX_FILE = os.path.join(BASE_DIR, "index.html")

# Global subscriber list for Server-Sent Events
subscribers = []
subscribers_lock = threading.Lock()


def load_breakthroughs():
    try:
        with open(DATA_FILE, "r", encoding="utf-8") as f:
            return json.load(f)
    except Exception as e:
        return {"error": str(e), "events": [], "bounds": {}}


def save_breakthroughs(data):
    with open(DATA_FILE, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2)


def broadcast_event(data):
    payload = f"data: {json.dumps(data)}\n\n".encode("utf-8")
    with subscribers_lock:
        stale = []
        for q in subscribers:
            try:
                q.put_nowait(payload)
            except Exception:
                stale.append(q)
        for s in stale:
            subscribers.remove(s)


def open_in_chrome(url=f"http://{HOST}:{PORT}"):
    """Ensure page is opened in Google Chrome on macOS."""
    try:
        subprocess.run(["open", "-a", "Google Chrome", url], check=False)
    except Exception as e:
        print(f"[Warning] Failed to open Google Chrome: {e}", file=sys.stderr)


class BreakthroughHandler(http.server.BaseHTTPRequestHandler):
    def log_message(self, format, *args):
        # Keep stdout clean
        pass

    def do_OPTIONS(self):
        self.send_response(204)
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "Content-Type")
        self.end_headers()

    def do_GET(self):
        parsed = urlparse(self.path)
        path = parsed.path

        if path in ["/", "/index.html"]:
            self.serve_file(INDEX_FILE, "text/html; charset=utf-8")
        elif path == "/api/breakthroughs":
            self.send_json(load_breakthroughs())
        elif path == "/api/events":
            self.handle_sse()
        elif path == "/health":
            self.send_json({"status": "ok", "port": PORT, "subscribers": len(subscribers)})
        else:
            self.send_error(404, "Not Found")

    def do_POST(self):
        parsed = urlparse(self.path)
        if parsed.path == "/api/notify":
            content_length = int(self.headers.get("Content-Length", 0))
            body = self.rfile.read(content_length).decode("utf-8")
            try:
                event_data = json.loads(body)
                data = load_breakthroughs()

                if "events" not in data:
                    data["events"] = []

                # Ensure event fields
                event = {
                    "id": event_data.get("id", f"breakthrough-{int(time.time()*1000)}"),
                    "timestamp": event_data.get("timestamp", time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())),
                    "type": event_data.get("type", "BREAKTHROUGH"),
                    "severity": event_data.get("severity", "CRITICAL"),
                    "title": event_data.get("title", "Breakthrough Event"),
                    "summary": event_data.get("summary", ""),
                    "bounds_impact": event_data.get("bounds_impact", ""),
                    "lean_file": event_data.get("lean_file", ""),
                    "commit": event_data.get("commit", "")
                }
                data["events"].append(event)
                data["last_updated"] = time.strftime("%Y-%m-%dT%H:%M:%S%z")

                # If bounds updates were passed
                if "bounds_update" in event_data:
                    for k, v in event_data["bounds_update"].items():
                        if k in data.get("bounds", {}):
                            data["bounds"][k].update(v)

                save_breakthroughs(data)
                broadcast_event(data)

                # Open or bring Google Chrome to front
                open_in_chrome()

                self.send_json({"status": "published", "event": event})
            except Exception as e:
                self.send_error(400, f"Invalid JSON payload: {e}")
        else:
            self.send_error(404, "Not Found")

    def serve_file(self, file_path, content_type):
        if not os.path.exists(file_path):
            self.send_error(404, "File Not Found")
            return
        with open(file_path, "rb") as f:
            content = f.read()
        self.send_response(200)
        self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(content)))
        self.send_header("Cache-Control", "no-cache, no-store, must-revalidate")
        self.end_headers()
        self.wfile.write(content)

    def send_json(self, obj):
        content = json.dumps(obj).encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(content)))
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(content)

    def handle_sse(self):
        self.send_response(200)
        self.send_header("Content-Type", "text/event-stream")
        self.send_header("Cache-Control", "no-cache")
        self.send_header("Connection", "keep-alive")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()

        q = queue.Queue()
        with subscribers_lock:
            subscribers.append(q)

        # Send initial data immediately
        init_payload = f"data: {json.dumps(load_breakthroughs())}\n\n".encode("utf-8")
        try:
            self.wfile.write(init_payload)
            self.wfile.flush()
        except Exception:
            with subscribers_lock:
                if q in subscribers:
                    subscribers.remove(q)
            return

        try:
            while True:
                try:
                    msg = q.get(timeout=20.0)
                    self.wfile.write(msg)
                    self.wfile.flush()
                except queue.Empty:
                    # Keepalive comment
                    self.wfile.write(b": keepalive\n\n")
                    self.wfile.flush()
        except (BrokenPipeError, ConnectionResetError):
            pass
        finally:
            with subscribers_lock:
                if q in subscribers:
                    subscribers.remove(q)


class ThreadedHTTPServer(socketserver.ThreadingMixIn, http.server.HTTPServer):
    daemon_threads = True
    allow_reuse_address = True


def run_server():
    server = ThreadedHTTPServer((HOST, PORT), BreakthroughHandler)
    print(f"[Monitoring Server] Running at http://{HOST}:{PORT}")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()


if __name__ == "__main__":
    run_server()
