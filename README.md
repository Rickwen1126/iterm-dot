# iterm-dot

Minimal iTerm2 + SSH + tmux setup for opening fixed remote work sessions on another Mac.

## What this repo contains

- `ssh/config.example`
  Example SSH host alias for `workmac`
- `bin/iterm-workmac-session`
  Connects to `workmac` and attaches a named tmux session if it exists
- `iTerm2/DynamicProfiles/workmac-profiles.json`
  Six iTerm2 dynamic profiles: `work1` through `work6`

## Behavior

- Each iTerm2 profile opens one tab
- Each tab SSHes to `workmac`
- Each tab tries to attach a tmux session:
  - `work1` -> `work`
  - `work2` -> `work2`
  - `work3` -> `work3`
  - `work4` -> `work4`
  - `work5` -> `work5`
  - `work6` -> `work6`
- If the tmux session does not exist, it drops into a remote login shell
- It does not auto-create tmux sessions

## Install

1. Copy `ssh/config.example` into your `~/.ssh/config` and adjust host/user/IP.
2. Copy `bin/iterm-workmac-session` to `~/bin/iterm-workmac-session`.
3. Copy `iTerm2/DynamicProfiles/workmac-profiles.json` to:

```text
~/Library/Application Support/iTerm2/DynamicProfiles/workmac-profiles.json
```

4. Restart iTerm2.
5. In iTerm2 profile settings, set tab title display to `Profile Name`.

## Notes

- This setup uses iTerm2 tab color escape codes, not AppleScript tab-title hacks.
- Dynamic profile names are the stable way to keep tab titles as `work1` to `work6`.
