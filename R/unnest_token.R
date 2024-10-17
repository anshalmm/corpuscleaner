#' @title unnest_unigrams
#' @description Tokenizing the text into 1 unit (Word)
#' @param ... Input in the `id` of your choice from the `Documents` dataset
#' @return Splitting text into `1 token`
#' @format A \code{tibble} with 5 variables:
#' \describe{
#'  \item{id}{ID of the Document}
#'  \item{title}{Title of the Document}
#'  \item{author}{Author of the Document}
#'  \item{year}{Year Published}
#'  \item{word}{Token Column}
#' }
#' @export
#' @importFrom dplyr filter
#' @importFrom dplyr mutate
#' @importFrom stringi stri_extract_all_regex
#' @importFrom tidyr unnest
#' @importFrom dplyr select
#' @importFrom magrittr %>%
#' @examples
#' unnest_unigrams(id == 1)
unnest_unigrams = function(...){
  Documents %>%
    filter(...) %>%
    mutate(word = stri_extract_all_regex(text, pattern = "\\b(?:[[:word:]]+)")) %>%
    unnest(word) %>%
    select(id, title, -text, author, year, word)
}


#' @title unnest_bigrams
#' @description Tokenizing the text into 2 units (Words)
#' @param ... Input in the `id` of your choice from the `Documents` dataset
#' @return Mulitword combination of `2 tokens`
#'@format A \code{tibble} with 5 variables:
#' \describe{
#'  \item{id}{ID of the Document}
#'  \item{title}{Title of the Document}
#'  \item{author}{Author of the Document}
#'  \item{year}{Year Published}
#'  \item{token_two}{Token Column}
#' }
#' @export
#' @importFrom dplyr filter
#' @importFrom dplyr mutate
#' @importFrom stringi stri_extract_all_regex
#' @importFrom tidyr unnest
#' @importFrom dplyr select
#' @importFrom magrittr %>%
#' @examples
#' unnest_bigrams(id == 5)
unnest_bigrams = function(...){
  Documents %>%
    filter(...) %>%
    mutate(token_two = stri_extract_all_regex(text, pattern = "\\b(?:[[:word:]]+.[[:word:]]+|[[:word:]]+)")) %>%
    unnest(token_two) %>%
    select(id, title, -text, author, year, token_two)
}


#' @title unnest_trigrams
#' @description Tokenizing the text into 3 units (Words)
#' @param ... Input in the `id` of your choice from the `Documents` dataset
#' @return Mulitword combination of `3 tokens`
#' @format A \code{tibble} with 5 variables:
#' \describe{
#'  \item{id}{ID of the Document}
#'  \item{title}{Title of the Document}
#'  \item{author}{Author of the Document}
#'  \item{year}{Year Published}
#'  \item{token_three}{Token Column}
#' }
#' @export
#' @importFrom dplyr filter
#' @importFrom dplyr mutate
#' @importFrom stringi stri_extract_all_regex
#' @importFrom tidyr unnest
#' @importFrom dplyr select
#' @importFrom magrittr %>%
#' @examples
#' unnest_trigrams(id == 7)
unnest_trigrams = function(...){
  Documents %>%
    filter(...) %>%
    mutate(token_three = stri_extract_all_regex(text, pattern = "\\b(?:[[:word:]]+.[[:word:]]+.[[:word:]]+)")) %>%
    unnest(token_three) %>%
    select(id, title, -text, author, year, token_three)
}


#' @title unnest_N4_grams
#' @description Tokenizing the text into 4 units (Words)
#' @param ... Input in the `id` of your choice from the `Documents` dataset
#' @return Mulitword combination of `4 tokens`
#' @format A \code{tibble} with 5 variables:
#' \describe{
#'  \item{id}{ID of the Document}
#'  \item{title}{Title of the Document}
#'  \item{author}{Author of the Document}
#'  \item{year}{Year Published}
#'  \item{token_four}{Token Column}
#' }
#' @export
#' @importFrom dplyr filter
#' @importFrom dplyr mutate
#' @importFrom stringi stri_extract_all_regex
#' @importFrom tidyr unnest
#' @importFrom dplyr select
#' @importFrom magrittr %>%
#' @examples
#' unnest_N4_grams(id == 3)
unnest_N4_grams = function(...){
  Documents %>%
    filter(...) %>%
    mutate(token_four = stri_extract_all_regex(text, pattern = "\\b(?:[[:word:]]+.[[:word:]]+.[[:word:]]+.[[:word:]]+)")) %>%
    unnest(token_four) %>%
    select(id, title, -text, author, year, token_four)
}

#' @title unnest_N5_grams
#' @description Tokenizing the text into 5 units (Words)
#' @param ... Input in the `id` of your choice from the `Documents` dataset
#' @return Mulitword combination of `5 tokens`
#' @format A \code{tibble} with 5 variables:
#' \describe{
#'  \item{id}{ID of the Document}
#'  \item{title}{Title of the Document}
#'  \item{author}{Author of the Document}
#'  \item{year}{Year Published}
#'  \item{token_five}{Token Column}
#' }
#' @export
#' @importFrom dplyr filter
#' @importFrom dplyr mutate
#' @importFrom stringi stri_extract_all_regex
#' @importFrom tidyr unnest
#' @importFrom dplyr select
#' @importFrom magrittr %>%
#' @examples
#' unnest_N5_grams(id == 2)
unnest_N5_grams = function(...){
  Documents %>%
    filter(...) %>%
    mutate(token_five = stri_extract_all_regex(text, pattern = "\\b(?:[[:word:]]+.[[:word:]]+.[[:word:]]+.[[:word:]]+.[[:word:]]+)")) %>%
    unnest(token_five) %>%
    select(id, title, -text, author, year, token_five)
}
