#' @title 18 Cleaned Novels
#' @description
#' A complete cleaned tibble of 18 Novels that is usable for Corpus Analytics
#' @importFrom tidytext unnest_tokens
#' @importFrom dplyr anti_join
#' @importFrom dplyr count
#' @importFrom magrittr %>%
#' @return A dataframe with 369111 rows and 5 variables
#' @export
#' @examples
#' library(dplyr)
#' library(tidytext)
#' novels() %>%
#'   unnest_tokens(word, text) %>%
#'   anti_join(get_stopwords("en", source = "smart")) %>%
#'   count(ID, title, word, sort = T)
novels = function(){
  A = novels_tgt
  return(A)
}
