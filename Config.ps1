<#
TODO: Find a code style/format so that this is idiomatic
      From what I can tell, functions have a different style than formal Cmdlets
#>

$here = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
. "$here\Player.ps1"

function buildConfig ([string] $configJsonPath) {
    $json = (Get-Content $configJsonPath | Out-String | ConvertFrom-Json)
    $numCards = $json.numCards
    $players = @()
    foreach ($jsonPlayer in $json.players) {
        $name = $jsonPlayer.name
        $strategy = $jsonPlayer.strategy
        $player = buildPlayer2 $name $strategy
        $players += $player
    }

    $result = [System.Tuple]::Create($numCards, $players)
    $result
}

# ----------------- main

$configJsonPath = "./config.json"
$result = buildConfig $configJsonPath
Write-Host "TRACER numCards: " $result.Item1
Write-Host "TRACER num players: " $result.Item2.Count
