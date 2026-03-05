#!/usr/bin/env python3
"""Delete analyzer page routes from index.tsx (already extracted to separate files)"""

import os

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
INDEX = os.path.join(BASE, "src", "index.tsx")

with open(INDEX, "r", encoding="utf-8") as f:
    lines = f.readlines()

print(f"Before: {len(lines)} lines")

# Find analyzer/job start: "// AI Job Analyzer" comment + app.get('/analyzer/job'
# Find analyzer/major end: the closing }) after "AI 전공 추천" return

# L278-15320 based on our read (comment line at 278, closing }) at 15320)
# But let's be precise - find them
job_start = None
major_end = None

for i, line in enumerate(lines):
    if "// AI Job Analyzer v2.0.0" in line and job_start is None:
        job_start = i  # 0-indexed
    if "AI 전공 추천 - Careerwiki" in line and "return c.html" in line:
        # The next line with }) is the end
        for j in range(i+1, min(i+5, len(lines))):
            if lines[j].strip() == "})":
                major_end = j + 1  # exclusive
                break

if job_start is None or major_end is None:
    print(f"ERROR: Could not find boundaries. job_start={job_start}, major_end={major_end}")
    exit(1)

print(f"Deleting lines {job_start+1} to {major_end} (0-indexed {job_start} to {major_end-1})")
print(f"  First line: {lines[job_start].rstrip()}")
print(f"  Last line:  {lines[major_end-1].rstrip()}")

del lines[job_start:major_end]

# Also clean up leftover comments/blank lines between routes
# Look for orphaned comments like "// API 엔드포인트들" etc.

with open(INDEX, "w", encoding="utf-8") as f:
    f.writelines(lines)

print(f"After: {len(lines)} lines")
