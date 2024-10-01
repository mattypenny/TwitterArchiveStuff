Describe "Convert-TaTwitterArchiveToPsObject" {

    BeforeAll {
        
        $tweets = cat ../tests/DummyTwitterArchive.json | convertfrom-json | Convert-TaTwitterArchiveToPsObject

    }

    It "returns the right number of tweets" {
        $tweets.length | Should -Be 1
    }
}