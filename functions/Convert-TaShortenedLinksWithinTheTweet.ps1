function Convert-TaShortenedLinksWithinTheTweet {
    <#
.SYNOPSIS
   xx
#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $True)][string]  $TweetText
    )
   
    $DebugPreference = $PSCmdlet.GetVariableValue('DebugPreference')
   
    write-startfunction
  
    write-dbg "`$TweetText: <$TweetText>"
 
    $patterns = @('https://t.co',
        'https://bit.ly',
        'http://bit.ly',
        'https://buff.ly',
        'https://dlvr.it',
        'https://ift.tt',
        'https://lnkd.in',
        'https://ow.ly',
        'http://tinyurl.com',
        'https://tinyurl.com',
        'https://youtu.be')

    $p = $patterns -join "|"
    
    $pattern = '\b(' + $p + ')[^ ]*(?=\s|$)'

    $RegexMatches = [regex]::Matches($TweetText, $pattern, 'IgnoreCase') 
    write-dbg "Regex line:`$matches = [regex]::Matches('$TweetText', '$pattern', 'IgnoreCase') "

    foreach ($Match in $RegexMatches) {
        $ShortenedLink = $Match.Value
        $ExpandedLink = Convert-TaShortenedLinkToExpandedLink -ShortenedLink $ShortenedLink

        $TweetText = $TweetText -replace $ShortenedLink, $ExpandedLink
    }


 


    # TODO: Need to return the expanded text
    # TODO: Need to allow for more than one shortened link in a tweet
    # TODO: Need comments
    # TODO: Need to pnly expand if there is a shortened link
    # TODO: Need to write a pester test
    # TODO: Need to perhaps expand the invoke webrequest line to make it more debuggable
    # TODO: Need to think ablout a log file for the whole thing tbh
   
    write-endfunction
    write-dbg "`$TweetText: <$TweetText>"

    return $TweetText
   
   
}

function Convert-TaShortenedLinkToExpandedLink {
    <#
<#
.SYNOPSIS
   xx
#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $True)][string] $ShortenedLink
    )
   
    $DebugPreference = $PSCmdlet.GetVariableValue('DebugPreference')
   
    write-startfunction
   
    write-dbg "`$ShortenedLink: <$ShortenedLink>"
    
    try {
        $Response = Invoke-WebRequest -UseBasicParsing -Uri $ShortenedLink
    }
    catch {
        write-dbg "Error: $_"
        return $ShortenedLink
    }
 
    $BaseResponse = $Response.BaseResponse
    $RequestMessage = $BaseResponse.RequestMessage
    $ExpandedLink = $RequestMessage.RequestUri.AbsoluteUri 
    
    write-dbg "`$ExpandedLink: <$ExpandedLink>"
    write-endfunction
   
    return $ExpandedLink
}