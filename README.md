# iterm-dot

一套偏實用的 iTerm2 + SSH + tmux 設定。

用途是把另一台 Mac 當成固定工作機，讓 iTerm2 一次開出 `work1` 到 `work6` 六個 profile，每個 tab 自動：

- SSH 到 `workmac`
- attach 對應的 tmux session
- 用不同 tab 顏色區分
- tab title 直接顯示 profile name

這個 repo 刻意不走 AppleScript 強制改 tab title。那條路在不同 iTerm2 版本上不穩，最後保留的是比較穩的 dynamic profile 方案。

## 結構

- `bin/iterm-workmac-session`
  本機啟動腳本，會 SSH 到 `workmac` 並 attach 指定 tmux session
- `iTerm2/DynamicProfiles/workmac-profiles.json`
  定義 `work1` 到 `work6` 六個 iTerm2 dynamic profiles
- `ssh/config.example`
  `~/.ssh/config` 的範例設定
- `install.sh`
  安裝腳本，會把上述檔案裝到正確位置

## 行為

- `work1` 連到 remote tmux session `work`
- `work2` 連到 remote tmux session `work2`
- `work3` 連到 remote tmux session `work3`
- `work4` 連到 remote tmux session `work4`
- `work5` 連到 remote tmux session `work5`
- `work6` 連到 remote tmux session `work6`
- 如果該 tmux session 不存在，不會自動建立，只會停在遠端 login shell

## 安裝

直接在 repo 目錄執行：

```bash
./install.sh
```

預設安裝內容：

- `~/bin/iterm-workmac-session`
- `~/Library/Application Support/iTerm2/DynamicProfiles/workmac-profiles.json`
- `~/.ssh/config` 補上 `Host workmac` 範例區塊

執行完後：

1. 視需要修改 `~/.ssh/config` 裡的 `HostName` / `User`
2. 確認你已經能用 SSH key 登入 `workmac`
3. 重開 iTerm2
4. 在 iTerm2 的 profile/title 設定裡，讓 tab title 顯示 `Profile Name`

## 使用

重開 iTerm2 後，你應該會看到六個 dynamic profiles：

- `work1`
- `work2`
- `work3`
- `work4`
- `work5`
- `work6`

你可以：

- 分別打開它們
- 或在 iTerm2 內用 `Profiles > Open All`
- 或自己再存成 Window Arrangement

## 遠端需求

remote 端需要：

- `tmux`
- 有對應 session，例如 `work`, `work2`, `work3`, `work4`, `work5`, `work6`

可先在 remote 檢查：

```bash
tmux ls
```

## 客製

如果你要改 remote 主機，調整：

- `~/.ssh/config` 的 `Host workmac`

如果你要改 tab 顏色，調整：

- `bin/iterm-workmac-session` 裡不同 session 的 RGB 值

如果你要增加 profile 數量，調整：

- `iTerm2/DynamicProfiles/workmac-profiles.json`

## 設計取捨

- tab 名稱靠 iTerm2 dynamic profile name，不靠 terminal title hack
- session 不存在時不自動建立，避免誤開空白 tmux session
- SSH host alias 統一叫 `workmac`，讓本機腳本保持簡單
