local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Define the coreutils we want to unalias so Scoop takes over
local unalias_script = [[
  $utils = @('ls','cat','chmod','cp','cut','date','echo','env','id','ln','mkdir','mv','pwd','rm','rmdir','sleep','sort','tail','tee','touch','uname','uniq','wc');
  foreach ($u in $utils) { if (Get-Alias $u -EA SilentlyContinue) { Remove-Item "alias:\$u" -Force } }
]]

config.default_prog = {
	"powershell.exe",
	"-NoExit",
	"-Command",
	-- 1. Load VS Developer Shell
	"Import-Module 'C:\\Program Files\\Microsoft Visual Studio\\18\\Community\\Common7\\Tools\\Microsoft.VisualStudio.DevShell.dll'; "
		.. "Enter-VsDevShell -VsInstallPath 'C:\\Program Files\\Microsoft Visual Studio\\18\\Community' -Arch x64; "
		-- 2. Run the unalias script inline
		.. unalias_script,
}
config.font = wezterm.font("SFMono Nerd Font", { weight = "Regular", italic = false })

config.default_cwd = wezterm.home_dir

return config
