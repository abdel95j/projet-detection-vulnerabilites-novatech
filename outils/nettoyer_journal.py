from pathlib import Path
import re
p = Path.home() / "projet/journal.txt"
s = p.read_text(errors="replace")
s, n = re.subn(r"(User created with password\s+)'[^'\r\n]*'", r"\1'[MASQUE POUR PARTAGE]'", s)
p.write_text(s)
print("Journal nettoye, occurrences masquees :", n)
