---
name: ASCII banner style preference
description: User prefers ASCII/figlet banners without surrounding box frames
type: feedback
originSessionId: 92ae773f-5295-472a-be32-1017f55f9734
---
Don't wrap ASCII/figlet banners in box-drawing character frames (┌─┐│└─┘). Use the banner text directly followed by plain `#` comment lines.

**Why:** User explicitly asked to remove the box after seeing it — clean banner without frame is preferred.

**How to apply:** When generating file headers with ASCII art, skip the box entirely. Just the banner + description lines.
