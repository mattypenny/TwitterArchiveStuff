function write-startfunction {
<#
.SYNOPSIS
  Marks start of function in logfile or debug output
.DESCRIPTION
  Gets parameters back from Get-PSCallStack
.EXAMPLE
  write-startfunction 
#>

    [CmdletBinding()]

    Param(  )

    $DebugPreference = $PSCmdlet.GetVariableValue('DebugPreference')

    $CallDate = get-date -format 'hh:mm:ss.ffff'

    $CallingFunction = Get-PSCallStack | Select-Object -first 2 | select-object -last 1

    [string]$Command = $CallingFunction.Command

    [string]$Location = $CallingFunction.Location

    [string]$Arguments = $CallingFunction.Arguments

    # [string]$FunctionName = $CallingFunction.FunctionName
    # (Get-Host).PrivateData.DebugForegroundColor = "Gray"

    write-dbg  "$CallDate StartFunction: $Command "

    # (Get-Host).PrivateData.DebugForegroundColor = "Blue"

    return
}


function write-endfunction {
<#
.SYNOPSIS
  Marks end of function in logfile or debug output
.DESCRIPTION
  Gets parameters back from Get-PSCallStack
.EXAMPLE
  write-endfunction 
#>

    [CmdletBinding()]

    Param(  )

    $DebugPreference = $PSCmdlet.GetVariableValue('DebugPreference')

    $CallDate = get-date -format 'hh:mm:ss.ffff'

    $CallingFunction = Get-PSCallStack | Select-Object -first 2 | select-object -last 1

    [string]$Command = $CallingFunction.Command

    [string]$Location = $CallingFunction.Location

    [string]$Arguments = $CallingFunction.Arguments

    # [string]$FunctionName = $CallingFunction.FunctionName
    # (Get-Host).PrivateData.DebugForegroundColor = "Gray"

    write-dbg  "$CallDate EndFunction: $Command "

    # (Get-Host).PrivateData.DebugForegroundColor = "Blue"

    return
}