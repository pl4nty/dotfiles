# workaround for broken UTF-8 support in WDAC audit mode
[Console]::OutputEncoding = [Text.Encoding]::UTF8

oh-my-posh init pwsh --config $env:POSH_THEMES_PATH/lightgreen.omp.json | Invoke-Expression

Import-Module PSReadLine

$null = Register-EngineEvent -SourceIdentifier 'PowerShell.OnIdle' -MaxTriggerCount 1 -Action {
  Import-Module -Name UsefulArgumentCompleters -Global
  Import-UsefulArgumentCompleterSet -OptionalCompleter Hyperv

  Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
    $Local:word = $wordToComplete.Replace('"', '""')
    $Local:ast = $commandAst.ToString().Replace('"', '""')
    winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
      [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
  }
}

komac autocomplete powershell | out-string | iex
