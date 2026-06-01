# Staff & Administrative Commands

The following commands require a staff rank. They are defined and rank-gated in
`server/includes/commands.nvgt`; the staff/role system itself is described in the project
`README.md`.

This reference is staff-only. View it in game with `/admincmds`. (Regular players see only the
player commands in `commands.md`, shown with `/cmds`.)

**Ranks**, from highest to lowest authority: **Developer**, **Manager**, **Admin**,
**Assistant**. Higher ranks inherit every ability of the ranks below them. A separate
**Language Channel Manager (LCM)** sub-role governs a single language channel.

In the tables below, the **Rank** column is the *minimum* rank required. For example, **Admin**
means admins, managers, and developers can all use that command.

> ⚠️ A few commands have **no explicit rank check** in the code and are intended for
> developer/internal use only. They are marked **internal⚠** in the Rank column. Treat them as
> developer-only and use with caution.

Arguments in `[brackets]` are optional. Targets are character (login) names unless noted.

## Moderation & punishment

| Command | Rank | Description |
| --- | --- | --- |
| `/kick <name>` | Assistant | Kick a player. Cannot kick higher-ranked staff. |
| `/kickall` | Developer | Kick every online player. |
| `/ckick <name>` | LCM / Admin | Kick a player out of your current language channel. |
| `/jail <name> <seconds> <reason>` | Assistant | Send a player to the jail map; stores their position and inventory. |
| `/unjail <name>` | Assistant | Release a player from jail and restore their position and inventory. |
| `/jaillist` | Assistant | List jailed players (by computer ID). |
| `/jailtime` | Everyone | Show your own remaining jail time. |
| `/warn <name> <message>` | Assistant | Issue a warning to a player (max 5). |
| `/blockfeature <name> <feature>` | Assistant | Disable a game feature for a player (cannot target a developer). |
| `/unblockfeature <name> <feature>` | Assistant | Re-enable a previously blocked feature. |
| `/ban <name> [reason\|<text>] [minute\|<n>] [compid\|<0\|1>]` | Manager | Ban a player's computer (product ID). Pipe-delimited options. Cannot ban higher staff. |
| `/unban <name>` | Manager | Remove a ban. |
| `/banned` | Manager | List all banned users. |
| `/banid <name>` | Manager | Show the ban ID associated with a player. |
| `/banguide` | Manager | Show the built-in ban-system help text. |
| `/temporary_ban <name> <minutes>` | Manager | Kick and ban a player for a set time. |
| `/temporary_bans` | Manager | List active temporary bans and time remaining. |
| `/mv <name>` | Assistant | Move a stuck player to safety on the main map. |
| `/sleep <name> [message]` | Admin | Force a player to sleep. |
| `/wake <name> [message]` | Admin | Wake a sleeping player. |
| `/hideme` | Admin | Become hidden (applies on your next login). |
| `/unhideme` | Admin | Stop being hidden (applies on your next login). |
| `/closeclient <name>` | internal⚠ | Force a player's client to close. |
| `/closeclientall` | internal⚠ | Force all clients to close. |

## Player stats & character data

| Command | Rank | Description |
| --- | --- | --- |
| `/sethealth <name> <value>` | Manager | Set a player's health. |
| `/setlevel <name> <value>` | Manager | Set a player's level. |
| `/setreinforcement <name> <value>` | Manager | Set a player's reinforcement. |
| `/setxp <name> <value>` | Manager | Set a player's XP. |
| `/setenergy <name> <value>` | Admin | Set a player's energy. |
| `/setfull <name> <value>` | Admin | Set both hunger and thirst "full" values. |
| `/sethunger <name> <value>` | Manager | Set a player's hunger. |
| `/setthirst <name> <value>` | Manager | Set a player's thirst. |
| `/seturine <name> <value>` | Manager | Set a player's urine (bladder) value. |
| `/setfeces <name> <value>` | Manager | Set a player's feces (bowel) value. |
| `/setsick <name> <value>` | Manager | Set a player's sickness. |
| `/setgender <name> <0\|1>` | Admin | Set a player's gender (0 = he, 1 = she). |
| `/setstatus <name> <message>` | Admin | Set another player's status message. |
| `/settitle <name> <title>` | Admin | Set a player's title. |
| `/cleartitle <name>` | Admin | Clear a player's title. |
| `/resetwalktime <name>` | Manager | Reset a player's walk timer. |
| `/restaure` | Manager | Restore your own stats (full health, zero hunger/thirst/dirty/wet). |
| `/safe [name]` | Admin | Toggle safe mode (self, or another player). |
| `/supersafe [name]` | Admin | Toggle super-safe mode. |
| `/fastpvp [name]` | Admin | Instantly toggle PvP without the usual timers. |
| `/pvp [name]` | Everyone | Toggle your own PvP (with confirmation/timers); Admin may target another player. |
| `/tthirst [name]` | Admin | Toggle thirst-timer control. |
| `/thunger [name]` | Admin | Toggle hunger-timer control. |
| `/getinv <name>` | Manager | Return a player's inventory data. |
| `/setinv <name> <invdata>` | Manager | Overwrite a player's inventory. |
| `/seteinv <name> <encrypted-invdata>` | Manager | Overwrite a player's inventory from encrypted data. |
| `/getmyinv` | Everyone | Export your own (encrypted) inventory to a client-side file. |
| `/backupinv` | Admin | Back up every player's inventory to `inv_backups/`. |
| `/getbackupinv <name>` | Admin | Retrieve a backed-up inventory. |
| `/cdata <name> <key>` | Developer | Read a character data value (`inv` and `health` are special-cased). |
| `/cdataset <name> <key> <value>` | Developer | Write a character data value (`lcm`/`admin`/`manager` keys are developer-only). |
| `/dcd <name> <filename>` | internal⚠ | Delete a specific character data file. |
| `/changepass <name> <newpass>` | Manager | Change a player's password (not a developer's, unless you are one). |
| `getpass <name>` | Manager | Reveal a player's password (no leading slash; not for developers). |
| `/changemymap <map>` | Admin | Teleport yourself to a map's spawn point. |

## Items & economy

| Command | Rank | Description |
| --- | --- | --- |
| `/give <name> <item> <amount>` | Manager | Give an item to a player. |
| `/giveall <item> <amount>` | Admin | Give an item to every online player. |
| `/ig <item> <amount> [name...]` | Manager | Give an item to listed characters, or everyone (online and offline). |
| `/ik <item>` | Manager | Remove an item from every inventory (online and offline). |
| `/recieve <item> [amount]` | Everyone | Claim items previously stored under your character. |
| `/addnotadg <item>` | Admin | Add an item to the "not a draw-and-get" list (`notadg.svr`). |
| `/auct <item> <amount> <need> <minbid>` | internal⚠ | Start an auction (no args / ≤4 args shows current auction info). |
| `/bid [amount]` | Everyone | Bid in the current auction (menu shown if several are running). |
| `/abid [amount]` | Everyone | Alternate auction-bid interface. |
| `/currentauction` | Everyone | Show the current auction's info. |
| `/ca [reason]` | Assistant | Cancel a running auction (or all of them). |
| `/guess <number>` | Everyone | Make a guess in the guessing game. |
| `/guess start <min> <max> <item> <amount> [minutes]` | Admin | Start a guessing game. |
| `/guess stop [reason]` / `/guess info` | Admin | Stop / inspect the guessing game. |
| `/vote <yes\|no>` | Everyone | Cast your vote. |
| `/votes` | Admin | Show the vote tally. |
| `/votelist` | Admin | Show who has voted. |
| `/clearvotes` | Manager | Reset all votes. |

## Movement & teleporting

| Command | Rank | Description |
| --- | --- | --- |
| `/move <name> <x> <y> <z> [map]` | Admin | Teleport a player. |
| `/moveplayer <name> <name2>` | Admin | Move a player to another player's location. |
| `/moveall <x> <y> <z> [map]` | Admin | Move all online players. |
| `/moveall_global [x y z]` | Admin | Move all characters, online and offline (random if no coordinates). |
| `/mapmove [map:<m>] [dest:<m>] [name...]` | Admin | Move matched players (by map and/or name) to a destination map. |
| `/changemap <name> <map>` | Admin | Move a player to a map's spawn. |
| `/suicide <name>` | Admin | Send a player back to the main map. |
| `/go <x> <z>` or `/go <x> <y> <z>` | Map owner / Admin | Teleport yourself within your current (2D-enabled) map. |
| `/follow <name>` | Manager | Start following a player. |
| `/stopfollow` | Manager | Stop following. |
| `/look <name>` | Everyone | Spectate a player (requires their trust; Admin bypasses trust). |
| `/lookstop` | Everyone | Stop spectating and return to where you were. |
| `/rescue` | Developer | Clear stuck map data (`map.usr`/`mapavolter.usr`) for all characters. |

## World, objects & AI

| Command | Rank | Description |
| --- | --- | --- |
| `/spawn_obj <x> <y> <z> <map> <item> <amount>` | Manager | Spawn an item object in a map. |
| `/objs` | Developer | Dump counts of all dynamic objects. |
| `/clearobjs` | Developer | Remove orphaned fixtures (washbasins, showers, etc.) on missing maps. |
| `/kill <name> [reason]` | Admin | Set a player's health to zero. |
| `/killrobots` | Admin | Destroy all robots. |
| `/rmove <x> <y> <z> <map>` | Everyone | Move the robot linked to you. |
| `/refreshai` | Admin | Destroy and reload all AI. |
| `/aiinfo` | Admin | List spawned AI and their positions. |
| `/ailist` | Admin | List AI definition files and their sizes. |
| `/minesweeper [count]` | Admin | Spawn random mines (default 250) across your map. |
| `/timebombsweeper [count]` | Admin | Spawn random time bombs (default 250). |
| `/censorbombsweeper [count]` | Admin | Spawn random censor bombs (default 250). |
| `/mineclear` | Admin | Remove all mines. |
| `/turretclear` | Admin | Remove all turrets. |
| `/hsd <owner>` | Admin | Destroy a player's house. |
| `/hsda` | Manager | Destroy all houses. |
| `/asd <owner>` | Admin | Destroy a player's apartment. |
| `/tsd <owner>` | Admin | Destroy a player's tent. |
| `/tsda` | Manager | Destroy all tents. |
| `/weather` | Admin | Open the weather control menu (rain / wind / night). |
| `/nuke <name> [/na]` | Developer | Delete a character (`/na` performs a raw directory delete). |

## Maps

| Command | Rank | Description |
| --- | --- | --- |
| `/maps` | Admin | Menu of all maps; select one to teleport there. |
| `/maplist` | Admin | List all maps with file sizes. |
| `/mapexists <map>` | Admin | Check whether a map exists. |
| `/maplines` | Admin | Count the lines in your current map's file. |
| `/showrawmap` | Admin | Show the raw data of your current map. |
| `/rawmap` | Map owner / Admin | Copy the current map's data to your clipboard. |
| `/rawdata <mapdata>` | Map owner / Admin | Overwrite the current map with validated raw data. |
| `/backupmap` | Admin | Back up all maps to `map_backups/`. |
| `/getbackupmap <map>` | Admin | Copy a backed-up map to your clipboard. |
| `/delmap <map>` | Manager | Delete a map. |
| `/cleanmapowners` | Admin | Remove duplicate owner entries from every map. |
| `/clearplots` | Developer | Destroy **every** house on the server. Marks each house health=0; the normal destruction loop then cleans up house maps, dependent items, and zone markers. Intended for fresh-server setup; broadcasts per-house death messages if players are online. |
| `/maptrash` | Manager | Run a map spam-collection pass. |
| `/initmaps` | Admin | Reboot the map system. |

## XP & events

| Command | Rank | Description |
| --- | --- | --- |
| `/xp` | Everyone | Show XP status. |
| `/xp <double\|super\|mega\|giga\|master\|normal> [duration]` | Admin | Start an XP event of the given mode. |
| `/xp start` / `/xp stop` / `/xp edit` | Admin | Enable / disable / edit the automatic XP schedule. |
| `/newevent <name>` | Manager | Create an event (returns its ID). |
| `/eventset <id> <setting=value>` | Manager | Configure an event before launch. |
| `/launchevent <id>` | Manager | Launch (lock) an event. |
| `/startevent <id>` | Manager | Start a launched event. |
| `/endevent <id>` | Developer | End an event. |
| `/eventinfo <id>` | Everyone | Show an event's details. |
| `/events` | Everyone | List events (managers also see unlaunched events). |
| `/eventhelp` | Manager | Show the event-system help text. |
| `/joinevent <id>` | Everyone | Join an event. |
| `/leaveevent` | Everyone | Leave the event you are in. |

## Messaging & notifications

| Command | Rank | Description |
| --- | --- | --- |
| `/me <action>` | Everyone | Emote/action message (supports message variables). |
| `/pm <name> <message>` | Everyone | Send a private message. |
| `/r <message>` | Everyone | Reply to the last private message you received. |
| `/notify <message>` | Admin | Send a server-wide notification. |
| `/newmotd <message>` | Admin | Set the server message of the day (announced to everyone). |
| `/notifyall <message>` | Manager | Send a game-update message to all characters (offline players get a PM). |
| `/pnotify <sound> <message>` | Manager | Notify everyone with a sound. |
| `/playernotify <name> <sound> <message>` | Manager | Notify one player with a sound. |
| `/lcnotify <channel> <message>` | Manager | Notify a specific language channel. |
| `/cnotify <message>` | LCM | Notify your own language channel. |
| `/chnotify <message>` | LCM | Channel notification for your language channel. |
| `/beep <...>` | Manager | Send a raw beep packet. |
| `/dlg <name> <message>` | Manager | Send a dialog box to a player. |
| `/sendpacket <channel> <data>` | Manager | Send a raw packet to everyone. |
| `/sendpacketplus <channel> <data>` | Manager | Raw packet to everyone except yourself. |
| `/sendpacketplayer <name> <channel> <data>` | Manager | Raw packet to one player. |
| `/sendplayerpacket <name> <channel> <data>` | Manager | Variant of the above. |

## Language channels (LCM)

| Command | Rank | Description |
| --- | --- | --- |
| `/channelusers` | Everyone | List users in your current language channel. |
| `/lcms` | Everyone | List all language channel managers. |
| `/cpass` | Channel owner | Show your channel's password. |
| `/newlmotd <message>` | Admin / LCM | Set the language channel's message of the day. |
| `/mlmgr <name>` | Admin | Promote or demote a player as a language channel manager. |

## Teams (staff)

These are the staff-facing team commands; everyday team commands are in the player reference
(`commands.md`, shown in game with `/cmds`).

| Command | Rank | Description |
| --- | --- | --- |
| `/teaminfo [team]` | Leader/Mod (Admin: any team) | Show team details including its password. |
| `/setteampoints <team> <value>` | Admin | Set a team's points. |
| `/setteamkills <team> <value>` | Admin | Set a team's kills. |
| `/team <name>` | Admin | Show which team a player belongs to. |
| `/teamreset <name>` | Admin | Remove a player from their team. |
| `/teamdestroy <team>` | Manager | Delete a team. |
| `/teamdestroyold` | Developer | Delete all empty teams. |
| `/changeteamleader <team> <name>` | Admin | Force-assign a team's leader. |
| `/teammerge <dest> <src>` | Manager | Merge one team into another. |
| `/teamnickname <name>` | Leader/Mod | Rename your team's display name. |
| `/backupteam [rm] [rec]` | Admin | Back up team files (`rm` wipes backups first, `rec` recovers unloaded teams). |

## Server control & maintenance

| Command | Rank | Description |
| --- | --- | --- |
| `/shutdown [reason]` | Admin | Shut the server down. |
| `/shutdowntime [seconds] [reason]` | Admin | Schedule a shutdown. |
| `/reboot [reason]` | Admin | Reboot the server. |
| `/reboottime [seconds] [reason]` | Admin | Schedule a reboot. |
| `/gamestop` | Admin | Freeze the game (stop all movement). |
| `/gamestart` | Admin | Unfreeze the game. |
| `/datasave` | Manager | Force-save server data. |
| `/garbage_collect` | Assistant | Clear weapons/objects/robots to reduce lag. |
| `/varset <var> [value]` | Manager | View or set a server variable (e.g. `chatting`). |
| `/varremove <var>` | Manager | Delete a server variable. |
| `/ps <sound>` | Manager | Play a sound to everyone. |
| `/play <file> <x> <y> <z> <map>` | Developer | Play a positioned sound on a map. |
| `/maptrash` | Manager | Collect map spam. |
| `/chartrash` | Assistant | Collect spam characters. |

## Logs, notes & diagnostics

| Command | Rank | Description |
| --- | --- | --- |
| `/adminlog` | Admin | Browse admin-log entries and copy one to the clipboard. |
| `/addalog <message>` | Manager | Add an entry to the admin log. |
| `/anote` | Manager | Show the current admin note. |
| `/addanote <message>` | Manager | Update the admin note. |
| `/admintells` | Assistant | Copy the admin-tell history to the clipboard. |
| `/respond <name> <message>` | Assistant | Reply to a player's staff question. |
| `/feedbacks` | Admin | Manage submitted feedback. |
| `/listlogs` | Manager | Copy the list of log files to the clipboard. |
| `/getlog <path>` | Manager | Copy a log file's contents to the clipboard. |
| `/cld` | Manager | Clear all logs. |
| `/compcharslog` | Developer | Copy `compchars.log` to the clipboard. |
| `/profile [reset]` | Developer | Generate a server profiling report. |
| `/stopprofile` | Developer | Stop profiling and dump `profile.log`. |
| `/last_runtime` | Developer | Show the last recorded runtime. |
| `/intmaps` | Developer | List the maps currently loaded in memory. |
| `/objs` | Developer | Dump dynamic-object counts (also listed above). |
| `/debug_stores` | Developer | Compare player-store counts in memory vs. on disk. |
| `/ip <name>` | Manager | Show a player's IP address. |
| `/ping <name...>` / `/ping all` | Admin | Show round-trip ping(s). |
| `/compid <name>` | Developer | Show a player's computer ID. |
| `/compinfo <name>` | Developer | Show a player's computer information. |
| `/chars` | Assistant | Browse all characters with last-seen times. |
| `/nickfind <nick>` | Everyone | Find online players by nickname. |
| `/pvplist` | Everyone | List players who are currently PvP. |
| `/zones` | internal⚠ | Debug: send the `zones` packet. |

## Miscellaneous

| Command | Rank | Description |
| --- | --- | --- |
| `/admincmds` | Assistant | Show this staff command reference. |
| `/staff` | Everyone | Open the staff menu. |
| `/newstaff <name> <role>` | Manager | Promote a player to a staff role (cannot exceed your own rank). |
| `/delstaff <name> <role>` | Manager | Remove a staff role from a player. |
| `/staffr` | Manager | Reload `staff.json`. |
| `/adminrules` | Assistant | View the staff rules. |
| `/rules` | Everyone | View the game rules. |
| `/feedback [message]` | Everyone | Open the feedback menu, or submit feedback directly. |
| `/afk [title]` | Everyone | Toggle AFK status. |
| `/rq` | Everyone | Rage quit (only while sleeping and not in PvP). |
| `/chat <message>` | Everyone | Chat while hidden (for hidden staff). |
| `/newbie` | Everyone | Turn off your newbie flag (newbies only). |
| `/setemail <email>` | Everyone | Set your account email. |
| `/sendemail <to> [from] [name] [subject] [message]` | Manager | Send an account email (delivery currently disabled in code). |
| `/divorce <name>` | Developer | Force a divorce between a player and their partner. |
