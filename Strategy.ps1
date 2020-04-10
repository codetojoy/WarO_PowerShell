
<#
TODO: Find a code style/format so that this is idiomatic
      From what I can tell, functions have a different style than formal Cmdlets
#>

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
. $here\Constants.ps1

<#
TODO 1: We should store strategies as functions in a dictionary, but I haven't
figured out how to do that yet.

TODO 2: write more strategies
#>

function getNext ([int[]] $hand, [int] $prizeCard) {
    [int] $bid = $hand[0]
    [int[]] $newHand = $hand | Select-Object -Skip 1

    if ($newHand -eq $null) {
        $newHand = @()
    }

    $result = [System.Tuple]::Create($bid, $newHand)
    $result
}

function applyStrategy([string] $strategy, [int[]] $hand, [int] $prizeCard) {
    $result = $null
    if ($strategy -eq $global:getNextStrategy) {
        $result = getNext $hand $prizeCard
    }
    $result
}
