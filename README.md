[![Release Build](https://github.com/kapresoft/wow-lib-util/actions/workflows/release-build.yml/badge.svg)](https://github.com/kapresoft/wow-lib-util/actions/workflows/release-build.yml)

# LibUtil by Kapresoft :: The boring code your addon needs, written once.
> ▶ A [World of Warcraft](https://worldofwarcraft.com/) AddOn

![download-count](https://cf.way2muchnoise.eu/full_1638413_downloads.svg?badge_style=for_the_badge) ![supported-wow-versions](https://cf.way2muchnoise.eu/versions/World%20of%20Warcraft%20Versions_1638413_all.svg?badge_style=for_the_badge)

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
[MIT](LICENSE)

### Donations

If LibUtil has made your addon development easier, consider supporting its development:

- **[Paypal&trade; Donation](https://www.paypal.com/donate/?hosted_button_id=AX58YP3GSGXVU)**
- **[Bitcoin Donation](https://www.blockchain.com/btc/address/3QQVAwJGkKHMM2oq6CLVWYgfx83TFVwp39)**

## About

- About the Author [(Tony Lagnada)](https://tony.resume.lagnada.com/)
- My AddOn Portfolio Can Be Found Here [Curse Forge/Kapresoft](https://www.curseforge.com/members/kapresoft/projects)
