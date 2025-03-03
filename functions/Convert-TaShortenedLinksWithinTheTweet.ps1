function Convert-TaShortenedLinks {
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
   
    <#
 
$p

    
    #>
    write-dbg "`$TweetText: <$TweetText>"
 
    $patterns = @('https://t.co',
        'https://bit.ly',
        'https://buff.ly',
        'https://dlvr.it',
        'https://ift.tt',
        'https://lnkd.in',
        'https://ow.ly',
        'https://tinyurl.com',
        'https://youtu.be')

    $p = $patterns -join "|"
    
    $pattern = '\b(' + $p + ')[^ ]* '

    $RegexMatches = [regex]::Matches($string, $pattern, 'IgnoreCase') 
    write-dbg "Regex line:`$matches = [regex]::Matches('$TweetText', '$pattern', 'IgnoreCase') "

    foreach ($ShortenedLink in $RegexMatches) {
        write-dbg "`$ShortenedLink: <$ShortenedLink>"
        $ExpandedLink = ((Invoke-WebRequest -UseBasicParsing –Uri $ShortenedLink).baseresponse).RequestMessage.RequestUri.AbsoluteUri
        write-dbg "`$ExpandedLink: <$ExpandedLink>"

        $TweetText = $TweetText -replace $ShortenedLink, $ExpandedLink
    }


 


    # TODO: Need to return the expanded text
    # TODO: Need to allow for more than one shortened link in a tweet
    # TODO: Need comments
    # TODO: Need to pnly expand if there is a shortened link
    # TODO: Need to write a pester test
    # TODO: Need to perhaps expand the invoke webrequest line to make it more debuggable
    # TODO: Need to think ablout a log file for the whole thing tbh
}
   
write-endfunction
write-dbg "`$TweetText: <$TweetText>"

return $TweetText
   
   
}
