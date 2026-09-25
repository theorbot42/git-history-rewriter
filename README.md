# Git commit dates: a safe testing note

This repository documents how Git records commit timestamps. It does not provide a bulk backdating or contribution-graph manipulation tool.

## The two dates in a commit

Git stores two timestamps:

- **Author date**: when the change was originally authored.
- **Committer date**: when the commit object was created (or most recently rewritten).

For a one-off, isolated test, Git accepts date environment variables for a single commit:

```sh
GIT_AUTHOR_DATE="2024-01-15T12:00:00+01:00" \
GIT_COMMITTER_DATE="2024-01-15T12:00:00+01:00" \
git -C /path/to/disposable-repo commit --allow-empty -m "timestamp test"
```

Use a disposable local repository and dates that accurately describe the test. `GIT_AUTHOR_DATE` and `GIT_COMMITTER_DATE` affect only the process environment for that command; they do not change system time. Git accepts several date formats; ISO 8601 with an explicit timezone is a clear choice.

Inspect the stored values with:

```sh
git log -1 --format='author: %aI%ncommitter: %cI'
```

## Important limitations

Timestamps are metadata supplied by the commit creator, not an independently verified record of when work happened. Rewriting them changes commit IDs, and pushing rewritten history can affect collaborators. Do not use fabricated dates to misrepresent work or manipulate contribution displays. GitHub contribution attribution also depends on GitHub's account, repository, and branch eligibility rules; changing timestamps does not guarantee a contribution is shown.

For history repair, preserve accurate original author dates and coordinate with everyone using the affected branch before rewriting or force-pushing. For experiments, keep them local and disposable.
