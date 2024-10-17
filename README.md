
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

It also has functions relating to `text analysis` such as:

- `novels` which has a one row per line format for the `text`, along
  with the same variables as listed above.

- `document_by_ID(..., vars)` that has a `tibble` consisting of the
  Document’s:

- `id`

- `text`

and can add any `column_names` of your choice such as the `year`,
`author`, or both.

Alongside this, there are `Frequency List` functions relative to the
`Documents` dataset :

- `unnest_unigrams`
- `unnest_bigrams`
- `unnest_trigrams`
- `unnest_N4_grams`
- `unnest_N5_grams`

## Installation

You can install the development version of corpuscleaner from
[GitHub](https://github.com/) with:

``` r
# install.packages("corpuscleaner")
devtools::install_github("anshalmm/corpuscleaner")
```

## Usage

``` r
library(corpuscleaner)
library(dplyr)
library(tidytext)
# novels() 
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

# document_by_ID
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

# Frequency List
unigram_Analysis = unnest_unigrams(id == 4)
UA = unigram_Analysis %>%
  anti_join(get_stopwords("en", source = "smart"))
UA
#> # A tibble: 55,650 × 5
#>    id    title               author         year  word     
#>    <chr> <chr>               <chr>          <chr> <chr>    
#>  1 4     The Monk: A Romance Lewis, Matthew 1795  monk     
#>  2 4     The Monk: A Romance Lewis, Matthew 1795  romance  
#>  3 4     The Monk: A Romance Lewis, Matthew 1795  matthew  
#>  4 4     The Monk: A Romance Lewis, Matthew 1795  lewis    
#>  5 4     The Monk: A Romance Lewis, Matthew 1795  somnia   
#>  6 4     The Monk: A Romance Lewis, Matthew 1795  terrores 
#>  7 4     The Monk: A Romance Lewis, Matthew 1795  magicos  
#>  8 4     The Monk: A Romance Lewis, Matthew 1795  miracula 
#>  9 4     The Monk: A Romance Lewis, Matthew 1795  sagas    
#> 10 4     The Monk: A Romance Lewis, Matthew 1795  nocturnos
#> # ℹ 55,640 more rows
```

If you would like to know more about this package, please see the [Get
started](https://anshalmm.github.io/corpuscleaner/articles/corpuscleaner.html)
Page.
