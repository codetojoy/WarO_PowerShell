<#
TODO: Find a code style/format so that this is idiomatic
      From what I can tell, functions have a different style than formal Cmdlets
#>

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
. $here\Strategy.ps1

# Pester tests
Describe 'applyStrategy' {
  It "applyStrategy should support getNext" {
    $hand = @(1,2,3,4)
    $prizeCard = 0

    # test
    $result = applyStrategy 'getNext' $hand $prizeCard

    $result.Item1 | Should -Be 1
    $result.Item2.Count | Should -Be 3
  }
}
Describe 'getNext' {
  It "getNext should pick the next card in the hand" {
    $hand = @(1,2,3,4)
    $prizeCard = 0

    # test
    $result = getNext $hand $prizeCard

    $result.Item1 | Should -Be 1
    $result.Item2.Count | Should -Be 3
  }
  It "getNext should handle picking the last card" {
    $hand = @(7)
    $prizeCard = 0

    # test
    $result = getNext $hand $prizeCard

    $result.Item1 | Should -Be 7
    $result.Item2.Count | Should -Be 0
  }
}
