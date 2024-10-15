
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
#> # A tibble: 895,673 × 5
#>       ID title              year author        word     
#>    <dbl> <chr>             <dbl> <chr>         <chr>    
#>  1     1 Wuthering Heights  1847 Bronte, Emily wuthering
#>  2     1 Wuthering Heights  1847 Bronte, Emily heights  
#>  3     1 Wuthering Heights  1847 Bronte, Emily chapter  
#>  4     1 Wuthering Heights  1847 Bronte, Emily returned 
#>  5     1 Wuthering Heights  1847 Bronte, Emily visit    
#>  6     1 Wuthering Heights  1847 Bronte, Emily landlord 
#>  7     1 Wuthering Heights  1847 Bronte, Emily solitary 
#>  8     1 Wuthering Heights  1847 Bronte, Emily neighbour
#>  9     1 Wuthering Heights  1847 Bronte, Emily troubled 
#> 10     1 Wuthering Heights  1847 Bronte, Emily beautiful
#> # ℹ 895,663 more rows
```

Here, we can use the `document_by_ID` function to extract the `id`,
`text`, and an additional column, `author`, for the document `Vathek`.

Additionally, we can do some `frequency list` text analysis on this
document by finding all the unigrams in it:

``` r
Documents
#> # A tibble: 18 × 5
#>    id    title                          text                        year  author
#>    <chr> <chr>                          <chr>                       <chr> <chr> 
#>  1 1     Vathek                         vathek an arabian tale by … 1786  Beckf…
#>  2 2     A Sicilian Romance             a sicilian romance by ann … 1790  Radcl…
#>  3 3     The Mysteries of Udulpho       the mysteries of udolpho a… 1794  Radcl…
#>  4 4     The Monk: A Romance            the monk a romance by matt… 1795  Lewis…
#>  5 5     Sense and Sensibility          sense and sensibility by j… 1811  Auste…
#>  6 6     Frankenstein                   frankenstein or the modern… 1818  Shell…
#>  7 7     Ivanhoe                        ivanhoe a romance by sir w… 1820  Scott…
#>  8 8     Narrative of Arthur Gordon Pym narrative of a gordon pym … 1838  Poe, …
#>  9 9     Wuthering Heights              wuthering heights chapter … 1847  Bront…
#> 10 10    The House of Seven Gables      the house of the seven gab… 1851  Hawth…
#> 11 11    North and South                north and south by elizabe… 1854  Gaske…
#> 12 12    The Woman in White             the woman in white by wilk… 1860  Colli…
#> 13 13    Great Expectations             chapter i my father s fami… 1861  Dicke…
#> 14 14    The Portrait of a Lady         chapter i under certain ci… 1881  James…
#> 15 15    Treasure Island                to the hesitating purchase… 1882  Steve…
#> 16 16    Dr Jekyll and Hyde             strange case of dr jekyll … 1886  Steve…
#> 17 17    The Picture of Dorian Gray     the artist is the creator … 1890  Wilde…
#> 18 18    Dracula                        chapter jonathan harker s … 1897  Stoke…
document_by_ID(id == 1, vars = "year")
#> # A tibble: 1 × 3
#> # Groups:   id, text [1]
#>   id    text                                                               year 
#>   <chr> <chr>                                                              <chr>
#> 1 1     vathek an arabian tale by william beckford esq p vathek vathek ni… 1786
unigram_Analysis = document_by_ID(id == 1, vars = "year")

UA = unigram_Analysis %>%
  unnest_tokens(word, 
                text, 
                token = "words") %>%
  anti_join(get_stopwords("en", source = "smart")) 

UA_Count_Words = UA %>%
  count(word, sort = T)
UA_Count_Words
#> # A tibble: 5,396 × 3
#> # Groups:   id [1]
#>    id    word            n
#>    <chr> <chr>       <int>
#>  1 1     caliph        151
#>  2 1     vathek        125
#>  3 1     nouronihar     87
#>  4 1     carathis       79
#>  5 1     thy            78
#>  6 1     thou           72
#>  7 1     whilst         66
#>  8 1     bababalouk     55
#>  9 1     gulchenrouz    54
#> 10 1     palace         47
#> # ℹ 5,386 more rows
```

If you would like to know more about this package, please see the [Get
started](https://anshalmm.github.io/corpuscleaner/articles/corpuscleaner.html)
Page.
