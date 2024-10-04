Describe "Convert-TaTwitterArchiveToPsObject" {

    BeforeAll {
        
        $tweets = Get-Content tests/DummyTwitterArchive.json | convertfrom-json | Convert-TaTwitterArchiveToPsObject

    }

    It "returns the right number of tweets" {
        $tweets.length | Should -Be 1
    }

        It -pending "converts shortened URLs to long URLs" {

            $True | Should -Be $False

    }

    It -pending "includes an markdown image link in the output, if there is one" {

            $True | Should -Be $False

    }

    It -pending "includes two image links in the text if there are two images" {

            $True | Should -Be $False

    }

}