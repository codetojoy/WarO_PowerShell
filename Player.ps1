<#
TODO: Find a code style/format so that this is idiomatic
      From what I can tell, functions have a different style than formal Cmdlets
#>

function buildPlayer ([string] $name, [int[]] $hand, [string] $strategy) {
    $player = @{}
    $player.Name = $name
    $player.Hand = $hand
    $player.Strategy = $strategy
    $player.NumPointsThisGame = 0
    $player.NumRoundsWon = 0
    $player
}

function buildPlayer2 ([string] $name, [string] $strategy) {
    $player = buildPlayer $name $null $strategy
    $player
}

function assignHand ([hashtable] $player, [int[]] $hand) {
    $player.Hand = $hand
}

function logPlayer ([hashtable] $p) {
    $points = $p.NumPointsThisGame
    $rounds = $p.NumRoundsWon
    Write-Host "TRACER " $p.Name " Hand: " $p.Hand " # pts: " $points " # rds: " $rounds
}

function playerTakesTurn ([hashtable] $player, [int] $prizeCard) {
    logPlayer $player
    $play = applyStrategy $player.Strategy $player.Hand $prizeCard
    $bid = $play.Item1
    $player.Hand = $play.Item2
    $bid
}

function playerWins ([hashtable] $player, [int] $prizeCard) {
    $player.NumPointsThisGame += $prizeCard
    $player.NumRoundsWon += 1
}

function findWinner ($players) {
    $winner = $null
    $maxPoints = -1

    foreach ($player in $players) {
        if ($player.NumPointsThisGame -gt $maxPoints) {
            $winner = $player
            $maxPoints = $player.NumPointsThisGame
        }
    }

    $winner
}
