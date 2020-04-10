<#
TODO: Find a code style/format so that this is idiomatic
      From what I can tell, functions have a different style than formal Cmdlets
#>

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
. "$here\..\Config.ps1"

# Pester tests
Describe 'buildConfigFromJson' {
  It "should support basic functionality" {
    $jsonStr =@' 
{
    "numCards": 20,
    "players" :
        [
            {"name": "Bach", "strategy": "getNext"},
            {"name": "Mozart", "strategy": "getNext"}
        ]
}
'@

    # test
    $result = buildConfigFromJson $jsonStr

    $result.Item1 | Should -Be 20
    $result.Item2.Count | Should -Be 2
  }
}
