#' @title Individual Novels Extraction
#' @name polish
#' @description
#' This function allows you to extract the novel of your choice based on the title you choose along with
#' any extra parameters you'd like to see with it such as the year or the author.
#' @return A dataframe with title, text, and then any column variable of your choice
#'
#' @param ... Input any title from the novels() function
#' @param vars Input any column variable of the novels() function
#' @export
#' @importFrom dplyr group_by
#' @importFrom dplyr filter
#' @importFrom dplyr select
#' @importFrom rlang .data
#' @importFrom magrittr %>%
#' @examples
#' polish(title == "Frankenstein", vars = "year")
polish = function(..., vars){
  suppressMessages(novels_tgt %>%
                     dplyr::group_by(.data$title, .data$text) %>%
                     dplyr::filter(...) %>%
                     dplyr::select({{vars}}))
}


# Note: For these to work they need to not have a COLUMN COLLISION to be considered binding and part of the
# global variables. See this link here and section about Data AND Column Collisions:
# https://rlang.r-lib.org/reference/topic-data-mask-ambiguity.html
