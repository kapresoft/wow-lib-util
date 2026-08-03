# CLAUDE.md

## Description
A shared LibStub-based utility library for Kapresoft WoW addons -- string, table, mixin, assertion, and sequence helpers, plus a Lua evaluator and logging mixins. Not a standalone addon; other addons depend on it via CurseForge.

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`wow-lib-util` (packaged as `Kapresoft-LibUtil`) is a **library addon**, not a standalone player-facing addon -- other kapresoft addons (ActionbarPlus, DevSuite, AddonSuite, DebugChatFrame) embed or vendor its code. It bundles two distinct things under one repo:

- **`Lib/`** -- **version 1, deprecated** -- the actual `LoadOnDemand` WoW addon (`Kapresoft-LibUtil.toc` -> `_Lib.xml`), providing `LibStub`-registered libraries (`Kapresoft-String-1.0`, table/mixin/assert/sequence utilities, a Lua evaluator, logger mixins, etc.) that a consumer addon pulls in at runtime via `LibStub(...)`.
- **`Lib-2-0/`** -- a **source-only** collection of `.lua` files (`AceLib.lua`, `ModuleUtil.lua`, `GameVersionMixin.lua`, `DebugChatFrameMixin.lua`, etc.) that is *not* loaded by this repo's own TOC/XML at all. It exists to be **vendored file-by-file** into consumer repos (see e.g. ActionbarPlus's or AddonSuite's `pkgmeta.yaml`, which `externals:`-pull this repo into `ThirdParty/Libs/Kapresoft-LibUtil/` and then `ignore:` specific `Lib-2-0/*.lua` files that duplicate what the consumer already embeds elsewhere). When editing `Lib-2-0/`, remember changes only take effect in consumers after their own `w-sync-libs` pulls this repo again -- there is no runtime loading path inside this repo to test `Lib-2-0/` changes directly in WoW.

## Build & Release

### Pull external library dependencies (LibStub, Ace3)

```shell
./pull-extlibs.sh
```

### Run automated tests

Unlike the addon repos in this family, `Lib/` has real, WoW-independent automated tests -- run them with plain Lua, no in-game step required:

```shell
./dev/run-all-tests.sh
# or individually:
./dev/run-lua <name>       # e.g. ./dev/run-lua string
./dev/run-lua <name> 1     # interactive mode
```

Tests live as `dev/test-*.lua` (plain-Lua, `LibStub`-based, using `dev/lib/` as WoW-API shims) and `dev/spec/*_spec.lua` (busted-style specs, run via `./dev/run-busted`). **Run the relevant test after touching anything under `Lib/`** -- this is the one repo in this family where that's actually possible before asking the user to validate in-game.

### Release process
1. Create pull requests
2. Create tag to publish -- an automated github action will push any tag created
3. Verify CurseForge build is green (if applicable), then publish the GitHub draft release

### Local in-game deployment (`dev/deployer-config.lua`)

`dev/deployer-config.lua` drives the `deployer` CLI tool (`deployer --config dev/deployer-config.lua -q -n --watch`) to copy/sync source folders straight into local WoW client AddOns directories for in-game testing. Key mapping: the `Lib-2-0` addon entry is deployed `as = 'LibUtil'` -- i.e. `Lib-2-0/` is copied to an AddOns folder literally named `LibUtil` (not `Lib-2-0`), to each configured client (`classic-era`, `classic`, `classic-anniversary`, `retail`) via `env.wow.<client>.addOnDir`. `env` comes from `require('user-env')`, a local/untracked module (machine-specific WoW install paths) not present in this repo -- the deployer config alone isn't runnable without it.

**Why this matters when debugging:** the deployed tree is a 1:1 copy of `Lib-2-0/`, so a file/path referenced in `Lib-2-0/*.xml` or `*.toc` resolves the same way in-game under `Interface/AddOns/LibUtil/...` as it does in the repo under `Lib-2-0/...`. If an in-game `LUA_WARNING` cites a path like `LibUtil/LibUtil.xml:6 Error loading LibUtil/Libs/...`, that maps directly back to `Lib-2-0/LibUtil.xml` in this repo -- check `<Script file="...">`/`<Include file="...">` paths there relative to `Lib-2-0/`, not relative to the referencing file's own subfolder.

## Architecture

### `Lib/` load order (`_Lib.xml`)

`Constants.lua` and `Init.lua` load first, then `LibStubMixin`, `pprint`, `LibFactoryMixin`, `Library.lua`, `LibModule`, `Mixin`, `Assert`, `Table`, `String`, `Ace3`, `IncrementerBuilder`, `SequenceMixin`, `LuaEvaluator`, `Safecall`, `LoggerMixin`, `Util`, then the namespace mixins (`NamespaceKapresoftLibMixin.lua`, `NamespaceAceLibraryMixin.lua`, `CoreNamespaceMixin.lua`). Each subfolder under `Lib/` has its own `_<Name>.xml` include file -- add new files there, not directly in `_Lib.xml`, unless introducing a new top-level module.

### `Lib-2-0/` contents

Standalone `.lua` files, each typically a single `LibStub`-style module (`AceLib.lua`, `AddonUtil.lua`, `AddonInfoUtil.lua`, `ColorFormatter.lua`, `ConsoleHelperMixin.lua`, `DebugChatFrameMixin.lua`, `GameVersionMixin.lua`, `ModuleUtil.lua`, `SequenceMixin.lua`, `String.lua`, `Table.lua`, `TimeUtil.lua`, `AceConfigUtil.lua`, `AceLocaleUtil.lua`), plus `Annotations/Annotations-2-0.lua` for EmmyLua types. These map 1:1 to the `ThirdParty/Libs/Kapresoft-LibUtil/Lib-2-0/*.lua` paths referenced in consumer `pkgmeta.yaml` files -- keep filenames stable, since renaming one means updating every consumer's `ignore:`/`externals:` list too.

### Dev-only code

No `--@debug@`/`--@do-not-package@` tokens are used here the way they are in the addon repos -- `Lib/` is a library with no in-game debug UI of its own; dev/test scaffolding lives entirely under `dev/`, already excluded from packaging via `pkgmeta.yaml`'s `ignore:` list.

## Key conventions

- **Mixin-based OOP** -- composition via `Mixin()`/`CreateFromMixins()`, not inheritance chains. Keep mixins focused on a single concern.
- **EmmyLua annotations** -- the codebase uses EmmyLua (`---@param`, `---@return`, `---@class`) for IDE type checking. Maintain these on public APIs, especially in `Lib-2-0/Annotations/Annotations-2-0.lua` since consumer repos type-check against it.
- **This is a consumed library, twice over** -- `Lib/`'s public LibStub API and `Lib-2-0/`'s vendored file contents are both depended on by other kapresoft addons. Avoid breaking changes to either without checking downstream consumers (ActionbarPlus, DevSuite, AddonSuite, DebugChatFrame all pull from this repo).
- **Test before asking for in-game validation** -- since `Lib/` has real automated tests, run them (`./dev/run-all-tests.sh` or the specific `./dev/run-lua <name>`) after any change under `Lib/`, rather than defaulting to "validate in-game" as the other repos in this family do.

## Code style

Formatting is enforced by `stylua.toml`: 100-column width, 2-space indent, Unix line endings, prefer single quotes, keep parens on function calls, collapse simple statements onto one line. Match this on touched lines; don't reformat whole files as a side effect of an unrelated change.
