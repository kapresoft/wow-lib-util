# LibUtil by Kapresoft

A shared **LibStub-based utility library** for WoW addons. This is a library addon, not a standalone player-facing addon — it provides no UI of its own and does nothing on its own once installed. Other addons (such as ActionbarPlus, DevSuite, AddonSuite, and DebugChatFrame) depend on it via CurseForge or embed/vendor its code directly.

## What's included

- **String** — string utility library
- **Table** — helpers for common table operations
- **Assertion** — lightweight runtime assertions
- **Sequence** — sequence/iterator helpers
- **Lua evaluator** — safe evaluation of Lua expressions
- **Logger mixins** — structured logging helpers for addon development
- ... and many more

## Who this is for

Addon developers who want to reuse common Lua/WoW-API helpers instead of reimplementing them per-addon. If you're a player who installed this directly, you likely don't need to interact with it — check which addon listed it as a dependency.

## License
[MIT](LICENSE.md)
