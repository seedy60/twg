# Ultra World (UW)

Ultra World is an **audio-only multiplayer game** — a real‑time world where you fight, hunt,
explore, craft, trade, socialize, and build your own maps, all through sound and a screen
reader rather than graphics. It is written in **[NVGT](https://nvgt.gg)** (the NonVisual
Gaming Toolkit), a scripting engine built on AngelScript, and ships as two programs:

| Program | Entry script | Build config | Role |
| --- | --- | --- | --- |
| **Client** | `client/uw.nvgt` | `client/uw.json` | What players run (`uw.exe`). Connects to a server. |
| **Server** | `server/uwserver.nvgt` | `server/uwserver.json` | The authoritative dedicated server that hosts the world. |

- **Current version:** 2518 (see `client/application.nvgt` / `server/application.nvgt`)
- **Default game server:** `twg.seedy.cc:6200`
- **Game port (UDP/ENet):** `6200`
- **Contact:** uwgame@outlook.com

> This README is the developer/operator guide (building, running, hosting, administration).
> For the **player** guide — gameplay, the full hotkey walkthrough, map building, and the
> Dynamic Variable System — read [`client/docs/readme.txt`](client/docs/readme.txt), or press
> **Shift+H** in game.

---

## Table of contents

1. [Prerequisites](#prerequisites)
2. [Getting the code and assets](#getting-the-code-and-assets)
3. [Running from source (dev loop)](#running-from-source-dev-loop)
4. [Compiling release builds](#compiling-release-builds)
5. [Hosting a server](#hosting-a-server)
6. [Repository layout](#repository-layout)
7. [Staff, admin & developer system](#staff-admin--developer-system)
8. [Slash commands](#slash-commands)
9. [Hotkeys (quick reference)](#hotkeys-quick-reference)
10. [Client auto-update](#client-auto-update)
11. [Existing documentation](#existing-documentation)

---

## Prerequisites

- **NVGT** — download and install from <https://nvgt.gg>. NVGT runs `.nvgt` scripts directly
  and compiles them into standalone executables. On Windows it also installs right‑click
  "Run"/"Compile" context‑menu entries for `.nvgt` files.
- **NVGT plugins used by the client** (declared with `#pragma plugin` in `client/uw.nvgt`):
  - `legacy_sound`
  - `nvgt_curl`

  These ship with NVGT; make sure your NVGT install includes them.
- **Audio assets are not in this repository** — see the next section.

> ⚠️ The exact NVGT command‑line flags below follow NVGT's documented conventions. NVGT was
> not detected on this machine's `PATH`, so treat the official docs at <https://nvgt.gg> as the
> authoritative source if a flag has changed in your NVGT version. The right‑click context‑menu
> ("Run" / "Compile") is the simplest and most reliable route on Windows.

## Getting the code and assets

```sh
git clone https://github.com/seedy60/twg
```

The repo contains **all source code and game data**, but **not the packaged audio**. The real
sound pack is a binary `.dat` file that is git‑ignored (see `.gitignore`) and distributed with
the official game build. The 28‑byte `client/pack.pk` you see in the repo is **not** the sound
pack — it is only the saved settings file for the pack‑creator tool.

- To build/refresh the audio pack from a folder of sounds, use `client/pack_creator.nvgt`
  (by HarryMK) and `client/soundlength.nvgt`.
- For a playable client you must obtain the audio assets from the official distribution and
  place them alongside `uw.exe` / `uw.nvgt`.

## Running from source (dev loop)

You don't have to compile to test — NVGT can run a script in place.

**Client** (connects to `twg.seedy.cc:6200` by default):

```sh
nvgt client/uw.nvgt
```

or right‑click `client/uw.nvgt` → **Run**.

**Server** (listens on UDP `6200`):

```sh
nvgt server/uwserver.nvgt
```

**Testing client + server locally:** start the server, then in the client open
**main menu → misc → "Server connection settings"** and set the address to `127.0.0.1` (and the
port to match the server). The values are saved to preferences and reused on the next connect.
The defaults live in `client/includes/net.nvgt` (`mainnetaddress = "twg.seedy.cc"`,
`netport = 6200`); a dev-only localhost toggle also exists in uncompiled builds.

## Compiling release builds

Each entry script has a sibling `.json` that NVGT auto‑loads to configure the build
(it is matched by filename: `uw.nvgt` ↔ `uw.json`, `uwserver.nvgt` ↔ `uwserver.json`).

**Client → `uw.exe`**

```sh
nvgt -c client/uw.nvgt      # compile (release); see `nvgt --help` for your version's flags
```

`client/uw.json`:
```json
{ "build": { "product_identifier": "com.ultraworld.uw", "windows_bundle": 1 },
  "scripting": { "allow_multiline_strings": true } }
```
The client also bundles data into the executable via `#pragma asset` (the `docs/` folder and
`unzip.bat`, used by the auto‑updater).

**Server → server binary**

```sh
nvgt -c server/uwserver.nvgt
```

`server/uwserver.json` sets `"linux_bundle": 1` (the production server targets Linux, but the
script also runs on Windows from source). The server bundles its rules, `readme.txt`,
`commands.md`, `commands-staff.md`, and changelogs as assets via `#pragma asset`.

> The compiled server enforces a **single instance** (`instance uwserverinstance("uwserver.exe")`),
> so only one copy can run per machine at a time.

## Hosting a server

1. Build or run `server/uwserver.nvgt`. It listens on UDP port **6200** by default
   (`n.setup_server(6200, 20, 500)` — port, plus ENet peer/channel limits). Override the port at
   launch with **`-p <port>`** (e.g. `uwserver.exe -p 7000`, or `nvgt server/uwserver.nvgt -p 7000`);
   the active port is printed on startup.
2. On startup it loads server data, the map system, auctions, the XP schedule, and feedback,
   then enters its main loop and prints `Server is running.`
   - On Windows it opens a window titled `Ultra World Server version <version>`.
   - On Linux it runs headless in the console.
3. **Operator keys while the server window is focused:**
   - **H** — hide the server window
   - **Escape** — shut the server down
4. Open the server's UDP port (default **6200**, or whatever you passed to `-p`) on the
   host/firewall so clients can connect.

Runtime data is written into git‑ignored folders next to the server (created on demand):
`chars/`, `maps/` (except the bundled `main_map`), `teams/`, `houses/`, `apartments/`,
`lockers/`, `fridges/`, `microwaves/`, `playerstores/`, `vehicles/`, `logs/`, and more — see
`.gitignore` for the full list. Config/data that **is** tracked includes `staff.json`,
`languages.json`, `countries.json`, `item_descriptions.svr`, `drawsounds.svr`, the AI/mob
definitions in `ais/`, and the consumable definitions in `foods_and_drinks/`.

## Repository layout

```
client/                  Client (player) program
  uw.nvgt                Client entry point  (config: uw.json)
  application.nvgt       App name/version/website
  includes.nvgt          Master #include list
  includes/              Client modules: gameloop, input, net, inventory, map, menus, audio…
  docs/                  Player readme.txt, rules.txt, changes.md  (bundled into uw.exe)
  pack_creator.nvgt      Tool to build the audio .dat pack (assets themselves are not tracked)
  unzip.bat              Used by the in-game auto-updater

server/                  Dedicated server program
  uwserver.nvgt          Server entry point  (config: uwserver.json)
  application.nvgt       App name/version/website
  includes.nvgt          Master #include list
  includes/              Server modules: commands, staff, network, player, map, events…
  ais/                   Mob/animal/vehicle/boss definitions (*.ai)
  foods_and_drinks/      Consumable item definitions (*.fad)
  ntm/                   Additional item data (*.json)
  staff.json             Staff role definitions (see below)
  commands.md            Player-facing command reference (shown in game via /cmds)
  commands-staff.md      Staff/admin command reference (shown via /admincmds, staff only)
  rules/staff.md         Staff conduct rules
  changelogs/            server.md, client.md (bundled and viewable in game)
```

## Staff, admin & developer system

Ranks are defined in **`server/staff.json`** by a `pos` (position) value — **lower `pos` = higher
authority**:

| Role (`type`) | `pos` | Meaning |
| --- | --- | --- |
| `developer` | 0 | Highest. Can code; effectively unlimited in‑game. |
| `manager` | 10 | Access to all game commands, but cannot code. |
| `admin` | 20 | Most administrative, security, and server‑management tasks. |
| `ast` (assistant) | 30 | Assists/moderates players: kick, jail, warn, etc. |

### How a character becomes staff

The system is **file‑based**: a character has a role if the file
`server/chars/<charname>/<role>.staff` exists. `is_staff(name, type)` simply checks for that
file (see `server/includes/staff.nvgt`). The character folder must already exist (i.e. the
account must have been created).

There are **no hardcoded developers** — every staff role, including developer, comes from the
`.staff` files described above. On a brand-new server with no staff yet, bootstrap the first
developer manually (see *Granting a role manually (offline)* below): create
`server/chars/<charname>/developer.staff`, then run `/staffr` or restart. That developer can
then promote everyone else in game with `/newstaff`.

### Granting / revoking roles in game

Use these commands (you must be a **manager or higher**, and you cannot grant or remove a role
that is equal to or higher than your own):

| Command | Effect |
| --- | --- |
| `/staff` | Open the staff menu. |
| `/newstaff <charname> <role>` | Promote: creates `chars/<charname>/<role>.staff`. |
| `/delstaff <charname> <role>` | Demote: deletes that `.staff` file. |
| `/staffr` | Reload `staff.json` after editing roles by hand. |

### Granting a role manually (offline)

Create an empty file `server/chars/<charname>/<role>.staff` (for example
`server/chars/alice/developer.staff`), then run `/staffr` in game (or restart the server).

> **Language Channel Managers (LCM)** are a sub‑role stored at
> `server/chars/<name>/lcm/<language>.staff` and managed with the `/mlmgr`, `/lcms`, and
> `/newlmotd` commands.

Capability checks used throughout the code: `is_dev()`, `is_manager()`, `is_admin()`,
`is_assistant()`, and `buildable()` — where each higher rank also satisfies the lower checks.
Staff conduct is governed by [`server/rules/staff.md`](server/rules/staff.md).

## Slash commands

**How to enter a command in game:** press **`/`** (then type the command name), or type **`//`**,
or press **`=`** (equals) — all open the command line. Arguments are shown as `<arg>`.

- **`/cmds`** — the complete, frequently‑updated player command list (reads `commands.md`).
- **`/admincmds`** — the staff command reference (staff only; reads `commands-staff.md`).
- **`/help`** (or **Shift+H**) — the help menu.
- **`/banguide`** and **`/eventhelp`** — built‑in guides for the ban and event systems.

The player‑facing commands (general, status, trust/mute, messages, and the full team command
set) are documented in **[`server/commands.md`](server/commands.md)**.

Staff/admin commands are documented separately — with their required rank — in
**[`server/commands-staff.md`](server/commands-staff.md)** (moderation, player stats,
items/economy, movement, world/AI, maps, XP/events, messaging, language channels, teams,
server control, logs/diagnostics). That file is **staff‑only**: it is shown in game by
**`/admincmds`** (gated to staff, mirroring `/adminrules`) and is *not* part of the public
`/cmds` listing. The commands themselves are defined in `server/includes/commands.nvgt`, the
authoritative source for exact arguments and rank gating.

## Hotkeys (quick reference)

The full, authoritative walkthrough is in [`client/docs/readme.txt`](client/docs/readme.txt)
(and **Shift+H** in game). Key handling lives in `client/includes/gameloop.nvgt`. Essentials:

| Action | Key |
| --- | --- |
| Move | Arrow keys (Up = forward, Down = back, Left/Right = strafe) |
| Turn 90° | **Q** / **E** |
| Check facing direction | **F** |
| Jump (with arrows for direction) | **Shift+Space** |
| Climb up / down | **Page Up** / **Page Down** |
| Sit / stand | **Alt+R** |
| Open / close inventory | **I** / **Escape** |
| Left hand / right hand | **1** / **2** (or numpad) |
| Action held item / alternate action | **Space** / **Alt+Space** |
| Clap / snap fingers | **T** / **Alt+T** |
| Fire weapon / reload / check ammo | **Ctrl** / **R** / **Alt+Z** |
| Language‑channel chat | **/** |
| Team chat | **Shift+'** (or `/t`) |
| Spouse chat | **'** (apostrophe) |
| Reply to last private message | **/r** |
| Who's online / players in your map | **F1** / **F5** |
| Browse online players (then **F2** to PM) | **Shift+F5** |
| Ask staff / send feedback | **F7** |
| Help | **Shift+H** |
| Command line / menus | **=** |
| Landmarks (then track with **O**) | **Shift+`** |
| Track a player | **W** |
| Map builder menu (in your map) | **B** |
| Toggle newbie flag | type **=** then `newbie!` |

## Client auto-update

The client can update itself: it downloads `uw-c.zip`, and the bundled `client/unzip.bat`
expands it over the install and relaunches `uw.exe`. (See the `*updater.nvgt` modules in
`client/includes/`.)

## Existing documentation

- [`client/docs/readme.txt`](client/docs/readme.txt) — player guide: gameplay, hotkeys, map
  building, and the Dynamic Variable System (gender/map/message variables).
- [`client/docs/rules.txt`](client/docs/rules.txt) / [`server/rules.txt`](server/rules.txt) — game rules.
- [`server/commands.md`](server/commands.md) — player command reference (also shown via `/cmds`).
- [`server/commands-staff.md`](server/commands-staff.md) — staff/admin command reference with required ranks (shown in game via `/admincmds`, staff only).
- [`server/rules/staff.md`](server/rules/staff.md) — staff conduct rules.
- [`server/changelogs/`](server/changelogs/) — server and client changelogs (viewable in game via `/changes`).

---

*Music credits: Kevin MacLeod, MaxKoMusic, LenaOrsa, zero‑project, and yammlex. Pack creator
tool © HarryMK (MIT).*
