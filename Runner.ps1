<#
TODO: Find a code style/format so that this is idiomatic
      From what I can tell, functions have a different style than formal Cmdlets
#>

param([string]$configPath = "config.json")

$here = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
. "$here\Game.ps1"
. "$here\Player.ps1"
. "$here\Strategy.ps1"
. "$here\Config.ps1"

# ------- main

$config = buildConfig $configPath
$numCards = $config.Item1
# consider the kitty as a player
$players = $config.Item2
$numPlayers = $players.Count
$handSize = $numCards / ($numPlayers + 1)
Write-Host "TRACER handSize: " $handSize

# deal cards into hands
$deck = getDeck $numCards
$shuffledDeck = shuffleDeck $deck
$hands = dealDeck $shuffledDeck $handSize

# assign hand to kitty
$kitty = $hands[0].Group
Write-Host "TRACER kitty handSize: " $kitty.Count
$playerHandIndex = 1

# assign hands to players
foreach ($player in $players) {
    assignHand $player $hands[$playerHandIndex].Group
    $playerHandIndex += 1
}

# play game
playGame $kitty $players
