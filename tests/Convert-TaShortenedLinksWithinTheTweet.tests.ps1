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
        },
        @{
            TweetText = "RT @guardianobits: Sir John Hoskyns obituary. Businessman and influential head of Margaret Thatcher's policy unit. http://bit.ly/1sHcbQl"
            Expected  = "RT @guardianobits: Sir John Hoskyns obituary. Businessman and influential head of Margaret Thatcher's policy unit. https://www.theguardian.com/politics/2014/oct/20/sir-john-hoskyns"
        },
        @{ 
            TweetText = "Enjoying the classic England/Bulgaria episode of Whatever Happened to the Likely Lads? on the iPlayer http://bit.ly/5FgQ8F"
            Expected  = "Enjoying the classic England/Bulgaria episode of Whatever Happened to the Likely Lads? on the iPlayer https://www.bbc.co.uk/programmes/b007k47r"
        },
        @{ 
            TweetText = "The Beeb has started podcasting Desert Island Discs - hooray! http://bit.ly/77Gvu1"
            Expected  = "The Beeb has started podcasting Desert Island Discs - hooray! https://www.bbc.co.uk/sounds/brand/b006qnmr"
        },
        @{ 
            TweetText = "Hooray! RT  @chrismid259  It was only a matter of time  - Disney announces Monsters Inc sequel http://tinyurl.com/32zcnrb"
            Expected  = "Hooray! RT  @chrismid259  It was only a matter of time  - Disney announces Monsters Inc sequel http://news.bbc.co.uk/1/hi/entertainment/8639142.stm"
        },
        @{ 
            # checking it works if there's a space after the link
            TweetText = "My favourite Xmas-related podcast - the Nightsingers of Brighton, Newfoundland. From RTE http://bit.ly/41KzNeS "
            Expected  = "My favourite Xmas-related podcast - the Nightsingers of Brighton, Newfoundland. From RTE https://www.rte.ie/radio/doconone/2010/1229/646601-the_nightsingers_of_brighton/ "
        }
        @{ 
            TweetText = "Dory Previn was married to Andre Previn.  Tbh, I only know Andre Previn from Morecambe and Wise https://t.co/1EkizwPKd8"
            Expected  = "Dory Previn was married to Andre Previn.  Tbh, I only know Andre Previn from Morecambe and Wise https://en.wikipedia.org/wiki/Dory_Previn" 
        }
        @{ 
            TweetText = "Testing with two URLs https://t.co/1EkizwPKd8  http://bit.ly/41KzNeS "
            Expected  = "Testing with two URLs https://en.wikipedia.org/wiki/Dory_Previn  https://www.rte.ie/radio/doconone/2010/1229/646601-the_nightsingers_of_brighton/ " 
        }
        @{ 
            TweetText = "Testing with two URLs from the same shortener https://bit.ly/4hrSUim http://bit.ly/77Gvu1"
            Expected  = "Testing with two URLs from the same shortener https://mattypenny.micro.blog/ https://www.bbc.co.uk/sounds/brand/b006qnmr" 
        }
    )


    It "should return the an expanded link for '<TweetText>'" -TestCases $testCases {

        # Act
        $result = Convert-TaShortenedLinksWithinTheTweet -TweetText $TweetText

        # Assert
        $result | Should -Be $Expected
    }
}