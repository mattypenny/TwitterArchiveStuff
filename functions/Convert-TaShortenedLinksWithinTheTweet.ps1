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
    $patterns = @("WIN", "fo")

$pattern = '\b$p[^ ]* '

$p = $patterns -join "|"

$pattern = '\b$p[^ ]* '

$matches = [regex]::Matches($string, $pattern, 'IgnoreCase')

foreach ($match in $matches) {
    Write-Output $match.Value
}

$p

$pattern = '\b(' + $p + ')[^ ]* '

$matches = [regex]::Matches($string, $pattern, 'IgnoreCase') ; foreach ($match in $matches) {
    Write-Output $match.Value
}
    
    #>
    write-dbg "`$TweetText: <$TweetText>"
    foreach ($ShortenedLinkString in 'https://t.co',
        'https://bit.ly',
        'https://buff.ly',
        'https://dlvr.it',
        'https://ift.tt',
        'https://lnkd.in',
        'https://ow.ly',
        'https://tinyurl.com',
        'https://youtu.be') {

        $AllShortenedLinks = $TweetText | 
        Select-String -Pattern $ShortenedLinkString -AllMatches | 
        Select-Object -ExpandProperty Matches | 
        Select-Object -ExpandProperty Value

        foreach ($ShortenedLink in $AllShortenedLinks) {
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
