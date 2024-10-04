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

            $Urls = foreach ($E in $($Top | select-object -expand entities)) {
                
                $E | select-object -expand urls

            }
            
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

                [PSCustomObject]@{
                    datetime = $Top.created_at
                    Text     = $Text
                    converteddateTime = [DateTime]::ParseExact($Top.created_at,
                        'ddd MMM dd HH:mm:ss zzz yyyy', 
                        $null) 
                }
            }
            else {
                [PSCustomObject]@{
                    datetime = $Top.created_at
                    Text     = $Top.full_text  
                    Short    = $null
                    Expanded = $null
                    Display  = $null

                }

            }
        }
    }
}