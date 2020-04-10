
<#
TODO: Find a code style/format so that this is idiomatic
      From what I can tell, functions have a different style than formal Cmdlets
#>
# https://github.com/PoshCode/PowerShellPracticeAndStyle/blob/master/Style-Guide/Code-Layout-and-Formatting.md

$here = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
. "$here\Strategy.ps1"

function getDeck ([int] $numCards) {
    1..$numCards
}

function shuffleDeck ([int[]] $deck) {
    [int[]] ($deck | Sort-Object {Get-Random})
}

# https://stackoverflow.com/a/26850233/12704

function dealDeck ([int[]] $deck, [int] $handSize) {
    $counter = [pscustomobject] @{ Value = 0 }

    $groups = $deck | Group-Object -Property { [math]::Floor($counter.Value++ / $handSize) }
    $groups
}

function playGame ([int []] $kitty, $players) {
    foreach ($prizeCard in $kitty) {
        playRound $prizeCard $players
    }

    $winningPlayer = findWinner $players

    Write-Host "Winner: "
    logPlayer $winningPlayer
}

function playRound ([int] $prizeCard, $players) {
    Write-Host "`n`n----------------"
    Write-Host "TRACER prizeCard: ${prizeCard}"

    $winningBid = -1
    $winningPlayer = $null

    foreach ($player in $players) {
        $bid = playerTakesTurn $player $prizeCard

        if ($bid -gt $winningBid) {
            $winningBid = $bid
            $winningPlayer = $player
        }
    }

    playerWins $winningPlayer $prizeCard

    Write-Host "TRACER winner: " $winningPlayer.Name " with bid: " $winningBid
}

# ------  main

<#
$deck = Get-Deck 20
Write-Host "TRACER deck : " + $deck
$deck = Shuffle-Deck $deck
$hands = Deal-Deck $deck 5
Write-Host "TRACER x : " + $hands.Count
Write-Host "TRACER y : " + $hands[0].Group
#>
