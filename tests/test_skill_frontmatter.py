from pathlib import Path


def test_skill_metadata_is_single_line_json():
    skill = Path(__file__).resolve().parents[1] / "SKILL.md"
    metadata_line = next(line for line in skill.read_text(encoding="utf-8").splitlines() if line.startswith("metadata:"))
    assert metadata_line.startswith("metadata: {")
    assert metadata_line.rstrip().endswith("}")
