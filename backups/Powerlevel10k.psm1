#requires -Version 2 -Modules posh-git

function Write-Theme {
  param(
    [bool]
    $lastCommandFailed,
    [string]
    $with
  )

  # Base settings
  $sl = $global:ThemeSettings #local settings
  $sl.Options.OriginSymbols = $true
  $sl.GitSymbols.OriginSymbols["Github"] = "$([char]::ConvertFromUtf32(0xf113)) "   # 
  $sl.PromptSymbols.SegmentForwardSymbol = [char]::ConvertFromUtf32(0xE0B0)         # 
  $sl.PromptSymbols.SegmentBackwardSymbol = [char]::ConvertFromUtf32(0xE0B2)        # 

  #################### Os ####################
  if ($PSVersionTable.Platform -ne 'Unix') {
    # suppose it to be Windows
    $sl.PromptSymbols.StartSymbol = [char]::ConvertFromUtf32(0xe70f)      # 
  }
  else {
    $os = $(uname)
    switch ($os) {
      "Darwin" { 
        $sl.PromptSymbols.StartSymbol = [char]::ConvertFromUtf32(0xe711)  # 
      }
      # TODO: 加入更多Linux系统
      Default { 
        $sl.PromptSymbols.StartSymbol = [char]::ConvertFromUtf32(0xe712)  # 
      }
    }
  }

  $Os = " $($sl.PromptSymbols.StartSymbol) "
  $sl.Colors.OsForegroundColor = [ConsoleColor]::Black
  $sl.Colors.OsBackgroundColor = [ConsoleColor]::Gray

  #################### Path ####################
  $sl.PromptSymbols.PathHomeSymbol = [char]::ConvertFromUtf32(0xf015)   # 
  $sl.PromptSymbols.PathSymbol = [char]::ConvertFromUtf32(0xf07c)       # 
  $pathSymbol = if ($pwd.Path -eq $HOME) { $sl.PromptSymbols.PathHomeSymbol } else { $sl.PromptSymbols.PathSymbol }

  $path = " $($pathSymbol) " + " $(Get-FullPath -dir $pwd) "
  $sl.Colors.PathForegroundColor = [ConsoleColor]::White
  $sl.Colors.PathBackgroundColor = [ConsoleColor]::DarkBlue

  #################### Git ####################
  if (Get-VCSStatus) {
    $gitInfo = Get-VcsInfo -status ($gitStatus)

    $gitStatus = " $($gitInfo.VcInfo) "
    $sl.Colors.GitForegroundColor = [ConsoleColor]::Black
    $sl.Colors.GitBackgroundColor = $gitInfo.BackgroundColor
  }

  #################### Last command status ####################
  $pass = [char]::ConvertFromUtf32(0xf00c)    # 
  $err = [char]::ConvertFromUtf32(0xf00d)     # 
  $sl.PromptSymbols.LastCommandStatusSymbol = If ($lastCommandFailed) { $err } Else { $pass }

  $lastCommandStatus = " $($sl.PromptSymbols.LastCommandStatusSymbol) "
  $sl.Colors.LastCommandStatusForegroundColor = If ($lastCommandFailed) { [ConsoleColor]::DarkRed } Else { [ConsoleColor]::DarkGreen }
  $sl.Colors.LastCommandStatusBackgroundColor = [ConsoleColor]::Green
  
  #################### Python Env ####################
  if (Test-VirtualEnv) {
    $pythonEnv = " $(Get-VirtualEnvName) $($sl.PromptSymbols.VirtualEnvSymbol) "
    $sl.Colors.VirtualEnvForegroundColor = [ConsoleColor]::Black
    $sl.Colors.VirtualEnvBackgroundColor = [System.ConsoleColor]::DarkBlue
  }

  #################### Timestamp ####################
  $sl.PromptSymbols.ClockSymbol = [char]::ConvertFromUtf32(0xf64f)  #  

  $time = " $(Get-Date -Format HH:mm) $($sl.PromptSymbols.ClockSymbol) "
  $sl.Colors.TimestampForegroundColor = [ConsoleColor]::Black
  $sl.Colors.TimestampBackgroundColor = [ConsoleColor]::White

  #################### Write Prompt ####################
  $prompt += Write-Prompt -Object "╭─"
  # Os
  $prompt += Write-Prompt -Object $Os -ForegroundColor $sl.Colors.OsForegroundColor-BackgroundColor $sl.Colors.OsBackgroundColor
  # Connection
  $prompt += Write-Prompt -Object $sl.PromptSymbols.SegmentForwardSymbol -ForegroundColor $sl.Colors.OsBackgroundColor -BackgroundColor $sl.Colors.PathBackgroundColor
  # Path
  $prompt += Write-Prompt -Object $path -ForegroundColor $sl.Colors.PathForegroundColor -BackgroundColor $sl.Colors.PathBackgroundColor
  # Connection
  $prompt += Write-Prompt -Object $sl.PromptSymbols.SegmentForwardSymbol -ForegroundColor $sl.Colors.PathBackgroundColor -BackgroundColor $sl.Colors.GitBackgroundColor
  # Git
  if (Get-VCSStatus) {
    $prompt += Write-Prompt -Object $gitStatus -ForegroundColor $sl.Colors.GitForegroundColor -BackgroundColor $sl.Colors.GitBackgroundColor

    $prompt += Write-Prompt -Object $sl.PromptSymbols.SegmentForwardSymbol -ForegroundColor $sl.Colors.GitBackgroundColor
  }

  # Switch to right part
  $rightElements = ($sl.PromptSymbols.SegmentBackwardSymbol, $lastCommandStatus, $sl.PromptSymbols.SegmentBackwardSymbol, $pythonEnv, $sl.PromptSymbols.SegmentBackwardSymbol, $time, "─╮")
  foreach ($indicatior in $rightElements) {
    $total += $indicatior.Length
  }
  $prompt += Set-CursorForRightBlockWrite -textLength $total
  # Connection
  $prompt += Write-Prompt -Object $sl.PromptSymbols.SegmentBackwardSymbol -ForegroundColor $sl.Colors.LastCommandStatusBackgroundColor
  # Last command status
  $prompt += Write-Prompt -Object $lastCommandStatus -ForegroundColor $sl.Colors.LastCommandStatusForegroundColor -BackgroundColor $sl.Colors.LastCommandStatusBackgroundColor
  # Connection
  $prompt += Write-Prompt -Object $sl.PromptSymbols.SegmentBackwardSymbol -ForegroundColor $sl.Colors.VirtualEnvBackgroundColor -BackgroundColor $sl.Colors.LastCommandStatusBackgroundColor
  # Virtual env
  $prompt += Write-Prompt -Object $pythonEnv -ForegroundColor $sl.Colors.VirtualEnvForegroundColor -BackgroundColor $sl.Colors.VirtualEnvBackgroundColor
  # Connection
  $prompt += Write-Prompt -Object $sl.PromptSymbols.SegmentBackwardSymbol -ForegroundColor $sl.Colors.TimestampBackgroundColor -BackgroundColor $sl.Colors.VirtualEnvBackgroundColor
  # Time
  $prompt += Write-Prompt -Object $time -ForegroundColor $sl.Colors.TimestampForegroundColor -BackgroundColor $sl.Colors.TimestampBackgroundColor
  $prompt += Write-Prompt -Object "─╮"

  # Switch to next line
  $prompt += Write-Prompt -Object "`r"
  $prompt += Set-Newline
  # Switch to right part
  $prompt += Set-CursorForRightBlockWrite -textLength 2
  $prompt += Write-Prompt -Object "─╯"
  # Switch to left part
  $prompt += Write-Prompt -Object "`r"
  $prompt += Write-Prompt -Object "╰─ "
  $prompt
}
