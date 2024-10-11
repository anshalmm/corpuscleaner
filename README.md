
<!-- README.md is generated from README.Rmd. Please edit that file -->

# corpuscleaner

<!-- badges: start -->
<!-- badges: end -->

This package has a collection of 18 Documents cleaned and ready for use
regarding Corpus Analysis. It has `novels()` function which has the
collection consisting of:

- `title`: The Title of the Document
- `text`: The Text of the Document
- `year`: The Year the Document was Published
- `author`: The Author of the Document
- `novel_bookshelf`: The Category of the Document

It also has a function `polish(..., vars)` that consists of:

- `title`
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
#>    title             text                            year author novel_bookshelf
#>    <chr>             <chr>                          <dbl> <chr>  <chr>          
#>  1 Wuthering Heights WUTHERING HEIGHTS               1847 Bront… Tragedy        
#>  2 Wuthering Heights CHAPTER I                       1847 Bront… Tragedy        
#>  3 Wuthering Heights I have just returned from a v…  1847 Bront… Tragedy        
#>  4 Wuthering Heights This is certainly a beautiful…  1847 Bront… Tragedy        
#>  5 Wuthering Heights In all England                  1847 Bront… Tragedy        
#>  6 Wuthering Heights I do not believe that I could…  1847 Bront… Tragedy        
#>  7 Wuthering Heights A perfect misanthropist s hea…  1847 Bront… Tragedy        
#>  8 Wuthering Heights and Mr                          1847 Bront… Tragedy        
#>  9 Wuthering Heights Heathcliff and I are such a s…  1847 Bront… Tragedy        
#> 10 Wuthering Heights A capital fellow                1847 Bront… Tragedy        
#> # ℹ 20,711 more rows
```

Then we can use the `polish` function to extract the title, text, and an
additional column, author for the document `Vathek`.

We can do some frequency list text analysis on this document by finding
all the unigrams in it:

``` r
polish(title == "Vathek", vars = "author")
#> # A tibble: 5,259 × 3
#> # Groups:   title, text [4,903]
#>    title  text             author           
#>    <chr>  <chr>            <chr>            
#>  1 Vathek VATHEK           Beckford, William
#>  2 Vathek AN ARABIAN TALE  Beckford, William
#>  3 Vathek BY               Beckford, William
#>  4 Vathek WILLIAM BECKFORD Beckford, William
#>  5 Vathek ESQ              Beckford, William
#>  6 Vathek p                Beckford, William
#>  7 Vathek VATHEK           Beckford, William
#>  8 Vathek Vathek           Beckford, William
#>  9 Vathek ninth Caliph     Beckford, William
#> 10 Vathek a                Beckford, William
#> # ℹ 5,249 more rows
unigram_Analysis = polish(title == "Vathek", vars = "author")

UA = unigram_Analysis %>%
  unnest_tokens(word, 
                text, 
                token = "words") %>%
  anti_join(get_stopwords("en", source = "smart")) 

UA_Count_Words = UA %>%
  count(word, sort = T)
UA_Count_Words
#> # A tibble: 5,393 × 3
#> # Groups:   title [1]
#>    title  word            n
#>    <chr>  <chr>       <int>
#>  1 Vathek caliph        151
#>  2 Vathek vathek        125
#>  3 Vathek nouronihar     87
#>  4 Vathek carathis       79
#>  5 Vathek thy            78
#>  6 Vathek thou           72
#>  7 Vathek whilst         66
#>  8 Vathek bababalouk     55
#>  9 Vathek gulchenrouz    54
#> 10 Vathek palace         47
#> # ℹ 5,383 more rows
```

If you would like to know how to use this package, please see the
Vignette on it.
