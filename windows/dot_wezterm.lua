local wezterm = require("wezterm")
local config = wezterm.config_builder()

local unalias_script = [[
  $utils = @('ls','cat','chmod','cp','cut','date','echo','env','id','ln','mkdir','mv','pwd','rm','rmdir','sleep','sort','tail','tee','touch','uname','uniq','wc');
  foreach ($u in $utils) { if (Get-Alias $u -EA SilentlyContinue) { Remove-Item "alias:\$u" -Force } }
]]

local safe_msvc_script = [[
  try {
      $vsModule = 'C:\Program Files\Microsoft Visual Studio\18\Community\Common7\Tools\Microsoft.VisualStudio.DevShell.dll'
      if (Test-Path $vsModule) {
          Import-Module $vsModule -ErrorAction Stop
          Enter-VsDevShell -VsInstallPath 'C:\Program Files\Microsoft Visual Studio\18\Community' -Arch x64 -ErrorAction Stop
          Write-Host "[WezTerm] MSVC DevShell successfully loaded." -ForegroundColor Green
      } else {
          Write-Warning "[WezTerm] MSVC DevShell dll not found. Skipping MSVC setup."
      }
  } catch {
      Write-Warning "[WezTerm] Failed to initialize MSVC DevShell. Error: $_"
  }
]]

config.default_prog = {
    "powershell.exe",
    "-NoExit",
    "-Command",
    -- Menggunakan string baru (\n) saat menggabungkan agar syntax PowerShell tidak rusak
    safe_msvc_script .. "\n" .. unalias_script,
}

config.default_cwd = wezterm.home_dir

return config
