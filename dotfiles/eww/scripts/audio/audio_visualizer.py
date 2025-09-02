#!/usr/bin/env python3
# ─────────────────────────────────────────────────────────────────────────────
#  °˖* ૮(  • ᴗ ｡)っ🍸  pewdiepie/archdaemon/dionysh shhheersh
#  vers. 1.0
# ─────────────────────────────────────────────────────────────────────────────
#  Reads /tmp/cava.raw and writes an ASCII‑art file that can be shown by eww, 
#  waybar, or any terminal widget. Can run as exec once in hyprland config.
# ─────────────────────────────────────────────────────────────────────────────

import argparse
import os
import select
import signal
import sys
import time
from pathlib import Path
from typing import NoReturn

import numpy as np

# ── Default visual parameters ───────────────────────────────────────────────
DEFAULT_WIDTH  = 64
DEFAULT_HEIGHT = 12
DEFAULT_FPS    = 30
DEFAULT_DECAY  = 0.92               # lower → longer trails
CHARS = [" ", ".", ":", "·", "•", "•"]   # ascending intensity
FIFO_MAX_READ  = 4096

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


def build_frame(history: np.ndarray, height: int, width: int) -> list[str]:
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
    *,
    cava_fifo_fd: int,
    out_path: Path,
    width: int = DEFAULT_WIDTH,
    height: int = DEFAULT_HEIGHT,
    fps: int = DEFAULT_FPS,
    decay: float = DEFAULT_DECAY,
    fifo_max_read: int = FIFO_MAX_READ
) -> None:
    """Main loop – read CAVA output, update the decay buffer, write ASCII."""
    if not out_path.parent.exists():
        os.makedirs(out_path.parent)

    polling_handler = select.poll()
    polling_handler.register(cava_fifo_fd, select.POLLIN)

    decay_buffer = np.zeros((height, width), dtype=float)

    sleep_duration = 1.0 / fps
    while True:
        if not polling_handler.poll():
            time.sleep(sleep_duration)
            continue

        line = os.read(cava_fifo_fd, fifo_max_read).decode()

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
        ascii_lines = build_frame(decay_buffer, height, width)
        with open(out_path, "w") as out:
            out.write("\n".join(ascii_lines))

        time.sleep(sleep_duration)



def _handle_sigint(fifo_fd: int) -> NoReturn:
    """Graceful exit on Ctrl‑C."""
    print("\n[+] CAVA ASCII visualizer stopped.")

    os.close(fifo_fd)

    sys.exit(0)


def main() -> None:
    parser = argparse.ArgumentParser(
        description="CAVA → ASCII visualizer (compatible with eww/widgets)",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument("--cava-path", type=Path, default="/tmp/cava.raw",
                        help="Path to CAVA raw output file")
    parser.add_argument("--out-path", type=Path, default="/tmp/visualizer.txt",
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

    # make our life easier regarding the fifo
    assert args.cava_path.exists()
    assert args.cava_path.is_fifo()

    cava_fifo_fd = os.open(args.cava_path, os.O_RDONLY | os.O_NONBLOCK)

    signal.signal(signal.SIGINT, lambda _, __: _handle_sigint(cava_fifo_fd))

    print("[+] Starting CAVA ASCII visualizer …")
    run(
        cava_fifo_fd=cava_fifo_fd,
        out_path=args.out_path,
        width=args.width,
        height=args.height,
        fps=args.fps,
        decay=args.decay,
    )


if __name__ == "__main__":
    main()
