<#
TODO: Find a code style/format so that this is idiomatic
      From what I can tell, functions have a different style than formal Cmdlets
#>

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
. $here\Game.ps1

# Pester tests
Describe 'getDeck' {
  It "Given N, result deck has N items" {
    $deck = getDeck 10
    $deck.Count | Should -Be 10
  }
  It "Given N, result deck should be ordered" {
    $deck = getDeck 10
    $deck | Select-Object -first 1 | Should -Be 1
    $deck | Select-Object -last 1 | Should -Be 10
  }
}

Describe 'shuffleDeck' {
  It "Given N, result deck has N items" {
    $deck = getDeck 10
    $newDeck = shuffleDeck $deck
    $newDeck.Count | Should -Be 10
  }
}

Describe 'dealDeck' {
  It "Given N, result deck has N items" {
    $numCards = 20
    $numPlayers = 3
    $handSize = $numCards / ($numPlayers + 1)
    $deck = getDeck $numCards
    $newDeck = shuffleDeck $deck

    # test
    $hands = dealDeck $newDeck $handSize

    $hands.Count | Should -Be 4
    $hands[0].Count | Should -Be 5
    $hands[1].Count | Should -Be 5
    $hands[2].Count | Should -Be 5
    $hands[3].Count | Should -Be 5
  }
}
