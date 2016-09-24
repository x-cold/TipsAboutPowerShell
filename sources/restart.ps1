param($Step="A")


#'!!! Important: UAC must be closed before execution!!!'
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
	$arguments = "& '" + $myinvocation.mycommand.definition + "'"+  " -Step $Step"
	Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $arguments
	break
}


$script = $myInvocation.MyCommand.Definition
$scriptPath = Split-Path -parent $script
. (Join-Path $scriptpath RestartFunctions.ps1)


Clear-Any-Restart

if (Should-Run-Step "A") 
{
    'Close UAC...' #Only run once, and will take effect after restart
    New-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -PropertyType DWord -Value 0 -Force
	
    Write-Host "Write-Host A"
	Restart-And-Resume $script "B"
}

if (Should-Run-Step "B") 
{
	Write-Host "Write-Host B"
	Restart-And-Resume $script "C"
}

if (Should-Run-Step "C") 
{
	Write-Host "Write-Host C"
}

Wait-For-Keypress "Test script Complete, press any key to exit script..."
