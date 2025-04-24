---@class WezTerm
local wezterm = require "wezterm"

local icons = require "utils.icons" ---@class Icons
local fun = require "utils.fun" ---@class Fun

---@class Config
local Config = {}

-- Auto reloading gives problems when generating modules and also does not reload colors properly
Config.automatically_reload_config = false

-- if fun.is_windows then
  Config.allow_win32_input_mode = true
  -- Config.debug_key_events = true
  Config.window_close_confirmation = 'AlwaysPrompt'
  Config.skip_close_confirmation_for_processes_named = {
    "bash.exe",
    "elvish.exe",
    "nu.exe",
    "cmd.exe",
    "pwsh.exe",
    "powershell.exe",
    "broot.exe",
  }
  Config.clean_exit_codes = { 130 }
  Config.exit_behavior_messaging = "Verbose"
  Config.exit_behavior = "CloseOnCleanExit"

  Config.default_prog = { 'elvish' }

  Config.launch_menu = {
    { label = "Nu", args = { "nu" }, cwd = "~" },
    { label = "Elvish", args = { "elvish" }, cwd = "~" },
    {
      label = icons.Pwsh .. " PowerShell V7",
      args = {
        "pwsh",
        "-NoLogo",
        "-ExecutionPolicy",
        "RemoteSigned",
        "-NoProfileLoadTime",
      },
      cwd = "~",
    },
    { label = icons.Pwsh .. " PowerShell V5", args = { "powershell" }, cwd = "~" },
    { label = "Command Prompt", args = { "cmd.exe" }, cwd = "~" },
    { label = icons.Git .. " Git bash", args = { "sh", "-l" }, cwd = "~" },
  }

  -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
  Config.wsl_domains = {
    {
      name = "WSL:Ubuntu",
      distribution = "Ubuntu",
      username = "sravioli",
      default_cwd = "/home/sRavioli",
      default_prog = { "bash" },
    },
    {
      name = "WSL:Alpine",
      distribution = "Alpine",
      username = "sravioli",
      default_cwd = "/home/sravioli",
    },
  }
-- end

Config.default_cwd = fun.home

-- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
Config.ssh_domains = {}

-- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
Config.unix_domains = {}

return Config

