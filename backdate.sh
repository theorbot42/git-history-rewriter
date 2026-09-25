#!/usr/bin/env bash
set -euo pipefail

# Generate backdated commits across a day range
DAYS=${1:-10}

for (( i=DAYS-1; i>=0; i-- )); do
  DATE=$(date -d "$i days ago" +"%Y-%m-%d 12:00:00")
  FILE="day-${i}.txt"
  echo "Commit for day -$i ($DATE)" > "$FILE"
  git add "$FILE"
  GIT_AUTHOR_DATE="$DATE" GIT_COMMITTER_DATE="$DATE" git commit -m "feat: commit day -$i ($DATE)"
done

echo "Done. Run 'git push origin main' to sync."
