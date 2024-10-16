Describe "Convert-TaTwitterArchiveToPsObject" {

    BeforeAll {
        
        $tweets = Get-Content $PsScriptRoot/DummyTwitterArchive.json | convertfrom-json | Convert-TaTwitterArchiveToPsObject

    }

    It "returns the right number of tweets" {
        $tweets.length | Should -Be 2
    }

        It "converts Musk's shortened URLs to long URLs" {

            $TweetWithTheLink = $Tweets[1]
            $Text = $TweetWithTheLink.Text
            Write-Debug "`$Text: <$Text>"
            $Text.Contains('t.co') | Should -Be $False
            $Text | Should -BeLike "*bbc*"

    }

    It -pending "includes an markdown image link in the output, if there is one" {

            $True | Should -Be $False

    }

    It "creates two image sub-objects if there are two images" {
            $TweetWithTheImages = $Tweets[0]
            $Images = $TweetWithTheImages | Select-Object -expand ImageLinks
            $Images | Should -HaveCount 2
    }


    It "creates an image link by concatenating the tweet id with the file name from the media url" {
        
            $TweetWithTheImages = $Tweets[0]
            $Images = $TweetWithTheImages | Select-Object -expand ImageLinks

            $FirstImageFileName = $Images[0].ImageFileName
            Write-Debug "`$FirstImageFileName: <$FirstImageFileName>"
            $FirstImageFileName | Should -Be '1076485920365469696-DvByPbkX4AAP4h9.jpg'
        
            $SecondImageFileName = $Images[1].ImageFileName
            Write-Debug "`$SecondImageFileName: <$SecondImageFileName>"
            $SecondImageFileName | Should -Be '1076485939613044736-DvByQjRWkAAsYDj.jpg'
        
    }

    It -pending "includes two image links in the text if there are two images" {

            $True | Should -Be $False

    }

    It -pending "sticks a space in front of the 
    hashtags so that markdown doesn't treat them as headings" {

    }

}