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
    $T20 | Convert-TaTwitterArchiveToPsObject

#>


function Convert-TaTwitterArchiveToPsObject {
    [cmdletbinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipeline = $true)]
        $Tweet,
        $Log = 'c:\temp\TwitterARchiveStuff\Log-$(Get-date).dayofweek.csv'
    )
    process {

        write-SsfLog -Log $Log -Message "In Convert-TaTwitterArchiveToPsObject" -Initialize

        foreach ($T in $Tweet) {
            $Top = $T | Select-Object -expand tweet
            write-SsfLog -Log $Log -Message "Created <($top).created_at"

            $ImageLinks = get-TaImageLinks -ExpandedTweet $Top -Log $Log
            write-SsfLog -Log $Log -Message "`$ImageLinks count: <$($ImageLinks.Length)>"

            $Urls = foreach ($E in $($Top | select-object -expand entities)) {
                
                $E | select-object -expand urls

            }
            write-SsfLog -Log $Log -Message "`$Urls count: <$($Urls.Length)>"
            
            if ($Urls) {
                [string]$Text = $Top.full_text
                write-SsfLog -Log $Log -Message "Text <$Text>"
                foreach ($U in $Urls) {
                    [string]$Short = $U.Url
                    [string]$Expanded = $U.Expanded_url
                    write-SsfLog -Log $Log -Message "Short <$Short> Expanded <$Expanded>"
                    $Text = $Text -replace $Short, $Expanded
                    write-SsfLog -Log $Log -Message "Text <$Text>"
                }

                $Text = Convert-TaShortenedLinksWithinTheTweet -TweetText $Text -Log $Log

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
                $Text = Convert-TaShortenedLinksWithinTheTweet -TweetText $Text -Log $Log
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
        $ExpandedTweet,
        [Parameter(Mandatory = $True)][string]$Log
    )
    
    if (!($ExpandedTweet.Extended_entities)) {
        return $null
    }

    $Images = $ExpandedTweet |
    Select-Object -ExpandProperty extended_entities | 
    Select-Object -ExpandProperty  media
    write-SsfLog -Log $Log -Message "In get-TaImageLinks `$Images count: <$($Images.Length)>"

    $ImageLinks = foreach ($I in $Images) {

        [string]$TweetId = $I.id_str
        [string]$Url = $I.Media_url

        [string]$FileName = Split-Path $url -Leaf
        
        $ImageFileName = "$TweetId-$FileName"

        [PSCustomObject]@{
            ImageFileName = $ImageFileName
        }
    }

    write-SsfLog -Log $Log -Message "`$ImageLinks count: <$($ImageLinks.Length)>"

    return $ImageLinks
    
}


