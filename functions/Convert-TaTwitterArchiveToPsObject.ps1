<#
.SYNOPSIS
    Possibly a collection of functions that will convert from json to powershell obkect to markdown files
.NOTES
    TODO: 
    * handle pictures
    * replace the shortened url with the expanded url
    * 
    * replace the expanded url with markdown link
    * get it into a format it can be imported into micro.blog
.LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
    $Tweets = gc ./clean_tweets.json  | convertfrom-json
    $t20 = $Tweets | ? tweet -like "*Nov 20*" | select -first 20
    $T20 | Select-TweetStuff

    DEBUG: Convert-TaTwitterArchiveToPsObject: $Urls count: <1>
DEBUG: Text <ICYMI: top reggae trivia from @JohnWilson14's MasterTapes https://t.co/BiDUifu1Uz>
DEBUG: Short <https://t.co/BiDUifu1Uz> Expanded <https://twitter.com/salisbury_matt/status/763628643323084800>
DEBUG: Text <ICYMI: top reggae trivia from @JohnWilson14's MasterTapes https://twitter.com/salisbury_matt/status/763628643323084800>
Convert-TaShortenedLinks: C:\Users\matty\OneDrive\powershell\Modules\TwitterArchiveStuff\functions\Convert-TaTwitterArchiveToPsObject.ps1:54
Line |
  54 |                  $Text = Convert-TaShortenedLinks -TweetText $Text
     |                          ~~~~~~~~~~~~~~~~~~~~~~~~
     | The term 'Convert-TaShortenedLinks' is not recognized as a name of a cmdlet, function, script file, or
     | executable program. Check the spelling of the name, or if a path was included, verify that the path is correct
     | and try again.
DEBUG: Created <(@{edit_info=; retweeted=False; source=<a href="http://twitter.com" rel="nofollow">Twitter Web Client</a>; entities=; display_text_range=System.Object[]; favorite_count=0; id_str=763844007285911552; truncated=False; retweet_count=0; id=763844007285911
#>


function Convert-TaTwitterArchiveToPsObject {
    [cmdletbinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipeline = $true)]
        $Tweet
    )
    process {
        foreach ($T in $Tweet) {
            $Top = $T | Select-Object -expand tweet
            write-debug "Created <($top).created_at"

            $ImageLinks = get-TaImageLinks -ExpandedTweet $Top
            write-dbg "`$ImageLinks count: <$($ImageLinks.Length)>"

            $Urls = foreach ($E in $($Top | select-object -expand entities)) {
                
                $E | select-object -expand urls

            }
            write-dbg "`$Urls count: <$($Urls.Length)>"
            
            if ($Urls) {
                [string]$Text = $Top.full_text
                Write-Debug "Text <$Text>"
                foreach ($U in $Urls) {
                    [string]$Short = $U.Url
                    [string]$Expanded = $U.Expanded_url
                    Write-Debug "Short <$Short> Expanded <$Expanded>"
                    $Text = $Text -replace $Short, $Expanded
                    Write-Debug "Text <$Text>"
                }

                $Text = Convert-TaShortenedLinksWithinTheTweet -TweetText $Text

                [PSCustomObject]@{
                    datetime          = $Top.created_at
                    Text              = $Text
                    converteddateTime = [DateTime]::ParseExact($Top.created_at,
                        'ddd MMM dd HH:mm:ss zzz yyyy', 
                        $null) 
                    ImageLinks        = $ImageLinks                    
                }
            }
            else {
                $Text = $Top.full_text
                $Text = Convert-TaShortenedLinksWithinTheTweet -TweetText $Text
                [PSCustomObject]@{
                    datetime          = $Top.created_at
                    Text              = $Text
                    converteddateTime = [DateTime]::ParseExact($Top.created_at,
                        'ddd MMM dd HH:mm:ss zzz yyyy', 
                        $null) 
                    ImageLinks        = $ImageLinks                    


                }

            }
        }
    }
}

function get-TaImageLinks {
    [CmdletBinding()]
    param (
        $ExpandedTweet
    )
    
    if (!($ExpandedTweet.Extended_entities)) {
        return $null
    }

    $Images = $ExpandedTweet |
    Select-Object -ExpandProperty extended_entities | 
    Select-Object -ExpandProperty  media
    write-dbg "In get-TaImageLinks `$Images count: <$($Images.Length)>"

    $ImageLinks = foreach ($I in $Images) {

        [string]$TweetId = $I.id_str
        [string]$Url = $I.Media_url

        [string]$FileName = Split-Path $url -Leaf
        
        $ImageFileName = "$TweetId-$FileName"

        [PSCustomObject]@{
            ImageFileName = $ImageFileName
        }
    }

    write-dbg "`$ImageLinks count: <$($ImageLinks.Length)>"

    return $ImageLinks
    
}


function write-dbg {
    <#
.SYNOPSIS
   xx
#>
    [CmdletBinding()]
    param (
        $DebugLine
    )
   
    $DebugPreference = $PSCmdlet.GetVariableValue('DebugPreference')
   
   
   
    write-debug $DebugLine
   
   
}