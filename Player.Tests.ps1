<#
TODO: Find a code style/format so that this is idiomatic
      From what I can tell, functions have a different style than formal Cmdlets
#>

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
. $here\Player.ps1
. $here\Strategy.ps1

# Pester tests
Describe 'buildPlayer' {
  It "player should have a name" {
    $hand = @(1,2,3,4)
    $strategy = $global:getNextStrategy

    # test
    $player = buildPlayer "Mozart" $hand $strategy

    $player.Name | Should -Be "Mozart"
  }
  It "player should have a hand" {
    $hand = @(1,2,3,4)
    $strategy = $global:getNextStrategy

    # test
    $player = buildPlayer "Mozart" $hand $strategy

    $player.Hand.Count | Should -Be 4
  }
  It "player should have a strategy" {
    $hand = @(1,2,3,4)
    $strategy = $global:getNextStrategy

    # test
    $player = buildPlayer "Mozart" $hand $strategy
    $resultStrategy = $player.Strategy

    $result = applyStrategy -strategy $resultStrategy -hand $hand -prizeCard 0
    $result.Item1 | Should -Be 1
    $result.Item2.Count | Should -Be 3
  }
}

Describe 'playerTakesTurn' {
  It "player turn should generate a bid" {
    $hand = @(1,2,3,4)
    $player = buildPlayer "Mozart" $hand $getNextStrategy
    $prizeCard = 10

    # test
    $bid = playerTakesTurn $player $prizeCard

    $bid | Should -Be 1
  }
  It "player turn should modify the hand" {
    $hand = @(1,2,3,4)
    $player = buildPlayer "Mozart" $hand $getNextStrategy
    $prizeCard = 10

    # test
    $bid = playerTakesTurn $player $prizeCard

    $player.Hand.Count | Should -Be 3
    $player.Hand[0] | Should -Be 2
    $player.Hand[1] | Should -Be 3
    $player.Hand[2] | Should -Be 4
  }
}

Describe 'playerWins' {
  It "winning player should be awarded prize points" {
    $hand = @(1,2,3,4)
    $player = buildPlayer "Mozart" $hand $getNextStrategy
    $prizeCard = 10

    # test
    playerWins $player $prizeCard

    $player.NumPointsThisGame | Should -Be 10
    $player.NumRoundsWon | Should -Be 1
  }
}
