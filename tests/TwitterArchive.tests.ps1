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

    It -pending "includes two image links in the text if there are two images" {

            $True | Should -Be $False

    }

}