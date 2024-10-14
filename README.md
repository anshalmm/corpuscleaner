
<!-- README.md is generated from README.Rmd. Please edit that file -->

# corpuscleaner

<!-- badges: start -->
<!-- badges: end -->

## Overview

The `{corpuscleaner}` package has a collection of 18 Documents cleaned
and ready for use regarding Corpus Analysis. It has a `novels()`
function which has the collection consisting of:

- `title`: The Title of the Document
- `text`: The Text of the Document
- `year`: The Year the Document was Published
- `author`: The Author of the Document
- `novel_bookshelf`: The Category of the Document

It also has a function `novels_by_ID(..., vars)` that consists of:

- `ID`
- `text`

and can add any `column_name` of your choice such as `year`, `author`,
or both.

## Installation

You can install the development version of corpuscleaner from
[GitHub](https://github.com/) with:

``` r
# install.packages("corpuscleaner")
devtools::install_github("anshalmm/corpuscleaner")
```

## Examples

These are basic examples of what `corpuscleaner` can show you when
combined with basic text analysis:

``` r
library(corpuscleaner)
library(dplyr)
library(tidytext)
```

Here we’re using the `novels()` function and filtering it out to find
the metadata of the document `Wuthering Heights`

``` r
WH_Text = novels() %>%
  filter(title == "Wuthering Heights")

WH_Text
#> # A tibble: 20,721 × 5
#>       ID title             text                                      year author
#>    <dbl> <chr>             <chr>                                    <dbl> <chr> 
#>  1     1 Wuthering Heights WUTHERING HEIGHTS                         1847 Bront…
#>  2     1 Wuthering Heights CHAPTER I                                 1847 Bront…
#>  3     1 Wuthering Heights I have just returned from a visit to my…  1847 Bront…
#>  4     1 Wuthering Heights This is certainly a beautiful country     1847 Bront…
#>  5     1 Wuthering Heights In all England                            1847 Bront…
#>  6     1 Wuthering Heights I do not believe that I could have fixe…  1847 Bront…
#>  7     1 Wuthering Heights A perfect misanthropist s heaven          1847 Bront…
#>  8     1 Wuthering Heights and Mr                                    1847 Bront…
#>  9     1 Wuthering Heights Heathcliff and I are such a suitable pa…  1847 Bront…
#> 10     1 Wuthering Heights A capital fellow                          1847 Bront…
#> # ℹ 20,711 more rows
```

Then we can use the `novels_by_ID` function to extract the ID, text, and
an additional column, author, for the document `Vathek`.

We can do some frequency list text analysis on this document by finding
all the unigrams in it:

``` r
novels()
#> # A tibble: 369,611 × 5
#>       ID title             text                                      year author
#>    <dbl> <chr>             <chr>                                    <dbl> <chr> 
#>  1     1 Wuthering Heights WUTHERING HEIGHTS                         1847 Bront…
#>  2     1 Wuthering Heights CHAPTER I                                 1847 Bront…
#>  3     1 Wuthering Heights I have just returned from a visit to my…  1847 Bront…
#>  4     1 Wuthering Heights This is certainly a beautiful country     1847 Bront…
#>  5     1 Wuthering Heights In all England                            1847 Bront…
#>  6     1 Wuthering Heights I do not believe that I could have fixe…  1847 Bront…
#>  7     1 Wuthering Heights A perfect misanthropist s heaven          1847 Bront…
#>  8     1 Wuthering Heights and Mr                                    1847 Bront…
#>  9     1 Wuthering Heights Heathcliff and I are such a suitable pa…  1847 Bront…
#> 10     1 Wuthering Heights A capital fellow                          1847 Bront…
#> # ℹ 369,601 more rows
novels_by_ID(ID = 2, vars = "year")
#> # A tibble: 5,259 × 3
#> # Groups:   ID, text [4,903]
#>       ID text              year
#>    <dbl> <chr>            <dbl>
#>  1     2 VATHEK            1786
#>  2     2 AN ARABIAN TALE   1786
#>  3     2 BY                1786
#>  4     2 WILLIAM BECKFORD  1786
#>  5     2 ESQ               1786
#>  6     2 p                 1786
#>  7     2 VATHEK            1786
#>  8     2 Vathek            1786
#>  9     2 ninth Caliph      1786
#> 10     2 a                 1786
#> # ℹ 5,249 more rows
unigram_Analysis = novels_by_ID(ID = 2, vars = "year")

UA = unigram_Analysis %>%
  unnest_tokens(word, 
                text, 
                token = "words") %>%
  anti_join(get_stopwords("en", source = "smart")) 

UA_Count_Words = UA %>%
  count(word, sort = T)
UA_Count_Words
#> # A tibble: 5,393 × 3
#> # Groups:   ID [1]
#>       ID word            n
#>    <dbl> <chr>       <int>
#>  1     2 caliph        151
#>  2     2 vathek        125
#>  3     2 nouronihar     87
#>  4     2 carathis       79
#>  5     2 thy            78
#>  6     2 thou           72
#>  7     2 whilst         66
#>  8     2 bababalouk     55
#>  9     2 gulchenrouz    54
#> 10     2 palace         47
#> # ℹ 5,383 more rows
```

If you would like to know more about this package, please see the [Get
started](https://anshalmm.github.io/corpuscleaner/articles/corpuscleaner.html)
Page.
