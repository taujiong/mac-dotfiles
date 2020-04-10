Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

#region PSReadLine
$CustomPSReadLineOptions = @{
  Colors = @{
    "Command"    = [System.ConsoleColor]::DarkYellow
    "Comment"    = [System.ConsoleColor]::Green
    "Emphasis"   = [System.ConsoleColor]::DarkGreen
    "Keyword"    = [System.ConsoleColor]::DarkGreen
    "Operator"   = [System.ConsoleColor]::White
    "Parameter"  = [System.ConsoleColor]::White
    "Variable"   = [System.ConsoleColor]::DarkMagenta
    "Selection"  = [System.ConsoleColor]::DarkGreen
    "Prediction" = [System.ConsoleColor]::DarkGreen
  }
}
Set-PSReadLineOption @CustomPSReadLineOptions
#endregion

Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Powerlevel10k
Import-Module ZLocation
