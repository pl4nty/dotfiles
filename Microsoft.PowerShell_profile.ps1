[Console]::OutputEncoding = [Text.Encoding]::UTF8
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/lightgreen.omp.json" | Invoke-Expression

Import-Module PSReadLine

function ?? {
  gh copilot suggest --target shell ('use powershell to ' + $args)
}

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

function Add-AutopilotToVM {
  [CmdletBinding()]
  param(
    [parameter(ValueFromPipeline,Mandatory)][Microsoft.HyperV.PowerShell.VirtualMachine]$VM,
    [parameter(Mandatory)][string]$Tenant
  )
  begin {
    $oidc = Invoke-RestMethod https://login.microsoftonline.com/$Tenant/.well-known/openid-configuration
    $file = New-TemporaryFile
    @{
      # Version=2049
      CloudAssignedTenantId=$oidc.authorization_endpoint -replace "https://login.microsoftonline.com/([^/]+).+", '$1'
      CloudAssignedTenantDomain=$Tenant
      CloudAssignedOobeConfig=28
      CloudAssignedDomainJoinMethod=0
      CloudAssignedForcedEnrollment=1
      ZtdCorrelationId=(New-Guid).Guid
      CloudAssignedAadServerData="{`"ZeroTouchConfig`":{`"CloudAssignedTenantUpn`":`"`",`"CloudAssignedTenantDomain`":`"$Tenant`"}}"
      # CloudAssignedDeviceName
      Comment_File="Manual Profile"
    } | ConvertTo-Json | Set-Content $file
  }
  process {
    $_ | Enable-VMIntegrationService -Name "Guest Service Interface" # Copy-VMFile dependency
    $_ | Enable-VMTPM -PassThru | Copy-VMFile -FileSource Host -Force -SourcePath $file -DestinationPath "C:\Windows\Provisioning\Autopilot\AutopilotConfigurationFile.json"
  }
  end {
    Remove-Item $file
  }
}

function Tail ($Log = "Application", $Pastmins = 5) {
  $lastdate = $(Get-Date).AddMinutes(-$Pastmins)
  while ($True) {
    $newdate = Get-Date
    Get-WinEvent $Log -ea 0 | where TimeCreated -ge $lastdate -and TimeCreated -le $newdate | Sort-Object TimeCreated
    $lastdate = $newdate
    Start-Sleep -Milliseconds 330
  }
}
