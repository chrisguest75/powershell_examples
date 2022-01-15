Set-StrictMode -Version Latest

BeforeAll {
    # DON'T use $MyInvocation.MyCommand.Path
    . $PSCommandPath.Replace('.Tests.ps1','.ps1')
    Mock Get-DateNow { return [datetime]::parse("12:34:56") }
        #Mock Get-DateNow {}

}

Describe -Tag "Acceptance" "Get-TimeString" {
    It "Get-TimeString should not throw" {
        { Get-TimeString } | Should -Not -Throw
    }

    It "Get-TimeString should return string value" {
        ((Get-TimeString) -is [string]) | Should -Be $true
    }

    It "Get-TimeString should be six characters in length" {
        (Get-TimeString).Length | Should -Be (6)
    }

    It "Get-TimeString should match mock datetime" {    
        (Get-TimeString) | Should -Be "123456"
    }

    It "Get-TimeString should contain only numerical characters" {
        {[int](Get-TimeString) -is [int]} | Should -Not -Throw
    }

}
