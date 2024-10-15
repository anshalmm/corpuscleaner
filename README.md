
<!-- README.md is generated from README.Rmd. Please edit that file -->

# corpuscleaner

<!-- badges: start -->
<!-- badges: end -->

## Overview

The `{corpuscleaner}` package has a collection of `18 Documents` cleaned
and ready for use regarding Text Analysis. It has a dataset `Documents`
which has the collection consisting of:

- `ID`: ID of the Document
- `title`: Title of the Document
- `text`: Text of the Document
- `year`: Year the Document was Published
- `author`: Author of the Document

Along with this, the package has a function `novels` which has a one row
per line format for the `text`, along with the same variables as listed
above.

It also has a function `document_by_ID(..., vars)` that has a `tibble`
consisting of the Document’s:

- `id`
- `text`

and can add any `column_names` of your choice such as the `year`,
`author`, or both.

## Installation

You can install the development version of corpuscleaner from
[GitHub](https://github.com/) with:

``` r
# install.packages("corpuscleaner")
devtools::install_github("anshalmm/corpuscleaner")
```

## Examples

These are basic examples of what `corpuscleaner` can do when combined
with basic text analysis:

``` r
library(corpuscleaner)
library(dplyr)
library(tidytext)

novels() %>%
  unnest_tokens(word, 
                text, 
                token = "words") %>%
  anti_join(get_stopwords("en", source = "smart"))
#> [38;5;246m# A tibble: 895,673 × 6[39m
#>       ID title                year author         novel_bookshelf word     
#>    [3m[38;5;246m<dbl>[39m[23m [3m[38;5;246m<chr>[39m[23m               [3m[38;5;246m<dbl>[39m[23m [3m[38;5;246m<chr>[39m[23m          [3m[38;5;246m<chr>[39m[23m           [3m[38;5;246m<chr>[39m[23m    
#> [38;5;250m 1[39m     8 The Monk: A Romance  [4m1[24m795 Lewis, Matthew Gothic Fiction  monk     
#> [38;5;250m 2[39m     8 The Monk: A Romance  [4m1[24m795 Lewis, Matthew Gothic Fiction  romance  
#> [38;5;250m 3[39m     8 The Monk: A Romance  [4m1[24m795 Lewis, Matthew Gothic Fiction  matthew  
#> [38;5;250m 4[39m     8 The Monk: A Romance  [4m1[24m795 Lewis, Matthew Gothic Fiction  lewis    
#> [38;5;250m 5[39m     8 The Monk: A Romance  [4m1[24m795 Lewis, Matthew Gothic Fiction  somnia   
#> [38;5;250m 6[39m     8 The Monk: A Romance  [4m1[24m795 Lewis, Matthew Gothic Fiction  terrores 
#> [38;5;250m 7[39m     8 The Monk: A Romance  [4m1[24m795 Lewis, Matthew Gothic Fiction  magicos  
#> [38;5;250m 8[39m     8 The Monk: A Romance  [4m1[24m795 Lewis, Matthew Gothic Fiction  miracula 
#> [38;5;250m 9[39m     8 The Monk: A Romance  [4m1[24m795 Lewis, Matthew Gothic Fiction  sagas    
#> [38;5;250m10[39m     8 The Monk: A Romance  [4m1[24m795 Lewis, Matthew Gothic Fiction  nocturnos
#> [38;5;246m# ℹ 895,663 more rows[39m
```

Here, we can use the `document_by_ID` function to extract the `id`,
`text`, and an additional column, `author`, for the document `Vathek`.

Additionally, we can do some `frequency list` text analysis on this
document by finding all the unigrams in it:

``` r
Documents
#> [38;5;246m# A tibble: 18 × 5[39m
#>    id    title                          text                        year  author
#>    [3m[38;5;246m<chr>[39m[23m [3m[38;5;246m<chr>[39m[23m                          [3m[38;5;246m<chr>[39m[23m                       [3m[38;5;246m<chr>[39m[23m [3m[38;5;246m<chr>[39m[23m 
#> [38;5;250m 1[39m 1     Vathek                         vathek an arabian tale by … 1786  Beckf…
#> [38;5;250m 2[39m 2     A Sicilian Romance             a sicilian romance by ann … 1790  Radcl…
#> [38;5;250m 3[39m 3     The Mysteries of Udulpho       the mysteries of udolpho a… 1794  Radcl…
#> [38;5;250m 4[39m 4     The Monk: A Romance            the monk a romance by matt… 1795  Lewis…
#> [38;5;250m 5[39m 5     Sense and Sensibility          sense and sensibility by j… 1811  Auste…
#> [38;5;250m 6[39m 6     Frankenstein                   frankenstein or the modern… 1818  Shell…
#> [38;5;250m 7[39m 7     Ivanhoe                        ivanhoe a romance by sir w… 1820  Scott…
#> [38;5;250m 8[39m 8     Narrative of Arthur Gordon Pym narrative of a gordon pym … 1838  Poe, …
#> [38;5;250m 9[39m 9     Wuthering Heights              wuthering heights chapter … 1847  Bront…
#> [38;5;250m10[39m 10    The House of Seven Gables      the house of the seven gab… 1851  Hawth…
#> [38;5;250m11[39m 11    North and South                north and south by elizabe… 1854  Gaske…
#> [38;5;250m12[39m 12    The Woman in White             the woman in white by wilk… 1860  Colli…
#> [38;5;250m13[39m 13    Great Expectations             chapter i my father s fami… 1861  Dicke…
#> [38;5;250m14[39m 14    The Portrait of a Lady         chapter i under certain ci… 1881  James…
#> [38;5;250m15[39m 15    Treasure Island                to the hesitating purchase… 1882  Steve…
#> [38;5;250m16[39m 16    Dr Jekyll and Hyde             strange case of dr jekyll … 1886  Steve…
#> [38;5;250m17[39m 17    The Picture of Dorian Gray     the artist is the creator … 1890  Wilde…
#> [38;5;250m18[39m 18    Dracula                        chapter jonathan harker s … 1897  Stoke…
document_by_ID(id == 1, vars = "year")
#> [38;5;246m# A tibble: 1 × 3[39m
#> [38;5;246m# Groups:   id, text [1][39m
#>   id    text                                                               year 
#>   [3m[38;5;246m<chr>[39m[23m [3m[38;5;246m<chr>[39m[23m                                                              [3m[38;5;246m<chr>[39m[23m
#> [38;5;250m1[39m 1     vathek an arabian tale by william beckford esq p vathek vathek ni… 1786
unigram_Analysis = document_by_ID(id == 1, vars = "year")

UA = unigram_Analysis %>%
  unnest_tokens(word, 
                text, 
                token = "words") %>%
  anti_join(get_stopwords("en", source = "smart")) 

UA_Count_Words = UA %>%
  count(word, sort = T)
UA_Count_Words
#> [38;5;246m# A tibble: 5,396 × 3[39m
#> [38;5;246m# Groups:   id [1][39m
#>    id    word            n
#>    [3m[38;5;246m<chr>[39m[23m [3m[38;5;246m<chr>[39m[23m       [3m[38;5;246m<int>[39m[23m
#> [38;5;250m 1[39m 1     caliph        151
#> [38;5;250m 2[39m 1     vathek        125
#> [38;5;250m 3[39m 1     nouronihar     87
#> [38;5;250m 4[39m 1     carathis       79
#> [38;5;250m 5[39m 1     thy            78
#> [38;5;250m 6[39m 1     thou           72
#> [38;5;250m 7[39m 1     whilst         66
#> [38;5;250m 8[39m 1     bababalouk     55
#> [38;5;250m 9[39m 1     gulchenrouz    54
#> [38;5;250m10[39m 1     palace         47
#> [38;5;246m# ℹ 5,386 more rows[39m
```

If you would like to know more about this package, please see the [Get
started](https://anshalmm.github.io/corpuscleaner/articles/corpuscleaner.html)
Page.
