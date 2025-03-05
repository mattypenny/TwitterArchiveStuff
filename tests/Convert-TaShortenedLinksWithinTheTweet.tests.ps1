Describe "Convert-TaShortenedLinksWithinTheTweet" {


    beforeAll {
        import-module -force TwitterArchiveStuff
    }
    $testCases = @(
       
        @{ 
            TweetText = "Listening to local author Terry Pratchett in a talk in Philadelphia. http://bit.ly/abNxkd"
            Expected  = "Listening to local author Terry Pratchett in a talk in Philadelphia. https://libwww.freelibrary.org/podcast/episode/571"
        },
        @{ 
            TweetText = "Wish I/we'd asked the S'bury candidates how they plan to protect the noses of local canines -   http://bit.ly/9aOFc2"
            Expected  = "Wish I/we'd asked the S'bury candidates how they plan to protect the noses of local canines -   https://www.salisburyjournal.co.uk/news/8116189.Dog_injures_nose/"
        }
        <#
        @{
            TweetText = "RT @guardianobits: Sir John Hoskyns obituary. Businessman and influential head of Margaret Thatcher's policy unit. http://bit.ly/1sHcbQl"
            Expected  = "http://expanded.url/1" 
        },
        @{ 
            TweetText = " interesting interview with Dickens biographer Michael Slater http://bit.ly/hz0QMz"
            Expected  = "http://expanded.url/1"
   
        },
        @{ 
            TweetText = "This is very good - RT @Londonist Is this the most beautiful hand-drawn map of London yet? http://bit.ly/cyCjR3"
            Expected  = "http://expanded.url/1"
        },
        @{ 
            TweetText = "Preferred the Fragonard to the Damien Hirst at the Wallace Collection. http://bit.ly/51YCbY"
            Expected  = "http://expanded.url/1"
        },
        @{ 
            TweetText = "Enjoying the classic England/Bulgaria episode of Whatever Happened to the Likely Lads? on the iPlayer http://bit.ly/5FgQ8F"
            Expected  = "http://expanded.url/1"
        },
        @{ 
            TweetText = "Read this on Mark Steel's blog about a gig in Andersonstown - http://bit.ly/6SH9Qr"
            Expected  = "http://expanded.url/1"
        },
        @{ 
            TweetText = "The Beeb has started podcasting Desert Island Discs - hooray! http://bit.ly/77Gvu1"
            Expected  = "http://expanded.url/1"
        },
        @{ 
            TweetText = "My favourite Xmas-related podcast - the Nightsingers of Brighton, Newfoundland. From RTE http://bit.ly/6zfdkv"
            Expected  = "http://expanded.url/1"
        }
        #>
    )


    It "should return the Expected result for <TweetText>" -TestCases $testCases {

        write-host $TweetText
        write-host $expected
        # Act
        $result = Convert-TaShortenedLinksWithinTheTweet -TweetText $TweetText

        # Assert
        $result | Should -Be $Expected
    }
}