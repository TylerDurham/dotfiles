Create an annotated git tag on the current HEAD commit.

Arguments: $ARGUMENTS — expected format: `<tag-name> [description]`

Steps:
1. Parse $ARGUMENTS:
   - The first word is the **tag name**.
   - Everything after the first word is the **description**. If no description is provided, use an empty string.
2. Validate the tag name:
   - Must not be empty — if it is, tell the user the usage and stop.
   - Must not already exist locally (`git tag -l <name>`) — if it does, tell the user and stop.
3. Run `git log --oneline -1` to show which commit will be tagged.
4. Create the annotated tag:

```bash
git tag -a "<tag-name>" -m "<description>"
```

5. Show confirmation: print the tag name, the commit it points to (`git rev-parse --short <tag-name>`), and the tag message.

Do **not** push the tag to the remote unless the user asks.
Do **not** ask for confirmation — just tag.
