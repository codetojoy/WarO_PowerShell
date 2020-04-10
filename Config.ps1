<#
TODO: Find a code style/format so that this is idiomatic
      From what I can tell, functions have a different style than formal Cmdlets
#>

$here = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
. "$here\Player.ps1"

function buildConfigFromJson ([string] $jsonStr) {
    $json = ConvertFrom-Json $jsonStr
    $numCards = $json.numCards
    $players = @()
    foreach ($jsonPlayer in $json.players) {
        $name = $jsonPlayer.name
        $strategy = $jsonPlayer.strategy
        $player = buildPlayer $name $strategy
        $players += $player
    }

    $result = [System.Tuple]::Create($numCards, $players)
    $result
}

function buildConfig ([string] $configJsonPath) {
    $jsonStr = (Get-Content $configJsonPath | Out-String)
    $result = buildConfigFromJson $jsonStr
    $result
}
