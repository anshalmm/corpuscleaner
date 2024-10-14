#' @title 18 Cleaned Novels
#' @description
#' A complete cleaned tibble of 18 Documents that are usable for Corpus Analytics
#' @importFrom tidytext unnest_tokens
#' @importFrom dplyr anti_join
#' @importFrom dplyr count
#' @importFrom magrittr %>%
#' @format A dataframe with 369111 rows and 6 variables consisting of:
#' \describe{
#'  \item{ID}{ID of Documents}
#'  \item{title}{Title of Documents}
#'  \item{text}{Text of Documents}
#'  \item{year}{Year Published}
#'  \item{author}{Author of Documents}
#' }
#' @export
#' @examples
#' library(dplyr)
#' library(tidytext)
#' novels() %>%
#'   unnest_tokens(word, text) %>%
#'   anti_join(get_stopwords("en", source = "smart")) %>%
#'   count(title, word, sort = TRUE)
novels = function(){
  A = novels_tgt
  return(A)
}
