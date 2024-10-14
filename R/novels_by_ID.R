#' @title Novels Extraction
#' @name novels_by_ID
#' @description
#' This function allows you to extract the novel(s) of your choice based on the title you choose along with
#' any extra parameters you'd like to see with it such as the year or the author.
#' @return A dataframe with ID, text, and then any column variable of your choice
#'
#' @param ID Input any ID (i.e., 1:18) from the novels() function
#' @param vars Input any column variable of the novels() function
#' @export
#' @importFrom dplyr group_by
#' @importFrom dplyr filter
#' @importFrom dplyr select
#' @importFrom rlang .data
#' @importFrom magrittr %>%
#' @examples
#' novels_by_ID(ID = c(5, 6), vars = "year")
novels_by_ID = function(ID, vars){
  suppressMessages(novels_tgt %>%
                     dplyr::filter(.data$ID %in% {{ID}}) %>%
                     dplyr::group_by(.data$ID, .data$text) %>%
                     dplyr::select({{vars}}))
}
