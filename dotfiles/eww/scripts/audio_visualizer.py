#!/usr/bin/env python3
# ─────────────────────────────────────────────────────────────────────────────
#  °˖* ૮(  • ᴗ ｡)っ🍸  pewdiepie/archdaemon/dionysh
#  shhheersh
#  vers. 1.0
# ─────────────────────────────────────────────────────────────────────────────
#  Reads /tmp/cava.raw and writes an ASCII‑art file that can be shown by eww, 
#  waybar, or any terminal widget. Can run as exec once in hyprland config.
# ─────────────────────────────────────────────────────────────────────────────

import argparse
import os
import signal
import sys
import time

import numpy as np

# ── Default visual parameters ───────────────────────────────────────────────
DEFAULT_WIDTH  = 64
DEFAULT_HEIGHT = 12
DEFAULT_FPS    = 30
DEFAULT_DECAY  = 0.92               # lower → longer trails
CHARS = [" ", ".", ":", "·", "•", "•"]   # ascending intensity


def parse_frame(line: str, width: int) -> list[int]:
    """Turn a semicolon‑separated line from CAVA into a list of ints."""
    try:
        return [int(x) for x in line.strip().split(";") if x][:width]
    except ValueError:
        return [0] * width


def normalize(vals: list[int]) -> np.ndarray:
    """Scale values to the range [0, 1]."""
    arr = np.array(vals, dtype=float)
    return (arr - arr.min()) / (arr.max() - arr.min() + 1e-5)


def get_char_index(val: float) -> int:
    """Map a normalized value to the appropriate character index."""
    return min(int(val * (len(CHARS) - 1)), len(CHARS) - 1)


def build_frame(_, history: np.ndarray, height: int, width: int) -> list[str]:
    """Create the ASCII rows from the decay buffer."""
    frame = [[" " for _ in range(width)] for _ in range(height)]

    for x in range(width):
        for y in range(height):
            strength = history[y, x]
            idx = get_char_index(strength)
            frame[height - y - 1][x] = CHARS[idx]

    # No baseline drawing – the “remove” request is satisfied
    return ["".join(row) for row in frame]


def run(
    cava_path: str,
    out_path: str,
    width: int = DEFAULT_WIDTH,
    height: int = DEFAULT_HEIGHT,
    fps: int = DEFAULT_FPS,
    decay: float = DEFAULT_DECAY,
) -> None:
    """Main loop – read CAVA output, update the decay buffer, write ASCII."""
    os.makedirs(os.path.dirname(out_path), exist_ok=True)

    decay_buffer = np.zeros((height, width), dtype=float)

    while True:
        try:
            with open(cava_path, "r") as f:
                # read one line at a time from the FIFO
                line = f.readline()
                if not line:
                    time.sleep(1.0 / fps)
                    continue
        except Exception:
            time.sleep(1.0 / fps)
            continue

        # 1️⃣ Parse & normalise
        values = parse_frame(line, width)
        values = normalize(values) if values else np.zeros(width)

        # 2️⃣ Build a binary “bars” matrix for the current frame
        new_frame = np.zeros((height, width), dtype=float)
        for i, val in enumerate(values):
            bar_h = int(val * height)
            new_frame[:bar_h, i] = 1.0

        # 3️⃣ Apply decay (trails) and blend with the new frame
        decay_buffer = np.maximum(decay_buffer * decay, new_frame)

        # 4️⃣ Render ASCII and write out
        ascii_lines = build_frame(values, decay_buffer, height, width)
        with open(out_path, "w") as out:
            out.write("\n".join(ascii_lines))

        time.sleep(1.0 / fps)



def _handle_sigint(signum, frame):
    """Graceful exit on Ctrl‑C."""
    print("\n[+] CAVA ASCII visualizer stopped.")
    sys.exit(0)


def main() -> None:
    parser = argparse.ArgumentParser(
        description="CAVA → ASCII visualizer (compatible with eww/widgets)",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument("--cava-path", default="/tmp/cava.raw",
                        help="Path to CAVA raw output file")
    parser.add_argument("--out-path",  default="/tmp/visualizer.txt",
                        help="File where ASCII art will be written")
    parser.add_argument("--width",  type=int, default=DEFAULT_WIDTH,
                        help="Number of columns (match CAVA `bars` setting)")
    parser.add_argument("--height", type=int, default=DEFAULT_HEIGHT,
                        help="Number of rows in the ASCII canvas")
    parser.add_argument("--fps",    type=int, default=DEFAULT_FPS,
                        help="Refresh rate (frames per second)")
    parser.add_argument("--decay",  type=float, default=DEFAULT_DECAY,
                        help="Trail‑fade factor (0‑1, lower = slower fade)")

    args = parser.parse_args()
    signal.signal(signal.SIGINT, _handle_sigint)

    print("[+] Starting CAVA ASCII visualizer …")
    run(
        cava_path=args.cava_path,
        out_path=args.out_path,
        width=args.width,
        height=args.height,
        fps=args.fps,
        decay=args.decay,
    )


if __name__ == "__main__":
    main()
