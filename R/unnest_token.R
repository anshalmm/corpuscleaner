#' @title unnest_unigrams
#' @description Tokenizing the text into 1 unit (Word)
#' @param tbl Input in the `tibble` of your choice made from the `document_by_ID` function
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
#' @importFrom dplyr mutate
#' @importFrom stringi stri_extract_all_regex
#' @importFrom tidyr unnest
#' @importFrom dplyr select
#' @importFrom magrittr %>%
#' @importFrom rlang enquo
#' @examples
#' UDocument = document_by_ID(id == 1)
#' unnest_unigrams(UDocument)
unnest_unigrams = function(data, args){
  args = rlang::enquo(args)
  data %>%
    mutate(word = stri_extract_all_regex(text, pattern = "\\b(?:[[:word:]]+)")) %>%
    unnest(word) %>%
    select(id, title, -text, author, year, word)
}


#' @title unnest_bigrams
#' @description Tokenizing the text into 2 units (Words)
#' @param tbl Input in the `tibble` of your choice made from the `document_by_ID` function
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
#' @importFrom dplyr mutate
#' @importFrom stringi stri_extract_all_regex
#' @importFrom tidyr unnest
#' @importFrom dplyr select
#' @importFrom magrittr %>%
#' @importFrom rlang enquo
#' @examples
#' BDocument = document_by_ID(id == 5)
#' unnest_bigrams(BDocument)
unnest_bigrams = function(data, args){
  args = rlang::enquo(args)
  data %>%
    mutate(token_two = stri_extract_all_regex(text, pattern = "\\b(?:[[:word:]]+.[[:word:]]+|[[:word:]]+)")) %>%
    unnest(token_two) %>%
    select(id, title, -text, author, year, token_two)
}


#' @title unnest_trigrams
#' @description Tokenizing the text into 3 units (Words)
#' @param tbl Input in the `tibble` of your choice made from the `document_by_ID` function
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
#' @importFrom dplyr mutate
#' @importFrom stringi stri_extract_all_regex
#' @importFrom tidyr unnest
#' @importFrom dplyr select
#' @importFrom magrittr %>%
#' @importFrom rlang enquo
#' @examples
#' TDocument = document_by_ID(id == 7)
#' unnest_trigrams(TDocument)
unnest_trigrams = function(data, args){
  args = rlang::enquo(args)
  data %>%
    mutate(token_three = stri_extract_all_regex(text, pattern = "\\b(?:[[:word:]]+.[[:word:]]+.[[:word:]]+)")) %>%
    unnest(token_three) %>%
    select(id, title, -text, author, year, token_three)
}


#' @title unnest_N4_grams
#' @description Tokenizing the text into 4 units (Words)
#' @param tbl Input in the `tibble` of your choice made from the `document_by_ID` function
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
#' @importFrom dplyr mutate
#' @importFrom stringi stri_extract_all_regex
#' @importFrom tidyr unnest
#' @importFrom dplyr select
#' @importFrom magrittr %>%
#' @importFrom rlang enquo
#' @examples
#' NDocument = document_by_ID(id == 10)
#' unnest_N4_grams(NDocument)
unnest_N4_grams = function(data, args){
  args = rlang::enquo(args)
  data %>%
    mutate(token_four = stri_extract_all_regex(text, pattern = "\\b(?:[[:word:]]+.[[:word:]]+.[[:word:]]+.[[:word:]]+)")) %>%
    unnest(token_four) %>%
    select(id, title, -text, author, year, token_four)
}

#' @title unnest_N5_grams
#' @description Tokenizing the text into 5 units (Words)
#' @param tbl Input in the `tibble` of your choice made from the `document_by_ID` function
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
#' @importFrom dplyr mutate
#' @importFrom stringi stri_extract_all_regex
#' @importFrom tidyr unnest
#' @importFrom dplyr select
#' @importFrom magrittr %>%
#' @importFrom rlang enquo
#' @examples
#' N5Document = document_by_ID(id == 18)
#' unnest_N5_grams(N5Document)
unnest_N5_grams = function(data, args){
  args = rlang::enquo(args)
  data %>%
    mutate(token_five = stri_extract_all_regex(text, pattern = "\\b(?:[[:word:]]+.[[:word:]]+.[[:word:]]+.[[:word:]]+.[[:word:]]+)")) %>%
    unnest(token_five) %>%
    select(id, title, -text, author, year, token_five)
}
